From: zonque@gmail.com (Daniel Mack)
Date: Wed,  7 Aug 2013 17:33:58 +0200
Subject: [PATCH 09/20] ata: pdata_pxa: migrate over to dmaengine usage
In-Reply-To: <1375889649-14638-1-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
Message-ID: <1375889649-14638-10-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is compile-tested only, but the migration was actually
straight-forward.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/ata/pata_pxa.c | 172 ++++++++++++++++++++-----------------------------
 1 file changed, 70 insertions(+), 102 deletions(-)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index 942ef94..906c0b5 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -28,76 +28,43 @@
 #include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/completion.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma/mmp-pdma.h>
 
 #include <scsi/scsi_host.h>
 
 #include <mach/pxa2xx-regs.h>
 #include <linux/platform_data/ata-pxa.h>
-#include <mach/dma.h>
 
 #define DRV_NAME	"pata_pxa"
 #define DRV_VERSION	"0.1"
 
 struct pata_pxa_data {
-	uint32_t		dma_channel;
-	struct pxa_dma_desc	*dma_desc;
-	dma_addr_t		dma_desc_addr;
-	uint32_t		dma_desc_id;
+	struct dma_chan		*dma_channel;
+	unsigned int		dma_dir;
+	unsigned int		dma_len;
+	dma_cookie_t		dma_cookie;
 
 	/* DMA IO physical address */
 	uint32_t		dma_io_addr;
-	/* PXA DREQ<0:2> pin selector */
-	uint32_t		dma_dreq;
-	/* DMA DCSR register value */
-	uint32_t		dma_dcsr;
 
+	struct ata_port		*ap;
 	struct completion	dma_done;
 };
 
 /*
- * Setup the DMA descriptors. The size is transfer capped at 4k per descriptor,
- * if the transfer is longer, it is split into multiple chained descriptors.
+ * DMA interrupt handler.
  */
-static void pxa_load_dmac(struct scatterlist *sg, struct ata_queued_cmd *qc)
+static void pxa_ata_dma_irq(void *param)
 {
+	struct ata_queued_cmd *qc = param;
 	struct pata_pxa_data *pd = qc->ap->private_data;
 
-	uint32_t cpu_len, seg_len;
-	dma_addr_t cpu_addr;
-
-	cpu_addr = sg_dma_address(sg);
-	cpu_len = sg_dma_len(sg);
-
-	do {
-		seg_len = (cpu_len > 0x1000) ? 0x1000 : cpu_len;
-
-		pd->dma_desc[pd->dma_desc_id].ddadr = pd->dma_desc_addr +
-			((pd->dma_desc_id + 1) * sizeof(struct pxa_dma_desc));
-
-		pd->dma_desc[pd->dma_desc_id].dcmd = DCMD_BURST32 |
-					DCMD_WIDTH2 | (DCMD_LENGTH & seg_len);
-
-		if (qc->tf.flags & ATA_TFLAG_WRITE) {
-			pd->dma_desc[pd->dma_desc_id].dsadr = cpu_addr;
-			pd->dma_desc[pd->dma_desc_id].dtadr = pd->dma_io_addr;
-			pd->dma_desc[pd->dma_desc_id].dcmd |= DCMD_INCSRCADDR |
-						DCMD_FLOWTRG;
-		} else {
-			pd->dma_desc[pd->dma_desc_id].dsadr = pd->dma_io_addr;
-			pd->dma_desc[pd->dma_desc_id].dtadr = cpu_addr;
-			pd->dma_desc[pd->dma_desc_id].dcmd |= DCMD_INCTRGADDR |
-						DCMD_FLOWSRC;
-		}
-
-		cpu_len -= seg_len;
-		cpu_addr += seg_len;
-		pd->dma_desc_id++;
-
-	} while (cpu_len);
+	dma_unmap_sg(pd->dma_channel->device->dev,
+		     qc->sg, pd->dma_len, pd->dma_dir);
 
-	/* Should not happen */
-	if (seg_len & 0x1f)
-		DALGN |= (1 << pd->dma_dreq);
+	complete(&pd->dma_done);
 }
 
 /*
@@ -106,28 +73,51 @@ static void pxa_load_dmac(struct scatterlist *sg, struct ata_queued_cmd *qc)
 static void pxa_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct pata_pxa_data *pd = qc->ap->private_data;
-	int si = 0;
-	struct scatterlist *sg;
+	struct dma_slave_config	config;
+	struct dma_async_tx_descriptor *tx;
+	struct dma_chan *chan = pd->dma_channel;
+	int ret;
 
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
 		return;
 
-	pd->dma_desc_id = 0;
-
-	DCSR(pd->dma_channel) = 0;
-	DALGN &= ~(1 << pd->dma_dreq);
+	memset(&config, 0, sizeof(config));
+
+	if (qc->tf.flags & ATA_TFLAG_WRITE) {
+		config.dst_maxburst = 32;
+		config.dst_addr = pd->dma_io_addr;
+		config.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		config.direction = DMA_MEM_TO_DEV;
+		pd->dma_dir = DMA_TO_DEVICE;
+	} else {
+		config.src_maxburst = 32;
+		config.src_addr = pd->dma_io_addr;
+		config.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		config.direction = DMA_DEV_TO_MEM;
+		pd->dma_dir = DMA_FROM_DEVICE;
+	}
 
-	for_each_sg(qc->sg, sg, qc->n_elem, si)
-		pxa_load_dmac(sg, qc);
+	ret = dmaengine_slave_config(chan, &config);
+	if (ret < 0) {
+		pr_err("dmaengine_slave_config() failed\n");
+		return;
+	}
 
-	pd->dma_desc[pd->dma_desc_id - 1].ddadr = DDADR_STOP;
+	pd->dma_len = dma_map_sg(chan->device->dev, qc->sg, qc->n_elem,
+				 pd->dma_dir);
 
-	/* Fire IRQ only at the end of last block */
-	pd->dma_desc[pd->dma_desc_id - 1].dcmd |= DCMD_ENDIRQEN;
+	tx = dmaengine_prep_slave_sg(chan, qc->sg, pd->dma_len,
+				     config.direction,
+				     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (tx == NULL) {
+		pr_err("dmaengine_prep_slave_sg() failed\n");
+		return;
+	}
 
-	DDADR(pd->dma_channel) = pd->dma_desc_addr;
-	DRCMR(pd->dma_dreq) = DRCMR_MAPVLD | pd->dma_channel;
+	tx->callback = pxa_ata_dma_irq;
+	tx->callback_param = pd->ap;
 
+	pd->dma_cookie = dmaengine_submit(tx);
 }
 
 /*
@@ -146,7 +136,7 @@ static void pxa_bmdma_start(struct ata_queued_cmd *qc)
 {
 	struct pata_pxa_data *pd = qc->ap->private_data;
 	init_completion(&pd->dma_done);
-	DCSR(pd->dma_channel) = DCSR_RUN;
+	dma_async_issue_pending(pd->dma_channel);
 }
 
 /*
@@ -155,12 +145,7 @@ static void pxa_bmdma_start(struct ata_queued_cmd *qc)
 static void pxa_bmdma_stop(struct ata_queued_cmd *qc)
 {
 	struct pata_pxa_data *pd = qc->ap->private_data;
-
-	if ((DCSR(pd->dma_channel) & DCSR_RUN) &&
-		wait_for_completion_timeout(&pd->dma_done, HZ))
-		dev_err(qc->ap->dev, "Timeout waiting for DMA completion!");
-
-	DCSR(pd->dma_channel) = 0;
+	dmaengine_terminate_all(pd->dma_channel);
 }
 
 /*
@@ -171,8 +156,12 @@ static unsigned char pxa_bmdma_status(struct ata_port *ap)
 {
 	struct pata_pxa_data *pd = ap->private_data;
 	unsigned char ret = ATA_DMA_INTR;
+	struct dma_tx_state tx_state;
+	enum dma_status status;
 
-	if (pd->dma_dcsr & DCSR_BUSERR)
+	status = dmaengine_tx_status(pd->dma_channel, pd->dma_cookie,
+				     &tx_state);
+	if (status == DMA_ERROR)
 		ret |= ATA_DMA_ERR;
 
 	return ret;
@@ -214,21 +203,6 @@ static struct ata_port_operations pxa_ata_port_ops = {
 	.qc_prep		= pxa_qc_prep,
 };
 
-/*
- * DMA interrupt handler.
- */
-static void pxa_ata_dma_irq(int dma, void *port)
-{
-	struct ata_port *ap = port;
-	struct pata_pxa_data *pd = ap->private_data;
-
-	pd->dma_dcsr = DCSR(dma);
-	DCSR(dma) = pd->dma_dcsr;
-
-	if (pd->dma_dcsr & DCSR_STOPSTATE)
-		complete(&pd->dma_done);
-}
-
 static int pxa_ata_probe(struct platform_device *pdev)
 {
 	struct ata_host *host;
@@ -239,6 +213,7 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	struct resource *dma_res;
 	struct resource *irq_res;
 	struct pata_pxa_pdata *pdata = pdev->dev.platform_data;
+	dma_cap_mask_t mask;
 	int ret = 0;
 
 	/*
@@ -333,38 +308,30 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	data->ap = ap;
 	ap->private_data = data;
-	data->dma_dreq = pdata->dma_dreq;
 	data->dma_io_addr = dma_res->start;
 
 	/*
-	 * Allocate space for the DMA descriptors
-	 */
-	data->dma_desc = dmam_alloc_coherent(&pdev->dev, PAGE_SIZE,
-					&data->dma_desc_addr, GFP_KERNEL);
-	if (!data->dma_desc)
-		return -EINVAL;
-
-	/*
 	 * Request the DMA channel
 	 */
-	data->dma_channel = pxa_request_dma(DRV_NAME, DMA_PRIO_LOW,
-						pxa_ata_dma_irq, ap);
-	if (data->dma_channel < 0)
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	data->dma_channel =
+		dma_request_slave_channel_compat(mask, mmp_pdma_filter_fn,
+						 &pdata->dma_dreq, &pdev->dev,
+						 "data");
+	if (data->dma_channel == NULL)
 		return -EBUSY;
 
 	/*
-	 * Stop and clear the DMA channel
-	 */
-	DCSR(data->dma_channel) = 0;
-
-	/*
 	 * Activate the ATA host
 	 */
 	ret = ata_host_activate(host, irq_res->start, ata_sff_interrupt,
 				pdata->irq_flags, &pxa_ata_sht);
 	if (ret)
-		pxa_free_dma(data->dma_channel);
+		dma_release_channel(data->dma_channel);
 
 	return ret;
 }
@@ -374,7 +341,8 @@ static int pxa_ata_remove(struct platform_device *pdev)
 	struct ata_host *host = platform_get_drvdata(pdev);
 	struct pata_pxa_data *data = host->ports[0]->private_data;
 
-	pxa_free_dma(data->dma_channel);
+	dmaengine_terminate_all(data->dma_channel);
+	dma_release_channel(data->dma_channel);
 
 	ata_host_detach(host);
 
-- 
1.8.3.1
