From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 May 2017 10:37:21 +0100
Subject: [PATCHv3 0/2] arm64: fix hotplug rwsem boot fallout
In-Reply-To: <alpine.DEB.2.20.1705110949140.1758@nanos>
References: <1493377266-2205-1-git-send-email-mark.rutland@arm.com>
 <20170510180928.GA7102@leverpostej>
 <alpine.DEB.2.20.1705102208290.2571@nanos>
 <alpine.DEB.2.20.1705110949140.1758@nanos>
Message-ID: <20170511093721.GB14766@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 11, 2017 at 10:30:39AM +0200, Thomas Gleixner wrote:
> On Wed, 10 May 2017, Thomas Gleixner wrote:
> > On Wed, 10 May 2017, Mark Rutland wrote:
> > > [    0.182133] [<ffff200008155218>] lockdep_assert_hotplug_held+0x78/0x98
> > > [    0.182161] [<ffff20000840a36c>] __static_key_slow_inc+0x174/0x2e0
> > > [    0.182188] [<ffff20000840a654>] static_key_enable_cpuslocked+0x64/0xb0
> > > [    0.182215] [<ffff2000080a1120>] update_cpu_capabilities+0x178/0x2d8
> > > [    0.182243] [<ffff20000809e72c>] update_cpu_errata_workarounds_cpuslocked+0x1c/0x28
> > > [    0.182270] [<ffff2000080a1420>] check_local_cpu_capabilities+0x1a0/0x248
> > > [    0.182295] [<ffff2000080a2d18>] secondary_start_kernel+0x1e8/0x478
> > > [    0.182317] [<000000008219a1b4>] 0x8219a1b4
> > > [    0.182337] CPU features: enabling workaround for ARM erratum 834220
> > > [    0.182362] ------------[ cut here ]------------
> > > 
> > > The problem is that the secondary CPU doesn't hold the rwsem when it
> > > calls __static_key_slow_inc() in its boot path. It cannot take the
> > > rwsem, since the primaary CPU holds this for the duration of onlining
> > > the secondary CPU.
> 
> Looking deeper into that:
> 
> secondary_start_kernel()
>   check_local_cpu_capabilities()
>     update_cpu_errata_workarounds()
>       update_cpu_capabilities()
>         static_key_enable()
> 	  __static_key_slow_inc()
> 	    jump_label_lock()
>        	      mutex_lock(&jump_label_mutex);
> 
> How is that supposed to work?
> 
> That call path is the low level CPU bringup, running in the context of the
> idle task of that CPU with interrupts and preemption disabled. Taking a
> mutex in that context, even if in that case the mutex is uncontended, is a
> NONO.

Urgh; good point. Thanks for taking a look.

I think I can solve both issues by deferring poking the keys, so I'll
give that a go.

As an aside, do we have anything that should detect the broken mutex
usage? I've been testing kernels with LOCKDEP, PROVE_LOCKING,
DEBUG_ATOMIC_SLEEP, and friends, and nothing has complained so far.

Thanks,
Mark.
