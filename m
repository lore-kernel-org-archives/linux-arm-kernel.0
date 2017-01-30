From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jan 2017 15:04:28 +0000
Subject: [PATCH 06/10] soc/qbman: Add ARM equivalent for
 flush_dcache_range()
In-Reply-To: <5414359.8GMja3pNrI@wuerfel>
References: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
 <VI1PR0401MB2430DA6BD2F857C30EC86A50917F0@VI1PR0401MB2430.eurprd04.prod.outlook.com>
 <HE1PR0401MB263638F320470CA216990BCC86720@HE1PR0401MB2636.eurprd04.prod.outlook.com>
 <5414359.8GMja3pNrI@wuerfel>
Message-ID: <20170130150428.GY27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 10:20:09PM +0100, Arnd Bergmann wrote:
> On Monday, January 23, 2017 7:24:59 PM CET Roy Pledge wrote:
> > > Is there a non-"under the covers" way to say "flush this region" without
> > > the arch second-guessing whether it really needs to be flushed?
> > Any advice on how to resolve this? I looked into trying to do a
> > non-cacheable mapping of the
> > memory so that the flush wouldn't be required but the ioremap code
> > prevents mapping normal
> > memory in this way.  The QMan device requiresthis memory to be zeroed at
> > startup. Because the device
> > does non coherent reads and writes to the memory we must ensure that any
> > cache in the CPU cluster(s)
> > is flushed in order to prevent a future castout from overwriting data.
> > This happened before on PPC
> > platforms and made for some very unfun debug session trying to
> > understand what was causing the failure.
> 
> If this is normal RAM, you should be able to just write zeroes, and then
> do a dma_map_single() for initialization. Are there any other requirements
> what to do with the memory later, is it used for communication at all,
> or just required to be zero?

Please don't encourage incorrect DMA API usage.

dma_map_single() must always be paired with an unmap at some point,
otherwise it's a memory leak if DMA API debugging is enabled.  So,
if you wish to suggest using dma_map_single(), please also suggest
where to use dma_unmap_single() too.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
