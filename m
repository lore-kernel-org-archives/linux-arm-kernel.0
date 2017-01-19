From: dingtianhong@huawei.com (Ding Tianhong)
Date: Thu, 19 Jan 2017 21:35:14 +0800
Subject: [PATCH v9 2/4] arm64: arch_timer: Introduce a generic erratum handing
 mechanism for fsl-a008585
In-Reply-To: <1484832916-7248-1-git-send-email-dingtianhong@huawei.com>
References: <1484832916-7248-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <1484832916-7248-3-git-send-email-dingtianhong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The workaround for hisilicon,161010101 will check the return value of the system counter
by different way, in order to distinguish with the fsl-a008585 workaround, introduce
a new generic erratum handing mechanism for fsl-a008585 and rename some functions.

After discussion with Marc and Will, a consensus decision was made to remove the commandline
parameter for enabling fsl,erratum-a008585 erratum.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt |   9 --
 arch/arm64/include/asm/arch_timer.h             |  38 +++------
 drivers/clocksource/Kconfig                     |   8 ++
 drivers/clocksource/arm_arch_timer.c            | 105 ++++++++++++++----------
 4 files changed, 84 insertions(+), 76 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 21e2d88..76437ad 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -539,15 +539,6 @@
 			loops can be debugged more effectively on production
 			systems.
 
-	clocksource.arm_arch_timer.fsl-a008585=
-			[ARM64]
-			Format: <bool>
-			Enable/disable the workaround of Freescale/NXP
-			erratum A-008585.  This can be useful for KVM
-			guests, if the guest device tree doesn't show the
-			erratum.  If unspecified, the workaround is
-			enabled based on the device tree.
-
 	clearcpuid=BITNUM [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index eaa5bbe..b4b3400 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -29,41 +29,29 @@
 
 #include <clocksource/arm_arch_timer.h>
 
-#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585)
+#if IS_ENABLED(CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND)
 extern struct static_key_false arch_timer_read_ool_enabled;
-#define needs_fsl_a008585_workaround() \
+#define needs_unstable_timer_counter_workaround() \
 	static_branch_unlikely(&arch_timer_read_ool_enabled)
 #else
-#define needs_fsl_a008585_workaround()  false
+#define needs_unstable_timer_counter_workaround()  false
 #endif
 
-u32 __fsl_a008585_read_cntp_tval_el0(void);
-u32 __fsl_a008585_read_cntv_tval_el0(void);
-u64 __fsl_a008585_read_cntvct_el0(void);
 
-/*
- * The number of retries is an arbitrary value well beyond the highest number
- * of iterations the loop has been observed to take.
- */
-#define __fsl_a008585_read_reg(reg) ({			\
-	u64 _old, _new;					\
-	int _retries = 200;				\
-							\
-	do {						\
-		_old = read_sysreg(reg);		\
-		_new = read_sysreg(reg);		\
-		_retries--;				\
-	} while (unlikely(_old != _new) && _retries);	\
-							\
-	WARN_ON_ONCE(!_retries);			\
-	_new;						\
-})
+struct arch_timer_erratum_workaround {
+	const char *id;		/* Indicate the Erratum ID */
+	u32 (*read_cntp_tval_el0)(void);
+	u32 (*read_cntv_tval_el0)(void);
+	u64 (*read_cntvct_el0)(void);
+};
+
+extern const struct arch_timer_erratum_workaround *timer_unstable_counter_workaround;
 
 #define arch_timer_reg_read_stable(reg) 		\
 ({							\
 	u64 _val;					\
-	if (needs_fsl_a008585_workaround())		\
-		_val = __fsl_a008585_read_##reg();	\
+	if (needs_unstable_timer_counter_workaround())		\
+		_val = timer_unstable_counter_workaround->read_##reg();\
 	else						\
 		_val = read_sysreg(reg);		\
 	_val;						\
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 4866f7a..6693e07 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -325,10 +325,18 @@ config ARM_ARCH_TIMER_EVTSTREAM
 	  This must be disabled for hardware validation purposes to detect any
 	  hardware anomalies of missing events.
 
+config ARM_ARCH_TIMER_OOL_WORKAROUND
+	bool
+	depends on FSL_ERRATUM_A008585
+	help
+	  This option would only be enabled by Freescale/NXP Erratum A-008585
+	  or something else chip has similar erratum.
+
 config FSL_ERRATUM_A008585
 	bool "Workaround for Freescale/NXP Erratum A-008585"
 	default y
 	depends on ARM_ARCH_TIMER && ARM64
+	select ARM_ARCH_TIMER_OOL_WORKAROUND
 	help
 	  This option enables a workaround for Freescale/NXP Erratum
 	  A-008585 ("ARM generic timer may contain an erroneous
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 02fef68..2487c66 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -96,41 +96,59 @@ static int __init early_evtstrm_cfg(char *buf)
  */
 
 #ifdef CONFIG_FSL_ERRATUM_A008585
-DEFINE_STATIC_KEY_FALSE(arch_timer_read_ool_enabled);
-EXPORT_SYMBOL_GPL(arch_timer_read_ool_enabled);
-
-static int fsl_a008585_enable = -1;
-
-static int __init early_fsl_a008585_cfg(char *buf)
-{
-	int ret;
-	bool val;
 
-	ret = strtobool(buf, &val);
-	if (ret)
-		return ret;
-
-	fsl_a008585_enable = val;
-	return 0;
-}
-early_param("clocksource.arm_arch_timer.fsl-a008585", early_fsl_a008585_cfg);
-
-u32 __fsl_a008585_read_cntp_tval_el0(void)
+/*
+ * The number of retries is an arbitrary value well beyond the highest number
+ * of iterations the loop has been observed to take.
+ */
+#define __fsl_a008585_read_reg(reg) ({			\
+	u64 _old, _new;					\
+	int _retries = 200;				\
+							\
+	do {						\
+		_old = read_sysreg(reg);		\
+		_new = read_sysreg(reg);		\
+		_retries--;				\
+	} while (unlikely(_old != _new) && _retries);	\
+							\
+	WARN_ON_ONCE(!_retries);			\
+	_new;						\
+})
+
+static u32 notrace fsl_a008585_read_cntp_tval_el0(void)
 {
 	return __fsl_a008585_read_reg(cntp_tval_el0);
 }
 
-u32 __fsl_a008585_read_cntv_tval_el0(void)
+static u32 notrace fsl_a008585_read_cntv_tval_el0(void)
 {
 	return __fsl_a008585_read_reg(cntv_tval_el0);
 }
 
-u64 __fsl_a008585_read_cntvct_el0(void)
+static u64 notrace fsl_a008585_read_cntvct_el0(void)
 {
 	return __fsl_a008585_read_reg(cntvct_el0);
 }
-EXPORT_SYMBOL(__fsl_a008585_read_cntvct_el0);
-#endif /* CONFIG_FSL_ERRATUM_A008585 */
+#endif
+
+#ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
+const struct arch_timer_erratum_workaround *timer_unstable_counter_workaround = NULL;
+EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
+
+DEFINE_STATIC_KEY_FALSE(arch_timer_read_ool_enabled);
+EXPORT_SYMBOL_GPL(arch_timer_read_ool_enabled);
+
+static const struct arch_timer_erratum_workaround ool_workarounds[] = {
+#ifdef CONFIG_FSL_ERRATUM_A008585
+	{
+		.id = "fsl,erratum-a008585",
+		.read_cntp_tval_el0 = fsl_a008585_read_cntp_tval_el0,
+		.read_cntv_tval_el0 = fsl_a008585_read_cntv_tval_el0,
+		.read_cntvct_el0 = fsl_a008585_read_cntvct_el0,
+	},
+#endif
+};
+#endif /* CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND */
 
 static __always_inline
 void arch_timer_reg_write(int access, enum arch_timer_reg reg, u32 val,
@@ -281,8 +299,8 @@ static __always_inline void set_next_event(const int access, unsigned long evt,
 	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
 }
 
-#ifdef CONFIG_FSL_ERRATUM_A008585
-static __always_inline void fsl_a008585_set_next_event(const int access,
+#ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
+static __always_inline void erratum_set_next_event_generic(const int access,
 		unsigned long evt, struct clock_event_device *clk)
 {
 	unsigned long ctrl;
@@ -300,20 +318,20 @@ static __always_inline void fsl_a008585_set_next_event(const int access,
 	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
 }
 
-static int fsl_a008585_set_next_event_virt(unsigned long evt,
+static int erratum_set_next_event_virt(unsigned long evt,
 					   struct clock_event_device *clk)
 {
-	fsl_a008585_set_next_event(ARCH_TIMER_VIRT_ACCESS, evt, clk);
+	erratum_set_next_event_generic(ARCH_TIMER_VIRT_ACCESS, evt, clk);
 	return 0;
 }
 
-static int fsl_a008585_set_next_event_phys(unsigned long evt,
+static int erratum_set_next_event_phys(unsigned long evt,
 					   struct clock_event_device *clk)
 {
-	fsl_a008585_set_next_event(ARCH_TIMER_PHYS_ACCESS, evt, clk);
+	erratum_set_next_event_generic(ARCH_TIMER_PHYS_ACCESS, evt, clk);
 	return 0;
 }
-#endif /* CONFIG_FSL_ERRATUM_A008585 */
+#endif /* CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND */
 
 static int arch_timer_set_next_event_virt(unsigned long evt,
 					  struct clock_event_device *clk)
@@ -343,16 +361,16 @@ static int arch_timer_set_next_event_phys_mem(unsigned long evt,
 	return 0;
 }
 
-static void fsl_a008585_set_sne(struct clock_event_device *clk)
+static void erratum_workaround_set_sne(struct clock_event_device *clk)
 {
-#ifdef CONFIG_FSL_ERRATUM_A008585
+#ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
 	if (!static_branch_unlikely(&arch_timer_read_ool_enabled))
 		return;
 
 	if (arch_timer_uses_ppi == VIRT_PPI)
-		clk->set_next_event = fsl_a008585_set_next_event_virt;
+		clk->set_next_event = erratum_set_next_event_virt;
 	else
-		clk->set_next_event = fsl_a008585_set_next_event_phys;
+		clk->set_next_event = erratum_set_next_event_phys;
 #endif
 }
 
@@ -385,7 +403,7 @@ static void __arch_timer_setup(unsigned type,
 			BUG();
 		}
 
-		fsl_a008585_set_sne(clk);
+		erratum_workaround_set_sne(clk);
 	} else {
 		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
 		clk->name = "arch_mem_timer";
@@ -605,7 +623,7 @@ static void __init arch_counter_register(unsigned type)
 
 		clocksource_counter.archdata.vdso_direct = true;
 
-#ifdef CONFIG_FSL_ERRATUM_A008585
+#ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
 		/*
 		 * Don't use the vdso fastpath if errata require using
 		 * the out-of-line counter accessor.
@@ -893,12 +911,15 @@ static int __init arch_timer_of_init(struct device_node *np)
 
 	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
 
-#ifdef CONFIG_FSL_ERRATUM_A008585
-	if (fsl_a008585_enable < 0)
-		fsl_a008585_enable = of_property_read_bool(np, "fsl,erratum-a008585");
-	if (fsl_a008585_enable) {
-		static_branch_enable(&arch_timer_read_ool_enabled);
-		pr_info("Enabling workaround for FSL erratum A-008585\n");
+#ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
+	for (i = 0; i < ARRAY_SIZE(ool_workarounds); i++) {
+		if (of_property_read_bool(np, ool_workarounds[i].id)) {
+			timer_unstable_counter_workaround = &ool_workarounds[i];
+			static_branch_enable(&arch_timer_read_ool_enabled);
+			pr_info("arch_timer: Enabling workaround for %s\n",
+				timer_unstable_counter_workaround->id);
+			break;
+		}
 	}
 #endif
 
-- 
1.9.0
