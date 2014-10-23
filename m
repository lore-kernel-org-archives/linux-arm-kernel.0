From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Oct 2014 09:55:34 +0100
Subject: CMA region and highmem
In-Reply-To: <CADtm3G65f0RZR-RBw=kdKWoTP0RFOPwPjhjkEbF2JFeUV0YZPA@mail.gmail.com>
References: <20140813191811.GP30401@n2100.arm.linux.org.uk>
 <CADtm3G65f0RZR-RBw=kdKWoTP0RFOPwPjhjkEbF2JFeUV0YZPA@mail.gmail.com>
Message-ID: <20141023085534.GG27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 07:10:58PM -0700, Gregory Fong wrote:
> Hi Russell,
> 
> On Wed, Aug 13, 2014 at 12:18 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > [...]
> > The reason I ask is that this morning, I was greeted by this excellent
> > OOM on one of my platforms.  It has 2G of memory, and no real DMA
> > restrictions, and with much of the memory still available, it OOM'd
> > because I need a relatively large CMA block.
> > [...]
> > xdg-screensaver invoked oom-killer: gfp_mask=0x4d0, order=2, oom_score_adj=0

order=2 => 16K

> > Normal: 117*4kB (UEMC) 959*8kB (UEMC) 2*16kB (C) 2*32kB
> >  (C) 2*64kB (C) 0*128kB 0*256kB 0*512kB 1*1024kB (C) 1*2048kB (C)
> >  36*4096kB (C) = 158892kB
> 
> it doesn't look like the fragmentation is _too_ terrible, an OOM still
> happens?  Since this didn't seem surprising to you, I'm thinking my
> understanding might be wrong, and was wondering if you might be able
> to help me understand how an OOM like this happens with such a large
> amount of lowmem still free.

for 16K and above, all the pages are marked with "C", which means they
are CMA pages.  All other types (unmovable, reclaimable, movable) are
exhausted.

The gfp flags were GFP_KERNEL | __GFP_REPEAT.  Mobility grouping is on,
but allocflags_to_migratetype() returns MIGRATE_UNMOVABLE for this.

The fallbacks for MIGRATE_UNMOVABLE are:

[MIGRATE_UNMOVABLE] = { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE, MIGRATE_RESERVE }

which does not allow it to take from CMA.

The only migration type which is allowed to fallback to CMA is:

[MIGRATE_MOVABLE] = { MIGRATE_CMA, MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE, MIGRATE_RESERVE },

which you get with having the "__GFP_MOVABLE" gfp bit set.  Hence,
GFP_KERNEL allocations never allocate from CMA.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
