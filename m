From: cedric@precidata.com (Cedric Berger)
Date: Tue, 23 Apr 2013 10:02:18 +0200 (CEST)
Subject: [PATCH 2/10] LPC32XX: 002-mmc.2: Workaround for MMC+DMA on LPC32xx
 (V2)
Message-ID: <mailman.3.1366704182.1125.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because of some PL08x and PL18x buggered up design, software workaround is
needed be integrated to maje that combination work. Here is a rework of
original NXP patch for the 3.9 kernel.

Signed-off-by: Gabriele Mondada <gabriele@precidata.com>
---

Index: include/linux/amba/mmci.h
===================================================================
--- include/linux/amba/mmci.h	(revision 1767)
+++ include/linux/amba/mmci.h	(working copy)
@@ -19,6 +19,12 @@
 #define MCI_ST_FBCLKEN		(1 << 7)
 #define MCI_ST_DATA74DIREN	(1 << 8)
 
+/*
+ * list of DMA quirks
+ */
+#define MCI_DMA_QUIRK_PL18X_RX	(1 << 0)
+#define MCI_DMA_QUIRK_PL18X_TX	(1 << 1)
+
 /* Just some dummy forwarding */
 struct dma_chan;
 
@@ -57,6 +63,8 @@
  * @dma_tx_param: parameter passed to the DMA allocation
  * filter in order to select an appropriate TX channel. If this
  * is NULL the driver will attempt to use the RX channel as a
+ * @dma_pl18x_quirks: apply quirks to make the pl08x/pl18x combination
+ * work properly, such as with nxp lpc32xx cpu.
  * bidirectional channel
  */
 struct mmci_platform_data {
@@ -70,6 +78,7 @@
 	unsigned long capabilities;
 	unsigned long capabilities2;
 	u32 sigdir;
+	u32 dma_quirks;
 	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
 	void *dma_rx_param;
 	void *dma_tx_param;
Index: drivers/mmc/host/mmci.c
===================================================================
--- drivers/mmc/host/mmci.c	(revision 1768)
+++ drivers/mmc/host/mmci.c	(working copy)
@@ -3,6 +3,7 @@
  *
  *  Copyright (C) 2003 Deep Blue Solutions, Ltd, All Rights Reserved.
  *  Copyright (C) 2010 ST-Ericsson SA
+ *  Copyright (C) 2013 Precidata Sarl, Gabriele Mondada
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -45,6 +46,14 @@
 
 #define DRIVER_NAME "mmci-pl18x"
 
+#define COOKIE_PREP	0x00000001
+#define COOKIE_SINGLE	0x00000002
+#define COOKIE_ID_MASK	0xFF000000
+#define COOKIE_ID_SHIFT	24
+#define COOKIE_ID(n)	(COOKIE_ID_MASK & ((n) << COOKIE_ID_SHIFT))
+
+#define DMA_QUIRKS_TX_SIZE SZ_64K
+
 static unsigned int fmax = 515633;
 
 /**
@@ -305,14 +314,38 @@
 	struct mmci_platform_data *plat = host->plat;
 	const char *rxname, *txname;
 	dma_cap_mask_t mask;
+	int i;
 
 	if (!plat || !plat->dma_filter) {
 		dev_info(mmc_dev(host->mmc), "no DMA platform data\n");
 		return;
 	}
 
-	/* initialize pre request cookie */
-	host->next_data.cookie = 1;
+	host->dma_quirks = plat->dma_quirks;
+	if (host->dma_quirks & MCI_DMA_QUIRK_PL18X_TX) {
+		/*
+		 * The PL08X+PL18X do not support sg on TX DMA. So
+		 * a temporary bounce buffer is used if more than 1 sg segment
+		 * is passed in the data request. The bounce buffer will get a
+		 * contiguous copy of the TX data and it will be used instead.
+		 */
+		for (i = 0; i < 2; i++) {
+			host->bounce_buf_pool[i].dma_v_tx = dma_alloc_coherent(
+				mmc_dev(host->mmc), DMA_QUIRKS_TX_SIZE,
+				&host->bounce_buf_pool[i].dma_p_tx, GFP_KERNEL);
+			if (host->bounce_buf_pool[i].dma_v_tx == NULL) {
+				dev_err(mmc_dev(host->mmc),
+					"error getting DMA region\n");
+				return;
+			}
+			dev_info(mmc_dev(host->mmc),
+				"DMA buffer: phy:%p, virt:%p\n",
+				(void *)host->bounce_buf_pool[i].dma_p_tx,
+				host->bounce_buf_pool[i].dma_v_tx);
+		}
+		host->bounce_buf = &host->bounce_buf_pool[0];
+		host->next_data.bounce_buf = &host->bounce_buf_pool[1];
+	}
 
 	/* Try to acquire a generic DMA engine slave channel */
 	dma_cap_zero(mask);
@@ -382,12 +415,26 @@
 static inline void mmci_dma_release(struct mmci_host *host)
 {
 	struct mmci_platform_data *plat = host->plat;
+	int i;
 
 	if (host->dma_rx_channel)
 		dma_release_channel(host->dma_rx_channel);
 	if (host->dma_tx_channel && plat->dma_tx_param)
 		dma_release_channel(host->dma_tx_channel);
 	host->dma_rx_channel = host->dma_tx_channel = NULL;
+
+	if (host->dma_quirks & MCI_DMA_QUIRK_PL18X_TX) {
+		for (i = 0; i < 2; i++) {
+			if (host->bounce_buf_pool[i].dma_v_tx == NULL)
+				continue;
+			dma_free_coherent(mmc_dev(host->mmc),
+				DMA_QUIRKS_TX_SIZE,
+				host->bounce_buf_pool[i].dma_v_tx,
+				host->bounce_buf_pool[i].dma_p_tx);
+			host->bounce_buf_pool[i].dma_v_tx = NULL;
+			host->bounce_buf_pool[i].dma_p_tx = 0;
+		}
+	}
 }
 
 static void mmci_dma_data_error(struct mmci_host *host)
@@ -396,7 +443,6 @@
 	dmaengine_terminate_all(host->dma_current);
 	host->dma_current = NULL;
 	host->dma_desc_current = NULL;
-	host->data->host_cookie = 0;
 }
 
 static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
@@ -412,7 +458,9 @@
 		chan = host->dma_tx_channel;
 	}
 
-	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len, dir);
+	if (!(data->host_cookie & COOKIE_SINGLE))
+		dma_unmap_sg(chan->device->dev, data->sg, data->sg_len, dir);
+	data->host_cookie = 0;
 }
 
 static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
@@ -459,7 +507,8 @@
 /* prepares DMA channel and DMA descriptor, returns non-zero on failure */
 static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 				struct dma_chan **dma_chan,
-				struct dma_async_tx_descriptor **dma_desc)
+				struct dma_async_tx_descriptor **dma_desc,
+				struct mmci_bounce_buf *bounce_buf)
 {
 	struct variant_data *variant = host->variant;
 	struct dma_slave_config conf = {
@@ -476,7 +525,11 @@
 	struct dma_async_tx_descriptor *desc;
 	enum dma_data_direction buffer_dirn;
 	int nr_sg;
+	bool single = bounce_buf && (data->flags & MMC_DATA_WRITE) &&
+			(data->sg_len > 1);
 
+	WARN_ON(data->host_cookie);
+
 	if (data->flags & MMC_DATA_READ) {
 		conf.direction = DMA_DEV_TO_MEM;
 		buffer_dirn = DMA_FROM_DEVICE;
@@ -485,6 +538,8 @@
 		conf.direction = DMA_MEM_TO_DEV;
 		buffer_dirn = DMA_TO_DEVICE;
 		chan = host->dma_tx_channel;
+		if (host->dma_quirks & MCI_DMA_QUIRK_PL18X_TX)
+			conf.device_fc = true;
 	}
 
 	/* If there's no DMA channel, fall back to PIO */
@@ -496,23 +551,58 @@
 		return -EINVAL;
 
 	device = chan->device;
-	nr_sg = dma_map_sg(device->dev, data->sg, data->sg_len, buffer_dirn);
-	if (nr_sg == 0)
-		return -EINVAL;
+	dmaengine_slave_config(chan, &conf);
 
-	dmaengine_slave_config(chan, &conf);
-	desc = dmaengine_prep_slave_sg(chan, data->sg, nr_sg,
-					    conf.direction, DMA_CTRL_ACK);
+	if (single) {
+		int i;
+		unsigned char *dst = bounce_buf->dma_v_tx;
+		size_t len = 0;
+
+		dev_dbg(mmc_dev(host->mmc), "use bounce buffer\n");
+
+		/* Move data to contiguous buffer first, then transfer it */
+		for (i = 0; i < data->sg_len; i++) {
+			unsigned long flags;
+			struct scatterlist *sg = &data->sg[i];
+			void *src;
+
+			/* Map the current scatter buffer, copy data, unmap */
+			local_irq_save(flags);
+			src = (unsigned char *)kmap_atomic(sg_page(sg)) +
+							   sg->offset;
+			memcpy(dst + len, src, sg->length);
+			len += sg->length;
+			kunmap_atomic(src);
+			local_irq_restore(flags);
+		}
+
+		desc = dmaengine_prep_slave_single(chan, bounce_buf->dma_p_tx,
+						len, buffer_dirn, DMA_CTRL_ACK);
+	} else {
+		nr_sg = dma_map_sg(device->dev, data->sg, data->sg_len,
+				   buffer_dirn);
+		if (nr_sg == 0)
+			return -EINVAL;
+
+		desc = dmaengine_prep_slave_sg(chan, data->sg, nr_sg,
+					       conf.direction, DMA_CTRL_ACK);
+	}
+
 	if (!desc)
 		goto unmap_exit;
 
 	*dma_chan = chan;
 	*dma_desc = desc;
 
+	data->host_cookie = COOKIE_PREP;
+	if (single)
+		data->host_cookie |= COOKIE_SINGLE;
+
 	return 0;
 
  unmap_exit:
-	dma_unmap_sg(device->dev, data->sg, data->sg_len, buffer_dirn);
+	if (!single)
+		dma_unmap_sg(device->dev, data->sg, data->sg_len, buffer_dirn);
 	return -ENOMEM;
 }
 
@@ -525,14 +615,20 @@
 
 	/* No job were prepared thus do it now. */
 	return __mmci_dma_prep_data(host, data, &host->dma_current,
-				    &host->dma_desc_current);
+				    &host->dma_desc_current,
+				    host->bounce_buf);
 }
 
 static inline int mmci_dma_prep_next(struct mmci_host *host,
 				     struct mmc_data *data)
 {
 	struct mmci_host_next *nd = &host->next_data;
-	return __mmci_dma_prep_data(host, data, &nd->dma_chan, &nd->dma_desc);
+	int rv;
+	rv = __mmci_dma_prep_data(host, data, &nd->dma_chan, &nd->dma_desc,
+				    nd->bounce_buf);
+	if (!rv)
+		data->host_cookie |= COOKIE_ID(++host->next_data.cookie_cnt);
+	return rv;
 }
 
 static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
@@ -569,14 +665,22 @@
 static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 {
 	struct mmci_host_next *next = &host->next_data;
+	struct mmci_bounce_buf *tmp;
 
-	WARN_ON(data->host_cookie && data->host_cookie != next->cookie);
+	WARN_ON(data->host_cookie && ((data->host_cookie & COOKIE_ID_MASK) !=
+					COOKIE_ID(next->cookie_cnt)));
 	WARN_ON(!data->host_cookie && (next->dma_desc || next->dma_chan));
 
 	host->dma_desc_current = next->dma_desc;
 	host->dma_current = next->dma_chan;
 	next->dma_desc = NULL;
 	next->dma_chan = NULL;
+
+	if (host->dma_quirks & MCI_DMA_QUIRK_PL18X_TX) {
+		tmp = host->next_data.bounce_buf;
+		host->next_data.bounce_buf = host->bounce_buf;
+		host->bounce_buf = tmp;
+	}
 }
 
 static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq,
@@ -584,7 +688,6 @@
 {
 	struct mmci_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
-	struct mmci_host_next *nd = &host->next_data;
 
 	if (!data)
 		return;
@@ -594,8 +697,7 @@
 	if (mmci_validate_data(host, data))
 		return;
 
-	if (!mmci_dma_prep_next(host, data))
-		data->host_cookie = ++nd->cookie < 0 ? 1 : nd->cookie;
+	mmci_dma_prep_next(host, data);
 }
 
 static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
@@ -836,6 +938,16 @@
 		dev_err(mmc_dev(host->mmc), "stray MCI_DATABLOCKEND interrupt\n");
 
 	if (status & MCI_DATAEND || data->error) {
+		/*
+		 * On pl08x+pl18x, there is a problem with the DMA flow control
+		 * and the last burst transfer is not performed. So we force
+		 * the transfer programmatically here.
+		 */
+		if ((host->dma_quirks & MCI_DMA_QUIRK_PL18X_RX) &&
+		    (data->flags & MMC_DATA_READ) &&
+		    host->dma_rx_channel)
+			dmaengine_device_control(host->dma_rx_channel,
+			    DMA_FORCE_BURST, 0);
 		if (dma_inprogress(host))
 			mmci_dma_finalize(host, data);
 		mmci_stop_data(host);
Index: drivers/mmc/host/mmci.h
===================================================================
--- drivers/mmc/host/mmci.h	(revision 1768)
+++ drivers/mmc/host/mmci.h	(working copy)
@@ -158,10 +158,16 @@
 struct variant_data;
 struct dma_chan;
 
+struct mmci_bounce_buf {
+	void				*dma_v_tx;
+	dma_addr_t			dma_p_tx;
+};
+
 struct mmci_host_next {
 	struct dma_async_tx_descriptor	*dma_desc;
 	struct dma_chan			*dma_chan;
-	s32				cookie;
+	struct mmci_bounce_buf		*bounce_buf;
+	s32				cookie_cnt;
 };
 
 struct mmci_host {
@@ -208,6 +214,10 @@
 	struct dma_async_tx_descriptor	*dma_desc_current;
 	struct mmci_host_next	next_data;
 
+	struct mmci_bounce_buf  *bounce_buf;
+	struct mmci_bounce_buf	bounce_buf_pool[2];
+	u32			dma_quirks;
+
 #define dma_inprogress(host)	((host)->dma_current)
 #else
 #define dma_inprogress(host)	(0)
