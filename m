From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Mar 2013 21:59:33 +0800
Subject: [PATCH 1/2] clk: mxs: get base address from device tree
In-Reply-To: <1364306374-10481-1-git-send-email-shawn.guo@linaro.org>
References: <1364306374-10481-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364306374-10481-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of using the static definitions, get clkctrl and digctl base
addresses with mapping from device tree.

Use macro on variable is not nice, but it's done here to save huge
pointless diff stat.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx23.dtsi |    1 +
 arch/arm/boot/dts/imx28.dtsi |    1 +
 drivers/clk/mxs/clk-imx23.c  |   26 ++++++++++++++++++--------
 drivers/clk/mxs/clk-imx28.c  |   25 +++++++++++++++++--------
 4 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 27ce807..8d37aa7 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -295,6 +295,7 @@
 			};
 
 			digctl at 8001c000 {
+				compatible = "fsl,imx23-digctl";
 				reg = <0x8001c000 2000>;
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index c2f10d3..d306ff5 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -647,6 +647,7 @@
 			};
 
 			digctl at 8001c000 {
+				compatible = "fsl,imx28-digctl";
 				reg = <0x8001c000 0x2000>;
 				interrupts = <89>;
 				status = "disabled";
diff --git a/drivers/clk/mxs/clk-imx23.c b/drivers/clk/mxs/clk-imx23.c
index 46ae6be..0c8fda4 100644
--- a/drivers/clk/mxs/clk-imx23.c
+++ b/drivers/clk/mxs/clk-imx23.c
@@ -15,11 +15,16 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <mach/mx23.h>
 #include "clk.h"
 
-#define DIGCTRL			MX23_IO_ADDRESS(MX23_DIGCTL_BASE_ADDR)
-#define CLKCTRL			MX23_IO_ADDRESS(MX23_CLKCTRL_BASE_ADDR)
+static void __iomem *clkctrl;
+static void __iomem *digctrl;
+
+#define CLKCTRL clkctrl
+#define DIGCTRL digctrl
+
 #define PLLCTRL0		(CLKCTRL + 0x0000)
 #define CPU			(CLKCTRL + 0x0020)
 #define HBUS			(CLKCTRL + 0x0030)
@@ -100,6 +105,14 @@ int __init mx23_clocks_init(void)
 	struct device_node *np;
 	u32 i;
 
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx23-digctl");
+	digctrl = of_iomap(np, 0);
+	WARN_ON(!digctrl);
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx23-clkctrl");
+	clkctrl = of_iomap(np, 0);
+	WARN_ON(!clkctrl);
+
 	clk_misc_init();
 
 	clks[ref_xtal] = mxs_clk_fixed("ref_xtal", 24000000);
@@ -152,12 +165,9 @@ int __init mx23_clocks_init(void)
 			return PTR_ERR(clks[i]);
 		}
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx23-clkctrl");
-	if (np) {
-		clk_data.clks = clks;
-		clk_data.clk_num = ARRAY_SIZE(clks);
-		of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
-	}
+	clk_data.clks = clks;
+	clk_data.clk_num = ARRAY_SIZE(clks);
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
 		clk_prepare_enable(clks[clks_init_on[i]]);
diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index fb30cd9..f623fdd 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -15,10 +15,13 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <mach/mx28.h>
 #include "clk.h"
 
-#define CLKCTRL			MX28_IO_ADDRESS(MX28_CLKCTRL_BASE_ADDR)
+static void __iomem *clkctrl;
+#define CLKCTRL clkctrl
+
 #define PLL0CTRL0		(CLKCTRL + 0x0000)
 #define PLL1CTRL0		(CLKCTRL + 0x0020)
 #define PLL2CTRL0		(CLKCTRL + 0x0040)
@@ -52,7 +55,8 @@
 #define BP_FRAC0_IO1FRAC	16
 #define BP_FRAC0_IO0FRAC	24
 
-#define DIGCTRL			MX28_IO_ADDRESS(MX28_DIGCTL_BASE_ADDR)
+static void __iomem *digctrl;
+#define DIGCTRL digctrl
 #define BP_SAIF_CLKMUX		10
 
 /*
@@ -155,6 +159,14 @@ int __init mx28_clocks_init(void)
 	struct device_node *np;
 	u32 i;
 
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx28-digctl");
+	digctrl = of_iomap(np, 0);
+	WARN_ON(!digctrl);
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx28-clkctrl");
+	clkctrl = of_iomap(np, 0);
+	WARN_ON(!clkctrl);
+
 	clk_misc_init();
 
 	clks[ref_xtal] = mxs_clk_fixed("ref_xtal", 24000000);
@@ -230,12 +242,9 @@ int __init mx28_clocks_init(void)
 			return PTR_ERR(clks[i]);
 		}
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx28-clkctrl");
-	if (np) {
-		clk_data.clks = clks;
-		clk_data.clk_num = ARRAY_SIZE(clks);
-		of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
-	}
+	clk_data.clks = clks;
+	clk_data.clk_num = ARRAY_SIZE(clks);
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
 	clk_register_clkdev(clks[enet_out], NULL, "enet_out");
 
-- 
1.7.9.5
