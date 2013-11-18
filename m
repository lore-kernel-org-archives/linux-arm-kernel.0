From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 18 Nov 2013 11:57:11 +0100
Subject: [PATCH] RFC: framebuffer: provide generic get_fb_unmapped_area
Message-ID: <1384772231-20993-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes mmapping the simple-framebuffer device work on a no-MMU
ARM target. The code is mostly taken from
arch/blackfin/kernel/sys_bfin.c.

Note this is only tested on this no-MMU machine and I don't know enough
about framebuffers and mm to decide if this patch is sane. Also I'm
unsure about the size check because it triggers if userspace page aligns
the len parameter. (I don't know how usual it is to do, I'd say it's
wrong, but my test program (fbtest by Geert Uytterhoeven) does it.)

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/video/fbmem.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index dacaf74..70b328c 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1483,6 +1483,24 @@ __releases(&info->lock)
 	return 0;
 }
 
+#ifdef HAVE_ARCH_FB_UNMAPPED_AREA
+#define fb_get_unmapped_area get_fb_unmapped_area
+#else
+unsigned long fb_get_unmapped_area(struct file *filp, unsigned long orig_addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct fb_info * const info = filp->private_data;
+	unsigned long screen_size = info->screen_size ?: info->fix.smem_len;
+
+	if (len > screen_size) {
+		pr_info("%lu > %lu (%lu, %lu)\n", len, screen_size, info->screen_size, info->fix.smem_len);
+		return -EINVAL;
+	}
+
+	return (unsigned long)info->screen_base;
+}
+#endif
+
 static const struct file_operations fb_fops = {
 	.owner =	THIS_MODULE,
 	.read =		fb_read,
@@ -1494,9 +1512,7 @@ static const struct file_operations fb_fops = {
 	.mmap =		fb_mmap,
 	.open =		fb_open,
 	.release =	fb_release,
-#ifdef HAVE_ARCH_FB_UNMAPPED_AREA
-	.get_unmapped_area = get_fb_unmapped_area,
-#endif
+	.get_unmapped_area = fb_get_unmapped_area,
 #ifdef CONFIG_FB_DEFERRED_IO
 	.fsync =	fb_deferred_io_fsync,
 #endif
-- 
1.8.4.2
