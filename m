From: adharmap@codeaurora.org (adharmap at codeaurora.org)
Date: Wed, 27 Jan 2010 11:32:25 -0800
Subject: [PATCH 1/5] gic: prevent gic from crossing NR_IRQ
In-Reply-To: <1264620749-24527-1-git-send-email-adharmap@codeaurora.org>
References: <1264620749-24527-1-git-send-email-adharmap@codeaurora.org>
Message-ID: <1264620749-24527-2-git-send-email-adharmap@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abhijeet Dharmapurikar <adharmap@quicinc.com>

The gic code tries to initialize interrupts beyond NR_IRQ. Prevent
code from doing that.

Signed-off-by: Abhijeet Dharmapurikar <adharmap@quicinc.com>
---
 arch/arm/common/gic.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 337741f..e763c4c 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -175,6 +175,11 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
 	set_irq_chained_handler(irq, gic_handle_cascade_irq);
 }
 
+/*
+ * In case of multiple cascaded GICs, order calls to gic_dist_init with
+ * ascending irq_start
+ */
+
 void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
 			  unsigned int irq_start)
 {
@@ -233,7 +238,7 @@ void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
 	/*
 	 * Setup the Linux IRQ subsystem.
 	 */
-	for (i = irq_start; i < gic_data[gic_nr].irq_offset + max_irq; i++) {
+	for (i = irq_start; i < NR_IRQS && i < gic_data[gic_nr].irq_offset + max_irq; i++) {
 		set_irq_chip(i, &gic_chip);
 		set_irq_chip_data(i, &gic_data[gic_nr]);
 		set_irq_handler(i, handle_level_irq);
-- 
1.5.6.3
