From: ttnguyen@apm.com (Tai Nguyen)
Date: Thu, 13 Oct 2016 11:09:16 -0700
Subject: [PATCH v2] perf: xgene: Remove bogus IS_ERR() check
Message-ID: <1476382156-11641-1-git-send-email-ttnguyen@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In acpi_get_pmu_hw_inf we pass the address of a local variable to IS_ERR(),
which doesn't make sense, as the pointer must be a real, valid pointer.
This doesn't cause a functional problem, as IS_ERR() will evaluate as
false, but the check is bogus and causes static checkers to complain.

Remove the bogus check.

The bug is reported by Dan Carpenter <dan.carpenter@oracle.com> in [1]

[1] https://www.spinics.net/lists/arm-kernel/msg535957.html

Signed-off-by: Tai Nguyen <ttnguyen@apm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
v2:
 Add more problem description in the commit message
 Add Acked-by: Mark Rutland <mark.rutland@arm.com>

 drivers/perf/xgene_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index c2ac764..a8ac4bc 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1011,7 +1011,7 @@ xgene_pmu_dev_ctx *acpi_get_pmu_hw_inf(struct xgene_pmu *xgene_pmu,
 	rc = acpi_dev_get_resources(adev, &resource_list,
 				    acpi_pmu_dev_add_resource, &res);
 	acpi_dev_free_resource_list(&resource_list);
-	if (rc < 0 || IS_ERR(&res)) {
+	if (rc < 0) {
 		dev_err(dev, "PMU type %d: No resource address found\n", type);
 		goto err;
 	}
-- 
1.9.1
