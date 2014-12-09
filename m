From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Tue, 9 Dec 2014 14:31:58 +0800
Subject: [PATCH v5] clocksource: arch_timer: Fix code to use physical
 timers when requested
In-Reply-To: <20141208162140.GN16185@e104818-lin.cambridge.arm.com>
References: <1416812564-26465-1-git-send-email-sonnyrao@chromium.org>
 <1417776064.14380.17.camel@mtksdaap41>
 <20141208162140.GN16185@e104818-lin.cambridge.arm.com>
Message-ID: <1418106718.32622.31.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-12-08 at 16:21 +0000, Catalin Marinas wrote:
> On Fri, Dec 05, 2014 at 10:41:04AM +0000, Yingjoe Chen wrote:
> > On Sun, 2014-11-23 at 23:02 -0800, Sonny Rao wrote: 
> > > This is a bug fix for using physical arch timers when
> > > the arch_timer_use_virtual boolean is false.  It restores the
> > > arch_counter_get_cntpct() function after removal in
> > > 
> > > 0d651e4e "clocksource: arch_timer: use virtual counters"
> > > 
> > > We need this on certain ARMv7 systems which are architected like this:
> > > diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> > > index f190971..b1fa4e6 100644
> > > --- a/arch/arm64/include/asm/arch_timer.h
> > > +++ b/arch/arm64/include/asm/arch_timer.h
> > > @@ -104,6 +104,15 @@ static inline void arch_timer_set_cntkctl(u32 cntkctl)
> > >  	asm volatile("msr	cntkctl_el1, %0" : : "r" (cntkctl));
> > >  }
> > >  
> > > +static inline u64 arch_counter_get_cntpct(void)
> > > +{
> > > +	/*
> > > +	 * AArch64 kernel and user space mandate the use of CNTVCT.
> > > +	 */
> > > +	BUG();
> > > +	return 0;
> > > +}
> > > +
> > >  static inline u64 arch_counter_get_cntvct(void)
> > >  {
> > >  	u64 cval;
> > 
> > I tested this on an arm64 platform and system fail to boot when apply
> > this patch.
> > 
> > The boot loader start kernel at EL2, so is_hyp_mode_available() will be
> > true and we will use physical timer. Without this patch,
> > arch_timer_read_counter set to arch_counter_get_cntvct even when we use
> > physical timer which is incorrect but at least system will boot.
> 
> So on arm64 we want to use CNTVCT all the time, even if we start the
> kernel at EL2. This is the counter that gets exposed to user via vdso.
> When the kernel boots at EL2, we initialise CNTVOFF to 0, so we know
> that CNTVCT == CNTPCT. However, I would still prefer to use CNTVCT even
> in such case to spot possible firmware issues with not restoring CNTVOFF
> when coming out of suspend (one particular case of suspend which does
> not require a different kernel entry point).
> 
> > I think we still need this function on arm64. We should add BUG() to
> > arch_timer_init instead, maybe something like this:
> > 
> > @@ -708,9 +708,12 @@ static void __init arch_timer_init(struct device_node *np)
> >  	 * If we cannot rely on firmware initializing the timer registers then
> >  	 * we should use the physical timers instead.
> >  	 */
> > -	if (IS_ENABLED(CONFIG_ARM) &&
> > -	    of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
> > +	if (of_property_read_bool(np, "arm,cpu-registers-not-fw-configured")) {
> > +		if (IS_ENABLED(CONFIG_ARM64))
> > +			BUG();
> > +		else
> >  			arch_timer_use_virtual = false;
> > +	}
> 
> We could be more tolerant (give people a chance to check their DT):
> 
> 	if (!WARN_ON(IS_ENABLED(CONFIG_ARM64)))
> 		arch_timer_use_virtual = false;
> 
> In addition, we can define arch_counter_get_cntpct to always read CNTVCT
> (not that nice but maybe it looks better with a comment):
> 
> /*
>  * AArch64 kernel and user space mandate the use of CNTVCT.
>  */
> #define arch_counter_get_cntpct	arch_counter_get_cntvct
> 
> (or any better suggestion to avoid reading CNTPCT on arm64)
> 

I'm not sure about this. arch_timer_use_virtual is false, indicate we
are using physical timer, the function name suggest it will read
physical timer, but actually it is reading virtual timer. It sure will
create confusion when one need to debug.

We are using physical timer because arch_timer_init() will check
is_hyp_mode_available(), and use physical timer if it is avaliable. For
arm64, if we want to use virtual timer even in HYP mode, how about this
change:

@@ -720,7 +723,8 @@ static void __init arch_timer_init(struct device_node *np)
         * If no interrupt provided for virtual timer, we'll have to
         * stick to the physical timer. It'd better be accessible...
         */
-       if (is_hyp_mode_available() || !arch_timer_ppi[VIRT_PPI]) {
+       if ((IS_ENABLED(CONFIG_ARM) && is_hyp_mode_available()) ||
+           !arch_timer_ppi[VIRT_PPI]) {
                arch_timer_use_virtual = false;

                if (!arch_timer_ppi[PHYS_SECURE_PPI] ||

Maybe also add some WARN_ON for arm64 here to make sure we never set
arch_timer_use_virtual to false for ARM64.

Joe.C
