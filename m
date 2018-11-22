From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu, 22 Nov 2018 22:22:12 +0100
Subject: [PATCH 2/2] clk: core: link consumer with clock driver
In-Reply-To: <20181122212212.16039-1-miquel.raynal@bootlin.com>
References: <20181122212212.16039-1-miquel.raynal@bootlin.com>
Message-ID: <20181122212212.16039-3-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One major concern when, for instance, suspending/resuming a platform
is to never access registers before the underlying clock has been
resumed, otherwise most of the time the kernel will just crash. One
solution is to use syscore operations when registering clock drivers
suspend/resume callbacks. One problem of using syscore_ops is that the
suspend/resume scheduling will depend on the order of the
registrations, which brings (unacceptable) randomness in the process.

A feature called device links has been introduced to handle such
situation. It creates dependencies between consumers and providers,
enforcing e.g. the suspend/resume order when needed. Such feature is
already in use for regulators.

Add device links support in the clock subsystem by creating/deleting
the links at get/put time.

Example of a boot (ESPRESSObin, A3700 SoC) with devices linked to clocks:
ahci-mvebu d00e0000.sata: Linked as a consumer to d0013000.nb-periph-clk
mvneta d0030000.ethernet: Linked as a consumer to d0018000.sb-periph-clk
xhci-hcd d0058000.usb: Linked as a consumer to d0018000.sb-periph-clk
xenon-sdhci d00d0000.sdhci: Linked as a consumer to d0013000.nb-periph-clk
xenon-sdhci d00d0000.sdhci: Dropping the link to d0013000.nb-periph-clk
advk-pcie d0070000.pcie: Linked as a consumer to d0018000.sb-periph-clk
xenon-sdhci d00d0000.sdhci: Linked as a consumer to d0013000.nb-periph-clk
xenon-sdhci d00d0000.sdhci: Linked as a consumer to regulator.1
cpu cpu0: Linked as a consumer to d0013000.nb-periph-clk
cpu cpu0: Dropping the link to d0013000.nb-periph-clk
cpu cpu0: Linked as a consumer to d0013000.nb-periph-clk

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/clk.c            | 20 ++++++++++++++++++++
 drivers/clk/clkdev.c         | 13 ++++++++++---
 include/linux/clk-provider.h |  2 ++
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b799347c5fd6..33a0f2b0533a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -90,6 +90,7 @@ struct clk {
 	unsigned long max_rate;
 	unsigned int exclusive_count;
 	struct hlist_node clks_node;
+	struct device_link *link;
 };
 
 /***           runtime pm          ***/
@@ -262,6 +263,25 @@ struct clk_hw *__clk_get_hw(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(__clk_get_hw);
 
+void __clk_device_link(struct device *consumer, struct clk *clk)
+{
+	if (!consumer || !clk || !clk->core)
+		return;
+
+	clk->link = device_link_add(consumer, clk->core->dev,
+				    DL_FLAG_STATELESS);
+}
+EXPORT_SYMBOL_GPL(__clk_device_link);
+
+void __clk_device_unlink(struct clk *clk)
+{
+	if (!clk || !clk->link)
+		return;
+
+	device_link_del(clk->link);
+}
+EXPORT_SYMBOL_GPL(__clk_device_unlink);
+
 unsigned int clk_hw_get_num_parents(const struct clk_hw *hw)
 {
 	return hw->core->num_parents;
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 9ab3db8b3988..fccfd4c01457 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -194,20 +194,27 @@ EXPORT_SYMBOL(clk_get_sys);
 struct clk *clk_get(struct device *dev, const char *con_id)
 {
 	const char *dev_id = dev ? dev_name(dev) : NULL;
-	struct clk *clk;
+	struct clk *clk = NULL;
 
 	if (dev && dev->of_node) {
 		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
-		if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
+		if (PTR_ERR(clk) == -EPROBE_DEFER)
 			return clk;
 	}
 
-	return clk_get_sys(dev_id, con_id);
+	if (IS_ERR_OR_NULL(clk))
+		clk = clk_get_sys(dev_id, con_id);
+
+	if (!IS_ERR(clk))
+		__clk_device_link(dev, clk);
+
+	return clk;
 }
 EXPORT_SYMBOL(clk_get);
 
 void clk_put(struct clk *clk)
 {
+	__clk_device_unlink(clk);
 	__clk_put(clk);
 }
 EXPORT_SYMBOL(clk_put);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 60c51871b04b..c7ba8098f854 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -781,6 +781,8 @@ void devm_clk_hw_unregister(struct device *dev, struct clk_hw *hw);
 const char *__clk_get_name(const struct clk *clk);
 const char *clk_hw_get_name(const struct clk_hw *hw);
 struct clk_hw *__clk_get_hw(struct clk *clk);
+void __clk_device_link(struct device *consumer, struct clk *clk);
+void __clk_device_unlink(struct clk *clk);
 unsigned int clk_hw_get_num_parents(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent_by_index(const struct clk_hw *hw,
-- 
2.19.1
