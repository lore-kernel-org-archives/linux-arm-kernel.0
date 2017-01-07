From: dingtianhong@huawei.com (Ding Tianhong)
Date: Sat, 7 Jan 2017 15:07:37 +0800
Subject: [PATCH v7 3/4] arm64: arch_timer: Work around Erratum Hisilicon-161601
In-Reply-To: <1483772858-10380-1-git-send-email-dingtianhong@huawei.com>
References: <1483772858-10380-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <1483772858-10380-4-git-send-email-dingtianhong@huawei.com>
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

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
---
 Documentation/arm64/silicon-errata.txt |  1 +
 drivers/clocksource/Kconfig            | 12 ++++++++-
 drivers/clocksource/arm_arch_timer.c   | 49 ++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 405da11..1c1a95f 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -63,3 +63,4 @@ stable kernels.
 | Cavium         | ThunderX SMMUv2 | #27704          | N/A		       |
 |                |                 |                 |                         |
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585     |
+| Hisilicon      | Hip0{5,6,7}     | #161601         | HISILICON_ERRATUM_161601|
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 97f95f8..c0eabed 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -327,7 +327,7 @@ config ARM_ARCH_TIMER_EVTSTREAM
 
 config ARM_ARCH_TIMER_OOL_WORKAROUND
 	bool "Workaround for arm arch timer unstable counter"
-	depends on FSL_ERRATUM_A008585
+	depends on FSL_ERRATUM_A008585 || HISILICON_ERRATUM_161601
 	help
 	  This option would only be enabled by Freescale/NXP Erratum A-008585
 	  or something else chip has similar erratum.
@@ -343,6 +343,16 @@ config FSL_ERRATUM_A008585
 	  value").  The workaround will only be active if the
 	  fsl,erratum-a008585 property is found in the timer node.
 
+config HISILICON_ERRATUM_161601
+	bool "Workaround for Hisilicon Erratum 161601"
+	default y
+	select ARM_ARCH_TIMER_OOL_WORKAROUND
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
index 2487c66..ef09e59f 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -131,6 +131,47 @@ static u64 notrace fsl_a008585_read_cntvct_el0(void)
 }
 #endif
 
+#ifdef CONFIG_HISILICON_ERRATUM_161601
+/*
+ * Verify whether the value of the second read is larger than the first by
+ * less than 32 is the only way to confirm the value is correct, so clear the
+ * lower 5 bits to check whether the difference is greater than 32 or not.
+ * Theoretically the erratum should not occur more than twice in succession
+ * when reading the system counter, but it is possible that some interrupts
+ * may lead to more than twice read errors, triggering the warning, so setting
+ * the number of retries far beyond the number of iterations the loop has been
+ * observed to take.
+ */
+#define __hisi_161601_read_reg(reg) ({				\
+	u64 _old, _new;						\
+	int _retries = 50;					\
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
+static u32 notrace hisi_161601_read_cntp_tval_el0(void)
+{
+	return __hisi_161601_read_reg(cntp_tval_el0);
+}
+
+static u32 notrace hisi_161601_read_cntv_tval_el0(void)
+{
+	return __hisi_161601_read_reg(cntv_tval_el0);
+}
+
+static u64 notrace hisi_161601_read_cntvct_el0(void)
+{
+	return __hisi_161601_read_reg(cntvct_el0);
+}
+#endif
+
 #ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
 const struct arch_timer_erratum_workaround *timer_unstable_counter_workaround = NULL;
 EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
@@ -147,6 +188,14 @@ static u64 notrace fsl_a008585_read_cntvct_el0(void)
 		.read_cntvct_el0 = fsl_a008585_read_cntvct_el0,
 	},
 #endif
+#ifdef CONFIG_HISILICON_ERRATUM_161601
+	{
+		.id = "hisilicon,erratum-161601",
+		.read_cntp_tval_el0 = hisi_161601_read_cntp_tval_el0,
+		.read_cntv_tval_el0 = hisi_161601_read_cntv_tval_el0,
+		.read_cntvct_el0 = hisi_161601_read_cntvct_el0,
+	},
+#endif
 };
 #endif /* CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND */
 
-- 
1.9.0
