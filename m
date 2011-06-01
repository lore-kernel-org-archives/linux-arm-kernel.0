From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 1 Jun 2011 14:47:33 +0200
Subject: [PATCH] mach-ux500: register a clock for the SMP TWD
Message-ID: <1306932453-19889-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The SMP TWD on the ux500 will change frequency at the same time as
the CPU. Loop back the frequency presented from the CPU into a
clock that is looked up by the SMP TWD driver with the new cpufreq
notifier hook.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/clock.c |   48 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index 32ce908..b4e786a 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/clkdev.h>
+#include <linux/cpufreq.h>
 
 #include <plat/mtu.h>
 #include <mach/hardware.h>
@@ -759,6 +760,51 @@ err_out:
 late_initcall(clk_debugfs_init);
 #endif /* defined(CONFIG_DEBUG_FS) */
 
+unsigned long clk_smp_twd_rate = 400000000;
+
+unsigned long clk_smp_twd_get_rate(struct clk *clk)
+{
+	return clk_smp_twd_rate;
+}
+
+static struct clk clk_smp_twd = {
+	.get_rate = clk_smp_twd_get_rate,
+	.name =  "smp_twd",
+};
+
+static struct clk_lookup clk_smp_twd_lookup = {
+	.dev_id = "smp_twd",
+	.clk = &clk_smp_twd,
+};
+
+#ifdef CONFIG_CPU_FREQ
+
+static int clk_twd_cpufreq_transition(struct notifier_block *nb,
+				      unsigned long state, void *data)
+{
+	struct cpufreq_freqs *f = data;
+
+	if (state == CPUFREQ_PRECHANGE) {
+		/* Save frequency in simple Hz */
+		clk_smp_twd_rate = f->new * 1000;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block clk_twd_cpufreq_nb = {
+	.notifier_call = clk_twd_cpufreq_transition,
+};
+
+static int clk_init_smp_twd_cpufreq(void)
+{
+	return cpufreq_register_notifier(&clk_twd_cpufreq_nb,
+				  CPUFREQ_TRANSITION_NOTIFIER);
+}
+late_initcall(clk_init_smp_twd_cpufreq);
+
+#endif
+
 int __init clk_init(void)
 {
 	if (cpu_is_u8500ed()) {
@@ -779,6 +825,8 @@ int __init clk_init(void)
 	else
 		clkdev_add_table(u8500_v1_clks, ARRAY_SIZE(u8500_v1_clks));
 
+	clkdev_add(&clk_smp_twd_lookup);
+
 #ifdef CONFIG_DEBUG_FS
 	clk_debugfs_add_table(u8500_common_clks, ARRAY_SIZE(u8500_common_clks));
 	if (cpu_is_u8500ed())
-- 
1.7.3.2
