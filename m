From: dingtianhong@huawei.com (Ding Tianhong)
Date: Sat, 26 Nov 2016 16:00:45 +0800
Subject: [PATCH v4 3/6] arm64: arch_timer: Work around Erratum Hisilicon-161601
In-Reply-To: <1480147248-12828-1-git-send-email-dingtianhong@huawei.com>
References: <1480147248-12828-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <1480147248-12828-4-git-send-email-dingtianhong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Erratum Hisilicon-161601 says that the ARM generic timer counter "has the
potential to contain an erroneous value when the timer value changes".
Accesses to TVAL (both read and write) are also affected due to the implicit counter
read.  Accesses to CVAL are not affected.

The workaround is to reread the system count registers until the value of the second
read is larger than the first one by less than 32, the system counter can be guaranteed
not to return wrong value twice by back-to-back read and the error value is always larger
than the correct one by 32. Writes to TVAL are replaced with an equivalent write to CVAL.

The workaround is enabled if the hisilicon,erratum-161601 property is found in
the timer node in the device tree. This can be overridden with the
clocksource.arm_arch_timer.hisilicon-161601 boot parameter, which allows KVM
users to enable the workaround until a mechanism is implemented to
automatically communicate this information.

Fix some description for fsl erratum a008585.

v2: Significant rework based on feedback, including seperate the fsl erratum a008585
    to another patch, update the erratum name and remove unwanted code.

v3: Significant rework based on feedback, including fix some alignment problem, make the
    #define __hisi_161601_read_reg to be private to the .c file instead of being globally
    visible, add more accurate annotation and modify a bit of logical format to enable
    arch_timer_read_ool_enabled, remove the kernel commandline parameter
    clocksource.arm_arch_timer.hisilicon-161601.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
---
 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/include/asm/arch_timer.h    |  2 +-
 drivers/clocksource/Kconfig            |  9 +++++
 drivers/clocksource/arm_arch_timer.c   | 67 +++++++++++++++++++++++++++++++---
 4 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 405da11..1c1a95f 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -63,3 +63,4 @@ stable kernels.
 | Cavium         | ThunderX SMMUv2 | #27704          | N/A		       |
 |                |                 |                 |                         |
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585     |
+| Hisilicon      | Hip0{5,6,7}     | #161601         | HISILICON_ERRATUM_161601|
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index f882c7c..ebf4cde 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -29,7 +29,7 @@
 
 #include <clocksource/arm_arch_timer.h>
 
-#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585)
+#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585) || IS_ENABLED(CONFIG_HISILICON_ERRATUM_161601)
 extern struct static_key_false arch_timer_read_ool_enabled;
 #define needs_unstable_timer_counter_workaround() \
 	static_branch_unlikely(&arch_timer_read_ool_enabled)
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index e2c6e43..6847ef8 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -315,6 +315,15 @@ config FSL_ERRATUM_A008585
 	  value").  The workaround will only be active if the
 	  fsl,erratum-a008585 property is found in the timer node.
 
+config HISILICON_ERRATUM_161601
+	bool "Workaround for Hisilicon Erratum 161601"
+	default y
+	depends on ARM_ARCH_TIMER && ARM64
+	help
+	  This option enables a workaround for Hisilicon Erratum
+	  161601. The workaround will be active if the hisilicon,erratum-161601
+	  property is found in the timer node.
+
 config ARM_GLOBAL_TIMER
 	bool "Support for the ARM global timer" if COMPILE_TEST
 	select CLKSRC_OF if OF
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 696386f..3d59af1 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -94,15 +94,18 @@ static int __init early_evtstrm_cfg(char *buf)
  * Architected system timer support.
  */
 
-#ifdef CONFIG_FSL_ERRATUM_A008585
+#if CONFIG_FSL_ERRATUM_A008585 || IS_ENABLED(CONFIG_HISILICON_ERRATUM_161601)
 struct arch_timer_erratum_workaround *timer_unstable_counter_workaround = NULL;
 EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
 
 #define        FSL_A008585	0x0001
+#define        HISILICON_161601	0x0002
 
 DEFINE_STATIC_KEY_FALSE(arch_timer_read_ool_enabled);
 EXPORT_SYMBOL_GPL(arch_timer_read_ool_enabled);
+#endif
 
+#ifdef CONFIG_FSL_ERRATUM_A008585
 /*
  * The number of retries is an arbitrary value well beyond the highest number
  * of iterations the loop has been observed to take.
@@ -144,6 +147,51 @@ static u64 fsl_a008585_read_cntvct_el0(void)
 };
 #endif /* CONFIG_FSL_ERRATUM_A008585 */
 
+#ifdef CONFIG_HISILICON_ERRATUM_161601
+/*
+ * Theoretically the erratum should not occur more than twice in succession,
+ * so set the retry count to 2 is sufficient here.
+ * Verify whether the value of the second read is larger than the first by
+ * less than 32 is the only way to confirm the value is correct, so clear the
+ * lower 5 bits to check whether the difference is greater than 32 or not.
+ */
+#define __hisi_161601_read_reg(reg) ({				\
+	u64 _old, _new;						\
+	int _retries = 2;					\
+								\
+	do {							\
+		_old = read_sysreg(reg);			\
+		_new = read_sysreg(reg);			\
+		_retries--;					\
+	} while (unlikely((_new - _old) >> 5) && _retries);	\
+								\
+	WARN_ON_ONCE(!_retries);				\
+	_new;							\
+})
+
+static u32 hisi_161601_read_cntp_tval_el0(void)
+{
+	return __hisi_161601_read_reg(cntp_tval_el0);
+}
+
+static  u32 hisi_161601_read_cntv_tval_el0(void)
+{
+	return __hisi_161601_read_reg(cntv_tval_el0);
+}
+
+static u64 hisi_161601_read_cntvct_el0(void)
+{
+	return __hisi_161601_read_reg(cntvct_el0);
+}
+
+static struct arch_timer_erratum_workaround arch_timer_hisi_161601 = {
+	.erratum = HISILICON_161601,
+	.read_cntp_tval_el0 = hisi_161601_read_cntp_tval_el0,
+	.read_cntv_tval_el0 = hisi_161601_read_cntv_tval_el0,
+	.read_cntvct_el0 = hisi_161601_read_cntvct_el0,
+};
+#endif /* CONFIG_HISILICON_ERRATUM_161601 */
+
 static __always_inline
 void arch_timer_reg_write(int access, enum arch_timer_reg reg, u32 val,
 			  struct clock_event_device *clk)
@@ -293,7 +341,7 @@ static __always_inline void set_next_event(const int access, unsigned long evt,
 	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
 }
 
-#ifdef CONFIG_FSL_ERRATUM_A008585
+#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585) || IS_ENABLED(CONFIG_HISILICON_ERRATUM_161601)
 static __always_inline void erratum_set_next_event_generic(const int access,
 		unsigned long evt, struct clock_event_device *clk)
 {
@@ -357,7 +405,7 @@ static int arch_timer_set_next_event_phys_mem(unsigned long evt,
 
 static void erratum_workaround_set_sne(struct clock_event_device *clk)
 {
-#ifdef CONFIG_FSL_ERRATUM_A008585
+#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585) || IS_ENABLED(CONFIG_HISILICON_ERRATUM_161601)
 	if (!static_branch_unlikely(&arch_timer_read_ool_enabled))
 		return;
 
@@ -617,7 +665,7 @@ static void __init arch_counter_register(unsigned type)
 
 		clocksource_counter.archdata.vdso_direct = true;
 
-#ifdef CONFIG_FSL_ERRATUM_A008585
+#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585) || IS_ENABLED(CONFIG_HISILICON_ERRATUM_161601)
 		/*
 		 * Don't use the vdso fastpath if errata require using
 		 * the out-of-line counter accessor.
@@ -906,10 +954,19 @@ static int __init arch_timer_of_init(struct device_node *np)
 #ifdef CONFIG_FSL_ERRATUM_A008585
 	if (!timer_unstable_counter_workaround && of_property_read_bool(np, "fsl,erratum-a008585"))
 		timer_unstable_counter_workaround = &arch_timer_fsl_a008585;
+#endif
+
+#ifdef CONFIG_HISILICON_ERRATUM_161601
+	if (!timer_unstable_counter_workaround && of_property_read_bool(np, "hisilicon,erratum-161601"))
+		timer_unstable_counter_workaround = &arch_timer_hisi_161601;
+#endif
 
+#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585) || IS_ENABLED(CONFIG_HISILICON_ERRATUM_161601)
 	if (timer_unstable_counter_workaround) {
 		static_branch_enable(&arch_timer_read_ool_enabled);
-		pr_info("Enabling workaround for FSL erratum A-008585\n");
+		pr_info("Enabling workaround for %s\n",
+			timer_unstable_counter_workaround->erratum == FSL_A008585 ?
+			"FSL ERRATUM A-008585" : "HISILICON ERRATUM 161601");
 	}
 #endif
 
-- 
1.9.0
