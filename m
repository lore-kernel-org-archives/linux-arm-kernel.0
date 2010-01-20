From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 20 Jan 2010 16:05:25 +0000
Subject: too much memory for node
In-Reply-To: <20100120155510.GB27507@n2100.arm.linux.org.uk>
References: <20100120153411.GG26562@trinity.fluff.org>
	<20100120155510.GB27507@n2100.arm.linux.org.uk>
Message-ID: <20100120160525.GW10014@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2010 at 03:55:10PM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 20, 2010 at 03:34:11PM +0000, Ben Dooks wrote:
> > I've been looking at support for a new machine type where the
> > current system is using DISCONTIGMEM as the 1G memory map has
> > 4x256M RAM ranges which may not all be filled.
> 
> Firstly, use sparsemem, unless you intentionally want to spend more
> cycles in the kernel.

Ok, any idea if that will fix the problem in this case?
 
> > After removing a hack in the machine support file which fills in
> > its own memory table thus obliteratign the bootloader supplied ATAG_MEM
> > I found a problem. The board has the full complement of memory and is
> > being passed a single ATAG_MEM from the bootloader for all 1G.
> 
> You're into the classic problem which happens when you don't tackle
> these kinds of issues as soon as the first one occurs.  If you allow
> them to persist for any time, getting rid of them later becomes very
> difficult.  I suspect that you're rather stuck now.

Unfortunately the bootloader is actually correct in this case, the
version of the chip on this board has a complete 1G of memory, it
just happens there are versions which have holey memory maps depending
on how the DRAM is bonded/wired to the chip.

Will look at SPARSEMEM tomorrow.
 
> > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > index c6c57b6..a5f7b21 100644
> > --- a/arch/arm/kernel/setup.c
> > +++ b/arch/arm/kernel/setup.c
> > @@ -410,6 +410,21 @@ static int __init arm_add_memory(unsigned long start, unsigned long size)
> >  		return -EINVAL;
> >  
> >  	meminfo.nr_banks++;
> > +
> > +	if (PHYS_TO_NID(start + size) != bank->node) {
> > +		/* more memory than a single node can handle */
> > +
> > +		unsigned long next = (1024*1024);
> > +
> > +		while (PHYS_TO_NID(start + next) == bank->node) 
> > +			next += (1024*1024); 
> > +
> > +		bank->size = next;
> > +		printk(KERN_INFO "adding new bank 0x%08x size 0x%08x\n",
> > +				start + next, size - next);
> > +		arm_add_memory(start + next, size - next);
> > +	}
> > +
> >  	return 0;
> >  }
> >  
> > Note, this code uses a search as I couldn't find a good way of calculating
> > how mucch space was left in a node given a starting address.
> 
> There is no way to do this in the kernel.
> 
> > Another option is to do similar to sanity_check_meminfo() in the mmu
> > setup code (we would still need some form of nodemask or similar from
> > the memory.h). Is NODE_MEM_SIZE_MASK usable if !CONIFG_DISCONTIGMEM
> > to allow us to avoid the search and still have compilable code?
> 
> NODE_MEM_SIZE_MASK is DISCONTIGMEM specific; it doesn't exist for
> flatmem nor sparsemem (where it's not relevant.)

Yeah, my secodn solution had to be ?#ifdef CONFIG_DISCONTIGMEM
 
> It's also complicated by platforms which compress their physical RAM
> space to fit inside the virtual mappings, eg:
> 
>  * 256MB @ 0x00000000 -> PAGE_OFFSET
>  * 512MB @ 0x20000000 -> PAGE_OFFSET + 0x10000000
>  * 256MB @ 0x80000000 -> PAGE_OFFSET + 0x30000000
> 
> The only other solution would be for platforms to declare valid areas
> of physical memory back to the setup_arch() code, so that it can
> verify the parameters passed - but that's an awful lot of effort just
> to fix idiotically implemented boot loaders.

thanks for the help.

Should I send a patch to detect bad DISCONTIGMEM setup? I think that
a check of PHYS_TO_PFN((start+end) != PHYS_TO_PFN(start)) should be
safe in all cases?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
