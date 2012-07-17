From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 17 Jul 2012 12:53:49 +0200 (CEST)
Subject: [PATCH/RFC 2/4] dma: shdma: add explicit support for client DMA
 channel multiplexing
In-Reply-To: <Pine.LNX.4.64.1207171201550.11241@axis700.grange>
References: <Pine.LNX.4.64.1207171201550.11241@axis700.grange>
Message-ID: <Pine.LNX.4.64.1207171242500.17060@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the new dmaengine multiplexer API. In shdma case the
multiplexer is built-in into the DMAC, so, the multiplexer .request_chan()
method only has to check, whether this client is supported by the specific
DMAC instance. The routing is performed inside the .device_control()
method.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/dma/sh/shdma-base.c |   28 +++++++++++++++++++++++++++-
 drivers/dma/sh/shdma.c      |   22 ++++++++++++++++++++++
 include/linux/sh_dma.h      |    3 +++
 include/linux/shdma-base.h  |    4 ++++
 4 files changed, 56 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 0c34c73..76e4854 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -808,6 +808,30 @@ static irqreturn_t chan_irqt(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static struct dma_chan *shdma_mux_request_chan(struct dma_device *dmadev,
+		struct device *dev, enum dma_transfer_direction direction,
+		const char *name)
+{
+	struct shdma_dev *sdev = to_shdma_dev(dmadev);
+	const struct shdma_ops *ops = sdev->ops;
+	struct shdma_chan *schan;
+	int i;
+
+	if (!ops->slave_supported(sdev, dev, direction, name))
+		return NULL;
+
+	/* The DMAC supports this client, pick up the first free channel */
+	shdma_for_each_chan(schan, sdev, i)
+		if (!schan->dma_chan.client_count)
+			return &schan->dma_chan;
+
+	return NULL;
+}
+
+static const struct dma_multiplexer shdma_mux = {
+	.request_chan = shdma_mux_request_chan,
+};
+
 int shdma_request_irq(struct shdma_chan *schan, int irq,
 			   unsigned long flags, const char *name)
 {
@@ -880,7 +904,8 @@ int shdma_init(struct device *dev, struct shdma_dev *sdev,
 	    !sdev->ops->slave_addr ||
 	    !sdev->ops->channel_busy ||
 	    !sdev->ops->halt_channel ||
-	    !sdev->ops->desc_completed)
+	    !sdev->ops->desc_completed ||
+	    !sdev->ops->slave_supported)
 		return -EINVAL;
 
 	sdev->schan = kcalloc(chan_num, sizeof(*sdev->schan), GFP_KERNEL);
@@ -901,6 +926,7 @@ int shdma_init(struct device *dev, struct shdma_dev *sdev,
 	dma_dev->device_prep_slave_sg = shdma_prep_slave_sg;
 	dma_dev->device_control = shdma_control;
 
+	dma_dev->mux = &shdma_mux;
 	dma_dev->dev = dev;
 
 	return 0;
diff --git a/drivers/dma/sh/shdma.c b/drivers/dma/sh/shdma.c
index 027c9be..ef3c018 100644
--- a/drivers/dma/sh/shdma.c
+++ b/drivers/dma/sh/shdma.c
@@ -424,6 +424,27 @@ static bool sh_dmae_desc_completed(struct shdma_chan *schan,
 		 (sh_desc->hw.sar + sh_desc->hw.tcr) == sar_buf);
 }
 
+static bool sh_dmae_slave_supported(struct shdma_dev *sdev, struct device *dev,
+		enum dma_transfer_direction direction, const char *name)
+{
+	struct sh_dmae_device *shdev = container_of(sdev, struct sh_dmae_device,
+						    shdma_dev);
+	struct sh_dmae_pdata *pdata = shdev->pdata;
+	const struct sh_dmae_slave_config *cfg;
+	int i;
+
+	if (!dev)
+		return false;
+
+	for (i = 0, cfg = pdata->slave; i < pdata->slave_num; i++, cfg++)
+		if (cfg->dev_id && !strcmp(cfg->dev_id, dev_name(dev)) &&
+		    cfg->direction == direction &&
+		    (!name || (cfg->name && !strcmp(name, cfg->name))))
+			return true;
+
+	return false;
+}
+
 static bool sh_dmae_nmi_notify(struct sh_dmae_device *shdev)
 {
 	/* Fast path out if NMIF is not asserted for this controller */
@@ -632,6 +653,7 @@ static const struct shdma_ops sh_dmae_shdma_ops = {
 	.start_xfer = sh_dmae_start_xfer,
 	.embedded_desc = sh_dmae_embedded_desc,
 	.chan_irq = sh_dmae_chan_irq,
+	.slave_supported = sh_dmae_slave_supported,
 };
 
 static int __devinit sh_dmae_probe(struct platform_device *pdev)
diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
index b64d6be..86be8ab 100644
--- a/include/linux/sh_dma.h
+++ b/include/linux/sh_dma.h
@@ -31,6 +31,9 @@ struct sh_dmae_slave_config {
 	dma_addr_t	addr;
 	u32		chcr;
 	char		mid_rid;
+	enum dma_transfer_direction direction;
+	const char	*name;
+	const char	*dev_id;
 };
 
 struct sh_dmae_channel {
diff --git a/include/linux/shdma-base.h b/include/linux/shdma-base.h
index 93f9821..3769518 100644
--- a/include/linux/shdma-base.h
+++ b/include/linux/shdma-base.h
@@ -70,6 +70,8 @@ struct shdma_chan {
 	enum shdma_pm_state pm_state;
 };
 
+struct shdma_dev;
+
 /**
  * struct shdma_ops - simple DMA driver operations
  * desc_completed:	return true, if this is the descriptor, that just has
@@ -98,6 +100,8 @@ struct shdma_ops {
 	void (*start_xfer)(struct shdma_chan *, struct shdma_desc *);
 	struct shdma_desc *(*embedded_desc)(void *, int);
 	bool (*chan_irq)(struct shdma_chan *, int);
+	bool (*slave_supported)(struct shdma_dev *, struct device *,
+				enum dma_transfer_direction, const char *);
 };
 
 struct shdma_dev {
-- 
1.7.2.5
