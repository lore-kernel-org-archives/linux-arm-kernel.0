From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 Apr 2014 14:51:18 +0100
Subject: set_fiq_handler: Bad mode in data abort handler detected
In-Reply-To: <7402473.jpZGckhttH@dabox>
References: <2527501.cXAbiV8bqS@dabox> <2181550.Duxpmd4GvD@dabox>
 <20140424190156.GZ26756@n2100.arm.linux.org.uk> <7402473.jpZGckhttH@dabox>
Message-ID: <20140425135117.GP26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 03:36:48PM +0200, Tim Sander wrote:
> Hi Russell and List
> 
> Thanks for your feedback!
> Am Donnerstag, 24. April 2014, 20:01:56 schrieb Russell King - ARM Linux:
> > > > In years gone by, I'd have recommended that the kernel mappings for
> > > > this stuff were done via static mappings, but with DT, that's no
> > > > longer acceptable.  So I guess we have a problem...
> > > 
> > > To verify that your very plausible hypothesis is right i tried:
> > > timer_memory = __arm_ioremap(0x4280000>>PAGE_SHIFT,0x1000,MT_MEMORY);
> > > //also tried MT_DEVICE
> > This isn't going to help.  Any dynamically initialised mapping via any
> > of the ioremap functions is going to fail for the reason I outlined,
> > and it doesn't matter what type of mapping you use.  *All* dynamically
> > created mappings are populated to other threads lazily.
> Ok, i tried mapping statically in bootup. Just to verify and understand the 
> problem. It seems to help somewhat (probably it does go into more threads), 
> but it doesn't remedy the problem completly:
> 
> static struct map_desc zynq_axi_gp0 __initdata = {
>     .virtual   = 0xe4000000, //FIXME just arbitrary, which?
>     .pfn    = __phys_to_pfn(0x40000000),
>     .length = SZ_128M,
>     .type   = MT_DEVICE,
> };
> 
> static void __init zynq_axi_gp_init(void)
> {
>     iotable_init(&zynq_axi_gp0,1);
>     zynq_axi_gp0_base = (void __iomem *) zynq_axi_gp0.virtual;
>     BUG_ON(!zynq_axi_gp0_base);
> }
> This was called in the .map_io callback. But it seems, even this is to late to
> propagate into all threads. Calling it earlier does not work (e.g. .init_early 
> ,.init_timer or init_irq)...

It isn't too late.  .map_io is called as part of the very early kernel
initialisation, when the page tables are being setup with real mappings
for the very first time.  There's no interrupts, no real memory allocators,
in fact not much of anything at that point.

I'm afraid that I'm no longer that knowledgeable about whether ioremap
will take account of this stuff or not - other people have been hacking
in this area and my knowledge is outdated.

> Thinking about it, if its truly lazy even an early initialization does not 
> help if mapping synchronisation is allways done lazy via data abort.

This is how it works.

.map_io is called with the init_mm as the current mm structure.  This
contains the page tables.  Calling iotable_init() sets up mappings in
that page table.  No other threads exist at this point.

When a kernel thread is spawned, all L1 page tables for kernel mappings
are copied to the child's page tables.  Therefore, the mappings setup
via iotable_init() will propagate into the children without any data
aborts.

On ioremap(), the init_mm's page tables are updated with the L1 entries.
Other page tables are not updated until an access is performed, which
causes a data abort if there is no L1 page table entry.

So, .map_io should resolve the problem.  If it doesn't, something else
is going on - maybe ioremap() is trampling all over your static mappings...
though I thought we put the iotable_init()-created mappings into the
vmalloc list, which should prevent it.  I don't know anymore...

> > The reason for that is because it's _very_ expensive/racy to walk over
> > every single thread and update its page tables - Linux years ago used
> > to do that as standard with ioremap() and similar, and the code was
> > ripped out after it became too much of a burden.
>
> It seems as if this was before git times? At least it does not seem to be 
> in the git repository. Do you have an rough estimate in what year that was or 
> which kernel version?

Yes, way before a very long time ago, probably 1.2 or 2.0 kernel time
(or their development counterparts.)

I'm sorry, I don't think I can really help anymore with this problem.
I've given you the best that my limited knowledge of the ARM kernel
today allows, which is reducing as I don't really hack on the ARM kernel
very much anymore, and I'm not involved with many of the changes which
happen today.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
