From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 22 Mar 2016 14:23:16 -0600
Subject: [PATCH 08/14] coresight: tmc: allocating memory when needed
In-Reply-To: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
References: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1458678202-3447-9-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In it's current form the TMC probe() function allocates
trace buffer memory at boot time, event if coresight isn't
used.  This is highly inefficient since trace buffers can
occupy a lot of memory that could be used otherwised.

This patch allocates trace buffers on the fly, when the
coresight subsytem is sollicited.  Allocated buffers are
released when traces are read using the device descriptors
under /dev.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 97 ++++++++++++++++++++-----
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 97 ++++++++++++++++++++++---
 drivers/hwtracing/coresight/coresight-tmc.c     | 14 ----
 3 files changed, 164 insertions(+), 44 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index f9749924a055..e5d67e01409c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -16,14 +16,13 @@
  */
 
 #include <linux/coresight.h>
+#include <linux/slab.h>
+
 #include "coresight-priv.h"
 #include "coresight-tmc.h"
 
 void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 {
-	/* Zero out the memory to help with debug */
-	memset(drvdata->buf, 0, drvdata->size);
-
 	CS_UNLOCK(drvdata->base);
 
 	/* Wait for TMCSReady bit to be set */
@@ -109,19 +108,46 @@ static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
 
 static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
 {
+	bool allocated = false;
+	char *buf = NULL;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
+	/* Allocating the memory here while outside of the spinlock */
+	buf = devm_kzalloc(drvdata->dev, drvdata->size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		kfree(buf);
 		return -EBUSY;
 	}
 
+	/*
+	 * If drvdata::buf isn't NULL, memory was allocated for a previous
+	 * trace run but wasn't read.  If so simply zero-out the memory.
+	 *
+	 * The memory is freed when users read the buffer using the
+	 * /dev/xyz.{etf|etb} interface.  See tmc_read_unprepare_etf() for
+	 * details.
+	 */
+	if (!drvdata->buf) {
+		allocated = true;
+		drvdata->buf = buf;
+	} else {
+		memset(drvdata->buf, 0, drvdata->size);
+	}
+
 	tmc_etb_enable_hw(drvdata);
 	drvdata->enable = true;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
+	/* Free memory outside the spinlock if need be */
+	if (!allocated)
+		kfree(buf);
+
 	dev_info(drvdata->dev, "TMC-ETB/ETF enabled\n");
 	return 0;
 }
@@ -205,52 +231,75 @@ const struct coresight_ops tmc_etf_cs_ops = {
 
 int tmc_read_prepare_etf(struct tmc_drvdata *drvdata)
 {
-	int ret = 0;
 	enum tmc_mode mode;
 	unsigned long flags;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
-	/* The TMC isn't enable, so there is no need to disable it */
-	if (!drvdata->enable)
+	/* The TMC isn't enabled, so there is no need to disable it */
+	if (!drvdata->enable) {
+		/*
+		 * The ETB/ETF is disabled already.  If drvdata::buf is NULL
+		 * trace data has been harvested.
+		 */
+		if (!drvdata->buf) {
+			spin_unlock_irqrestore(&drvdata->spinlock, flags);
+			return -EINVAL;
+		}
+
 		goto out;
+	}
 
 	if (drvdata->config_type != TMC_CONFIG_TYPE_ETB &&
 	    drvdata->config_type != TMC_CONFIG_TYPE_ETF) {
-		ret = -EINVAL;
-		goto out;
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return -EINVAL;
 	}
 
 	/* There is no point in reading a TMC in HW FIFO mode */
 	mode = readl_relaxed(drvdata->base + TMC_MODE);
 	if (mode != TMC_MODE_CIRCULAR_BUFFER) {
-		ret = -EINVAL;
-		goto out;
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return -EINVAL;
 	}
 
 	tmc_etb_disable_hw(drvdata);
-	drvdata->reading = true;
+	tmc_etb_dump_hw(drvdata);
 
 out:
+	drvdata->reading = true;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-	return ret;
+	return 0;
 }
 
 int tmc_read_unprepare_etf(struct tmc_drvdata *drvdata)
 {
 	int ret = 0;
+	char *buf = NULL;
 	enum tmc_mode mode;
 	unsigned long flags;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
-	/* The TMC isn't enable, so there is no need to enable it */
-	if (!drvdata->enable)
-		goto out;
-
 	if (drvdata->config_type != TMC_CONFIG_TYPE_ETB &&
 	    drvdata->config_type != TMC_CONFIG_TYPE_ETF) {
 		ret = -EINVAL;
+		goto err;
+	}
+
+	/* The TMC isn't enabled, so there is no need to enable it */
+	if (!drvdata->enable) {
+		/*
+		 * The ETB/ETF is not tracing and the buffer was just read.
+		 * As such prepare to free the trace buffer.
+		 */
+		buf = drvdata->buf;
+
+		/*
+		 * drvdata::buf is switched on in tmc_read_prepare_etf() so
+		 * it is important to set it back to NULL.
+		 */
+		drvdata->buf = NULL;
 		goto out;
 	}
 
@@ -258,13 +307,25 @@ int tmc_read_unprepare_etf(struct tmc_drvdata *drvdata)
 	mode = readl_relaxed(drvdata->base + TMC_MODE);
 	if (mode != TMC_MODE_CIRCULAR_BUFFER) {
 		ret = -EINVAL;
-		goto out;
+		goto err;
 	}
 
+	/*
+	 * The trace run will continue with the same allocated trace buffer.
+	 * As such zero-out the buffer so that we don't end up with stale
+	 * data.
+	 */
+	memset(drvdata->buf, 0, drvdata->size);
 	tmc_etb_enable_hw(drvdata);
-	drvdata->reading = false;
 
 out:
+	drvdata->reading = false;
+
+err:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	/* Free allocated memory outside of the spinlock */
+	kfree(buf);
+
 	return ret;
 }
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 67e7d5dd891f..c4962568276e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -16,6 +16,8 @@
  */
 
 #include <linux/coresight.h>
+#include <linux/dma-mapping.h>
+
 #include "coresight-priv.h"
 #include "coresight-tmc.h"
 
@@ -82,19 +84,51 @@ static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 
 static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
 {
+	bool allocated = false;
 	unsigned long flags;
+	void __iomem *vaddr;
+	dma_addr_t paddr;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
+	/*
+	 * Contiguous  memory can't be allocated while a spinlock is held.
+	 * As such allocate memory here and free it if a buffer has already
+	 * been allocated (from a previous session).
+	 */
+	vaddr = dma_alloc_coherent(drvdata->dev, drvdata->size,
+				   &paddr, GFP_KERNEL);
+	if (!vaddr)
+		return -ENOMEM;
+
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		dma_free_coherent(drvdata->dev, drvdata->size, vaddr, paddr);
 		return -EBUSY;
 	}
 
+	/*
+	 * If drvdata::buf == NULL, use the memory allocated above.
+	 * Otherwise a buffer still exists from a previous session, so
+	 * simply use that.
+	 */
+	if (!drvdata->buf) {
+		allocated = true;
+		drvdata->vaddr = vaddr;
+		drvdata->paddr = paddr;
+		drvdata->buf = drvdata->vaddr;
+	}
+
+	memset(drvdata->vaddr, 0, drvdata->size);
+
 	tmc_etr_enable_hw(drvdata);
 	drvdata->enable = true;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
+	/* Free memory outside the spinlock if need be */
+	if (!allocated)
+		dma_free_coherent(drvdata->dev, drvdata->size, vaddr, paddr);
+
 	dev_info(drvdata->dev, "TMC-ETR enabled\n");
 	return 0;
 }
@@ -129,48 +163,87 @@ const struct coresight_ops tmc_etr_cs_ops = {
 
 int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 {
-	int ret = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
-	/* The TMC isn't enable, so there is no need to disable it */
-	if (!drvdata->enable)
+	/* The TMC isn't enabled, so there is no need to disable it */
+	if (!drvdata->enable) {
+		/*
+		 * The ETR is disabled already.  If drvdata::buf is NULL
+		 * trace data has been harvested.
+		 */
+		if (!drvdata->buf) {
+			spin_unlock_irqrestore(&drvdata->spinlock, flags);
+			return -EINVAL;
+		}
+
 		goto out;
+	}
 
 	if (drvdata->config_type != TMC_CONFIG_TYPE_ETR) {
-		ret = -EINVAL;
-		goto out;
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return -EINVAL;
 	}
 
 	tmc_etr_disable_hw(drvdata);
-	drvdata->reading = true;
+	tmc_etr_dump_hw(drvdata);
 
 out:
+	drvdata->reading = true;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-	return ret;
+	return 0;
 }
 
 int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 {
 	int ret = 0;
 	unsigned long flags;
+	void __iomem *vaddr = NULL;
+	dma_addr_t paddr;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
-	/* The TMC isn't enable, so there is no need to enable it */
-	if (!drvdata->enable)
-		goto out;
-
 	if (drvdata->config_type != TMC_CONFIG_TYPE_ETR) {
 		ret = -EINVAL;
+		goto err;
+	}
+
+	/* The TMC isn't enabled, so there is no need to enable it */
+	if (!drvdata->enable) {
+		/*
+		 * The ETR is not tracing and trace data was just read. As
+		 * such prepare to free the trace buffer.
+		 */
+		vaddr = drvdata->vaddr;
+		paddr = drvdata->paddr;
+
+		/*
+		 * drvdata::buf is switched on in tmc_read_prepare_etr() and
+		 * tmc_enable_etr_sink so it is important to set it back to
+		 * NULL.
+		 */
+		drvdata->buf = NULL;
 		goto out;
 	}
 
+	/*
+	 * The trace run will continue with the same allocated trace buffer.
+	 * As such zero-out the buffer so that we don't end up with stale
+	 * data.
+	 */
+	memset(drvdata->buf, 0, drvdata->size);
 	tmc_etr_enable_hw(drvdata);
-	drvdata->reading = false;
 
 out:
+	drvdata->reading = false;
+
+err:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	/* Free allocated memory out side of the spinlock */
+	if (vaddr)
+		dma_free_coherent(drvdata->dev, drvdata->size, vaddr, paddr);
+
 	return ret;
 }
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 26dbef305851..c614fe160f8a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -318,20 +318,6 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 
 	pm_runtime_put(&adev->dev);
 
-	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
-		drvdata->vaddr = dma_alloc_coherent(dev, drvdata->size,
-						&drvdata->paddr, GFP_KERNEL);
-		if (!drvdata->vaddr)
-			return -ENOMEM;
-
-		memset(drvdata->vaddr, 0, drvdata->size);
-		drvdata->buf = drvdata->vaddr;
-	} else {
-		drvdata->buf = devm_kzalloc(dev, drvdata->size, GFP_KERNEL);
-		if (!drvdata->buf)
-			return -ENOMEM;
-	}
-
 	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
 	if (!desc) {
 		ret = -ENOMEM;
-- 
2.1.4
