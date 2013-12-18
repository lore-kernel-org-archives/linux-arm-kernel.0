From: john.tobias.ph@gmail.com (John Tobias)
Date: Tue, 17 Dec 2013 17:17:31 -0800
Subject: [PATCH 4/4] Added cpufreq support for iMX6SL
In-Reply-To: <1387329451-17480-1-git-send-email-john.tobias.ph@gmail.com>
References: <1387329451-17480-1-git-send-email-john.tobias.ph@gmail.com>
Message-ID: <1387329451-17480-4-git-send-email-john.tobias.ph@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    Re-using imx6q cpufreq driver

Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
---
 arch/arm/mach-imx/mach-imx6sl.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index 2f952e3..a8b1543 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/irqchip.h>
-#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
@@ -34,6 +33,17 @@ static void __init imx6sl_fec_init(void)
 	}
 }
 
+static struct platform_device imx6q_cpufreq_pdev = {
+	.name = "imx6q-cpufreq",
+};
+
+static void __init imx6sl_init_late(void)
+{
+	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ)) {
+		platform_device_register(&imx6q_cpufreq_pdev);
+	}
+}
+
 static void __init imx6sl_init_machine(void)
 {
 	struct device *parent;
@@ -70,6 +80,7 @@ DT_MACHINE_START(IMX6SL, "Freescale i.MX6 SoloLite (Device Tree)")
 	.map_io		= debug_ll_io_init,
 	.init_irq	= imx6sl_init_irq,
 	.init_machine	= imx6sl_init_machine,
+	.init_late      = imx6sl_init_late,
 	.dt_compat	= imx6sl_dt_compat,
 	.restart	= mxc_restart,
 MACHINE_END
-- 
1.8.3.2
