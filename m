From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue,  8 Sep 2015 15:20:12 -0700
Subject: [PATCH] soc: qcom: smem: Move RPM message ram out of smem DT node
Message-ID: <1441750812-13041-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SMEM is a software construct built on top of a DDR carveout and
sometimes a device memory called RPM message ram. Having the RPM
message ram in the smem DT node's reg property leads to the smem
node being located in different places depending on if the
message ram is being used or not. Let's add a qcom specific
property, qcom,rpm-msg-ram, and point to the device memory from
the SMEM node via a phandle. This allows us to always have the
SMEM node at the root of the DT regardless of whether it's using
the message ram or not.

Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 17 ++++++---
 drivers/soc/qcom/smem.c             | 73 +++++++++++++++----------------------
 2 files changed, 41 insertions(+), 49 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 71e146de4fe4..16dfae8feece 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -20,6 +20,15 @@
 		};
 	};
 
+	smem {
+		compatible = "qcom,smem";
+
+		memory-region = <&smem_region>;
+		qcom,rpm-msg-ram = <&rpm_msg_ram>;
+
+		hwlocks = <&tcsr_mutex 3>;
+	};
+
 	smd {
 		compatible = "qcom,smd";
 
@@ -300,13 +309,9 @@
 			#hwlock-cells = <1>;
 		};
 
-		smem at fa00000 {
-			compatible = "qcom,smem";
-
-			memory-region = <&smem_region>;
+		rpm_msg_ram: memory at fc428000 {
+			compatible = "qcom,rpm-msg-ram";
 			reg = <0xfc428000 0x4000>;
-
-			hwlocks = <&tcsr_mutex 3>;
 		};
 
 		blsp1_uart2: serial at f991e000 {
diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 74017114ce6e..19019aa092e8 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -664,37 +664,47 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
 	return 0;
 }
 
-static int qcom_smem_count_mem_regions(struct platform_device *pdev)
+static int qcom_smem_map_memory(struct qcom_smem *smem, struct device *dev,
+				const char *name, int i)
 {
-	struct resource *res;
-	int num_regions = 0;
-	int i;
-
-	for (i = 0; i < pdev->num_resources; i++) {
-		res = &pdev->resource[i];
+	struct device_node *np;
+	struct resource r;
+	int ret;
 
-		if (resource_type(res) == IORESOURCE_MEM)
-			num_regions++;
+	np = of_parse_phandle(dev->of_node, name, 0);
+	if (!np) {
+		dev_err(dev, "No %s specified\n", name);
+		return -EINVAL;
 	}
 
-	return num_regions;
+	ret = of_address_to_resource(np, 0, &r);
+	of_node_put(np);
+	if (ret)
+		return ret;
+
+	smem->regions[i].aux_base = (u32)r.start;
+	smem->regions[i].size = resource_size(&r);
+	smem->regions[i].virt_base = devm_ioremap_nocache(dev, r.start,
+							  resource_size(&r));
+	if (!smem->regions[i].virt_base)
+		return -ENOMEM;
+
+	return 0;
 }
 
 static int qcom_smem_probe(struct platform_device *pdev)
 {
 	struct smem_header *header;
-	struct device_node *np;
 	struct qcom_smem *smem;
-	struct resource *res;
-	struct resource r;
 	size_t array_size;
-	int num_regions = 0;
+	int num_regions;
 	int hwlock_id;
 	u32 version;
 	int ret;
-	int i;
 
-	num_regions = qcom_smem_count_mem_regions(pdev) + 1;
+	num_regions = 1;
+	if (of_find_property(pdev->dev.of_node, "qcom,rpm-msg-ram", NULL))
+		num_regions++;
 
 	array_size = num_regions * sizeof(struct smem_region);
 	smem = devm_kzalloc(&pdev->dev, sizeof(*smem) + array_size, GFP_KERNEL);
@@ -704,36 +714,13 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	smem->dev = &pdev->dev;
 	smem->num_regions = num_regions;
 
-	np = of_parse_phandle(pdev->dev.of_node, "memory-region", 0);
-	if (!np) {
-		dev_err(&pdev->dev, "No memory-region specified\n");
-		return -EINVAL;
-	}
-
-	ret = of_address_to_resource(np, 0, &r);
-	of_node_put(np);
+	ret = qcom_smem_map_memory(smem, &pdev->dev, "memory-region", 0);
 	if (ret)
 		return ret;
 
-	smem->regions[0].aux_base = (u32)r.start;
-	smem->regions[0].size = resource_size(&r);
-	smem->regions[0].virt_base = devm_ioremap_nocache(&pdev->dev,
-							  r.start,
-							  resource_size(&r));
-	if (!smem->regions[0].virt_base)
-		return -ENOMEM;
-
-	for (i = 1; i < num_regions; i++) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, i - 1);
-
-		smem->regions[i].aux_base = (u32)res->start;
-		smem->regions[i].size = resource_size(res);
-		smem->regions[i].virt_base = devm_ioremap_nocache(&pdev->dev,
-								  res->start,
-								  resource_size(res));
-		if (!smem->regions[i].virt_base)
-			return -ENOMEM;
-	}
+	if (num_regions > 1 && (ret = qcom_smem_map_memory(smem, &pdev->dev,
+					"qcom,rpm-msg-ram", 1)))
+		return ret;
 
 	header = smem->regions[0].virt_base;
 	if (le32_to_cpu(header->initialized) != 1 ||
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
