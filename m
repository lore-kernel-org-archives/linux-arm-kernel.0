From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Sep 2016 12:36:15 +0100
Subject: [PATCH v5 3/5] arm64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <1473469413-11019-3-git-send-email-oss@buserror.net>
References: <1473469413-11019-1-git-send-email-oss@buserror.net>
 <1473469413-11019-3-git-send-email-oss@buserror.net>
Message-ID: <20160912113615.GA20804@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The changes in arm64's <asm/arch_timer.h> are going to conflict with
some cleanup [1,2] that just landed in the arm64 for-next/core branch.

Could you please rebase atop of that?

On Fri, Sep 09, 2016 at 08:03:31PM -0500, Scott Wood wrote:
> Erratum A-008585 says that the ARM generic timer counter "has the
> potential to contain an erroneous value for a small number of core
> clock cycles every time the timer value changes".  Accesses to TVAL
> (both read and write) are also affected due to the implicit counter
> read.  Accesses to CVAL are not affected.
> 
> The workaround is to reread TVAL and count registers until successive reads
> return the same value, and when writing TVAL to retry until counter
> reads before and after the write return the same value.

This doesn't match the code, which doesn't seem to write TVAL at all,
and instead does the work manually, reading CNTVCT then writing to CVAL.
Please update the patch description.

[...]

> +extern struct static_key_false arch_timer_read_ool_enabled;
> +
> +#define ARCH_TIMER_REG_READ(reg, func) \
> +extern u64 func##_ool(void); \
> +static inline u64 __##func(void) \
> +{ \
> +	u64 val; \
> +	asm volatile("mrs %0, " reg : "=r" (val)); \
> +	return val; \
> +} \

Following recent cleanup, please use read_sysreg().

> +static inline u64 _##func(void) \
> +{ \
> +	if (IS_ENABLED(CONFIG_FSL_ERRATUM_A008585) && \
> +	    static_branch_unlikely(&arch_timer_read_ool_enabled)) \
> +		return func##_ool(); \
> +	else \
> +		return __##func(); \
> +}
> +
> +ARCH_TIMER_REG_READ("cntp_tval_el0", arch_timer_get_ptval)
> +ARCH_TIMER_REG_READ("cntv_tval_el0", arch_timer_get_vtval)
> +ARCH_TIMER_REG_READ("cntvct_el0", arch_counter_get_cntvct)
> +
> +#undef ARCH_TIMER_REG_READ

Rather than defining a number of inline functions here as wrappers for
read_sysreg(), can we pass the reg name down instead? e.g.

#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585)
extern struct static_key_false arch_timer_read_ool_enabled;
#define needs_fsl_a008585_workaround() \
	static_branch_unlikely(&arch_timer_read_ool_enabled)
#else
#define needs_fsl_a008585_workaround()	false
#endif

#define arch_timer_unstable_reg_read(reg)		\
({							\
	if (needs_fsl_a008585_workaround())		\
		return __fsl_a008585_read_##reg();	\
	else						\
		return read_sysreg(reg);		\
})

... with __fsl_a008585_read_{cntp_tval_el0,cntv_tval_el0,cntvct_el0}
defined appropriately in the driver code.

[...]

> +static __always_inline void arch_timer_cval_write_cp15(int access, u64 val)
> +{
> +	if (access == ARCH_TIMER_PHYS_ACCESS)
> +		asm volatile("msr cntp_cval_el0, %0" : : "r" (val));
> +	else if (access == ARCH_TIMER_VIRT_ACCESS)
> +		asm volatile("msr cntv_cval_el0, %0" : : "r" (val));
> +
> +	isb();
> +}

Please add ARCH_TIMER_REG_CVAL to enum arch_timer_reg, and move these
accesses into arch_timer_reg_write_cp15().

[...]

> +#ifdef CONFIG_FSL_ERRATUM_A008585
> +DEFINE_STATIC_KEY_FALSE(arch_timer_read_ool_enabled);
> +EXPORT_SYMBOL_GPL(arch_timer_read_ool_enabled);
> +
> +/*
> + * __always_inline is used to ensure that func() is not an actual function
> + * pointer, which would result in the register accesses potentially being too
> + * far apart for the loop to work.
> + *
> + * The timeout is an arbitrary value well beyond the highest number
> + * of iterations the loop has been observed to take.
> + */
> +static __always_inline u64 fsl_a008585_reread_counter(u64 (*func)(void))

Please:

* Rename this to __fsl_a008585_read_reg, as it's used for registers
  other than the counters.

* Make this a macro, to which the register name is passed in, such that
  it can use read_sysreg(), as with my suggestion above regarding how to
  restructure the function.

* Move this into the ifdef'd block in the arm64 header, leaving the
  callers where they are in the driver code.

> +{
> +	u64 cval_old, cval_new;

Nit: use 'old' and 'new', so as to not imply that this applies (only) to
CNT{V,P}_CVAL. 

> +	int timeout = 200;

Nit: s/timeout/retries/

> +
> +	do {
> +		isb();

What's the ISB for?

The core should order accesses to the same counter, and any ISB required
for ordering against other counters should already be present. So I
don't follow what this is trying to achieve.

If this is necessary, please add a comment explaining what it is
intended to ensure.

> +		cval_old = func();
> +		cval_new = func();
> +		timeout--;
> +	} while (unlikely(cval_old != cval_new) && timeout);
> +
> +	WARN_ON_ONCE(!timeout);
> +	return cval_new;
> +}
> +
> +u64 arch_counter_get_cntvct_ool(void)
> +{
> +	return fsl_a008585_reread_counter(__arch_counter_get_cntvct);
> +}
> +EXPORT_SYMBOL(arch_counter_get_cntvct_ool);
> +
> +u64 arch_timer_get_vtval_ool(void)
> +{
> +	return fsl_a008585_reread_counter(__arch_timer_get_vtval);
> +}
> +
> +u64 arch_timer_get_ptval_ool(void)
> +{
> +	return fsl_a008585_reread_counter(__arch_timer_get_ptval);
> +}

With the above suggestion, these will need to be renamed to something
like:

	__fsl_a008585_read_{cntvct_el0,cntv_tval_el0,cntp_tval_el0}

[...]

> +#ifdef CONFIG_FSL_ERRATUM_A008585
> +static __always_inline void fsl_a008585_set_next_event(const int access,
> +		unsigned long evt, struct clock_event_device *clk)
> +{
> +	unsigned long ctrl;
> +	u64 cval = evt + arch_counter_get_cntvct();
> +
> +	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
> +	ctrl |= ARCH_TIMER_CTRL_ENABLE;
> +	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
> +	arch_timer_cval_write_cp15(access, cval);
> +	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
> +}
> +
> +static int fsl_a008585_set_next_event_virt(unsigned long evt,
> +					   struct clock_event_device *clk)
> +{
> +	fsl_a008585_set_next_event(ARCH_TIMER_VIRT_ACCESS, evt, clk);
> +	return 0;
> +}
> +
> +static int fsl_a008585_set_next_event_phys(unsigned long evt,
> +					   struct clock_event_device *clk)
> +{
> +	fsl_a008585_set_next_event(ARCH_TIMER_PHYS_ACCESS, evt, clk);
> +	return 0;
> +}
> +#endif /* CONFIG_FSL_ERRATUM_A008585 */
> +
>  static int arch_timer_set_next_event_virt(unsigned long evt,
>  					  struct clock_event_device *clk)
>  {
> @@ -271,6 +346,19 @@ static int arch_timer_set_next_event_phys_mem(unsigned long evt,
>  	return 0;
>  }
>  
> +static void fsl_a008585_set_sne(struct clock_event_device *clk)
> +{
> +#ifdef CONFIG_FSL_ERRATUM_A008585
> +	if (!static_branch_unlikely(&arch_timer_read_ool_enabled))
> +		return;
> +
> +	if (arch_timer_uses_ppi == VIRT_PPI)
> +		clk->set_next_event = fsl_a008585_set_next_event_virt;
> +	else
> +		clk->set_next_event = fsl_a008585_set_next_event_phys;
> +#endif
> +}
> +

I'm not keen on the magic hook to reset the function pointers, and the
additional phys/virt stubs seem pointless. Instead, can we fold this
into the existing set_next_event? e.g. have that do:

	if (needs_fsl_a008585_workaround() {
		fsl_a008585_set_next_event(access, evt, clk);
		return;
	}

... with a stub BUILD_BUG() fsl_a008585_set_next_event() when
!CONFIG_FSL_ERRATUM_A008585, and:

#ifndef needs_fsl_a008585_workaround
#define needs_fsl_a008585_workaround()	false
#endif

... in the driver, so as to not cause issues for 32-bit.

[...]

> +#ifdef CONFIG_FSL_ERRATUM_A008585
> +		/*
> +		 * Don't use the vdso fastpath if errata require using
> +		 * the out-of-line counter accessor.
> +		 */
> +		if (static_branch_unlikely(&arch_timer_read_ool_enabled))
> +			clocksource_counter.name = "arch_sys_counter_ool";

Can we move the next patch before this, and avoid messing with the name
entirely?

[...]

> @@ -800,6 +899,11 @@ static int __init arch_timer_of_init(struct device_node *np)
>  
>  	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
>  
> +#ifdef CONFIG_FSL_ERRATUM_A008585
> +	if (of_property_read_bool(np, "fsl,erratum-a008585"))
> +		static_branch_enable(&arch_timer_read_ool_enabled);
> +#endif

Please log something, e.g.

	pr_info("Enabling workaround for FSL erratum A008585\n");

Thanks,
Mark.

[1] https://git.kernel.org/cgit/linux/kernel/git/mark/linux.git/commit/?h=arm64/read-write-sysreg&id=ad2d624a50b900a3148d74ed8597508bc472c12e
[2] https://git.kernel.org/cgit/linux/kernel/git/mark/linux.git/log/?h=arm64/read-write-sysreg
[3] https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/log/?h=for-next/core
