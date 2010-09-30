From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 30 Sep 2010 13:42:02 +0400
Subject: [PATCH 4/6] mmc: sdhci_pltfm: pass more data on custom init-call
In-Reply-To: <19620.19198.88841.623775@ipc1.ka-ro>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
	<1285790884-3516-5-git-send-email-w.sang@pengutronix.de>
	<19620.19198.88841.623775@ipc1.ka-ro>
Message-ID: <20100930094202.GA581@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 30, 2010 at 10:31:58AM +0200, Lothar Wa?mann wrote:
> > The custom init call may need more data to perform its job, so we pass
> > it a pointer to pdata, too. Also, always use the platform_id specific
> > data even if platform_data is present. Doing that, platform_data can
> > additionally be parsed by init() for board-specific information (via
> > sdhci->mmc->parent).
> > 
> Why not a pointer to the platform_device itself? Then the callback
> function would have even more information (e.g. platform_device ID)
> and could easily get at the platform_data too.

dev->platform_data may not be there. There are two ways to pass
the "platform data" to the sdhci-pltfm driver:

a) via dev->platform_data
b) via platform_device_id->driver_data

Technically, we can do something like this in the probe():

if (!pdev->dev.platform_data)
	pdev->dev.platform_data = platform_device_id->driver_data;

pdata->init(dev);

Note, in this case we must also NULLify platform_data it at remove(),
as platform_device_release() will try to free statically allocated
memory.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
