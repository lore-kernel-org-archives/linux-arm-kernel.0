From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 20 Sep 2016 16:36:35 +0900
Subject: [PATCH v26 2/7] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <57DC067B.3050003@arm.com>
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <20160907042908.6232-3-takahiro.akashi@linaro.org>
 <57D9925D.5000508@arm.com> <20160915114815.GK16712@linaro.org>
 <57DC067B.3050003@arm.com>
Message-ID: <20160920073634.GC30248@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 03:49:31PM +0100, James Morse wrote:
> On 16/09/16 04:21, AKASHI Takahiro wrote:
> > On Wed, Sep 14, 2016 at 07:09:33PM +0100, James Morse wrote:
> >> On 07/09/16 05:29, AKASHI Takahiro wrote:
> >>> Primary kernel calls machine_crash_shutdown() to shut down non-boot cpus
> >>> and save registers' status in per-cpu ELF notes before starting crash
> >>> dump kernel. See kernel_kexec().
> >>> Even if not all secondary cpus have shut down, we do kdump anyway.
> >>>
> >>> As we don't have to make non-boot(crashed) cpus offline (to preserve
> >>> correct status of cpus at crash dump) before shutting down, this patch
> >>> also adds a variant of smp_send_stop().
> 
> >>> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> >>> index 04744dc..a908958 100644
> >>> --- a/arch/arm64/include/asm/kexec.h
> >>> +++ b/arch/arm64/include/asm/kexec.h
> >>> @@ -40,7 +40,46 @@
> >>>  static inline void crash_setup_regs(struct pt_regs *newregs,
> >>>  				    struct pt_regs *oldregs)
> >>>  {
> >>> -	/* Empty routine needed to avoid build errors. */
> >>> +	if (oldregs) {
> >>> +		memcpy(newregs, oldregs, sizeof(*newregs));
> >>> +	} else {
> >>> +		u64 tmp1, tmp2;
> >>> +
> >>> +		__asm__ __volatile__ (
> >>> +			"stp	 x0,   x1, [%2, #16 *  0]\n"
> >>> +			"stp	 x2,   x3, [%2, #16 *  1]\n"
> >>> +			"stp	 x4,   x5, [%2, #16 *  2]\n"
> >>> +			"stp	 x6,   x7, [%2, #16 *  3]\n"
> >>> +			"stp	 x8,   x9, [%2, #16 *  4]\n"
> >>> +			"stp	x10,  x11, [%2, #16 *  5]\n"
> >>> +			"stp	x12,  x13, [%2, #16 *  6]\n"
> >>> +			"stp	x14,  x15, [%2, #16 *  7]\n"
> >>> +			"stp	x16,  x17, [%2, #16 *  8]\n"
> >>> +			"stp	x18,  x19, [%2, #16 *  9]\n"
> >>> +			"stp	x20,  x21, [%2, #16 * 10]\n"
> >>> +			"stp	x22,  x23, [%2, #16 * 11]\n"
> >>> +			"stp	x24,  x25, [%2, #16 * 12]\n"
> >>> +			"stp	x26,  x27, [%2, #16 * 13]\n"
> >>> +			"stp	x28,  x29, [%2, #16 * 14]\n"
> >>> +			"mov	 %0,  sp\n"
> >>> +			"stp	x30,  %0,  [%2, #16 * 15]\n"
> >>> +
> >>> +			"/* faked current PSTATE */\n"
> >>> +			"mrs	 %0, CurrentEL\n"
> >>> +			"mrs	 %1, DAIF\n"
> >>> +			"orr	 %0, %0, %1\n"
> >>> +			"mrs	 %1, NZCV\n"
> >>> +			"orr	 %0, %0, %1\n"
> >>> +
> >>
> >> What about SPSEL? While we don't use it, it is correctly preserved for
> >> everything except a CPU that calls panic()...
> > 
> > My comment above might be confusing, but what I want to fake
> > here is "spsr" as pt_regs.pstate is normally set based on spsr_el1.
> > So there is no corresponding field of SPSEL in spsr.
> 
> Here is my logic, I may have missed something obvious, see what you think:
> 
> SPSR_EL{1,2} shows the CPU mode 'M' in bits 0-4, From aarch64 bit 4 is always 0.
> From the register definitions in the ARM-ARM C5.2, likely values in 0-3 are:
> 0100 EL1t
> 0101 EL1h
> 1000 EL2t
> 1001 EL2h
> 
> I'm pretty sure this least significant bit is what SPSEL changes, so it does get
> implicitly recorded in SPSR.
> CurrentEL returns a value in bits 0-3, of which 0-1 are RES0, so we lose the
> difference between EL?t and EL?h.

OK.
SPSel will be added assuming that CurrentEL is never 0 here.

> 
> > 
> >>
> >>> +			/* pc */
> >>> +			"adr	 %1, 1f\n"
> >>> +		"1:\n"
> >>> +			"stp	 %1, %0,   [%2, #16 * 16]\n"
> >>> +			: "=r" (tmp1), "=r" (tmp2), "+r" (newregs)
> >>> +			:
> >>> +			: "memory"
> 
> Do you need the memory clobber? This asm only modifies values in newregs.

What about this (including the change above):
|                       "/* faked current PSTATE */\n"
|                       "mrs     %0, CurrentEL\n"
|                       "mrs     %1, SPSEL\n"
|                       "orr     %0, %0, %1\n"
|                       "mrs     %1, DAIF\n"
|                       "orr     %0, %0, %1\n"
|                       "mrs     %1, NZCV\n"
|                       "orr     %0, %0, %1\n"
|                       /* pc */
|                       "adr     %1, 1f\n"
|               "1:\n"
|                       "stp     %1, %0,   [%2, #16 * 16]\n"
|                       : "+r" (tmp1), "+r" (tmp2)
|                       : "r" (newregs)
|                       : "memory"


> 
> >>> +		);
> >>> +	}
> >>>  }
> >>>  
> >>>  #endif /* __ASSEMBLY__ */
> 
> 
> >>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> 
> >>> +#ifdef CONFIG_KEXEC_CORE
> >>> +void smp_send_crash_stop(void)
> >>> +{
> >>> +	cpumask_t mask;
> >>> +	unsigned long timeout;
> >>> +
> >>> +	if (num_online_cpus() == 1)
> >>> +		return;
> >>> +
> >>> +	cpumask_copy(&mask, cpu_online_mask);
> >>> +	cpumask_clear_cpu(smp_processor_id(), &mask);
> >>> +
> >>> +	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
> >>> +
> >>> +	pr_crit("SMP: stopping secondary CPUs\n");
> >>> +	smp_cross_call(&mask, IPI_CPU_CRASH_STOP);
> >>> +
> >>> +	/* Wait up to one second for other CPUs to stop */
> >>> +	timeout = USEC_PER_SEC;
> >>> +	while ((atomic_read(&waiting_for_crash_ipi) > 0) && timeout--)
> >>> +		udelay(1);
> >>> +
> >>> +	if (atomic_read(&waiting_for_crash_ipi) > 0)
> >>> +		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
> >>> +			   cpumask_pr_args(cpu_online_mask));
> >>> +}
> >>> +#endif
> >>
> >> This is very similar to smp_send_stop() which also has the timeout. Is it
> >> possible to merge them? You could use in_crash_kexec to choose the IPI type.
> > 
> > Yeah, we could merge them along with ipi_cpu_(crash_)stop().
> > But the resulting code would be quite noisy if each line
> > is switched by "if (in_crash_kexec)."
> > Otherwise, we may have one big "if" like:
> > void smp_send_stop(void)
> > {
> >     if (in_crash_kexec)
> >         ...
> >     else
> >         ...
> > }
> > It seems to me that it is not much different from the current code.
> > What do you think?
> 
> Hmm, yes, its too fiddly to keep the existing behaviour of both.
> 
> The problems are ipi_cpu_stop() doesn't call cpu_die(), (I can't see a good
> reason for this, but more archaeology is needed), and ipi_cpu_crash_stop()
> doesn't modify the online cpu mask.
> 
> I don't suggest we do this yet, but it could be future cleanup if it's proved to
> be safe:
> smp_send_stop() is only called from:  machine_halt(), machine_power_off(),
> machine_restart() and panic(). In all those cases the CPUs are never expected to
> come back, so we can probably merge the IPIs.  This involves modifying the
> online cpu mask during kdump, (which I think is fine as it uses the atomic
> bitops so we won't get blocked on a lock), and promoting in_crash_kexec to some
> atomic type.
> 
> But I think we should leave it as it is for now,

Sure.

Thanks,
-Takahiro AKASHI

> 
> Thanks,
> 
> James
> 
