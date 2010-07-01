From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Jul 2010 18:48:59 +0100
Subject: [patch 0/2] ARM: Disable outer cache before kexec call
In-Reply-To: <1278005695.7482.41.camel@e102109-lin.cambridge.arm.com>
References: <20100701160206.539545857@linutronix.de>
	<1278000887.7482.12.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1007011820000.4507@localhost.localdomain>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5E41E0C@dbde02.ent.ti.com>
	<20100701170653.GA15162@n2100.arm.linux.org.uk>
	<20100701172128.GB15162@n2100.arm.linux.org.uk>
	<1278005695.7482.41.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100701174859.GA16383@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 01, 2010 at 06:34:55PM +0100, Catalin Marinas wrote:
> On Thu, 2010-07-01 at 18:21 +0100, Russell King - ARM Linux wrote:
> > On Thu, Jul 01, 2010 at 06:06:53PM +0100, Russell King - ARM Linux wrote:
> > > 1. we move the IRQ (and FIQ) disable out of each CPUs proc_fin()
> > > 2. call flush_cache_all() immediately after IRQs are disabled
> > >    (removing any cache flushing from proc_fin() implementations.)
> > > 3. call outer_flush_all() (new function) after that
> > > 4. call proc_fin() to disable the C & I bits.
> > > 5. call flush_cache_all() again to invalidate the inner caches
> > > 6. call outer_flush_all() again to invalidate the outer caches
> > > 7. whatever's next after the existing cpu_proc_fin()...
> > >
> > > The only potential problem I see with this is that (5) and (6) may end
> > > up writing back some dirty data associated with the stack, and one of
> > > these functions may overwrite its return address - thereby causing us
> > > to loop back to (2) or (3).  I don't think that's a problem as the next
> > > time around this 'loop' we won't be creating new dirty cache lines, and
> > > we should get to step 7.
> > 
> > Right, something like this.  I've not made an effort to fix the L2 bits,
> > but I have marked the places where attention is required.  The interesting
> > bit is the first two files.
> > 
> > The next question this provokes is whether we need a dsb() between steps 3
> > and 4, and maybe again between 4 and 5, and possibly after 6 ?
> 
> We don't need a dsb() after 3 and 6. The outer_flush_all() function
> would need to do a cache_sync (which polls a register) since that's a
> background operation on the L2 cache. DSB doesn't have any effect on the
> L2 cache.

Well, that leaves a question about Feroceon:

#if defined(CONFIG_CACHE_FEROCEON_L2) && \
        !defined(CONFIG_CACHE_FEROCEON_L2_WRITETHROUGH)
        mov     r0, #0
        mcr     p15, 1, r0, c15, c9, 0          @ clean L2
        mcr     p15, 0, r0, c7, c10, 4          @ drain WB
#endif

The question is where to move that (effective) DSB to - I guess it can
move to arch/arm/mm/cache-feroceon-l2.c.
