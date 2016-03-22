From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 22 Mar 2016 14:23:13 -0600
Subject: [PATCH 05/14] coresight: tmc: splitting driver in ETB/ETF and ETR
 components
In-Reply-To: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
References: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1458678202-3447-6-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TMC block can operate in 3 modes (ETB, ETF and ETR) and accessed
via two interfaces (sysFS and Perf).  That makes 6 mode to cover, which
is way too much coupling for a single file.

This patch splits the original TMC driver in 2 halves, one for ETB/ETF
and another one for ETR mode.  A common core is kept for functionality
common to all 3 modes.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Makefile            |   4 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 204 ++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 128 ++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.c     | 264 +-----------------------
 drivers/hwtracing/coresight/coresight-tmc.h     |  18 ++
 5 files changed, 357 insertions(+), 261 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-tmc-etf.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tmc-etr.c

diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 1d0e32c7dbe4..0cf842ea3fe2 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -3,7 +3,9 @@
 #
 obj-$(CONFIG_CORESIGHT) += coresight.o coresight-etm-perf.o
 obj-$(CONFIG_OF) += of_coresight.o
-obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
+obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o \
+					     coresight-tmc-etf.o \
+					     coresight-tmc-etr.o
 obj-$(CONFIG_CORESIGHT_SINK_TPIU) += coresight-tpiu.o
 obj-$(CONFIG_CORESIGHT_SINK_ETBV10) += coresight-etb10.o
 obj-$(CONFIG_CORESIGHT_LINKS_AND_SINKS) += coresight-funnel.o \
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
new file mode 100644
index 000000000000..467d19221f7b
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -0,0 +1,204 @@
+/*
+ * Copyright(C) 2016 Linaro Limited. All rights reserved.
+ * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/coresight.h>
+#include "coresight-priv.h"
+#include "coresight-tmc.h"
+
+void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
+{
+	/* Zero out the memory to help with debug */
+	memset(drvdata->buf, 0, drvdata->size);
+
+	CS_UNLOCK(drvdata->base);
+
+	/* Wait for TMCSReady bit to be set */
+	tmc_wait_for_tmcready(drvdata);
+
+	writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
+	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
+		       TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
+		       TMC_FFCR_TRIGON_TRIGIN,
+		       drvdata->base + TMC_FFCR);
+
+	writel_relaxed(drvdata->trigger_cntr, drvdata->base + TMC_TRG);
+	tmc_enable_hw(drvdata);
+
+	CS_LOCK(drvdata->base);
+}
+
+static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
+{
+	enum tmc_mem_intf_width memwidth;
+	u8 memwords;
+	char *bufp;
+	u32 read_data;
+	int i;
+
+	memwidth = BMVAL(readl_relaxed(drvdata->base + CORESIGHT_DEVID), 8, 10);
+	if (memwidth == TMC_MEM_INTF_WIDTH_32BITS)
+		memwords = 1;
+	else if (memwidth == TMC_MEM_INTF_WIDTH_64BITS)
+		memwords = 2;
+	else if (memwidth == TMC_MEM_INTF_WIDTH_128BITS)
+		memwords = 4;
+	else
+		memwords = 8;
+
+	bufp = drvdata->buf;
+	while (1) {
+		for (i = 0; i < memwords; i++) {
+			read_data = readl_relaxed(drvdata->base + TMC_RRD);
+			if (read_data == 0xFFFFFFFF)
+				return;
+			memcpy(bufp, &read_data, 4);
+			bufp += 4;
+		}
+	}
+}
+
+void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
+{
+	CS_UNLOCK(drvdata->base);
+
+	tmc_flush_and_stop(drvdata);
+	tmc_etb_dump_hw(drvdata);
+	tmc_disable_hw(drvdata);
+
+	CS_LOCK(drvdata->base);
+}
+
+static void tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
+{
+	CS_UNLOCK(drvdata->base);
+
+	/* Wait for TMCSReady bit to be set */
+	tmc_wait_for_tmcready(drvdata);
+
+	writel_relaxed(TMC_MODE_HARDWARE_FIFO, drvdata->base + TMC_MODE);
+	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI,
+		       drvdata->base + TMC_FFCR);
+	writel_relaxed(0x0, drvdata->base + TMC_BUFWM);
+	tmc_enable_hw(drvdata);
+
+	CS_LOCK(drvdata->base);
+}
+
+static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
+{
+	CS_UNLOCK(drvdata->base);
+
+	tmc_flush_and_stop(drvdata);
+	tmc_disable_hw(drvdata);
+
+	CS_LOCK(drvdata->base);
+}
+
+static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
+{
+	unsigned long flags;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (drvdata->reading) {
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return -EBUSY;
+	}
+
+	tmc_etb_enable_hw(drvdata);
+	drvdata->enable = true;
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	dev_info(drvdata->dev, "TMC-ETB/ETF enabled\n");
+	return 0;
+}
+
+static void tmc_disable_etf_sink(struct coresight_device *csdev)
+{
+	unsigned long flags;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (drvdata->reading) {
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return;
+	}
+
+	tmc_etb_disable_hw(drvdata);
+	drvdata->enable = false;
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	dev_info(drvdata->dev, "TMC-ETB/ETF disabled\n");
+}
+
+static int tmc_enable_etf_link(struct coresight_device *csdev,
+			       int inport, int outport)
+{
+	unsigned long flags;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (drvdata->reading) {
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return -EBUSY;
+	}
+
+	tmc_etf_enable_hw(drvdata);
+	drvdata->enable = true;
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	dev_info(drvdata->dev, "TMC-ETF enabled\n");
+	return 0;
+}
+
+static void tmc_disable_etf_link(struct coresight_device *csdev,
+				 int inport, int outport)
+{
+	unsigned long flags;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (drvdata->reading) {
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return;
+	}
+
+	tmc_etf_disable_hw(drvdata);
+	drvdata->enable = false;
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	dev_info(drvdata->dev, "TMC disabled\n");
+}
+
+static const struct coresight_ops_sink tmc_etf_sink_ops = {
+	.enable		= tmc_enable_etf_sink,
+	.disable	= tmc_disable_etf_sink,
+};
+
+static const struct coresight_ops_link tmc_etf_link_ops = {
+	.enable		= tmc_enable_etf_link,
+	.disable	= tmc_disable_etf_link,
+};
+
+const struct coresight_ops tmc_etb_cs_ops = {
+	.sink_ops	= &tmc_etf_sink_ops,
+};
+
+const struct coresight_ops tmc_etf_cs_ops = {
+	.sink_ops	= &tmc_etf_sink_ops,
+	.link_ops	= &tmc_etf_link_ops,
+};
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
new file mode 100644
index 000000000000..910d6f3b7d26
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -0,0 +1,128 @@
+/*
+ * Copyright(C) 2016 Linaro Limited. All rights reserved.
+ * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/coresight.h>
+#include "coresight-priv.h"
+#include "coresight-tmc.h"
+
+void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
+{
+	u32 axictl;
+
+	/* Zero out the memory to help with debug */
+	memset(drvdata->vaddr, 0, drvdata->size);
+
+	CS_UNLOCK(drvdata->base);
+
+	/* Wait for TMCSReady bit to be set */
+	tmc_wait_for_tmcready(drvdata);
+
+	writel_relaxed(drvdata->size / 4, drvdata->base + TMC_RSZ);
+	writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
+
+	axictl = readl_relaxed(drvdata->base + TMC_AXICTL);
+	axictl |= TMC_AXICTL_WR_BURST_LEN;
+	writel_relaxed(axictl, drvdata->base + TMC_AXICTL);
+	axictl &= ~TMC_AXICTL_SCT_GAT_MODE;
+	writel_relaxed(axictl, drvdata->base + TMC_AXICTL);
+	axictl = (axictl &
+		  ~(TMC_AXICTL_PROT_CTL_B0 | TMC_AXICTL_PROT_CTL_B1)) |
+		  TMC_AXICTL_PROT_CTL_B1;
+	writel_relaxed(axictl, drvdata->base + TMC_AXICTL);
+
+	writel_relaxed(drvdata->paddr, drvdata->base + TMC_DBALO);
+	writel_relaxed(0x0, drvdata->base + TMC_DBAHI);
+	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
+		       TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
+		       TMC_FFCR_TRIGON_TRIGIN,
+		       drvdata->base + TMC_FFCR);
+	writel_relaxed(drvdata->trigger_cntr, drvdata->base + TMC_TRG);
+	tmc_enable_hw(drvdata);
+
+	CS_LOCK(drvdata->base);
+}
+
+static void tmc_etr_dump_hw(struct tmc_drvdata *drvdata)
+{
+	u32 rwp, val;
+
+	rwp = readl_relaxed(drvdata->base + TMC_RWP);
+	val = readl_relaxed(drvdata->base + TMC_STS);
+
+	/* How much memory do we still have */
+	if (val & BIT(0))
+		drvdata->buf = drvdata->vaddr + rwp - drvdata->paddr;
+	else
+		drvdata->buf = drvdata->vaddr;
+}
+
+void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
+{
+	CS_UNLOCK(drvdata->base);
+
+	tmc_flush_and_stop(drvdata);
+	tmc_etr_dump_hw(drvdata);
+	tmc_disable_hw(drvdata);
+
+	CS_LOCK(drvdata->base);
+}
+
+static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
+{
+	unsigned long flags;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (drvdata->reading) {
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return -EBUSY;
+	}
+
+	tmc_etr_enable_hw(drvdata);
+	drvdata->enable = true;
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	dev_info(drvdata->dev, "TMC-ETR enabled\n");
+	return 0;
+}
+
+static void tmc_disable_etr_sink(struct coresight_device *csdev)
+{
+	unsigned long flags;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (drvdata->reading) {
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return;
+	}
+
+	tmc_etr_disable_hw(drvdata);
+	drvdata->enable = false;
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	dev_info(drvdata->dev, "TMC-ETR disabled\n");
+}
+
+static const struct coresight_ops_sink tmc_etr_sink_ops = {
+	.enable		= tmc_enable_etr_sink,
+	.disable	= tmc_disable_etr_sink,
+};
+
+const struct coresight_ops tmc_etr_cs_ops = {
+	.sink_ops	= &tmc_etr_sink_ops,
+};
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 64f744724d00..bc31131e4bd5 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -31,7 +31,7 @@
 #include "coresight-priv.h"
 #include "coresight-tmc.h"
 
-static void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
+void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
 {
 	/* Ensure formatter, unformatter and hardware fifo are empty */
 	if (coresight_timeout(drvdata->base,
@@ -42,7 +42,7 @@ static void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
 	}
 }
 
-static void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
+void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
 {
 	u32 ffcr;
 
@@ -62,272 +62,16 @@ static void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
 	tmc_wait_for_tmcready(drvdata);
 }
 
-static void tmc_enable_hw(struct tmc_drvdata *drvdata)
+void tmc_enable_hw(struct tmc_drvdata *drvdata)
 {
 	writel_relaxed(TMC_CTL_CAPT_EN, drvdata->base + TMC_CTL);
 }
 
-static void tmc_disable_hw(struct tmc_drvdata *drvdata)
+void tmc_disable_hw(struct tmc_drvdata *drvdata)
 {
 	writel_relaxed(0x0, drvdata->base + TMC_CTL);
 }
 
-static void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
-{
-	/* Zero out the memory to help with debug */
-	memset(drvdata->buf, 0, drvdata->size);
-
-	CS_UNLOCK(drvdata->base);
-
-	/* Wait for TMCSReady bit to be set */
-	tmc_wait_for_tmcready(drvdata);
-
-	writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
-	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
-		       TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
-		       TMC_FFCR_TRIGON_TRIGIN,
-		       drvdata->base + TMC_FFCR);
-
-	writel_relaxed(drvdata->trigger_cntr, drvdata->base + TMC_TRG);
-	tmc_enable_hw(drvdata);
-
-	CS_LOCK(drvdata->base);
-}
-
-static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
-{
-	u32 axictl;
-
-	/* Zero out the memory to help with debug */
-	memset(drvdata->vaddr, 0, drvdata->size);
-
-	CS_UNLOCK(drvdata->base);
-
-	/* Wait for TMCSReady bit to be set */
-	tmc_wait_for_tmcready(drvdata);
-
-	writel_relaxed(drvdata->size / 4, drvdata->base + TMC_RSZ);
-	writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
-
-	axictl = readl_relaxed(drvdata->base + TMC_AXICTL);
-	axictl |= TMC_AXICTL_WR_BURST_LEN;
-	writel_relaxed(axictl, drvdata->base + TMC_AXICTL);
-	axictl &= ~TMC_AXICTL_SCT_GAT_MODE;
-	writel_relaxed(axictl, drvdata->base + TMC_AXICTL);
-	axictl = (axictl &
-		  ~(TMC_AXICTL_PROT_CTL_B0 | TMC_AXICTL_PROT_CTL_B1)) |
-		  TMC_AXICTL_PROT_CTL_B1;
-	writel_relaxed(axictl, drvdata->base + TMC_AXICTL);
-
-	writel_relaxed(drvdata->paddr, drvdata->base + TMC_DBALO);
-	writel_relaxed(0x0, drvdata->base + TMC_DBAHI);
-	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
-		       TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
-		       TMC_FFCR_TRIGON_TRIGIN,
-		       drvdata->base + TMC_FFCR);
-	writel_relaxed(drvdata->trigger_cntr, drvdata->base + TMC_TRG);
-	tmc_enable_hw(drvdata);
-
-	CS_LOCK(drvdata->base);
-}
-
-static void tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
-{
-	CS_UNLOCK(drvdata->base);
-
-	/* Wait for TMCSReady bit to be set */
-	tmc_wait_for_tmcready(drvdata);
-
-	writel_relaxed(TMC_MODE_HARDWARE_FIFO, drvdata->base + TMC_MODE);
-	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI,
-		       drvdata->base + TMC_FFCR);
-	writel_relaxed(0x0, drvdata->base + TMC_BUFWM);
-	tmc_enable_hw(drvdata);
-
-	CS_LOCK(drvdata->base);
-}
-
-static int tmc_enable(struct tmc_drvdata *drvdata, enum tmc_mode mode)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (drvdata->reading) {
-		spin_unlock_irqrestore(&drvdata->spinlock, flags);
-		return -EBUSY;
-	}
-
-	if (drvdata->config_type == TMC_CONFIG_TYPE_ETB) {
-		tmc_etb_enable_hw(drvdata);
-	} else if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
-		tmc_etr_enable_hw(drvdata);
-	} else {
-		if (mode == TMC_MODE_CIRCULAR_BUFFER)
-			tmc_etb_enable_hw(drvdata);
-		else
-			tmc_etf_enable_hw(drvdata);
-	}
-	drvdata->enable = true;
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-
-	dev_info(drvdata->dev, "TMC enabled\n");
-	return 0;
-}
-
-static int tmc_enable_sink(struct coresight_device *csdev, u32 mode)
-{
-	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	return tmc_enable(drvdata, TMC_MODE_CIRCULAR_BUFFER);
-}
-
-static int tmc_enable_link(struct coresight_device *csdev, int inport,
-			   int outport)
-{
-	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	return tmc_enable(drvdata, TMC_MODE_HARDWARE_FIFO);
-}
-
-static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
-{
-	enum tmc_mem_intf_width memwidth;
-	u8 memwords;
-	char *bufp;
-	u32 read_data;
-	int i;
-
-	memwidth = BMVAL(readl_relaxed(drvdata->base + CORESIGHT_DEVID), 8, 10);
-	if (memwidth == TMC_MEM_INTF_WIDTH_32BITS)
-		memwords = 1;
-	else if (memwidth == TMC_MEM_INTF_WIDTH_64BITS)
-		memwords = 2;
-	else if (memwidth == TMC_MEM_INTF_WIDTH_128BITS)
-		memwords = 4;
-	else
-		memwords = 8;
-
-	bufp = drvdata->buf;
-	while (1) {
-		for (i = 0; i < memwords; i++) {
-			read_data = readl_relaxed(drvdata->base + TMC_RRD);
-			if (read_data == 0xFFFFFFFF)
-				return;
-			memcpy(bufp, &read_data, 4);
-			bufp += 4;
-		}
-	}
-}
-
-static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
-{
-	CS_UNLOCK(drvdata->base);
-
-	tmc_flush_and_stop(drvdata);
-	tmc_etb_dump_hw(drvdata);
-	tmc_disable_hw(drvdata);
-
-	CS_LOCK(drvdata->base);
-}
-
-static void tmc_etr_dump_hw(struct tmc_drvdata *drvdata)
-{
-	u32 rwp, val;
-
-	rwp = readl_relaxed(drvdata->base + TMC_RWP);
-	val = readl_relaxed(drvdata->base + TMC_STS);
-
-	/* How much memory do we still have */
-	if (val & BIT(0))
-		drvdata->buf = drvdata->vaddr + rwp - drvdata->paddr;
-	else
-		drvdata->buf = drvdata->vaddr;
-}
-
-static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
-{
-	CS_UNLOCK(drvdata->base);
-
-	tmc_flush_and_stop(drvdata);
-	tmc_etr_dump_hw(drvdata);
-	tmc_disable_hw(drvdata);
-
-	CS_LOCK(drvdata->base);
-}
-
-static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
-{
-	CS_UNLOCK(drvdata->base);
-
-	tmc_flush_and_stop(drvdata);
-	tmc_disable_hw(drvdata);
-
-	CS_LOCK(drvdata->base);
-}
-
-static void tmc_disable(struct tmc_drvdata *drvdata, enum tmc_mode mode)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (drvdata->reading)
-		goto out;
-
-	if (drvdata->config_type == TMC_CONFIG_TYPE_ETB) {
-		tmc_etb_disable_hw(drvdata);
-	} else if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
-		tmc_etr_disable_hw(drvdata);
-	} else {
-		if (mode == TMC_MODE_CIRCULAR_BUFFER)
-			tmc_etb_disable_hw(drvdata);
-		else
-			tmc_etf_disable_hw(drvdata);
-	}
-out:
-	drvdata->enable = false;
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-
-	dev_info(drvdata->dev, "TMC disabled\n");
-}
-
-static void tmc_disable_sink(struct coresight_device *csdev)
-{
-	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	tmc_disable(drvdata, TMC_MODE_CIRCULAR_BUFFER);
-}
-
-static void tmc_disable_link(struct coresight_device *csdev, int inport,
-			     int outport)
-{
-	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	tmc_disable(drvdata, TMC_MODE_HARDWARE_FIFO);
-}
-
-static const struct coresight_ops_sink tmc_sink_ops = {
-	.enable		= tmc_enable_sink,
-	.disable	= tmc_disable_sink,
-};
-
-static const struct coresight_ops_link tmc_link_ops = {
-	.enable		= tmc_enable_link,
-	.disable	= tmc_disable_link,
-};
-
-static const struct coresight_ops tmc_etb_cs_ops = {
-	.sink_ops	= &tmc_sink_ops,
-};
-
-static const struct coresight_ops tmc_etr_cs_ops = {
-	.sink_ops	= &tmc_sink_ops,
-};
-
-static const struct coresight_ops tmc_etf_cs_ops = {
-	.sink_ops	= &tmc_sink_ops,
-	.link_ops	= &tmc_link_ops,
-};
-
 static int tmc_read_prepare(struct tmc_drvdata *drvdata)
 {
 	int ret = 0;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 2d7d52747b4e..b99d4dfc1d0b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -18,6 +18,8 @@
 #ifndef _CORESIGHT_TMC_H
 #define _CORESIGHT_TMC_H
 
+#include <linux/miscdevice.h>
+
 #define TMC_RSZ			0x004
 #define TMC_STS			0x00c
 #define TMC_RRD			0x010
@@ -119,4 +121,20 @@ struct tmc_drvdata {
 	u32			trigger_cntr;
 };
 
+/* Generic functions */
+void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata);
+void tmc_flush_and_stop(struct tmc_drvdata *drvdata);
+void tmc_enable_hw(struct tmc_drvdata *drvdata);
+void tmc_disable_hw(struct tmc_drvdata *drvdata);
+
+/* ETB/ETF functions */
+void tmc_etb_enable_hw(struct tmc_drvdata *drvdata);
+void tmc_etb_disable_hw(struct tmc_drvdata *drvdata);
+extern const struct coresight_ops tmc_etb_cs_ops;
+extern const struct coresight_ops tmc_etf_cs_ops;
+
+/* ETR functions */
+void tmc_etr_enable_hw(struct tmc_drvdata *drvdata);
+void tmc_etr_disable_hw(struct tmc_drvdata *drvdata);
+extern const struct coresight_ops tmc_etr_cs_ops;
 #endif
-- 
2.1.4
