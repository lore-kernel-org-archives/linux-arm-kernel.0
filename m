From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Aug 2010 14:34:26 +0200
Subject: [PATCH 1/8] ARM i.MX dma: implement wrapper for dma functions
In-Reply-To: <AANLkTimtQrmrW-pNWX=0J9GMsGrS-5-LZKkxdHDSuSxW@mail.gmail.com>
References: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
	<1281344743-2029-2-git-send-email-s.hauer@pengutronix.de>
	<AANLkTimtQrmrW-pNWX=0J9GMsGrS-5-LZKkxdHDSuSxW@mail.gmail.com>
Message-ID: <20100810123426.GH27749@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, Aug 10, 2010 at 12:45:17AM +0200, Linus Walleij wrote:
> 2010/8/9 Sascha Hauer <s.hauer@pengutronix.de>:
> 
> > Currently there is only one i.MX DMA implementation in the tree,
> > the one for i.MX1/21/27. The SDMA support for i.MX25/31/35/51 can
> > be implemented similarly. This wrapper for the DMA is implemented
> > so that drivers do not have to care about the implementation
> > present and don't have to #ifdef DMA support
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > (...)
> > +struct imx_dma_operations {
> > + ? ? ? int (*config_channel)(int channel, struct imx_dma_config *cfg);
> > + ? ? ? int (*setup_single)(int channel, dma_addr_t mem, int dma_length,
> > + ? ? ? ? ? ? ? unsigned int dmamode);
> > + ? ? ? int (*setup_sg)(int channel, struct scatterlist *sg,
> > + ? ? ? ? ? ? ? ? ? ? ? unsigned int sgcount, unsigned int dma_length,
> > + ? ? ? ? ? ? ? ? ? ? ? unsigned int dmamode);
> > + ? ? ? void (*enable)(int channel);
> > + ? ? ? void (*disable)(int channel);
> > + ? ? ? int (*request)(enum imx_dma_prio);
> > + ? ? ? void (*free)(int channel);
> > + ? ? ? int num_channels;
> > +};
> 
> This is just getting *so* close to the drivers/dma dmaengine API.

I was afraid somewone would say this ;)

> 
> We decided to use the damengine for all our DMA drivers and we
> haven't regretted one bit.
> 
> There has been some noise about too many drivers stacking up
> below arch/arm instead of going to the apropriate subsystem, can't
> you atleast contemplate using the dmaengine and help us improve
> that subsystem?

The last time I looked into dmaengine I failed to see how this API
could help me. Looking at it again it seems that this is the way
to go. I will definitely have a closer look. I can't promise though that
this will be before the next merge window. The SDMA engine on the other
hand is of great value for the i.MX community, so if anyone is willing
to help here, please step forward.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
