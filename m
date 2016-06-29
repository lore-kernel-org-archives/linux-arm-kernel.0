From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 29 Jun 2016 16:11:15 +0800
Subject: [PATCH v2 1/2] ARM64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <20160513112441.200f4349@arm.com>
References: <1463114260-8724-1-git-send-email-oss@buserror.net>
 <20160513112441.200f4349@arm.com>
Message-ID: <577382A3.7080509@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/5/13 18:24, Marc Zyngier wrote:
> On Thu, 12 May 2016 23:37:39 -0500
> Scott Wood <oss@buserror.net> wrote:
>
> Hi Scott,
>
>> Erratum A-008585 says that the ARM generic timer counter "has the
>> potential to contain an erroneous value for a small number of core
>> clock cycles every time the timer value changes".  Accesses to TVAL
>> (both read and write) are also affected due to the implicit counter
>> read.  Accesses to CVAL are not affected.
>>
>> The workaround is to reread TVAL and count registers until successive reads
>> return the same value, and when writing TVAL to retry until counter
>> reads before and after the write return the same value.
>>
>> This erratum can be found on LS1043A and LS2080A.
>>
>> Signed-off-by: Scott Wood <oss@buserror.net>
>> ---
>> v2:
>> Significant rework based on feedback, including using static_key,
>> disabling VDSO counter access rather than adding the workaround to the
>> VDSO, and uninlining the loops.
>>
>> Dropped the separate property for indicating that writes to TVAL are
>> affected, as I believe that's just a side effect of the implicit
>> counter read being corrupted, and thus a chip that is affected by one
>> will always be affected by the other.
>>
>> Dropped the arm32 portion as it seems there was confusion about whether
>> LS1021A is affected.  Currently I am being told that it is not
>> affected.
>>
>> I considered writing to CVAL rather than looping on TVAL writes, but
>> that would still have required separate set_next_event() code for the
>> erratum, and adding CVAL to the enum would have required a bunch of
>> extra handlers in switch statements (even where unused, due to compiler
>> warnings about unhandled enum values) including in an arm32 header.  It
>> seemed better to avoid the arm32 interaction and new untested
>> accessors.
>> ---
>>  .../devicetree/bindings/arm/arch_timer.txt         |   6 ++
>>  arch/arm64/include/asm/arch_timer.h                |  37 +++++--
>>  drivers/clocksource/arm_arch_timer.c               | 110 +++++++++++++++++++++
>>  3 files changed, 144 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/arch_timer.txt b/Documentation/devicetree/bindings/arm/arch_timer.txt
>> index e774128..ef5fbe9 100644
>> --- a/Documentation/devicetree/bindings/arm/arch_timer.txt
>> +++ b/Documentation/devicetree/bindings/arm/arch_timer.txt
>> @@ -25,6 +25,12 @@ to deliver its interrupts via SPIs.
>>  - always-on : a boolean property. If present, the timer is powered through an
>>    always-on power domain, therefore it never loses context.
>>  
>> +- fsl,erratum-a008585 : A boolean property. Indicates the presence of
>> +  QorIQ erratum A-008585, which says that reading the counter is
>> +  unreliable unless the same value is returned by back-to-back reads.
>> +  This also affects writes to the tval register, due to the implicit
>> +  counter read.
>> +
>>  ** Optional properties:
>>  
>>  - arm,cpu-registers-not-fw-configured : Firmware does not initialize
> This should be part of a separate patch. Also, errata should be
> documented in Documentation/arm64/silicon-errata.txt.
>
>> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
>> index fbe0ca3..9715e85 100644
>> --- a/arch/arm64/include/asm/arch_timer.h
>> +++ b/arch/arm64/include/asm/arch_timer.h
>> @@ -23,10 +23,33 @@
>>  
>>  #include <linux/bug.h>
>>  #include <linux/init.h>
>> +#include <linux/jump_label.h>
>>  #include <linux/types.h>
>>  
>>  #include <clocksource/arm_arch_timer.h>
>>  
>> +extern struct static_key_false arch_timer_read_ool_enabled;
>> +
>> +#define ARCH_TIMER_REG_READ(reg, func) \
>> +extern u64 func##_ool(void); \
>> +static inline u64 __##func(void) \
>> +{ \
>> +	u64 val; \
>> +	asm volatile("mrs %0, " reg : "=r" (val)); \
>> +	return val; \
>> +} \
>> +static inline u64 _##func(void) \
>> +{ \
>> +	if (static_branch_unlikely(&arch_timer_read_ool_enabled)) \
>> +		return func##_ool(); \
>> +	else \
>> +		return __##func(); \
>> +}
>> +
>> +ARCH_TIMER_REG_READ("cntp_tval_el0", arch_timer_get_ptval)
>> +ARCH_TIMER_REG_READ("cntv_tval_el0", arch_timer_get_vtval)
>> +ARCH_TIMER_REG_READ("cntvct_el0", arch_counter_get_cntvct)
>> +
> Given that this will have a (small) impact on non-affected platforms,
> it'd be good to have this guarded by a erratum-specific config option
> (CONFIG_FSL_ERRATUM_008585?) and turn it into trivial accessors when not
> defined.
>
>>  /*
>>   * These register accessors are marked inline so the compiler can
>>   * nicely work out which register we want, and chuck away the rest of
>> @@ -66,19 +89,19 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
>>  	if (access == ARCH_TIMER_PHYS_ACCESS) {
>>  		switch (reg) {
>>  		case ARCH_TIMER_REG_CTRL:
>> -			asm volatile("mrs %0,  cntp_ctl_el0" : "=r" (val));
>> +			asm volatile("mrs %0, cntp_ctl_el0" : "=r" (val));
> Spurious change?
>
>>  			break;
>>  		case ARCH_TIMER_REG_TVAL:
>> -			asm volatile("mrs %0, cntp_tval_el0" : "=r" (val));
>> +			val = _arch_timer_get_ptval();
>>  			break;
>>  		}
>>  	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
>>  		switch (reg) {
>>  		case ARCH_TIMER_REG_CTRL:
>> -			asm volatile("mrs %0,  cntv_ctl_el0" : "=r" (val));
>> +			asm volatile("mrs %0, cntv_ctl_el0" : "=r" (val));
> Same here.
>
>>  			break;
>>  		case ARCH_TIMER_REG_TVAL:
>> -			asm volatile("mrs %0, cntv_tval_el0" : "=r" (val));
>> +			val = _arch_timer_get_vtval();
>>  			break;
>>  		}
>>  	}
>> @@ -116,12 +139,8 @@ static inline u64 arch_counter_get_cntpct(void)
>>  
>>  static inline u64 arch_counter_get_cntvct(void)
>>  {
>> -	u64 cval;
>> -
>>  	isb();
>> -	asm volatile("mrs %0, cntvct_el0" : "=r" (cval));
>> -
>> -	return cval;
>> +	return _arch_counter_get_cntvct();
>>  }
>>  
>>  static inline int arch_timer_arch_init(void)
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index 5152b38..6f78831 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -79,10 +79,52 @@ static enum ppi_nr arch_timer_uses_ppi = VIRT_PPI;
>>  static bool arch_timer_c3stop;
>>  static bool arch_timer_mem_use_virtual;
>>  
>> +DEFINE_STATIC_KEY_FALSE(arch_timer_read_ool_enabled);
>> +EXPORT_SYMBOL_GPL(arch_timer_read_ool_enabled);
>> +
> Once you have a config option, this can move to the guarded section
> below...
>
>>  /*
>>   * Architected system timer support.
>>   */
>>  
>> +#ifdef CONFIG_ARM64
> which can become CONFIG_FSL_ERRATUM_008585
>
>> +/*
>> + * __always_inline is used to ensure that func() is not an actual function
>> + * pointer, which would result in the register accesses potentially being too
>> + * far apart for the loop to work.
>> + */
>> +static __always_inline u64 arch_timer_reread(u64 (*func)(void))
> This is quite a generic function name. I'd expect something that refers
> to the erratum number.

This is a generic solution to reread the timer counter, how about using a generic one
here for more potential consumers in the future?

Thanks
Hanjun
