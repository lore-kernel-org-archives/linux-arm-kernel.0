From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 28 Aug 2018 16:51:30 +0100
Subject: [PATCH v5 20/27] irqchip/gic-v3: Switch to PMR masking after IRQ
 acknowledge
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1535471497-38854-21-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After an interrupt has been acknowledged, mask the IRQ priority through
PMR and clear PSR.I bit, allowing higher priority interrupts to be
received during interrupt handling.

Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arch_gicv3.h   | 6 ++++++
 arch/arm64/include/asm/arch_gicv3.h | 6 ++++++
 drivers/irqchip/irq-gic-v3.c        | 8 +++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index 58d5d3e..b39d620 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -368,5 +368,11 @@ static inline bool gic_prio_masking_enabled(void)
 	return false;
 }

+static inline void gic_start_pmr_masking(void)
+{
+	/* Should not get called */
+	WARN_ON(true);
+}
+
 #endif /* !__ASSEMBLY__ */
 #endif /* !__ASM_ARCH_GICV3_H */
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 19a5b1f..eb55da8 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -161,5 +161,11 @@ static inline bool gic_prio_masking_enabled(void)
 	       && cpus_have_const_cap(ARM64_HAS_IRQ_PRIO_MASKING);
 }

+static inline void gic_start_pmr_masking(void)
+{
+	gic_write_pmr(ICC_PMR_EL1_MASKED);
+	asm volatile ("msr daifclr, #2" : : : "memory");
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_ARCH_GICV3_H */
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index a467fcf..56d1fb9 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -350,12 +350,18 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs

 	irqnr = gic_read_iar();

+	if (gic_prio_masking_enabled()) {
+		isb();
+		/* Masking IRQs earlier would prevent to ack the current IRQ */
+		gic_start_pmr_masking();
+	}
+
 	if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
 		int err;

 		if (static_branch_likely(&supports_deactivate_key))
 			gic_write_eoir(irqnr);
-		else
+		else if (!gic_prio_masking_enabled())
 			isb();

 		err = handle_domain_irq(gic_data.domain, irqnr, regs);
--
1.9.1
