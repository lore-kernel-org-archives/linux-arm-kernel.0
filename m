From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 17 May 2011 16:20:21 +0200
Subject: [PATCH] arm: Use arch_spin_lock for unwind to avoid lockdep
	deadlock
In-Reply-To: <alpine.LFD.2.02.1105171605080.3078@ionos>
References: <alpine.LFD.2.02.1105171605080.3078@ionos>
Message-ID: <1305642021.2466.5799.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-05-17 at 16:11 +0200, Thomas Gleixner wrote:
> When lockdep traces a lock taken in a module the arm unwinder takes
> unwind_lock which causes a recursive lockdep call deadlocking itself
> on the unwind_lock.
> 
> Make unwind_lock an arch_spin_lock to avoid the lockdep call and use
> the raw_local_irq_save/restore() variants to avoid irq tracing as
> well. 

That doesn't parse, lockdep has recursion protection, this shouldn't
happen.
