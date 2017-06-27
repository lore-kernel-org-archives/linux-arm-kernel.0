From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Jun 2017 10:10:07 +0100
Subject: [GIT PULL v3] updates to qbman (soc drivers) to support arm/arm64
In-Reply-To: <CAK8P3a0N5tiP7RPMg=Q8fsROuYabJjQ5Awd2ekrn686nDqdNwA@mail.gmail.com>
References: <HE1PR0401MB17071A7853695DB6546FE28C8FC50@HE1PR0401MB1707.eurprd04.prod.outlook.com>
 <CAK8P3a2EvCvs57hE_X9J5jg6jW8jPh6gxaTOUYntbnHdb_cMZA@mail.gmail.com>
 <20170623152227.GA21989@leverpostej>
 <DB6PR04MB2999E8FFBE0FE708A003637986D80@DB6PR04MB2999.eurprd04.prod.outlook.com>
 <CAK8P3a0mhWTRriGYB6aHS28dm842d-0OeGRmRYzMS4ZYY9=YCQ@mail.gmail.com>
 <20170627081717.GM4902@n2100.armlinux.org.uk>
 <CAK8P3a0N5tiP7RPMg=Q8fsROuYabJjQ5Awd2ekrn686nDqdNwA@mail.gmail.com>
Message-ID: <20170627091006.GN4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 11:05:38AM +0200, Arnd Bergmann wrote:
> On Tue, Jun 27, 2017 at 10:17 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Tue, Jun 27, 2017 at 09:17:48AM +0200, Arnd Bergmann wrote:
> >> I'd suggest we start out by converting this to some standard API
> >> first, regardless of performance, to get it working properly with code
> >> that should be maintainable at least, and make progress with your
> >> hardware enablement.
> >
> > I think Roy is rather confused right now about what the driver does
> > and doesn't do.
> >
> > With his patches, two areas are mapped on ARM:
> >
> > 1. The addr.ci area is mapped using ioremap().  This is a device mapping,
> >    and is used by the "Cache-inhibited register access." functions.
> >
> > 2. The addr.ce area is mapped using ioremap_wc(), and all other stuff
> >    including the verb accesses go through this region.  This is a
> >    memory, non-cacheable mapping.
> >
> > The addr.ce region is the area that has a mixture of memset(), MMIO
> > accessors, direct CPU accesses, cache flushes and prefetches used on
> > it.
> >
> > As it is marked non-cacheable, the cache flushes are a pure waste of
> > CPU cycles.  Prefetching to a non-cacheable area doesn't make much
> > sense either.
> >
> > So, I think for ARM: just kill the cache flushing - its doing nothing
> > useful.  The prefetching could also be removed as well to recover a
> > few more CPU cycles.
> 
> Right, that sounds good. I wondered about the ioremap_wc() earlier
> and thought I must have missed something as it didn't make any sense
> to me, but apparently that was because the code really doesn't make
> sense ;-).
> 
> It would be good to get consistent __iomem annotations on it too,
> so we can see exactly where the MMIO interfaces are used incorrectly,
> and find a fix for that.
> 
> I wonder if doing memcpy_toio on the write-combining mapping
> will do what Roy wants and and up sending a single bus transaction
> for one descriptor most of the time, while fitting in with the ioremap_wc()
> interface and its __iomem pointers.

Either the CE region needs __iomem pointers and proper accessors, or
it needs to be using memremap(offset, size, MEMREMAP_WC) and not use
the iomem accessors.

The CI region should definitely have __iomem annotations though.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
