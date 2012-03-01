From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 1 Mar 2012 19:18:46 +0100
Subject: [PATCH v2 2/2] dmaengine: Add support for multiple descriptors
 for imx-dma.
In-Reply-To: <CACKLOr2bFgSUW+oXgFReHt6ZS+t7atMJ6nzDgF4-e9cRyOYX4w@mail.gmail.com>
References: <1330445298-3522-1-git-send-email-javier.martin@vista-silicon.com>
 <1330445298-3522-3-git-send-email-javier.martin@vista-silicon.com>
 <20120301101904.GA3852@pengutronix.de>
 <CACKLOr2bFgSUW+oXgFReHt6ZS+t7atMJ6nzDgF4-e9cRyOYX4w@mail.gmail.com>
Message-ID: <20120301181846.GB3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2012 at 11:28:18AM +0100, javier Martin wrote:
> Hi Sascha,
> 
> On 1 March 2012 11:19, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Tue, Feb 28, 2012 at 05:08:18PM +0100, Javier Martin wrote:
> >> dmaengine specifies the possibility that several descriptors
> >> can be queued for transfer. It also indicates that tasklets
> >> must be used for DMA callbacks.
> >>
> >> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> >
> > Have you tested this patch with audio?
> 
> Yes,
> I have a test battery which tests audio, mmc, runs dmatest module and
> a custom mem2mem video device I'm developing.

Cool.

> 
> >
> >> +static int imxdma_xfer_desc(struct imxdma_desc *d)
> >> +{
> >> + ? ? struct imxdma_channel *imxdmac = to_imxdma_chan(d->desc.chan);
> >> + ? ? int ret;
> >> +
> >> + ? ? /* Configure and enable */
> >> + ? ? switch (d->type) {
> >> + ? ? case IMXDMA_DESC_MEMCPY:
> >> + ? ? ? ? ? ? ret = imx_dma_config_channel(imxdmac->imxdma_channel,
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? d->config_port, d->config_mem, 0, 0);
> >> + ? ? ? ? ? ? if (ret < 0)
> >> + ? ? ? ? ? ? ? ? ? ? return ret;
> >> + ? ? ? ? ? ? ret = imx_dma_setup_single(imxdmac->imxdma_channel, d->src,
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?d->len, d->dest, d->dmamode);
> >> + ? ? ? ? ? ? if (ret < 0)
> >> + ? ? ? ? ? ? ? ? ? ? return ret;
> >> + ? ? ? ? ? ? break;
> >> + ? ? case IMXDMA_DESC_CYCLIC:
> >> + ? ? ? ? ? ? ret = imx_dma_setup_progression_handler(imxdmac->imxdma_channel,
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? imxdma_progression);
> >> + ? ? ? ? ? ? if (ret < 0)
> >> + ? ? ? ? ? ? ? ? ? ? return ret;
> >
> > You fall through here. Is this intended? If yes, a comment would be good
> > here.
> 
> Yes it is. cyclic is the same as slave_sg with the add-on of the
> progression handler and a specific configuration of the sglist which
> is done in 'imxdma_prep_dma_cyclic'.
> Do you want me to send a new version with a comment on the matter?

Yes, it's better to have a comment there. People looking at this code
will ask themselves the same question otherwise.

With this you can add my:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
