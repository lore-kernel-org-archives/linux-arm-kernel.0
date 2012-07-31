From: xiechao.mail@gmail.com (Chao Xie)
Date: Tue, 31 Jul 2012 14:13:14 +0800
Subject: [PATCH 7/7] arm: cache: add dt support for tauros2 cache
In-Reply-To: <1343715194-25900-1-git-send-email-xiechao.mail@gmail.com>
References: <1343715194-25900-1-git-send-email-xiechao.mail@gmail.com>
Message-ID: <1343715194-25900-7-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
---
 .../devicetree/bindings/arm/mrvl/tauros2.txt       |   18 ++++++++++
 arch/arm/mm/cache-tauros2.c                        |   35 +++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mrvl/tauros2.txt

diff --git a/Documentation/devicetree/bindings/arm/mrvl/tauros2.txt b/Documentation/devicetree/bindings/arm/mrvl/tauros2.txt
new file mode 100644
index 0000000..3616b75
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mrvl/tauros2.txt
@@ -0,0 +1,18 @@
+* Marvell Tauros2 Cache
+
+Required properties:
+- compatible : Should be "marvell,tauros2-cache".
+- marvell,tauros2-cache-features : Specify the features supported for the
+  tauros2 cache.
+  The features including
+    CACHE_TAUROS2_PREFETCH_ON       (1 << 0)
+    CACHE_TAUROS2_LINEFILL_BURST8   (1 << 1)
+  The definition can be found at
+  arch/arm/include/asm/hardware/cache-tauros2.h
+
+Example:
+	L2: l2-cache {
+		compatible = "marvell,tauros2-cache";
+		marvell,tauros2-cache-features = <0x3>;
+	};
+
diff --git a/arch/arm/mm/cache-tauros2.c b/arch/arm/mm/cache-tauros2.c
index e9f054f..1be0f4e 100644
--- a/arch/arm/mm/cache-tauros2.c
+++ b/arch/arm/mm/cache-tauros2.c
@@ -15,6 +15,8 @@
  */
 
 #include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
 #include <asm/cputype.h>
@@ -198,7 +200,7 @@ static void enable_extra_feature(unsigned int features)
 	write_extra_features(u);
 }
 
-void __init tauros2_init(unsigned int features)
+static void __init tauros2_internal_init(unsigned int features)
 {
 	char *mode = NULL;
 
@@ -294,3 +296,34 @@ void __init tauros2_init(unsigned int features)
 	printk(KERN_INFO "Tauros2: L2 cache support initialised "
 			 "in %s mode.\n", mode);
 }
+
+#ifdef CONFIG_OF
+static const struct of_device_id tauros2_ids[] __initconst = {
+	{ .compatible = "marvell,tauros2-cache"},
+	{}
+};
+#endif
+
+void __init tauros2_init(unsigned int features)
+{
+#ifdef CONFIG_OF
+	struct device_node *node;
+	int ret;
+	unsigned int f;
+
+	node = of_find_matching_node(NULL, tauros2_ids);
+	if (!node) {
+		pr_info("Not found marvell,tauros2-cache, disable it\n");
+		return;
+	}
+
+	ret = of_property_read_u32(node, "marvell,tauros2-cache-features", &f);
+	if (ret) {
+		pr_info("Not found marvell,tauros-cache-features property, "
+			"disable extra features\n");
+		features = 0;
+	} else
+		features = f;
+#endif
+	tauros2_internal_init(features);
+}
-- 
1.7.0.4
