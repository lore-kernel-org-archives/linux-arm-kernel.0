From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 29 Oct 2017 19:18:49 +0530
Subject: [PATCH V4 01/12] of: platform: Add of_find_amba_device_by_node()
In-Reply-To: <cover.1509284255.git.viresh.kumar@linaro.org>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
Message-ID: <80731ad75f52781bf1d5fb1a1a211ee59b4a2ffb.1509284255.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_find_device_by_node() works only with platform devices. Lets create
one for amba devices as well.

Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/of/platform.c       | 20 ++++++++++++++++++++
 include/linux/of_platform.h |  9 +++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index ac15d0e3d27d..b38a8e5908a3 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -60,6 +60,26 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
 }
 EXPORT_SYMBOL(of_find_device_by_node);
 
+#ifdef CONFIG_ARM_AMBA
+/**
+ * of_find_amba_device_by_node - Find the amba_device associated with a node
+ * @np: Pointer to device tree node
+ *
+ * Takes a reference to the embedded struct device which needs to be dropped
+ * after use.
+ *
+ * Returns amba_device pointer, or NULL if not found
+ */
+struct amba_device *of_find_amba_device_by_node(struct device_node *np)
+{
+	struct device *dev;
+
+	dev = bus_find_device(&amba_bustype, NULL, np, of_dev_node_match);
+	return dev ? to_amba_device(dev) : NULL;
+}
+EXPORT_SYMBOL(of_find_amba_device_by_node);
+#endif
+
 #ifdef CONFIG_OF_ADDRESS
 /*
  * The following routines scan a subtree and registers a device for
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 8a561e08bc9e..fbf8a6443885 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -61,6 +61,15 @@ static inline struct platform_device *of_find_device_by_node(struct device_node
 }
 #endif
 
+#if defined(CONFIG_OF) && defined(CONFIG_ARM_AMBA)
+extern struct amba_device *of_find_amba_device_by_node(struct device_node *np);
+#else
+static inline struct amba_device *of_find_amba_device_by_node(struct device_node *np)
+{
+	return NULL;
+}
+#endif
+
 #ifdef CONFIG_OF_ADDRESS
 /* Platform drivers register/unregister */
 extern struct platform_device *of_device_alloc(struct device_node *np,
-- 
2.15.0.rc1.236.g92ea95045093
