From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Fri,  2 Mar 2018 14:55:31 +0000
Subject: [PATCH 3/3] iommu: armsmmu: set iommu ops for rpmsg bus
In-Reply-To: <20180302145531.20463-1-srinivas.kandagatla@linaro.org>
References: <20180302145531.20463-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180302145531.20463-4-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On Qualcomm SoCs, ADSP exposes many functions like audio and
others. These services need iommu access to allocate any
memory for the DSP. As these drivers are childeren of
rpmsg bus, able to allocate memory from iommus is basic
requirement. So set arm smmu iommu ops for this bus type.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/iommu/arm-smmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index e6920d32ac9e..9b63489af15c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -53,6 +53,7 @@
 #include <linux/spinlock.h>
 
 #include <linux/amba/bus.h>
+#include <linux/rpmsg.h>
 
 #include "io-pgtable.h"
 #include "arm-smmu-regs.h"
@@ -2168,6 +2169,10 @@ static void arm_smmu_bus_init(void)
 		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
 	}
 #endif
+#ifdef CONFIG_RPMSG
+	if (!iommu_present(&rpmsg_bus))
+		bus_set_iommu(&rpmsg_bus, &arm_smmu_ops);
+#endif
 }
 
 static int arm_smmu_device_probe(struct platform_device *pdev)
-- 
2.15.1
