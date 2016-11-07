From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 07 Nov 2016 20:55:42 +0100
Subject: [PATCH RFC 1/7] dma: pl08x: Add support for the DMA slave map
In-Reply-To: <3d10d013-b18c-e10e-b596-d4d0f8b6e973@samsung.com>
References: <1478276094-19135-1-git-send-email-s.nawrocki@samsung.com>
 <201611050026.49560.arnd@arndb.de>
 <3d10d013-b18c-e10e-b596-d4d0f8b6e973@samsung.com>
Message-ID: <3693046.Gh6DJsekH3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 7, 2016 4:41:58 PM CET Sylwester Nawrocki wrote:
> On 11/05/2016 12:26 AM, Arnd Bergmann wrote:

> 
>  static const struct dma_slave_map s3c64xx_dma1_slave_map[] = {
> -       { "samsung-pcm.1", "tx", (void *)"pcm1_tx" },
> -       { "samsung-pcm.1", "rx", (void *)"pcm1_rx" },
> -       { "samsung-i2s.1", "tx", (void *)"i2s1_tx" },
> -       { "samsung-i2s.1", "rx", (void *)"i2s1_rx" },
> -       { "s3c6410-spi.1", "tx", (void *)"spi1_tx" },
> -       { "s3c6410-spi.1", "rx", (void *)"spi1_rx" },
> +       { "samsung-pcm.1", "tx", (void *)&s3c64xx_dma1_info[0] },
> +       { "samsung-pcm.1", "rx", (void *)&s3c64xx_dma1_info[1] },
> +       { "samsung-i2s.1", "tx", (void *)&s3c64xx_dma1_info[2] },
> +       { "samsung-i2s.1", "rx", (void *)&s3c64xx_dma1_info[3] },
> +       { "s3c6410-spi.1", "tx", (void *)&s3c64xx_dma1_info[4] },
> +       { "s3c6410-spi.1", "rx", (void *)&s3c64xx_dma1_info[5] },
>  };
> 

I think you can drop the (void*) cast either way (before and after
this change).

> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index d5c75c8..0d1eb2e 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -1793,6 +1793,23 @@ bool pl08x_filter_id(struct dma_chan *chan, void *chan_id)
>  }
>  EXPORT_SYMBOL_GPL(pl08x_filter_id);
> 
> +static bool pl08x_filter_fn(struct dma_chan *chan, void *chan_id)
> +{
> +       struct pl08x_dma_chan *plchan;
> +
> +       /* Reject channels for devices not bound to this driver */
> +       if (chan->device->dev->driver != &pl08x_amba_driver.drv)
> +               return false;

This check should not be needed, you only get channels for the
device itself.

> +       plchan = to_pl08x_chan(chan);
> +
> +       /* Check that the channel is not taken! */
> +       if (plchan->cd == chan_id)
> +               return true;


What I had in mind was a bit different: Instead of comparing the
channel, I was thinking of modifying the channel itself, something
like:

	plchan->signal = chan_id->signal;
	plchan->periph_buses = chan_id->periph_buses;

after that, remove the plchan->cd data. Unfortunately, the muxing in
arch/arm/mach-spear/ makes this a bit harder. I'd have to think
about it some more. It may be easier to do this after moving
spear and lpc32xx over to use dma_slave_map.

	Arnd
