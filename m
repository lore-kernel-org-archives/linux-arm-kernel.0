From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 5 Dec 2016 05:23:20 +0000
Subject: [PATCH 1/3] clkdev: add devm_get_clk_from_child()
In-Reply-To: <874m2jvtmw.wl%kuninori.morimoto.gx@renesas.com>
References: <874m2jvtmw.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <8737i3vtl7.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Some driver is using this type of DT bindings for clock (more detail,
see ${LINUX}/Documentation/devicetree/bindings/sound/simple-card.txt).

	sound_soc {
		...
		cpu {
			clocks = <&xxx>;
			...
		};
		codec {
			clocks = <&xxx>;
			...
		};
	};

Current driver in this case uses of_clk_get() for each node, but there
is no devm_of_clk_get() today.
OTOH, the problem of having devm_of_clk_get() is that it encourages the
use of of_clk_get() when clk_get() is more desirable.

Thus, this patch adds new devm_get_clk_from_chile() which explicitly
reads as get a clock from a child node of this device.
By this function, we can also use this type of DT bindings

	sound_soc {
		clocks = <&xxx>, <&xxx>;
		clock-names = "cpu", "codec";
		...
		cpu {
			...
		};
		codec {
			...
		};
	};

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/clk/clk-devres.c | 21 +++++++++++++++++++++
 include/linux/clk.h      | 29 +++++++++++++++++++++++++----
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 8f57154..3a218c3 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -53,3 +53,24 @@ void devm_clk_put(struct device *dev, struct clk *clk)
 	WARN_ON(ret);
 }
 EXPORT_SYMBOL(devm_clk_put);
+
+struct clk *devm_get_clk_from_child(struct device *dev,
+				    struct device_node *np, const char *con_id)
+{
+	struct clk **ptr, *clk;
+
+	ptr = devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	clk = of_clk_get_by_name(np, con_id);
+	if (!IS_ERR(clk)) {
+		*ptr = clk;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return clk;
+}
+EXPORT_SYMBOL(devm_get_clk_from_child);
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 123c027..e9d36b3 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -17,8 +17,9 @@
 #include <linux/notifier.h>
 
 struct device;
-
 struct clk;
+struct device_node;
+struct of_phandle_args;
 
 /**
  * DOC: clk notifier callback types
@@ -249,6 +250,23 @@ static inline void clk_unprepare(struct clk *clk)
 struct clk *devm_clk_get(struct device *dev, const char *id);
 
 /**
+ * devm_get_clk_from_child - lookup and obtain a managed reference to a
+ *			     clock producer from child node.
+ * @dev: device for clock "consumer"
+ * @np: pointer to clock consumer node
+ * @con_id: clock consumer ID
+ *
+ * This function parses the clocks, and uses them to look up the
+ * struct clk from the registered list of clock providers by using
+ * @np and @con_id
+ *
+ * The clock will automatically be freed when the device is unbound
+ * from the bus.
+ */
+struct clk *devm_get_clk_from_child(struct device *dev,
+				    struct device_node *np, const char *con_id);
+
+/**
  * clk_enable - inform the system when the clock source should be running.
  * @clk: clock source
  *
@@ -432,6 +450,12 @@ static inline struct clk *devm_clk_get(struct device *dev, const char *id)
 	return NULL;
 }
 
+static inline struct clk *devm_get_clk_from_child(struct device *dev,
+				struct device_node *np, const char *con_id)
+{
+	return NULL;
+}
+
 static inline void clk_put(struct clk *clk) {}
 
 static inline void devm_clk_put(struct device *dev, struct clk *clk) {}
@@ -501,9 +525,6 @@ static inline void clk_disable_unprepare(struct clk *clk)
 	clk_unprepare(clk);
 }
 
-struct device_node;
-struct of_phandle_args;
-
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 struct clk *of_clk_get(struct device_node *np, int index);
 struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
-- 
1.9.1
