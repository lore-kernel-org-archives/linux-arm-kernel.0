From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Mar 2013 16:55:41 +0800
Subject: [PATCH 05/13] ARM: mxs: get reset address from device tree
In-Reply-To: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
References: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364547350-30498-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of using static address definition, get reset address from
device tree with mapping, so that core_initcall mxs_arch_reset_init()
can be killed.

The "rtc" clock code in mxs_arch_reset_init() seems to be zombie, since
there is no clk lookup defined in clock driver at all.  Remove it
together.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx23.dtsi |    2 +-
 arch/arm/boot/dts/imx28.dtsi |    2 +-
 arch/arm/mach-mxs/system.c   |   36 +++++++++++++++++-------------------
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 8d37aa7..30b410b 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -361,7 +361,7 @@
 			ranges;
 
 			clks: clkctrl at 80040000 {
-				compatible = "fsl,imx23-clkctrl";
+				compatible = "fsl,imx23-clkctrl", "fsl,clkctrl";
 				reg = <0x80040000 0x2000>;
 				#clock-cells = <1>;
 			};
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index d306ff5..56d84bf 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -756,7 +756,7 @@
 			ranges;
 
 			clks: clkctrl at 80040000 {
-				compatible = "fsl,imx28-clkctrl";
+				compatible = "fsl,imx28-clkctrl", "fsl,clkctrl";
 				reg = <0x80040000 0x2000>;
 				#clock-cells = <1>;
 			};
diff --git a/arch/arm/mach-mxs/system.c b/arch/arm/mach-mxs/system.c
index 30042e2..2d64ee9 100644
--- a/arch/arm/mach-mxs/system.c
+++ b/arch/arm/mach-mxs/system.c
@@ -23,6 +23,8 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 
 #include <asm/proc-fns.h>
 #include <asm/system_misc.h>
@@ -37,41 +39,37 @@
 #define MXS_MODULE_CLKGATE		(1 << 30)
 #define MXS_MODULE_SFTRST		(1 << 31)
 
-static void __iomem *mxs_clkctrl_reset_addr;
-
 /*
  * Reset the system. It is called by machine_restart().
  */
 void mxs_restart(char mode, const char *cmd)
 {
+	struct device_node *np;
+	void __iomem *reset_addr;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,clkctrl");
+	reset_addr = of_iomap(np, 0);
+	if (!reset_addr)
+		goto soft;
+
+	if (of_device_is_compatible(np, "fsl,imx23-clkctrl"))
+		reset_addr += MX23_CLKCTRL_RESET_OFFSET;
+	else
+		reset_addr += MX28_CLKCTRL_RESET_OFFSET;
+
 	/* reset the chip */
-	__mxs_setl(MXS_CLKCTRL_RESET_CHIP, mxs_clkctrl_reset_addr);
+	__mxs_setl(MXS_CLKCTRL_RESET_CHIP, reset_addr);
 
 	pr_err("Failed to assert the chip reset\n");
 
 	/* Delay to allow the serial port to show the message */
 	mdelay(50);
 
+soft:
 	/* We'll take a jump through zero as a poor second */
 	soft_restart(0);
 }
 
-static int __init mxs_arch_reset_init(void)
-{
-	struct clk *clk;
-
-	mxs_clkctrl_reset_addr = MXS_IO_ADDRESS(MXS_CLKCTRL_BASE_ADDR) +
-				(cpu_is_mx23() ? MX23_CLKCTRL_RESET_OFFSET :
-						 MX28_CLKCTRL_RESET_OFFSET);
-
-	clk = clk_get_sys("rtc", NULL);
-	if (!IS_ERR(clk))
-		clk_prepare_enable(clk);
-
-	return 0;
-}
-core_initcall(mxs_arch_reset_init);
-
 /*
  * Clear the bit and poll it cleared.  This is usually called with
  * a reset address and mask being either SFTRST(bit 31) or CLKGATE
-- 
1.7.9.5
