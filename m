From: nipun.gupta@nxp.com (Nipun Gupta)
Date: Wed, 29 Jun 2016 22:44:07 +0530
Subject: [RFC PATCH 1/2] fsl-mc: Added header file to provide fsl-mc bus iommu
 group creation
Message-ID: <1467220448-16764-1-git-send-email-nipun.gupta@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added a header file fsl_mc_smmu.h to provide basic support of creating
an IOMMU group for a fsl-mc type device and also provide helper macro
to get the stream ID of fsl-mc tyoe device.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Signed-off-by: Bharat Bhushan <bharat.bhushan@nxp.com>
---
 drivers/staging/fsl-mc/include/fsl_mc_smmu.h | 45 ++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 drivers/staging/fsl-mc/include/fsl_mc_smmu.h

diff --git a/drivers/staging/fsl-mc/include/fsl_mc_smmu.h b/drivers/staging/fsl-mc/include/fsl_mc_smmu.h
new file mode 100644
index 0000000..9dff5ba
--- /dev/null
+++ b/drivers/staging/fsl-mc/include/fsl_mc_smmu.h
@@ -0,0 +1,45 @@
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Author: Nipun Gupta <nipun.gupta@freescale.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef _FSL_MC_SMMU_H_
+#define _FSL_MC_SMMU_H_
+
+#include <../drivers/staging/fsl-mc/include/mc.h>
+
+/* Macro to get the MC device ICID (Stream ID) */
+#define fslmc_dev_streamid(_dev) (to_fsl_mc_device(_dev)->icid)
+
+/* Macro to get the container device of a MC device */
+#define fslmc_cont_dev(_dev) ((to_fsl_mc_device(dev)->flags & \
+	FSL_MC_IS_DPRC) ? (_dev) : (_dev->parent))
+
+/* Macro to check if a device is a container device */
+#define is_cont_dev(_dev) (to_fsl_mc_device(_dev)->flags & FSL_MC_IS_DPRC)
+
+static struct iommu_group *fslmc_device_group(struct device *dev)
+{
+	struct device *cont_dev = fslmc_cont_dev(dev);
+	struct iommu_group *group;
+
+	/* Container device is responsible for creating the iommu group */
+	if (is_cont_dev(dev)) {
+		group = iommu_group_alloc();
+
+		if (IS_ERR(group))
+			return NULL;
+	} else {
+		get_device(cont_dev);
+		group = iommu_group_get(cont_dev);
+		put_device(cont_dev);
+	}
+
+	return group;
+}
+
+#endif /* _FSL_MC_SMMU_H_ */
-- 
1.9.1
