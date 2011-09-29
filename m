From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 29 Sep 2011 19:57:06 -0400 (EDT)
Subject: Git pull request: mach/vmalloc.h removal,
	and ioremap optimizations
In-Reply-To: <4E84E0CA.2050905@gmail.com>
References: <alpine.LFD.2.00.1109230908410.12663@xanadu.home>
	<4E8495D9.2030009@gmail.com>
	<20110929173731.GB21718@n2100.arm.linux.org.uk>
	<4E84B80D.2020605@gmail.com>
	<alpine.LFD.2.02.1109291439110.9106@xanadu.home>
	<4E84D47F.7030007@gmail.com>
	<alpine.LFD.2.02.1109291645570.9106@xanadu.home>
	<4E84E0CA.2050905@gmail.com>
Message-ID: <alpine.LFD.2.02.1109291904070.9106@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Sep 2011, Rob Herring wrote:

> On 09/29/2011 03:47 PM, Nicolas Pitre wrote:
> > On Thu, 29 Sep 2011, Rob Herring wrote:
> > 
> >> So it was really Realview PBX I wanted to test my GIC changes on. Well,
> >> turns out it's got a similar problem, too.
> >>
> >> However, the fix for it should perhaps be a bit different. The problem
> >> is that the virtual address of REALVIEW_PBX_TILE_GIC_CPU_BASE is not
> >> aligned. Then 0x100 + 4KB length overlaps into the DIST_BASE. So do we
> >> fix it in the platform or should the core code mask out the lower bits
> >> of the virt addr before doing any size calculations?
> > 
> > Please fix it in the platform static declaration.  No need to put 
> > run time code for something that can be fixed in the source.
> > 
> Except that 2 out of 2 machines I've tried are broken.

You've been lucky... or maybe the authors of the versatile and realview 
support shared the same ... habits.

In any case, it is plain wrong to use overlapping mappings anyway.  If 
you do have a mapping to start at 0xf0000100 with a size of 4096 bytes, 
then the only way to satisfy this is to map two pages. If in practice 
only one page was enough because only the first 32 bytes are accessed, 
then you should really specify the size as 32.  Or use a 4K aligned 
start address if you want to stick with a 4K size.

But to simply mask out the low address bits _before_ determining the 
mapping end is just lying to yourself.  What if some day such a mapping 
that ends up crossing a page boundary is legit?  Better be more careful 
and rigorous with the actual mapping parameters rather than forcing the 
core code to guess what was meant.

And in this case, the map_desc entry order just hid the issue by having 
a later mapping overwrite the extra page from the previous one. If the 
map_desc entries were reversed then you'd have ended up with the wrong 
mapping in place which is a bug.  At least with my series this kind of 
mapping mistake is now flagged which is a good thing.

> Anyway, patch is coming.

Applied, thanks.


Nicolas
