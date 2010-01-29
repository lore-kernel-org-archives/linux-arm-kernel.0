From: adharmap@codeaurora.org (adharmap at codeaurora.org)
Date: Thu, 28 Jan 2010 23:06:01 -0800
Subject: [PATCH v2 1/4] GIC: Disable unused interrupts
In-Reply-To: <1264748764-5319-1-git-send-email-adharmap@codeaurora.org>
References: <1264748764-5319-1-git-send-email-adharmap@codeaurora.org>
Message-ID: <1264748764-5319-2-git-send-email-adharmap@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abhijeet Dharmapurikar <adharmap@quicinc.com>

Disable all interrupts of a gic in distributor initialization function.
This way interrupts beyond NR_IRQS stay disabled.

Signed-off-by: Abhijeet Dharmapurikar <adharmap@quicinc.com>
---
 arch/arm/common/gic.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 337741f..cd92ce0 100644
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
@@ -200,11 +205,10 @@ void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
 
 	/*
 	 * The GIC only supports up to 1020 interrupt sources.
-	 * Limit this to either the architected maximum, or the
-	 * platform maximum.
+	 * Limit this to either the architected maximum
 	 */
-	if (max_irq > max(1020, NR_IRQS))
-		max_irq = max(1020, NR_IRQS);
+	if (max_irq > 1020)
+		max_irq = 1020;
 
 	/*
 	 * Set all global interrupts to be level triggered, active low.
-- 
1.5.6.3
