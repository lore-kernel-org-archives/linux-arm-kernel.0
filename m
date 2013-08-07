From: zonque@gmail.com (Daniel Mack)
Date: Wed,  7 Aug 2013 12:19:23 +0200
Subject: [PATCH 05/12] dma: mmp_pdma: add filter function
In-Reply-To: <1375870770-14263-1-git-send-email-zonque@gmail.com>
References: <1375870770-14263-1-git-send-email-zonque@gmail.com>
Message-ID: <1375870770-14263-6-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PXA peripherals need to obtain specific DMA request ids which will
eventually be stored in the DRCMR register.

Currently, clients are expected to store that number inside the slave
config block as slave_id, which is unfortunately incompatible with the
way DMA resources are handled in DT environments.

This patch adds a filter function which stores the filter parameter
passed in by of-dma.c into the channel's drcmr register.

For backward compatability, cfg->slave_id is still used if set to
a non-zero value.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/mmp_pdma.c       | 21 ++++++++++++++++++++-
 include/linux/dma/mmp-pdma.h | 15 +++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/dma/mmp-pdma.h

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 1fe78d8..60a1410 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -19,6 +19,7 @@
 #include <linux/dmapool.h>
 #include <linux/of_device.h>
 #include <linux/of.h>
+#include <linux/dma/mmp-pdma.h>
 
 #include "dmaengine.h"
 
@@ -633,8 +634,13 @@ static int mmp_pdma_control(struct dma_chan *dchan, enum dma_ctrl_cmd cmd,
 			chan->dcmd |= DCMD_BURST32;
 
 		chan->dir = cfg->direction;
-		chan->drcmr = cfg->slave_id;
 		chan->dev_addr = addr;
+		/* FIXME: drivers should be ported over to use the filter
+		 * function. Once that's done, the following two lines can
+		 * be removed.
+		 */
+		if (cfg->slave_id)
+			chan->drcmr = cfg->slave_id;
 		break;
 	default:
 		return -ENOSYS;
@@ -883,6 +889,19 @@ static struct platform_driver mmp_pdma_driver = {
 	.remove		= mmp_pdma_remove,
 };
 
+bool mmp_pdma_filter_fn(struct dma_chan *chan, void *param)
+{
+	struct mmp_pdma_chan *c = to_mmp_pdma_chan(chan);
+
+	if (chan->device->dev->driver != &mmp_pdma_driver.driver)
+		return false;
+
+	c->drcmr = *(unsigned int *) param;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(mmp_pdma_filter_fn);
+
 module_platform_driver(mmp_pdma_driver);
 
 MODULE_DESCRIPTION("MARVELL MMP Periphera DMA Driver");
diff --git a/include/linux/dma/mmp-pdma.h b/include/linux/dma/mmp-pdma.h
new file mode 100644
index 0000000..2dc9b2b
--- /dev/null
+++ b/include/linux/dma/mmp-pdma.h
@@ -0,0 +1,15 @@
+#ifndef _MMP_PDMA_H_
+#define _MMP_PDMA_H_
+
+struct dma_chan;
+
+#ifdef CONFIG_MMP_PDMA
+bool mmp_pdma_filter_fn(struct dma_chan *chan, void *param);
+#else
+static inline bool mmp_pdma_filter_fn(struct dma_chan *chan, void *param)
+{
+	return false;
+}
+#endif
+
+#endif /* _MMP_PDMA_H_ */
-- 
1.8.3.1
