From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Sep 2011 00:18:06 +0100
Subject: Pull request: removal of most instances of mach/memory.h
In-Reply-To: <alpine.LFD.2.00.1109261852530.2718@xanadu.home>
References: <alpine.LFD.2.00.1109062158450.20358@xanadu.home>
	<alpine.LFD.2.00.1109130849590.20358@xanadu.home>
	<alpine.LFD.2.00.1109201349400.12663@xanadu.home>
	<20110926131524.GJ22455@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109260952490.2718@xanadu.home>
	<alpine.LFD.2.00.1109261023360.2718@xanadu.home>
	<20110926191055.GP22455@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109261514330.2718@xanadu.home>
	<20110926223810.GA23680@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109261852530.2718@xanadu.home>
Message-ID: <20110926231806.GC23680@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 07:01:22PM -0400, Nicolas Pitre wrote:
> On Mon, 26 Sep 2011, Russell King - ARM Linux wrote:
> 
> > On Mon, Sep 26, 2011 at 04:00:11PM -0400, Nicolas Pitre wrote:
> > > On Mon, 26 Sep 2011, Russell King - ARM Linux wrote:
> > > 
> > > > On Mon, Sep 26, 2011 at 10:33:28AM -0400, Nicolas Pitre wrote:
> > > > >       ARM: mach-ep93xx: remove mach/memory.h and Kconfig selection of SDRAM bank
> > > > 
> > > > Are you planning to totally kill off ZBOOT_ROM too?  Because removing
> > > > the zreladdr stuff is doing exactly that.
> > > 
> > > It looks like ZBOOT_ROM is not used on that platform at all.  However, 
> > > the ability to have a single defconfig and binary for the whole platform 
> > > is something that the mach-ep93xx maintainers are looking for.  Having 
> > > ZBOOT_ROM depend on and use CONFIG_PHYS_OFFSET would probably makes 
> > > sense eventually.
> > 
> > You miss the point.  Removing zreladdr actively _prevents_ anyone from
> > then choosing to build a kernel with ZBOOT_ROM enabled targetted for one
> > platform if that's what they want, because the decompressor then loses
> > the information it needs to properly locate the kernel.
> 
> Sure.  My point is that ZBOOT_ROM should eventually be coupled with 
> CONFIG_PHYS_OFFSET to derive the zreladdr value.  Like for XIP_KERNEL, 
> there is no real point having ZBOOT_ROM when ARM_PATCH_PHYS_VIRT is set, 
> and when not set we have the equivalent zreladdr information elsewhere 
> already.

I strongly disagree on a technical point - ARM_PATCH_PHYS_VIRT and
ZBOOT_ROM are entirely separate options _technically_ - there is no
inter-dependence between them.  ZBOOT_ROM just needs to know where
to place the decompressed image, and once it knows that, the kernel
can discover the P:V translation all by itself.

Moreover, PHYS_OFFSET does *not* define where the kernel ends up.
Remember that we sometimes place the kernel 1MB + 32K into the
physical memory space - you can't encode that into CONFIG_PHYS_OFFSET
and hope that both PHYS_OFFSET and zreladdr end up at the right place.

So this is argument is actually highly flawed technically.  You're
trying to combine two things which are actually different.

Or are we now in the business of breaking old platforms?
