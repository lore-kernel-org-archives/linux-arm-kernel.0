From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 14 Sep 2015 14:26:15 +0100
Subject: [RFC PATCH v2 1/7] irqchip: gic-v3: Reset BPR during initialization
In-Reply-To: <1442237181-17064-1-git-send-email-daniel.thompson@linaro.org>
References: <1442237181-17064-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1442237181-17064-2-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, when running on FVP, CPU 0 boots up with its BPR changed from
the reset value. This renders it impossible to (preemptively) prioritize
interrupts on CPU 0.

This is harmless on normal systems since Linux typically does not
support preemptive interrupts. It does however cause problems in
systems with additional changes (such as patches for NMI simulation).

Many thanks to Andrew Thoelke for suggesting the BPR as having the
potential to harm preemption.

Suggested-by: Andrew Thoelke <andrew.thoelke@arm.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c       | 13 +++++++++++++
 include/linux/irqchip/arm-gic-v3.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 7deed6ef54c2..b47bd971038e 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -127,6 +127,11 @@ static void __maybe_unused gic_write_pmr(u64 val)
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
@@ -501,6 +506,14 @@ static void gic_cpu_sys_reg_init(void)
 	/* Set priority mask register */
 	gic_write_pmr(DEFAULT_PMR_VALUE);
 
+	/*
+	 * Some firmwares hand over to the kernel with the BPR changed from
+	 * its reset value (and with a value large enough to prevent
+	 * any pre-emptive interrupts from working at all). Writing a zero
+	 * to BPR restores is reset value.
+	 */
+	gic_write_bpr1(0);
+
 	if (static_key_true(&supports_deactivate)) {
 		/* EOI drops priority only (mode 1) */
 		gic_write_ctlr(ICC_CTLR_EL1_EOImode_drop);
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 9eeeb9589acf..60cc91749e7d 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -292,6 +292,8 @@
 #define ICH_VMCR_PMR_SHIFT		24
 #define ICH_VMCR_PMR_MASK		(0xffUL << ICH_VMCR_PMR_SHIFT)
 
+#define ICC_BPR0_EL1			sys_reg(3, 0, 12, 8, 3)
+#define ICC_BPR1_EL1			sys_reg(3, 0, 12, 12, 3)
 #define ICC_EOIR1_EL1			sys_reg(3, 0, 12, 12, 1)
 #define ICC_DIR_EL1			sys_reg(3, 0, 12, 11, 1)
 #define ICC_IAR1_EL1			sys_reg(3, 0, 12, 12, 0)
-- 
2.4.3
