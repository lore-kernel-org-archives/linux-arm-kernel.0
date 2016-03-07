From: plaes@plaes.org (Priit Laes)
Date: Mon, 07 Mar 2016 17:30:41 +0200
Subject: [linux-sunxi] [PATCH] dma: sun4i: expose block size and wait
 cycle configuration to DMA users
In-Reply-To: <1457344771-12946-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457344771-12946-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457364641.20836.5.camel@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-03-07 at 10:59 +0100, Boris Brezillon wrote:
> Some drivers might need to tweak the block size and wait cycles
> values
> to get better performances.
> Create and export the sun4i_dma_set_chan_config() to do that.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/dma/sun4i-dma.c       | 44 ++++++++++++++++++++++++++++++---
> ----------
>  include/linux/dma/sun4i-dma.h | 38
> +++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+), 13 deletions(-)
>  create mode 100644 include/linux/dma/sun4i-dma.h
> 
> diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
> index 1661d518..e48f537 100644
> --- a/drivers/dma/sun4i-dma.c
> +++ b/drivers/dma/sun4i-dma.c
> @@ -12,6 +12,7 @@
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
>  #include <linux/dmaengine.h>
> +#include <linux/dma/sun4i-dma.h>
>  #include <linux/dmapool.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> @@ -138,6 +139,7 @@ struct sun4i_dma_pchan {
>  struct sun4i_dma_vchan {
>  	struct virt_dma_chan		vc;
>  	struct dma_slave_config		cfg;
> +	struct sun4i_dma_chan_config	scfg;
>  	struct sun4i_dma_pchan		*pchan;
>  	struct sun4i_dma_promise	*processing;
>  	struct sun4i_dma_contract	*contract;
> @@ -779,7 +781,7 @@ sun4i_dma_prep_slave_sg(struct dma_chan *chan,
> struct scatterlist *sgl,
>  	u8 ram_type, io_mode, linear_mode;
>  	struct scatterlist *sg;
>  	dma_addr_t srcaddr, dstaddr;
> -	u32 endpoints, para;
> +	u32 endpoints;
>  	int i;
>  
>  	if (!sgl)
> @@ -825,17 +827,6 @@ sun4i_dma_prep_slave_sg(struct dma_chan *chan,
> struct scatterlist *sgl,
>  			dstaddr = sg_dma_address(sg);
>  		}
>  
> -		/*
> -		 * These are the magic DMA engine timings that keep
> SPI going.
> -		 * I haven't seen any interface on DMAEngine to
> configure
> -		 * timings, and so far they seem to work for
> everything we
> -		 * support, so I've kept them here. I don't know if
> other
> -		 * devices need different timings because, as usual,
> we only
> -		 * have the "para" bitfield meanings, but no comment
> on what
> -		 * the values should be when doing a certain
> operation :|
> -		 */
> -		para = SUN4I_DDMA_MAGIC_SPI_PARAMETERS;
> -
>  		/* And make a suitable promise */
>  		if (vchan->is_dedicated)
>  			promise = generate_ddma_promise(chan,
> srcaddr, dstaddr,
> @@ -850,7 +841,7 @@ sun4i_dma_prep_slave_sg(struct dma_chan *chan,
> struct scatterlist *sgl,
>  			return NULL; /* TODO: should we free
> everything? */
>  
>  		promise->cfg |= endpoints;
> -		promise->para = para;
> +		promise->para = vchan->scfg.para;
>  
>  		/* Then add it to the contract */
>  		list_add_tail(&promise->list, &contract->demands);
> @@ -908,6 +899,21 @@ static int sun4i_dma_config(struct dma_chan
> *chan,
>  	return 0;
>  }
>  
> +int sun4i_dma_set_chan_config(struct dma_chan *dchan,
> +			      const struct sun4i_dma_chan_config
> *cfg)
> +{
> +	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(dchan);
> +
> +	if (!vchan->is_dedicated)
> +		return -ENOTSUPP;
> +
> +	/* TODO: control cfg value */
> +	vchan->scfg = *cfg;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(sun4i_dma_set_chan_config);
> +
>  static struct dma_chan *sun4i_dma_of_xlate(struct of_phandle_args
> *dma_spec,
>  					   struct of_dma *ofdma)
>  {
> @@ -1206,6 +1212,18 @@ static int sun4i_dma_probe(struct
> platform_device *pdev)
>  		spin_lock_init(&vchan->vc.lock);
>  		vchan->vc.desc_free = sun4i_dma_free_contract;
>  		vchan_init(&vchan->vc, &priv->slave);
> +
> +		/*
> +		 * These are the magic DMA engine timings that keep
> SPI going.
> +		 * I haven't seen any interface on DMAEngine to
> configure
> +		 * timings, and so far they seem to work for
> everything we
> +		 * support, so I've kept them here. I don't know if
> other
> +		 * devices need different timings because, as usual,
> we only
> +		 * have the "para" bitfield meanings, but no comment
> on what
> +		 * the values should be when doing a certain
> operation :|
> +		 */
> +		vchan->scfg.para = SUN4I_DDMA_MAGIC_SPI_PARAMETERS;

Does SPI refer the Serial Peripheral Interface?

If yes, then I would point out that current sun4i SPI driver doesn't
actually use DMA [1]

http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/411
722.html


> +
>  	}
>  
>  	ret = clk_prepare_enable(priv->clk);
> diff --git a/include/linux/dma/sun4i-dma.h b/include/linux/dma/sun4i
> -dma.h
> new file mode 100644
> index 0000000..f643539
> --- /dev/null
> +++ b/include/linux/dma/sun4i-dma.h
> @@ -0,0 +1,38 @@
> +/*
> + * Sun4i DMA Engine drivers support header file
> + *
> + * Copyright (C) 2016 Free Electrons. All rights reserved.
> + *
> + * This is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published
> by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef _SUN4I_DMA_H
> +#define _SUN4I_DMA_H
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +
> +/* Dedicated DMA parameter register layout */
> +#define SUN4I_DDMA_PARA_DST_DATA_BLK_SIZE(n)	(((n) - 1) <<
> 24)
> +#define SUN4I_DDMA_PARA_DST_WAIT_CYCLES(n)	(((n) - 1) << 16)
> +#define SUN4I_DDMA_PARA_SRC_DATA_BLK_SIZE(n)	(((n) - 1) << 8)
> +#define SUN4I_DDMA_PARA_SRC_WAIT_CYCLES(n)	(((n) - 1) << 0)
> +
> +/**
> + * struct sun4i_dma_chan_config - DMA channel config
> + *
> + * @para: contains information about block size and time before
> checking
> + *	  DRQ line. This is device specific and only applicable to
> dedicated
> + *	  DMA channels
> + */
> +struct sun4i_dma_chan_config {
> +	u32 para;
> +};
> +
> +int sun4i_dma_set_chan_config(struct dma_chan *dchan,
> +			      const struct sun4i_dma_chan_config
> *cfg);
> +
> +#endif /* _SUN4I_DMA_H */
> -- 
> 2.1.4
> 
