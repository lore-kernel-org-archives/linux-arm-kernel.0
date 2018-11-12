From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 12 Nov 2018 11:57:09 +0000
Subject: [PATCH v6 18/24] irqchip/gic-v3: Handle pseudo-NMIs
In-Reply-To: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1542023835-21446-19-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a higher priority to be used for pseudo-NMIs. When such an
interrupt is received, keep interrupts fully disabled at CPU level to
prevent receiving other pseudo-NMIs while handling the current one.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 5245791..c763f1a 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -41,6 +41,8 @@
 
 #include "irq-gic-common.h"
 
+#define GICD_INT_NMI_PRI		0xa0
+
 struct redist_region {
 	void __iomem		*redist_base;
 	phys_addr_t		phys_base;
@@ -375,6 +377,16 @@ static u64 gic_mpidr_to_affinity(unsigned long mpidr)
 	return aff;
 }
 
+static inline void gic_deactivate_unexpected_irq(u32 irqnr)
+{
+	if (static_branch_likely(&supports_deactivate_key)) {
+		if (irqnr < 8192)
+			gic_write_dir(irqnr);
+	} else {
+		gic_write_eoir(irqnr);
+	}
+}
+
 static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqnr;
@@ -384,6 +396,22 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 	if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
 		int err;
 
+		if (gic_supports_nmi() &&
+		    unlikely(gic_read_rpr() == GICD_INT_NMI_PRI)) {
+			if (static_branch_likely(&supports_deactivate_key))
+				gic_write_eoir(irqnr);
+			/*
+			 * Leave the PSR.I bit set to prevent other NMIs to be
+			 * received while handling this one.
+			 * PSR.I will be restored when we ERET to the
+			 * interrupted context.
+			 */
+			err = handle_domain_nmi(gic_data.domain, irqnr, regs);
+			if (err)
+				gic_deactivate_unexpected_irq(irqnr);
+			return;
+		}
+
 		if (gic_prio_masking_enabled()) {
 			gic_pmr_mask_irqs();
 			gic_arch_enable_irqs();
@@ -397,12 +425,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 		err = handle_domain_irq(gic_data.domain, irqnr, regs);
 		if (err) {
 			WARN_ONCE(true, "Unexpected interrupt received!\n");
-			if (static_branch_likely(&supports_deactivate_key)) {
-				if (irqnr < 8192)
-					gic_write_dir(irqnr);
-			} else {
-				gic_write_eoir(irqnr);
-			}
+			gic_deactivate_unexpected_irq(irqnr);
 		}
 		return;
 	}
-- 
1.9.1
