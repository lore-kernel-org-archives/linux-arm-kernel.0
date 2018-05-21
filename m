From: zhangshaokun@hisilicon.com (Shaokun Zhang)
Date: Mon, 21 May 2018 19:15:17 +0800
Subject: [PATCH] perf: hisi: fix uncore PMU index ID
Message-ID: <1526901317-52248-1-git-send-email-zhangshaokun@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to ACPI SPEC about _UID (Unique ID), The _UID must be unique
across all devices with either a common _HID or _CID. For HiSilion
uncore PMU, SCCL_ID and INDEX_ID are used to identify the uncore PMU
for the same _HID. Therefore, _UID is not equal to INDEX_ID in
multi-sccl scene for the same uncore PMU device.

CCL_ID can be used as the INDEX_ID for the L3C PMU and IDX-ID is added
in DSDT table for the HHA PMU.

Fixes: 2940bc4("perf: hisi: Add support for HiSilicon SoC L3C PMU driver")
Fixes: 2bab3cf("perf: hisi: Add support for HiSilicon SoC HHA PMU driver")
Reported-by: Huiqiang Wang <wanghuiqiang@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Huiqiang Wang <wanghuiqiang@huawei.com>
---
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c | 18 ++++++++----------
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c | 11 ++---------
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
index 443906e..dcd8e77 100644
--- a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
@@ -238,19 +238,10 @@ MODULE_DEVICE_TABLE(acpi, hisi_hha_pmu_acpi_match);
 static int hisi_hha_pmu_init_data(struct platform_device *pdev,
 				  struct hisi_pmu *hha_pmu)
 {
-	unsigned long long id;
 	struct resource *res;
-	acpi_status status;
-
-	status = acpi_evaluate_integer(ACPI_HANDLE(&pdev->dev),
-				       "_UID", NULL, &id);
-	if (ACPI_FAILURE(status))
-		return -EINVAL;
-
-	hha_pmu->index_id = id;
 
 	/*
-	 * Use SCCL_ID and UID to identify the HHA PMU, while
+	 * Use SCCL_ID and HHA index ID to identify the HHA PMU, while
 	 * SCCL_ID is in MPIDR[aff2].
 	 */
 	if (device_property_read_u32(&pdev->dev, "hisilicon,scl-id",
@@ -258,6 +249,13 @@ static int hisi_hha_pmu_init_data(struct platform_device *pdev,
 		dev_err(&pdev->dev, "Can not read hha sccl-id!\n");
 		return -EINVAL;
 	}
+
+	if (device_property_read_u32(&pdev->dev, "hisilicon,idx-id",
+				     &hha_pmu->index_id)) {
+		dev_err(&pdev->dev, "Can not read hha index-id!\n");
+		return -EINVAL;
+	}
+
 	/* HHA PMUs only share the same SCCL */
 	hha_pmu->ccl_id = -1;
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
index 0bde5d9..133889c 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
@@ -237,16 +237,7 @@ MODULE_DEVICE_TABLE(acpi, hisi_l3c_pmu_acpi_match);
 static int hisi_l3c_pmu_init_data(struct platform_device *pdev,
 				  struct hisi_pmu *l3c_pmu)
 {
-	unsigned long long id;
 	struct resource *res;
-	acpi_status status;
-
-	status = acpi_evaluate_integer(ACPI_HANDLE(&pdev->dev),
-				       "_UID", NULL, &id);
-	if (ACPI_FAILURE(status))
-		return -EINVAL;
-
-	l3c_pmu->index_id = id;
 
 	/*
 	 * Use the SCCL_ID and CCL_ID to identify the L3C PMU, while
@@ -264,6 +255,8 @@ static int hisi_l3c_pmu_init_data(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	l3c_pmu->index_id = l3c_pmu->ccl_id;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	l3c_pmu->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(l3c_pmu->base)) {
-- 
2.7.4
