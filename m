From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 15 Dec 2017 09:28:09 +0530
Subject: [PATCH V6 02/13] of: platform: Make of_platform_bus_create() global
In-Reply-To: <3875af7e7e77745f02ad429f09a1ad168a55e248.1513264961.git.viresh.kumar@linaro.org>
References: <3875af7e7e77745f02ad429f09a1ad168a55e248.1513264961.git.viresh.kumar@linaro.org>
Message-ID: <83a2f2479ecc6c44a1bfdd89f55f315da7bafc7c.1513309217.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The boot constraints core needs to create platform or AMBA devices
corresponding to a compatible string and not for rest of the nodes in
DT. of_platform_bus_create() fits in the best to achieve that.

Allow it to be used outside of platform.c.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V6:
- Build bot reported a compilation error when CONFIG_OF_ADDRESS isn't
  selected in .config.
- Git didn't catch the change in the file when I rebased the patches to
  the latest kernel and applied this patch cleanly and so I missed that
  the function declaration is placed outside of the #ifdef/endif block.
- This patch just moves the declaration within the CONFIG_OF_ADDRESS
  block.

 drivers/of/platform.c       |  8 ++++----
 include/linux/of_platform.h | 11 +++++++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 61a4a81bea9f..6f707bfb348f 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -397,10 +397,10 @@ static const struct of_dev_auxdata *of_dev_lookup(const struct of_dev_auxdata *l
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
index 4909d1aa47ec..ff80fba79c41 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -81,6 +81,10 @@ extern int of_platform_bus_probe(struct device_node *root,
 				 const struct of_device_id *matches,
 				 struct device *parent);
 #ifdef CONFIG_OF_ADDRESS
+extern int of_platform_bus_create(struct device_node *bus,
+				  const struct of_device_id *matches,
+				  const struct of_dev_auxdata *lookup,
+				  struct device *parent, bool strict);
 extern int of_platform_populate(struct device_node *root,
 				const struct of_device_id *matches,
 				const struct of_dev_auxdata *lookup,
@@ -94,6 +98,13 @@ extern int devm_of_platform_populate(struct device *dev);
 
 extern void devm_of_platform_depopulate(struct device *dev);
 #else
+static inline int of_platform_bus_create(struct device_node *bus,
+					 const struct of_device_id *matches,
+					 const struct of_dev_auxdata *lookup,
+					 struct device *parent, bool strict)
+{
+	return -ENODEV;
+}
 static inline int of_platform_populate(struct device_node *root,
 					const struct of_device_id *matches,
 					const struct of_dev_auxdata *lookup,
-- 
2.15.0.194.g9af6a3dea062
