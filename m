From: gabriele@precidata.com (Gabriele Mondada)
Date: Wed, 23 Jan 2013 11:32:10 +0100
Subject: LPC32xx and MMCI driver
In-Reply-To: <20121222212457.GJ14363@n2100.arm.linux.org.uk>
References: <50D2E156.20707@precidata.com> <50D2E317.6000005@precidata.com>
 <20121222212457.GJ14363@n2100.arm.linux.org.uk>
Message-ID: <4B116C76-1D65-437C-8C38-B08702706FA2@precidata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
>> +#ifdef CONFIG_ARCH_LPC32XX
>> +/*
>> + * This exported function is used by mmci driver to workaround a bug in the
>> + * LPC32xx CPU.
>> + */
>> +void pl08x_force_dma_burst(struct dma_chan *chan)
>> +{
>> +    struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
>> +    struct pl08x_driver_data *pl08x = plchan->host;
>> +
>> +    dev_dbg(&pl08x->adev->dev,
>> +        "force burst signal=%d chan=%p plchan=%p\n",
>> +        plchan->signal, chan, plchan);
>> +    if (plchan->signal >= 0)
>> +        writel(1 << plchan->signal, pl08x->base + PL080_SOFT_BREQ);
>> +}
>> +
>> +EXPORT_SYMBOL_GPL(pl08x_force_dma_burst);
> 
> Eww.  This is really horrid and totally breaks software layering.

Yes, it is.
There is a silicon bug that prevents the DMA controller to receive the last DMA request. So, I have to generate the last transfer by software.
How can I do that without breaking software layers? Do I add a new entry point in the dmaengine device?

> As for formatting in the patch, that's also horrid.  Extra tab
> indentations, lines over 80 characters, and a hell of a lot of code
> to fix this brokenness.
> 
> At least the first thing that needs to happen is to clean the patch up
> so that it passes checkpatch.pl.

I cleaned up the patch and posted again on the list. See [PATCH] Implements DMA on mmci driver for LPC3250 plateform
