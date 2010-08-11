From: rabin@rab.in (Rabin Vincent)
Date: Wed, 11 Aug 2010 20:18:59 +0530
Subject: [PATCH] ARM: add PrimeCell generic DMA to MMCI/PL180 v10
In-Reply-To: <1281454328-22805-1-git-send-email-linus.walleij@stericsson.com>
References: <1281454328-22805-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20100811144859.GC5846@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 10, 2010 at 05:32:08PM +0200, Linus Walleij wrote:
> This extends the MMCI/PL180 driver with generic DMA engine support
> using the PrimeCell DMA engine interface.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> Changes v9->v10:
> - Rebased on top of Rabins MMCI patches
> - Added a special bit write for the ux500 variants
> ---
>  drivers/mmc/host/mmci.c   |  259 ++++++++++++++++++++++++++++++++++++++++++--
>  drivers/mmc/host/mmci.h   |   12 ++
>  include/linux/amba/mmci.h |   16 +++
>  3 files changed, 275 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index f0c7313..7f7059f 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -2,7 +2,7 @@
>   *  linux/drivers/mmc/host/mmci.c - ARM PrimeCell MMCI PL180/1 driver
>   *
>   *  Copyright (C) 2003 Deep Blue Solutions, Ltd, All Rights Reserved.
> - *  Copyright (C) 2010 ST-Ericsson AB.
> + *  Copyright (C) 2010 ST-Ericsson SA
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -23,8 +23,10 @@
>  #include <linux/clk.h>
>  #include <linux/scatterlist.h>
>  #include <linux/gpio.h>
> -#include <linux/amba/mmci.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/amba/mmci.h>
>  
>  #include <asm/div64.h>
>  #include <asm/io.h>
> @@ -40,6 +42,7 @@ static unsigned int fmax = 515633;
>   * struct variant_data - MMCI variant-specific quirks
>   * @clkreg: default value for MCICLOCK register
>   * @clkreg_enable: enable value for MMCICLOCK register
> + * @dmareg_enable: enable value for MMCIDATACTRL register
>   * @datalength_bits: number of bits in the MMCIDATALENGTH register
>   * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
>   *	      is asserted (likewise for RX)
> @@ -50,6 +53,7 @@ static unsigned int fmax = 515633;
>  struct variant_data {
>  	unsigned int		clkreg;
>  	unsigned int		clkreg_enable;
> +	unsigned int		dmareg_enable;
>  	unsigned int		datalength_bits;
>  	unsigned int		fifosize;
>  	unsigned int		fifohalfsize;
> @@ -74,6 +78,7 @@ static struct variant_data variant_ux500 = {
>  	.fifohalfsize		= 8 * 4,
>  	.clkreg			= MCI_CLK_ENABLE,
>  	.clkreg_enable		= 1 << 14, /* HWFCEN */
> +	.dmareg_enable		= 1 << 12, /* DMAREQCTRL */
>  	.datalength_bits	= 24,
>  	.singleirq		= true,
>  };
> @@ -169,6 +174,209 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
>  	sg_miter_start(&host->sg_miter, data->sg, data->sg_len, flags);
>  }
>  
> +/*
> + * All the DMA operation mode stuff goes inside this ifdef.
> + * This assumes that you have a generic DMA device interface,
> + * no custom DMA interfaces are supported.
> + */
> +#ifdef CONFIG_DMADEVICES
> +static void __devinit mmci_setup_dma(struct mmci_host *host)
> +{
> +	struct mmci_platform_data *plat = host->plat;
> +	dma_cap_mask_t mask;
> +
> +	if (!plat || !plat->dma_filter) {
> +		dev_err(mmc_dev(host->mmc), "no DMA platform data!\n");
> +		return;
> +	}
> +
> +	/* Try to acquire a generic DMA engine slave channel */
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +	/*
> +	 * If only an RX channel is specified, the driver will
> +	 * attempt to use it bidirectionally, however if it is
> +	 * is specified but cannot be located, DMA will be disabled.
> +	 */
> +	host->dma_rx_channel = dma_request_channel(mask,
> +						plat->dma_filter,
> +						plat->dma_rx_param);
> +	/* E.g if no DMA hardware is present */
> +	if (!host->dma_rx_channel) {
> +		dev_err(mmc_dev(host->mmc), "no RX DMA channel!\n");
> +		return;
> +	}
> +	if (plat->dma_tx_param) {
> +		host->dma_tx_channel = dma_request_channel(mask,
> +							   plat->dma_filter,
> +							   plat->dma_tx_param);
> +		if (!host->dma_tx_channel) {
> +			dma_release_channel(host->dma_rx_channel);
> +			host->dma_rx_channel = NULL;

There's a return missing here.

> +		}
> +	} else {
> +		host->dma_tx_channel = host->dma_rx_channel;
> +	}
> +	host->enable_dma = true;
> +	dev_info(mmc_dev(host->mmc), "use DMA channels DMA RX %s, DMA TX %s\n",
> +		 dma_chan_name(host->dma_rx_channel),
> +		 dma_chan_name(host->dma_tx_channel));
> +}
> +
> +static void __devexit mmci_disable_dma(struct mmci_host *host)
> +{

I don't think this should be __devexit since you're also calling it from
a __devinit function.

> +	if (host->dma_rx_channel)
> +		dma_release_channel(host->dma_rx_channel);
> +	if (host->dma_tx_channel)
> +		dma_release_channel(host->dma_tx_channel);
> +	host->enable_dma = false;
> +}
> +
> +static void mmci_dma_data_end(struct mmci_host *host)
> +{
> +	struct mmc_data *data = host->data;
> +
> +	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
> +		     (data->flags & MMC_DATA_WRITE)
> +		     ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
> +}
> +
> +static void mmci_dma_data_error(struct mmci_host *host)
> +{
> +	struct mmc_data *data = host->data;
> +	struct dma_chan *chan;
> +
> +	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
> +	if (data->flags & MMC_DATA_READ)
> +		chan = host->dma_rx_channel;
> +	else
> +		chan = host->dma_tx_channel;
> +	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
> +		     (data->flags & MMC_DATA_WRITE)
> +		     ? DMA_TO_DEVICE : DMA_FROM_DEVICE);

Might as well call mmci_dma_data_end() here?

> +	chan->device->device_control(chan, DMA_TERMINATE_ALL, 0);
> +}
> +
> +static void mmci_dma_callback(void *param)
> +{
> +	struct mmci_host *host = param;
> +
> +	return;
> +}

Why an empty function?  Can't you remove the DMA_PREP_INTERRUPT if you
don't need a callback?

> +
> +/*
> + * This one gets called repeatedly to copy data using
> + * DMA until there is no more data left to copy.
> + */

Is this comment correct?  Why is this called repeatedly for a single
request?

> +static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
> +{
> +	struct variant_data *variant = host->variant;
> +	struct dma_slave_config rx_conf = {
> +		.src_addr = host->phybase + MMCIFIFO,
> +		.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
> +		.direction = DMA_FROM_DEVICE,
> +		.src_maxburst = variant->fifohalfsize >> 2,
> +	};
> +	struct dma_slave_config tx_conf = {
> +		.dst_addr = host->phybase + MMCIFIFO,
> +		.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
> +		.direction = DMA_TO_DEVICE,
> +		.dst_maxburst = variant->fifohalfsize >> 2,
> +	};
> +	struct mmc_data *data = host->data;
> +	enum dma_data_direction direction;
> +	struct dma_chan *chan;
> +	struct dma_async_tx_descriptor *desc;
> +	struct scatterlist *sg;
> +	unsigned int sglen;
> +	dma_cookie_t cookie;
> +	int i;
> +
> +	datactrl |= MCI_DPSM_DMAENABLE;
> +	datactrl |= variant->dmareg_enable;
> +
> +	if (data->flags & MMC_DATA_READ) {
> +		direction = DMA_FROM_DEVICE;
> +		chan = host->dma_rx_channel;
> +		chan->device->device_control(chan, DMA_SLAVE_CONFIG,
> +					     (unsigned long) &rx_conf);
> +	} else {
> +		direction = DMA_TO_DEVICE;
> +		chan = host->dma_tx_channel;
> +		chan->device->device_control(chan, DMA_SLAVE_CONFIG,
> +					     (unsigned long) &tx_conf);
> +	}
> +
> +	/* Check for weird stuff in the sg list */
> +	for_each_sg(data->sg, sg, data->sg_len, i) {
> +		if (sg->offset & 3 || sg->length & 3)
> +			return -EINVAL;
> +	}
> +
> +	sglen = dma_map_sg(mmc_dev(host->mmc), data->sg,
> +			   data->sg_len, direction);
> +	if (sglen != data->sg_len)
> +		goto unmap_exit;

sglen < data->sg_len is not an error condition.

> +
> +	desc = chan->device->device_prep_slave_sg(chan,
> +					data->sg, data->sg_len, direction,
> +					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	if (!desc)
> +		goto unmap_exit;
> +
> +	host->dma_desc = desc;
> +	dev_vdbg(mmc_dev(host->mmc), "Submit MMCI DMA job, sglen %d "
> +		 "blksz %04x blks %04x flags %08x\n",
> +		 sglen, data->blksz, data->blocks, data->flags);
> +	desc->callback = mmci_dma_callback;
> +	desc->callback_param = host;
> +	cookie = desc->tx_submit(desc);
> +
> +	/* Here overloaded DMA controllers may fail */
> +	if (dma_submit_error(cookie))
> +		goto unmap_exit;
> +	chan->device->device_issue_pending(chan);
> +
> +	/* Trigger the DMA transfer */
> +	writel(datactrl, host->base + MMCIDATACTRL);
> +	/*
> +	 * Let the MMCI say when the data is ended and it's time
> +	 * to fire next DMA request. When that happens, MMCI will
> +	 * call mmci_data_end()
> +	 */
> +	writel(readl(host->base + MMCIMASK0) | MCI_DATAENDMASK,
> +	       host->base + MMCIMASK0);
> +	return 0;
> +
> +unmap_exit:
> +	chan->device->device_control(chan, DMA_TERMINATE_ALL, 0);
> +	dma_unmap_sg(mmc_dev(host->mmc), data->sg, sglen, direction);
> +	return -ENOMEM;
> +}
> +#else
> +/* Blank functions if the DMA engine is not available */
> +static inline void mmci_setup_dma(struct mmci_host *host)
> +{
> +}
> +
> +static inline void mmci_disable_dma(struct mmci_host *host)
> +{
> +}
> +
> +static inline void mmci_dma_data_end(struct mmci_host *host)
> +{
> +}
> +
> +static inline void mmci_dma_data_error(struct mmci_host *host)
> +{
> +}
> +
> +static inline int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
> +{
> +	return -ENOSYS;
> +}
> +#endif
> +
>  static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
>  {
>  	struct variant_data *variant = host->variant;
> @@ -184,8 +392,6 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
>  	host->size = data->blksz * data->blocks;
>  	host->data_xfered = 0;
>  
> -	mmci_init_sg(host, data);
> -
>  	clks = (unsigned long long)data->timeout_ns * host->cclk;
>  	do_div(clks, 1000000000UL);
>  
> @@ -199,13 +405,32 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
>  	BUG_ON(1 << blksz_bits != data->blksz);
>  
>  	datactrl = MCI_DPSM_ENABLE | blksz_bits << 4;
> -	if (data->flags & MMC_DATA_READ) {
> +
> +	if (data->flags & MMC_DATA_READ)
>  		datactrl |= MCI_DPSM_DIRECTION;
> +
> +	if (host->enable_dma) {
> +		int ret;
> +
> +		/*
> +		 * Attempt to use DMA operation mode, if this
> +		 * should fail, fall back to PIO mode
> +		 */
> +		ret = mmci_dma_start_data(host, datactrl);
> +		if (!ret)
> +			return;
> +	}
> +
> +	/* IRQ mode, map the SG list for CPU reading/writing */
> +	mmci_init_sg(host, data);
> +
> +	if (data->flags & MMC_DATA_READ) {
>  		irqmask = MCI_RXFIFOHALFFULLMASK;
>  
>  		/*
> -		 * If we have less than a FIFOSIZE of bytes to transfer,
> -		 * trigger a PIO interrupt as soon as any data is available.
> +		 * If we have less than a FIFOSIZE of bytes to
> +		 * transfer, trigger a PIO interrupt as soon as any
> +		 * data is available.
>  		 */
>  		if (host->size < variant->fifosize)
>  			irqmask |= MCI_RXDATAAVLBLMASK;
> @@ -280,9 +505,12 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>  
>  		/*
>  		 * We hit an error condition.  Ensure that any data
> -		 * partially written to a page is properly coherent.
> +		 * partially written to a page is properly coherent,
> +		 * unless we're using DMA.
>  		 */
> -		if (data->flags & MMC_DATA_READ) {
> +		if (host->enable_dma)
> +			mmci_dma_data_error(host);
> +		else if (data->flags & MMC_DATA_READ) {
>  			struct sg_mapping_iter *sg_miter = &host->sg_miter;
>  			unsigned long flags;
>  
> @@ -295,6 +523,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>  		}
>  	}
>  	if (status & MCI_DATAEND) {
> +		mmci_dma_data_end(host);
>  		mmci_stop_data(host);
>  
>  		/* MCI_DATABLOCKEND not used with single irq */
> @@ -718,6 +947,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
>  		dev_dbg(mmc_dev(mmc), "eventual mclk rate: %u Hz\n",
>  			host->mclk);
>  	}
> +	host->phybase = dev->res.start;
>  	host->base = ioremap(dev->res.start, resource_size(&dev->res));
>  	if (!host->base) {
>  		ret = -ENOMEM;
> @@ -829,6 +1059,8 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
>  	    && host->gpio_cd_irq < 0)
>  		mmc->caps |= MMC_CAP_NEEDS_POLL;
>  
> +	mmci_setup_dma(host);
> +
>  	ret = request_irq(dev->irq[0], mmci_irq, IRQF_SHARED, DRIVER_NAME " (cmd)", host);
>  	if (ret)
>  		goto unmap;
> @@ -855,13 +1087,15 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
>  
>  	mmc_add_host(mmc);
>  
> -	dev_info(&dev->dev, "%s: MMCI rev %x cfg %02x at 0x%016llx irq %d,%d\n",
> -		mmc_hostname(mmc), amba_rev(dev), amba_config(dev),
> -		(unsigned long long)dev->res.start, dev->irq[0], dev->irq[1]);
> +	dev_info(&dev->dev, "%s: MMCI/PL180 manf %x rev %x cfg %02x at 0x%016llx\n",
> +		 mmc_hostname(mmc), amba_manf(dev), amba_rev(dev), amba_config(dev),
> +		 (unsigned long long)dev->res.start);
> +	dev_info(&dev->dev, "IRQ %d, %d (pio)\n", dev->irq[0], dev->irq[1]);
>  
>  	return 0;
>  
>   irq0_free:
> +	mmci_disable_dma(host);
>  	free_irq(dev->irq[0], host);
>   unmap:

Looks like the mmci_disable_dma() call should be at this label instead
of the earlier one.

>  	if (host->gpio_wp != -ENOSYS)
> @@ -903,6 +1137,7 @@ static int __devexit mmci_remove(struct amba_device *dev)
>  		writel(0, host->base + MMCICOMMAND);
>  		writel(0, host->base + MMCIDATACTRL);
>  
> +		mmci_disable_dma(host);
>  		free_irq(dev->irq[0], host);
>  		if (!variant->singleirq)
>  			free_irq(dev->irq[1], host);
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index ba203b8..a8414f7 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -142,8 +142,11 @@
>  
>  struct clk;
>  struct variant_data;
> +struct dma_chan;
> +struct dma_async_tx_descriptor;
>  
>  struct mmci_host {
> +	phys_addr_t		phybase;
>  	void __iomem		*base;
>  	struct mmc_request	*mrq;
>  	struct mmc_command	*cmd;
> @@ -173,6 +176,15 @@ struct mmci_host {
>  	/* pio stuff */
>  	struct sg_mapping_iter	sg_miter;
>  	unsigned int		size;
> +
>  	struct regulator	*vcc;
> +
> +	/* DMA stuff */
> +	bool			enable_dma;
> +#ifdef CONFIG_DMADEVICES
> +	struct dma_chan		*dma_rx_channel;
> +	struct dma_chan		*dma_tx_channel;
> +	struct dma_async_tx_descriptor *dma_desc;
> +#endif
>  };
>  
> diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
> index f4ee9ac..dbeba68 100644
> --- a/include/linux/amba/mmci.h
> +++ b/include/linux/amba/mmci.h
> @@ -6,6 +6,8 @@
>  
>  #include <linux/mmc/host.h>
>  
> +/* Just some dummy forwarding */
> +struct dma_chan;
>  /**
>   * struct mmci_platform_data - platform configuration for the MMCI
>   * (also known as PL180) block.
> @@ -27,6 +29,17 @@
>   * @cd_invert: true if the gpio_cd pin value is active low
>   * @capabilities: the capabilities of the block as implemented in
>   * this platform, signify anything MMC_CAP_* from mmc/host.h
> + * @dma_filter: function used to select an apropriate RX and TX
> + * DMA channel to be used for DMA, if and only if you're deploying the
> + * generic DMA engine
> + * @dma_rx_param: parameter passed to the DMA allocation
> + * filter in order to select an apropriate RX channel. If
> + * there is a bidirectional RX+TX channel, then just specify
> + * this and leave dma_tx_param set to NULL
> + * @dma_tx_param: parameter passed to the DMA allocation
> + * filter in order to select an apropriate TX channel. If this
> + * is NULL the driver will attempt to use the RX channel as a
> + * bidirectional channel
>   */
>  struct mmci_platform_data {
>  	unsigned int f_max;
> @@ -38,6 +51,9 @@ struct mmci_platform_data {
>  	int	gpio_cd;
>  	bool	cd_invert;
>  	unsigned long capabilities;
> +	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
> +	void *dma_rx_param;
> +	void *dma_tx_param;
>  };
>  
>  #endif
