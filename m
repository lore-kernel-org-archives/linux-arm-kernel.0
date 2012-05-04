From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri,  4 May 2012 21:50:43 +0800
Subject: [PATCH 1/2] ARM: mxs: add initial device tree support for imx23-evk
 board
Message-ID: <1336139444-24672-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds initial device tree support for imx23-evk board, and only
serial console is enabled.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.txt |    4 ++++
 arch/arm/mach-mxs/Kconfig                     |    1 +
 arch/arm/mach-mxs/clock-mx23.c                |    2 ++
 arch/arm/mach-mxs/mach-mxs.c                  |   24 ++++++++++++++++++++++++
 4 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index fecb580..1708df5 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -1,6 +1,10 @@
 Freescale i.MX Platforms Device Tree Bindings
 -----------------------------------------------
 
+i.MX23 Evaluation Kit
+Required root node properties:
+    - compatible = "fsl,imx23-evk", "fsl,imx23";
+
 i.MX28 Evaluation Kit
 Required root node properties:
     - compatible = "fsl,imx28-evk", "fsl,imx28";
diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 09fe0fb..a37cfc3 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -21,6 +21,7 @@ comment "MXS platforms:"
 
 config MACH_MXS_DT
 	bool "Support MXS platforms from device tree"
+	select SOC_IMX23
 	select SOC_IMX28
 	select USE_OF
 	help
diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
index e3ac52c..23652df 100644
--- a/arch/arm/mach-mxs/clock-mx23.c
+++ b/arch/arm/mach-mxs/clock-mx23.c
@@ -440,6 +440,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxs-pwm.4", NULL, pwm_clk)
 	_REGISTER_CLOCK("imx23-fb", NULL, lcdif_clk)
 	_REGISTER_CLOCK("imx23-gpmi-nand", NULL, gpmi_clk)
+	/* for DT */
+	_REGISTER_CLOCK("80070000.serial", NULL, uart_clk)
 };
 
 static int clk_misc_init(void)
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 5c5cba2..ae07c9d 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -37,6 +37,15 @@ static void __init mxs_dt_init_irq(void)
 	of_irq_init(mxs_irq_match);
 }
 
+static void __init imx23_timer_init(void)
+{
+	mx23_clocks_init();
+}
+
+static struct sys_timer imx23_timer = {
+	.init = imx23_timer_init,
+};
+
 static void __init imx28_timer_init(void)
 {
 	mx28_clocks_init();
@@ -52,12 +61,27 @@ static void __init mxs_machine_init(void)
 				NULL, NULL);
 }
 
+static const char *imx23_dt_compat[] __initdata = {
+	"fsl,imx23-evk",
+	"fsl,imx23",
+	NULL,
+};
+
 static const char *imx28_dt_compat[] __initdata = {
 	"fsl,imx28-evk",
 	"fsl,imx28",
 	NULL,
 };
 
+DT_MACHINE_START(IMX23, "Freescale i.MX23 (Device Tree)")
+	.map_io		= mx23_map_io,
+	.init_irq	= mxs_dt_init_irq,
+	.timer		= &imx23_timer,
+	.init_machine	= mxs_machine_init,
+	.dt_compat	= imx23_dt_compat,
+	.restart	= mxs_restart,
+MACHINE_END
+
 DT_MACHINE_START(IMX28, "Freescale i.MX28 (Device Tree)")
 	.map_io		= mx28_map_io,
 	.init_irq	= mxs_dt_init_irq,
-- 
1.7.5.4
