From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 18 Mar 2015 14:20:24 +0000
Subject: [RFC PATCH 3/7] irqchip: gic-v3: Reset BPR during initialization
In-Reply-To: <1426688428-3150-1-git-send-email-daniel.thompson@linaro.org>
References: <1426688428-3150-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1426688428-3150-4-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, when running on FVP, CPU 0 boots up with its BPR changed from
the reset value. This renders it impossible to (preemptively) prioritize
interrupts on CPU 0.

This is harmless on normal systems but prevents preemption by NMIs on
systems with CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS enabled.

Many thanks to Andrew Thoelke for suggesting the BPR as having the
potential to harm preemption.

Suggested-by: Andrew Thoelke <andrew.thoelke@arm.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c       | 13 +++++++++++++
 include/linux/irqchip/arm-gic-v3.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index fd8850def1b8..32533650494c 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -120,6 +120,11 @@ static void __maybe_unused gic_write_pmr(u64 val)
 	asm volatile("msr_s " __stringify(ICC_PMR_EL1) ", %0" : : "r" (val));
 }
 
+static void __maybe_unused gic_write_bpr1(u64 val)
+{
+	asm volatile("msr_s " __stringify(ICC_BPR1_EL1) ", %0" : : "r" (val));
+}
+
 static void __maybe_unused gic_write_ctlr(u64 val)
 {
 	asm volatile("msr_s " __stringify(ICC_CTLR_EL1) ", %0" : : "r" (val));
@@ -383,6 +388,14 @@ static void gic_cpu_sys_reg_init(void)
 	/* Set priority mask register */
 	gic_write_pmr(DEFAULT_PMR_VALUE);
 
+	/*
+	 * On FVP, CPU 0 arrives in the kernel with its BPR changed from the
+	 * reset value (and the value is large enough to prevent pre-emptive
+	 * interrupts from working at all). Writing a zero to BPR restores the
+	 * reset value.
+	 */
+	gic_write_bpr1(0);
+
 	/* EOI deactivates interrupt too (mode 0) */
 	gic_write_ctlr(ICC_CTLR_EL1_EOImode_drop_dir);
 
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 781974afff9f..79d6645897e6 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -270,6 +270,8 @@
 #define ICH_VMCR_PMR_SHIFT		24
 #define ICH_VMCR_PMR_MASK		(0xffUL << ICH_VMCR_PMR_SHIFT)
 
+#define ICC_BPR0_EL1			sys_reg(3, 0, 12, 8, 3)
+#define ICC_BPR1_EL1			sys_reg(3, 0, 12, 12, 3)
 #define ICC_EOIR1_EL1			sys_reg(3, 0, 12, 12, 1)
 #define ICC_IAR1_EL1			sys_reg(3, 0, 12, 12, 0)
 #define ICC_SGI1R_EL1			sys_reg(3, 0, 12, 11, 5)
-- 
2.1.0
