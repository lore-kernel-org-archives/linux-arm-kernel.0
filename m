From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Jul 2010 18:06:53 +0100
Subject: [patch 0/2] ARM: Disable outer cache before kexec call
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5E41E0C@dbde02.ent.ti.com>
References: <20100701160206.539545857@linutronix.de>
	<1278000887.7482.12.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1007011820000.4507@localhost.localdomain>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5E41E0C@dbde02.ent.ti.com>
Message-ID: <20100701170653.GA15162@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 01, 2010 at 10:08:37PM +0530, Shilimkar, Santosh wrote:
> > -----Original Message-----
> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> > kernel-bounces at lists.infradead.org] On Behalf Of Thomas Gleixner
> > To: Catalin Marinas
> > Cc: LAK
> > 
> > Catalin,
> > 
> > But it can disable the inner caches? That's weird.
> > 
> If the C bit is disabled then it is as good as L1 and L2 are disabled.

However, if L2 contains valid cache lines which haven't been written
back, the result of disabling the C bit effectively is instantaneous
memory corruption.

We know that some L2 caches aren't searched if the C bit in the MMU
tables is disabled, and for those caches I'd imagine the same thing
happens when you clear the C bit in the SCTLR when turning off the
MMU.  What we currently do for L1 is:

- disable interrupts
- clean all caches (optionally invalidating)
- turn off I & C bits
- invalidate all caches

The 'clean' is there to push dirty data out of the caches back into
memory.  We then turn off the I & C bits, ensuring that no new cache
lines are read in.  At this point, some caches are no longer searched.

We then invalidate all caches to ensure that when _something_ later
re-enables the caches, that they don't see our stale data.

As L2 needs this same handling, what I propose is, for both
machine_restart() and machine_kexec():

1. we move the IRQ (and FIQ) disable out of each CPUs proc_fin()
2. call flush_cache_all() immediately after IRQs are disabled
   (removing any cache flushing from proc_fin() implementations.)
3. call outer_flush_all() (new function) after that
4. call proc_fin() to disable the C & I bits.
5. call flush_cache_all() again to invalidate the inner caches
6. call outer_flush_all() again to invalidate the outer caches
7. whatever's next after the existing cpu_proc_fin()...

The only potential problem I see with this is that (5) and (6) may end
up writing back some dirty data associated with the stack, and one of
these functions may overwrite its return address - thereby causing us
to loop back to (2) or (3).  I don't think that's a problem as the next
time around this 'loop' we won't be creating new dirty cache lines, and
we should get to step 7.
