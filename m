From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 22 Dec 2012 21:24:57 +0000
Subject: LPC32xx and MMCI driver
In-Reply-To: <50D2E317.6000005@precidata.com>
References: <50D2E156.20707@precidata.com> <50D2E317.6000005@precidata.com>
Message-ID: <20121222212457.GJ14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 11:06:15AM +0100, Gabriele Mondada wrote:
> @@ -385,6 +385,7 @@ static void pl08x_start_next_txd(struct  
> pl08x_dma_chan *plchan)
>      while ((val & PL080_CONFIG_ACTIVE) || (val & PL080_CONFIG_ENABLE))
>          val = readl(phychan->base + PL080_CH_CONFIG);
>
> +    /* TODO: why val and not txd->ccfg ? */
>      writel(val | PL080_CONFIG_ENABLE, phychan->base + PL080_CH_CONFIG);

We've written txd->ccfg to the register.  We've read the register back
into val, waiting for bits to change.  Should we write back the latest
value we've read back from the register or the old one?

> +#ifdef CONFIG_ARCH_LPC32XX
> +/*
> + * This exported function is used by mmci driver to workaround a bug in the
> + * LPC32xx CPU.
> + */
> +void pl08x_force_dma_burst(struct dma_chan *chan)
> +{
> +    struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
> +    struct pl08x_driver_data *pl08x = plchan->host;
> +
> +    dev_dbg(&pl08x->adev->dev,
> +        "force burst signal=%d chan=%p plchan=%p\n",
> +        plchan->signal, chan, plchan);
> +    if (plchan->signal >= 0)
> +        writel(1 << plchan->signal, pl08x->base + PL080_SOFT_BREQ);
> +}
> +
> +EXPORT_SYMBOL_GPL(pl08x_force_dma_burst);

Eww.  This is really horrid and totally breaks software layering.

As for formatting in the patch, that's also horrid.  Extra tab
indentations, lines over 80 characters, and a hell of a lot of code
to fix this brokenness.

At least the first thing that needs to happen is to clean the patch up
so that it passes checkpatch.pl.
