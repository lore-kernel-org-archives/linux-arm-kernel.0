From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 17 May 2011 17:45:44 +0200 (CEST)
Subject: [PATCH] arm: Use arch_spin_lock for unwind to avoid lockdep
	deadlock
In-Reply-To: <1305642021.2466.5799.camel@twins>
References: <alpine.LFD.2.02.1105171605080.3078@ionos>
	<1305642021.2466.5799.camel@twins>
Message-ID: <alpine.LFD.2.02.1105171737260.3078@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 May 2011, Peter Zijlstra wrote:

> On Tue, 2011-05-17 at 16:11 +0200, Thomas Gleixner wrote:
> > When lockdep traces a lock taken in a module the arm unwinder takes
> > unwind_lock which causes a recursive lockdep call deadlocking itself
> > on the unwind_lock.
> > 
> > Make unwind_lock an arch_spin_lock to avoid the lockdep call and use
> > the raw_local_irq_save/restore() variants to avoid irq tracing as
> > well. 
> 
> That doesn't parse, lockdep has recursion protection, this shouldn't
> happen.

Gah, misread the splat. The problem is 

     unwind() -> lock() -> lock_acquired() -> unwind() -> lock()

So it's not lockdep calling first. Will resend with a proper
changelog.

Thanks,

	tglx
