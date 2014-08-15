From: geoff@infradead.org (Geoff Levand)
Date: Fri, 15 Aug 2014 11:53:19 -0700
Subject: [PATCH] Arm64: convert soft_restart() to assembly code
In-Reply-To: <20140815182157.GD21908@leverpostej>
References: <1407847365-10873-1-git-send-email-achandran@mvista.com>
 <1408123221.22761.38.camel@smoke> <20140815182157.GD21908@leverpostej>
Message-ID: <1408128799.22761.47.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, 2014-08-15 at 19:21 +0100, Mark Rutland wrote:
> On Fri, Aug 15, 2014 at 06:20:21PM +0100, Geoff Levand wrote:
> > For the cpu-ops shutdown I'm working on I need a call to move the
> > secondary processors to an identity mapped spin loop after the identity
> > map is enabled.  I want to do this in C code, so it needs to happen
> > after the identity map is enabled, and before the dcache is disabled.
> > 
> > I think to do this we can keep the existing soft_restart(addr) routine
> > with something like this:
> > 
> > void soft_restart(unsigned long addr)
> > {
> > 	setup_mm_for_reboot();
> > 
> > #if defined(CONFIG_SMP)
> > 	smp_secondary_shutdown();
> > #endif
> > 
> > 	cpu_soft_restart(addr);
> > 
> > 	/* Should never get here */
> > 	BUG();
> > }
> > 
> 
> I don't follow why you need a hook in the middle of soft_restart. That
> sounds like a layering violation to me.
> 
> I assume this is for implementing the spin-table cpu-return-addr idea?

Yes.

> If so, what's wrong with something like:

> void spin_table_cpu_die(unsigned int cpu)
> {
> 	unsigned long release_addr = per_cpu(return_addr, cpu);
> 	
> 	/*
> 	 * We should have a local_disable(DBG|ASYNC|FIQ|IRQ) function or
> 	 * something similar as these are all context synchronising and
> 	 * therefore expensive.
> 	 */
> 	local_dbg_disable();
> 	local_async_disable();
> 	local_fiq_disable();
> 	arch_local_irq_disable();
> 
> 	soft_restart(release_addr);
> }

OK, this is a much simpler way than what I was thinking, which
was to have the secondaries spin in the kernel until the main
cpu shutdown.  I'll switch over to this, thanks.

-Geoff
