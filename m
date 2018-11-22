From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Nov 2018 14:14:29 +0000
Subject: [PATCH v2 1/1] arm64: Early boot time stamps
In-Reply-To: <20181121175841.if3vyumzvw3yoovi@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <20181120144340.30201-1-pasha.tatashin@soleen.com>
 <20181120144340.30201-2-pasha.tatashin@soleen.com>
 <20181121174706.GC9801@arm.com>
 <20181121175841.if3vyumzvw3yoovi@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
Message-ID: <86lg5lrygq.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Nov 2018 17:58:41 +0000,
Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
> 
> On 18-11-21 17:47:07, Will Deacon wrote:
> > > +	/*
> > > +	 * The arm64 boot protocol mandates that CNTFRQ_EL0 reflects
> > > +	 * the timer frequency. To avoid breakage on misconfigured
> > > +	 * systems, do not register the early sched_clock if the
> > > +	 * programmed value if zero. Other random values will just
> > > +	 * result in random output.
> > > +	 */
> > > +	if (!freq)
> > > +		return;
> > > +
> > > +	arch_timer_read_counter = arch_counter_get_cntvct;
> > 
> > Why do you need to assign this here?
> > 
> > > +	sched_clock_register(arch_timer_read_counter, ARCH_TIMER_NBITS, freq);
> > 
> > arch_timer_read_counter can be reassigned once the arm_arch_timer driver
> > has probed; what stops this from being unused as the sched_clock after that
> > has happened? I worry that toggling the function pointer could lead to
> > sched_clock() going backwards.
> 
> No reason, I will revert it back to use a local variable.

I think the issue is that you are doing an assignment for something
that the kernel has already statically initialized.

> I agree, time can go backward for a period of time while we switch
> to permanent clock later, if that clock is different.

It is worse than that. You're setting up sched_clock with an
unreliable clock source which can go backward at any point, not just
at handover time.

I'd rather we have the timestamping code be able to use another souce
than sched_clock, and eventually switch to it once sched_clock is
registered (and properly corrected.

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
