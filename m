From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Tue,  1 Oct 2013 14:39:07 +0200
Subject: [PATCH 3/6] iommu/arm-smmu: Check for num_context_irqs > 0 to avoid
 divide by zero exception
In-Reply-To: <1380631150-10783-1-git-send-email-andreas.herrmann@calxeda.com>
References: <1380631150-10783-1-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <1380631150-10783-4-git-send-email-andreas.herrmann@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the right (or wrong;-) definition of v1 SMMU node in DTB it is
possible to trigger a division by zero in arm_smmu_init_domain_context
(if number of context irqs is 0):

       if (smmu->version == 1) {
               root_cfg->irptndx = atomic_inc_return(&smmu->irptndx);
 =>            root_cfg->irptndx %= smmu->num_context_irqs;
       } else {

Avoid this by checking for num_context_irqs > 0 when probing
for SMMU devices.

Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 drivers/iommu/arm-smmu.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index d19676c..7d07561 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1803,12 +1803,11 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 			smmu->num_context_irqs++;
 	}
 
-	if (num_irqs < smmu->num_global_irqs) {
+	if (!smmu->num_context_irqs) {
 		dev_warn(dev, "found %d interrupts but expected at least %d\n",
-			 num_irqs, smmu->num_global_irqs);
-		smmu->num_global_irqs = num_irqs;
+			 num_irqs, smmu->num_global_irqs + 1);
+		return -ENODEV;
 	}
-	smmu->num_context_irqs = num_irqs - smmu->num_global_irqs;
 
 	smmu->irqs = devm_kzalloc(dev, sizeof(*smmu->irqs) * num_irqs,
 				  GFP_KERNEL);
-- 
1.7.9.5
