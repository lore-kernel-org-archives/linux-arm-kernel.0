From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 19 Nov 2010 14:50:10 +0000
Subject: [PATCH] arm: Fix GIC distributor initialisation
Message-ID: <1290178210-30791-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code checking interrupt limits was "slightly" wrong, using
max() instead of min() value. This hasn't been noticed before
because max_irq was never really higher then NR_IRQS...

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/common/gic.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 772f95f..35a2a0b 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -235,8 +235,8 @@ void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
 	 * Limit this to either the architected maximum, or the
 	 * platform maximum.
 	 */
-	if (max_irq > max(1020, NR_IRQS))
-		max_irq = max(1020, NR_IRQS);
+	if (max_irq > min(1020, NR_IRQS))
+		max_irq = min(1020, NR_IRQS);
 
 	/*
 	 * Set all global interrupts to be level triggered, active low.
-- 
1.6.3.3
