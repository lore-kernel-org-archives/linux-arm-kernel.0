From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 16 Aug 2016 15:38:24 +0100
Subject: [PATCH v2 2/2] remoteproc: core: Rework obtaining a rproc from a DT
 phandle
In-Reply-To: <20160816143824.4120-1-lee.jones@linaro.org>
References: <20160816143824.4120-1-lee.jones@linaro.org>
Message-ID: <20160816143824.4120-2-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In this patch we;
 - Use a subsystem generic phandle to obtain an rproc
   - We have to support TI's bespoke version for the time being
 - Convert wkup_m3_ipc driver to new API
 - Rename the call to be more like other, similar OF calls
 - Move feature-not-enabled inline stub to the headers
 - Strip out duplicate code by calling into of_get_rproc_by_index()

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---

v1 => v2:
 - Strip '_by_phandle' from function name

drivers/remoteproc/remoteproc_core.c | 41 ++++++++----------------------------
 drivers/soc/ti/wkup_m3_ipc.c         | 14 +++---------
 include/linux/remoteproc.h           |  4 ++--
 3 files changed, 14 insertions(+), 45 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index fe362fb..1c5d5d8 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1269,47 +1269,24 @@ struct rproc *of_get_rproc_by_name(struct device_node *np, const char *name)
 EXPORT_SYMBOL(of_get_rproc_by_name);
 
 /**
- * rproc_get_by_phandle() - find a remote processor by phandle
- * @phandle: phandle to the rproc
+ * of_get_rproc() - lookup and obtain a reference to an rproc
+ * @np: node to search for rproc
  *
- * Finds an rproc handle using the remote processor's phandle, and then
- * return a handle to the rproc.
+ * Finds an rproc handle using the default remote processor's phandle,
+ * and then returns a handle to the rproc.
  *
  * This function increments the remote processor's refcount, so always
  * use rproc_put() to decrement it back once rproc isn't needed anymore.
  *
- * Returns the rproc handle on success, and NULL on failure.
+ * Returns a pointer to the rproc struct on success or an appropriate error
+ * code otherwise.
  */
-struct rproc *rproc_get_by_phandle(phandle phandle)
-{
-	struct rproc *rproc = NULL, *r;
-	struct device_node *np;
-
-	np = of_find_node_by_phandle(phandle);
-	if (!np)
-		return NULL;
-
-	mutex_lock(&rproc_list_mutex);
-	list_for_each_entry(r, &rproc_list, node) {
-		if (r->dev.parent && r->dev.parent->of_node == np) {
-			rproc = r;
-			get_device(&rproc->dev);
-			break;
-		}
-	}
-	mutex_unlock(&rproc_list_mutex);
-
-	of_node_put(np);
-
-	return rproc;
-}
-#else
-struct rproc *rproc_get_by_phandle(phandle phandle)
+struct rproc *of_get_rproc(struct device_node *np)
 {
-	return NULL;
+	return of_get_rproc_by_index(np, 0);
 }
+EXPORT_SYMBOL(of_get_rproc);
 #endif
-EXPORT_SYMBOL(rproc_get_by_phandle);
 
 /**
  * rproc_add() - register a remote processor
diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 8823cc8..8518c16 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -385,7 +385,6 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	int irq, ret;
-	phandle rproc_phandle;
 	struct rproc *m3_rproc;
 	struct resource *res;
 	struct task_struct *task;
@@ -430,16 +429,9 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 		return PTR_ERR(m3_ipc->mbox);
 	}
 
-	if (of_property_read_u32(dev->of_node, "ti,rproc", &rproc_phandle)) {
-		dev_err(&pdev->dev, "could not get rproc phandle\n");
-		ret = -ENODEV;
-		goto err_free_mbox;
-	}
-
-	m3_rproc = rproc_get_by_phandle(rproc_phandle);
-	if (!m3_rproc) {
-		dev_err(&pdev->dev, "could not get rproc handle\n");
-		ret = -EPROBE_DEFER;
+	m3_rproc = of_get_rproc(dev->of_node);
+	if (IS_ERR(m3_rproc)) {
+		ret = PTR_ERR(m3_rproc);
 		goto err_free_mbox;
 	}
 
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index f130938..0e1adc9 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -515,7 +515,7 @@ extern struct rproc *of_get_rproc_by_index(struct device_node *np,
 					   int index);
 extern struct rproc *of_get_rproc_by_name(struct device_node *np,
 					  const char *name);
-extern struct rproc *rproc_get_by_phandle(phandle phandle);
+extern struct rproc *of_get_rproc(struct device_node *np);
 #else
 static inline
 struct rproc *of_get_rproc_by_index(struct device_node *np, int index)
@@ -528,7 +528,7 @@ struct rproc *of_get_rproc_by_name(struct device_node *np, const char *name)
 	return NULL;
 }
 static inline
-struct rproc *rproc_get_by_phandle(phandle phandle)
+struct rproc *of_get_rproc(struct device_node *np)
 {
 	return NULL;
 }
-- 
2.9.0
