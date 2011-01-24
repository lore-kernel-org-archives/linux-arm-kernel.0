From: dave@linux.vnet.ibm.com (Dave Hansen)
Date: Mon, 24 Jan 2011 08:52:17 -0800
Subject: [PATCH] ARM: mm: Regarding section when dealing with meminfo
In-Reply-To: <20110123180532.GA3509@n2100.arm.linux.org.uk>
References: <1295516739-9839-1-git-send-email-pullip.cho@samsung.com>
	<1295544047.9039.609.camel@nimitz>
	<20110120180146.GH6335@n2100.arm.linux.org.uk>
	<1295547087.9039.694.camel@nimitz>
	<20110123180532.GA3509@n2100.arm.linux.org.uk>
Message-ID: <1295887937.11047.119.camel@nimitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-01-23 at 18:05 +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 20, 2011 at 10:11:27AM -0800, Dave Hansen wrote:
> > On Thu, 2011-01-20 at 18:01 +0000, Russell King - ARM Linux wrote:
> > > > The x86 version of show_mem() actually manages to do this without any
> > > > #ifdefs, and works for a ton of configuration options.  It uses
> > > > pfn_valid() to tell whether it can touch a given pfn.
> > > 
> > > x86 memory layout tends to be very simple as it expects memory to
> > > start at the beginning of every region described by a pgdat and extend
> > > in one contiguous block.  I wish ARM was that simple.
> > 
> > x86 memory layouts can be pretty funky and have been that way for a long
> > time.  That's why we *have* to handle holes in x86's show_mem().  My
> > laptop even has a ~1GB hole in its ZONE_DMA32:
> 
> If x86 is soo funky, I suggest you try the x86 version of show_mem()
> on an ARM platform with memory holes.  Make sure you try it with
> sparsemem as well...

x86 uses the generic lib/ show_mem().  It works for any holes, as long
as they're expressed in one of the memory models so that pfn_valid()
notices them.

ARM looks like its pfn_valid() is backed up by searching the (ASM
arch-specific) memblocks.  That looks like it would be fairly slow
compared to the other pfn_valid() implementations and I can see why it's
being avoided in show_mem().

Maybe we should add either the MAX_ORDER or section_nr() trick to the
lib/ implementation.  I bet that would use pfn_valid() rarely enough to
meet any performance concerns.

-- Dave
