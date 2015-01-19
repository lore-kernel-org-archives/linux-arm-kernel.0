From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 19 Jan 2015 18:19:15 +0000
Subject: [PATCH] ARM: kprobes: Eliminate test code's use of BX
 instruction on ARMv4 CPUs
In-Reply-To: <20150119172750.GC26493@n2100.arm.linux.org.uk>
References: <1421687930.4201.21.camel@linaro.org>
 <20150119172750.GC26493@n2100.arm.linux.org.uk>
Message-ID: <1421691555.4201.54.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-01-19 at 17:27 +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 19, 2015 at 05:18:50PM +0000, Jon Medhurst (Tixy) wrote:
> > diff --git a/arch/arm/probes/kprobes/test-arm.c b/arch/arm/probes/kprobes/test-arm.c
> > index e72b07e..5c6e37e 100644
> > --- a/arch/arm/probes/kprobes/test-arm.c
> > +++ b/arch/arm/probes/kprobes/test-arm.c
> > @@ -215,9 +215,11 @@ void kprobe_arm_test_cases(void)
> >  	TEST_UNSUPPORTED("msr	cpsr_f, lr")
> >  	TEST_UNSUPPORTED("msr	spsr, r0")
> >  
> > +#if (__LINUX_ARM_ARCH__ >= 5) || defined(CONFIG_CPU_32v4T)
> >  	TEST_BF_R("bx	r",0,2f,"")
> >  	TEST_BB_R("bx	r",7,2f,"")
> >  	TEST_BF_R("bxeq	r",14,2f,"")
> > +#endif
> 
> Unnecessary ()... and this isn't correct.  With a multi-platform kernel, we
> can end up with CONFIG_CPU_32v4 and CONFIG_CPU_32v4T both set.
> 
> I think:
> 
> #if __LINUX_ARM_ARCH__ >= 5 || \
>     (__LINUX_ARM_ARCH__ == 4 && !defined(CONFIG_CPU_32v4))
> 
> would cover it.

Multi-platform kernels in general are problematic, e.g. we have quite a
few

#if __LINUX_ARM_ARCH__ >= 7

which would also need

 && !defined(CONFIG_CPU_32v6) && !defined(CONFIG_CPU_32v6K)

which isn't going to scale well. What's really needed is runtime checks,
and that will also let the test not have to fall back to lowest common
denominator. Implementing that is something I never got around to doing,
and I probably should. We would need to do something like export
cpu_architecture() for module use, what do you think of that?

So, for now, I will fix the compile time tests as you suggest for this
patch, and will look at introducing run-time tests for a wider solution.
That won't be for some weeks yet though.

-- 
Tixy
