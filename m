From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 15 Feb 2014 11:20:08 +0100
Subject: [PATCH v2 10/23] ARM: MM: Add DT binding for Feroceon L2 cache
In-Reply-To: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
Message-ID: <1392459621-24003-11-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instantiate the L2 cache from DT. Indicate in DT where the cache
control register is and if write through should be made.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
cc: devicetree at vger.kernel.org
---
v2:
Change compatible strings to follow l2x0 convention
Only expect register for kirkwood-cache.
Default to write through if no DT node.
Rename writethrough to wt-override to follow l2cc binding.
Split kirkwood.dtsi change into a patch of its own.
---
 .../devicetree/bindings/arm/mrvl/feroceon.txt      | 17 +++++++
 arch/arm/include/asm/hardware/cache-feroceon-l2.h  |  2 +
 arch/arm/mach-kirkwood/board-dt.c                  | 15 +------
 arch/arm/mm/cache-feroceon-l2.c                    | 52 ++++++++++++++++++++++
 4 files changed, 72 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mrvl/feroceon.txt

diff --git a/Documentation/devicetree/bindings/arm/mrvl/feroceon.txt b/Documentation/devicetree/bindings/arm/mrvl/feroceon.txt
new file mode 100644
index 000000000000..d6d7d6195ed1
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mrvl/feroceon.txt
@@ -0,0 +1,17 @@
+* Marvell Feroceon Cache
+
+Required properties:
+- compatible : Should be either "marvell,ferocean-cache" or
+  	       "marvell,kirkwood-cache".
+
+Optional properties:
+- wt-override: If present then L2 is forced to Write through mode
+- reg        : Address of the L2 cache control register. Mandatory for
+  	       "marvell,kirkwood-cache", not used by "marvell,ferocean-cache"
+
+
+Example:
+		l2: l2-cache at 20128 {
+			compatible = "marvell,kirkwood-cache";
+			reg = <0x20128 0x4>;
+		};
diff --git a/arch/arm/include/asm/hardware/cache-feroceon-l2.h b/arch/arm/include/asm/hardware/cache-feroceon-l2.h
index 8edd330aabf6..12e1588dc4f1 100644
--- a/arch/arm/include/asm/hardware/cache-feroceon-l2.h
+++ b/arch/arm/include/asm/hardware/cache-feroceon-l2.h
@@ -9,3 +9,5 @@
  */
 
 extern void __init feroceon_l2_init(int l2_wt_override);
+extern int __init feroceon_of_init(void);
+
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 34c35510fd17..2ef59ee2182d 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -42,19 +42,6 @@ static void __init kirkwood_map_io(void)
 	iotable_init(kirkwood_io_desc, ARRAY_SIZE(kirkwood_io_desc));
 }
 
-static void __init kirkwood_l2_init(void)
-{
-#ifdef CONFIG_CACHE_FEROCEON_L2
-#ifdef CONFIG_CACHE_FEROCEON_L2_WRITETHROUGH
-	writel(readl(L2_CONFIG_REG) | L2_WRITETHROUGH, L2_CONFIG_REG);
-	feroceon_l2_init(1);
-#else
-	writel(readl(L2_CONFIG_REG) & ~L2_WRITETHROUGH, L2_CONFIG_REG);
-	feroceon_l2_init(0);
-#endif
-#endif
-}
-
 static struct resource kirkwood_cpufreq_resources[] = {
 	[0] = {
 		.start  = CPU_CONTROL_PHYS,
@@ -211,7 +198,7 @@ static void __init kirkwood_dt_init(void)
 
 	BUG_ON(mvebu_mbus_dt_init());
 
-	kirkwood_l2_init();
+	feroceon_of_init();
 
 	kirkwood_cpufreq_init();
 	kirkwood_cpuidle_init();
diff --git a/arch/arm/mm/cache-feroceon-l2.c b/arch/arm/mm/cache-feroceon-l2.c
index 898362e7972b..17a1ecd7a40c 100644
--- a/arch/arm/mm/cache-feroceon-l2.c
+++ b/arch/arm/mm/cache-feroceon-l2.c
@@ -13,11 +13,16 @@
  */
 
 #include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/highmem.h>
+#include <linux/io.h>
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
 #include <asm/hardware/cache-feroceon-l2.h>
 
+#define L2_WRITETHROUGH_KIRKWOOD	BIT(4)
+
 /*
  * Low-level cache maintenance operations.
  *
@@ -350,3 +355,50 @@ void __init feroceon_l2_init(int __l2_wt_override)
 	printk(KERN_INFO "Feroceon L2: Cache support initialised%s.\n",
 			 l2_wt_override ? ", in WT override mode" : "");
 }
+#ifdef CONFIG_OF
+static const struct of_device_id feroceon_ids[] __initconst = {
+	{ .compatible = "marvell,kirkwood-cache"},
+	{ .compatible = "marvell,feroceon-cache"},
+	{}
+};
+
+int __init feroceon_of_init(void)
+{
+	struct device_node *node;
+	void __iomem *base;
+	bool l2_wt_override = false;
+	struct resource res;
+
+	node = of_find_matching_node(NULL, feroceon_ids);
+	if (!node) {
+		/*
+		 * If we don't know the write through state then
+		 * assume it is write back, as that is the safest
+		 * option.
+		 */
+		feroceon_l2_init(0);
+		return 0;
+	}
+
+	if (of_device_is_compatible(node, "marvell,kirkwood-cache")) {
+		if (of_property_read_bool(node, "wt-override"))
+			l2_wt_override = true;
+
+		if (of_address_to_resource(node, 0, &res))
+			return -ENODEV;
+
+		base = ioremap(res.start, resource_size(&res));
+		if (!base)
+			return -ENOMEM;
+
+		if (l2_wt_override)
+			writel(readl(base) | L2_WRITETHROUGH_KIRKWOOD, base);
+		else
+			writel(readl(base) & ~L2_WRITETHROUGH_KIRKWOOD, base);
+	}
+
+	feroceon_l2_init(l2_wt_override);
+
+	return 0;
+}
+#endif
-- 
1.8.5.3
