From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Jul 2017 16:12:56 +0200
Subject: [PATCH 01/18] regmap: mmio: Add function to attach a clock
In-Reply-To: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
Message-ID: <02f409ad80afed68e02660f161fc26d588a86fa7.1499955058.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

regmap_init_mmio_clk allows to specify a clock that needs to be enabled
while accessing the registers.

However, that clock is retrieved through its clock ID, which means it will
lookup that clock based on the current device that registers the regmap,
and, in the DT case, will only look in that device OF node.

This might be problematic if the clock to enable is stored in another node.
Let's add a function that allows to attach a clock that has already been
retrieved to a regmap in order to fix this.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/base/regmap/regmap-mmio.c | 24 ++++++++++++++++++++++++
 include/linux/regmap.h            |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index 5189fd6182f6..5cadfd3394d8 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -28,6 +28,8 @@
 struct regmap_mmio_context {
 	void __iomem *regs;
 	unsigned val_bytes;
+
+	bool attached_clk;
 	struct clk *clk;
 
 	void (*reg_write)(struct regmap_mmio_context *ctx,
@@ -363,4 +365,26 @@ struct regmap *__devm_regmap_init_mmio_clk(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(__devm_regmap_init_mmio_clk);
 
+int regmap_mmio_attach_clk(struct regmap *map, struct clk *clk)
+{
+	struct regmap_mmio_context *ctx = map->bus_context;
+
+	ctx->clk = clk;
+	ctx->attached_clk = true;
+
+	return clk_prepare(ctx->clk);
+}
+EXPORT_SYMBOL_GPL(regmap_mmio_attach_clk);
+
+void regmap_mmio_detach_clk(struct regmap *map)
+{
+	struct regmap_mmio_context *ctx = map->bus_context;
+
+	clk_unprepare(ctx->clk);
+
+	ctx->attached_clk = false;
+	ctx->clk = NULL;
+}
+EXPORT_SYMBOL_GPL(regmap_mmio_detach_clk);
+
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 978abfbac617..11a292a76586 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -21,6 +21,7 @@
 #include <linux/lockdep.h>
 
 struct module;
+struct clk;
 struct device;
 struct i2c_client;
 struct irq_domain;
@@ -789,6 +790,9 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 	__regmap_lockdep_wrapper(__devm_regmap_init_ac97, #config,	\
 				ac97, config)
 
+int regmap_mmio_attach_clk(struct regmap *map, struct clk *clk);
+void regmap_mmio_detach_clk(struct regmap *map);
+
 void regmap_exit(struct regmap *map);
 int regmap_reinit_cache(struct regmap *map,
 			const struct regmap_config *config);
-- 
git-series 0.9.1
