From: b20788@freescale.com (Anson Huang)
Date: Mon, 23 Jun 2014 12:10:32 +0800
Subject: [PATCH] ARM: imx: add cpufreq support for i.mx6sx
Message-ID: <1403496632-20308-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cpufreq support for i.MX6SX, using common
i.MX6Q cpufreq driver.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/mach-imx6sx.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
index 74ff7d6..be2ca52 100644
--- a/arch/arm/mach-imx/mach-imx6sx.c
+++ b/arch/arm/mach-imx/mach-imx6sx.c
@@ -8,6 +8,7 @@
 
 #include <linux/irqchip.h>
 #include <linux/of_platform.h>
+#include <linux/pm_opp.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
@@ -39,9 +40,35 @@ static void __init imx6sx_init_irq(void)
 	irqchip_init();
 }
 
+static void __init imx6sx_opp_init(struct device *cpu_dev)
+{
+	struct device_node *np;
+
+	np = of_find_node_by_path("/cpus/cpu at 0");
+	if (!np) {
+		pr_warn("failed to find cpu0 node\n");
+		return;
+	}
+
+	cpu_dev->of_node = np;
+	if (of_init_opp_table(cpu_dev))
+		pr_warn("failed to init OPP table\n");
+
+	of_node_put(np);
+}
+
+static struct platform_device imx6sx_cpufreq_pdev = {
+	.name = "imx6q-cpufreq",
+};
+
 static void __init imx6sx_init_late(void)
 {
 	imx6q_cpuidle_init();
+
+	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ)) {
+		imx6sx_opp_init(&imx6sx_cpufreq_pdev.dev);
+		platform_device_register(&imx6sx_cpufreq_pdev);
+	}
 }
 
 static const char *imx6sx_dt_compat[] __initconst = {
-- 
1.7.9.5
