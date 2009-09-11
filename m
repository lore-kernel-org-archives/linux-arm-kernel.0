From: p.osciak@samsung.com (Pawel Osciak)
Date: Fri, 11 Sep 2009 20:04:52 +0200
Subject: [PATCH 2/7] [ARM] s3c-fb: Added window source selection.
Message-ID: <E4D3F24EA6C9E54F817833EAE0D912AC0771185D59@bssrvexch01.BS.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is now possible to switch between local bus and DMA as the source
for a window. Local source mode can handle RGB and YCbCr formats.

Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Pawel Osciak <p.osciak@samsung.com>

---
 arch/arm/plat-s3c/include/plat/regs-fb.h |    1 +
 arch/arm/plat-s3c/include/plat/s3c-fb.h  |    9 ++++++
 drivers/video/s3c-fb.c                   |   40 ++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c/include/plat/regs-fb.h b/arch/arm/plat-s3c/include/plat/regs-fb.h
index 8d3071d..4c024ca 100644
--- a/arch/arm/plat-s3c/include/plat/regs-fb.h
+++ b/arch/arm/plat-s3c/include/plat/regs-fb.h
@@ -170,6 +170,7 @@
 /* WINCONx */
 
 
+#define WINCONx(_x)				(0x20 + ((_x) * 4))
 #define WINCONx_BITSWP				(1 << 18)
 #define WINCONx_BYTSWP				(1 << 17)
 #define WINCONx_HAWSWP				(1 << 16)
diff --git a/arch/arm/plat-s3c/include/plat/s3c-fb.h b/arch/arm/plat-s3c/include/plat/s3c-fb.h
index 0aebc40..b08f9ad 100644
--- a/arch/arm/plat-s3c/include/plat/s3c-fb.h
+++ b/arch/arm/plat-s3c/include/plat/s3c-fb.h
@@ -26,6 +26,12 @@ typedef enum s3c_fb_color_key_mode {
 	S3CFB_COLORKEY_MODE_FG = 1
 } s3c_fb_color_key_mode_t;
 
+typedef enum s3c_fb_source {
+	S3CFB_SOURCE_DMA = 0,
+	S3CFB_SOURCE_LOCAL_RGB = 1,
+	S3CFB_SOURCE_LOCAL_YCbCr = 2
+} s3c_fb_source_t;
+
 #ifndef FBIO_WAITFORVSYNC
 #define FBIO_WAITFORVSYNC _IOW('F', 0x20, __u32)
 #endif
@@ -41,5 +47,8 @@ typedef enum s3c_fb_color_key_mode {
 /* param: 1 - on, 0 - off */
 #define S3CFB_IOCTL_COLOR_KEY_ENABLE	_IO(S3CFB_IOCTL_MAGIC, 3)
 
+
+/* Param: s3c_fb_source */
+#define S3CFB_IOCTL_SET_SOURCE		_IO(S3CFB_IOCTL_MAGIC, 5)
 #endif /* __LINUX_S3C_FB_H__ */
 
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 2de3151..28622c0 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -960,6 +960,43 @@ static int s3c_fb_set_color_key_mode(struct s3c_fb_win *win,
 	return 0;
 }
 
+static int s3c_fb_set_source(struct s3c_fb_win *win, s3c_fb_source_t source)
+{
+	struct s3c_fb *sfb = win->parent;
+	int wincon_reg, new_val;
+
+	if (win->index > 2) {
+		dev_err(sfb->dev, "Source change not supported for window %d\n",
+			win->index);
+		return -EINVAL;
+	}
+
+	wincon_reg = readl(sfb->regs + WINCONx(win->index));
+	new_val = wincon_reg;
+
+	switch (source) {
+	case S3CFB_SOURCE_DMA:
+		new_val &= ~(WINCONx_ENLOCAL | WINCONx_YCbCr);
+		break;
+	case S3CFB_SOURCE_LOCAL_RGB:
+		new_val &= ~WINCONx_YCbCr;
+		new_val |= WINCONx_ENLOCAL;
+		break;
+	case S3CFB_SOURCE_LOCAL_YCbCr:
+		new_val |= WINCONx_YCbCr | WINCONx_ENLOCAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* The window has to be disabled during source switch */
+	writel(wincon_reg & ~WINCONx_ENWIN, sfb->regs + WINCONx(win->index));
+	new_val |= WINCONx_ENWIN;
+	writel(new_val, sfb->regs + WINCONx(win->index));
+
+	return 0;
+}
+
 static int s3c_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			unsigned long arg)
 {
@@ -999,6 +1036,9 @@ static int s3c_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	case S3CFB_IOCTL_COLOR_KEY_ENABLE:
 		return s3c_fb_color_key_enable(win, arg);
 
+
+	case S3CFB_IOCTL_SET_SOURCE:
+		return s3c_fb_set_source(win, arg);
 	default:
 		return -ENOTTY;
 	}
-- 
1.6.4.2.253.g0b1fac
