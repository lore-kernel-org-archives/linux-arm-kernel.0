From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 16 Aug 2016 15:52:12 +0100
Subject: [PATCH 3/2+1] remoteproc: core: Move of_get_rproc() helper to header
In-Reply-To: <20160816143824.4120-1-lee.jones@linaro.org>
References: <20160816143824.4120-1-lee.jones@linaro.org>
Message-ID: <20160816145212.GA4254@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

remoteproc: core: Move of_get_rproc() helper to header

Since of_get_rproc() has been made a simple helper, we can move it
to the remoteproc.h and make it a 'static inline'.

Suggested-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 1c5d5d8..6966fb2 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1267,25 +1267,6 @@ struct rproc *of_get_rproc_by_name(struct device_node *np, const char *name)
 	return of_get_rproc_by_index(np, index);
 }
 EXPORT_SYMBOL(of_get_rproc_by_name);
-
-/**
- * of_get_rproc() - lookup and obtain a reference to an rproc
- * @np: node to search for rproc
- *
- * Finds an rproc handle using the default remote processor's phandle,
- * and then returns a handle to the rproc.
- *
- * This function increments the remote processor's refcount, so always
- * use rproc_put() to decrement it back once rproc isn't needed anymore.
- *
- * Returns a pointer to the rproc struct on success or an appropriate error
- * code otherwise.
- */
-struct rproc *of_get_rproc(struct device_node *np)
-{
-	return of_get_rproc_by_index(np, 0);
-}
-EXPORT_SYMBOL(of_get_rproc);
 #endif
 
 /**
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 0e1adc9..ec1cffd 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -515,7 +515,6 @@ extern struct rproc *of_get_rproc_by_index(struct device_node *np,
 					   int index);
 extern struct rproc *of_get_rproc_by_name(struct device_node *np,
 					  const char *name);
-extern struct rproc *of_get_rproc(struct device_node *np);
 #else
 static inline
 struct rproc *of_get_rproc_by_index(struct device_node *np, int index)
@@ -527,11 +526,24 @@ struct rproc *of_get_rproc_by_name(struct device_node *np, const char *name)
 {
 	return NULL;
 }
-static inline
-struct rproc *of_get_rproc(struct device_node *np)
+#endif /* CONFIG_OF */
+
+/**
+ * of_get_rproc() - lookup and obtain a reference to an rproc
+ * @np: node to search for rproc
+ *
+ * Finds an rproc handle using the default remote processor's phandle,
+ * and then returns a handle to the rproc.
+ *
+ * This function increments the remote processor's refcount, so always
+ * use rproc_put() to decrement it back once rproc isn't needed anymore.
+ *
+ * Returns a pointer to the rproc struct on success or an appropriate error
+ * code otherwise.
+ */
+static inline struct rproc *of_get_rproc(struct device_node *np)
 {
-	return NULL;
+	return of_get_rproc_by_index(np, 0);
 }
-#endif /* CONFIG_OF */
 
 #endif /* REMOTEPROC_H */
