From: gabriele@precidata.com (Gabriele Mondada)
Date: Thu, 20 Dec 2012 11:06:15 +0100
Subject: LPC32xx and MMCI driver
In-Reply-To: <50D2E156.20707@precidata.com>
References: <50D2E156.20707@precidata.com>
Message-ID: <50D2E317.6000005@precidata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
Currently, LPC32xx plateform do not enable DMA on the mmci driver. This 
makes the driver useless because getting out data from a 64 bytes FIFO 
by interrupt is not fast enough (at standard SD-card data rate).

DMA is not enabled because LPC32xx has a bug that prevent DMA to work 
properly with the MMC controller (silicon bug, I guess). NXP did a patch 
to workaround this, but it has not been commited on the main branch. The 
patch is for linux 2.6.39.2 and does not use dmaengine.

So, I reworked this patch to make it compatible with the last kernel 
(3.7). Here it is. Have I any chance to see this patch be commited on 
the main branch?

Thanks a lot,
Gabriele


diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index d1cc579..cdc8899 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -385,6 +385,7 @@ static void pl08x_start_next_txd(struct 
pl08x_dma_chan *plchan)
      while ((val & PL080_CONFIG_ACTIVE) || (val & PL080_CONFIG_ENABLE))
          val = readl(phychan->base + PL080_CH_CONFIG);

+    /* TODO: why val and not txd->ccfg ? */
      writel(val | PL080_CONFIG_ENABLE, phychan->base + PL080_CH_CONFIG);
  }

@@ -1758,6 +1759,26 @@ static void pl08x_free_virtual_channels(struct 
dma_device *dmadev)
      }
  }

+#ifdef CONFIG_ARCH_LPC32XX
+/*
+ * This exported function is used by mmci driver to workaround a bug in the
+ * LPC32xx CPU.
+ */
+void pl08x_force_dma_burst(struct dma_chan *chan)
+{
+    struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
+    struct pl08x_driver_data *pl08x = plchan->host;
+
+    dev_dbg(&pl08x->adev->dev,
+        "force burst signal=%d chan=%p plchan=%p\n",
+        plchan->signal, chan, plchan);
+    if (plchan->signal >= 0)
+        writel(1 << plchan->signal, pl08x->base + PL080_SOFT_BREQ);
+}
+
+EXPORT_SYMBOL_GPL(pl08x_force_dma_burst);
+#endif
+
  #ifdef CONFIG_DEBUG_FS
  static const char *pl08x_state_str(enum pl08x_dma_chan_state state)
  {
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index edc3e9b..0890905 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -3,6 +3,7 @@
   *
   *  Copyright (C) 2003 Deep Blue Solutions, Ltd, All Rights Reserved.
   *  Copyright (C) 2010 ST-Ericsson SA
+ *  Copyright (C) 2012 Gabriele Mondada <gmondada@precidata.com>
   *
   * This program is free software; you can redistribute it and/or modify
   * it under the terms of the GNU General Public License version 2 as
@@ -42,6 +43,16 @@

  #define DRIVER_NAME "mmci-pl18x"

+#define COOKIE_PREP    0x00000001
+#define COOKIE_SINGLE    0x00000002
+#define COOKIE_ID_MASK    0xFF000000
+#define COOKIE_ID_SHIFT    24
+#define COOKIE_ID(n)    (COOKIE_ID_MASK & ((n) << COOKIE_ID_SHIFT))
+
+#ifdef CONFIG_ARCH_LPC32XX
+#define DMA_TX_SIZE SZ_64K
+#endif
+
  static unsigned int fmax = 515633;

  /**
@@ -132,6 +143,10 @@ static struct variant_data variant_ux500v2 = {
      .signal_direction    = true,
  };

+#ifdef CONFIG_ARCH_LPC32XX
+void pl08x_force_dma_burst(struct dma_chan *chan);
+#endif
+
  /*
   * This must be called with host->lock held
   */
@@ -266,14 +281,38 @@ static void __devinit mmci_dma_setup(struct 
mmci_host *host)
      struct mmci_platform_data *plat = host->plat;
      const char *rxname, *txname;
      dma_cap_mask_t mask;
-
+#ifdef CONFIG_ARCH_LPC32XX
+    int i;
+#endif
+
      if (!plat || !plat->dma_filter) {
          dev_info(mmc_dev(host->mmc), "no DMA platform data\n");
          return;
      }

-    /* initialize pre request cookie */
-    host->next_data.cookie = 1;
+#ifdef CONFIG_ARCH_LPC32XX
+    /*
+     * The LPC32XX do not support sg on TX DMA. So
+     * a temporary bouncing buffer is used if more than 1 sg segment
+     * is passed in the data request. The bouncing buffer will get a
+     * contiguous copy of the TX data and it will be used instead.
+     */
+    for (i=0; i<2; i++) {
+            host->dma_v_tx[i] = dma_alloc_coherent(mmc_dev(host->mmc),
+            DMA_TX_SIZE, &host->dma_p_tx[i], GFP_KERNEL);
+            if (host->dma_v_tx[i] == NULL) {
+            dev_err(mmc_dev(host->mmc), "error getting DMA region\n");
+            return;
+        }
+            dev_info(mmc_dev(host->mmc), "DMA buffer: phy:%p, virt:%p\n",
+            (void *)host->dma_p_tx[i], host->dma_v_tx[i]);
+    }
+
+    host->dma_v_tx_current = host->dma_v_tx[0];
+    host->dma_p_tx_current = host->dma_p_tx[0];
+    host->next_data.dma_v_tx = host->dma_v_tx[1];
+    host->next_data.dma_p_tx = host->dma_p_tx[1];
+#endif

      /* Try to acquire a generic DMA engine slave channel */
      dma_cap_zero(mask);
@@ -343,12 +382,26 @@ static void __devinit mmci_dma_setup(struct 
mmci_host *host)
  static inline void mmci_dma_release(struct mmci_host *host)
  {
      struct mmci_platform_data *plat = host->plat;
+#ifdef CONFIG_ARCH_LPC32XX
+    int i;
+#endif

      if (host->dma_rx_channel)
          dma_release_channel(host->dma_rx_channel);
      if (host->dma_tx_channel && plat->dma_tx_param)
          dma_release_channel(host->dma_tx_channel);
      host->dma_rx_channel = host->dma_tx_channel = NULL;
+
+#ifdef CONFIG_ARCH_LPC32XX
+    for (i=0; i<2; i++) {
+        if (host->dma_v_tx[i] == NULL)
+            continue;
+        dma_free_coherent(mmc_dev(host->mmc), DMA_TX_SIZE,
+            host->dma_v_tx[i], host->dma_p_tx[i]);
+        host->dma_v_tx[i] = NULL;
+        host->dma_p_tx[i] = 0;
+    }
+#endif
  }

  static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
@@ -384,8 +437,9 @@ static void mmci_dma_unmap(struct mmci_host *host, 
struct mmc_data *data)
          dir = DMA_FROM_DEVICE;
      }

-    if (!data->host_cookie)
+    if (data->host_cookie && !(data->host_cookie & COOKIE_SINGLE))
          dma_unmap_sg(chan->device->dev, data->sg, data->sg_len, dir);
+    /* TODO: no data->host_cookie=0 here ? */

      /*
       * Use of DMA with scatter-gather is impossible.
@@ -421,6 +475,7 @@ static int mmci_dma_prep_data(struct mmci_host 
*host, struct mmc_data *data,
      struct dma_async_tx_descriptor *desc;
      enum dma_data_direction buffer_dirn;
      int nr_sg;
+    bool single = false;

      /* Check if next job is already prepared */
      if (data->host_cookie && !next &&
@@ -440,6 +495,9 @@ static int mmci_dma_prep_data(struct mmci_host 
*host, struct mmc_data *data,
          conf.direction = DMA_MEM_TO_DEV;
          buffer_dirn = DMA_TO_DEVICE;
          chan = host->dma_tx_channel;
+#ifdef CONFIG_ARCH_LPC32XX
+        conf.device_fc = true;
+#endif
      }

      /* If there's no DMA channel, fall back to PIO */
@@ -451,13 +509,46 @@ static int mmci_dma_prep_data(struct mmci_host 
*host, struct mmc_data *data,
          return -EINVAL;

      device = chan->device;
-    nr_sg = dma_map_sg(device->dev, data->sg, data->sg_len, buffer_dirn);
-    if (nr_sg == 0)
-        return -EINVAL;
-
      dmaengine_slave_config(chan, &conf);
-    desc = dmaengine_prep_slave_sg(chan, data->sg, nr_sg,
-                        conf.direction, DMA_CTRL_ACK);
+
+#ifdef CONFIG_ARCH_LPC32XX
+    if ((data->flags & MMC_DATA_WRITE) && (data->sg_len > 1))
+        single = true;
+#endif
+
+    if (single) {
+        int i;
+        unsigned char *dst = next ? next->dma_v_tx : 
host->dma_v_tx_current;
+        size_t len = 0;
+
+        dev_dbg(mmc_dev(host->mmc), "use bounce buffer\n");
+        /* Move data to contiguous buffer first, then transfer it */
+            for (i = 0; i < data->sg_len; i++) {
+            unsigned long flags;
+            struct scatterlist *sg = &data->sg[i];
+            void *src;
+
+                    /* Map the current scatter buffer, copy data, and 
unmap */
+            local_irq_save(flags);
+            src = (unsigned char *)kmap_atomic(sg_page(sg)) + sg->offset;
+                    memcpy(dst + len, src, sg->length);
+                    len += sg->length;
+            kunmap_atomic(src);
+            local_irq_restore(flags);
+            }
+
+        desc = dmaengine_prep_slave_single(chan,
+            next ? next->dma_p_tx : host->dma_p_tx_current,
+            len, buffer_dirn, DMA_CTRL_ACK);
+    } else {
+        nr_sg = dma_map_sg(device->dev, data->sg, data->sg_len, 
buffer_dirn);
+        if (nr_sg == 0)
+            return -EINVAL;
+
+        desc = dmaengine_prep_slave_sg(chan, data->sg, nr_sg,
+                            conf.direction, DMA_CTRL_ACK);
+    }
+
      if (!desc)
          goto unmap_exit;

@@ -469,12 +560,20 @@ static int mmci_dma_prep_data(struct mmci_host 
*host, struct mmc_data *data,
          host->dma_desc_current = desc;
      }

+    data->host_cookie = COOKIE_PREP;
+    if (single)
+        data->host_cookie |= COOKIE_SINGLE;
+    if (next)
+        data->host_cookie |= COOKIE_ID(++next->cookie_cnt);
+
      return 0;

   unmap_exit:
      if (!next)
          dmaengine_terminate_all(chan);
-    dma_unmap_sg(device->dev, data->sg, data->sg_len, buffer_dirn);
+    if (!single)
+        dma_unmap_sg(device->dev, data->sg, data->sg_len, buffer_dirn);
+    data->host_cookie = 0;
      return -ENOMEM;
  }

@@ -512,11 +611,16 @@ static int mmci_dma_start_data(struct mmci_host 
*host, unsigned int datactrl)
  static void mmci_get_next_data(struct mmci_host *host, struct mmc_data 
*data)
  {
      struct mmci_host_next *next = &host->next_data;
+#ifdef CONFIG_ARCH_LPC32XX
+    void *tmp_v;
+    dma_addr_t tmp_p;
+#endif

-    if (data->host_cookie && data->host_cookie != next->cookie) {
-        pr_warning("[%s] invalid cookie: data->host_cookie %d"
-               " host->next_data.cookie %d\n",
-               __func__, data->host_cookie, host->next_data.cookie);
+    if (data->host_cookie && ((data->host_cookie & COOKIE_ID_MASK) !=
+                    COOKIE_ID(next->cookie_cnt))) {
+        pr_warning("[%s] invalid cookie: data->host_cookie=0x%08x"
+               " host->next_data.cookie_cnt=0x%08x\n",
+               __func__, data->host_cookie, host->next_data.cookie_cnt);
          data->host_cookie = 0;
      }

@@ -528,6 +632,15 @@ static void mmci_get_next_data(struct mmci_host 
*host, struct mmc_data *data)

      next->dma_desc = NULL;
      next->dma_chan = NULL;
+
+#ifdef CONFIG_ARCH_LPC32XX
+    tmp_v = host->next_data.dma_v_tx;
+    host->next_data.dma_v_tx = host->dma_v_tx_current;
+    host->dma_v_tx_current = tmp_v;
+    tmp_p = host->next_data.dma_p_tx;
+    host->next_data.dma_p_tx = host->dma_p_tx_current;
+    host->dma_p_tx_current = tmp_p;
+#endif
  }

  static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request 
*mrq,
@@ -551,7 +664,7 @@ static void mmci_pre_request(struct mmc_host *mmc, 
struct mmc_request *mrq,
          if (mmci_dma_prep_data(host, data, nd))
              data->host_cookie = 0;
          else
-            data->host_cookie = ++nd->cookie < 0 ? 1 : nd->cookie;
+            data->host_cookie = COOKIE_ID(++nd->cookie_cnt) | COOKIE_PREP;
      }
  }

@@ -579,7 +692,7 @@ static void mmci_post_request(struct mmc_host *mmc, 
struct mmc_request *mrq,
      if (chan) {
          if (err)
              dmaengine_terminate_all(chan);
-        if (data->host_cookie)
+        if (data->host_cookie && !(data->host_cookie & COOKIE_SINGLE))
              dma_unmap_sg(mmc_dev(host->mmc), data->sg,
                       data->sg_len, dir);
          mrq->data->host_cookie = 0;
@@ -767,6 +880,15 @@ mmci_data_irq(struct mmci_host *host, struct 
mmc_data *data,
          dev_err(mmc_dev(host->mmc), "stray MCI_DATABLOCKEND interrupt\n");

      if (status & MCI_DATAEND || data->error) {
+#ifdef CONFIG_ARCH_LPC32XX
+        /*
+         * On LPC32XX, there is a problem with the DMA flow control and
+         * the last burst transfer is not performed. So we force the
+         * transfer programmatically here.
+         */
+        if (data->flags & MMC_DATA_READ)
+            pl08x_force_dma_burst(host->dma_rx_channel);
+#endif
          if (dma_inprogress(host))
              mmci_dma_unmap(host, data);
          mmci_stop_data(host);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index d437ccf..6e1ea3f 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -159,7 +159,11 @@ struct dma_chan;
  struct mmci_host_next {
      struct dma_async_tx_descriptor    *dma_desc;
      struct dma_chan            *dma_chan;
-    s32                cookie;
+    s32                cookie_cnt;
+#ifdef CONFIG_ARCH_LPC32XX
+    void                *dma_v_tx;
+    dma_addr_t            dma_p_tx;
+#endif
  };

  struct mmci_host {
@@ -202,6 +206,12 @@ struct mmci_host {
      struct dma_chan        *dma_tx_channel;
      struct dma_async_tx_descriptor    *dma_desc_current;
      struct mmci_host_next    next_data;
+#ifdef CONFIG_ARCH_LPC32XX
+    void            *dma_v_tx[2];
+    dma_addr_t        dma_p_tx[2];
+    void            *dma_v_tx_current;
+    dma_addr_t        dma_p_tx_current;
+#endif

  #define dma_inprogress(host)    ((host)->dma_current)
  #else
