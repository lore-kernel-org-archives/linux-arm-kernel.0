From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Mar 2013 16:55:48 +0800
Subject: [PATCH 12/13] ARM: mxs: merge imx23 and imx28 into one machine_desc
In-Reply-To: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
References: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364547350-30498-13-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the function hooks are same between imx23 and imx28
machine_desc, so merge them into one.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/mach-mxs.c |   43 +++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 19f732f..b74f450 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -181,18 +181,6 @@ static struct of_dev_auxdata mxs_auxdata_lookup[] __initdata = {
 	{ /* sentinel */ }
 };
 
-static void __init imx23_timer_init(void)
-{
-	mx23_clocks_init();
-	clocksource_of_init();
-}
-
-static void __init imx28_timer_init(void)
-{
-	mx28_clocks_init();
-	clocksource_of_init();
-}
-
 #define OCOTP_WORD_OFFSET		0x20
 #define OCOTP_WORD_COUNT		0x20
 
@@ -573,32 +561,27 @@ soft:
 	soft_restart(0);
 }
 
-static const char *imx23_dt_compat[] __initdata = {
-	"fsl,imx23",
-	NULL,
-};
+static void __init mxs_timer_init(void)
+{
+	if (of_machine_is_compatible("fsl,imx23"))
+		mx23_clocks_init();
+	else
+		mx28_clocks_init();
+	clocksource_of_init();
+}
 
-static const char *imx28_dt_compat[] __initdata = {
+static const char *mxs_dt_compat[] __initdata = {
 	"fsl,imx28",
+	"fsl,imx23",
 	NULL,
 };
 
-DT_MACHINE_START(IMX23, "Freescale i.MX23 (Device Tree)")
-	.map_io		= debug_ll_io_init,
-	.init_irq	= irqchip_init,
-	.handle_irq	= icoll_handle_irq,
-	.init_time	= imx23_timer_init,
-	.init_machine	= mxs_machine_init,
-	.dt_compat	= imx23_dt_compat,
-	.restart	= mxs_restart,
-MACHINE_END
-
-DT_MACHINE_START(IMX28, "Freescale i.MX28 (Device Tree)")
+DT_MACHINE_START(MXS, "Freescale MXS (Device Tree)")
 	.map_io		= debug_ll_io_init,
 	.init_irq	= irqchip_init,
 	.handle_irq	= icoll_handle_irq,
-	.init_time	= imx28_timer_init,
+	.init_time	= mxs_timer_init,
 	.init_machine	= mxs_machine_init,
-	.dt_compat	= imx28_dt_compat,
+	.dt_compat	= mxs_dt_compat,
 	.restart	= mxs_restart,
 MACHINE_END
-- 
1.7.9.5
