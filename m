From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 10 Aug 2010 00:45:17 +0200
Subject: [PATCH 1/8] ARM i.MX dma: implement wrapper for dma functions
In-Reply-To: <1281344743-2029-2-git-send-email-s.hauer@pengutronix.de>
References: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
	<1281344743-2029-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <AANLkTimtQrmrW-pNWX=0J9GMsGrS-5-LZKkxdHDSuSxW@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/9 Sascha Hauer <s.hauer@pengutronix.de>:

> Currently there is only one i.MX DMA implementation in the tree,
> the one for i.MX1/21/27. The SDMA support for i.MX25/31/35/51 can
> be implemented similarly. This wrapper for the DMA is implemented
> so that drivers do not have to care about the implementation
> present and don't have to #ifdef DMA support
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> (...)
> +struct imx_dma_operations {
> + ? ? ? int (*config_channel)(int channel, struct imx_dma_config *cfg);
> + ? ? ? int (*setup_single)(int channel, dma_addr_t mem, int dma_length,
> + ? ? ? ? ? ? ? unsigned int dmamode);
> + ? ? ? int (*setup_sg)(int channel, struct scatterlist *sg,
> + ? ? ? ? ? ? ? ? ? ? ? unsigned int sgcount, unsigned int dma_length,
> + ? ? ? ? ? ? ? ? ? ? ? unsigned int dmamode);
> + ? ? ? void (*enable)(int channel);
> + ? ? ? void (*disable)(int channel);
> + ? ? ? int (*request)(enum imx_dma_prio);
> + ? ? ? void (*free)(int channel);
> + ? ? ? int num_channels;
> +};

This is just getting *so* close to the drivers/dma dmaengine API.

We decided to use the damengine for all our DMA drivers and we
haven't regretted one bit.

There has been some noise about too many drivers stacking up
below arch/arm instead of going to the apropriate subsystem, can't
you atleast contemplate using the dmaengine and help us improve
that subsystem?

I sent some patches to Dan which essentially is a single-buffer
(non-sglist) API, which is all I see missing to fit this need.

Yours,
Linus Walleij
