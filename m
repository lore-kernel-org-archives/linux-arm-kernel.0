From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Feb 2011 13:33:40 +0000
Subject: [PATCH 4/6] ARM: s5pv310: update IRQ combiner to use EOI in parent
	chip
In-Reply-To: <1298900022-21516-1-git-send-email-will.deacon@arm.com>
References: <1298900022-21516-1-git-send-email-will.deacon@arm.com>
Message-ID: <1298900022-21516-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IRQ combiner code invokes the ->irq_{un}mask routines of the parent
chip.

This patch updates the cascaded handler to use EOI now that the GIC has
moved to using the fasteoi flow model.

Tested-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-s5pv310/irq-combiner.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s5pv310/irq-combiner.c b/arch/arm/mach-s5pv310/irq-combiner.c
index 1ea4a9e..24d5604 100644
--- a/arch/arm/mach-s5pv310/irq-combiner.c
+++ b/arch/arm/mach-s5pv310/irq-combiner.c
@@ -59,9 +59,6 @@ static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 	unsigned int cascade_irq, combiner_irq;
 	unsigned long status;
 
-	/* primary controller ack'ing */
-	chip->irq_ack(&desc->irq_data);
-
 	spin_lock(&irq_controller_lock);
 	status = __raw_readl(chip_data->base + COMBINER_INT_STATUS);
 	spin_unlock(&irq_controller_lock);
@@ -79,8 +76,8 @@ static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 		generic_handle_irq(cascade_irq);
 
  out:
-	/* primary controller unmasking */
-	chip->irq_unmask(&desc->irq_data);
+	/* primary controller EOI */
+	chip->irq_eoi(&desc->irq_data);
 }
 
 static struct irq_chip combiner_chip = {
-- 
1.7.0.4
