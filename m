From: oss@buserror.net (Scott Wood)
Date: Thu, 22 Sep 2016 03:35:17 -0500
Subject: [PATCH v6 3/4] arm64: arch_timer: Work around QorIQ Erratum A-008585
In-Reply-To: <1474533318-7796-1-git-send-email-oss@buserror.net>
References: <1474533318-7796-1-git-send-email-oss@buserror.net>
Message-ID: <1474533318-7796-3-git-send-email-oss@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Erratum A-008585 says that the ARM generic timer counter "has the
potential to contain an erroneous value for a small number of core
clock cycles every time the timer value changes".  Accesses to TVAL
(both read and write) are also affected due to the implicit counter
read.  Accesses to CVAL are not affected.

The workaround is to reread TVAL and count registers until successive
reads return the same value.  Writes to TVAL are replaced with an
equivalent write to CVAL.

The workaround is to reread TVAL and count registers until successive reads
return the same value, and when writing TVAL to retry until counter
reads before and after the write return the same value.

The workaround is enabled if the fsl,erratum-a008585 property is found in
the timer node in the device tree.  This can be overridden with the
clocksource.arm_arch_timer.fsl-a008585 boot parameter, which allows KVM
users to enable the workaround until a mechanism is implemented to
automatically communicate this information.

This erratum can be found on LS1043A and LS2080A.

Signed-off-by: Scott Wood <oss@buserror.net>
---
v6:
- Addressed feedback from Mark Rutland

v5:
- Export arch_timer_read_ool_enabled so that get_cycles() can be called
  from modules.

v4:
- Undef ARCH_TIMER_REG_READ after use

v3:
- Used cval rather than a loop for the write side of the erratum
- Added a Kconfig control
- Moved the device tree binding into its own patch
- Added erratum to silicon-errata.txt
- Changed function names to contain the erratum name
- Factored out the setting of erratum versions of set_next_event
  to improve readability
- Added a comment clarifying that the timeout is arbitrary

v2:
Significant rework based on feedback, including using static_key,
disabling VDSO counter access rather than adding the workaround to the
VDSO, and uninlining the loops.

Dropped the separate property for indicating that writes to TVAL are
affected, as I believe that's just a side effect of the implicit
counter read being corrupted, and thus a chip that is affected by one
will always be affected by the other.

Dropped the arm32 portion as it seems there was confusion about whether
LS1021A is affected.  Currently I am being told that it is not
affected.

I considered writing to CVAL rather than looping on TVAL writes, but
that would still have required separate set_next_event() code for the
erratum, and adding CVAL to the enum would have required a bunch of
extra handlers in switch statements (even where unused, due to compiler
warnings about unhandled enum values) including in an arm32 header.  It
seemed better to avoid the arm32 interaction and new untested
accessors.

Signed-off-by: Scott Wood <oss@buserror.net>
---
 Documentation/arm64/silicon-errata.txt |   2 +
 Documentation/kernel-parameters.txt    |   9 +++
 arch/arm64/include/asm/arch_timer.h    |  47 ++++++++++++++-
 drivers/clocksource/Kconfig            |  10 ++++
 drivers/clocksource/arm_arch_timer.c   | 104 +++++++++++++++++++++++++++++++++
 5 files changed, 169 insertions(+), 3 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 4da60b4..041e3a9 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -60,3 +60,5 @@ stable kernels.
 | Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154    |
 | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456    |
 | Cavium         | ThunderX SMMUv2 | #27704          | N/A		       |
+|                |                 |                 |                         |
+| Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585     |
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 46c030a..fb4de4d 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -698,6 +698,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			loops can be debugged more effectively on production
 			systems.
 
+	clocksource.arm_arch_timer.fsl-a008585=
+			[ARM64]
+			Format: <bool>
+			Enable/disable the workaround of Freescale/NXP
+			erratum A-008585.  This can be useful for KVM
+			guests, if the guest device tree doesn't show the
+			erratum.  If unspecified, the workaround is
+			enabled based on the device tree.
+
 	clearcpuid=BITNUM [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 7ff386c..cddd5b7 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -24,10 +24,51 @@
 
 #include <linux/bug.h>
 #include <linux/init.h>
+#include <linux/jump_label.h>
 #include <linux/types.h>
 
 #include <clocksource/arm_arch_timer.h>
 
+#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585)
+extern struct static_key_false arch_timer_read_ool_enabled;
+#define needs_fsl_a008585_workaround() \
+	static_branch_unlikely(&arch_timer_read_ool_enabled)
+#else
+#define needs_fsl_a008585_workaround()  false
+#endif
+
+u32 __fsl_a008585_read_cntp_tval_el0(void);
+u32 __fsl_a008585_read_cntv_tval_el0(void);
+u64 __fsl_a008585_read_cntvct_el0(void);
+
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
+#define arch_timer_unstable_reg_read(reg) 		\
+({							\
+	u64 _val;					\
+	if (needs_fsl_a008585_workaround())		\
+		_val = __fsl_a008585_read_##reg();	\
+	else						\
+		_val = read_sysreg(reg);		\
+	_val;						\
+})
+
 /*
  * These register accessors are marked inline so the compiler can
  * nicely work out which register we want, and chuck away the rest of
@@ -67,14 +108,14 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
 		case ARCH_TIMER_REG_CTRL:
 			return read_sysreg(cntp_ctl_el0);
 		case ARCH_TIMER_REG_TVAL:
-			return read_sysreg(cntp_tval_el0);
+			return arch_timer_unstable_reg_read(cntp_tval_el0);
 		}
 	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
 			return read_sysreg(cntv_ctl_el0);
 		case ARCH_TIMER_REG_TVAL:
-			return read_sysreg(cntv_tval_el0);
+			return arch_timer_unstable_reg_read(cntv_tval_el0);
 		}
 	}
 
@@ -108,7 +149,7 @@ static inline u64 arch_counter_get_cntpct(void)
 static inline u64 arch_counter_get_cntvct(void)
 {
 	isb();
-	return read_sysreg(cntvct_el0);
+	return arch_timer_unstable_reg_read(cntvct_el0);
 }
 
 static inline int arch_timer_arch_init(void)
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5677886..8a753fd 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -305,6 +305,16 @@ config ARM_ARCH_TIMER_EVTSTREAM
 	  This must be disabled for hardware validation purposes to detect any
 	  hardware anomalies of missing events.
 
+config FSL_ERRATUM_A008585
+	bool "Workaround for Freescale/NXP Erratum A-008585"
+	default y
+	depends on ARM_ARCH_TIMER && ARM64
+	help
+	  This option enables a workaround for Freescale/NXP Erratum
+	  A-008585 ("ARM generic timer may contain an erroneous
+	  value").  The workaround will only be active if the
+	  fsl,erratum-a008585 property is found in the timer node.
+
 config ARM_GLOBAL_TIMER
 	bool "Support for the ARM global timer" if COMPILE_TEST
 	select CLKSRC_OF if OF
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 5770054..eb5fb41 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -94,6 +94,43 @@ early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
  * Architected system timer support.
  */
 
+#ifdef CONFIG_FSL_ERRATUM_A008585
+DEFINE_STATIC_KEY_FALSE(arch_timer_read_ool_enabled);
+EXPORT_SYMBOL_GPL(arch_timer_read_ool_enabled);
+
+static int fsl_a008585_enable = -1;
+
+static int __init early_fsl_a008585_cfg(char *buf)
+{
+	int ret;
+	bool val;
+
+	ret = strtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	fsl_a008585_enable = val;
+	return 0;
+}
+early_param("clocksource.arm_arch_timer.fsl-a008585", early_fsl_a008585_cfg);
+
+u32 __fsl_a008585_read_cntp_tval_el0(void)
+{
+	return __fsl_a008585_read_reg(cntp_tval_el0);
+}
+
+u32 __fsl_a008585_read_cntv_tval_el0(void)
+{
+	return __fsl_a008585_read_reg(cntv_tval_el0);
+}
+
+u64 __fsl_a008585_read_cntvct_el0(void)
+{
+	return __fsl_a008585_read_reg(cntvct_el0);
+}
+EXPORT_SYMBOL(__fsl_a008585_read_cntvct_el0);
+#endif /* CONFIG_FSL_ERRATUM_A008585 */
+
 static __always_inline
 void arch_timer_reg_write(int access, enum arch_timer_reg reg, u32 val,
 			  struct clock_event_device *clk)
@@ -243,6 +280,40 @@ static __always_inline void set_next_event(const int access, unsigned long evt,
 	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
 }
 
+#ifdef CONFIG_FSL_ERRATUM_A008585
+static __always_inline void fsl_a008585_set_next_event(const int access,
+		unsigned long evt, struct clock_event_device *clk)
+{
+	unsigned long ctrl;
+	u64 cval = evt + arch_counter_get_cntvct();
+
+	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
+	ctrl |= ARCH_TIMER_CTRL_ENABLE;
+	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
+
+	if (access == ARCH_TIMER_PHYS_ACCESS)
+		write_sysreg(cval, cntp_cval_el0);
+	else if (access == ARCH_TIMER_VIRT_ACCESS)
+		write_sysreg(cval, cntv_cval_el0);
+
+	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
+}
+
+static int fsl_a008585_set_next_event_virt(unsigned long evt,
+					   struct clock_event_device *clk)
+{
+	fsl_a008585_set_next_event(ARCH_TIMER_VIRT_ACCESS, evt, clk);
+	return 0;
+}
+
+static int fsl_a008585_set_next_event_phys(unsigned long evt,
+					   struct clock_event_device *clk)
+{
+	fsl_a008585_set_next_event(ARCH_TIMER_PHYS_ACCESS, evt, clk);
+	return 0;
+}
+#endif /* CONFIG_FSL_ERRATUM_A008585 */
+
 static int arch_timer_set_next_event_virt(unsigned long evt,
 					  struct clock_event_device *clk)
 {
@@ -271,6 +342,19 @@ static int arch_timer_set_next_event_phys_mem(unsigned long evt,
 	return 0;
 }
 
+static void fsl_a008585_set_sne(struct clock_event_device *clk)
+{
+#ifdef CONFIG_FSL_ERRATUM_A008585
+	if (!static_branch_unlikely(&arch_timer_read_ool_enabled))
+		return;
+
+	if (arch_timer_uses_ppi == VIRT_PPI)
+		clk->set_next_event = fsl_a008585_set_next_event_virt;
+	else
+		clk->set_next_event = fsl_a008585_set_next_event_phys;
+#endif
+}
+
 static void __arch_timer_setup(unsigned type,
 			       struct clock_event_device *clk)
 {
@@ -299,6 +383,8 @@ static void __arch_timer_setup(unsigned type,
 		default:
 			BUG();
 		}
+
+		fsl_a008585_set_sne(clk);
 	} else {
 		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
 		clk->name = "arch_mem_timer";
@@ -515,6 +601,15 @@ static void __init arch_counter_register(unsigned type)
 			arch_timer_read_counter = arch_counter_get_cntvct;
 		else
 			arch_timer_read_counter = arch_counter_get_cntpct;
+
+#ifdef CONFIG_FSL_ERRATUM_A008585
+		/*
+		 * Don't use the vdso fastpath if errata require using
+		 * the out-of-line counter accessor.
+		 */
+		if (static_branch_unlikely(&arch_timer_read_ool_enabled))
+			clocksource_counter.name = "arch_sys_counter_ool";
+#endif
 	} else {
 		arch_timer_read_counter = arch_counter_get_cntvct_mem;
 
@@ -800,6 +895,15 @@ static int __init arch_timer_of_init(struct device_node *np)
 
 	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
 
+#ifdef CONFIG_FSL_ERRATUM_A008585
+	if (fsl_a008585_enable < 0)
+		fsl_a008585_enable = of_property_read_bool(np, "fsl,erratum-a008585");
+	if (fsl_a008585_enable) {
+		static_branch_enable(&arch_timer_read_ool_enabled);
+		pr_info("Enabling workaround for FSL erratum A-008585\n");
+	}
+#endif
+
 	/*
 	 * If we cannot rely on firmware initializing the timer registers then
 	 * we should use the physical timers instead.
-- 
2.7.4
