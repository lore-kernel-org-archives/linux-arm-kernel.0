From: tim@krieglstein.org (Tim Sander)
Date: Fri, 25 Apr 2014 15:36:48 +0200
Subject: set_fiq_handler: Bad mode in data abort handler detected
In-Reply-To: <20140424190156.GZ26756@n2100.arm.linux.org.uk>
References: <2527501.cXAbiV8bqS@dabox> <2181550.Duxpmd4GvD@dabox>
 <20140424190156.GZ26756@n2100.arm.linux.org.uk>
Message-ID: <7402473.jpZGckhttH@dabox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell and List

Thanks for your feedback!
Am Donnerstag, 24. April 2014, 20:01:56 schrieb Russell King - ARM Linux:
> > > In years gone by, I'd have recommended that the kernel mappings for
> > > this stuff were done via static mappings, but with DT, that's no
> > > longer acceptable.  So I guess we have a problem...
> > 
> > To verify that your very plausible hypothesis is right i tried:
> > timer_memory = __arm_ioremap(0x4280000>>PAGE_SHIFT,0x1000,MT_MEMORY);
> > //also tried MT_DEVICE
> This isn't going to help.  Any dynamically initialised mapping via any
> of the ioremap functions is going to fail for the reason I outlined,
> and it doesn't matter what type of mapping you use.  *All* dynamically
> created mappings are populated to other threads lazily.
Ok, i tried mapping statically in bootup. Just to verify and understand the 
problem. It seems to help somewhat (probably it does go into more threads), 
but it doesn't remedy the problem completly:

static struct map_desc zynq_axi_gp0 __initdata = {
    .virtual   = 0xe4000000, //FIXME just arbitrary, which?
    .pfn    = __phys_to_pfn(0x40000000),
    .length = SZ_128M,
    .type   = MT_DEVICE,
};

static void __init zynq_axi_gp_init(void)
{
    iotable_init(&zynq_axi_gp0,1);
    zynq_axi_gp0_base = (void __iomem *) zynq_axi_gp0.virtual;
    BUG_ON(!zynq_axi_gp0_base);
}
This was called in the .map_io callback. But it seems, even this is to late to
propagate into all threads. Calling it earlier does not work (e.g. .init_early 
,.init_timer or init_irq)...
Thinking about it, if its truly lazy even an early initialization does not 
help if mapping synchronisation is allways done lazy via data abort.

> The reason for that is because it's _very_ expensive/racy to walk over
> every single thread and update its page tables - Linux years ago used
> to do that as standard with ioremap() and similar, and the code was
> ripped out after it became too much of a burden.
It seems as if this was before git times? At least it does not seem to be 
in the git repository. Do you have an rough estimate in what year that was or 
which kernel version?

> When I talk about static mappings above, I'm talking about those which
> are setup very early in boot via iotable_init().  However, these aren't
> permitted with DT anymore.
As pointed out above this call at least boots and works in a way that i see 
the ioremapped virtual address used (0xe4000000).
> > the memory at early boot in "zynq_init_late".
> 
> My kernel doesn't have zynq_init_late()... I'm guessing that it's hooked
> into the .init_late callback, which is certainly too late - this is called
> towards the end of driver initialisation, after many threads have already
> been spawned.
Is there an callback where iotable_init still works and that is early enough?

> The places where you are called before any threads have been spawned are
> unfortunately places where you can't use ioremap().
> 
> At the moment, I don't have an answer to this - the answers I have are
> incompatible with the direction that arm-soc people want to go (which is
> to have zero static mappings.)
Ok, your wrote in the earlier mail:
>What might be possible is to have a function which can be called in
>these circumstances which ensures that a kernel address is accessible
>to all threads in the system, though while it's doing that, it would
>have to stop any fork() or exit() activity to be sure that it updated
>every thread.
Would a solution that works that way be acceptable for mainline? 

Besides that i currently don't understand why the FIQ worked on older pre 
CortexA9 cores with Linux? There is an nice writeup at 
http://free-electrons.com/blog/fiq-handlers-in-the-arm-linux-kernel/ 
which is working with an armV5 (which has the caches on the "wrong" side) and 
i think that it was also working on armV6 (aka arm1136).

Best regards
Tim
