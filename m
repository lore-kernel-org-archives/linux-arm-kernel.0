From: hotran@apm.com (Hoan Tran)
Date: Tue,  6 Jun 2017 11:02:24 -0700
Subject: [PATCH v3 1/3] perf: xgene: Parse PMU subnode from the match table
In-Reply-To: <1496772146-11084-1-git-send-email-hotran@apm.com>
References: <1496772146-11084-1-git-send-email-hotran@apm.com>
Message-ID: <1496772146-11084-2-git-send-email-hotran@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch parses PMU Subnode from a match table.

Signed-off-by: Hoan Tran <hotran@apm.com>
---
 drivers/perf/xgene_pmu.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 35b5289..5ffd580 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1047,9 +1047,35 @@ xgene_pmu_dev_ctx *acpi_get_pmu_hw_inf(struct xgene_pmu *xgene_pmu,
 	return NULL;
 }
 
+static const struct acpi_device_id xgene_pmu_acpi_type_match[] = {
+	{"APMC0D5D", PMU_TYPE_L3C},
+	{"APMC0D5E", PMU_TYPE_IOB},
+	{"APMC0D5F", PMU_TYPE_MCB},
+	{"APMC0D60", PMU_TYPE_MC},
+	{},
+};
+
+static const struct acpi_device_id *xgene_pmu_acpi_match_type(
+					const struct acpi_device_id *ids,
+					struct acpi_device *adev)
+{
+	const struct acpi_device_id *match_id = NULL;
+	const struct acpi_device_id *id;
+
+	for (id = ids; id->id[0] || id->cls; id++) {
+		if (!acpi_match_device_ids(adev, id))
+			match_id = id;
+		else if (match_id)
+			break;
+	}
+
+	return match_id;
+}
+
 static acpi_status acpi_pmu_dev_add(acpi_handle handle, u32 level,
 				    void *data, void **return_value)
 {
+	const struct acpi_device_id *acpi_id;
 	struct xgene_pmu *xgene_pmu = data;
 	struct xgene_pmu_dev_ctx *ctx;
 	struct acpi_device *adev;
@@ -1059,17 +1085,11 @@ static acpi_status acpi_pmu_dev_add(acpi_handle handle, u32 level,
 	if (acpi_bus_get_status(adev) || !adev->status.present)
 		return AE_OK;
 
-	if (!strcmp(acpi_device_hid(adev), "APMC0D5D"))
-		ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_L3C);
-	else if (!strcmp(acpi_device_hid(adev), "APMC0D5E"))
-		ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_IOB);
-	else if (!strcmp(acpi_device_hid(adev), "APMC0D5F"))
-		ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_MCB);
-	else if (!strcmp(acpi_device_hid(adev), "APMC0D60"))
-		ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_MC);
-	else
-		ctx = NULL;
+	acpi_id = xgene_pmu_acpi_match_type(xgene_pmu_acpi_type_match, adev);
+	if (!acpi_id)
+		return AE_OK;
 
+	ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, (u32)acpi_id->driver_data);
 	if (!ctx)
 		return AE_OK;
 
-- 
1.9.1
