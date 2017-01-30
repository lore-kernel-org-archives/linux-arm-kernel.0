From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jan 2017 15:12:20 +0000
Subject: [PATCH 06/10] soc/qbman: Add ARM equivalent for
 flush_dcache_range()
In-Reply-To: <VI1PR0401MB2430DA6BD2F857C30EC86A50917F0@VI1PR0401MB2430.eurprd04.prod.outlook.com>
References: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
 <1484779180-1344-7-git-send-email-roy.pledge@nxp.com>
 <20170118231206.GT27312@n2100.armlinux.org.uk>
 <VI1PR0401MB2430DA6BD2F857C30EC86A50917F0@VI1PR0401MB2430.eurprd04.prod.outlook.com>
Message-ID: <20170130151220.GZ27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 11:36:18PM +0000, Scott Wood wrote:
> On 01/18/2017 05:12 PM, Russell King - ARM Linux wrote:
> > Please do not fiddle about under the covers, there be dragons there.
> > 
> > It looks to me like you're trying to use __cpuc_flush_dcache_area()
> > on an area that's been ioremap()'d, which is a waste of CPU cycles.
> > ioremap()'d areas are mapped as "device" memory type, which means
> > the region isn't even cached.  So I don't think this is necessary.
> 
> It is mapped cachable, via memremap() (see patch 1/10).  This is RAM
> that the device uses, non-coherently, for its own purposes (but requires
> software to clear it first).

Ok.

> Is there a non-"under the covers" way to say "flush this region" without
> the arch second-guessing whether it really needs to be flushed?

memremap() doesn't have any associated cache flushing functionality
defined for it - it's a relatively new interface added to the kernel.

There are some interfaces defined for memory that was vmalloc'd, but
due to the way kernel/memremap.c works, you can't guarantee that the
pointer you end up with came from vmalloc'd space, so I don't think
suggesting to use those would be correct (as they may have assumptions
that they'll only be called with vmalloc'd addresses.)

As pointed out later in the thread, using dma_map_single() on the
returned address is not permissible either.

The only thing I can say is that it needs a proposal for a new arch-
independent interface.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
