From: adharmap@codeaurora.org (adharmap at codeaurora.org)
Date: Thu, 28 Jan 2010 23:06:02 -0800
Subject: [PATCH v2 2/4] GIC: Prevent gic from crossing NR_IRQS
In-Reply-To: <1264748764-5319-1-git-send-email-adharmap@codeaurora.org>
References: <1264748764-5319-1-git-send-email-adharmap@codeaurora.org>
Message-ID: <1264748764-5319-3-git-send-email-adharmap@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abhijeet Dharmapurikar <adharmap@quicinc.com>

Prevent gic code from initializing interrupts beyon NR_IRQS.

Signed-off-by: Abhijeet Dharmapurikar <adharmap@quicinc.com>
---
 arch/arm/common/gic.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index cd92ce0..8a2bfae 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -237,7 +237,8 @@ void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
 	/*
 	 * Setup the Linux IRQ subsystem.
 	 */
-	for (i = irq_start; i < gic_data[gic_nr].irq_offset + max_irq; i++) {
+	for (i = irq_start;
+		i < NR_IRQS && i < gic_data[gic_nr].irq_offset + max_irq; i++) {
 		set_irq_chip(i, &gic_chip);
 		set_irq_chip_data(i, &gic_data[gic_nr]);
 		set_irq_handler(i, handle_level_irq);
-- 
1.5.6.3
