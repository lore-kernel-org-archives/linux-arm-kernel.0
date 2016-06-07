From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue,  7 Jun 2016 14:31:00 +0100
Subject: [RFC PATCH v2 05/15] drivers: acpi: iort: add support for named
 component look-up
In-Reply-To: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1465306270-27076-6-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPI IORT table allows ids translations for PCI devices (through
their respective root complex) and name components (ie components
identified through their ACPI namespace path).

Current IORT code only allows look-up and retrieval of IORT nodes
corresponding to PCI root complexes components; this patch fills
the gap by adding support for named components IORT node look-ups.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/iort.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index 7cc9880..cfdde71 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -215,12 +215,35 @@ iort_scan_node(enum acpi_iort_node_type type,
 static acpi_status
 iort_find_dev_callback(struct acpi_iort_node *node, void *context)
 {
-	struct acpi_iort_root_complex *pci_rc;
 	struct device *dev = context;
-	struct pci_bus *bus;
 
 	switch (node->type) {
-	case ACPI_IORT_NODE_PCI_ROOT_COMPLEX:
+	case ACPI_IORT_NODE_NAMED_COMPONENT: {
+		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+		struct acpi_iort_named_component *ncomp;
+		struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
+
+		if (!adev)
+			break;
+
+		ncomp = (struct acpi_iort_named_component *)node->node_data;
+
+		if (ACPI_FAILURE(acpi_get_name(adev->handle,
+					       ACPI_FULL_PATHNAME, &buffer))) {
+			pr_warn("Can't get device full path name\n");
+			break;
+		}
+
+		if (!strcmp(ncomp->device_name, (char *)buffer.pointer))
+			return AE_OK;
+
+		break;
+	}
+
+	case ACPI_IORT_NODE_PCI_ROOT_COMPLEX: {
+		struct acpi_iort_root_complex *pci_rc;
+		struct pci_bus *bus;
+
 		bus = to_pci_bus(dev);
 		pci_rc = (struct acpi_iort_root_complex *)node->node_data;
 
@@ -234,6 +257,7 @@ iort_find_dev_callback(struct acpi_iort_node *node, void *context)
 
 		break;
 	}
+	}
 
 	return AE_NOT_FOUND;
 }
-- 
2.6.4
