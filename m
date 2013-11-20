From: dan.j.williams@intel.com (Williams, Dan J)
Date: Wed, 20 Nov 2013 20:23:21 +0000
Subject: [PATCH 11/31] dma: add channel request API that supports
 deferred probe
In-Reply-To: <528D0C06.9080006@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-12-git-send-email-swarren@wwwdotorg.org>
 <CAPcyv4heN3PFc+n2RDBviA0zvyU4jfi5VLOcQVR6oRPi1woPTA@mail.gmail.com>
 <1384766276.14845.155.camel@smile>	<528A5170.3090809@wwwdotorg.org>
 <1384862421.14845.222.camel@smile>	<528B9CAE.3040600@wwwdotorg.org>
 <CAPcyv4jR2MufF6PqB3cUwNdQZfzGWVdj1UunBkeyMYm-KvkpCQ@mail.gmail.com>
 <528BFDD0.3090503@wwwdotorg.org>
 <CAPcyv4i7o0RP4ovG1S8RbiV9wqV+VZWX+2vBm3iKnVLCYfrnBQ@mail.gmail.com>
 <528CFE68.6060908@wwwdotorg.org>
 <CAPcyv4hjJDOq+qEvuCG32PLQcWeHVyeVDCy=5UM8KX445OxY_w@mail.gmail.com>
 <528D0C06.9080006@wwwdotorg.org>
Message-ID: <1384979000.2067.5.camel@dwillia2-mobl1.amr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-11-20 at 12:22 -0700, Stephen Warren wrote:
> On 11/20/2013 12:15 PM, Dan Williams wrote:
> > On Wed, Nov 20, 2013 at 10:24 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> >> On 11/19/2013 05:38 PM, Dan Williams wrote:
> >>> On Tue, Nov 19, 2013 at 4:09 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> >>>> Deferred probe certainly isn't the only error that can be returned
> >>>> though,
> >>>
> >>> Of course, but do any of those other ones matter?  Certainly not if
> >>> they've all been hidden behind a NULL return from
> >>> dma_request_slave_channel().
> >>>
> >>>> so I don't think "defer" in the name makes much sense. The
> >>>> function as I wrote it returns a standard "error pointer" value.
> >>>> Typically, callers would simply propagate *any* error code back to the
> >>>> caller of probe() without even looking at it; it's the driver core that
> >>>> checks for -EPROBE_DEFER vs. other error codes. In some cases, drivers
> >>>> do check in order to avoid printing failure messages in the deferred
> >>>> probe case, but again that's pretty standard, and not something specific
> >>>> to this API.
> >>>
> >>> Right, but the only reason to introduce this API is to propagate
> >>> EPROBE_DEFER, right?  It also serves to document drivers that are
> >>> prepared for / depend on deferred probing support.
> >>
> >> Well, that's the reason I'm introducing the API, but it's not really
> >> what the API actually does.
> >>
> > 
> > True, this is quite a bit of back and forth for something that will be
> > temporary.  How bad would it be to short-circuit this discussion and
> > go straight to converting dma_request_slave_channel().  Leave
> > dma_request_channel() as is and just convert the 20 or so users of
> > dma_request_slave_channel() over?
> 
> I had thought about that, but there are drivers that use
> dma_request_slave_channel(), but fall back to dma_request_channel() if
> that fails. I think there were other cases where the two APIs were
> mixed. Drivers would then have a value that sometimes IS_ERR() or is
> valid, and other times ==NULL or is valid. So, the values would have to
> be checked using IS_ERR_OR_NULL() which I believe is now deprecated  -
> certainly Russell will shout at me if I start introducing more usage! 

Ok, I found the discussion about IS_ERR_OR_NULL(), but actually we would
not need to use it, just check for NULL and return an error in
__dma_request_slave_channel.

> So
> that means converting dma_request_channel()'s return value too, and that
> is a /lot/ more to convert. I suppose an alternative might be to have
> the individual affected drivers convert a NULL return from
> dma_request_channel() to an ERR value, but for some reason I forget now,
> even that looked problematic.

Why do the drivers that call dma_request_channel need to convert it to
an ERR value?  i.e. what's problematic about the below (not compile
tested)?

btw, samsung_dmadev_request() looks like a crash waiting to happen when
that hardware ip shows up on a 64-bit system.


diff --git a/arch/arm/plat-samsung/dma-ops.c b/arch/arm/plat-samsung/dma-ops.c
index ec0d731b0e7b..abee452bcf6e 100644
--- a/arch/arm/plat-samsung/dma-ops.c
+++ b/arch/arm/plat-samsung/dma-ops.c
@@ -22,16 +22,20 @@ static unsigned samsung_dmadev_request(enum dma_ch dma_ch,
 				struct samsung_dma_req *param,
 				struct device *dev, char *ch_name)
 {
+	struct dma_chan *chan;
+
 	dma_cap_mask_t mask;
 
 	dma_cap_zero(mask);
 	dma_cap_set(param->cap, mask);
 
-	if (dev->of_node)
-		return (unsigned)dma_request_slave_channel(dev, ch_name);
-	else
+	if (dev->of_node) {
+		chan = dma_request_slave_channel(dev, ch_name);
+		return IS_ERR(chan) ? (unsigned) NULL : (unsigned) chan;
+	} else {
 		return (unsigned)dma_request_channel(mask, pl330_filter,
 							(void *)dma_ch);
+	}
 }
 
 static int samsung_dmadev_release(unsigned ch, void *param)
diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 853f610af28f..c483b095e157 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -528,7 +528,8 @@ static void data_xfer(struct work_struct *work)
 	/* request dma channels */
 	/* dma_request_channel may sleep, so calling from process context */
 	acdev->dma_chan = dma_request_slave_channel(acdev->host->dev, "data");
-	if (!acdev->dma_chan) {
+	if (IS_ERR(acdev->dma_chan)) {
+		acdev->dma_chan = NULL;
 		dev_err(acdev->host->dev, "Unable to get dma_chan\n");
 		goto chan_request_fail;
 	}
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 9162ac80c18f..64c163664b9d 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -593,15 +593,20 @@ EXPORT_SYMBOL_GPL(__dma_request_channel);
  */
 struct dma_chan *dma_request_slave_channel(struct device *dev, const char *name)
 {
+	struct dma_chan *chan = ERR_PTR(-ENODEV);
+
 	/* If device-tree is present get slave info from here */
 	if (dev->of_node)
 		return of_dma_request_slave_channel(dev->of_node, name);
 
 	/* If device was enumerated by ACPI get slave info from here */
-	if (ACPI_HANDLE(dev))
-		return acpi_dma_request_slave_chan_by_name(dev, name);
+	if (ACPI_HANDLE(dev)) {
+		chan = acpi_dma_request_slave_chan_by_name(dev, name);
+		if (!chan)
+			chan = ERR_PTR(-ENODEV);
+	}
 
-	return NULL;
+	return chan;
 }
 EXPORT_SYMBOL_GPL(dma_request_slave_channel);
 
diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index b7c857774708..777e18db654a 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -723,7 +723,8 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 
 	/* Setup the DMA */
 	i2c->dmach = dma_request_slave_channel(dev, "rx-tx");
-	if (!i2c->dmach) {
+	if (IS_ERR(i2c->dmach)) {
+		i2c->dmach = NULL;
 		dev_err(dev, "Failed to request dma\n");
 		return -ENODEV;
 	}
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index c3785edc0e92..342408961590 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -350,6 +350,11 @@ static void mmci_dma_setup(struct mmci_host *host)
 	host->dma_rx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "rx");
 	host->dma_tx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "tx");
 
+	if (IS_ERR(host->dma_rx_channel))
+		host->dma_rx_channel = NULL;
+	if (IS_ERR(host->dma_tx_channel))
+		host->dma_tx_channel = NULL;
+
 	/* initialize pre request cookie */
 	host->next_data.cookie = 1;
 
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index c174c6a0d224..527c1a427b13 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1170,11 +1170,13 @@ static int mxcmci_probe(struct platform_device *pdev)
 			host->dma = dma_request_channel(mask, filter, host);
 		}
 	}
-	if (host->dma)
+	if (!IS_ERR(host->dma))
 		mmc->max_seg_size = dma_get_max_seg_size(
 				host->dma->device->dev);
-	else
+	else {
+		host->dma = NULL;
 		dev_info(mmc_dev(host->mmc), "dma not available. Using PIO\n");
+	}
 
 	INIT_WORK(&host->datawork, mxcmci_datawork);
 
diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index e1fa3ef735e0..f5411a6001fa 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -636,7 +636,8 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	}
 
 	ssp->dmach = dma_request_slave_channel(&pdev->dev, "rx-tx");
-	if (!ssp->dmach) {
+	if (IS_ERR(ssp->dmach)) {
+		ssp->dmach = NULL;
 		dev_err(mmc_dev(host->mmc),
 			"%s: failed to request dma\n", __func__);
 		ret = -ENODEV;
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 59ab0692f0b9..fbe1f372faca 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -564,7 +564,7 @@ static int acquire_dma_channels(struct gpmi_nand_data *this)
 
 	/* request dma channel */
 	dma_chan = dma_request_slave_channel(&pdev->dev, "rx-tx");
-	if (!dma_chan) {
+	if (IS_ERR(dma_chan)) {
 		pr_err("Failed to request DMA channel.\n");
 		goto acquire_err;
 	}
diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index de7b1141b90f..7a3ebe87b106 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -552,7 +552,8 @@ static int mxs_spi_probe(struct platform_device *pdev)
 		goto out_master_free;
 
 	ssp->dmach = dma_request_slave_channel(&pdev->dev, "rx-tx");
-	if (!ssp->dmach) {
+	if (IS_ERR(ssp->dmach)) {
+		ssp->dmach = NULL;
 		dev_err(ssp->dev, "Failed to request DMA\n");
 		ret = -ENODEV;
 		goto out_master_free;
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 9c511a954d21..38d4121f7073 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1140,11 +1140,11 @@ static int pl022_dma_autoprobe(struct pl022 *pl022)
 
 	/* automatically configure DMA channels from platform, normally using DT */
 	pl022->dma_rx_channel = dma_request_slave_channel(dev, "rx");
-	if (!pl022->dma_rx_channel)
+	if (IS_ERR(pl022->dma_rx_channel))
 		goto err_no_rxchan;
 
 	pl022->dma_tx_channel = dma_request_slave_channel(dev, "tx");
-	if (!pl022->dma_tx_channel)
+	if (IS_ERR(pl022->dma_tx_channel))
 		goto err_no_txchan;
 
 	pl022->dummypage = kmalloc(PAGE_SIZE, GFP_KERNEL);
@@ -1155,11 +1155,11 @@ static int pl022_dma_autoprobe(struct pl022 *pl022)
 
 err_no_dummypage:
 	dma_release_channel(pl022->dma_tx_channel);
-	pl022->dma_tx_channel = NULL;
 err_no_txchan:
+	pl022->dma_tx_channel = NULL;
 	dma_release_channel(pl022->dma_rx_channel);
-	pl022->dma_rx_channel = NULL;
 err_no_rxchan:
+	pl022->dma_rx_channel = NULL;
 	return -ENODEV;
 }
 		
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index aaa22867e656..c0f400c3c954 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -278,7 +278,7 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
 
 	chan = dma_request_slave_channel(dev, "tx");
 
-	if (!chan) {
+	if (IS_ERR(chan)) {
 		/* We need platform data */
 		if (!plat || !plat->dma_filter) {
 			dev_info(uap->port.dev, "no DMA platform data\n");
@@ -305,8 +305,10 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
 
 	/* Optionally make use of an RX channel as well */
 	chan = dma_request_slave_channel(dev, "rx");
+	if (IS_ERR(chan))
+		chan = NULL;
 	
-	if (!chan && plat->dma_rx_param) {
+	if (chan && plat->dma_rx_param) {
 		chan = dma_request_channel(mask, plat->dma_filter, plat->dma_rx_param);
 
 		if (!chan) {
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index d067285a2d20..c0ae083e061c 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -723,8 +723,10 @@ static int atmel_prepare_tx_dma(struct uart_port *port)
 	dma_cap_set(DMA_SLAVE, mask);
 
 	atmel_port->chan_tx = dma_request_slave_channel(port->dev, "tx");
-	if (atmel_port->chan_tx == NULL)
+	if (IS_ERR(atmel_port->chan_tx)) {
+		atmel_port->chan_tx = NULL;
 		goto chan_err;
+	}
 	dev_info(port->dev, "using %s for tx DMA transfers\n",
 		dma_chan_name(atmel_port->chan_tx));
 
@@ -890,8 +892,10 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	dma_cap_set(DMA_CYCLIC, mask);
 
 	atmel_port->chan_rx = dma_request_slave_channel(port->dev, "rx");
-	if (atmel_port->chan_rx == NULL)
+	if (IS_ERR(atmel_port->chan_rx)) {
+		atmel_port->chan_rx = NULL;
 		goto chan_err;
+	}
 	dev_info(port->dev, "using %s for rx DMA transfers\n",
 		dma_chan_name(atmel_port->chan_rx));
 
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 042aa077b5b3..1e4cb60ce0af 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -985,7 +985,8 @@ static int imx_uart_dma_init(struct imx_port *sport)
 
 	/* Prepare for RX : */
 	sport->dma_chan_rx = dma_request_slave_channel(dev, "rx");
-	if (!sport->dma_chan_rx) {
+	if (IS_ERR(sport->dma_chan_rx)) {
+		sport->dma_chan_rx = NULL;
 		dev_dbg(dev, "cannot get the DMA channel.\n");
 		ret = -EINVAL;
 		goto err;
@@ -1011,7 +1012,8 @@ static int imx_uart_dma_init(struct imx_port *sport)
 
 	/* Prepare for TX : */
 	sport->dma_chan_tx = dma_request_slave_channel(dev, "tx");
-	if (!sport->dma_chan_tx) {
+	if (IS_ERR(sport->dma_chan_tx)) {
+		sport->dma_chan_tx = NULL;
 		dev_err(dev, "cannot get the TX DMA channel!\n");
 		ret = -EINVAL;
 		goto err;
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 10e9d70b5c40..cc9747ab71cd 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -530,16 +530,20 @@ static int mxs_auart_dma_init(struct mxs_auart_port *s)
 
 	/* init for RX */
 	s->rx_dma_chan = dma_request_slave_channel(s->dev, "rx");
-	if (!s->rx_dma_chan)
+	if (IS_ERR(s->rx_dma_chan)) {
+		s->rx_dma_chan = NULL;
 		goto err_out;
+	}
 	s->rx_dma_buf = kzalloc(UART_XMIT_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!s->rx_dma_buf)
 		goto err_out;
 
 	/* init for TX */
 	s->tx_dma_chan = dma_request_slave_channel(s->dev, "tx");
-	if (!s->tx_dma_chan)
+	if (IS_ERR(s->tx_dma_chan)) {
+		s->tx_dma_chan = NULL;
 		goto err_out;
+	}
 	s->tx_dma_buf = kzalloc(UART_XMIT_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!s->tx_dma_buf)
 		goto err_out;
diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
index ff9d6de2b746..b71c5f138968 100644
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -502,7 +502,7 @@ static int cppi41_dma_controller_start(struct cppi41_dma_controller *controller)
 		musb_dma->max_len = SZ_4M;
 
 		dc = dma_request_slave_channel(dev, str);
-		if (!dc) {
+		if (IS_ERR(dc)) {
 			dev_err(dev, "Falied to request %s.\n", str);
 			ret = -EPROBE_DEFER;
 			goto err;
diff --git a/drivers/usb/musb/ux500_dma.c b/drivers/usb/musb/ux500_dma.c
index 3700e9713258..6c863b90ad66 100644
--- a/drivers/usb/musb/ux500_dma.c
+++ b/drivers/usb/musb/ux500_dma.c
@@ -330,13 +330,14 @@ static int ux500_dma_controller_start(struct ux500_dma_controller *controller)
 			ux500_channel->dma_chan =
 				dma_request_slave_channel(dev, chan_names[ch_num]);
 
-			if (!ux500_channel->dma_chan)
+			if (IS_ERR(ux500_channel->dma_chan)) {
 				ux500_channel->dma_chan =
 					dma_request_channel(mask,
 							    data ?
 							    data->dma_filter :
 							    NULL,
 							    param_array[ch_num]);
+			}
 
 			if (!ux500_channel->dma_chan) {
 				ERR("Dma pipe allocation error dir=%d ch=%d\n",
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 0bc727534108..0da9425d64e7 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1056,7 +1056,7 @@ static inline struct dma_chan
 	struct dma_chan *chan;
 
 	chan = dma_request_slave_channel(dev, name);
-	if (chan)
+	if (!IS_ERR(chan))
 		return chan;
 
 	return __dma_request_channel(mask, fn, fn_param);
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index a11405de86e8..56c3056cdac7 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -125,7 +125,7 @@ static int omap_pcm_open(struct snd_pcm_substream *substream)
 
 		chan = dma_request_slave_channel(rtd->cpu_dai->dev,
 						 dma_data->filter_data);
-		ret = snd_dmaengine_pcm_open(substream, chan);
+		ret = snd_dmaengine_pcm_open(substream, IS_ERR(chan) ? NULL : chan);
 	} else {
 		ret = snd_dmaengine_pcm_open_request_chan(substream,
 							  omap_dma_filter_fn,
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index e29ec3cd84b1..4182b203fad5 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -227,11 +227,15 @@ static void dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
 
 	if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX) {
 		pcm->chan[0] = dma_request_slave_channel(dev, "rx-tx");
+		if (IS_ERR(pcm->chan[0]))
+			pcm->chan[0] = NULL;
 		pcm->chan[1] = pcm->chan[0];
 	} else {
 		for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
 			pcm->chan[i] = dma_request_slave_channel(dev,
 					dmaengine_pcm_dma_channel_names[i]);
+			if (IS_ERR(pcm->chan[i]))
+				pcm->chan[i] = NULL;
 		}
 	}
 }
