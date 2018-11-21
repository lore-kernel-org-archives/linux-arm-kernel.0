From: pasha.tatashin@soleen.com (Pavel Tatashin)
Date: Wed, 21 Nov 2018 17:58:41 +0000
Subject: [PATCH v2 1/1] arm64: Early boot time stamps
In-Reply-To: <20181121174706.GC9801@arm.com>
References: <20181120144340.30201-1-pasha.tatashin@soleen.com>
 <20181120144340.30201-2-pasha.tatashin@soleen.com>
 <20181121174706.GC9801@arm.com>
Message-ID: <20181121175841.if3vyumzvw3yoovi@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18-11-21 17:47:07, Will Deacon wrote:
> > +	/*
> > +	 * The arm64 boot protocol mandates that CNTFRQ_EL0 reflects
> > +	 * the timer frequency. To avoid breakage on misconfigured
> > +	 * systems, do not register the early sched_clock if the
> > +	 * programmed value if zero. Other random values will just
> > +	 * result in random output.
> > +	 */
> > +	if (!freq)
> > +		return;
> > +
> > +	arch_timer_read_counter = arch_counter_get_cntvct;
> 
> Why do you need to assign this here?
> 
> > +	sched_clock_register(arch_timer_read_counter, ARCH_TIMER_NBITS, freq);
> 
> arch_timer_read_counter can be reassigned once the arm_arch_timer driver
> has probed; what stops this from being unused as the sched_clock after that
> has happened? I worry that toggling the function pointer could lead to
> sched_clock() going backwards.

No reason, I will revert it back to use a local variable. I agree, time
can go backward for a period of time while we switch to permanent clock later,
if that clock is different. 

> 
> > +}
> > +
> >  void __init setup_arch(char **cmdline_p)
> >  {
> > +	sched_clock_early_init();
> > +
> >  	init_mm.start_code = (unsigned long) _text;
> >  	init_mm.end_code   = (unsigned long) _etext;
> >  	init_mm.end_data   = (unsigned long) _edata;
> 
> The patch from this point onwards just looks like a refactoring to me which
> should be independent of adding early printk timestamps. Also, it doesn't
> update the vdso logic, which hardwires a 56-bit mask for the counter values.

OK, I will split the patch, and will also address the hard coded value
here:

https://soleen.com/source/xref/linux/arch/arm64/kernel/vdso/gettimeofday.S?r=c80ed088#73

Are there more that you know of?

Thank you,
Pasha
