From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 31 Mar 2016 16:46:35 +0900
Subject: [PATCH v15 17/20] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <56EC440F.4050406@arm.com>
References: <cover.1457977401.git.geoff@infradead.org>
 <8f53a31cf8bbfdd73eb289e078addc31c5a19fcf.1457977403.git.geoff@infradead.org>
 <56EC440F.4050406@arm.com>
Message-ID: <20160331074635.GC2267@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 06:08:15PM +0000, James Morse wrote:
> Hi!
> 
> On 14/03/16 17:48, Geoff Levand wrote:
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > 
> > Primary kernel calls machine_crash_shutdown() to shut down non-boot cpus
> > and save registers' status in per-cpu ELF notes before starting crash
> > dump kernel. See kernel_kexec().
> > Even if not all secondary cpus have shut down, we do kdump anyway.
> > 
> > As we don't have to make non-boot(crashed) cpus offline (to preserve
> > correct status of cpus at crash dump) before shutting down, this patch
> > also adds a variant of smp_send_stop().
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index b1adc51..76402c6cd 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -701,6 +705,28 @@ static void ipi_cpu_stop(unsigned int cpu)
> >  		cpu_relax();
> >  }
> >  
> > +static atomic_t waiting_for_crash_ipi;
> > +
> > +static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
> > +{
> > +	crash_save_cpu(regs, cpu);
> > +
> > +	raw_spin_lock(&stop_lock);
> > +	pr_debug("CPU%u: stopping\n", cpu);
> > +	raw_spin_unlock(&stop_lock);
> > +
> > +	atomic_dec(&waiting_for_crash_ipi);
> > +
> > +	local_irq_disable();
> 
> Aren't irqs already disabled here? - or is this a 'just make sure'....

Well, it also exists in ipi_cpu_stop() ...

> > +
> > +	if (cpu_ops[cpu]->cpu_die)
> > +		cpu_ops[cpu]->cpu_die(cpu);
> > +
> > +	/* just in case */
> > +	while (1)
> > +		wfi();
> > +}
> > +
> >  /*
> >   * Main handler for inter-processor interrupts
> >   */
> > @@ -731,6 +757,12 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
> >  		irq_exit();
> >  		break;
> >  
> > +	case IPI_CPU_CRASH_STOP:
> > +		irq_enter();
> > +		ipi_cpu_crash_stop(cpu, regs);
> > +		irq_exit();
> 
> This made me jump: irq_exit() may end up in the __do_softirq() (with irqs turned
> back on!) ... but these lines are impossible to reach. Maybe get the compiler to
> enforce this with an unreachable() instead?

I'm not sure how effective unreachable() is here, but OK I will add it.

Thanks,
-Takahiro AKASHI

> > +		break;
> > +
> >  #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
> >  	case IPI_TIMER:
> >  		irq_enter();
> > @@ -791,6 +823,30 @@ void smp_send_stop(void)
> >  		pr_warning("SMP: failed to stop secondary CPUs\n");
> >  }
> >  
> > +void smp_send_crash_stop(void)
> > +{
> > +	cpumask_t mask;
> > +	unsigned long timeout;
> > +
> > +	if (num_online_cpus() == 1)
> > +		return;
> > +
> > +	cpumask_copy(&mask, cpu_online_mask);
> > +	cpumask_clear_cpu(smp_processor_id(), &mask);
> > +
> > +	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
> > +
> > +	smp_cross_call(&mask, IPI_CPU_CRASH_STOP);
> > +
> > +	/* Wait up to one second for other CPUs to stop */
> > +	timeout = USEC_PER_SEC;
> > +	while ((atomic_read(&waiting_for_crash_ipi) > 0) && timeout--)
> > +		udelay(1);
> > +
> > +	if (atomic_read(&waiting_for_crash_ipi) > 0)
> > +		pr_warn("SMP: failed to stop secondary CPUs\n");
> > +}
> > +
> >  /*
> >   * not supported here
> >   */
> > 
> 
> 
> Thanks,
> 
> James
> 
> 
