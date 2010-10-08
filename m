From: dan.j.williams@intel.com (Dan Williams)
Date: Thu, 7 Oct 2010 17:14:59 -0700
Subject: [PATCH 3/4] dmaengine: Add Freescale i.MX SDMA support
In-Reply-To: <1285854995-6569-4-git-send-email-s.hauer@pengutronix.de>
References: <1285854995-6569-1-git-send-email-s.hauer@pengutronix.de>
	<1285854995-6569-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <AANLkTi=YY_bZ0mFy6dA18-mifM52H7wNJVHqgvfxR6zc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 30, 2010 at 6:56 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> This patch adds support for the Freescale i.MX SDMA engine.
>

Applied, this set, however...

> +static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
> + ? ? ? ? ? ? ? struct dma_chan *chan, struct scatterlist *sgl,
> + ? ? ? ? ? ? ? unsigned int sg_len, enum dma_data_direction direction,
> + ? ? ? ? ? ? ? unsigned long flags)
> +{
> + ? ? ? struct sdma_channel *sdmac = to_sdma_chan(chan);
> + ? ? ? struct sdma_engine *sdma = sdmac->sdma;
> + ? ? ? int ret, i, count;
> + ? ? ? int channel = chan->chan_id;
> + ? ? ? struct scatterlist *sg;
> +
> + ? ? ? if (sdmac->status == DMA_IN_PROGRESS)
> + ? ? ? ? ? ? ? return NULL;
> + ? ? ? sdmac->status = DMA_IN_PROGRESS;

...shouldn't this be an atomic test and set operation to ensure a
single user at a time?

--
Dan
