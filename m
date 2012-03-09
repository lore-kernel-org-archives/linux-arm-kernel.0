From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 9 Mar 2012 11:19:11 +0800
Subject: [PATCH v3 10/11] ASoC: fsl: let fsl_ssi work with imx pcm and
 machine drivers
In-Reply-To: <4F591A69.9060401@freescale.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-11-git-send-email-shawn.guo@linaro.org>
 <4F591A69.9060401@freescale.com>
Message-ID: <20120309031909.GJ2499@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2012 at 02:45:29PM -0600, Timur Tabi wrote:
> Shawn Guo wrote:
> 
> > +	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx1-ssi")) {
> 
> I wonder if the i.MX code should be protected by an #ifdef.  There's no
> point in compiling this code on PowerPC.
> 
I'm not really fond of #ifdef.  The i.MX code is not that much after
all.

> > +		/*
> > +		 * FIXME: The dma burst size must equal to ssi watermark
> > +		 * setting on imx.  We have burstsize be "fifo_depth - 2"
> > +		 * here because "fifo_depth - 2" rather than fifo_depth is
> > +		 * being written into watermark register in fsl_ssi_startup().
> > +		 * Is this something needs to be fixed for PowerPC?
> 
> Setting the watermark to fifo_depth-2 allows the SSI to continue storing
> data into the FIFO (during capture) in the case the DMA engine isn't fast
> enough.  I don't want the FIFO to be completely full before we start the DMA.
> 
> For playback, it's the same thing.  I can't be sure the FIFO is completely
> empty when it's time to DMA more data.
> 
Ok, got you.  We used to set fifo_depth on imx-ssi not the value given
by hardware manual, but the one already tuned.

So all we need is to encode the hardware value in device tree property
"fsl,fifo-depth", and it just works.  I will remove this "FIXME". 

> > +		 */
> > +		ssi_private->dma_params_tx.burstsize =
> > +			ssi_private->fifo_depth - 2;
> > +		ssi_private->dma_params_rx.burstsize =
> > +			ssi_private->fifo_depth - 2;
> > +		ssi_private->dma_params_tx.dma_addr =
> > +			ssi_private->ssi_phys + offsetof(struct ccsr_ssi, stx0);
> > +		ssi_private->dma_params_rx.dma_addr =
> > +			ssi_private->ssi_phys + offsetof(struct ccsr_ssi, srx0);
> 
> So I'm a little confused by this new binding.  I went through a lot of
> work to remove DMA-specific data from the SSI driver, and here you are
> adding a bunch of it back.  What you're doing here -- I'm doing it in the
> DMA driver where it belongs.

I'm not sure these all belong to DMA driver.  These are all
configurations/parameters of SSI, which are related to DMA though.
I see fsl_dma are handling these, but I do not fully agree with that,
because we end up with fsl_dma driver accessing SSI node and
"struct ccsr_ssi" which should be SSI private data.

Secondly, this is the way that how imx-ssi and imx-pcm-dma works and
interacts.  If we want to move these stuff into imx-pcm-dma, we need
a good story to convince imx-ssi users that why it's better than what
they currently do.

> 
> > +		/*
> > +		 * TODO: This is a temporary solution and should be changed
> > +		 * to use generic DMA binding later when the helplers get in.
> > +		 */
> > +		ret = of_property_read_u32_array(pdev->dev.of_node,
> > +					"fsl,ssi-dma-events", dma_events, 2);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "could not get dma events\n");
> > +			goto error_irq;
> > +		}
> > +		ssi_private->dma_params_tx.dma = dma_events[0];
> > +		ssi_private->dma_params_rx.dma = dma_events[1];
> 
> of_property_read_u32_array seems overkill for just two integers.
> 
Hmm, I do not think so.

Device tree maintainers created helpers of_property_read_u32 and
of_property_read_u32_array to ease the user and make the operation
less error prone.  Looking at the of_property_read_u32 implementation,
it's even calling into of_property_read_u32_array.  So I do not think
it's overkill for reading two integers in any way.

static inline int of_property_read_u32(const struct device_node *np,
                                       const char *propname,
                                       u32 *out_value)
{
        return of_property_read_u32_array(np, propname, out_value, 1);
}

> ssi_private->dma_params_tx.dma = be32_to_cpu(prop[0]);
> ssi_private->dma_params_rx.dma = be32_to_cpu(prop[1]);
> 

-- 
Regards,
Shawn
