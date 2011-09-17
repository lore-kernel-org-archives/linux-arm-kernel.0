From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 17 Sep 2011 17:20:46 +0100
Subject: [PATCH 16/19] ARM: move iotable mappings within the vmalloc region
In-Reply-To: <alpine.LFD.2.00.1109171150320.20358@xanadu.home>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
	<1316156850-31013-17-git-send-email-nico@fluxnic.net>
	<20110917151953.GJ16381@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109171150320.20358@xanadu.home>
Message-ID: <20110917162046.GK16381@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 17, 2011 at 12:05:02PM -0400, Nicolas Pitre wrote:
> On Sat, 17 Sep 2011, Russell King - ARM Linux wrote:
> 
> > On Fri, Sep 16, 2011 at 03:07:27AM -0400, Nicolas Pitre wrote:
> > >  void __init iotable_init(struct map_desc *io_desc, int nr)
> > >  {
> > > -	int i;
> > > +	struct map_desc *md;
> > > +	struct vm_struct *vm;
> > > +
> > > +	vm = __va(memblock_alloc(sizeof(*vm) * nr, __alignof__(*vm)));
> > > +	memset(vm, 0, sizeof(*vm) * nr);
> > 
> > Any reason not to adapt early_alloc() ?
> 
> It uses the size for the alignment argument.  This is way too large an 
> alignment in this case.  The size as alignment makes perfect sense in 
> the other cases, and providing it explicitly for those cases might look 
> strange.  But if you prefer that I'll just do it.

Just change early_alloc() to also take the alignment and then fix up the
existing callers.  It's silly to open-code the __va() + memset().

> > This is silly.  You're defining VMALLOC_END to be 0xff000000UL, and
> > then defining this to be 0xf0000000UL - 8MB.  Why hide the 240MB
> > inside these constants?  Why not set it to VMALLOC_END - 240MB -
> > VMALLOC_OFFSET - making the size in their _explicit_ instead of hidden?
> 
> Actually I care more about the absolute start address than the size this 
> ends up creating.  This is to accommodate some of the static mappings 
> that starts at 0xf0000000 on machines with a potential to have enough 
> RAM that could map higher than that.  It just happens that this 
> corresponds to 240MB.

We should stick to dealing with the size of vmalloc area rather than an
absolute address range as that's what we present to users via the
vmalloc= argument to the kernel.

> > >  /*
> > >   * vmalloc=size forces the vmalloc area to be exactly 'size'
> > >   * bytes. This can be used to increase (or decrease) the vmalloc
> > > - * area - the default is 128m.
> > > + * area - the default is 240m.
> > >   */
> > >  static int __init early_vmalloc(char *arg)
> > >  {
> > > @@ -853,6 +866,7 @@ void __init sanity_check_meminfo(void)
> > >  #endif
> > >  	meminfo.nr_banks = j;
> > >  	memblock_set_current_limit(lowmem_limit);
> > > +	high_memory = __va(lowmem_limit - 1) + 1;
> > 
> > NAK.  This ends up initializing this setting twice during the boot,
> > potentially leading to bugs because they're both done in different ways.
> 
> In that case I should remove the other one.

If you do that, don't forget to fix nommu as well.

> > > @@ -977,6 +991,12 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
> > >  	}
> > >  
> > >  	/*
> > > +	 * Clear the vmalloc area.
> > > +	 */
> > > +	for (addr = VMALLOC_START; addr < VMALLOC_END; addr += PGDIR_SIZE)
> > > +		pmd_clear(pmd_off_k(addr));
> > 
> > Why not combine this with the clearance above:
> > 
> >         for (addr = VMALLOC_END; addr; addr += PGDIR_SIZE)
> >                 pmd_clear(pmd_off_k(addr));
> > 
> > ?
> 
> Because I wanted to keep the mapping for the DEBUG_LL code alive as long 
> as possible.

You can't put DEUBG_LL code into create_mapping() anyway because at some
point it will be called without the mapping in place, even with your
modified code.

It's not like we have a lot of code between those two points - we've
done most of the allocation (eg vectors page), so the only failure point
is if L2 page table allocation fails - but that's true of almost any
create_mapping() call.

So, I don't see the benefit of delaying the clearance.
