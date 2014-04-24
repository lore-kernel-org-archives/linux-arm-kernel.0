From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Apr 2014 20:01:56 +0100
Subject: set_fiq_handler: Bad mode in data abort handler detected
In-Reply-To: <2181550.Duxpmd4GvD@dabox>
References: <2527501.cXAbiV8bqS@dabox>
 <20140424103136.GI26756@n2100.arm.linux.org.uk> <2181550.Duxpmd4GvD@dabox>
Message-ID: <20140424190156.GZ26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 04:33:38PM +0200, Tim Sander wrote:
> Hi Russell and List
> <snip>
> > In years gone by, I'd have recommended that the kernel mappings for
> > this stuff were done via static mappings, but with DT, that's no
> > longer acceptable.  So I guess we have a problem...
> 
> To verify that your very plausible hypothesis is right i tried:
> timer_memory = __arm_ioremap(0x4280000>>PAGE_SHIFT,0x1000,MT_MEMORY); //also tried MT_DEVICE

This isn't going to help.  Any dynamically initialised mapping via any
of the ioremap functions is going to fail for the reason I outlined,
and it doesn't matter what type of mapping you use.  *All* dynamically
created mappings are populated to other threads lazily.

The reason for that is because it's _very_ expensive/racy to walk over
every single thread and update its page tables - Linux years ago used
to do that as standard with ioremap() and similar, and the code was
ripped out after it became too much of a burden.

When I talk about static mappings above, I'm talking about those which
are setup very early in boot via iotable_init().  However, these aren't
permitted with DT anymore.

> the memory at early boot in "zynq_init_late".

My kernel doesn't have zynq_init_late()... I'm guessing that it's hooked
into the .init_late callback, which is certainly too late - this is called
towards the end of driver initialisation, after many threads have already
been spawned.

The places where you are called before any threads have been spawned are
unfortunately places where you can't use ioremap().

At the moment, I don't have an answer to this - the answers I have are
incompatible with the direction that arm-soc people want to go (which is
to have zero static mappings.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
