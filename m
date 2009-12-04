From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Dec 2009 16:59:29 +0000
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <20091204163850.GC20386@n2100.arm.linux.org.uk>
References: <4B18F141.7070101@denx.de>
	<20091204131307.GE15887@n2100.arm.linux.org.uk>
	<4B1911B4.7080907@denx.de>
	<20091204154231.GB20386@n2100.arm.linux.org.uk>
	<4B1931B3.90301@denx.de>
	<20091204163850.GC20386@n2100.arm.linux.org.uk>
Message-ID: <20091204165929.GD20386@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2009 at 04:38:50PM +0000, Russell King - ARM Linux wrote:
> On Fri, Dec 04, 2009 at 04:58:43PM +0100, Heiko Schocher wrote:
> > Hello Russell King,
> > 
> > Russell King - ARM Linux wrote:
> > > On Fri, Dec 04, 2009 at 02:42:12PM +0100, Heiko Schocher wrote:
> > >> Hello Russell King,
> > >>
> > >> Russell King - ARM Linux wrote:
> > >>> On Fri, Dec 04, 2009 at 12:23:45PM +0100, Heiko Schocher wrote:
> > >>>> [4] Log from Demoprogramm, not working
> > >>> I think this is messed up - this is not from your first script but your
> > >>> second script which starts four independent read processes.
> > >>>
> > >>> I determined this because:
> > >>> (1) the read thread addresses are mostly the same
> > >>> (2) there are four "Read form in_msg" strings, which you only print
> > >>> once at the start of the program.
> > >> Ups, sorry for the confusion, here 2 logs with the right values:
> > > 
> > > I don't remember whether 2.6.28 has highmem.  Can you check whether you're
> > > using highmem please?
> > 
> > No, there is no HIGHMEM in the defconfig, if you mean this config option.
> > 
> > You can find the complete defconfig here:
> > 
> > http://git.denx.de/?p=linux-2.6-denx.git;a=blob;f=arch/arm/configs/suen3_defconfig;h=905f9bc6a36c03ab41b97a292fca5b3a0011a2a0;hb=3dc3e4dc957f216ec5cdcd2a770f5c4b0cefca4a
> 
> Please apply this patch and re-run your program.  Expect a fair bit of
> output - the last 50 or so lines from the kernel messages should cover
> everything that's required.  Also useful would be the output from the
> program giving the addresses of the shm regions.

BTW, so that other people know: the use of highmem on VIVT caches _will_
result in buggy shared mmap[*] behaviour similar to what you're seeing; the
ARM fixup in update_mmu_cache() is rendered inoperative for the existing
mappings.

Luckily, however, when the conditions for applying the fixup are triggered,
you _will_ get a kernel oops.

Since the fix for this involves touching every other architecture (because
we need the page table pointer passed into update_mmu_cache), I will not
be forwarding this fix for 2.6.32.X - the patch is just far too big to
consider.

That all said, Heiko, since you're not using highmem, this will not be
affecting you.


* - this occurs when the same physical pages are mapped multiple times
into the same MM space.  Our work-around for this is to mark the pages
non-cachable bufferable, or if the write buffer fails the coherency test,
non-cachable non-bufferable.
