From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Fri, 27 Sep 2013 23:22:44 +0200
Subject: [PATCH] iommu/arm-smmu: Print context fault information
In-Reply-To: <20130927104557.GN3315@alberich>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380234982-1677-9-git-send-email-andreas.herrmann@calxeda.com>
 <20130927100902.GD9057@mudshark.cambridge.arm.com>
 <20130927104557.GN3315@alberich>
Message-ID: <20130927212244.GU3315@alberich>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Print context fault information when the fault was not handled by
report_iommu_fault.

Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 drivers/iommu/arm-smmu.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 2a9acc1..5e1dad1 100644
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
