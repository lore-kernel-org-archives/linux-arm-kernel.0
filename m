From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 24 Apr 2017 19:42:27 +0200 (CEST)
Subject: [Bug] VCHIQ functional test broken
In-Reply-To: <20170424164015.GP17774@n2100.armlinux.org.uk>
References: <331235003.222371.1491934205807@email.1und1.de>
 <685482264.60263.1492105308873@email.1und1.de>
 <20170413222915.GF17774@n2100.armlinux.org.uk>
 <20170414074104.GA8704@laptop> <87pog7x7c5.fsf@eliezer.anholt.net>
 <20170420195822.GA22677@laptop>
 <696fb1c1-7751-caf0-e0d9-9c67b059b4cc@i2se.com>
 <20170424164015.GP17774@n2100.armlinux.org.uk>
Message-ID: <1058502523.15283.1493055747531@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Russell King - ARM Linux <linux@armlinux.org.uk> hat am 24. April 2017 um 18:40 geschrieben:
> 
> 
> On Mon, Apr 24, 2017 at 06:12:09PM +0200, Stefan Wahren wrote:
> > Am 20.04.2017 um 21:58 schrieb Rabin Vincent:
> > > On Thu, Apr 20, 2017 at 11:27:38AM -0700, Eric Anholt wrote:
> > >> I'm confused by what you're saying here.  The driver has already been
> > >> converted to not use dmac_map_area (commit
> > >> cf9caf1929882b66922aee698e99e6c8f357bee5), and uses dma_map_sg instead,
> > >> matching the radeon driver you give as a model as far as I can see.
> > >> That commit is in v4.11-rc6 from Stefan's regression report.
> > > Right.  Sorry.  I must have had an old tag checked out when I looked at
> > > the driver earlier.  The DMA API usage in the driver in v4.11-rc6 and
> > > current master looks fine, except for one thing:
> > >
> > > The flush in flush_dcache_page() (from get_user_pages()) was done with a
> > > v6_flush_kern_dcache_page() which always did a clean+invalidate while
> > > the DMA API only does what is required by the direction, which is only a
> > > invalidate for DMA_FROM_DEVICE.  Since the driver calls dma_from_sg() on
> > > the entire page, even if userspace sent in an offset into the page,
> > > unrelated data in userspace may be thrown away.
> > >
> > > Does changing the dma API calls to always use DMA_BIDIRECTIONAL make the
> > > test pass?
> > 
> > Unfortunately not (at least not that simple).
> > 
> > Do we need special DMA mapping attributes here ? Or a dma_sync_sg_for_* ?
> 
> I had a look at the driver when you first reported the problem, but I
> don't see an obvious problem.
> 
> In drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c, I
> see it using get_user_pages(), generating a scatterlist, which it then
> uses dma_map_sg() with.  It then goes on to populate the DMA coherent
> buffer that it allocated with the DMA addresses of these buffers.
> 
> The tear-down looks sane too - free_pagelist() looks like it correctly
> unmaps the scatterlist, marks the pages dirty if necessary, puts the
> pages and frees the DMA coherent memory.
> 
> Since you're running on a PIPT cache, the only possible issue is whether
> there's a lifetime mismatch between what happens here, and what you're
> doing with the pages in userspace.  All the rules wrt the DMA API apply
> to these userspace pages, just as these same rules apply in kernel space.
> Once you have called dma_map_sg() on them, any CPU access (whether
> explicit or speculative) will cause cache lines to be populated, and
> possibly marked dirty, which can have the effect of corrupting the data
> unless it is unmapped prior to the accesses you care about.

Just for the records, the link to the userspace program:

https://github.com/raspberrypi/userland/blob/master/interface/vchiq_arm/vchiq_test.c

Maybe there is an issue in the ioctl

> 
> What I can't see is how changing flush_dcache_page() has possibly broken
> this: it seems to imply that you're getting flush_dcache_page() somehow
> called inbetween mapping it for DMA, using it for DMA and CPU accesses
> occuring.  However, the driver doesn't call flush_dcache_page() other
> than through get_user_pages() - and since dma_map_sg() is used in that
> path, it should be fine.
> 
> So, I don't have much to offer.
> 
> However, flush_dcache_page() is probably still a tad heavy - it currently
> flushes to the point of coherency, but it's really about making sure that
> the user vs kernel mappings are coherent, not about device coherency.
> That's the role of the DMA API.

Currently i don't care too much about performance. More important is to fix this regression, because i'm not able to verify the function of this driver efficiently.

I'm thinking about 2 options:

1) add a force parameter to flush_dcache_page() which make it possible to override the new logic
2) create a second version of flush_dcache_page() with the old behavior

But first of all i need to figure out which parts of flush_dcache_page() are really necessary.

Many thanks anyway

> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
