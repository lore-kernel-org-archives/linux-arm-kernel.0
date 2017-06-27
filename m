From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Jun 2017 09:17:17 +0100
Subject: [GIT PULL v3] updates to qbman (soc drivers) to support arm/arm64
In-Reply-To: <CAK8P3a0mhWTRriGYB6aHS28dm842d-0OeGRmRYzMS4ZYY9=YCQ@mail.gmail.com>
References: <HE1PR0401MB17071A7853695DB6546FE28C8FC50@HE1PR0401MB1707.eurprd04.prod.outlook.com>
 <CAK8P3a2EvCvs57hE_X9J5jg6jW8jPh6gxaTOUYntbnHdb_cMZA@mail.gmail.com>
 <20170623152227.GA21989@leverpostej>
 <DB6PR04MB2999E8FFBE0FE708A003637986D80@DB6PR04MB2999.eurprd04.prod.outlook.com>
 <CAK8P3a0mhWTRriGYB6aHS28dm842d-0OeGRmRYzMS4ZYY9=YCQ@mail.gmail.com>
Message-ID: <20170627081717.GM4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 09:17:48AM +0200, Arnd Bergmann wrote:
> I'd suggest we start out by converting this to some standard API
> first, regardless of performance, to get it working properly with code
> that should be maintainable at least, and make progress with your
> hardware enablement.

I think Roy is rather confused right now about what the driver does
and doesn't do.

With his patches, two areas are mapped on ARM:

1. The addr.ci area is mapped using ioremap().  This is a device mapping,
   and is used by the "Cache-inhibited register access." functions.

2. The addr.ce area is mapped using ioremap_wc(), and all other stuff
   including the verb accesses go through this region.  This is a
   memory, non-cacheable mapping.

The addr.ce region is the area that has a mixture of memset(), MMIO
accessors, direct CPU accesses, cache flushes and prefetches used on
it.

As it is marked non-cacheable, the cache flushes are a pure waste of
CPU cycles.  Prefetching to a non-cacheable area doesn't make much
sense either.

So, I think for ARM: just kill the cache flushing - its doing nothing
useful.  The prefetching could also be removed as well to recover a
few more CPU cycles.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
