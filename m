From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Tue,  1 Oct 2013 14:39:08 +0200
Subject: [PATCH 4/6] iommu/arm-smmu: Print context fault information
In-Reply-To: <1380631150-10783-1-git-send-email-andreas.herrmann@calxeda.com>
References: <1380631150-10783-1-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <1380631150-10783-5-git-send-email-andreas.herrmann@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Print context fault information when the fault was not handled by
report_iommu_fault.

Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 drivers/iommu/arm-smmu.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7d07561..579b6f8 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -590,6 +590,9 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 		ret = IRQ_HANDLED;
 		resume = RESUME_RETRY;
 	} else {
+		dev_err_ratelimited(smmu->dev, "context fault: iova=0x%08lx, "
+				"fsynr=0x%x, cb=%d\n",
+				iova, fsynr, root_cfg->cbndx);
 		ret = IRQ_NONE;
 		resume = RESUME_TERMINATE;
 	}
-- 
1.7.9.5
