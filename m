From: dingtianhong@huawei.com (Ding Tianhong)
Date: Tue, 15 Nov 2016 20:16:03 +0800
Subject: [PATCH v4 2/6] arm64: arch_timer: Introduce a generic erratum handing
 mechanism for fsl-a008585
In-Reply-To: <1479212167-5812-1-git-send-email-dingtianhong@huawei.com>
References: <1479212167-5812-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <1479212167-5812-2-git-send-email-dingtianhong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The workaround for hisilicon,161601 will check the return value of the system counter
by different way, in order to distinguish with the fsl-a008585 workaround, introduce
a new generic erratum handing mechanism for fsl-a008585 and rename some functions.

v2: Introducing a new generic erratum handling mechanism for fsl erratum a008585.

v3: Introducing the erratum_workaround_set_sne generic function for fsl erratum a008585
    and make the #define __fsl_a008585_read_reg to be private to the .c file instead of
    being globally visible. After discussion with Marc and Will, a consensus decision was
    made to remove the commandline parameter for enabling fsl,erratum-a008585 erratum,
    and make some generic name more specific, export timer_unstable_counter_workaround
    for module access.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
---
 Documentation/kernel-parameters.txt  |  9 -----
 arch/arm64/include/asm/arch_timer.h  | 36 ++++++-----------
 drivers/clocksource/arm_arch_timer.c | 78 +++++++++++++++++++++---------------
 3 files changed, 58 insertions(+), 65 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 6fa1d8a..738de4e 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -698,15 +698,6 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
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
index eaa5bbe..f882c7c 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -31,39 +31,27 @@
 
 #if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585)
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
+	int erratum;		/* Indicate the Erratum ID */
+	u32 (*read_cntp_tval_el0)(void);
+	u32 (*read_cntv_tval_el0)(void);
+	u64 (*read_cntvct_el0)(void);
+};
+
+extern struct arch_timer_erratum_workaround *timer_unstable_counter_workaround;
 
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
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 73c487d..696386f 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -95,40 +95,53 @@ early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
  */
 
 #ifdef CONFIG_FSL_ERRATUM_A008585
-DEFINE_STATIC_KEY_FALSE(arch_timer_read_ool_enabled);
-EXPORT_SYMBOL_GPL(arch_timer_read_ool_enabled);
-
-static int fsl_a008585_enable = -1;
+struct arch_timer_erratum_workaround *timer_unstable_counter_workaround = NULL;
+EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
 
-static int __init early_fsl_a008585_cfg(char *buf)
-{
-	int ret;
-	bool val;
+#define        FSL_A008585	0x0001
 
-	ret = strtobool(buf, &val);
-	if (ret)
-		return ret;
-
-	fsl_a008585_enable = val;
-	return 0;
-}
-early_param("clocksource.arm_arch_timer.fsl-a008585", early_fsl_a008585_cfg);
+DEFINE_STATIC_KEY_FALSE(arch_timer_read_ool_enabled);
+EXPORT_SYMBOL_GPL(arch_timer_read_ool_enabled);
 
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
+static u32 fsl_a008585_read_cntp_tval_el0(void)
 {
 	return __fsl_a008585_read_reg(cntp_tval_el0);
 }
 
-u32 __fsl_a008585_read_cntv_tval_el0(void)
+static  u32 fsl_a008585_read_cntv_tval_el0(void)
 {
 	return __fsl_a008585_read_reg(cntv_tval_el0);
 }
 
-u64 __fsl_a008585_read_cntvct_el0(void)
+static u64 fsl_a008585_read_cntvct_el0(void)
 {
 	return __fsl_a008585_read_reg(cntvct_el0);
 }
-EXPORT_SYMBOL(__fsl_a008585_read_cntvct_el0);
+
+static struct arch_timer_erratum_workaround arch_timer_fsl_a008585 = {
+	.erratum = FSL_A008585,
+	.read_cntp_tval_el0 = fsl_a008585_read_cntp_tval_el0,
+	.read_cntv_tval_el0 = fsl_a008585_read_cntv_tval_el0,
+	.read_cntvct_el0 = fsl_a008585_read_cntvct_el0,
+};
 #endif /* CONFIG_FSL_ERRATUM_A008585 */
 
 static __always_inline
@@ -281,7 +294,7 @@ static __always_inline void set_next_event(const int access, unsigned long evt,
 }
 
 #ifdef CONFIG_FSL_ERRATUM_A008585
-static __always_inline void fsl_a008585_set_next_event(const int access,
+static __always_inline void erratum_set_next_event_generic(const int access,
 		unsigned long evt, struct clock_event_device *clk)
 {
 	unsigned long ctrl;
@@ -299,17 +312,17 @@ static __always_inline void fsl_a008585_set_next_event(const int access,
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
 #endif /* CONFIG_FSL_ERRATUM_A008585 */
@@ -342,16 +355,16 @@ static int arch_timer_set_next_event_phys_mem(unsigned long evt,
 	return 0;
 }
 
-static void fsl_a008585_set_sne(struct clock_event_device *clk)
+static void erratum_workaround_set_sne(struct clock_event_device *clk)
 {
 #ifdef CONFIG_FSL_ERRATUM_A008585
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
 
@@ -384,7 +397,7 @@ static void __arch_timer_setup(unsigned type,
 			BUG();
 		}
 
-		fsl_a008585_set_sne(clk);
+		erratum_workaround_set_sne(clk);
 	} else {
 		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
 		clk->name = "arch_mem_timer";
@@ -891,9 +904,10 @@ static int __init arch_timer_of_init(struct device_node *np)
 	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
 
 #ifdef CONFIG_FSL_ERRATUM_A008585
-	if (fsl_a008585_enable < 0)
-		fsl_a008585_enable = of_property_read_bool(np, "fsl,erratum-a008585");
-	if (fsl_a008585_enable) {
+	if (!timer_unstable_counter_workaround && of_property_read_bool(np, "fsl,erratum-a008585"))
+		timer_unstable_counter_workaround = &arch_timer_fsl_a008585;
+
+	if (timer_unstable_counter_workaround) {
 		static_branch_enable(&arch_timer_read_ool_enabled);
 		pr_info("Enabling workaround for FSL erratum A-008585\n");
 	}
-- 
1.9.0
