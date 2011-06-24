From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 24 Jun 2011 15:10:56 +0100
Subject: [RFC PATCH 1/4] dt: early platform devices support
In-Reply-To: <1308924659-31894-1-git-send-email-marc.zyngier@arm.com>
References: <1308924659-31894-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1308924659-31894-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for populating early platform devices from the device
tree, by walking the tree and adding nodes whose 'compatible'
property matches the 'class' string passed as a parameter.

This allows devices to be probed long before the whole device
infrastructure is available.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/of/platform.c       |   26 ++++++++++++++++++++++++++
 include/linux/of_platform.h |    1 +
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index e75af39..2a323ee 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -458,4 +458,30 @@ int of_platform_populate(struct device_node *root,
 	of_node_put(root);
 	return rc;
 }
+
+/**
+ * of_early_platform_populate() - Populate early platform devices from DT
+ * @class: string to compare to the 'compatible' attributes
+ *
+ * This function walks the device tree and register devices whose
+ * 'compatible' property matches the 'class' parameter.
+ *
+ * Returns 0 on success, < 0 on failure.
+ */
+int of_early_platform_populate(const char *class)
+{
+	struct platform_device *pdev;
+	struct device_node *np = NULL;
+
+	while ((np = of_find_compatible_node(np, NULL, class))) {
+		pdev = of_device_alloc(np, NULL, NULL);
+		if (!pdev)
+			return -ENOMEM;
+		list_del(&pdev->dev.devres_head);
+		memset(&pdev->dev.devres_head, 0, sizeof(pdev->dev.devres_head));
+		early_platform_add_devices(&pdev, 1);
+	}
+
+	return 0;
+}
 #endif /* !CONFIG_SPARC */
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 5a6f458..dd1dc90 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -95,6 +95,7 @@ extern int of_platform_populate(struct device_node *root,
 				const struct of_device_id *matches,
 				const struct of_dev_auxdata *lookup,
 				struct device *parent);
+extern int of_early_platform_populate(const char *class);
 #endif /* !CONFIG_SPARC */
 
 #endif /* CONFIG_OF_DEVICE */
-- 
1.7.0.4
