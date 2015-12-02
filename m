From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Dec 2015 09:23:59 +0100
Subject: [RFC v02 00/15] dmaengine: New 'universal' API for requesting
 channel
In-Reply-To: <20151202045209.GB1854@localhost>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <3124382.EhiMyQGKTA@wuerfel> <20151202045209.GB1854@localhost>
Message-ID: <2174709.hFEDv974P4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 December 2015 10:22:09 Vinod Koul wrote:
> > 
> > > > This legacy mode needs changes in platform code, in dmaengine drivers and
> > > > finally the dmaengine user drivers can be converted:
> > > 
> > > Are you marking the current APIs as dericated in the end of this series
> > 
> > I think we practically stopped marking things as deprecated in general.
> > Per Linus decree, whenever we want to get rid of something, we should
> > instead change all users in tree and then remove the API, expecting
> > driver maintainers to do something just because you marked it as deprecated
> > often doesn't work.
> 
> Yes but while we do conversion we don't know if new users get added which use
> old API..

We probably don't need to worry about new users of dma_request_channel(),
as we don't add new ARM platforms without DT, and other architectures
don't add a lot of new platforms. Similarly, I don't expect a whole lot
of dma_request_slave_channel_compat() users, because the conversion from
board files to DT based booting has slowed down a lot after most of the
actively maintained platforms are done with it.

If you do a one-line patch to add dma_request_chan() as an alias for
dma_request_slave_channel_reason() now, we can probably convert most
users of dma_request_slave_channel() and dma_request_slave_channel_reason()
to dma_request_chan() in the next merge window and do a patch to
replace the few remaining ones and remove the API one merge window later.

If wewant to stage out the conversion of the
dma_request_slave_channel_compat() and dma_request_channel() similarly,
it would be good to have all the interface changes for the dmaengine
core basically in place, so we can start to convert the platforms
independently for the 4.5 merge window without having a dependency on
dmaengine patches. It's probably best to not convert a slave driver
away from dma_request_channel() until the dma map has been created
for all platforms using that driver, again to avoid having too many
dependencies.

	Arnd
