From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 21 Jul 2015 15:50:48 +0200
Subject: [RFC PATCH 06/16] Add DEVM_CLOCK()
In-Reply-To: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1437486658-28365-7-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/clk/clk.c   | 13 +++++++++++++
 include/linux/clk.h | 10 ++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 1b5fe3da6b55..b51b54846284 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2705,6 +2705,19 @@ void devm_clk_unregister(struct device *dev, struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(devm_clk_unregister);
 
+int devm_acquire_clock(struct device *dev,
+		       const struct devm_resource *resource)
+{
+	struct clk **clkp = dev_get_drvdata(dev) + resource->offset;
+
+	*clkp = devm_clk_get(dev, resource->name);
+	if (IS_ERR(*clkp))
+		return PTR_ERR(*clkp);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_acquire_clock);
+
 /*
  * clkdev helpers
  */
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 0df4a51e1a78..1084776efc28 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -17,6 +17,7 @@
 #include <linux/notifier.h>
 
 struct device;
+struct devm_resource;
 
 struct clk;
 
@@ -138,6 +139,15 @@ int clk_get_phase(struct clk *clk);
  */
 bool clk_is_match(const struct clk *p, const struct clk *q);
 
+int devm_acquire_clock(struct device *dev,
+		       const struct devm_resource *resource);
+
+#define DEVM_CLOCK(_struct, _member, _name) {	 			\
+	.initfunc = devm_acquire_clock,				 	\
+	.offset = offsetof_t(struct _struct, _member, struct clk *),	\
+	.name = _name,							\
+}
+
 #else
 
 static inline long clk_get_accuracy(struct clk *clk)
-- 
2.4.3
