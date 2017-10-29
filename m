From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 29 Oct 2017 19:18:50 +0530
Subject: [PATCH V4 02/12] of: platform: Make of_platform_bus_create() global
In-Reply-To: <cover.1509284255.git.viresh.kumar@linaro.org>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
Message-ID: <0244d3887d8439bb2c65c14fbc37074543b9789d.1509284255.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The boot constraints core needs to create platform or AMBA devices
corresponding to a compatible string and not for rest of the nodes in
DT. of_platform_bus_create() fits in the best to achieve that.

Allow it to be used outside of platform.c.

Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/of/platform.c       |  8 ++++----
 include/linux/of_platform.h | 12 ++++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b38a8e5908a3..808628842ea8 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -362,10 +362,10 @@ static const struct of_dev_auxdata *of_dev_lookup(const struct of_dev_auxdata *l
  * Creates a platform_device for the provided device_node, and optionally
  * recursively create devices for all the child nodes.
  */
-static int of_platform_bus_create(struct device_node *bus,
-				  const struct of_device_id *matches,
-				  const struct of_dev_auxdata *lookup,
-				  struct device *parent, bool strict)
+int of_platform_bus_create(struct device_node *bus,
+			   const struct of_device_id *matches,
+			   const struct of_dev_auxdata *lookup,
+			   struct device *parent, bool strict)
 {
 	const struct of_dev_auxdata *auxdata;
 	struct device_node *child;
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index fbf8a6443885..3ee106018b60 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -82,6 +82,10 @@ extern struct platform_device *of_platform_device_create(struct device_node *np,
 						   struct device *parent);
 
 extern int of_platform_device_destroy(struct device *dev, void *data);
+extern int of_platform_bus_create(struct device_node *bus,
+				  const struct of_device_id *matches,
+				  const struct of_dev_auxdata *lookup,
+				  struct device *parent, bool strict);
 extern int of_platform_bus_probe(struct device_node *root,
 				 const struct of_device_id *matches,
 				 struct device *parent);
@@ -118,6 +122,14 @@ static inline int of_platform_device_destroy(struct device *dev, void *data)
 	return -ENODEV;
 }
 
+static inline int of_platform_bus_create(struct device_node *bus,
+					 const struct of_device_id *matches,
+					 const struct of_dev_auxdata *lookup,
+					 struct device *parent, bool strict)
+{
+	return -ENODEV;
+}
+
 static inline int of_platform_bus_probe(struct device_node *root,
 					const struct of_device_id *matches,
 					struct device *parent)
-- 
2.15.0.rc1.236.g92ea95045093
