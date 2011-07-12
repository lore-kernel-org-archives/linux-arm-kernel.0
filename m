From: toddpoynor@google.com (Todd Poynor)
Date: Tue, 12 Jul 2011 15:42:05 -0700
Subject: [PATCH 4/4] ARM: OMAP2+: Check NULL return from irq_alloc_generic_chip
Message-ID: <1310510525-4786-1-git-send-email-toddpoynor@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 arch/arm/mach-omap2/irq.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 3af2b7a..acbb05c 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -129,6 +129,13 @@ omap_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
 
 	gc = irq_alloc_generic_chip("INTC", 1, irq_start, base,
 					handle_level_irq);
+
+	if (!gc) {
+		pr_err("%s: irq_alloc_generic_chip for IRQ %u failed\n",
+		       __func__, irq_start);
+		return;
+	}
+
 	ct = gc->chip_types;
 	ct->chip.irq_ack = omap_mask_ack_irq;
 	ct->chip.irq_mask = irq_gc_mask_disable_reg;
-- 
1.7.3.1
