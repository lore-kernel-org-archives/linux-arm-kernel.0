From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 11 Oct 2010 13:07:58 +0200
Subject: [PATCH 4/6] mmc: sdhci_pltfm: pass more data on custom init-call
In-Reply-To: <20100930094202.GA581@oksana.dev.rtsoft.ru>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
	<1285790884-3516-5-git-send-email-w.sang@pengutronix.de>
	<19620.19198.88841.623775@ipc1.ka-ro>
	<20100930094202.GA581@oksana.dev.rtsoft.ru>
Message-ID: <20101011110758.GE6028@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 30, 2010 at 01:42:02PM +0400, Anton Vorontsov wrote:
> On Thu, Sep 30, 2010 at 10:31:58AM +0200, Lothar Wa?mann wrote:
> > > The custom init call may need more data to perform its job, so we pass
> > > it a pointer to pdata, too. Also, always use the platform_id specific
> > > data even if platform_data is present. Doing that, platform_data can
> > > additionally be parsed by init() for board-specific information (via
> > > sdhci->mmc->parent).
> > > 
> > Why not a pointer to the platform_device itself? Then the callback
> > function would have even more information (e.g. platform_device ID)
> > and could easily get at the platform_data too.
> 
> dev->platform_data may not be there. There are two ways to pass
> the "platform data" to the sdhci-pltfm driver:
> 
> a) via dev->platform_data
> b) via platform_device_id->driver_data

or c) both :)

which is the reason for the current implementation.
platform_device_id->driver_data may still need additional information
from the board (e.g. a write protect pin from board pcm043) while the
larger part of the driver_data-extensions are still generic (e.g. to
imx-esdhc).

> 
> Technically, we can do something like this in the probe():
> 
> if (!pdev->dev.platform_data)
> 	pdev->dev.platform_data = platform_device_id->driver_data;
> 
> pdata->init(dev);
> 
> Note, in this case we must also NULLify platform_data it at remove(),
> as platform_device_release() will try to free statically allocated
> memory.
> 
> Thanks,
> 
> -- 
> Anton Vorontsov
> email: cbouatmailru at gmail.com
> irc://irc.freenode.net/bd2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101011/f3816841/attachment.sig>
