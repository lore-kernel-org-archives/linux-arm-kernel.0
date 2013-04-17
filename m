From: cedric@precidata.com (Cedric Berger)
Date: Wed, 17 Apr 2013 22:42:50 +0200 (CEST)
Subject: [PATCH 2/10] LPC32XX: 002-mmc.1: Workaround for MMC+DMA on LPC32xx
Message-ID: <mailman.19.1366231470.1198.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gabriele Mondada <gabriele@precidata.com>
---
the connection between the MMC controller and the DMA on NXP LPC32xx has
silicon bugs. NXP did a patch to workaround this, but it has not been commited
on the main branch. This is a rework of that patch for 3.9 kernel.

Index: mmci.c
===================================================================
--- drivers/mmc/host/mmci.c	(revision 1688)
+++ drivers/mmc/host/mmci.c	(working copy)
@@ -3,6 +3,7 @@
  *
  *  Copyright (C) 2003 Deep Blue Solutions, Ltd, All Rights Reserved.
  *  Copyright (C) 2010 ST-Ericsson SA
+ *  Copyright (C) 2013 Precidata Sarl, Gabriele Mondada
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -44,6 +45,16 @@
 
 #define DRIVER_NAME "mmci-pl18x"
 
+#define COOKIE_PREP	0x00000001
+#define COOKIE_SINGLE	0x00000002
+#define COOKIE_ID_MASK	0xFF000000
+#define COOKIE_ID_SHIFT	24
+#define COOKIE_ID(n)	(COOKIE_ID_MASK & ((n) << COOKIE_ID_SHIFT))
+
+#ifdef CONFIG_ARCH_LPC32XX
+#define DMA_TX_SIZE SZ_64K
+#endif
+
 static unsigned int fmax = 515633;
 
 /**
@@ -303,15 +314,40 @@
 	struct mmci_platform_data *plat = host->plat;
 	const char *rxname, *txname;
 	dma_cap_mask_t mask;
+#ifdef CONFIG_ARCH_LPC32XX
+	int i;
+#endif
 
 	if (!plat || !plat->dma_filter) {
 		dev_info(mmc_dev(host->mmc), "no DMA platform data\n");
 		return;
 	}
 
-	/* initialize pre request cookie */
-	host->next_data.cookie = 1;
+#ifdef CONFIG_ARCH_LPC32XX
+	/*
+	 * The LPC32XX do not support sg on TX DMA. So
+	 * a temporary bounce buffer is used if more than 1 sg segment
+	 * is passed in the data request. The bounce buffer will get a
+	 * contiguous copy of the TX data and it will be used instead.
+	 */
+	for (i = 0; i < 2; i++) {
+		host->bounce_buf_pool[i].dma_v_tx = dma_alloc_coherent(
+			mmc_dev(host->mmc), DMA_TX_SIZE,
+			&host->bounce_buf_pool[i].dma_p_tx, GFP_KERNEL);
+		if (host->bounce_buf_pool[i].dma_v_tx == NULL) {
+			dev_err(mmc_dev(host->mmc),
+				"error getting DMA region\n");
+			return;
+		}
+		dev_info(mmc_dev(host->mmc), "DMA buffer: phy:%p, virt:%p\n",
+			(void *)host->bounce_buf_pool[i].dma_p_tx,
+			 host->bounce_buf_pool[i].dma_v_tx);
+	}
 
+	host->bounce_buf = &host->bounce_buf_pool[0];
+	host->next_data.bounce_buf = &host->bounce_buf_pool[1];
+#endif
+
 	/* Try to acquire a generic DMA engine slave channel */
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
@@ -380,12 +416,27 @@
 static inline void mmci_dma_release(struct mmci_host *host)
 {
 	struct mmci_platform_data *plat = host->plat;
+#ifdef CONFIG_ARCH_LPC32XX
+	int i;
+#endif
 
 	if (host->dma_rx_channel)
 		dma_release_channel(host->dma_rx_channel);
 	if (host->dma_tx_channel && plat->dma_tx_param)
 		dma_release_channel(host->dma_tx_channel);
 	host->dma_rx_channel = host->dma_tx_channel = NULL;
+
+#ifdef CONFIG_ARCH_LPC32XX
+	for (i = 0; i < 2; i++) {
+		if (host->bounce_buf_pool[i].dma_v_tx == NULL)
+			continue;
+		dma_free_coherent(mmc_dev(host->mmc), DMA_TX_SIZE,
+			host->bounce_buf_pool[i].dma_v_tx,
+			host->bounce_buf_pool[i].dma_p_tx);
+		host->bounce_buf_pool[i].dma_v_tx = NULL;
+		host->bounce_buf_pool[i].dma_p_tx = 0;
+	}
+#endif
 }
 
 static void mmci_dma_data_error(struct mmci_host *host)
@@ -394,7 +445,6 @@
 	dmaengine_terminate_all(host->dma_current);
 	host->dma_current = NULL;
 	host->dma_desc_current = NULL;
-	host->data->host_cookie = 0;
 }
 
 static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
@@ -410,7 +460,9 @@
 		chan = host->dma_tx_channel;
 	}
 
-	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len, dir);
+	if (!(data->host_cookie & COOKIE_SINGLE))
+		dma_unmap_sg(chan->device->dev, data->sg, data->sg_len, dir);
+	data->host_cookie = 0;
 }
 
 static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
@@ -457,7 +509,8 @@
 /* prepares DMA channel and DMA descriptor, returns non-zero on failure */
 static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 				struct dma_chan **dma_chan,
-				struct dma_async_tx_descriptor **dma_desc)
+				struct dma_async_tx_descriptor **dma_desc,
+				struct mmci_bounce_buf *bounce_buf)
 {
 	struct variant_data *variant = host->variant;
 	struct dma_slave_config conf = {
@@ -474,7 +527,11 @@
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
@@ -483,6 +540,9 @@
 		conf.direction = DMA_MEM_TO_DEV;
 		buffer_dirn = DMA_TO_DEVICE;
 		chan = host->dma_tx_channel;
+#ifdef CONFIG_ARCH_LPC32XX
+		conf.device_fc = true;
+#endif
 	}
 
 	/* If there's no DMA channel, fall back to PIO */
@@ -494,23 +554,58 @@
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
 
@@ -523,14 +618,20 @@
 
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
@@ -567,14 +668,24 @@
 static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 {
 	struct mmci_host_next *next = &host->next_data;
+#ifdef CONFIG_ARCH_LPC32XX
+	struct mmci_bounce_buf *tmp;
+#endif
 
-	WARN_ON(data->host_cookie && data->host_cookie != next->cookie);
+	WARN_ON(data->host_cookie && ((data->host_cookie & COOKIE_ID_MASK) !=
+					COOKIE_ID(next->cookie_cnt)));
 	WARN_ON(!data->host_cookie && (next->dma_desc || next->dma_chan));
 
 	host->dma_desc_current = next->dma_desc;
 	host->dma_current = next->dma_chan;
 	next->dma_desc = NULL;
 	next->dma_chan = NULL;
+
+#ifdef CONFIG_ARCH_LPC32XX
+	tmp = host->next_data.bounce_buf;
+	host->next_data.bounce_buf = host->bounce_buf;
+	host->bounce_buf = tmp;
+#endif
 }
 
 static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq,
@@ -582,7 +693,6 @@
 {
 	struct mmci_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
-	struct mmci_host_next *nd = &host->next_data;
 
 	if (!data)
 		return;
@@ -592,8 +702,7 @@
 	if (mmci_validate_data(host, data))
 		return;
 
-	if (!mmci_dma_prep_next(host, data))
-		data->host_cookie = ++nd->cookie < 0 ? 1 : nd->cookie;
+	mmci_dma_prep_next(host, data);
 }
 
 static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
@@ -834,6 +943,16 @@
 		dev_err(mmc_dev(host->mmc), "stray MCI_DATABLOCKEND interrupt\n");
 
 	if (status & MCI_DATAEND || data->error) {
+#ifdef CONFIG_ARCH_LPC32XX
+		/*
+		 * On LPC32XX, there is a problem with the DMA flow control and
+		 * the last burst transfer is not performed. So we force the
+		 * transfer programmatically here.
+		 */
+		if ((data->flags & MMC_DATA_READ) && host->dma_rx_channel)
+			dmaengine_device_control(host->dma_rx_channel,
+			    DMA_FORCE_BURST, 0);
+#endif
 		if (dma_inprogress(host))
 			mmci_dma_finalize(host, data);
 		mmci_stop_data(host);
Index: mmci.h
===================================================================
--- drivers/mmc/host/mmci.h	(revision 1688)
+++ drivers/mmc/host/mmci.h	(working copy)
@@ -158,10 +158,20 @@
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
+#ifdef CONFIG_ARCH_LPC32XX
+	void				*dma_v_tx;
+	dma_addr_t			dma_p_tx;
+#endif
 };
 
 struct mmci_host {
@@ -208,6 +218,9 @@
 	struct dma_async_tx_descriptor	*dma_desc_current;
 	struct mmci_host_next	next_data;
 
+	struct mmci_bounce_buf  *bounce_buf;
+	struct mmci_bounce_buf	bounce_buf_pool[2];
+
 #define dma_inprogress(host)	((host)->dma_current)
 #else
 #define dma_inprogress(host)	(0)
