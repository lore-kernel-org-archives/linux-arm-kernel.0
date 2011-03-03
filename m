From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 3 Mar 2011 15:12:44 +0100
Subject: [PATCH 4/6] video i.MX: remove mx1 compile time dependencies
In-Reply-To: <20110303134858.GH20423@jasper.tkos.co.il>
References: <1299159060-9289-1-git-send-email-s.hauer@pengutronix.de>
	<1299159060-9289-5-git-send-email-s.hauer@pengutronix.de>
	<20110303134858.GH20423@jasper.tkos.co.il>
Message-ID: <20110303141244.GQ29521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2011 at 03:48:58PM +0200, Baruch Siach wrote:
> Hi Sascha,
> 
> On Thu, Mar 03, 2011 at 02:30:58PM +0100, Sascha Hauer wrote:
> > remove usage of CONFIG_ARCH_MX1. It's mostly unused anyway, replace
> > it with cpu_is_mx1() where necessary. Also, depend on
> > IMX_HAVE_PLATFORM_IMX_FB instead of the architectures directly.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/video/Kconfig |    2 +-
> >  drivers/video/imxfb.c |   28 ++++++----------------------
> >  2 files changed, 7 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index 6bafb51b..59c1e97 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -422,7 +422,7 @@ config FB_SA1100
> >  
> >  config FB_IMX
> >  	tristate "Freescale i.MX LCD support"
> > -	depends on FB && (HAVE_FB_IMX || ARCH_MX1 || ARCH_MX2)
> > +	depends on FB && IMX_HAVE_PLATFORM_IMX_FB
> 
> The HAVE_FB_IMX symbol becomes redundant, then. We should remove it entirely 
> from drivers/video/Kconfig and arch/arm/plat-mxc/devices/Kconfig.

ok. Updated to the following:

8<-------------------------
[PATCH 4/6] video i.MX: remove mx1 compile time dependencies

remove usage of CONFIG_ARCH_MX1. It's mostly unused anyway, replace
it with cpu_is_mx1() where necessary. Also, depend on
IMX_HAVE_PLATFORM_IMX_FB instead of the architectures directly.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/devices/Kconfig |    1 -
 drivers/video/Kconfig             |    5 +----
 drivers/video/imxfb.c             |   28 ++++++----------------------
 3 files changed, 7 insertions(+), 27 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index b9ab1d5..e4dcf49 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -24,7 +24,6 @@ config IMX_HAVE_PLATFORM_IMXDI_RTC
 
 config IMX_HAVE_PLATFORM_IMX_FB
 	bool
-	select HAVE_FB_IMX
 
 config IMX_HAVE_PLATFORM_IMX_I2C
 	bool
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6bafb51b..f372416 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -8,9 +8,6 @@ menu "Graphics support"
 config HAVE_FB_ATMEL
 	bool
 
-config HAVE_FB_IMX
-	bool
-
 config SH_MIPI_DSI
 	tristate
 	depends on (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
@@ -422,7 +419,7 @@ config FB_SA1100
 
 config FB_IMX
 	tristate "Freescale i.MX LCD support"
-	depends on FB && (HAVE_FB_IMX || ARCH_MX1 || ARCH_MX2)
+	depends on FB && IMX_HAVE_PLATFORM_IMX_FB
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 69bd4a5..0085658 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -65,12 +65,6 @@
 #define CPOS_OP		(1<<28)
 #define CPOS_CXP(x)	(((x) & 3ff) << 16)
 
-#ifdef CONFIG_ARCH_MX1
-#define CPOS_CYP(y)	((y) & 0x1ff)
-#else
-#define CPOS_CYP(y)	((y) & 0x3ff)
-#endif
-
 #define LCDC_LCWHB	0x10
 #define LCWHB_BK_EN	(1<<31)
 #define LCWHB_CW(w)	(((w) & 0x1f) << 24)
@@ -79,16 +73,6 @@
 
 #define LCDC_LCHCC	0x14
 
-#ifdef CONFIG_ARCH_MX1
-#define LCHCC_CUR_COL_R(r) (((r) & 0x1f) << 11)
-#define LCHCC_CUR_COL_G(g) (((g) & 0x3f) << 5)
-#define LCHCC_CUR_COL_B(b) ((b) & 0x1f)
-#else
-#define LCHCC_CUR_COL_R(r) (((r) & 0x3f) << 12)
-#define LCHCC_CUR_COL_G(g) (((g) & 0x3f) << 6)
-#define LCHCC_CUR_COL_B(b) ((b) & 0x3f)
-#endif
-
 #define LCDC_PCR	0x18
 
 #define LCDC_HCR	0x1C
@@ -115,11 +99,7 @@
 
 #define LCDC_RMCR	0x34
 
-#ifdef CONFIG_ARCH_MX1
-#define RMCR_LCDC_EN	(1<<1)
-#else
-#define RMCR_LCDC_EN	0
-#endif
+#define RMCR_LCDC_EN_MX1	(1<<1)
 
 #define RMCR_SELF_REF	(1<<0)
 
@@ -535,7 +515,11 @@ static void imxfb_enable_controller(struct imxfb_info *fbi)
 	writel(readl(fbi->regs + LCDC_CPOS) & ~(CPOS_CC0 | CPOS_CC1),
 		fbi->regs + LCDC_CPOS);
 
-	writel(RMCR_LCDC_EN, fbi->regs + LCDC_RMCR);
+	/*
+	 * RMCR_LCDC_EN_MX1 is present on i.MX1 only, but doesn't hurt
+	 * on other SoCs
+	 */
+	writel(RMCR_LCDC_EN_MX1, fbi->regs + LCDC_RMCR);
 
 	clk_enable(fbi->clk);
 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
