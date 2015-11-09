From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 Nov 2015 17:10:13 +0100
Subject: [PATCH 3/3] xen/arm: set the system time in Xen via the
 XENPF_settime hypercall
In-Reply-To: <alpine.DEB.2.02.1511061510190.23825@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511051706560.13541@kaball.uk.xensource.com>
 <6188457.uvvdcZaVNM@wuerfel>
 <alpine.DEB.2.02.1511061510190.23825@kaball.uk.xensource.com>
Message-ID: <22638556.UuzKE0hp21@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 November 2015 14:10:22 Stefano Stabellini wrote:
> On Thu, 5 Nov 2015, Arnd Bergmann wrote:
> > On Thursday 05 November 2015 17:09:45 Stefano Stabellini wrote:
> > > +	now = __current_kernel_time();
> > 
> > We don't have __current_kernel_time64() yet, but it is trivial
> > to add, just follow the example of
> > current_kernel_time()/current_kernel_time64() and convert the
> > existing __current_kernel_time() function into a static
> > inline wrapper for the new __current_kernel_time64().
> 
> All right. I guess something like:
> 
> struct timespec64 __current_kernel_time64(void)
> {
> 	struct timekeeper *tk = &tk_core.timekeeper;
> 
> 	return tk_xtime(tk);
> }

Yes, exactly.

Just to make sure that this is actually the correct interface
that you want to call:

__current_kernel_time{,64}() is the fastest interface we have
to get an approximation of the current time, while ignoring
all of the locking.

Is is possible that you instead want ktime_get_real_ts64(),
which gives you the time as precise as the kernel knows it,
but uses locking?

> > > +	/*
> > > +	 * We only take the expensive HV call when the clock was set
> > > +	 * or when the 11 minutes RTC synchronization time elapsed.
> > > +	 */
> > > +	if (!was_set && timespec_compare(&now, &next_sync) < 0)
> > > +		return NOTIFY_OK;
> > > +
> > > +	op.interface_version = XENPF_INTERFACE_VERSION;
> > > +	op.cmd = XENPF_settime;
> > > +	op.u.settime.secs = now.tv_sec;
> > > +	op.u.settime.nsecs = now.tv_nsec;
> > > +	op.u.settime.system_time = arch_timer_read_counter();
> > > +	printk("GTOD: Setting to %ld.%ld at %lld\n",
> > > +	       (long)op.u.settime.secs,
> > > +	       (long)op.u.settime.nsecs,
> > > +	       (long long)op.u.settime.system_time);
> > > +	(void)HYPERVISOR_dom0_op(&op);
> > 
> > I guess we will also need a XENPF_settime64 interface, but at
> > least we can get away with implementing only that one on ARM,
> > while x86 will have to support both the 32-bit and 64-bit
> > based variant.
> 
> We already have XENPF_settime64, I'll just use it instead.

Ok, great! Then we just need to find a volunteer who can
do the same thing on x86, with the fallback to XENPF_settime
that they need for older hosts.

	Arnd
