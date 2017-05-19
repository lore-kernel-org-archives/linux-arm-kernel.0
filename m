From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 19 May 2017 14:13:21 +0100
Subject: [RFC PATCH] arm64: neon: Remove support for nested or hardirq
 kernel-mode NEON
In-Reply-To: <20170519124952.GB22800@leverpostej>
References: <1495193199-1291-1-git-send-email-Dave.Martin@arm.com>
 <20170519124952.GB22800@leverpostej>
Message-ID: <20170519131321.GD3559@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 01:49:53PM +0100, Mark Rutland wrote:
> Hi,
> 
> On Fri, May 19, 2017 at 12:26:39PM +0100, Dave Martin wrote:
> > +static bool __maybe_unused kernel_neon_allowed(void)
> > +{
> > +	/*
> > +	 * The per_cpu_ptr() is racy if called with preemption enabled.
> > +	 * This is not a bug:  per_cpu(kernel_neon_busy) is only set
> > +	 * when preemption is disabled, so we cannot migrate to another
> > +	 * CPU while it is set, nor can we migrate to a CPU where it is set.
> > +	 * So, if we find it clear on some CPU then we're guaranteed to find it
> > +	 * clear on any CPU we could migrate to.
> > +	 *
> > +	 * If we are in between kernel_neon_begin()...kernel_neon_end(), the
> > +	 * flag will be set, but preemption is also disabled, so we can't
> > +	 * migrate to another CPU and spuriously see it become false.
> > +	 */
> > +	return !(in_irq() || in_nmi()) &&
> > +		!local_read(this_cpu_ptr(&kernel_neon_busy));
> > +}
> 
> I think it would be better to use the this_cpu ops for this, rather than
> manually messing with the pointer.

I had thought that the properties of local_t were important here, but
this_cpu ops seem equally appropriate.

> Here, we can use raw_cpu_read(kernel_neon_busy), given the comment
> above.

What's the difference?  The raw_ variants aren't documented.  Do these
not bother about atomicity between the address calculation and the read?

> [...]
> 
> > +DEFINE_PER_CPU(local_t, kernel_neon_busy);
> 
> This can become a basic type like int or bool.

Agreed -- probably bool, given how it's used.

> [...]
> 
> > +void kernel_neon_begin(void)
> >  {
> >  	if (WARN_ON(!system_supports_fpsimd()))
> >  		return;
> > -	if (in_interrupt()) {
> > -		struct fpsimd_partial_state *s = this_cpu_ptr(
> > -			in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
> >  
> > -		BUG_ON(num_regs > 32);
> > -		fpsimd_save_partial_state(s, roundup(num_regs, 2));
> > -	} else {
> > -		/*
> > -		 * Save the userland FPSIMD state if we have one and if we
> > -		 * haven't done so already. Clear fpsimd_last_state to indicate
> > -		 * that there is no longer userland FPSIMD state in the
> > -		 * registers.
> > -		 */
> > -		preempt_disable();
> > -		if (current->mm &&
> > -		    !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
> > -			fpsimd_save_state(&current->thread.fpsimd_state);
> > +	BUG_ON(!kernel_neon_allowed());
> > +
> > +	preempt_disable();
> > +	local_set(this_cpu_ptr(&kernel_neon_busy), 1);
> 
> As preemption is disabled:
> 
> 	__this_cpu_write(kernel_neon_busy, 1);
> 
> [...]
> 
> >  void kernel_neon_end(void)
> >  {
> > +	long busy;
> > +
> >  	if (!system_supports_fpsimd())
> >  		return;
> > -	if (in_interrupt()) {
> > -		struct fpsimd_partial_state *s = this_cpu_ptr(
> > -			in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
> > -		fpsimd_load_partial_state(s);
> > -	} else {
> > -		preempt_enable();
> > -	}
> > +
> > +	busy = local_xchg(this_cpu_ptr(&kernel_neon_busy), 0);
> 
> Likewise:
> 
> 	busy = __this_cpu_xchg(kernel_neon_busy, 0);

Yup.  Will tweak.

Cheers
---Dave
