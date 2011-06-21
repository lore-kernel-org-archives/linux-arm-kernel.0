From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 21 Jun 2011 12:44:53 -0600
Subject: [PATCH 1/5] dt: Add default match table for bus ids
In-Reply-To: <20110621181127.18176.1384.stgit@ponder>
References: <20110621181127.18176.1384.stgit@ponder>
Message-ID: <20110621184453.18176.95533.stgit@ponder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No need for most platforms to define their own bus table when calling
of_platform_populate().  Supply a stock one.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/of/platform.c       |    8 ++++++++
 include/linux/of_platform.h |    2 ++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 63d3cb7..bb483ef 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -22,6 +22,14 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
+const struct of_device_id of_default_bus_match_table[] = {
+	{ .compatible = "simple-bus", },
+#ifdef CONFIG_ARM_AMBA
+	{ .compatible = "arm,amba-bus", },
+#endif /* CONFIG_ARM_AMBA */
+	{} /* Empty terminated list */
+};
+
 static int of_dev_node_match(struct device *dev, void *data)
 {
 	return dev->of_node == data;
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index fb51ae3..8f023f8 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -40,6 +40,8 @@ struct of_platform_driver
 #define	to_of_platform_driver(drv) \
 	container_of(drv,struct of_platform_driver, driver)
 
+extern const struct of_device_id of_default_bus_match_table[];
+
 /* Platform drivers register/unregister */
 extern struct platform_device *of_device_alloc(struct device_node *np,
 					 const char *bus_id,
