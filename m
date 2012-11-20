From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Mon, 19 Nov 2012 19:05:48 -0600
Subject: [PATCH v5 1/5] iommu/omap: remove redundant clock handling on ISR
In-Reply-To: <1353373552-16039-1-git-send-email-omar.luna@linaro.org>
References: <1353373552-16039-1-git-send-email-omar.luna@linaro.org>
Message-ID: <1353373552-16039-2-git-send-email-omar.luna@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the interrupt to be generated, the mmu clock should be already
enabled while translating a virtual address, so, this call to clock
handling is just increasing/decreasing the counter.

This works now, because its users need the same clock and they
indirectly power the mmu, in this interrupt context the handling of
clocks inside the ISR doesn't seem to be needed nor helping.

Next patch should also correct the dependency on clients to handle
iommu clocks.

Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
---
 drivers/iommu/omap-iommu.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index badc17c..6b1288c 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -807,9 +807,7 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 	if (!obj->refcount)
 		return IRQ_NONE;
 
-	clk_enable(obj->clk);
 	errs = iommu_report_fault(obj, &da);
-	clk_disable(obj->clk);
 	if (errs == 0)
 		return IRQ_HANDLED;
 
-- 
1.7.4.1
