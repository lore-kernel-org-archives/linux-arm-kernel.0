From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 19 Aug 2016 17:13:09 +0100
Subject: [RFC PATCH v3 1/7] irqchip: gic-v3: Reset BPR during initialization
In-Reply-To: <1471623195-7829-1-git-send-email-daniel.thompson@linaro.org>
References: <1471623195-7829-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1471623195-7829-2-git-send-email-daniel.thompson@linaro.org>
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
 arch/arm/include/asm/arch_gicv3.h   | 6 ++++++
 arch/arm64/include/asm/arch_gicv3.h | 6 ++++++
 drivers/irqchip/irq-gic-v3.c        | 8 ++++++++
 3 files changed, 20 insertions(+)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index e08d15184056..dfe4002812da 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -34,6 +34,7 @@
 #define ICC_CTLR			__ACCESS_CP15(c12, 0, c12, 4)
 #define ICC_SRE				__ACCESS_CP15(c12, 0, c12, 5)
 #define ICC_IGRPEN1			__ACCESS_CP15(c12, 0, c12, 7)
+#define ICC_BPR1			__ACCESS_CP15(c12, 0, c12, 3)
 
 #define ICC_HSRE			__ACCESS_CP15(c12, 4, c9, 5)
 
@@ -157,6 +158,11 @@ static inline void gic_write_sre(u32 val)
 	isb();
 }
 
+static inline void gic_write_bpr1(u32 val)
+{
+	asm volatile("mcr " __stringify(ICC_BPR1) : : "r" (val));
+}
+
 /*
  * Even in 32bit systems that use LPAE, there is no guarantee that the I/O
  * interface provides true 64bit atomic accesses, so using strd/ldrd doesn't
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 8ec88e5b290f..fc2a0cb47b2c 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -28,6 +28,7 @@
 #define ICC_CTLR_EL1			sys_reg(3, 0, 12, 12, 4)
 #define ICC_SRE_EL1			sys_reg(3, 0, 12, 12, 5)
 #define ICC_GRPEN1_EL1			sys_reg(3, 0, 12, 12, 7)
+#define ICC_BPR1_EL1			sys_reg(3, 0, 12, 12, 3)
 
 #define ICC_SRE_EL2			sys_reg(3, 4, 12, 9, 5)
 
@@ -165,6 +166,11 @@ static inline void gic_write_sre(u32 val)
 	isb();
 }
 
+static inline void gic_write_bpr1(u32 val)
+{
+	asm volatile("msr_s " __stringify(ICC_BPR1_EL1) ", %0" : : "r" (val));
+}
+
 #define gic_read_typer(c)		readq_relaxed(c)
 #define gic_write_irouter(v, c)		writeq_relaxed(v, c)
 
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 6fc56c3466b0..fedcdd09b9b2 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -495,6 +495,14 @@ static void gic_cpu_sys_reg_init(void)
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
-- 
2.7.4
