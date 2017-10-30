From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 30 Oct 2017 12:14:02 +0000
Subject: [PATCH v2] iommu/arm-smmu-v3: Warn about missing IRQs
Message-ID: <3bb431bfe78553db82a0e267263ac58781a2dd25.1509364684.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is annoyingly non-obvious when DMA transactions silently go missing
due to undetected SMMU faults. Help skip the first few debugging steps
in those situations by making it clear when we have neither wired IRQs
nor MSIs with which to raise error conditions.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Cover PRI for completeness, even if the "broken" vs. "does nothing"
    distinction doesn't matter much at the moment.

 drivers/iommu/arm-smmu-v3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e67ba6c40faf..343025a39478 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2263,6 +2263,8 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 						"arm-smmu-v3-evtq", smmu);
 		if (ret < 0)
 			dev_warn(smmu->dev, "failed to enable evtq irq\n");
+	} else {
+		dev_warn(smmu->dev, "no evtq irq - events will not be reported!\n");
 	}
 
 	irq = smmu->cmdq.q.irq;
@@ -2280,6 +2282,8 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 				       0, "arm-smmu-v3-gerror", smmu);
 		if (ret < 0)
 			dev_warn(smmu->dev, "failed to enable gerror irq\n");
+	} else {
+		dev_warn(smmu->dev, "no gerr irq - errors will not be reported!\n");
 	}
 
 	if (smmu->features & ARM_SMMU_FEAT_PRI) {
@@ -2293,6 +2297,8 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 			if (ret < 0)
 				dev_warn(smmu->dev,
 					 "failed to enable priq irq\n");
+		} else {
+			dev_warn(smmu->dev, "no priq irq - PRI will be broken\n");
 		}
 	}
 }
-- 
2.13.4.dirty
