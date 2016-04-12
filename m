From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 12 Apr 2016 11:54:44 -0600
Subject: [PATCH V2 07/15] coresight: tmc: allocating memory when needed
In-Reply-To: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1460483692-25061-8-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In it's current form the TMC probe() function allocates
trace buffer memory at boot time, event if coresight isn't
used.  This is highly inefficient since trace buffers can
occupy a lot of memory that could be used otherwised.

This patch allocates trace buffers on the fly, when the
coresight subsystem is solicited.  Allocated buffers are
released when traces are read using the device descriptors
under /dev.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 85 +++++++++++++++++++++++--
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 83 +++++++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tmc.c     | 14 ----
 3 files changed, 163 insertions(+), 19 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 4b8f39bd478b..7cb287ef7b9e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -16,14 +16,12 @@
  */
 
 #include <linux/coresight.h>
+#include <linux/slab.h>
 #include "coresight-priv.h"
 #include "coresight-tmc.h"
 
 void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 {
-	/* Zero out the memory to help with debug */
-	memset(drvdata->buf, 0, drvdata->size);
-
 	CS_UNLOCK(drvdata->base);
 
 	/* Wait for TMCSReady bit to be set */
@@ -110,19 +108,68 @@ static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
 
 static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
 {
+	bool allocated = false;
+	char *buf = NULL;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
+	 /* This shouldn't be happening */
+	WARN_ON(mode != CS_MODE_SYSFS);
+
+	/*
+	 * If a buffer is already allocated *keep holding* the lock and
+	 * jump to the fast path.  Otherwise release the lock and allocate
+	 * memory to work with.
+	 */
 	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (drvdata->buf)
+		goto fast_path;
+
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	/* Allocating the memory here while outside of the spinlock */
+	buf = kzalloc(drvdata->size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* Let's try again */
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+fast_path:
 	if (drvdata->reading) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		/*
+		 * Free allocated memory outside of the spinlock.  There is
+		 * no need to assert the validity of 'buf' since calling
+		 * kfree(NULL) is safe.
+		 */
+		kfree(buf);
 		return -EBUSY;
 	}
 
+	/*
+	 * If drvdata::buf isn't NULL, memory was allocated for a previous
+	 * trace run but wasn't read.  If so simply zero-out the memory.
+	 * Otherwise use the memory allocated above.
+	 *
+	 * The memory is freed when users read the buffer using the
+	 * /dev/xyz.{etf|etb} interface.  See tmc_read_unprepare_etf() for
+	 * details.
+	 */
+	if (drvdata->buf) {
+		memset(drvdata->buf, 0, drvdata->size);
+	} else {
+		allocated = true;
+		drvdata->buf = buf;
+	}
+
 	tmc_etb_enable_hw(drvdata);
 	drvdata->enable = true;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
+	/* Free memory outside the spinlock if need be */
+	if (!allocated && buf)
+		kfree(buf);
+
 	dev_info(drvdata->dev, "TMC-ETB/ETF enabled\n");
 	return 0;
 }
@@ -223,6 +270,12 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 		goto out;
 	}
 
+	/* If drvdata::buf is NULL the trace data has been read already */
+	if (drvdata->buf == NULL) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/* Disable the TMC if need be */
 	if (drvdata->enable)
 		tmc_etb_disable_hw(drvdata);
@@ -236,6 +289,7 @@ out:
 
 int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
 {
+	char *buf = NULL;
 	enum tmc_mode mode;
 	unsigned long flags;
 
@@ -254,11 +308,34 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
 	}
 
 	/* Re-enable the TMC if need be */
-	if (drvdata->enable)
+	if (drvdata->enable) {
+		/*
+		 * The trace run will continue with the same allocated trace
+		 * buffer. As such zero-out the buffer so that we don't end
+		 * up with stale data.
+		 *
+		 * Since the tracer is still enabled drvdata::buf
+		 * can't be NULL.
+		 */
+		memset(drvdata->buf, 0, drvdata->size);
 		tmc_etb_enable_hw(drvdata);
+	} else {
+		/*
+		 * The ETB/ETF is not tracing and the buffer was just read.
+		 * As such prepare to free the trace buffer.
+		 */
+		buf = drvdata->buf;
+		drvdata->buf = NULL;
+	}
 
 	drvdata->reading = false;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
+	/*
+	 * Free allocated memory outside of the spinlock.  There is no need
+	 * to assert the validity of 'buf' since calling kfree(NULL) is safe.
+	 */
+	kfree(buf);
+
 	return 0;
 }
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 495540e9064d..6022ff26deba 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/coresight.h>
+#include <linux/dma-mapping.h>
 #include "coresight-priv.h"
 #include "coresight-tmc.h"
 
@@ -83,19 +84,69 @@ static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 
 static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
 {
+	bool allocated = false;
 	unsigned long flags;
+	void __iomem *vaddr = NULL;
+	dma_addr_t paddr;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
+	 /* This shouldn't be happening */
+	WARN_ON(mode != CS_MODE_SYSFS);
+
+	/*
+	 * If a buffer is already allocated *keep holding* the lock and
+	 * jump to the fast path.  Otherwise release the lock and allocate
+	 * memory to work with.
+	 */
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (drvdata->vaddr)
+		goto fast_path;
+
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
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
+	/* Let's try again */
 	spin_lock_irqsave(&drvdata->spinlock, flags);
+fast_path:
 	if (drvdata->reading) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		if (vaddr)
+			dma_free_coherent(drvdata->dev, drvdata->size,
+					  vaddr, paddr);
 		return -EBUSY;
 	}
 
+	/*
+	 * If drvdata::buf == NULL, use the memory allocated above.
+	 * Otherwise a buffer still exists from a previous session, so
+	 * simply use that.
+	 */
+	if (drvdata->buf == NULL) {
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
+	if (!allocated && vaddr)
+		dma_free_coherent(drvdata->dev, drvdata->size, vaddr, paddr);
+
 	dev_info(drvdata->dev, "TMC-ETR enabled\n");
 	return 0;
 }
@@ -137,6 +188,12 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
+	/* If drvdata::buf is NULL the trace data has been read already */
+	if (drvdata->buf == NULL) {
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return -EINVAL;
+	}
+
 	/* Disable the TMC if need be */
 	if (drvdata->enable)
 		tmc_etr_disable_hw(drvdata);
@@ -150,6 +207,8 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 {
 	unsigned long flags;
+	dma_addr_t paddr;
+	void __iomem *vaddr = NULL;
 
 	/* config types are set a boot time and never change */
 	if (drvdata->config_type != TMC_CONFIG_TYPE_ETR)
@@ -158,11 +217,33 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* RE-enable the TMC if need be */
-	if (drvdata->enable)
+	if (drvdata->enable) {
+		/*
+		 * The trace run will continue with the same allocated trace
+		 * buffer. As such zero-out the buffer so that we don't end
+		 * up with stale data.
+		 *
+		 * Since the tracer is still enabled drvdata::buf
+		 * can't be NULL.
+		 */
+		memset(drvdata->buf, 0, drvdata->size);
 		tmc_etr_enable_hw(drvdata);
+	} else {
+		/*
+		 * The ETR is not tracing and the buffer was just read.
+		 * As such prepare to free the trace buffer.
+		 */
+		vaddr = drvdata->vaddr;
+		paddr = drvdata->paddr;
+		drvdata->buf = NULL;
+	}
 
 	drvdata->reading = false;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
+	/* Free allocated memory out side of the spinlock */
+	if (vaddr)
+		dma_free_coherent(drvdata->dev, drvdata->size, vaddr, paddr);
+
 	return 0;
 }
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index f7e385f18e5f..ae336641518f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -319,20 +319,6 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 
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
2.5.0
