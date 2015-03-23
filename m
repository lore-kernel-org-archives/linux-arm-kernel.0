From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Mon, 23 Mar 2015 08:37:42 -0700
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <20150323140041.GQ8656@n2100.arm.linux.org.uk>
References: <20150225125610.GY8656@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1502250941210.25484@knanqh.ubzr>
 <20150225170011.GC8656@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1502251257410.25484@knanqh.ubzr>
 <alpine.LFD.2.11.1502251427580.25484@knanqh.ubzr>
 <20150226010505.GU15405@linux.vnet.ibm.com>
 <20150322233057.GA17605@linux.vnet.ibm.com>
 <20150323125545.GP8656@n2100.arm.linux.org.uk>
 <20150323132133.GD5718@linux.vnet.ibm.com>
 <20150323140041.GQ8656@n2100.arm.linux.org.uk>
Message-ID: <20150323153742.GF5718@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 02:00:41PM +0000, Russell King - ARM Linux wrote:
> On Mon, Mar 23, 2015 at 06:21:33AM -0700, Paul E. McKenney wrote:
> > On Mon, Mar 23, 2015 at 12:55:45PM +0000, Russell King - ARM Linux wrote:
> > > What if the cpu_hotplug_state for the CPU changes between reading it
> > > testing its value, and then writing it, or do we guarantee that it
> > > can't change other than by this function here?  If it can't change,
> > > then what's the point of using atomic_t for this?
> > 
> > It indeed cannot change -here-, but there are other situations where
> > more than one CPU can be attempting to change it at the same time.
> > The reason that it cannot change here is that the variable has the
> > value that indicates that the previous offline completed within the
> > timeout period, so there are no outstanding writes.
> > 
> > When going offline, the outgoing CPU might take so long leaving that
> > the surviving CPU times out, thus both CPUs write to the variable at
> > the same time, which by itself requires atomics.  If this seems
> > unlikely, consider virtualized environments where the hypervisor
> > might preempt the guest OS.
> 
> If two CPUs write using atomic_set() to the same location, what value do
> you end up with?  It's just the same as if two CPUs write normally to the
> same location.

If that happens when using these functions, that is a usage error.

> The only way it can be different is if you use atomic_cmpxchg(), or
> cmpxchg() so you can atomically test that the original value is what's
> expected prior to writing it.
> 
> To illustrate this (I'll abbreviate the per-cpu state):
> 
> 	CPU0					CPU1
> 	oldstate = atomic_read(state);
> 	if (oldstate == CPU_DEAD) /* it isn't */
> 	atomic_cmpxchg(state, oldstate, CPU_BROKEN)
> 						atomic_xchg(state, CPU_DEAD)
> 
> 	/* succeeds */
> 	!= old_state /* fails */
> 	... so doesn't loop
> 	cpu_wait_death() returns false (failed)
> 
> Here, we report that the CPU failed to go offline, but the state is set
> to CPU_DEAD.  If it had been slightly earlier, CPU0 would have updated
> it to CPU_DEAD_POST.

Indeed.  Which is precisely why cpu_check_up_prepare() returns an error
after that timeout occurs.  This allows the arch code to decide what to
do, which might be to reset the CPU in some way.  Or to simply error
out the attempt to online the CPU.

> If we instead got rid of this atomic stuff, and looked at the code
> without atomic_* stuff confusing the picture, we'd probably have seen
> that.  This is why, whenever I see atomic_read() and atomic_set(), I'm
> very suspicious that the code is correct; virtually every time I've
> seen this pattern, the code has always had some problem.  I utterly
> hate code which uses these functions.

They do have their uses, including this case.

> So, I'd suggest getting rid of atomic_read() and atomic_set() here
> converting atomic_cmpxchg() to a plain cmpxchg(), and replacing that
> atomic_xchg() with a similar call to cmpxchg() so that a broken CPU
> doesn't confusingly end up being reported as broken yet getting a
> CPU_DEAD state.

And exactly how would that help?  You have all the same issues with this
transformed version of the code.  You just have READ_ONCE() instead of
atomic_read() and WRITE_ONCE() instead of atomic_set().  Or you have
bare accesses that the compiler might well be able to optimize into
nonsensical code.  Again, how does this help?

> After all, we know that a CPU going down _should_ be online before it
> goes down - if it isn't online, how can it be executing code. :)

That is indeed one scenario.

Another scenario is that the CPU failed to go down promptly during a
previous offline operation, and the arch-specific code chose to ignore
that error when the CPU was next brought online.  In this case, at the
next offline, this code would se CPU_DEAD_FROZEN or CPU_BROKEN instead
of CPU_ONLINE.  And there are architectures that do just this.

							Thanx, Paul
