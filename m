From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed,  2 May 2012 19:33:40 +0800
Subject: [PATCH 15/15] ARM: ux500: use machine specific hook for late init
In-Reply-To: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
References: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1335958420-5193-16-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500.c       |    4 ++++
 arch/arm/mach-ux500/clock.c              |    6 ++----
 arch/arm/mach-ux500/clock.h              |   12 ++++++++++++
 arch/arm/mach-ux500/cpu.c                |    6 ++++++
 arch/arm/mach-ux500/include/mach/setup.h |    1 +
 5 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 77d03c1..348ebd9 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -722,6 +722,7 @@ MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
 	.timer		= &ux500_timer,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= mop500_init_machine,
+	.init_late	= ux500_init_late,
 MACHINE_END
 
 MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
@@ -731,6 +732,7 @@ MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
 	.timer		= &ux500_timer,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= hrefv60_init_machine,
+	.init_late	= ux500_init_late,
 MACHINE_END
 
 MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
@@ -741,6 +743,7 @@ MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
 	.timer		= &ux500_timer,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= snowball_init_machine,
+	.init_late	= ux500_init_late,
 MACHINE_END
 
 #ifdef CONFIG_MACH_UX500_DT
@@ -830,6 +833,7 @@ DT_MACHINE_START(U8500_DT, "ST-Ericsson U8500 platform (Device Tree Support)")
 	.timer		= &ux500_timer,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= u8500_init_machine,
+	.init_late	= ux500_init_late,
 	.dt_compat      = u8500_dt_board_compat,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index ec35f0a..ce00f5e 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -633,7 +633,7 @@ static int clk_debugfs_register(struct clk *c)
 	return 0;
 }
 
-static int __init clk_debugfs_init(void)
+int __init clk_debugfs_init(void)
 {
 	struct clk *c;
 	struct dentry *d;
@@ -655,7 +655,6 @@ err_out:
 	return err;
 }
 
-late_initcall(clk_debugfs_init);
 #endif /* defined(CONFIG_DEBUG_FS) */
 
 unsigned long clk_smp_twd_rate = 500000000;
@@ -694,12 +693,11 @@ static struct notifier_block clk_twd_cpufreq_nb = {
 	.notifier_call = clk_twd_cpufreq_transition,
 };
 
-static int clk_init_smp_twd_cpufreq(void)
+int clk_init_smp_twd_cpufreq(void)
 {
 	return cpufreq_register_notifier(&clk_twd_cpufreq_nb,
 				  CPUFREQ_TRANSITION_NOTIFIER);
 }
-late_initcall(clk_init_smp_twd_cpufreq);
 
 #endif
 
diff --git a/arch/arm/mach-ux500/clock.h b/arch/arm/mach-ux500/clock.h
index d776ada..65d27a1 100644
--- a/arch/arm/mach-ux500/clock.h
+++ b/arch/arm/mach-ux500/clock.h
@@ -150,3 +150,15 @@ struct clk clk_##_name = {						\
 
 int __init clk_db8500_ed_fixup(void);
 int __init clk_init(void);
+
+#ifdef CONFIG_DEBUG_FS
+int clk_debugfs_init(void);
+#else
+static inline int clk_debugfs_init(void) { return 0; }
+#endif
+
+#ifdef CONFIG_CPU_FREQ
+int clk_init_smp_twd_cpufreq(void);
+#else
+static inline int clk_init_smp_twd_cpufreq(void) { return 0; }
+#endif
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index d11f389..9856c57 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -67,6 +67,12 @@ void __init ux500_init_irq(void)
 	clk_init();
 }
 
+void __init ux500_init_late(void)
+{
+	clk_debugfs_init();
+	clk_init_smp_twd_cpufreq();
+}
+
 static const char * __init ux500_get_machine(void)
 {
 	return kasprintf(GFP_KERNEL, "DB%4x", dbx500_partnumber());
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
index 3dc00ff..7b5d865 100644
--- a/arch/arm/mach-ux500/include/mach/setup.h
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -22,6 +22,7 @@ extern struct device * __init u5500_init_devices(void);
 extern struct device * __init u8500_init_devices(void);
 
 extern void __init ux500_init_irq(void);
+extern void __init ux500_init_late(void);
 
 extern void __init u5500_sdi_init(struct device *parent);
 
-- 
1.7.5.4
