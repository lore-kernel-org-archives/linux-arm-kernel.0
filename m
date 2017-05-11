From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 May 2017 13:54:31 +0100
Subject: [PATCHv3 0/2] arm64: fix hotplug rwsem boot fallout
In-Reply-To: <alpine.DEB.2.20.1705111200400.1758@nanos>
References: <1493377266-2205-1-git-send-email-mark.rutland@arm.com>
 <20170510180928.GA7102@leverpostej>
 <alpine.DEB.2.20.1705102208290.2571@nanos>
 <alpine.DEB.2.20.1705110949140.1758@nanos>
 <20170511093721.GB14766@leverpostej>
 <alpine.DEB.2.20.1705111200400.1758@nanos>
Message-ID: <20170511125430.GD14766@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 11, 2017 at 12:01:21PM +0200, Thomas Gleixner wrote:
> On Thu, 11 May 2017, Mark Rutland wrote:
> > On Thu, May 11, 2017 at 10:30:39AM +0200, Thomas Gleixner wrote:
> > > On Wed, 10 May 2017, Thomas Gleixner wrote:
> > > secondary_start_kernel()
> > >   check_local_cpu_capabilities()
> > >     update_cpu_errata_workarounds()
> > >       update_cpu_capabilities()
> > >         static_key_enable()
> > > 	  __static_key_slow_inc()
> > > 	    jump_label_lock()
> > >        	      mutex_lock(&jump_label_mutex);
> > > 
> > > How is that supposed to work?
> > > 
> > > That call path is the low level CPU bringup, running in the context of the
> > > idle task of that CPU with interrupts and preemption disabled. Taking a
> > > mutex in that context, even if in that case the mutex is uncontended, is a
> > > NONO.

> > As an aside, do we have anything that should detect the broken mutex
> > usage? I've been testing kernels with LOCKDEP, PROVE_LOCKING,
> > DEBUG_ATOMIC_SLEEP, and friends, and nothing has complained so far.
> 
> Peter and myself were wondering about that already. No idea why that
> doesn't yell at you.

AFAICT, this happens early enough that system_state is SYSTEM_BOOTING.
In ___might_sleep(), we see this and bail out without a splat.

Thanks,
Mark.
