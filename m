From: dingtianhong@huawei.com (Ding Tianhong)
Date: Thu, 19 Jan 2017 20:16:46 +0800
Subject: [PATCH v8 2/4] arm64: arch_timer: Introduce a generic erratum
 handing mechanism for fsl-a008585
In-Reply-To: <eeab7907-77c3-163c-f489-319012a13913@arm.com>
References: <1484824474-12172-1-git-send-email-dingtianhong@huawei.com>
 <1484824474-12172-3-git-send-email-dingtianhong@huawei.com>
 <eeab7907-77c3-163c-f489-319012a13913@arm.com>
Message-ID: <2041a6f8-bf03-c423-a3b9-713924e1e90c@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/1/19 19:59, Marc Zyngier wrote:
> On 19/01/17 11:14, Ding Tianhong wrote:
>> The workaround for hisilicon,161010101 will check the return value of the system counter
>> by different way, in order to distinguish with the fsl-a008585 workaround, introduce
>> a new generic erratum handing mechanism for fsl-a008585 and rename some functions.
>>
>> After discussion with Marc and Will, a consensus decision was made to remove the commandline
>> parameter for enabling fsl,erratum-a008585 erratum.
>>
>> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt |   9 --
>>  arch/arm64/include/asm/arch_timer.h             |  38 +++------
>>  drivers/clocksource/Kconfig                     |   8 ++
>>  drivers/clocksource/arm_arch_timer.c            | 105 ++++++++++++++----------
>>  4 files changed, 84 insertions(+), 76 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 21e2d88..76437ad 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -539,15 +539,6 @@
>>  			loops can be debugged more effectively on production
>>  			systems.
>>  
>> -	clocksource.arm_arch_timer.fsl-a008585=
>> -			[ARM64]
>> -			Format: <bool>
>> -			Enable/disable the workaround of Freescale/NXP
>> -			erratum A-008585.  This can be useful for KVM
>> -			guests, if the guest device tree doesn't show the
>> -			erratum.  If unspecified, the workaround is
>> -			enabled based on the device tree.
>> -
>>  	clearcpuid=BITNUM [X86]
>>  			Disable CPUID feature X for the kernel. See
>>  			arch/x86/include/asm/cpufeatures.h for the valid bit
>> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
>> index eaa5bbe..b4b3400 100644
>> --- a/arch/arm64/include/asm/arch_timer.h
>> +++ b/arch/arm64/include/asm/arch_timer.h
>> @@ -29,41 +29,29 @@
>>  
>>  #include <clocksource/arm_arch_timer.h>
>>  
>> -#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585)
>> +#if IS_ENABLED(CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND)
>>  extern struct static_key_false arch_timer_read_ool_enabled;
>> -#define needs_fsl_a008585_workaround() \
>> +#define needs_unstable_timer_counter_workaround() \
>>  	static_branch_unlikely(&arch_timer_read_ool_enabled)
>>  #else
>> -#define needs_fsl_a008585_workaround()  false
>> +#define needs_unstable_timer_counter_workaround()  false
>>  #endif
>>  
>> -u32 __fsl_a008585_read_cntp_tval_el0(void);
>> -u32 __fsl_a008585_read_cntv_tval_el0(void);
>> -u64 __fsl_a008585_read_cntvct_el0(void);
>>  
>> -/*
>> - * The number of retries is an arbitrary value well beyond the highest number
>> - * of iterations the loop has been observed to take.
>> - */
>> -#define __fsl_a008585_read_reg(reg) ({			\
>> -	u64 _old, _new;					\
>> -	int _retries = 200;				\
>> -							\
>> -	do {						\
>> -		_old = read_sysreg(reg);		\
>> -		_new = read_sysreg(reg);		\
>> -		_retries--;				\
>> -	} while (unlikely(_old != _new) && _retries);	\
>> -							\
>> -	WARN_ON_ONCE(!_retries);			\
>> -	_new;						\
>> -})
>> +struct arch_timer_erratum_workaround {
>> +	const char *id;		/* Indicate the Erratum ID */
>> +	u32 (*read_cntp_tval_el0)(void);
>> +	u32 (*read_cntv_tval_el0)(void);
>> +	u64 (*read_cntvct_el0)(void);
>> +};
>> +
>> +extern const struct arch_timer_erratum_workaround *timer_unstable_counter_workaround;
>>  
>>  #define arch_timer_reg_read_stable(reg) 		\
>>  ({							\
>>  	u64 _val;					\
>> -	if (needs_fsl_a008585_workaround())		\
>> -		_val = __fsl_a008585_read_##reg();	\
>> +	if (needs_unstable_timer_counter_workaround())		\
>> +		_val = timer_unstable_counter_workaround->read_##reg();\
>>  	else						\
>>  		_val = read_sysreg(reg);		\
>>  	_val;						\
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index 4866f7a..04c2b93 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -325,10 +325,18 @@ config ARM_ARCH_TIMER_EVTSTREAM
>>  	  This must be disabled for hardware validation purposes to detect any
>>  	  hardware anomalies of missing events.
>>  
>> +config ARM_ARCH_TIMER_OOL_WORKAROUND
>> +	bool "Workaround for arm arch timer unstable counter"
> 
> Please drop the message. We don't want that option to be selectable by a
> user, but only selected if an erratum that depends on it is enabled.
> 
OK

Thanks
Ding

>> +	depends on FSL_ERRATUM_A008585
>> +	help
>> +	  This option would only be enabled by Freescale/NXP Erratum A-008585
>> +	  or something else chip has similar erratum.
>> +
>>  config FSL_ERRATUM_A008585
>>  	bool "Workaround for Freescale/NXP Erratum A-008585"
>>  	default y
>>  	depends on ARM_ARCH_TIMER && ARM64
>> +	select ARM_ARCH_TIMER_OOL_WORKAROUND
>>  	help
>>  	  This option enables a workaround for Freescale/NXP Erratum
>>  	  A-008585 ("ARM generic timer may contain an erroneous
> 
> Thanks,
> 
> 	M.
> 
