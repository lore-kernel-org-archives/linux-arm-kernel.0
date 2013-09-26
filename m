From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Fri, 27 Sep 2013 00:36:16 +0200
Subject: [PATCH 4/9] iommu/arm-smmu: Check for num_context_irqs > 0 to avoid
 divide by zero exception
In-Reply-To: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <1380234982-1677-5-git-send-email-andreas.herrmann@calxeda.com>
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

Rationale: Assuming that at least one context bank for non-secure
usage is provided per SMMU, it follows (from ARM SMMU Architecture
Spec) that at least one context interrupt must be available.

Also remove the line of code that derived num_context_irqs from
num_irqs and num_global_irqs. If DT is wrong and interrupt property
contains less interrupts than num_global_irqs this would set
num_context_irqs to a big u32 value which most likely causes trouble
in other parts of the driver.

Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 drivers/iommu/arm-smmu.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 4307fbc..de9dd60 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1822,7 +1822,11 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 			 num_irqs, smmu->num_global_irqs);
 		smmu->num_global_irqs = num_irqs;
 	}
-	smmu->num_context_irqs = num_irqs - smmu->num_global_irqs;
+
+	if (!smmu->num_context_irqs) {
+		dev_err(dev, "no context interrupt specified in DT\n");
+		return -ENODEV;
+	}
 
 	smmu->irqs = devm_kzalloc(dev, sizeof(*smmu->irqs) * num_irqs,
 				  GFP_KERNEL);
-- 
1.7.9.5
