From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue,  7 Jun 2016 14:31:01 +0100
Subject: [RFC PATCH v2 06/15] drivers: acpi: iort: enhance device identifiers
 mappings
In-Reply-To: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1465306270-27076-7-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current IORT code only allow to map device identifiers to the
corresponding ITS group device id. This is not sufficient, in that
current code does not allow device id mappings to components
that sit between devices and ITS interrupt controllers (eg IOMMUs).

This patch enhances the current IORT ids mapping API to cater for
all mappings allowed by the IORT specification.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/iort.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index cfdde71..0ba6c8a 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -264,14 +264,14 @@ iort_find_dev_callback(struct acpi_iort_node *node, void *context)
 
 static struct acpi_iort_node *
 iort_dev_map_rid(struct acpi_iort_node *node, u32 rid_in,
-			    u32 *rid_out)
+			    u32 *rid_out, u8 type)
 {
 
 	if (!node)
 		goto out;
 
 	/* Go upstream */
-	while (node->type != ACPI_IORT_NODE_ITS_GROUP) {
+	while (node->type != type) {
 		struct acpi_iort_id_mapping *id;
 		int i, found = 0;
 
@@ -346,7 +346,7 @@ iort_its_find_node_and_map_rid(struct pci_dev *pdev, u32 req_id, u32 *dev_id)
 		return NULL;
 	}
 
-	return iort_dev_map_rid(node, req_id, dev_id);
+	return iort_dev_map_rid(node, req_id, dev_id, ACPI_IORT_NODE_ITS_GROUP);
 }
 
 /**
-- 
2.6.4
