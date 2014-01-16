From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Thu, 16 Jan 2014 13:44:13 +0100
Subject: [PATCH 01/11] iommu/arm-smmu: Introduce driver option handling
In-Reply-To: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <1389876263-25759-2-git-send-email-andreas.herrmann@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce handling of driver options. Options are set based on DT
information when probing an SMMU device. The first option introduced
is "arm,smmu-isolate-devices". (It will be used in the bus notifier
block.)

Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 drivers/iommu/arm-smmu.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index e46a887..0b97d03 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -47,6 +47,9 @@
 
 #include <asm/pgalloc.h>
 
+/* Driver options */
+#define ARM_SMMU_OPT_ISOLATE_DEVICES		(1 << 0)
+
 /* Maximum number of stream IDs assigned to a single device */
 #define MAX_MASTER_STREAMIDS		8
 
@@ -348,6 +351,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_TRANS_S2		(1 << 3)
 #define ARM_SMMU_FEAT_TRANS_NESTED	(1 << 4)
 	u32				features;
+	u32				options;
 	int				version;
 
 	u32				num_context_banks;
@@ -398,6 +402,29 @@ struct arm_smmu_domain {
 static DEFINE_SPINLOCK(arm_smmu_devices_lock);
 static LIST_HEAD(arm_smmu_devices);
 
+struct arm_smmu_option_prop {
+	u32 opt;
+	const char *prop;
+};
+
+static struct arm_smmu_option_prop arm_smmu_options [] = {
+	{ ARM_SMMU_OPT_ISOLATE_DEVICES, "arm,smmu-isolate-devices" },
+	{ 0, NULL},
+};
+
+static void check_driver_options(struct arm_smmu_device *smmu)
+{
+	int i = 0;
+	do {
+		if (of_property_read_bool(smmu->dev->of_node,
+						arm_smmu_options[i].prop)) {
+			smmu->options |= arm_smmu_options[i].opt;
+			dev_dbg(smmu->dev, "option %s\n",
+				arm_smmu_options[i].prop);
+		}
+	} while (arm_smmu_options[++i].opt);
+}
+
 static struct arm_smmu_master *find_smmu_master(struct arm_smmu_device *smmu,
 						struct device_node *dev_node)
 {
@@ -1783,6 +1810,8 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	}
 	smmu->dev = dev;
 
+	check_driver_options(smmu);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	smmu->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(smmu->base))
-- 
1.7.9.5
