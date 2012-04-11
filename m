From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Apr 2012 17:33:48 +0200
Subject: [PATCH 7/7] DRM: add PXA kms simple driver
In-Reply-To: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
References: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334158428-23735-8-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

This adds a sdrm driver for the PXA LCDC controller.
Currently only the base framebuffer is supported, no overlay.
There is no support for smart panels and so far only RGB565
pixel format is supported.
Tested on PHYTEC PCM-990 development board.

Also adds EOFINT and SOFINT bit definitions for the LDCMD registers.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-pxa/include/mach/regs-lcd.h |    2 +
 drivers/gpu/drm/Kconfig                   |    2 +
 drivers/gpu/drm/Makefile                  |    1 +
 drivers/gpu/drm/pxa/Kconfig               |   12 +
 drivers/gpu/drm/pxa/Makefile              |    1 +
 drivers/gpu/drm/pxa/pxa-lcdc-crtc.c       |  845 +++++++++++++++++++++++++++++
 6 files changed, 863 insertions(+)
 create mode 100644 drivers/gpu/drm/pxa/Kconfig
 create mode 100644 drivers/gpu/drm/pxa/Makefile
 create mode 100644 drivers/gpu/drm/pxa/pxa-lcdc-crtc.c

diff --git a/arch/arm/mach-pxa/include/mach/regs-lcd.h b/arch/arm/mach-pxa/include/mach/regs-lcd.h
index f82dcea..69699ce 100644
--- a/arch/arm/mach-pxa/include/mach/regs-lcd.h
+++ b/arch/arm/mach-pxa/include/mach/regs-lcd.h
@@ -158,6 +158,8 @@
 #define LCSR1_EOF(x)	(1 << ((x) + 7))  /* End of Frame Status */
 #define LCSR1_SOF(x)	(1 << ((x) - 1))  /* Start of Frame Status */
 
+#define LDCMD_EOFINT	(1 << 21)	/* instructs DMA to set the EOF status bit */
+#define LCDMD_SOFINT	(1 << 22)	/* instructs DMA to set the SOF status bit */
 #define LDCMD_PAL	(1 << 26)	/* instructs DMA to load palette buffer */
 
 /* overlay control registers */
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 4650d65..6a68e33 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -190,3 +190,5 @@ source "drivers/gpu/drm/udl/Kconfig"
 source "drivers/gpu/drm/sdrm/Kconfig"
 
 source "drivers/gpu/drm/imx/Kconfig"
+
+source "drivers/gpu/drm/pxa/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index b0c283e..0f16044 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -44,4 +44,5 @@ obj-$(CONFIG_DRM_GMA500) += gma500/
 obj-$(CONFIG_DRM_UDL) += udl/
 obj-$(CONFIG_DRM_SDRM) += sdrm/
 obj-$(CONFIG_DRM_IMX) +=imx/
+obj-$(CONFIG_DRM_PXA) +=pxa/
 obj-y			+= i2c/
diff --git a/drivers/gpu/drm/pxa/Kconfig b/drivers/gpu/drm/pxa/Kconfig
new file mode 100644
index 0000000..bb2e7e0
--- /dev/null
+++ b/drivers/gpu/drm/pxa/Kconfig
@@ -0,0 +1,12 @@
+config DRM_PXA
+	tristate "DRM Support for Marvell PXA"
+	depends on DRM && ARCH_PXA
+
+config DRM_PXA_LCDC
+	tristate "DRM Support for PXA2xx and PXA3xx"
+	depends on DRM && DRM_PXA
+	select DRM_SDRM
+	select DRM_SDRM_ENCON
+	help
+	  Choose this if you have a PXA2xx or PXA3xx processor
+	  with a display connected to the internal LCD controller.
diff --git a/drivers/gpu/drm/pxa/Makefile b/drivers/gpu/drm/pxa/Makefile
new file mode 100644
index 0000000..bb5cf1f
--- /dev/null
+++ b/drivers/gpu/drm/pxa/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_DRM_PXA_LCDC) += pxa-lcdc-crtc.o
diff --git a/drivers/gpu/drm/pxa/pxa-lcdc-crtc.c b/drivers/gpu/drm/pxa/pxa-lcdc-crtc.c
new file mode 100644
index 0000000..3d0e6e9
--- /dev/null
+++ b/drivers/gpu/drm/pxa/pxa-lcdc-crtc.c
@@ -0,0 +1,845 @@
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/sdrm.h>
+#include <drm/sdrm_encon.h>
+
+#include <mach/hardware.h>
+#include <mach/pxafb.h>
+
+/* PXA LCD DMA descriptor */
+struct pxafb_dma_descriptor {
+	unsigned int fdadr;
+	unsigned int fsadr;
+	unsigned int fidr;
+	unsigned int ldcmd;
+};
+
+enum {
+	PAL_NONE	= -1,
+	PAL_BASE	= 0,
+	PAL_OV1		= 1,
+	PAL_OV2		= 2,
+	PAL_MAX,
+};
+
+enum {
+	DMA_BASE	= 0,
+	DMA_UPPER	= 0,
+	DMA_LOWER	= 1,
+	DMA_OV1		= 1,
+	DMA_OV2_Y	= 2,
+	DMA_OV2_Cb	= 3,
+	DMA_OV2_Cr	= 4,
+	DMA_CURSOR	= 5,
+	DMA_CMD		= 6,
+	DMA_MAX,
+};
+
+/* maximum palette size - 256 entries, each 4 bytes long */
+#define PALETTE_SIZE	(256 * 4)
+#define CMD_BUFF_SIZE	(1024 * 50)
+
+/* NOTE: the palette and frame dma descriptors are doubled to allow
+ * the 2nd set for branch settings (FBRx)
+ */
+struct pxafb_dma_buff {
+	unsigned char palette[PAL_MAX * PALETTE_SIZE];
+	uint16_t cmd_buff[CMD_BUFF_SIZE];
+	struct pxafb_dma_descriptor pal_desc[PAL_MAX * 2];
+	struct pxafb_dma_descriptor dma_desc[DMA_MAX * 2];
+};
+
+struct pxa_crtc {
+	struct drm_crtc		base;
+	struct sdrm_crtc	*sdrm_crtc;
+	int			di_no;
+	int			enabled;
+
+	void __iomem		*mmio_base;
+
+	struct pxafb_dma_buff	*dma_buff;
+	size_t			dma_buff_size;
+	dma_addr_t		dma_buff_phys;
+	dma_addr_t		fdadr[DMA_MAX * 2];
+
+	unsigned long		video_mem_phys;	/* physical address of frame buffer */
+
+	u32			lccr0;
+	u32			lccr3;
+	u32			lccr4;
+	u32			cmap_inverse:1,
+				cmap_static:1,
+				unused:30;
+
+	u32			reg_lccr0;
+	u32			reg_lccr1;
+	u32			reg_lccr2;
+	u32			reg_lccr3;
+	u32			reg_lccr4;
+
+	struct completion	disable_done;
+
+	struct clk		*clk;
+	struct device		*dev;
+	int			vblank_enable;
+
+	struct drm_pending_vblank_event *page_flip_event;
+	struct drm_framebuffer	*newfb;
+
+	void (*lcd_power)(int, struct fb_var_screeninfo *);
+};
+
+#define to_pxa_crtc(x) container_of(x, struct pxa_crtc, base)
+
+static inline unsigned long
+lcd_readl(struct pxa_crtc *pxa_crtc, unsigned int off)
+{
+	return __raw_readl(pxa_crtc->mmio_base + off);
+}
+
+static inline void
+lcd_writel(struct pxa_crtc *pxa_crtc, unsigned int off, unsigned long val)
+{
+	__raw_writel(val, pxa_crtc->mmio_base + off);
+}
+
+static void pxa_crtc_load_lut(struct drm_crtc *crtc)
+{
+}
+
+const char *fourcc_to_str(u32 fourcc)
+{
+	static char buf[5];
+
+	*(u32 *)buf = fourcc;
+	buf[4] = 0;
+
+	return buf;
+}
+
+static inline void __pxa_crtc_lcd_power(struct pxa_crtc *pxa_crtc, int on)
+{
+	dev_dbg(pxa_crtc->dev, "LCD power o%s\n", on ? "n" : "ff");
+
+	if (pxa_crtc->lcd_power)
+		pxa_crtc->lcd_power(on, NULL); /* there is no fb_info */
+}
+
+static void pxa_crtc_enable_controller(struct pxa_crtc *pxa_crtc)
+{
+	dev_dbg(pxa_crtc->dev, "Enabling LCD controller\n");
+
+	/* enable LCD controller clock */
+	clk_prepare_enable(pxa_crtc->clk);
+
+	if (pxa_crtc->lccr0 & LCCR0_LCDT)
+		return;
+
+	/* Sequence from 11.7.10 */
+	lcd_writel(pxa_crtc, LCCR4, pxa_crtc->reg_lccr4);
+	lcd_writel(pxa_crtc, LCCR3, pxa_crtc->reg_lccr3);
+	lcd_writel(pxa_crtc, LCCR2, pxa_crtc->reg_lccr2);
+	lcd_writel(pxa_crtc, LCCR1, pxa_crtc->reg_lccr1);
+	lcd_writel(pxa_crtc, LCCR0, pxa_crtc->reg_lccr0 & ~LCCR0_ENB);
+
+	lcd_writel(pxa_crtc, FDADR0, pxa_crtc->fdadr[0]);
+	if (pxa_crtc->lccr0 & LCCR0_SDS)
+		lcd_writel(pxa_crtc, FDADR1, pxa_crtc->fdadr[1]);
+
+	lcd_writel(pxa_crtc, LCCR0, pxa_crtc->reg_lccr0 | LCCR0_ENB);
+}
+
+static void pxa_crtc_disable_controller(struct pxa_crtc *pxa_crtc)
+{
+	uint32_t lccr0;
+
+	dev_dbg(pxa_crtc->dev, "Disabling LCD controller\n");
+
+	/* Clear LCD Status Register */
+	lcd_writel(pxa_crtc, LCSR, 0xffffffff);
+
+	lccr0 = lcd_readl(pxa_crtc, LCCR0) & ~LCCR0_LDM;
+	lcd_writel(pxa_crtc, LCCR0, lccr0);
+	lcd_writel(pxa_crtc, LCCR0, lccr0 | LCCR0_DIS);
+
+	wait_for_completion_timeout(&pxa_crtc->disable_done, 200 * HZ / 1000);
+
+	/* disable LCD controller clock */
+	clk_disable_unprepare(pxa_crtc->clk);
+}
+
+static void pxa_crtc_decode_mach_info(struct pxa_crtc *pxa_crtc,
+				      struct pxafb_mach_info *inf)
+{
+	unsigned int lcd_conn = inf->lcd_conn;
+
+	pxa_crtc->cmap_inverse = inf->cmap_inverse;
+	pxa_crtc->cmap_static = inf->cmap_static;
+	pxa_crtc->lccr4 = inf->lccr4;
+
+	switch (lcd_conn & LCD_TYPE_MASK) {
+	case LCD_TYPE_MONO_STN:
+		pxa_crtc->lccr0 = LCCR0_CMS;
+		break;
+	case LCD_TYPE_MONO_DSTN:
+		pxa_crtc->lccr0 = LCCR0_CMS | LCCR0_SDS;
+		break;
+	case LCD_TYPE_COLOR_STN:
+		pxa_crtc->lccr0 = 0;
+		break;
+	case LCD_TYPE_COLOR_DSTN:
+		pxa_crtc->lccr0 = LCCR0_SDS;
+		break;
+	case LCD_TYPE_COLOR_TFT:
+		pxa_crtc->lccr0 = LCCR0_PAS;
+		break;
+	case LCD_TYPE_SMART_PANEL:
+		pxa_crtc->lccr0 = LCCR0_LCDT | LCCR0_PAS;
+		break;
+	default:
+		/* fall back to backward compatibility way */
+		pxa_crtc->lccr0 = inf->lccr0;
+		pxa_crtc->lccr3 = inf->lccr3;
+		return;
+	}
+
+	if (lcd_conn == LCD_MONO_STN_8BPP)
+		pxa_crtc->lccr0 |= LCCR0_DPD;
+
+	pxa_crtc->lccr0 |= (lcd_conn & LCD_ALTERNATE_MAPPING) ? LCCR0_LDDALT : 0;
+
+	pxa_crtc->lccr3 = LCCR3_Acb((inf->lcd_conn >> 10) & 0xff);
+	pxa_crtc->lccr3 |= (lcd_conn & LCD_BIAS_ACTIVE_LOW) ? LCCR3_OEP : 0;
+	pxa_crtc->lccr3 |= (lcd_conn & LCD_PCLK_EDGE_FALL)  ? LCCR3_PCP : 0;
+}
+
+/*
+ * Calculate the PCD value from the clock rate (in picoseconds).
+ * We take account of the PPCR clock setting.
+ * From PXA Developer's Manual:
+ *
+ *   PixelClock =      LCLK
+ *                -------------
+ *                2 ( PCD + 1 )
+ *
+ *   PCD =      LCLK
+ *         ------------- - 1
+ *         2(PixelClock)
+ *
+ * Where:
+ *   LCLK = LCD/Memory Clock
+ *   PCD = LCCR3[7:0]
+ *
+ * PixelClock here is in Hz while the pixclock argument given is the
+ * period in picoseconds. Hence PixelClock = 1 / ( pixclock * 10^-12 )
+ *
+ * The function get_lclk_frequency_10khz returns LCLK in units of
+ * 10khz. Calling the result of this function lclk gives us the
+ * following
+ *
+ *    PCD = (lclk * 10^4 ) * ( pixclock * 10^-12 )
+ *          -------------------------------------- - 1
+ *                          2
+ *
+ * Factoring the 10^4 and 10^-12 out gives 10^-8 == 1 / 100000000 as used below.
+ */
+static inline unsigned int get_pcd(struct pxa_crtc *pxa_crtc,
+				   unsigned int pixclock)
+{
+	unsigned long long pcd;
+
+	/* FIXME: Need to take into account Double Pixel Clock mode
+	 * (DPC) bit? or perhaps set it based on the various clock
+	 * speeds */
+	pcd = (unsigned long long)(clk_get_rate(pxa_crtc->clk) / 10000);
+	pcd *= pixclock;
+	do_div(pcd, 100000000 * 2);
+	/* no need for this, since we should subtract 1 anyway. they cancel */
+	/* pcd += 1; */ /* make up for integer math truncations */
+	return (unsigned int)pcd;
+}
+
+static int setup_frame_dma(struct pxa_crtc *pxa_crtc, int dma, int pal,
+			   unsigned long start, size_t size)
+{
+	struct pxafb_dma_descriptor *dma_desc;
+	unsigned int dma_desc_off;
+
+	if (dma < 0 || dma >= DMA_MAX * 2)
+		return -EINVAL;
+
+	dma_desc = &pxa_crtc->dma_buff->dma_desc[dma];
+	dma_desc_off = offsetof(struct pxafb_dma_buff, dma_desc[dma]);
+
+	dma_desc->fsadr = start;
+	dma_desc->fidr  = 0;
+	/* enable EOFINT unconditionally, but mask interrupt with LCCR0_EFM */
+	dma_desc->ldcmd = size | LDCMD_EOFINT;
+
+	if (pal < 0 || pal >= PAL_MAX * 2) {
+		dma_desc->fdadr = pxa_crtc->dma_buff_phys + dma_desc_off;
+		pxa_crtc->fdadr[dma] = pxa_crtc->dma_buff_phys + dma_desc_off;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void setup_base_frame(struct pxa_crtc *pxa_crtc, int branch)
+{
+	struct drm_framebuffer *fb = pxa_crtc->base.fb;
+	struct drm_display_mode *mode = &pxa_crtc->base.mode;
+	int nbytes, dma, pal, bpp = fb->bits_per_pixel;
+	unsigned long offset;
+
+	dma = DMA_BASE + (branch ? DMA_MAX : 0);
+	pal = (bpp >= 16) ? PAL_NONE : PAL_BASE + (branch ? PAL_MAX : 0);
+
+	nbytes = mode->crtc_hdisplay * mode->crtc_vdisplay * bpp / 8;
+	offset = pxa_crtc->video_mem_phys; /* no yoffset support yet */
+
+	if (pxa_crtc->lccr0 & LCCR0_SDS) {
+		nbytes = nbytes / 2;
+		setup_frame_dma(pxa_crtc, dma + 1, PAL_NONE,
+				offset + nbytes, nbytes);
+	}
+
+	setup_frame_dma(pxa_crtc, dma, pal, offset, nbytes);
+}
+
+static void setup_parallel_timing(struct pxa_crtc *pxa_crtc,
+				  struct drm_display_mode *mode)
+{
+	unsigned int lines_per_panel, pcd = get_pcd(pxa_crtc, mode->clock);
+	int hsync_len = mode->hsync_end - mode->hsync_start;
+	int right_margin = mode->hsync_start - mode->hdisplay;
+	int left_margin = mode->htotal - mode->hsync_end;
+	int vsync_len = mode->vsync_end - mode->vsync_start;
+	int upper_margin = mode->vtotal - mode->vsync_end;
+	int lower_margin = mode->vsync_start - mode->vdisplay;
+
+	pxa_crtc->reg_lccr1 =
+		LCCR1_DisWdth(mode->hdisplay) +
+		LCCR1_HorSnchWdth(hsync_len) +
+		LCCR1_BegLnDel(left_margin) +
+		LCCR1_EndLnDel(right_margin);
+
+	/*
+	 * If we have a dual scan LCD, we need to halve
+	 * the YRES parameter.
+	 */
+	lines_per_panel = mode->vdisplay;
+	if ((pxa_crtc->lccr0 & LCCR0_SDS) == LCCR0_Dual)
+		lines_per_panel /= 2;
+
+	pxa_crtc->reg_lccr2 =
+		LCCR2_DisHght(lines_per_panel) +
+		LCCR2_VrtSnchWdth(vsync_len) +
+		LCCR2_BegFrmDel(upper_margin) +
+		LCCR2_EndFrmDel(lower_margin);
+
+	pxa_crtc->reg_lccr3 = pxa_crtc->lccr3 |
+		(mode->flags & DRM_MODE_FLAG_PHSYNC ?
+		 LCCR3_HorSnchH : LCCR3_HorSnchL) |
+		(mode->flags & DRM_MODE_FLAG_PVSYNC ?
+		 LCCR3_VrtSnchH : LCCR3_VrtSnchL);
+
+	if (pcd)
+		pxa_crtc->reg_lccr3 |= LCCR3_PixClkDiv(pcd);
+}
+
+/* calculate 4-bit BPP value for LCCR3 and OVLxC1 */
+static int pixel_format_to_bpp(struct drm_framebuffer *fb)
+{
+	int bpp = -EINVAL;
+
+	switch (fb->pixel_format) {
+	case DRM_FORMAT_C8:
+		bpp = 3;
+		break;
+	case DRM_FORMAT_XRGB1555:
+	case DRM_FORMAT_ARGB1555:
+	case DRM_FORMAT_RGB565:
+		bpp = 4;
+		break;
+	case DRM_FORMAT_RGB888:
+		bpp = 9;
+		break;
+	}
+	return bpp;
+}
+
+/*
+ *  pxa_crtc_fb_to_lccr3():
+ *    Convert a bits per pixel value to the correct bit pattern for LCCR3
+ *
+ *  NOTE: for PXA27x with overlays support, the LCCR3_PDFOR_x bits have an
+ *  implication of the acutal use of transparency bit,  which we handle it
+ *  here separatedly. See PXA27x Developer's Manual, Section <<7.4.6 Pixel
+ *  Formats>> for the valid combination of PDFOR, PAL_FOR for various BPP.
+ *
+ *  Transparency for palette pixel formats is not supported at the moment.
+ */
+static uint32_t pxa_crtc_fb_to_lccr3(struct drm_framebuffer *fb)
+{
+	int bpp = pixel_format_to_bpp(fb);
+	uint32_t lccr3;
+	int transparency;
+
+	if (bpp < 0)
+		return 0;
+
+	lccr3 = LCCR3_BPP(bpp);
+
+	switch (fb->pixel_format) {
+	case DRM_FORMAT_ARGB1555:
+	case DRM_FORMAT_XRGB1555:
+		lccr3 |= LCCR3_PDFOR_3;
+		break;
+	case DRM_FORMAT_RGB565:
+		break;
+	case DRM_FORMAT_ARGB8888;
+	case DRM_FORMAT_XRGB8888;
+		lccr3 |= LCCR3_PDFOR_0;
+		break;
+	case DRM_FORMAT_RGB888;
+		lccr3 |= LCCR3_PDFOR_3;
+		break;
+	}
+	return lccr3;
+}
+
+static int pxa_drm_crtc_set(struct drm_crtc *crtc,
+		struct drm_display_mode *mode)
+{
+	struct pxa_crtc *pxa_crtc = to_pxa_crtc(crtc);
+	struct drm_framebuffer *fb = crtc->fb;
+	unsigned long flags;
+
+
+	/* Pixel clock */
+
+	/* Pixel format */
+	switch (fb->pixel_format) {
+	case DRM_FORMAT_RGB565:
+		pr_info("depth: %d, bpp: %d\n", fb->depth, fb->bits_per_pixel);
+		break;
+	default:
+		dev_err(pxa_crtc->dev, "unsupported pixel format %s\n",
+				fourcc_to_str(fb->pixel_format));
+		return -EINVAL;
+	}
+
+	/* Update shadow copy atomically */
+	local_irq_save(flags);
+
+	setup_parallel_timing(pxa_crtc, mode);
+
+	setup_base_frame(pxa_crtc, 0);
+
+	pxa_crtc->reg_lccr0 = pxa_crtc->lccr0 |
+		(LCCR0_LDM | LCCR0_SFM | LCCR0_IUM | LCCR0_EFM |
+		 LCCR0_QDM | LCCR0_BM  | LCCR0_OUM);
+
+	pxa_crtc->reg_lccr3 |= pxa_crtc_fb_to_lccr3(fb);
+
+	pxa_crtc->reg_lccr4 = lcd_readl(pxa_crtc, LCCR4) & ~LCCR4_PAL_FOR_MASK;
+	pxa_crtc->reg_lccr4 |= (pxa_crtc->lccr4 & LCCR4_PAL_FOR_MASK);
+	local_irq_restore(flags);
+
+	/*
+	 * Only update the registers if the controller is enabled
+	 * and something has changed.
+	 */
+	if ((lcd_readl(pxa_crtc, LCCR0) != pxa_crtc->reg_lccr0) ||
+	    (lcd_readl(pxa_crtc, LCCR1) != pxa_crtc->reg_lccr1) ||
+	    (lcd_readl(pxa_crtc, LCCR2) != pxa_crtc->reg_lccr2) ||
+	    (lcd_readl(pxa_crtc, LCCR3) != pxa_crtc->reg_lccr3) ||
+	    (lcd_readl(pxa_crtc, LCCR4) != pxa_crtc->reg_lccr4) ||
+	    (lcd_readl(pxa_crtc, FDADR0) != pxa_crtc->fdadr[0]) ||
+	    ((pxa_crtc->lccr0 & LCCR0_SDS) &&
+	    (lcd_readl(pxa_crtc, FDADR1) != pxa_crtc->fdadr[1]))) {
+		if (pxa_crtc->enabled) {
+			pxa_crtc_disable_controller(pxa_crtc);
+			pxa_crtc_enable_controller(pxa_crtc);
+		}
+	}
+
+	return 0;
+}
+
+static int pxa_drm_set_base(struct drm_crtc *crtc, int x, int y)
+{
+	struct pxa_crtc *pxa_crtc = to_pxa_crtc(crtc);
+	struct sdrm_buf_entry *entry;
+	struct drm_framebuffer *fb = crtc->fb;
+	unsigned long phys;
+	int dma = DMA_MAX + DMA_BASE;
+
+	entry = sdrm_fb_get_buf(fb);
+	if (!entry)
+		return -EFAULT;
+
+	phys = entry->paddr;
+	phys += x * (fb->bits_per_pixel >> 3);
+	phys += y * fb->pitches[0];
+
+	dev_dbg(pxa_crtc->dev, "%s: phys: 0x%lx\n", __func__, phys);
+	dev_dbg(pxa_crtc->dev, "%s: xy: %dx%d\n", __func__, x, y);
+
+	pxa_crtc->video_mem_phys = entry->paddr;
+
+	setup_base_frame(pxa_crtc, 1);
+
+	if (pxa_crtc->lccr0 & LCCR0_SDS)
+		lcd_writel(pxa_crtc, FBR1, pxa_crtc->fdadr[dma + 1] | 0x1);
+
+	lcd_writel(pxa_crtc, FBR0, pxa_crtc->fdadr[dma] | 0x1);
+
+	return 0;
+}
+
+static int pxa_crtc_mode_set(struct drm_crtc *crtc,
+			       struct drm_display_mode *mode,
+			       struct drm_display_mode *adjusted_mode,
+			       int x, int y,
+			       struct drm_framebuffer *old_fb)
+{
+	struct pxa_crtc *pxa_crtc = to_pxa_crtc(crtc);
+
+	pxa_drm_set_base(crtc, x, y);
+
+	return pxa_drm_crtc_set(crtc, mode);
+}
+
+static void pxa_crtc_enable(struct pxa_crtc *pxa_crtc)
+{
+	if (!pxa_crtc->enabled) {
+		__pxa_crtc_lcd_power(pxa_crtc, 1);
+		pxa_crtc_enable_controller(pxa_crtc);
+	}
+	pxa_crtc->enabled = 1;
+}
+
+static void pxa_crtc_disable(struct pxa_crtc *pxa_crtc)
+{
+	if (pxa_crtc->enabled) {
+		pxa_crtc_disable_controller(pxa_crtc);
+		__pxa_crtc_lcd_power(pxa_crtc, 0);
+	}
+	pxa_crtc->enabled = 0;
+}
+
+static void pxa_crtc_dpms(struct drm_crtc *crtc, int mode)
+{
+	struct pxa_crtc *pxa_crtc = to_pxa_crtc(crtc);
+
+	dev_dbg(pxa_crtc->dev, "%s mode: %d\n", __func__, mode);
+
+	switch (mode) {
+	case DRM_MODE_DPMS_ON:
+		pxa_crtc_enable(pxa_crtc);
+		break;
+	default:
+		pxa_crtc_disable(pxa_crtc);
+		break;
+	}
+}
+
+static bool pxa_crtc_mode_fixup(struct drm_crtc *crtc,
+				  struct drm_display_mode *mode,
+				  struct drm_display_mode *adjusted_mode)
+{
+	return true;
+}
+
+static void pxa_crtc_prepare(struct drm_crtc *crtc)
+{
+	struct pxa_crtc *pxa_crtc = to_pxa_crtc(crtc);
+
+	pxa_crtc_disable(pxa_crtc);
+}
+
+static void pxa_crtc_commit(struct drm_crtc *crtc)
+{
+	struct pxa_crtc *pxa_crtc = to_pxa_crtc(crtc);
+
+	pxa_crtc_enable(pxa_crtc);
+}
+
+static struct drm_crtc_helper_funcs pxa_helper_funcs = {
+	.dpms = pxa_crtc_dpms,
+	.prepare = pxa_crtc_prepare,
+	.commit = pxa_crtc_commit,
+	.mode_fixup = pxa_crtc_mode_fixup,
+	.mode_set = pxa_crtc_mode_set,
+	.load_lut = pxa_crtc_load_lut,
+};
+
+static void sdrm_handle_pageflip(struct pxa_crtc *pxa_crtc)
+{
+	struct drm_pending_vblank_event *e;
+	struct timeval now;
+	unsigned long flags;
+	struct drm_device *drm = pxa_crtc->base.dev;
+
+	spin_lock_irqsave(&drm->event_lock, flags);
+
+	e = pxa_crtc->page_flip_event;
+
+	if (!e) {
+		spin_unlock_irqrestore(&drm->event_lock, flags);
+		return;
+	}
+
+	do_gettimeofday(&now);
+	e->event.sequence = 0;
+	e->event.tv_sec = now.tv_sec;
+	e->event.tv_usec = now.tv_usec;
+	pxa_crtc->page_flip_event = NULL;
+
+	list_add_tail(&e->base.link, &e->base.file_priv->event_list);
+
+	wake_up_interruptible(&e->base.file_priv->event_wait);
+
+	spin_unlock_irqrestore(&drm->event_lock, flags);
+}
+
+static int pxa_crtc_enable_vblank(struct drm_crtc *crtc)
+{
+	struct pxa_crtc *pxa_crtc = to_pxa_crtc(crtc);
+	uint32_t lccr0;
+
+	pxa_crtc->reg_lccr0 &= ~LCCR0_EFM;
+
+	lccr0 = lcd_readl(pxa_crtc, LCCR0);
+	lccr0 &= ~LCCR0_EFM;
+	lcd_writel(pxa_crtc, LCCR0, lccr0);
+
+	return 0;
+}
+
+static void pxa_crtc_disable_vblank(struct drm_crtc *crtc)
+{
+	struct pxa_crtc *pxa_crtc = to_pxa_crtc(crtc);
+	uint32_t lccr0;
+
+	pxa_crtc->reg_lccr0 &= ~LCCR0_EFM;
+
+	lccr0 = lcd_readl(pxa_crtc, LCCR0);
+	lccr0 |= LCCR0_EFM;
+	lcd_writel(pxa_crtc, LCCR0, lccr0);
+}
+
+/*
+ * Handle LCDC interrupts.
+ */
+static irqreturn_t pxa_irq_handler(int irq, void *dev_id)
+{
+	struct pxa_crtc *pxa_crtc = dev_id;
+	struct drm_device *drm = pxa_crtc->base.dev;
+	unsigned int lccr0, lcsr;
+
+	lcsr = lcd_readl(pxa_crtc, LCSR);
+	if (lcsr & LCSR_LDD) {
+		lccr0 = lcd_readl(pxa_crtc, LCCR0);
+		lcd_writel(pxa_crtc, LCCR0, lccr0 | LCCR0_LDM);
+		complete(&pxa_crtc->disable_done);
+	}
+
+	if (lcsr & LCSR_BER)
+		dev_err(pxa_crtc->dev, "bus error caused by dma channel %d\n",
+			(lcsr >> 28) & 0x7);
+
+	if (lcsr & LCSR_EOF)
+		sdrm_handle_pageflip(pxa_crtc);
+
+	/* Acknowledge interrupt */
+	lcd_writel(pxa_crtc, LCSR, lcsr);
+
+	drm_handle_vblank(drm, 0);
+
+	if (pxa_crtc->newfb) {
+		pxa_crtc->base.fb = pxa_crtc->newfb;
+		pxa_crtc->newfb = NULL;
+		pxa_drm_set_base(&pxa_crtc->base, 0, 0);
+		sdrm_handle_pageflip(pxa_crtc);
+		sdrm_crtc_vblank_put(pxa_crtc->sdrm_crtc);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int pxa_page_flip(struct drm_crtc *crtc,
+			 struct drm_framebuffer *fb,
+			 struct drm_pending_vblank_event *event)
+{
+	struct pxa_crtc *pxa_crtc = to_pxa_crtc(crtc);
+
+	if (pxa_crtc->newfb)
+		return -EBUSY;
+
+	pxa_crtc->newfb = fb;
+	pxa_crtc->page_flip_event = event;
+	sdrm_crtc_vblank_get(pxa_crtc->sdrm_crtc);
+
+	return 0;
+}
+
+static const struct drm_crtc_funcs pxa_crtc_funcs = {
+	.page_flip = pxa_page_flip,
+};
+
+static const struct sdrm_crtc_helper_funcs pxa_sdrm_helper = {
+	.enable_vblank = pxa_crtc_enable_vblank,
+	.disable_vblank = pxa_crtc_disable_vblank,
+};
+
+#define DRIVER_NAME "pxa-lcdc-crtc"
+
+static int __devinit pxa_crtc_probe(struct platform_device *pdev)
+{
+	struct pxa_crtc *pxa_crtc;
+	struct resource *res;
+	int ret, irq;
+	struct pxafb_mach_info *pdata = pdev->dev.platform_data;
+
+	dev_dbg(&pdev->dev, "pxa_crtc_probe\n");
+
+	if (!pdata)
+		return -EINVAL;
+
+	dev_info(&pdev->dev, "got a %dx%dx%d LCD\n",
+			pdata->modes->xres,
+			pdata->modes->yres,
+			pdata->modes->bpp);
+	if (pdata->modes->xres == 0 ||
+	    pdata->modes->yres == 0 ||
+	    pdata->modes->bpp == 0) {
+		dev_err(&pdev->dev, "Invalid resolution or bit depth\n");
+		return -EINVAL;
+	}
+
+	pxa_crtc = devm_kzalloc(&pdev->dev, sizeof(*pxa_crtc), GFP_KERNEL);
+	if (!pxa_crtc) {
+		dev_dbg(&pdev->dev, "failed to allocate crtc\n");
+		return -ENOMEM;
+	}
+
+	pxa_crtc->dev = &pdev->dev;
+
+	init_completion(&pxa_crtc->disable_done);
+
+	pxa_crtc_decode_mach_info(pxa_crtc, pdata);
+
+	pxa_crtc->lcd_power = pdata->pxafb_lcd_power;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	res = devm_request_mem_region(&pdev->dev, res->start,
+			resource_size(res), DRIVER_NAME);
+	if (!res)
+		return -EBUSY;
+
+	pxa_crtc->mmio_base = devm_ioremap(&pdev->dev, res->start,
+				resource_size(res));
+	if (!pxa_crtc->mmio_base) {
+		dev_err(&pdev->dev, "Cannot map frame buffer registers\n");
+		return -EBUSY;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	ret = devm_request_irq(&pdev->dev, irq, pxa_irq_handler, 0, "pxa_drm",
+			pxa_crtc);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "irq request failed with %d.\n", ret);
+		return ret;
+	}
+
+	pxa_crtc->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(pxa_crtc->clk)) {
+		ret = PTR_ERR(pxa_crtc->clk);
+		dev_err(&pdev->dev, "unable to get clock: %d\n", ret);
+		return ret;
+	}
+
+	pxa_crtc->sdrm_crtc = sdrm_add_crtc(dev_name(&pdev->dev),
+			&pxa_crtc->base, &pxa_crtc_funcs, &pxa_helper_funcs,
+			&pxa_sdrm_helper);
+	if (!pxa_crtc->sdrm_crtc) {
+		dev_err(&pdev->dev, "failed to add crtc\n");
+		ret = -EINVAL;
+		goto err_clk;
+	}
+
+	platform_set_drvdata(pdev, pxa_crtc);
+
+	/* there are no devm helpers for dma_alloc_coherent */
+	pxa_crtc->dma_buff_size = PAGE_ALIGN(sizeof(struct pxafb_dma_buff));
+	pxa_crtc->dma_buff = dma_alloc_coherent(pxa_crtc->dev,
+				pxa_crtc->dma_buff_size,
+				&pxa_crtc->dma_buff_phys, GFP_KERNEL);
+	if (pxa_crtc->dma_buff == NULL) {
+		dev_err(&pdev->dev, "Failed to allocate memory for DMA\n");
+		ret = -ENOMEM;
+		goto err_crtc;
+	}
+
+	ret = sdrm_init_drm(dev_name(&pdev->dev), pdev, 16);
+	if (ret) {
+		dev_err(&pdev->dev, "init drm failed with %d\n", ret);
+		goto err_free_dma;
+	}
+
+	return 0;
+
+err_free_dma:
+	dma_free_coherent(&pdev->dev, pxa_crtc->dma_buff_size,
+			pxa_crtc->dma_buff, pxa_crtc->dma_buff_phys);
+err_crtc:
+	sdrm_remove_crtc(pxa_crtc->sdrm_crtc);
+err_clk:
+	clk_put(pxa_crtc->clk);
+
+	return ret;
+}
+
+static int __devexit pxa_crtc_remove(struct platform_device *pdev)
+{
+	struct pxa_crtc *pxa_crtc = platform_get_drvdata(pdev);
+
+	sdrm_exit_drm(dev_name(&pdev->dev));
+
+	clk_disable_unprepare(pxa_crtc->clk);
+	clk_put(pxa_crtc->clk);
+
+	sdrm_remove_crtc(pxa_crtc->sdrm_crtc);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver pxa_crtc_driver = {
+	.remove		= __devexit_p(pxa_crtc_remove),
+	.probe		= pxa_crtc_probe,
+	.driver		= {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	},
+};
+
+module_platform_driver(pxa_crtc_driver);
+
+MODULE_DESCRIPTION("PXA LCDC framebuffer driver");
+MODULE_AUTHOR("Philipp Zabel, Pengutronix");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5
