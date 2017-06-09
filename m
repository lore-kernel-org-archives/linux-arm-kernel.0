From: jlu@pengutronix.de (Jan Luebbe)
Date: Fri,  9 Jun 2017 10:31:20 +0200
Subject: [RFC PATCH 4/7] EDAC: Add devres helpers for
 edac_mc_alloc/edac_mc_add_mc(_with_groups)
In-Reply-To: <20170609083123.6539-1-jlu@pengutronix.de>
References: <20170609083123.6539-1-jlu@pengutronix.de>
Message-ID: <20170609083123.6539-5-jlu@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These helpers simplify error handling in the _probe functions and automate
deallocation in the _remove functions.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 drivers/edac/edac_mc.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/edac/edac_mc.h | 26 +++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 480072139b7a..4d6759222592 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -517,6 +517,33 @@ void edac_mc_free(struct mem_ctl_info *mci)
 }
 EXPORT_SYMBOL_GPL(edac_mc_free);
 
+/**
+ * devm_edac_mc_free() - Internal helper to call edac_mc_free from a devres
+ *	action.
+ */
+static void devm_edac_mc_free(void *mci)
+{
+	edac_mc_free((struct mem_ctl_info *)mci);
+}
+
+struct mem_ctl_info *devm_edac_mc_alloc(struct device *dev,
+                                        unsigned mc_num,
+                                        unsigned n_layers,
+                                        struct edac_mc_layer *layers,
+                                        unsigned sz_pvt)
+{
+	struct mem_ctl_info *mci;
+	mci = edac_mc_alloc(mc_num, n_layers, layers, sz_pvt);
+	if (!mci)
+		return mci;
+
+	if (devm_add_action_or_reset(dev, devm_edac_mc_free, mci))
+		return NULL;
+
+	return mci;
+}
+EXPORT_SYMBOL_GPL(devm_edac_mc_alloc);
+
 bool edac_has_mcs(void)
 {
 	bool ret;
@@ -828,6 +855,32 @@ struct mem_ctl_info *edac_mc_del_mc(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(edac_mc_del_mc);
 
+/**
+ * devm_edac_mc_del_mc() - Internal helper to call edac_mc_del_mc from a devres
+ *	action.
+ */
+static void devm_edac_mc_del_mc(void *dev)
+{
+	edac_mc_del_mc((struct device *)dev);
+}
+
+int devm_edac_mc_add_mc_with_groups(struct device *dev,
+                                    struct mem_ctl_info *mci,
+                                    const struct attribute_group **groups)
+{
+	int ret;
+
+	ret = edac_mc_add_mc_with_groups(mci, groups);
+	if (ret)
+		return ret;
+
+	if (devm_add_action_or_reset(dev, devm_edac_mc_del_mc, dev))
+		return 1;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_edac_mc_add_mc_with_groups);
+
 static void edac_mc_scrub_block(unsigned long page, unsigned long offset,
 				u32 size)
 {
diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index 5357800e418d..c89f4301ed3f 100644
--- a/drivers/edac/edac_mc.h
+++ b/drivers/edac/edac_mc.h
@@ -149,6 +149,32 @@ extern int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 extern void edac_mc_free(struct mem_ctl_info *mci);
 
 /**
+ * devm_edac_mc_alloc() - Helper to call edac_mc_alloc() and register it for
+ *	cleanup with devres.
+ *
+ * Returns:
+ *	On success, return a pointer to struct mem_ctl_info pointer;
+ *	%NULL otherwise
+ */
+struct mem_ctl_info *devm_edac_mc_alloc(struct device *dev,
+                                        unsigned mc_num,
+                                        unsigned n_layers,
+                                        struct edac_mc_layer *layers,
+                                        unsigned sz_pvt);
+
+/**
+ * devm_edac_mc_add_mc_with_groups() - Helper to call
+ *	edac_mc_add_mc_with_groups() and register it for cleanup with devres.
+ *
+ * Returns:
+ *	0 on Success, or an error code on failure
+ */
+int devm_edac_mc_add_mc_with_groups(struct device *dev,
+                                    struct mem_ctl_info *mci,
+                                    const struct attribute_group **groups);
+#define devm_edac_mc_add_mc(dev, mci)	devm_edac_mc_add_mc_with_groups(dev, mci, NULL)
+
+/**
  * edac_has_mcs() - Check if any MCs have been allocated.
  *
  * Returns:
-- 
2.11.0
