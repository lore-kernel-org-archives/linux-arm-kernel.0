From: dingtianhong@huawei.com (Ding Tianhong)
Date: Thu, 27 Oct 2016 20:17:21 +0800
Subject: [PATCH v2 3/4] arm64: arch_timer: Work around Erratum
 Hisilicon-161601
In-Reply-To: <16d8f329-3413-11da-6f2a-8b1a95c85352@arm.com>
References: <1477553651-13428-1-git-send-email-dingtianhong@huawei.com>
 <1477553651-13428-3-git-send-email-dingtianhong@huawei.com>
 <16d8f329-3413-11da-6f2a-8b1a95c85352@arm.com>
Message-ID: <44cf2916-7c81-5cdf-d113-f99326eae2c6@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/10/27 18:58, Marc Zyngier wrote:
> On 27/10/16 08:34, Ding Tianhong wrote:
>> Erratum Hisilicon-161601 says that the ARM generic timer counter "has the
>> potential to contain an erroneous value when the timer value changes".
>> Accesses to TVAL (both read and write) are also affected due to the implicit counter
>> read.  Accesses to CVAL are not affected.
>>
>> The workaround is to reread the system count registers until the value of the second
>> read is larger than the first one by less than 32, the system counter can be guaranteed
>> not to return wrong value twice by back-to-back read and the error value is always larger
>> than the correct one by 32. Writes to TVAL are replaced with an equivalent write to CVAL.
>>
>> The workaround is enabled if the hisilicon,erratum-161601 property is found in
>> the timer node in the device tree.  This can be overridden with the
>> clocksource.arm_arch_timer.hisilicon-161601 boot parameter, which allows KVM
>> users to enable the workaround until a mechanism is implemented to
>> automatically communicate this information.
>>
>> Fix some description for fsl erratum a008585.
>>
>> v2: Significant rework based on feedback, including seperate the fsl erratum a008585
>>     to another patch, update the erratum name and remove unwanted code.
>>
>> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
>> ---
>>  Documentation/arm64/silicon-errata.txt |  1 +
>>  Documentation/kernel-parameters.txt    |  9 ++++
>>  arch/arm64/include/asm/arch_timer.h    | 28 ++++++++++-
>>  drivers/clocksource/Kconfig            | 14 +++++-
>>  drivers/clocksource/arm_arch_timer.c   | 88 ++++++++++++++++++++++++++--------
>>  5 files changed, 118 insertions(+), 22 deletions(-)
>>
>> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
>> index 405da11..70c5d5e 100644
>> --- a/Documentation/arm64/silicon-errata.txt
>> +++ b/Documentation/arm64/silicon-errata.txt
>> @@ -63,3 +63,4 @@ stable kernels.
>>  | Cavium         | ThunderX SMMUv2 | #27704          | N/A		       |
>>  |                |                 |                 |                         |
>>  | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585     |
>> +| Hisilicon      | Hip05/Hip06/Hip07 | #161601       | HISILICON_ERRATUM_161601|
> 
> I've already commented on the alignment. Please read my initial review.
> 

It sees misunderstood, fix it this time.

>> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
>> index 6fa1d8a..735b4b6 100644
>> --- a/Documentation/kernel-parameters.txt
>> +++ b/Documentation/kernel-parameters.txt
>> @@ -707,6 +707,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>>  			erratum.  If unspecified, the workaround is
>>  			enabled based on the device tree.
>>  
>> +	clocksource.arm_arch_timer.hisilicon-161601=
>> +			[ARM64]
>> +			Format: <bool>
>> +			Enable/disable the workaround of Hisilicon
>> +			erratum 161601.  This can be useful for KVM
>> +			guests, if the guest device tree doesn't show the
>> +			erratum.  If unspecified, the workaround is
>> +			enabled based on the device tree.
>> +
>>  	clearcpuid=BITNUM [X86]
>>  			Disable CPUID feature X for the kernel. See
>>  			arch/x86/include/asm/cpufeatures.h for the valid bit
>> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
>> index 118719d8..49b3041 100644
>> --- a/arch/arm64/include/asm/arch_timer.h
>> +++ b/arch/arm64/include/asm/arch_timer.h
>> @@ -29,7 +29,7 @@
>>  
>>  #include <clocksource/arm_arch_timer.h>
>>  
>> -#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585)
>> +#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585) || IS_ENABLED(CONFIG_HISILICON_ERRATUM_161601)
>>  extern struct static_key_false arch_timer_read_ool_enabled;
>>  #define needs_timer_erratum_workaround() \
>>  	static_branch_unlikely(&arch_timer_read_ool_enabled)
>> @@ -65,11 +65,35 @@ extern struct arch_timer_erratum_workaround *erratum_workaround;
>>  	_new;						\
>>  })
>>  
>> +
>> +
>> +/*
>> + * The number of retries is an arbitrary value well beyond the highest number
>> + * of iterations the loop has been observed to take.
>> + * Verify whether the value of the second read is larger than the first by
>> + * less than 32 is the only way to confirm the value is correct, the system
>> + * counter can be guaranteed not to return wrong value twice by back-to-back read
>> + * and the error value is always larger than the correct one by 32.
>> + */
>> +#define __hisi_161601_read_reg(reg) ({				\
>> +	u64 _old, _new;						\
>> +	int _retries = 200;					\
> 
> Please document how this value was found (either in the code or in the
> commit message).

It really difficult to give the accurate standard, theoretically the error should not happened
twice together, so maybe 2 is enough here, I just give a arbitrary value.

> 
>> +								\
>> +	do {							\
>> +		_old = read_sysreg(reg);			\
>> +		_new = read_sysreg(reg);			\
>> +		_retries--;					\
>> +	} while (unlikely((_new - _old) >> 5) && _retries);	\
>> +								\
>> +	WARN_ON_ONCE(!_retries);				\
>> +	_new;							\
>> +})
> 
> Same remark as in the previous patch.
> 

I think the sentence *Verify whether the value of the second read is larger than the first by
less than 32 is the only way to confirm the value is correct* could explain why should *(_new - _old) >> 5*.
it is the same as (_new - _old)/32, also mean the _new should never bigger than _old more than 32.

>> +
>>  #define arch_timer_reg_read_stable(reg) 		\
>>  ({							\
>>  	u64 _val;					\
>>  	if (needs_timer_erratum_workaround())		\
>> -		_val = erratum_workaround->read_##reg();	\
>> +		_val = erratum_workaround->read_##reg();\
>>  	else						\
>>  		_val = read_sysreg(reg);		\
>>  	_val;						\
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index 8a753fd..4aafb6a 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -312,8 +312,20 @@ config FSL_ERRATUM_A008585
>>  	help
>>  	  This option enables a workaround for Freescale/NXP Erratum
>>  	  A-008585 ("ARM generic timer may contain an erroneous
>> -	  value").  The workaround will only be active if the
>> +	  value").  The workaround will be active if the
>>  	  fsl,erratum-a008585 property is found in the timer node.
>> +	  This can be overridden with the clocksource.arm_arch_timer.fsl-a008585
>> +	  boot parameter.
> 
> Move this hunk to the previous patch.
> 
>> +
>> +config HISILICON_ERRATUM_161601
>> +	bool "Workaround for Hisilicon Erratum 161601"
>> +	default y
>> +	depends on ARM_ARCH_TIMER && ARM64
>> +	help
>> +	  This option enables a workaround for Hisilicon Erratum
>> +	  161601. The workaround will be active if the hisilicon,erratum-161601
>> +	  property is found in the timer node. This can be overridden with
>> +	  the clocksource.arm_arch_timer.hisilicon-161601 boot parameter.
>>  
>>  config ARM_GLOBAL_TIMER
>>  	bool "Support for the ARM global timer" if COMPILE_TEST
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index e4f7fa1..89f1895 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -94,13 +94,14 @@ early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
>>   * Architected system timer support.
>>   */
>>  
>> -#ifdef CONFIG_FSL_ERRATUM_A008585
>> +#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585) || IS_ENABLED(CONFIG_HISILICON_ERRATUM_161601)
>>  struct arch_timer_erratum_workaround *erratum_workaround = NULL;
>>  
>>  DEFINE_STATIC_KEY_FALSE(arch_timer_read_ool_enabled);
>>  EXPORT_SYMBOL_GPL(arch_timer_read_ool_enabled);
>> +#endif
>>  
>> -
>> +#ifdef CONFIG_FSL_ERRATUM_A008585
>>  static u32 fsl_a008585_read_cntp_tval_el0(void)
>>  {
>>  	return __fsl_a008585_read_reg(cntp_tval_el0);
>> @@ -139,6 +140,45 @@ static int __init early_fsl_a008585_cfg(char *buf)
>>  early_param("clocksource.arm_arch_timer.fsl-a008585", early_fsl_a008585_cfg);
>>  #endif /* CONFIG_FSL_ERRATUM_A008585 */
>>  
>> +#ifdef CONFIG_HISILICON_ERRATUM_161601
>> +static u32 hisi_161601_read_cntp_tval_el0(void)
>> +{
>> +	return __hisi_161601_read_reg(cntp_tval_el0);
>> +}
>> +
>> +static  u32 hisi_161601_read_cntv_tval_el0(void)
>> +{
>> +	return __hisi_161601_read_reg(cntv_tval_el0);
>> +}
>> +
>> +static u64 hisi_161601_read_cntvct_el0(void)
>> +{
>> +	return __hisi_161601_read_reg(cntvct_el0);
>> +}
>> +
>> +static struct arch_timer_erratum_workaround arch_timer_hisi_161601 = {
>> +	.read_cntp_tval_el0 = hisi_161601_read_cntp_tval_el0,
>> +	.read_cntv_tval_el0 = hisi_161601_read_cntv_tval_el0,
>> +	.read_cntvct_el0 = hisi_161601_read_cntvct_el0,
>> +};
>> +
>> +static int __init early_hisi_161601_cfg(char *buf)
>> +{
>> +	int ret;
>> +	bool val;
>> +
>> +	ret = strtobool(buf, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (val)
>> +		erratum_workaround = &arch_timer_hisi_161601;
>> +
>> +	return 0;
>> +}
>> +early_param("clocksource.arm_arch_timer.hisilicon-161601", early_hisi_161601_cfg);
>> +#endif /* CONFIG_HISILICON_ERRATUM_161601 */
>> +
>>  static __always_inline
>>  void arch_timer_reg_write(int access, enum arch_timer_reg reg, u32 val,
>>  			  struct clock_event_device *clk)
>> @@ -288,8 +328,8 @@ static __always_inline void set_next_event(const int access, unsigned long evt,
>>  	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
>>  }
>>  
>> -#ifdef CONFIG_FSL_ERRATUM_A008585
>> -static __always_inline void fsl_a008585_set_next_event(const int access,
>> +#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585) || IS_ENABLED(CONFIG_HISILICON_ERRATUM_161601)
>> +static __always_inline void erratum_set_next_event(const int access,
>>  		unsigned long evt, struct clock_event_device *clk)
>>  {
>>  	unsigned long ctrl;
>> @@ -307,20 +347,20 @@ static __always_inline void fsl_a008585_set_next_event(const int access,
>>  	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
>>  }
>>  
>> -static int fsl_a008585_set_next_event_virt(unsigned long evt,
>> +static int erratum_set_next_event_virt(unsigned long evt,
>>  					   struct clock_event_device *clk)
>>  {
>> -	fsl_a008585_set_next_event(ARCH_TIMER_VIRT_ACCESS, evt, clk);
>> +	erratum_set_next_event(ARCH_TIMER_VIRT_ACCESS, evt, clk);
>>  	return 0;
>>  }
>>  
>> -static int fsl_a008585_set_next_event_phys(unsigned long evt,
>> +static int erratum_set_next_event_phys(unsigned long evt,
>>  					   struct clock_event_device *clk)
>>  {
>> -	fsl_a008585_set_next_event(ARCH_TIMER_PHYS_ACCESS, evt, clk);
>> +	erratum_set_next_event(ARCH_TIMER_PHYS_ACCESS, evt, clk);
>>  	return 0;
>>  }
>> -#endif /* CONFIG_FSL_ERRATUM_A008585 */
>> +#endif
>>  
>>  static int arch_timer_set_next_event_virt(unsigned long evt,
>>  					  struct clock_event_device *clk)
>> @@ -350,16 +390,16 @@ static int arch_timer_set_next_event_phys_mem(unsigned long evt,
>>  	return 0;
>>  }
>>  
>> -static void fsl_a008585_set_sne(struct clock_event_device *clk)
>> +static void erratum_set_sne(struct clock_event_device *clk)
>>  {
>> -#ifdef CONFIG_FSL_ERRATUM_A008585
>> +#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585) || IS_ENABLED(CONFIG_HISILICON_ERRATUM_161601)
>>  	if (!static_branch_unlikely(&arch_timer_read_ool_enabled))
>>  		return;
>>  
>>  	if (arch_timer_uses_ppi == VIRT_PPI)
>> -		clk->set_next_event = fsl_a008585_set_next_event_virt;
>> +		clk->set_next_event = erratum_set_next_event_virt;
>>  	else
>> -		clk->set_next_event = fsl_a008585_set_next_event_phys;
>> +		clk->set_next_event = erratum_set_next_event_phys;
>>  #endif
> 
> This should be in the previous patch as well, as it only messes with the
> FSL erratum.
> 

Ok.

>>  }
>>  
>> @@ -392,7 +432,7 @@ static void __arch_timer_setup(unsigned type,
>>  			BUG();
>>  		}
>>  
>> -		fsl_a008585_set_sne(clk);
>> +		erratum_set_sne(clk);
>>  	} else {
>>  		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
>>  		clk->name = "arch_mem_timer";
>> @@ -612,7 +652,7 @@ static void __init arch_counter_register(unsigned type)
>>  
>>  		clocksource_counter.archdata.vdso_direct = true;
>>  
>> -#ifdef CONFIG_FSL_ERRATUM_A008585
>> +#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585) || IS_ENABLED(CONFIG_HISILICON_ERRATUM_161601)
>>  		/*
>>  		 * Don't use the vdso fastpath if errata require using
>>  		 * the out-of-line counter accessor.
>> @@ -899,12 +939,22 @@ static int __init arch_timer_of_init(struct device_node *np)
>>  	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
>>  
>>  #ifdef CONFIG_FSL_ERRATUM_A008585
>> -	if (!erratum_workaround && of_property_read_bool(np, "fsl,erratum-a008585"))
>> +	if (!erratum_workaround && of_property_read_bool(np, "fsl,erratum-a008585")) {
>>  		erratum_workaround = &arch_timer_fsl_a008585;
>> +		if (erratum_workaround) {
> 
> Brilliant!
> 
>> +			static_branch_enable(&arch_timer_read_ool_enabled);
>> +			pr_info("Enabling workaround for FSL erratum A-008585\n");
>> +		}
>> +	}
>> +#endif
>>  
>> -	if (erratum_workaround) {
>> -		static_branch_enable(&arch_timer_read_ool_enabled);
>> -		pr_info("Enabling workaround for FSL erratum A-008585\n");
>> +#ifdef CONFIG_HISILICON_ERRATUM_161601
>> +	if (!erratum_workaround && of_property_read_bool(np, "hisilicon,erratum-161601")) {
>> +		erratum_workaround = &arch_timer_hisi_161601;
>> +		if (erratum_workaround) {
>> +			static_branch_enable(&arch_timer_read_ool_enabled);
>> +			pr_info("Enabling workaround for HISILICON erratum 161601\n");
>> +		}
>>  	}
>>  #endif
> 
> Do you see a pattern here? Surely you can factor a bit of that code (and
> remove the nonsensical bits).
> 

Yes, found it, try to fix it.

Thanks.
Ding

> Thanks,
> 
> 	M.
> 
