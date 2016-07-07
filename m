From: dingtianhong@huawei.com (Ding Tianhong)
Date: Thu, 7 Jul 2016 19:37:22 +0800
Subject: [PATCH v3 3/3] arm64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <577E25A4.2010800@arm.com>
References: <1467412897-15220-1-git-send-email-oss@buserror.net>
 <1467412897-15220-3-git-send-email-oss@buserror.net>
 <577E2226.3020902@huawei.com> <577E25A4.2010800@arm.com>
Message-ID: <577E3EF2.9080105@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/7/7 17:49, Marc Zyngier wrote:
> On 07/07/16 10:34, Ding Tianhong wrote:
>> On 2016/7/2 6:41, Scott Wood wrote:
>>> Erratum A-008585 says that the ARM generic timer counter "has the
>>> potential to contain an erroneous value for a small number of core
>>> clock cycles every time the timer value changes".  Accesses to TVAL
>>> (both read and write) are also affected due to the implicit counter
>>> read.  Accesses to CVAL are not affected.
>>>
>>> The workaround is to reread TVAL and count registers until successive reads
>>> return the same value, and when writing TVAL to retry until counter
>>> reads before and after the write return the same value.
>>>
>>> This erratum can be found on LS1043A and LS2080A.
>>>
>>> Signed-off-by: Scott Wood <oss@buserror.net>
>>> ---
>>> v3:
>>> - Used cval rather than a loop for the write side of the erratum
>>> - Added a Kconfig control
>>> - Moved the device tree binding into its own patch
>>> - Added erratum to silicon-errata.txt
>>> - Changed function names to contain the erratum name
>>> - Factored out the setting of erratum versions of set_next_event
>>>   to improve readability
>>> - Added a comment clarifying that the timeout is arbitrary
>>>
>>> v2:
>>> Significant rework based on feedback, including using static_key,
>>> disabling VDSO counter access rather than adding the workaround to the
>>> VDSO, and uninlining the loops.
>>>
>>> Dropped the separate property for indicating that writes to TVAL are
>>> affected, as I believe that's just a side effect of the implicit
>>> counter read being corrupted, and thus a chip that is affected by one
>>> will always be affected by the other.
>>>
>>> Dropped the arm32 portion as it seems there was confusion about whether
>>> LS1021A is affected.  Currently I am being told that it is not
>>> affected.
>>>
>>> I considered writing to CVAL rather than looping on TVAL writes, but
>>> that would still have required separate set_next_event() code for the
>>> erratum, and adding CVAL to the enum would have required a bunch of
>>> extra handlers in switch statements (even where unused, due to compiler
>>> warnings about unhandled enum values) including in an arm32 header.  It
>>> seemed better to avoid the arm32 interaction and new untested
>>> accessors.
>>> ---
>>>  Documentation/arm64/silicon-errata.txt |   2 +
>>>  arch/arm64/include/asm/arch_timer.h    |  48 ++++++++++++---
>>>  drivers/clocksource/Kconfig            |  10 ++++
>>>  drivers/clocksource/arm_arch_timer.c   | 103 +++++++++++++++++++++++++++++++++
>>>  4 files changed, 154 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
>>> index ba4b6ac..5778f62 100644
>>> --- a/Documentation/arm64/silicon-errata.txt
>>> +++ b/Documentation/arm64/silicon-errata.txt
>>> @@ -57,3 +57,5 @@ stable kernels.
>>>  | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375    |
>>>  | Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154    |
>>>  | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456    |
>>> +|                |                 |                 |                         |
>>> +| Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585     |
>>> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
>>> index fbe0ca3..70fbad9 100644
>>> --- a/arch/arm64/include/asm/arch_timer.h
>>> +++ b/arch/arm64/include/asm/arch_timer.h
>>> @@ -23,10 +23,34 @@
>>>  
>>>  #include <linux/bug.h>
>>>  #include <linux/init.h>
>>> +#include <linux/jump_label.h>
>>>  #include <linux/types.h>
>>>  
>>>  #include <clocksource/arm_arch_timer.h>
>>>  
>>> +extern struct static_key_false arch_timer_read_ool_enabled;
>>> +
>>> +#define ARCH_TIMER_REG_READ(reg, func) \
>>> +extern u64 func##_ool(void); \
>>> +static inline u64 __##func(void) \
>>> +{ \
>>> +	u64 val; \
>>> +	asm volatile("mrs %0, " reg : "=r" (val)); \
>>> +	return val; \
>>> +} \
>>> +static inline u64 _##func(void) \
>>> +{ \
>>> +	if (IS_ENABLED(CONFIG_FSL_ERRATUM_A008585) && \
>>> +	    static_branch_unlikely(&arch_timer_read_ool_enabled)) \
>>> +		return func##_ool(); \
>>> +	else \
>>> +		return __##func(); \
>>> +}
>>> +
>>> +ARCH_TIMER_REG_READ("cntp_tval_el0", arch_timer_get_ptval)
>>> +ARCH_TIMER_REG_READ("cntv_tval_el0", arch_timer_get_vtval)
>>> +ARCH_TIMER_REG_READ("cntvct_el0", arch_counter_get_cntvct)
>>> +
>>>  /*
>>>   * These register accessors are marked inline so the compiler can
>>>   * nicely work out which register we want, and chuck away the rest of
>>> @@ -58,6 +82,16 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
>>>  	isb();
>>>  }
>>>  
>>> +static __always_inline void arch_timer_cval_write_cp15(int access, u64 val)
>>> +{
>>> +	if (access == ARCH_TIMER_PHYS_ACCESS)
>>> +		asm volatile("msr cntp_cval_el0, %0" : : "r" (val));
>>> +	else if (access == ARCH_TIMER_VIRT_ACCESS)
>>> +		asm volatile("msr cntv_cval_el0, %0" : : "r" (val));
>>> +
>>> +	isb();
>>> +}
>>> +
>>>  static __always_inline
>>>  u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
>>>  {
>>> @@ -66,19 +100,19 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
>>>  	if (access == ARCH_TIMER_PHYS_ACCESS) {
>>>  		switch (reg) {
>>>  		case ARCH_TIMER_REG_CTRL:
>>> -			asm volatile("mrs %0,  cntp_ctl_el0" : "=r" (val));
>>> +			asm volatile("mrs %0, cntp_ctl_el0" : "=r" (val));
>>>  			break;
>>>  		case ARCH_TIMER_REG_TVAL:
>>> -			asm volatile("mrs %0, cntp_tval_el0" : "=r" (val));
>>> +			val = _arch_timer_get_ptval();
>>>  			break;
>>>  		}
>>>  	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
>>>  		switch (reg) {
>>>  		case ARCH_TIMER_REG_CTRL:
>>> -			asm volatile("mrs %0,  cntv_ctl_el0" : "=r" (val));
>>> +			asm volatile("mrs %0, cntv_ctl_el0" : "=r" (val));
>>>  			break;
>>>  		case ARCH_TIMER_REG_TVAL:
>>> -			asm volatile("mrs %0, cntv_tval_el0" : "=r" (val));
>>> +			val = _arch_timer_get_vtval();
>>>  			break;
>>>  		}
>>>  	}
>>> @@ -116,12 +150,8 @@ static inline u64 arch_counter_get_cntpct(void)
>>>  
>>>  static inline u64 arch_counter_get_cntvct(void)
>>>  {
>>> -	u64 cval;
>>> -
>>>  	isb();
>>> -	asm volatile("mrs %0, cntvct_el0" : "=r" (cval));
>>> -
>>> -	return cval;
>>> +	return _arch_counter_get_cntvct();
>>>  }
>>>  
>>>  static inline int arch_timer_arch_init(void)
>>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>>> index c346be6..672ddc3 100644
>>> --- a/drivers/clocksource/Kconfig
>>> +++ b/drivers/clocksource/Kconfig
>>> @@ -207,6 +207,16 @@ config ARM_ARCH_TIMER_EVTSTREAM
>>>  	  This must be disabled for hardware validation purposes to detect any
>>>  	  hardware anomalies of missing events.
>>>  
>>> +config FSL_ERRATUM_A008585
>>> +	bool "Workaround for Freescale/NXP Erratum A-008585"
>>> +	default y
>>> +	depends on ARM_ARCH_TIMER && ARM64
>>> +	help
>>> +	  This option enables a workaround for Freescale/NXP Erratum
>>> +	  A-008585 ("ARM generic timer may contain an erroneous
>>> +	  value").  The workaround will only be active if the
>>> +	  fsl,erratum-a008585 property is found in the timer node.
>>> +
>>>  config ARM_GLOBAL_TIMER
>>>  	bool
>>>  	select CLKSRC_OF if OF
>>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>>> index 5152b38..7ead4eb 100644
>>> --- a/drivers/clocksource/arm_arch_timer.c
>>> +++ b/drivers/clocksource/arm_arch_timer.c
>>> @@ -83,6 +83,51 @@ static bool arch_timer_mem_use_virtual;
>>>   * Architected system timer support.
>>>   */
>>>  
>>> +#ifdef CONFIG_FSL_ERRATUM_A008585
>>> +DEFINE_STATIC_KEY_FALSE(arch_timer_read_ool_enabled);
>>> +EXPORT_SYMBOL_GPL(arch_timer_read_ool_enabled);
>>> +
>>> +/*
>>> + * __always_inline is used to ensure that func() is not an actual function
>>> + * pointer, which would result in the register accesses potentially being too
>>> + * far apart for the loop to work.
>>> + *
>>> + * The timeout is an arbitrary value well beyond the highest number
>>> + * of iterations the loop has been observed to take.
>>> + */
>>> +static __always_inline u64 fsl_a008585_reread_counter(u64 (*func)(void))
>>> +{
>>> +	u64 cval_old, cval_new;
>>> +	int timeout = 200;
>>> +
>>> +	do {
>>> +		isb();
>>> +		cval_old = func();
>>> +		cval_new = func();
>>> +		timeout--;
>>> +	} while (unlikely(cval_old != cval_new) && timeout);
>>> +
>>> +	WARN_ON_ONCE(!timeout);
>>> +	return cval_new;
>>> +}
>> Hi Scott:
>>
>> I have test this patch, this solution looks will break the performance a little more than I expected.
>> it will have more than 10% that the cval will read again, we could sure that the cval_old always equal to the
>> cval_new in the normal circumstances, so I prefer this way:
>>
>> 	do {
>> 		isb();
>> 		cval_old = func();
>> 		cval_new = func();
>> 		timeout--;	
>> 	} while (unlikely((cval_new - cval_old) >> 2) && timeout);
> 
> What makes you think that ignoring the two bottom bits is a safe thing
> to do? Talking about performance when the HW has such a dramatic bug is
> like putting a bigger engine on a car that has no brakes: you just hit
> the wall quicker.
> 
> Thanks,
> 

I have a chip which has the same problem like Scott's chip, and I wish to solve this problem in the same way, 
our chip designer told me that if you got a wrong value from the cntvct_el0, you would not get a wrong value
until 8 cycles later, so I could ignoring the lowest 3 bits if I reading twice together.

The key problem is the probability of this bug, my chip has 1/100000 chance to met this bug, so use 10% performance
to fix this bug looks more expensive.

Thanks.
Ding

> 	M.
> 
