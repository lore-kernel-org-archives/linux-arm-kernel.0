From: vkoul@kernel.org (Vinod)
Date: Wed, 11 Jul 2018 12:42:06 +0530
Subject: [PATCH v1 1/4] dmaengine: imx-sdma: add memcpy interface
In-Reply-To: <DB6PR04MB32234F1EE6F457E0D8D12385895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-2-git-send-email-yibin.gong@nxp.com>
 <20180710152912.GE3219@vkoul-mobl>
 <DB6PR04MB32234F1EE6F457E0D8D12385895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
Message-ID: <20180711071206.GM3219@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-07-18, 05:34, Robin Gong wrote:
> > On 11-07-18, 00:23, Robin Gong wrote:
> > > Add MEMCPY support, meanwhile, add SDMA_BD_MAX_CNT instead of
> > > '0xffff'.
> > 
> > latter part should be its own patch. Never mix things
> Okay, I will split it even for this minor change.

Yes, a patch should represent _one_ thing, describe that one thing and
do that one thing.

Anything else, doesn't matter how simple or complex should be an
individual patch

> > > +	if (!desc)
> > > +		goto err_out;
> > > +
> > > +	do {
> > > +		count = min_t(size_t, len, SDMA_BD_MAX_CNT);
> > > +		bd = &desc->bd[i];
> > > +		bd->buffer_addr = dma_src;
> > > +		bd->ext_buffer_addr = dma_dst;
> > > +		bd->mode.count = count;
> > > +		desc->chn_count += count;
> > > +
> > > +		switch (sdmac->word_size) {
> > > +		case DMA_SLAVE_BUSWIDTH_4_BYTES:
> > 
> > This looks wrong, we are in memcpy, there is no SLAVE so no SLAVE widths..
> > 
> Okay, will remove check bus width.

it is not about bus_width but the fact that you are using slave
concepts. In memcpy we have _no_ slave, hence do not use anything
related to slave including dma_slave_config

-- 
~Vinod
