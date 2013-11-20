From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 20 Nov 2013 10:04:16 +0100
Subject: [PATCH 2/8] ASoC: fsl-ssi: Move sysfs stats to debugfs
In-Reply-To: <1384938262-20554-1-git-send-email-mpa@pengutronix.de>
References: <1384938262-20554-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1384938262-20554-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the worst case, the stats exposed via sysfs generate some irq load on
the system. In the best case, they show some statistics that are
interesting for developers. However, the interrupts and statistics are
not useful in general.

This patch moves the statistics to debugfs and disables interrupts
completely if the kernel is build without DEBUG_FS enabled.

While adding some error handling in the probe function, it fixes some
error jump labels.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 206 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 135 insertions(+), 71 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index fb8f52a..c2fc031 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -35,6 +35,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
@@ -112,6 +113,17 @@ static inline void write_ssi_mask(u32 __iomem *addr, u32 clear, u32 set)
 		    CCSR_SSI_SIER_TUE1_EN | CCSR_SSI_SIER_RFRC_EN | \
 		    CCSR_SSI_SIER_RDMAE | CCSR_SSI_SIER_RIE | \
 		    CCSR_SSI_SIER_ROE0_EN | CCSR_SSI_SIER_ROE1_EN)
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+#define FSLSSI_SIER_DBG_RX_FLAGS (CCSR_SSI_SIER_RFF0_EN | \
+		CCSR_SSI_SIER_RLS_EN | CCSR_SSI_SIER_RFS_EN | \
+		CCSR_SSI_SIER_ROE0_EN | CCSR_SSI_SIER_RDR0_EN | \
+		CCSR_SSI_SIER_RFRC_EN)
+#define FSLSSI_SIER_DBG_TX_FLAGS (CCSR_SSI_SIER_TFE0_EN | \
+		CCSR_SSI_SIER_TLS_EN | CCSR_SSI_SIER_TFS_EN | \
+		CCSR_SSI_SIER_TUE0_EN | CCSR_SSI_SIER_TDE0_EN | \
+		CCSR_SSI_SIER_TFRC_EN)
+#define FSLSSI_SISR_MASK (FSLSSI_SIER_DBG_RX_FLAGS | FSLSSI_SIER_DBG_TX_FLAGS)
+#endif
 
 /**
  * fsl_ssi_private: per-SSI private data
@@ -136,7 +148,6 @@ struct fsl_ssi_private {
 	struct snd_pcm_substream *second_stream;
 	unsigned int fifo_depth;
 	struct snd_soc_dai_driver cpu_dai_drv;
-	struct device_attribute dev_attr;
 	struct platform_device *pdev;
 
 	bool new_binding;
@@ -173,10 +184,13 @@ struct fsl_ssi_private {
 		unsigned int tfe1;
 		unsigned int tfe0;
 	} stats;
+	struct dentry *dbg_dir;
+	struct dentry *dbg_stats;
 
 	char name[1];
 };
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
 /**
  * fsl_ssi_isr: SSI interrupt handler
  *
@@ -201,7 +215,7 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 	   were interrupted for.  We mask it with the Interrupt Enable register
 	   so that we only check for events that we're interested in.
 	 */
-	sisr = read_ssi(&ssi->sisr) & SIER_FLAGS;
+	sisr = read_ssi(&ssi->sisr) & FSLSSI_SISR_MASK;
 
 	if (sisr & CCSR_SSI_SISR_RFRC) {
 		ssi_private->stats.rfrc++;
@@ -321,6 +335,101 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 	return ret;
 }
 
+/* Show the statistics of a flag only if its interrupt is enabled.  The
+ * compiler will optimze this code to a no-op if the interrupt is not
+ * enabled.
+ */
+#define SIER_SHOW(flag, name) \
+	do { \
+		if (FSLSSI_SISR_MASK & CCSR_SSI_SIER_##flag) \
+			seq_printf(s, #name "=%u\n", ssi_private->stats.name); \
+	} while (0)
+
+
+/**
+ * fsl_sysfs_ssi_show: display SSI statistics
+ *
+ * Display the statistics for the current SSI device.  To avoid confusion,
+ * we only show those counts that are enabled.
+ */
+static ssize_t fsl_ssi_stats_show(struct seq_file *s, void *unused)
+{
+	struct fsl_ssi_private *ssi_private = s->private;
+
+	SIER_SHOW(RFRC_EN, rfrc);
+	SIER_SHOW(TFRC_EN, tfrc);
+	SIER_SHOW(CMDAU_EN, cmdau);
+	SIER_SHOW(CMDDU_EN, cmddu);
+	SIER_SHOW(RXT_EN, rxt);
+	SIER_SHOW(RDR1_EN, rdr1);
+	SIER_SHOW(RDR0_EN, rdr0);
+	SIER_SHOW(TDE1_EN, tde1);
+	SIER_SHOW(TDE0_EN, tde0);
+	SIER_SHOW(ROE1_EN, roe1);
+	SIER_SHOW(ROE0_EN, roe0);
+	SIER_SHOW(TUE1_EN, tue1);
+	SIER_SHOW(TUE0_EN, tue0);
+	SIER_SHOW(TFS_EN, tfs);
+	SIER_SHOW(RFS_EN, rfs);
+	SIER_SHOW(TLS_EN, tls);
+	SIER_SHOW(RLS_EN, rls);
+	SIER_SHOW(RFF1_EN, rff1);
+	SIER_SHOW(RFF0_EN, rff0);
+	SIER_SHOW(TFE1_EN, tfe1);
+	SIER_SHOW(TFE0_EN, tfe0);
+
+	return 0;
+}
+
+static int fsl_ssi_stats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, fsl_ssi_stats_show, inode->i_private);
+}
+
+static const struct file_operations fsl_ssi_stats_ops = {
+	.open = fsl_ssi_stats_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int fsl_ssi_debugfs_create(struct fsl_ssi_private *ssi_private,
+		struct device *dev)
+{
+	ssi_private->dbg_dir = debugfs_create_dir(dev_name(dev), NULL);
+	if (!ssi_private->dbg_dir)
+		return -ENOMEM;
+
+	ssi_private->dbg_stats = debugfs_create_file("stats", S_IRUGO,
+			ssi_private->dbg_dir, ssi_private, &fsl_ssi_stats_ops);
+	if (!ssi_private->dbg_stats) {
+		debugfs_remove(ssi_private->dbg_dir);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void fsl_ssi_debugfs_remove(struct fsl_ssi_private *ssi_private)
+{
+	debugfs_remove(ssi_private->dbg_stats);
+	debugfs_remove(ssi_private->dbg_dir);
+}
+
+#else
+
+static int fsl_ssi_debugfs_create(struct fsl_ssi_private *ssi_private,
+		struct device *dev)
+{
+	return 0;
+}
+
+static void fsl_ssi_debugfs_remove(struct fsl_ssi_private *ssi_private)
+{
+}
+
+#endif /* IS_ENABLED(CONFIG_DEBUG_FS) */
+
 static void fsl_ssi_setup_ac97(struct fsl_ssi_private *ssi_private)
 {
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
@@ -795,56 +904,6 @@ static struct snd_ac97_bus_ops fsl_ssi_ac97_ops = {
 	.write		= fsl_ssi_ac97_write,
 };
 
-/* Show the statistics of a flag only if its interrupt is enabled.  The
- * compiler will optimze this code to a no-op if the interrupt is not
- * enabled.
- */
-#define SIER_SHOW(flag, name) \
-	do { \
-		if (SIER_FLAGS & CCSR_SSI_SIER_##flag) \
-			length += sprintf(buf + length, #name "=%u\n", \
-				ssi_private->stats.name); \
-	} while (0)
-
-
-/**
- * fsl_sysfs_ssi_show: display SSI statistics
- *
- * Display the statistics for the current SSI device.  To avoid confusion,
- * we only show those counts that are enabled.
- */
-static ssize_t fsl_sysfs_ssi_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
-{
-	struct fsl_ssi_private *ssi_private =
-		container_of(attr, struct fsl_ssi_private, dev_attr);
-	ssize_t length = 0;
-
-	SIER_SHOW(RFRC_EN, rfrc);
-	SIER_SHOW(TFRC_EN, tfrc);
-	SIER_SHOW(CMDAU_EN, cmdau);
-	SIER_SHOW(CMDDU_EN, cmddu);
-	SIER_SHOW(RXT_EN, rxt);
-	SIER_SHOW(RDR1_EN, rdr1);
-	SIER_SHOW(RDR0_EN, rdr0);
-	SIER_SHOW(TDE1_EN, tde1);
-	SIER_SHOW(TDE0_EN, tde0);
-	SIER_SHOW(ROE1_EN, roe1);
-	SIER_SHOW(ROE0_EN, roe0);
-	SIER_SHOW(TUE1_EN, tue1);
-	SIER_SHOW(TUE0_EN, tue0);
-	SIER_SHOW(TFS_EN, tfs);
-	SIER_SHOW(RFS_EN, rfs);
-	SIER_SHOW(TLS_EN, tls);
-	SIER_SHOW(RLS_EN, rls);
-	SIER_SHOW(RFF1_EN, rff1);
-	SIER_SHOW(RFF0_EN, rff0);
-	SIER_SHOW(TFE1_EN, tfe1);
-	SIER_SHOW(TFE0_EN, tfe0);
-
-	return length;
-}
-
 /**
  * Make every character in a string lower-case
  */
@@ -1008,7 +1067,10 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			dma_events[0], shared ? IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI);
 		imx_pcm_dma_params_init_data(&ssi_private->filter_data_rx,
 			dma_events[1], shared ? IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI);
-	} else if (ssi_private->use_dma) {
+	}
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	if (ssi_private->use_dma) {
 		/* The 'name' should not have any slashes in it. */
 		ret = devm_request_irq(&pdev->dev, ssi_private->irq,
 					fsl_ssi_isr, 0, ssi_private->name,
@@ -1019,20 +1081,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			goto error_irqmap;
 		}
 	}
-
-	/* Initialize the the device_attribute structure */
-	dev_attr = &ssi_private->dev_attr;
-	sysfs_attr_init(&dev_attr->attr);
-	dev_attr->attr.name = "statistics";
-	dev_attr->attr.mode = S_IRUGO;
-	dev_attr->show = fsl_sysfs_ssi_show;
-
-	ret = device_create_file(&pdev->dev, dev_attr);
-	if (ret) {
-		dev_err(&pdev->dev, "could not create sysfs %s file\n",
-			ssi_private->dev_attr.attr.name);
-		goto error_clk;
-	}
+#endif
 
 	/* Register with ASoC */
 	dev_set_drvdata(&pdev->dev, ssi_private);
@@ -1044,6 +1093,10 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		goto error_dev;
 	}
 
+	ret = fsl_ssi_debugfs_create(ssi_private, &pdev->dev);
+	if (ret)
+		goto error_dbgfs;
+
 	if (ssi_private->ssi_on_imx) {
 		if (!ssi_private->use_dma) {
 
@@ -1063,11 +1116,11 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 			ret = imx_pcm_fiq_init(pdev, &ssi_private->fiq_params);
 			if (ret)
-				goto error_dev;
+				goto error_pcm;
 		} else {
 			ret = imx_pcm_dma_init(pdev);
 			if (ret)
-				goto error_dev;
+				goto error_pcm;
 		}
 	}
 
@@ -1111,6 +1164,11 @@ done:
 error_dai:
 	if (ssi_private->ssi_on_imx)
 		imx_pcm_dma_exit(pdev);
+
+error_pcm:
+	fsl_ssi_debugfs_remove(ssi_private);
+
+error_dbgfs:
 	snd_soc_unregister_component(&pdev->dev);
 
 error_dev:
@@ -1121,7 +1179,10 @@ error_clk:
 		clk_disable_unprepare(ssi_private->clk);
 
 error_irqmap:
-	irq_dispose_mapping(ssi_private->irq);
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	if (ssi_private->use_dma)
+		irq_dispose_mapping(ssi_private->irq);
+#endif
 
 	return ret;
 }
@@ -1130,15 +1191,18 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 {
 	struct fsl_ssi_private *ssi_private = dev_get_drvdata(&pdev->dev);
 
+	fsl_ssi_debugfs_remove(ssi_private);
+
 	if (!ssi_private->new_binding)
 		platform_device_unregister(ssi_private->pdev);
 	if (ssi_private->ssi_on_imx)
 		imx_pcm_dma_exit(pdev);
 	snd_soc_unregister_component(&pdev->dev);
-	device_remove_file(&pdev->dev, &ssi_private->dev_attr);
 	if (ssi_private->ssi_on_imx)
 		clk_disable_unprepare(ssi_private->clk);
+#if IS_ENABLED(CONFIG_DEBUG_FS)
 	irq_dispose_mapping(ssi_private->irq);
+#endif
 
 	return 0;
 }
-- 
1.8.4.2
