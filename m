From: dingtianhong@huawei.com (Ding Tianhong)
Date: Sun, 23 Oct 2016 11:21:15 +0800
Subject: [PATCH 2/3] arm64: arch_timer: Work around QorIQ Erratum
 Hisilicon-161x01
Message-ID: <07862fac-b32a-9246-c01f-fc3e55635f54@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Erratum Hisilicon-161x01 says that the ARM generic timer counter "has the
potential to contain an erroneous value when the timer value changes".
Accesses to TVAL (both read and write) are also affected due to the implicit counter
read.  Accesses to CVAL are not affected.

The workaround is to reread TVAL and count registers until successive
reads return the limited range value (32) by back-to-back reads.  Writes to TVAL are
replaced with an equivalent write to CVAL.

The workaround is enabled if the hisilicon,erratum-161x01 property is found in
the timer node in the device tree.  This can be overridden with the
clocksource.arm_arch_timer.hisilicon-161x01 boot parameter, which allows KVM
users to enable the workaround until a mechanism is implemented to
automatically communicate this information.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
---
 Documentation/arm64/silicon-errata.txt |   1 +
 Documentation/kernel-parameters.txt    |   9 ++
 arch/arm64/include/asm/arch_timer.h    |  41 +++++++--
 drivers/clocksource/Kconfig            |  14 ++-
 drivers/clocksource/arm_arch_timer.c   | 153 +++++++++++++++++++++++++++------
 5 files changed, 182 insertions(+), 36 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 405da11..3a79803 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -63,3 +63,4 @@ stable kernels.
 | Cavium         | ThunderX SMMUv2 | #27704          | N/A		       |
 |                |                 |                 |                         |
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585     |
+| Hisilicon	 | Hip05/Hip06/Hip07 | #161x01	     | HISILICON_ERRATUM_161x01|
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 6fa1d8a..175f349 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -707,6 +707,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			erratum.  If unspecified, the workaround is
 			enabled based on the device tree.

+	clocksource.arm_arch_timer.hisilicon-161x01=
+			[ARM64]
+			Format: <bool>
+			Enable/disable the workaround of Hisilicon
+			erratum 161x01.  This can be useful for KVM
+			guests, if the guest device tree doesn't show the
+			erratum.  If unspecified, the workaround is
+			enabled based on the device tree.
+
 	clearcpuid=BITNUM [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index eaa5bbe..6b510db 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -29,17 +29,24 @@

 #include <clocksource/arm_arch_timer.h>

-#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585)
+#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585) || IS_ENABLED(CONFIG_HISILICON_ERRATUM_161X01)
 extern struct static_key_false arch_timer_read_ool_enabled;
-#define needs_fsl_a008585_workaround() \
+extern struct arch_timer_erratum_workaround *erratum_workaround;
+#define needs_timer_erratum_workaround() \
 	static_branch_unlikely(&arch_timer_read_ool_enabled)
 #else
-#define needs_fsl_a008585_workaround()  false
+#define needs_timer_erratum_workaround()  false
 #endif

-u32 __fsl_a008585_read_cntp_tval_el0(void);
-u32 __fsl_a008585_read_cntv_tval_el0(void);
-u64 __fsl_a008585_read_cntvct_el0(void);
+struct clock_event_device;
+
+struct arch_timer_erratum_workaround {
+	int erratum;
+	u32 (*read_cntp_tval_el0)(void);
+	u32 (*read_cntv_tval_el0)(void);
+	u64 (*read_cntvct_el0)(void);
+};
+extern struct arch_timer_erratum_workaround *erratum_workaround;

 /*
  * The number of retries is an arbitrary value well beyond the highest number
@@ -59,16 +66,34 @@ u64 __fsl_a008585_read_cntvct_el0(void);
 	_new;						\
 })

+#define __hisi_161x01_read_reg(reg) ({			\
+	u64 _old, _new;					\
+	int _retries = 200;				\
+							\
+	do {						\
+		_old = read_sysreg(reg);		\
+		_new = read_sysreg(reg);		\
+		_retries--;				\
+	} while (unlikely((_new - _old) >> 5) && _retries);	\
+							\
+	WARN_ON_ONCE(!_retries);			\
+	_new;						\
+})
+
+
+
 #define arch_timer_reg_read_stable(reg) 		\
 ({							\
 	u64 _val;					\
-	if (needs_fsl_a008585_workaround())		\
-		_val = __fsl_a008585_read_##reg();	\
+	if (needs_timer_erratum_workaround())		\
+		_val = erratum_workaround->read_##reg();	\
 	else						\
 		_val = read_sysreg(reg);		\
 	_val;						\
 })

+
+
 /*
  * These register accessors are marked inline so the compiler can
  * nicely work out which register we want, and chuck away the rest of
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 8a753fd..fcfcdc7 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -312,8 +312,20 @@ config FSL_ERRATUM_A008585
 	help
 	  This option enables a workaround for Freescale/NXP Erratum
 	  A-008585 ("ARM generic timer may contain an erroneous
-	  value").  The workaround will only be active if the
+	  value").  The workaround will be active if the
 	  fsl,erratum-a008585 property is found in the timer node.
+	  This can be overridden with the clocksource.arm_arch_timer.fsl-a008585
+	  boot parameter.
+
+config HISILICON_ERRATUM_161X01
+	bool "Workaround for Hisilicon Erratum 161201"
+	default y
+	depends on ARM_ARCH_TIMER && ARM64
+	help
+	  This option enables a workaround for Hisilicon Erratum
+	  161201. The workaround will be active if the hisi,erratum-161201
+	  property is found in the timer node. This can be overridden with
+	  the clocksource.arm_arch_timer.hisi-161201 boot parameter.

 config ARM_GLOBAL_TIMER
 	bool "Support for the ARM global timer" if COMPILE_TEST
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 73c487d..e1cf0ad 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -90,16 +90,23 @@ static int __init early_evtstrm_cfg(char *buf)
 }
 early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);

-/*
- * Architected system timer support.
- */
+#define 	FSL_A008585		1
+#define 	HISILICON_161X01	2
+
+struct arch_timer_erratum_workaround *erratum_workaround;
+
+#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585) || IS_ENABLED(CONFIG_HISILICON_ERRATUM_161X01)
+static int arch_timer_uses_erratum = 0;

-#ifdef CONFIG_FSL_ERRATUM_A008585
 DEFINE_STATIC_KEY_FALSE(arch_timer_read_ool_enabled);
 EXPORT_SYMBOL_GPL(arch_timer_read_ool_enabled);
+#endif

-static int fsl_a008585_enable = -1;
+/*
+ * Architected system timer support.
+ */

+#ifdef CONFIG_FSL_ERRATUM_A008585
 static int __init early_fsl_a008585_cfg(char *buf)
 {
 	int ret;
@@ -109,28 +116,96 @@ static int __init early_fsl_a008585_cfg(char *buf)
 	if (ret)
 		return ret;

-	fsl_a008585_enable = val;
+	if (val)
+		arch_timer_uses_erratum = FSL_A008585;
+
 	return 0;
 }
 early_param("clocksource.arm_arch_timer.fsl-a008585", early_fsl_a008585_cfg);

-u32 __fsl_a008585_read_cntp_tval_el0(void)
+u32 fsl_a008585_read_cntp_tval_el0(void)
 {
 	return __fsl_a008585_read_reg(cntp_tval_el0);
 }

-u32 __fsl_a008585_read_cntv_tval_el0(void)
+u32 fsl_a008585_read_cntv_tval_el0(void)
 {
 	return __fsl_a008585_read_reg(cntv_tval_el0);
 }

-u64 __fsl_a008585_read_cntvct_el0(void)
+u64 fsl_a008585_read_cntvct_el0(void)
 {
 	return __fsl_a008585_read_reg(cntvct_el0);
 }
-EXPORT_SYMBOL(__fsl_a008585_read_cntvct_el0);
+EXPORT_SYMBOL(fsl_a008585_read_cntvct_el0);
+#else
+u32 fsl_a008585_read_cntp_tval_el0(void)
+{
+	return 0;
+}
+
+u32 fsl_a008585_read_cntv_tval_el0(void)
+{
+	return 0;
+}
+
+u64 fsl_a008585_read_cntvct_el0(void)
+{
+	return 0;
+}
+EXPORT_SYMBOL(fsl_a008585_read_cntvct_el0);
 #endif /* CONFIG_FSL_ERRATUM_A008585 */

+#ifdef CONFIG_HISILICON_ERRATUM_161X01
+static int __init early_hisi_161x01_cfg(char *buf)
+{
+	int ret;
+	bool val;
+
+	ret = strtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	if (val)
+		arch_timer_uses_erratum = HISILICON_161X01;
+
+	return 0;
+}
+early_param("clocksource.arm_arch_timer.hisilicon-161x01", early_hisi_161x01_cfg);
+
+u32 hisi_161x01_read_cntp_tval_el0(void)
+{
+	return __hisi_161x01_read_reg(cntp_tval_el0);
+}
+
+u32 hisi_161x01_read_cntv_tval_el0(void)
+{
+	return __hisi_161x01_read_reg(cntv_tval_el0);
+}
+
+u64 hisi_161x01_read_cntvct_el0(void)
+{
+	return __hisi_161x01_read_reg(cntvct_el0);
+}
+EXPORT_SYMBOL(hisi_161x01_read_cntvct_el0);
+#else
+u32 hisi_161x01_read_cntp_tval_el0(void)
+{
+	return 0;
+}
+
+u32 hisi_161x01_read_cntv_tval_el0(void)
+{
+	return 0;
+}
+
+u64 hisi_161x01_read_cntvct_el0(void)
+{
+	return 0;
+}
+EXPORT_SYMBOL(hisi_161x01_read_cntvct_el0);
+#endif
+
 static __always_inline
 void arch_timer_reg_write(int access, enum arch_timer_reg reg, u32 val,
 			  struct clock_event_device *clk)
@@ -280,8 +355,8 @@ static __always_inline void set_next_event(const int access, unsigned long evt,
 	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
 }

-#ifdef CONFIG_FSL_ERRATUM_A008585
-static __always_inline void fsl_a008585_set_next_event(const int access,
+#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585) || IS_ENABLED(CONFIG_HISILICON_ERRATUM_161X01)
+static __always_inline void erratum_set_next_event(const int access,
 		unsigned long evt, struct clock_event_device *clk)
 {
 	unsigned long ctrl;
@@ -299,20 +374,35 @@ static __always_inline void fsl_a008585_set_next_event(const int access,
 	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
 }

-static int fsl_a008585_set_next_event_virt(unsigned long evt,
+static int erratum_set_next_event_virt(unsigned long evt,
 					   struct clock_event_device *clk)
 {
-	fsl_a008585_set_next_event(ARCH_TIMER_VIRT_ACCESS, evt, clk);
+	erratum_set_next_event(ARCH_TIMER_VIRT_ACCESS, evt, clk);
 	return 0;
 }

-static int fsl_a008585_set_next_event_phys(unsigned long evt,
+static int erratum_set_next_event_phys(unsigned long evt,
 					   struct clock_event_device *clk)
 {
-	fsl_a008585_set_next_event(ARCH_TIMER_PHYS_ACCESS, evt, clk);
+	erratum_set_next_event(ARCH_TIMER_PHYS_ACCESS, evt, clk);
 	return 0;
 }
-#endif /* CONFIG_FSL_ERRATUM_A008585 */
+#endif /* CONFIG_FSL_ERRATUM_A008585 || CONFIG_HISILICON_ERRATUM_161X01 */
+
+#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585) || IS_ENABLED(CONFIG_HISILICON_ERRATUM_161X01)
+static struct arch_timer_erratum_workaround arch_timer_erratum[] = {
+{
+	.erratum = FSL_A008585,
+	.read_cntp_tval_el0 = fsl_a008585_read_cntp_tval_el0,
+	.read_cntv_tval_el0 = fsl_a008585_read_cntv_tval_el0,
+	.read_cntvct_el0 = fsl_a008585_read_cntvct_el0,
+},{
+	.erratum = HISILICON_161X01,
+	.read_cntp_tval_el0 = hisi_161x01_read_cntp_tval_el0,
+	.read_cntv_tval_el0 = hisi_161x01_read_cntv_tval_el0,
+	.read_cntvct_el0 = hisi_161x01_read_cntvct_el0,
+} };
+#endif

 static int arch_timer_set_next_event_virt(unsigned long evt,
 					  struct clock_event_device *clk)
@@ -342,16 +432,16 @@ static int arch_timer_set_next_event_phys_mem(unsigned long evt,
 	return 0;
 }

-static void fsl_a008585_set_sne(struct clock_event_device *clk)
+static void erratum_set_sne(struct clock_event_device *clk)
 {
-#ifdef CONFIG_FSL_ERRATUM_A008585
+#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585) || IS_ENABLED(CONFIG_HISILICON_ERRATUM_161X01)
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

@@ -384,7 +474,7 @@ static void __arch_timer_setup(unsigned type,
 			BUG();
 		}

-		fsl_a008585_set_sne(clk);
+		erratum_set_sne(clk);
 	} else {
 		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
 		clk->name = "arch_mem_timer";
@@ -890,12 +980,21 @@ static int __init arch_timer_of_init(struct device_node *np)

 	arch_timer_c3stop = !of_property_read_bool(np, "always-on");

-#ifdef CONFIG_FSL_ERRATUM_A008585
-	if (fsl_a008585_enable < 0)
-		fsl_a008585_enable = of_property_read_bool(np, "fsl,erratum-a008585");
-	if (fsl_a008585_enable) {
+#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585) || IS_ENABLED(CONFIG_HISILICON_ERRATUM_161X01)
+	if (!arch_timer_uses_erratum) {
+		if (IS_ENABLED(CONFIG_FSL_ERRATUM_A008585) &&
+		    of_property_read_bool(np, "fsl,erratum-a008585"))
+			arch_timer_uses_erratum = FSL_A008585;
+		else if (IS_ENABLED(CONFIG_HISI_ERRATUM_161X01) &&
+			 of_property_read_bool(np, "hisilicon,erratum-161x01"))
+			arch_timer_uses_erratum = HISILICON_161X01;
+	}
+
+	if (arch_timer_uses_erratum) {
+		erratum_workaround = &arch_timer_erratum[arch_timer_uses_erratum - 1];
+		pr_info("Enabling workaround for %s\n", arch_timer_uses_erratum == FSL_A008585 ?
+			"FSL erratum A-008585" : "HISILICON ERRATUM 161x01");
 		static_branch_enable(&arch_timer_read_ool_enabled);
-		pr_info("Enabling workaround for FSL erratum A-008585\n");
 	}
 #endif

-- 
1.9.0
