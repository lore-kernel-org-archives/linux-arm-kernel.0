From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 29 Nov 2016 21:39:29 +0800
Subject: [PATCH v4 01/11] ACPI: ARM64: IORT: minor cleanup for
 iort_match_node_callback()
In-Reply-To: <1480426779-31387-1-git-send-email-guohanjun@huawei.com>
References: <1480426779-31387-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1480426779-31387-2-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

Cleanup iort_match_node_callback() a little bit to reduce
some lines of code, aslo fix the indentation in iort_scan_node().

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/acpi/arm64/iort.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 47bace8..a52fc7e 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -225,7 +225,7 @@ static struct acpi_iort_node *iort_scan_node(enum acpi_iort_node_type type,
 
 		if (iort_node->type == type &&
 		    ACPI_SUCCESS(callback(iort_node, context)))
-				return iort_node;
+			return iort_node;
 
 		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
 					 iort_node->length);
@@ -253,17 +253,15 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
 					    void *context)
 {
 	struct device *dev = context;
-	acpi_status status;
+	acpi_status status = AE_NOT_FOUND;
 
 	if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT) {
 		struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
 		struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
 		struct acpi_iort_named_component *ncomp;
 
-		if (!adev) {
-			status = AE_NOT_FOUND;
+		if (!adev)
 			goto out;
-		}
 
 		status = acpi_get_name(adev->handle, ACPI_FULL_PATHNAME, &buf);
 		if (ACPI_FAILURE(status)) {
@@ -289,8 +287,6 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
 		 */
 		status = pci_rc->pci_segment_number == pci_domain_nr(bus) ?
 							AE_OK : AE_NOT_FOUND;
-	} else {
-		status = AE_NOT_FOUND;
 	}
 out:
 	return status;
-- 
1.7.12.4
