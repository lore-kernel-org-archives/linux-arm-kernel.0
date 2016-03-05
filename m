From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sat,  5 Mar 2016 10:52:22 +0000
Subject: [PATCH v3 11/11] dmaengine: bcm2835: expose dma registers via debugfs
In-Reply-To: <1457175142-28665-1-git-send-email-kernel@martin.sperl.org>
References: <1457175142-28665-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1457175142-28665-12-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Expose all the dma registers via debugfs.
The mapping between linux channels and HW-dma channels is
also exposed via a softlink in debugfs.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/dma/bcm2835-dma.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 2884285..e2aea4a 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -29,6 +29,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
+#include <linux/debugfs.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
@@ -51,6 +52,7 @@ struct bcm2835_dmadev {
 	spinlock_t lock;
 	void __iomem *base;
 	struct device_dma_parameters dma_parms;
+	struct dentry *debugfs_node;
 };
 
 struct bcm2835_dma_cb {
@@ -904,6 +906,147 @@ static struct dma_chan *bcm2835_dma_xlate(struct of_phandle_args *spec,
 	return chan;
 }
 
+#ifdef CONFIG_DEBUG_FS
+static struct debugfs_reg32 bcm2835_dma_debugfs_common_reg32[] = {
+	{
+		.name = "int_status",
+		.offset = BCM2835_DMA_INT_STATUS,
+	},
+	{
+		.name = "enable",
+		.offset = BCM2835_DMA_ENABLE,
+	},
+};
+
+static void bcm2835_dma_debugfs_register_common(struct bcm2835_dmadev *od)
+{
+	struct debugfs_regset32 *regset;
+
+	regset = devm_kzalloc(od->ddev.dev, sizeof(*regset), GFP_KERNEL);
+	if (!regset)
+		return;
+
+	regset->regs  = bcm2835_dma_debugfs_common_reg32;
+	regset->nregs = ARRAY_SIZE(bcm2835_dma_debugfs_common_reg32);
+	regset->base  = od->base;
+
+	debugfs_create_regset32("common", S_IRUGO, od->debugfs_node, regset);
+}
+
+static struct debugfs_reg32 bcm2835_dma_debugfs_channel_reg32[] = {
+	{
+		.name = "cs         ",
+		.offset = BCM2835_DMA_CS,
+	},
+	{
+		.name = "addr       ",
+		.offset = BCM2835_DMA_ADDR,
+	},
+	{
+		.name = "ti         ",
+		.offset = BCM2835_DMA_TI,
+	},
+	{
+		.name = "source     ",
+		.offset = BCM2835_DMA_SOURCE_AD,
+	},
+	{
+		.name = "destination",
+		.offset = BCM2835_DMA_DEST_AD,
+	},
+	{
+		.name = "length     ",
+		.offset = BCM2835_DMA_LEN,
+	},
+	{
+		.name = "stride     ",
+		.offset = BCM2835_DMA_STRIDE,
+	},
+	{
+		.name = "next       ",
+		.offset = BCM2835_DMA_NEXTCB,
+	},
+	{
+		.name = "debug      ",
+		.offset = BCM2835_DMA_DEBUG,
+	},
+};
+
+static void bcm2835_dma_debugfs_register_channel(struct bcm2835_dmadev *od,
+						 int channel)
+{
+	struct debugfs_regset32 *regset;
+	char *name;
+
+	regset = devm_kzalloc(od->ddev.dev, sizeof(*regset), GFP_KERNEL);
+	if (!regset)
+		return;
+
+	name = devm_kasprintf(od->ddev.dev, GFP_KERNEL, "%02d", channel);
+	if (!name)
+		return;
+
+	regset->regs  = bcm2835_dma_debugfs_channel_reg32;
+	regset->nregs = ARRAY_SIZE(bcm2835_dma_debugfs_channel_reg32);
+	regset->base  = BCM2835_DMA_CHANIO(od->base, channel);
+
+	/*
+	 * expose, but only for the owner (=root)
+	 * contains pointers that should not leak
+	 */
+	debugfs_create_regset32(name, S_IRUSR, od->debugfs_node, regset);
+}
+
+static void bcm2835_dma_debugfs_register_link(struct bcm2835_dmadev *od,
+					      struct dma_chan *chan)
+{
+	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
+	char *name;
+
+	name = devm_kasprintf(od->ddev.dev, GFP_KERNEL, "%02d", c->ch);
+	if (!name)
+		return;
+
+	debugfs_create_symlink(dev_name(&chan->dev->device),
+			       od->debugfs_node, name);
+}
+
+static void bcm2835_dma_debugfs_register(struct bcm2835_dmadev *od)
+{
+	struct dma_chan *chan;
+	int i;
+
+	od->debugfs_node = debugfs_create_dir(dev_name(od->ddev.dev), NULL);
+	if (!od->debugfs_node)
+		return;
+
+	/* expose the common registers */
+	bcm2835_dma_debugfs_register_common(od);
+
+	/* register all the real channels - not only the mapped ones */
+	for (i = 0; i <= BCM2835_DMA_MAX_CHANNEL_NUMBER; i++)
+		bcm2835_dma_debugfs_register_channel(od, i);
+
+	/* create the softlinks */
+	list_for_each_entry(chan, &od->ddev.channels, device_node) {
+		bcm2835_dma_debugfs_register_link(od, chan);
+	}
+}
+
+static void bcm2835_dma_debugfs_remove(struct bcm2835_dmadev *od)
+{
+	debugfs_remove_recursive(od->debugfs_node);
+
+	od->debugfs_node = NULL;
+}
+
+#else
+static void bcm2835_dma_debugfs_register(struct bcm2835_dmadev *od)
+{ }
+static void bcm2835_dma_debugfs_remove(struct bcm2835_dmadev *od)
+{ }
+#endif
+
 static int bcm2835_dma_probe(struct platform_device *pdev)
 {
 	struct bcm2835_dmadev *od;
@@ -1022,6 +1165,8 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 		goto err_no_dma;
 	}
 
+	bcm2835_dma_debugfs_register(od);
+
 	dev_dbg(&pdev->dev, "Load BCM2835 DMA engine driver\n");
 
 	return 0;
@@ -1035,6 +1180,8 @@ static int bcm2835_dma_remove(struct platform_device *pdev)
 {
 	struct bcm2835_dmadev *od = platform_get_drvdata(pdev);
 
+	bcm2835_dma_debugfs_remove(od);
+
 	dma_async_device_unregister(&od->ddev);
 	bcm2835_dma_free(od);
 
-- 
2.1.4
