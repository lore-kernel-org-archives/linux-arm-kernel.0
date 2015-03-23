From: ola@adapteva.com (Ola Jeppsson)
Date: Mon, 23 Mar 2015 02:39:38 +0100
Subject: [PATCH v2] arm: zynq: Fix system clock with multi_v7_defconfig
Message-ID: <550F6EDA.30709@adapteva.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As mentioned in this commit:
arm: zynq: Don't use arm_global_timer with cpufreq
61f1fc7e9258a169ac8afb5ddf657a181e60d052

arm_global_timer depends on the CPU frequency. With cpufreq altering the
CPU frequency arm_global_timer will not maintain a stable time base. So
arm_global_timer must not be the clocksource when cpufreq is enabled.

The above commit tries to solve this at build time by only selecting
CONFIG_ARM_GLOBAL_TIMER if CONFIG_CPU_FREQ is disabled. This is not
always sufficient because other machs can also enable
CONFIG_ARM_GLOBAL_TIMER.

Therefore: If built with CONFIG_CPU_FREQ and CONFIG_ARM_GLOBAL_TIMER,
disable (on Zynq) the arm_global_timer devicetree node at boot before
clock sources are initialized. This ensures that arm_global_timer will
not be selected clocksource.

Signed-off-by: Ola Jeppsson <ola@adapteva.com>
---
 arch/arm/mach-zynq/common.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index c887196..a4666d4 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -148,10 +148,36 @@ out:
 	platform_device_register_full(&devinfo);
 }
 
+#if defined(CONFIG_CPU_FREQ) && defined(CONFIG_ARM_GLOBAL_TIMER)
+static struct property zynq_disable_arm_global_timer_prop = {
+	.name = "status",
+	.length = sizeof("disabled"),
+	.value = "disabled"
+};
+
+static void __init zynq_disable_arm_global_timer(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-global-timer");
+	if (!np)
+		return;
+
+	pr_info("%s: disabling arm_global_timer node\n", __func__);
+
+	if (of_update_property(np, &zynq_disable_arm_global_timer_prop))
+		pr_warn("%s: could not disable arm_global_timer node\n",
+			__func__);
+}
+#endif
+
 static void __init zynq_timer_init(void)
 {
 	zynq_early_slcr_init();
 
+#if defined(CONFIG_CPU_FREQ) && defined(CONFIG_ARM_GLOBAL_TIMER)
+	zynq_disable_arm_global_timer();
+#endif
 	zynq_clock_init();
 	of_clk_init(NULL);
 	clocksource_of_init();
-- 
2.3.3
