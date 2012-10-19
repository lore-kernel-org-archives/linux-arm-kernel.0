From: hechtb@googlemail.com (Bastian Hecht)
Date: Fri, 19 Oct 2012 12:15:35 +0200
Subject: [PATCH v3 2/3] mtd: sh_flctl: Add DMA capabilty
In-Reply-To: <1350641736-18192-1-git-send-email-hechtb@gmail.com>
References: <1350641736-18192-1-git-send-email-hechtb@gmail.com>
Message-ID: <1350641736-18192-3-git-send-email-hechtb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code probes if DMA channels can get allocated and tears them down at
removal/failure if needed.
If available it uses them to transfer the data part (not ECC). On
failure we fall back to PIO mode.

Based on Guennadi Liakhovetski's code from the sh_mmcif driver.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
Reviewed-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
v3: no changes. I don't know if the error

	warning: cast removes address space of expression [sparse]

because of line

	+       cfg.dst_addr = (dma_addr_t)FLDTFIFO(flctl);

can be fixed. dma_addr_t is loosly defined as u32 and I see no way how to make
a proper conversion.

 drivers/mtd/nand/sh_flctl.c  |  173 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/mtd/sh_flctl.h |   12 +++
 2 files changed, 183 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 78d18c0f..6dc0369 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -23,11 +23,15 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/sh_dma.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 
@@ -106,6 +110,84 @@ static void wait_completion(struct sh_flctl *flctl)
 	writeb(0x0, FLTRCR(flctl));
 }
 
+static void flctl_dma_complete(void *param)
+{
+	struct sh_flctl *flctl = param;
+
+	complete(&flctl->dma_complete);
+}
+
+static void flctl_release_dma(struct sh_flctl *flctl)
+{
+	if (flctl->chan_fifo0_rx) {
+		dma_release_channel(flctl->chan_fifo0_rx);
+		flctl->chan_fifo0_rx = NULL;
+	}
+	if (flctl->chan_fifo0_tx) {
+		dma_release_channel(flctl->chan_fifo0_tx);
+		flctl->chan_fifo0_tx = NULL;
+	}
+}
+
+static void flctl_setup_dma(struct sh_flctl *flctl)
+{
+	dma_cap_mask_t mask;
+	struct dma_slave_config cfg;
+	struct platform_device *pdev = flctl->pdev;
+	struct sh_flctl_platform_data *pdata = pdev->dev.platform_data;
+	int ret;
+
+	if (!pdata)
+		return;
+
+	if (pdata->slave_id_fifo0_tx <= 0 || pdata->slave_id_fifo0_rx <= 0)
+		return;
+
+	/* We can only either use DMA for both Tx and Rx or not use it@all */
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	flctl->chan_fifo0_tx = dma_request_channel(mask, shdma_chan_filter,
+					    (void *)pdata->slave_id_fifo0_tx);
+	dev_dbg(&pdev->dev, "%s: TX: got channel %p\n", __func__,
+		flctl->chan_fifo0_tx);
+
+	if (!flctl->chan_fifo0_tx)
+		return;
+
+	memset(&cfg, 0, sizeof(cfg));
+	cfg.slave_id = pdata->slave_id_fifo0_tx;
+	cfg.direction = DMA_MEM_TO_DEV;
+	cfg.dst_addr = (dma_addr_t)FLDTFIFO(flctl);
+	cfg.src_addr = 0;
+	ret = dmaengine_slave_config(flctl->chan_fifo0_tx, &cfg);
+	if (ret < 0)
+		goto err;
+
+	flctl->chan_fifo0_rx = dma_request_channel(mask, shdma_chan_filter,
+					    (void *)pdata->slave_id_fifo0_rx);
+	dev_dbg(&pdev->dev, "%s: RX: got channel %p\n", __func__,
+		flctl->chan_fifo0_rx);
+
+	if (!flctl->chan_fifo0_rx)
+		goto err;
+
+	cfg.slave_id = pdata->slave_id_fifo0_rx;
+	cfg.direction = DMA_DEV_TO_MEM;
+	cfg.dst_addr = 0;
+	cfg.src_addr = (dma_addr_t)FLDTFIFO(flctl);
+	ret = dmaengine_slave_config(flctl->chan_fifo0_rx, &cfg);
+	if (ret < 0)
+		goto err;
+
+	init_completion(&flctl->dma_complete);
+
+	return;
+
+err:
+	flctl_release_dma(flctl);
+}
+
 static void set_addr(struct mtd_info *mtd, int column, int page_addr)
 {
 	struct sh_flctl *flctl = mtd_to_flctl(mtd);
@@ -261,6 +343,70 @@ static void wait_wecfifo_ready(struct sh_flctl *flctl)
 	timeout_error(flctl, __func__);
 }
 
+static int flctl_dma_fifo0_transfer(struct sh_flctl *flctl, unsigned long *buf,
+					int len, enum dma_data_direction dir)
+{
+	struct dma_async_tx_descriptor *desc = NULL;
+	struct dma_chan *chan;
+	enum dma_transfer_direction tr_dir;
+	dma_addr_t dma_addr;
+	dma_cookie_t cookie = -EINVAL;
+	uint32_t reg;
+	int ret;
+
+	if (dir == DMA_FROM_DEVICE) {
+		chan = flctl->chan_fifo0_rx;
+		tr_dir = DMA_DEV_TO_MEM;
+	} else {
+		chan = flctl->chan_fifo0_tx;
+		tr_dir = DMA_MEM_TO_DEV;
+	}
+
+	dma_addr = dma_map_single(chan->device->dev, buf, len, dir);
+
+	if (dma_addr)
+		desc = dmaengine_prep_slave_single(chan, dma_addr, len,
+			tr_dir, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+
+	if (desc) {
+		reg = readl(FLINTDMACR(flctl));
+		reg |= DREQ0EN;
+		writel(reg, FLINTDMACR(flctl));
+
+		desc->callback = flctl_dma_complete;
+		desc->callback_param = flctl;
+		cookie = dmaengine_submit(desc);
+
+		dma_async_issue_pending(chan);
+	} else {
+		/* DMA failed, fall back to PIO */
+		flctl_release_dma(flctl);
+		dev_warn(&flctl->pdev->dev,
+			 "DMA failed, falling back to PIO\n");
+		ret = -EIO;
+		goto out;
+	}
+
+	ret =
+	wait_for_completion_timeout(&flctl->dma_complete,
+				msecs_to_jiffies(3000));
+
+	if (ret <= 0) {
+		chan->device->device_control(chan, DMA_TERMINATE_ALL, 0);
+		dev_err(&flctl->pdev->dev, "wait_for_completion_timeout\n");
+	}
+
+out:
+	reg = readl(FLINTDMACR(flctl));
+	reg &= ~DREQ0EN;
+	writel(reg, FLINTDMACR(flctl));
+
+	dma_unmap_single(chan->device->dev, dma_addr, len, dir);
+
+	/* ret > 0 is success */
+	return ret;
+}
+
 static void read_datareg(struct sh_flctl *flctl, int offset)
 {
 	unsigned long data;
@@ -279,11 +425,20 @@ static void read_fiforeg(struct sh_flctl *flctl, int rlen, int offset)
 
 	len_4align = (rlen + 3) / 4;
 
+	/* initiate DMA transfer */
+	if (flctl->chan_fifo0_rx && rlen >= 32 &&
+		flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_DEV_TO_MEM) > 0)
+			goto convert;	/* DMA success */
+
+	/* do polling transfer */
 	for (i = 0; i < len_4align; i++) {
 		wait_rfifo_ready(flctl);
 		buf[i] = readl(FLDTFIFO(flctl));
-		buf[i] = be32_to_cpu(buf[i]);
 	}
+
+convert:
+	for (i = 0; i < len_4align; i++)
+		buf[i] = be32_to_cpu(buf[i]);
 }
 
 static enum flctl_ecc_res_t read_ecfiforeg
@@ -325,9 +480,19 @@ static void write_ec_fiforeg(struct sh_flctl *flctl, int rlen,
 	unsigned long *buf = (unsigned long *)&flctl->done_buff[offset];
 
 	len_4align = (rlen + 3) / 4;
+
+	for (i = 0; i < len_4align; i++)
+		buf[i] = cpu_to_be32(buf[i]);
+
+	/* initiate DMA transfer */
+	if (flctl->chan_fifo0_tx && rlen >= 32 &&
+		flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_MEM_TO_DEV) > 0)
+			return;	/* DMA success */
+
+	/* do polling transfer */
 	for (i = 0; i < len_4align; i++) {
 		wait_wecfifo_ready(flctl);
-		writel(cpu_to_be32(buf[i]), FLECFIFO(flctl));
+		writel(buf[i], FLECFIFO(flctl));
 	}
 }
 
@@ -925,6 +1090,8 @@ static int __devinit flctl_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_resume(&pdev->dev);
 
+	flctl_setup_dma(flctl);
+
 	ret = nand_scan_ident(flctl_mtd, 1, NULL);
 	if (ret)
 		goto err_chip;
@@ -942,6 +1109,7 @@ static int __devinit flctl_probe(struct platform_device *pdev)
 	return 0;
 
 err_chip:
+	flctl_release_dma(flctl);
 	pm_runtime_disable(&pdev->dev);
 	free_irq(irq, flctl);
 err_flste:
@@ -955,6 +1123,7 @@ static int __devexit flctl_remove(struct platform_device *pdev)
 {
 	struct sh_flctl *flctl = platform_get_drvdata(pdev);
 
+	flctl_release_dma(flctl);
 	nand_release(&flctl->mtd);
 	pm_runtime_disable(&pdev->dev);
 	free_irq(platform_get_irq(pdev, 0), flctl);
diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
index 4815576..1c28f88 100644
--- a/include/linux/mtd/sh_flctl.h
+++ b/include/linux/mtd/sh_flctl.h
@@ -20,6 +20,7 @@
 #ifndef __SH_FLCTL_H__
 #define __SH_FLCTL_H__
 
+#include <linux/completion.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
@@ -107,6 +108,7 @@
 #define ESTERINTE	(0x1 << 24)	/* ECC error interrupt enable */
 #define AC1CLR		(0x1 << 19)	/* ECC FIFO clear */
 #define AC0CLR		(0x1 << 18)	/* Data FIFO clear */
+#define DREQ0EN		(0x1 << 16)	/* FLDTFIFODMA Request Enable */
 #define ECERB		(0x1 << 9)	/* ECC error */
 #define STERB		(0x1 << 8)	/* Status error */
 #define STERINTE	(0x1 << 4)	/* Status error enable */
@@ -138,6 +140,8 @@ enum flctl_ecc_res_t {
 	FL_TIMEOUT
 };
 
+struct dma_chan;
+
 struct sh_flctl {
 	struct mtd_info		mtd;
 	struct nand_chip	chip;
@@ -161,6 +165,11 @@ struct sh_flctl {
 	unsigned hwecc:1;	/* Hardware ECC (0 = disabled, 1 = enabled) */
 	unsigned holden:1;	/* Hardware has FLHOLDCR and HOLDEN is set */
 	unsigned qos_request:1;	/* QoS request to prevent deep power shutdown */
+
+	/* DMA related objects */
+	struct dma_chan		*chan_fifo0_rx;
+	struct dma_chan		*chan_fifo0_tx;
+	struct completion	dma_complete;
 };
 
 struct sh_flctl_platform_data {
@@ -170,6 +179,9 @@ struct sh_flctl_platform_data {
 
 	unsigned has_hwecc:1;
 	unsigned use_holden:1;
+
+	unsigned int            slave_id_fifo0_tx;
+	unsigned int            slave_id_fifo0_rx;
 };
 
 static inline struct sh_flctl *mtd_to_flctl(struct mtd_info *mtdinfo)
-- 
1.7.9.5
