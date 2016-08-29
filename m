From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Aug 2016 11:35:16 +0200
Subject: [PATCH v2] ARM: integrator: move CP CLCD display to DTS
Message-ID: <1472463316-9556-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Integrator/CP CLCD VGA display can now be registered
fully from the device tree. Delete the board file code and
add the display definition to the DTS.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Actually include the hunk deleting the boardfile code as well.
---
 arch/arm/boot/dts/integratorcp.dts       | 37 ++++++++++++++++++++-
 arch/arm/mach-integrator/integrator_cp.c | 57 --------------------------------
 2 files changed, 36 insertions(+), 58 deletions(-)

diff --git a/arch/arm/boot/dts/integratorcp.dts b/arch/arm/boot/dts/integratorcp.dts
index 371173ec63fd..915203b4083f 100644
--- a/arch/arm/boot/dts/integratorcp.dts
+++ b/arch/arm/boot/dts/integratorcp.dts
@@ -249,7 +249,42 @@
 			reg = <0xC0000000 0x1000>;
 			interrupts = <22>;
 			clocks = <&auxosc>, <&pclk>;
-			clock-names = "clcd", "apb_pclk";
+			clock-names = "clcdclk", "apb_pclk";
+
+			port {
+				/*
+				 * The VGA connected is implemented with a
+				 * THS8134A triple DAC that can be run in 24bit
+				 * or 16bit RGB mode.
+				 */
+				clcd_pads: endpoint {
+					remote-endpoint = <&clcd_panel>;
+					arm,pl11x,tft-r0g0b0-pads = <1 7 13>;
+				};
+			};
+
+			panel {
+				compatible = "panel-dpi";
+
+				port {
+					clcd_panel: endpoint {
+						remote-endpoint = <&clcd_pads>;
+					};
+				};
+
+				/* Standard 640x480 VGA timings */
+				panel-timing {
+					clock-frequency = <25175000>;
+					hactive = <640>;
+					hback-porch = <48>;
+					hfront-porch = <16>;
+					hsync-len = <96>;
+					vactive = <480>;
+					vback-porch = <33>;
+					vfront-porch = <10>;
+					vsync-len = <2>;
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 825298349bf5..a9e3cb511fcb 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -17,8 +17,6 @@
 #include <linux/device.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/kmi.h>
-#include <linux/amba/clcd.h>
-#include <linux/platform_data/video-clcd-versatile.h>
 #include <linux/amba/mmci.h>
 #include <linux/io.h>
 #include <linux/irqchip.h>
@@ -42,8 +40,6 @@
 /* Base address to the CP controller */
 static void __iomem *intcp_con_base;
 
-#define INTCP_PA_CLCD_BASE		0xc0000000
-
 /*
  * Logical      Physical
  * f1000000	10000000	Core module registers
@@ -121,57 +117,6 @@ static struct mmci_platform_data mmc_data = {
 	.gpio_cd	= -1,
 };
 
-/*
- * CLCD support
- */
-/*
- * Ensure VGA is selected.
- */
-static void cp_clcd_enable(struct clcd_fb *fb)
-{
-	struct fb_var_screeninfo *var = &fb->fb.var;
-	u32 val = CM_CTRL_STATIC1 | CM_CTRL_STATIC2
-			| CM_CTRL_LCDEN0 | CM_CTRL_LCDEN1;
-
-	if (var->bits_per_pixel <= 8 ||
-	    (var->bits_per_pixel == 16 && var->green.length == 5))
-		/* Pseudocolor, RGB555, BGR555 */
-		val |= CM_CTRL_LCDMUXSEL_VGA555_TFT555;
-	else if (fb->fb.var.bits_per_pixel <= 16)
-		/* truecolor RGB565 */
-		val |= CM_CTRL_LCDMUXSEL_VGA565_TFT555;
-	else
-		val = 0; /* no idea for this, don't trust the docs */
-
-	cm_control(CM_CTRL_LCDMUXSEL_MASK|
-		   CM_CTRL_LCDEN0|
-		   CM_CTRL_LCDEN1|
-		   CM_CTRL_STATIC1|
-		   CM_CTRL_STATIC2|
-		   CM_CTRL_STATIC|
-		   CM_CTRL_n24BITEN, val);
-}
-
-static int cp_clcd_setup(struct clcd_fb *fb)
-{
-	fb->panel = versatile_clcd_get_panel("VGA");
-	if (!fb->panel)
-		return -EINVAL;
-
-	return versatile_clcd_setup_dma(fb, SZ_1M);
-}
-
-static struct clcd_board clcd_data = {
-	.name		= "Integrator/CP",
-	.caps		= CLCD_CAP_5551 | CLCD_CAP_RGB565 | CLCD_CAP_888,
-	.check		= clcdfb_check,
-	.decode		= clcdfb_decode,
-	.enable		= cp_clcd_enable,
-	.setup		= cp_clcd_setup,
-	.mmap		= versatile_clcd_mmap_dma,
-	.remove		= versatile_clcd_remove_dma,
-};
-
 #define REFCOUNTER (__io_address(INTEGRATOR_HDR_BASE) + 0x28)
 
 static u64 notrace intcp_read_sched_clock(void)
@@ -209,8 +154,6 @@ static struct of_dev_auxdata intcp_auxdata_lookup[] __initdata = {
 		"mmci", &mmc_data),
 	OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_CP_AACI_BASE,
 		"aaci", &mmc_data),
-	OF_DEV_AUXDATA("arm,primecell", INTCP_PA_CLCD_BASE,
-		"clcd", &clcd_data),
 	{ /* sentinel */ },
 };
 
-- 
2.7.4
