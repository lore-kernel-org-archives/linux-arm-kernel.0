From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 12 Nov 2018 11:56:56 +0000
Subject: [PATCH v6 05/24] irqchip/gic-v3: Switch to PMR masking before calling
 IRQ handler
In-Reply-To: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1542023835-21446-6-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mask the IRQ priority through PMR and re-enable IRQs at CPU level,
allowing only higher priority interrupts to be received during interrupt
handling.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arch_gicv3.h   | 17 +++++++++++++++++
 arch/arm64/include/asm/arch_gicv3.h | 17 +++++++++++++++++
 drivers/irqchip/irq-gic-v3.c        | 10 ++++++++++
 3 files changed, 44 insertions(+)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index bef0b5d..f6f485f 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -363,5 +363,22 @@ static inline void gits_write_vpendbaser(u64 val, void * __iomem addr)
 
 #define gits_read_vpendbaser(c)		__gic_readq_nonatomic(c)
 
+static inline bool gic_prio_masking_enabled(void)
+{
+	return false;
+}
+
+static inline void gic_pmr_mask_irqs(void)
+{
+	/* Should not get called. */
+	WARN_ON_ONCE(true);
+}
+
+static inline void gic_arch_enable_irqs(void)
+{
+	/* Should not get called. */
+	WARN_ON_ONCE(true);
+}
+
 #endif /* !__ASSEMBLY__ */
 #endif /* !__ASM_ARCH_GICV3_H */
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 37193e2..3f8d5f4 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -155,5 +155,22 @@ static inline u32 gic_read_rpr(void)
 #define gits_write_vpendbaser(v, c)	writeq_relaxed(v, c)
 #define gits_read_vpendbaser(c)		readq_relaxed(c)
 
+static inline bool gic_prio_masking_enabled(void)
+{
+	return system_supports_irq_prio_masking();
+}
+
+static inline void gic_pmr_mask_irqs(void)
+{
+	/* Should not get called yet. */
+	WARN_ON_ONCE(true);
+}
+
+static inline void gic_arch_enable_irqs(void)
+{
+	/* Should not get called yet. */
+	WARN_ON_ONCE(true);
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_ARCH_GICV3_H */
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 8f87f40..e5d8c14 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -353,6 +353,11 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 	if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
 		int err;
 
+		if (gic_prio_masking_enabled()) {
+			gic_pmr_mask_irqs();
+			gic_arch_enable_irqs();
+		}
+
 		if (static_branch_likely(&supports_deactivate_key))
 			gic_write_eoir(irqnr);
 		else
@@ -371,6 +376,11 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 		return;
 	}
 	if (irqnr < 16) {
+		if (gic_prio_masking_enabled()) {
+			gic_pmr_mask_irqs();
+			gic_arch_enable_irqs();
+		}
+
 		gic_write_eoir(irqnr);
 		if (static_branch_likely(&supports_deactivate_key))
 			gic_write_dir(irqnr);
-- 
1.9.1
