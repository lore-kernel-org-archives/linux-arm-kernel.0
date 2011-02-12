From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 12 Feb 2011 22:04:19 +0800
Subject: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
In-Reply-To: <201102112104.23643.arnd@arndb.de>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
	<201102111651.35530.arnd@arndb.de>
	<20110212005506.GE9289@S2100-06.ap.freescale.net>
	<201102112104.23643.arnd@arndb.de>
Message-ID: <20110212140417.GA9821@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11, 2011 at 09:04:23PM +0100, Arnd Bergmann wrote:
> On Saturday 12 February 2011 01:55:07 Shawn Guo wrote:
> > On Fri, Feb 11, 2011 at 04:51:35PM +0100, Arnd Bergmann wrote:
> > > I have not looked much at other dmaengine drivers, but I'd be
> > > surprised if they require the device driver to be written
> > > for a specific implementation. If that was the case, you would
> > > not even need a dmaengine API but could just as well write
> > > to the DMA controller registers from the device driver directly.
> > > 
> > We need a specific implementation, but it's not so specific that we
> > have to access dma controller directly.  Even it is, we still need
> > an API/interface, as there are so many client devices need to do the
> > same thing, right? ;)
> 
> I looked at all mmc drivers that use the dmaengine API: 
> atmel-mci.c does the same as what you propose here, while sh_mmcif.c

Actually, it's not me who propose the implementation.  Sascha sent a
patch (under review) to change mxcmmc.c to use generic damengine api
several weeks ago.  I followed that as the example.

> and tmio_mmc.c more or less do what I'm suggesting you do instead.
> 
> Looking at sh_mmcif:
> 
>       host->chan_tx = dma_request_channel(mask, sh_mmcif_filter,
>                                           &pdata->dma->chan_priv_tx);
> 
> 
> This is the only place where dma engine specific data is used
> in the driver, and chan_priv_tx is part of the platform data, so the
> mmc driver can simply pass it down as a void pointer without knowing
> the type. The platform data as defined in the machine file ties
> both the dma controller and the mmc device together, but neither
> of the two drivers needs to know anything about the implementation
> of the other.
> 
Not really.  Though mmc does not need to know anything about dma
driver, dma knows that mmc driver has to pass .slave_id via
chan->private.  The snippet below is copied from shdma.

	struct sh_dmae_slave_config {
		unsigned int                    slave_id;
		dma_addr_t                      addr;
		u32                             chcr;
		char                            mid_rid;
	};
---
        if (chan->private) {
                /* The caller is holding dma_list_mutex */
                struct sh_dmae_slave *param = chan->private;
                clear_bit(param->slave_id, sh_dmae_slave_used);
        }

And it only works when slave_id is the first member of
sh_dmae_slave_config.

For me, it's more natural to define device's dma related things like
dma channel id and irq as its resources than platform data.  So I
still maintain the current approach.

Regards,
Shawn
