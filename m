From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Sun,  2 Oct 2016 17:46:38 -0700
Subject: [PATCH 1/2] remoteproc: Split driver and consumer dereferencing
Message-ID: <1475455600-31689-1-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to be able to lock a rproc driver implementations only when
used by a client, we must differ between the dereference operation of a
client and the implementation itself.

This patch brings no functional change.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/remoteproc.txt          |  6 +++---
 drivers/remoteproc/da8xx_remoteproc.c |  4 ++--
 drivers/remoteproc/omap_remoteproc.c  |  4 ++--
 drivers/remoteproc/qcom_q6v5_pil.c    |  4 ++--
 drivers/remoteproc/qcom_wcnss.c       |  4 ++--
 drivers/remoteproc/remoteproc_core.c  | 21 ++++++++++++++++++---
 drivers/remoteproc/st_remoteproc.c    |  4 ++--
 drivers/remoteproc/ste_modem_rproc.c  |  4 ++--
 drivers/remoteproc/wkup_m3_rproc.c    |  4 ++--
 include/linux/remoteproc.h            |  1 +
 10 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/Documentation/remoteproc.txt b/Documentation/remoteproc.txt
index ef0219fa4bb4..f07597482351 100644
--- a/Documentation/remoteproc.txt
+++ b/Documentation/remoteproc.txt
@@ -101,9 +101,9 @@ int dummy_rproc_example(struct rproc *my_rproc)
       On success, the new rproc is returned, and on failure, NULL.
 
       Note: _never_ directly deallocate @rproc, even if it was not registered
-      yet. Instead, when you need to unroll rproc_alloc(), use rproc_put().
+      yet. Instead, when you need to unroll rproc_alloc(), use rproc_free().
 
-  void rproc_put(struct rproc *rproc)
+  void rproc_free(struct rproc *rproc)
     - Free an rproc handle that was allocated by rproc_alloc.
       This function essentially unrolls rproc_alloc(), by decrementing the
       rproc's refcount. It doesn't directly free rproc; that would happen
@@ -131,7 +131,7 @@ int dummy_rproc_example(struct rproc *my_rproc)
       has completed successfully.
 
       After rproc_del() returns, @rproc is still valid, and its
-      last refcount should be decremented by calling rproc_put().
+      last refcount should be decremented by calling rproc_free().
 
       Returns 0 on success and -EINVAL if @rproc isn't valid.
 
diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index 12823d078e1e..1afac8f31be0 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -261,7 +261,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 	return 0;
 
 free_rproc:
-	rproc_put(rproc);
+	rproc_free(rproc);
 
 	return ret;
 }
@@ -290,7 +290,7 @@ static int da8xx_rproc_remove(struct platform_device *pdev)
 	disable_irq(drproc->irq);
 
 	rproc_del(rproc);
-	rproc_put(rproc);
+	rproc_free(rproc);
 
 	return 0;
 }
diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index 01e234cb9157..fa63bf2eb885 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -215,7 +215,7 @@ static int omap_rproc_probe(struct platform_device *pdev)
 	return 0;
 
 free_rproc:
-	rproc_put(rproc);
+	rproc_free(rproc);
 	return ret;
 }
 
@@ -224,7 +224,7 @@ static int omap_rproc_remove(struct platform_device *pdev)
 	struct rproc *rproc = platform_get_drvdata(pdev);
 
 	rproc_del(rproc);
-	rproc_put(rproc);
+	rproc_free(rproc);
 
 	return 0;
 }
diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index 05b04573e87d..2e0caaaa766a 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -875,7 +875,7 @@ static int q6v5_probe(struct platform_device *pdev)
 	return 0;
 
 free_rproc:
-	rproc_put(rproc);
+	rproc_free(rproc);
 
 	return ret;
 }
@@ -885,7 +885,7 @@ static int q6v5_remove(struct platform_device *pdev)
 	struct q6v5 *qproc = platform_get_drvdata(pdev);
 
 	rproc_del(qproc->rproc);
-	rproc_put(qproc->rproc);
+	rproc_free(qproc->rproc);
 
 	return 0;
 }
diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index 1917de7db91c..f5cedeaafba1 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -585,7 +585,7 @@ static int wcnss_probe(struct platform_device *pdev)
 	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
 
 free_rproc:
-	rproc_put(rproc);
+	rproc_free(rproc);
 
 	return ret;
 }
@@ -598,7 +598,7 @@ static int wcnss_remove(struct platform_device *pdev)
 
 	qcom_smem_state_put(wcnss->state);
 	rproc_del(wcnss->rproc);
-	rproc_put(wcnss->rproc);
+	rproc_free(wcnss->rproc);
 
 	return 0;
 }
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 3da566b0d437..ede3af14b9d0 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1307,7 +1307,7 @@ static struct device_type rproc_type = {
  * On success the new rproc is returned, and on failure, NULL.
  *
  * Note: _never_ directly deallocate @rproc, even if it was not registered
- * yet. Instead, when you need to unroll rproc_alloc(), use rproc_put().
+ * yet. Instead, when you need to unroll rproc_alloc(), use rproc_free().
  */
 struct rproc *rproc_alloc(struct device *dev, const char *name,
 			  const struct rproc_ops *ops,
@@ -1386,7 +1386,22 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 EXPORT_SYMBOL(rproc_alloc);
 
 /**
- * rproc_put() - unroll rproc_alloc()
+ * rproc_free() - unroll rproc_alloc()
+ * @rproc: the remote processor handle
+ *
+ * This function decrements the rproc dev refcount.
+ *
+ * If no one holds any reference to rproc anymore, then its refcount would
+ * now drop to zero, and it would be freed.
+ */
+void rproc_free(struct rproc *rproc)
+{
+	put_device(&rproc->dev);
+}
+EXPORT_SYMBOL(rproc_free);
+
+/**
+ * rproc_put() - release rproc reference
  * @rproc: the remote processor handle
  *
  * This function decrements the rproc dev refcount.
@@ -1411,7 +1426,7 @@ EXPORT_SYMBOL(rproc_put);
  *
  * After rproc_del() returns, @rproc isn't freed yet, because
  * of the outstanding reference created by rproc_alloc. To decrement that
- * one last refcount, one still needs to call rproc_put().
+ * one last refcount, one still needs to call rproc_free().
  *
  * Returns 0 on success and -EINVAL if @rproc isn't valid.
  */
diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
index 6f056caa8a56..ae8963fcc8c8 100644
--- a/drivers/remoteproc/st_remoteproc.c
+++ b/drivers/remoteproc/st_remoteproc.c
@@ -262,7 +262,7 @@ static int st_rproc_probe(struct platform_device *pdev)
 	return 0;
 
 free_rproc:
-	rproc_put(rproc);
+	rproc_free(rproc);
 	return ret;
 }
 
@@ -277,7 +277,7 @@ static int st_rproc_remove(struct platform_device *pdev)
 
 	of_reserved_mem_device_release(&pdev->dev);
 
-	rproc_put(rproc);
+	rproc_free(rproc);
 
 	return 0;
 }
diff --git a/drivers/remoteproc/ste_modem_rproc.c b/drivers/remoteproc/ste_modem_rproc.c
index 53dc17bdd54e..03d69a9a3c5b 100644
--- a/drivers/remoteproc/ste_modem_rproc.c
+++ b/drivers/remoteproc/ste_modem_rproc.c
@@ -257,7 +257,7 @@ static int sproc_drv_remove(struct platform_device *pdev)
 	rproc_del(sproc->rproc);
 	dma_free_coherent(sproc->rproc->dev.parent, SPROC_FW_SIZE,
 			  sproc->fw_addr, sproc->fw_dma_addr);
-	rproc_put(sproc->rproc);
+	rproc_free(sproc->rproc);
 
 	mdev->drv_data = NULL;
 
@@ -325,7 +325,7 @@ static int sproc_probe(struct platform_device *pdev)
 free_rproc:
 	/* Reset device data upon error */
 	mdev->drv_data = NULL;
-	rproc_put(rproc);
+	rproc_free(rproc);
 	return err;
 }
 
diff --git a/drivers/remoteproc/wkup_m3_rproc.c b/drivers/remoteproc/wkup_m3_rproc.c
index 3811cb522af3..18175d0331fd 100644
--- a/drivers/remoteproc/wkup_m3_rproc.c
+++ b/drivers/remoteproc/wkup_m3_rproc.c
@@ -208,7 +208,7 @@ static int wkup_m3_rproc_probe(struct platform_device *pdev)
 	return 0;
 
 err_put_rproc:
-	rproc_put(rproc);
+	rproc_free(rproc);
 err:
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
@@ -220,7 +220,7 @@ static int wkup_m3_rproc_remove(struct platform_device *pdev)
 	struct rproc *rproc = platform_get_drvdata(pdev);
 
 	rproc_del(rproc);
-	rproc_put(rproc);
+	rproc_free(rproc);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index c321eab5054e..930023b7c825 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -493,6 +493,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 void rproc_put(struct rproc *rproc);
 int rproc_add(struct rproc *rproc);
 int rproc_del(struct rproc *rproc);
+void rproc_free(struct rproc *rproc);
 
 int rproc_boot(struct rproc *rproc);
 void rproc_shutdown(struct rproc *rproc);
-- 
2.5.0
