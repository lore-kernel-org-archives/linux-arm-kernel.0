From: will.deacon@arm.com (Will Deacon)
Date: Fri,  1 Apr 2011 15:50:38 +0100
Subject: [PATCH 3/6] ARM: s5pv310: update IRQ combiner to use chained
	entry/exit functions
In-Reply-To: <1301669441-13744-1-git-send-email-will.deacon@arm.com>
References: <1301669441-13744-1-git-send-email-will.deacon@arm.com>
Message-ID: <1301669441-13744-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the IRQ combiner chained IRQ handler code to use the
chained IRQ enter/exit functions in order to function correctly on
primary controllers with different methods of flow control.

This is required for the GIC to move to fasteoi interrupt handling.

Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-exynos4/irq-combiner.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos4/irq-combiner.c b/arch/arm/mach-exynos4/irq-combiner.c
index f488b66..5a2758a 100644
--- a/arch/arm/mach-exynos4/irq-combiner.c
+++ b/arch/arm/mach-exynos4/irq-combiner.c
@@ -59,8 +59,7 @@ static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 	unsigned int cascade_irq, combiner_irq;
 	unsigned long status;
 
-	/* primary controller ack'ing */
-	chip->irq_ack(&desc->irq_data);
+	chained_irq_enter(chip, desc);
 
 	spin_lock(&irq_controller_lock);
 	status = __raw_readl(chip_data->base + COMBINER_INT_STATUS);
@@ -79,8 +78,7 @@ static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 		generic_handle_irq(cascade_irq);
 
  out:
-	/* primary controller unmasking */
-	chip->irq_unmask(&desc->irq_data);
+	chained_irq_exit(chip, desc);
 }
 
 static struct irq_chip combiner_chip = {
-- 
1.7.0.4
