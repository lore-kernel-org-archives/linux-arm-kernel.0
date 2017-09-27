From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 27 Sep 2017 09:20:13 +0800
Subject: [PATCH 2/4] ACPI: IORT: lookup iort node via fwnode
In-Reply-To: <1506475215-2731-1-git-send-email-hanjun.guo@linaro.org>
References: <1506475215-2731-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1506475215-2731-3-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we have a helper function iort_get_fwnode() which
lookup fwnode via iort node for SMMU, but sometimes we
just need something exctly the opposite, which means we
need to get the iort node via fwnode.

For example, we need to get SMMU's iort node when adding
support for SMMU MSI, but SMMU is not a named component
which has a associated device node in DSDT, that means
we can't match the ACPI full path name to get the iort
node for SMMU.

But with SMMU or other devices in IORT probed as platform
device, it created a fwnode to associate with the iort
node, so we introduce iort_get_iort_node() to get the
iort node via fwnode.

This can be extended to PMCG node usage in IORT too.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/arm64/iort.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 9565d57..db71d7f 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -126,6 +126,31 @@ static inline void iort_delete_fwnode(struct acpi_iort_node *node)
 	spin_unlock(&iort_fwnode_lock);
 }
 
+/**
+ * iort_get_iort_node() - Retrieve iort_node associated with an fwnode
+ *
+ * @fwnode: fwnode associated with device to be looked-up
+ *
+ * Returns: iort_node pointer on success, NULL on failure
+ */
+static inline
+struct acpi_iort_node *iort_get_iort_node(struct fwnode_handle *fwnode)
+{
+	struct iort_fwnode *curr;
+	struct acpi_iort_node *iort_node = NULL;
+
+	spin_lock(&iort_fwnode_lock);
+	list_for_each_entry(curr, &iort_fwnode_list, list) {
+		if (curr->fwnode == fwnode) {
+			iort_node = curr->iort_node;
+			break;
+		}
+	}
+	spin_unlock(&iort_fwnode_lock);
+
+	return iort_node;
+}
+
 typedef acpi_status (*iort_find_node_callback)
 	(struct acpi_iort_node *node, void *context);
 
@@ -424,9 +449,25 @@ static struct acpi_iort_node *iort_find_dev_node(struct device *dev)
 {
 	struct pci_bus *pbus;
 
-	if (!dev_is_pci(dev))
+	if (!dev_is_pci(dev)) {
+		struct acpi_iort_node *node;
+		/*
+		 * scan iort_fwnode_list to see if it's an iort platform
+		 * device (such as SMMU, PMCG),its iort node already cached
+		 * and associated with fwnode when iort platform devices
+		 * were initialized.
+		 */
+		node = iort_get_iort_node(dev->fwnode);
+		if (node)
+			return node;
+
+		/*
+		 * if not, then it should be a platform device defined in
+		 * DSDT/SSDT (with Named Component node in IORT)
+		 */
 		return iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
 				      iort_match_node_callback, dev);
+	}
 
 	/* Find a PCI root bus */
 	pbus = to_pci_dev(dev)->bus;
-- 
1.9.1
