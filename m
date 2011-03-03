From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  3 Mar 2011 14:30:58 +0100
Subject: [PATCH 4/6] video i.MX: remove mx1 compile time dependencies
In-Reply-To: <1299159060-9289-1-git-send-email-s.hauer@pengutronix.de>
References: <1299159060-9289-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1299159060-9289-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

remove usage of CONFIG_ARCH_MX1. It's mostly unused anyway, replace
it with cpu_is_mx1() where necessary. Also, depend on
IMX_HAVE_PLATFORM_IMX_FB instead of the architectures directly.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/video/Kconfig |    2 +-
 drivers/video/imxfb.c |   28 ++++++----------------------
 2 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6bafb51b..59c1e97 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -422,7 +422,7 @@ config FB_SA1100
 
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
1.7.2.3
