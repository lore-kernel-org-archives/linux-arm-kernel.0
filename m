From: larry.bassel@linaro.org (Larry Bassel)
Date: Mon, 12 May 2014 08:38:48 -0700
Subject: [PATCH v2] arm64: Support arch_irq_work_raise() via self IPIs
In-Reply-To: <20140512092956.GB914@arm.com>
References: <1399760621-10954-1-git-send-email-larry.bassel@linaro.org>
 <20140512092956.GB914@arm.com>
Message-ID: <20140512153848.GA13068@linaro6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 14 10:29, Will Deacon wrote:
> On Sat, May 10, 2014 at 11:23:41PM +0100, Larry Bassel wrote:
> > Support for arch_irq_work_raise() was missing from
> > arm64 (a prerequisite for FULL_NOHZ).
> 
> [...]
> 
> > @@ -455,6 +457,14 @@ void arch_send_call_function_single_ipi(int cpu)
> >  	smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC_SINGLE);
> >  }
> >  
> > +#ifdef CONFIG_IRQ_WORK
> > +void arch_irq_work_raise(void)
> > +{
> > +	if (is_smp())
> > +		smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
> > +}
> > +#endif
> 
> Does this even compile? We're probably better off just checking whether or
> not smp_cross_call is NULL.

No it doesn't (I incorrectly assumed that is_smp() was generic, not
arm32 specific and so I didn't compile this before submitting).

I've verified that your suggestion compiles and runs properly
and will resubmit.

Thanks for catching this.

> 
> Will

Larry
