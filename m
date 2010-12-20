From: nm@ti.com (Nishanth Menon)
Date: Mon, 20 Dec 2010 13:07:18 -0600
Subject: [PATCH v4 7/7] OMAP3630: PM: Erratum i583: disable coreoff if
	< ES1.2
In-Reply-To: <8739ps5kpv.fsf@deeprootsystems.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com>	<1292712817-24999-8-git-send-email-nm@ti.com>
	<8739ps5kpv.fsf@deeprootsystems.com>
Message-ID: <4D0FA966.5040100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman had written, on 12/20/2010 01:05 PM, the following:
[..]
>>  struct cpuidle_driver omap3_idle_driver = {
>> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
>> index 92ef400..9032d09 100644
>> --- a/arch/arm/mach-omap2/pm.h
>> +++ b/arch/arm/mach-omap2/pm.h
>> @@ -87,6 +87,7 @@ extern unsigned int omap24xx_cpu_suspend_sz;
>>  extern unsigned int omap34xx_cpu_suspend_sz;
>>  
>>  #define PM_RTA_ERRATUM_i608		(1 << 0)
>> +#define PM_SDRC_WAKEUP_ERRATUM_i583	(1 << 1)
>>  
>>  #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
>>  extern u16 pm34xx_errata;
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index 21cd36e..7faea55 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -928,12 +928,28 @@ void omap3_pm_off_mode_enable(int enable)
>>  		state = PWRDM_POWER_RET;
>>  
>>  #ifdef CONFIG_CPU_IDLE
>> -	omap3_cpuidle_update_states(state, state);
>> +	/*
>> +	 * Erratum i583: implementation for ES rev < Es1.2 on 3630. We cannot
>> +	 * enable OFF mode in a stable form for previous revisions, restrict
>> +	 * instead to RET
>> +	 */
>> +	if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583))
>> +		omap3_cpuidle_update_states(state, PWRDM_POWER_RET);
>> +	else
>> +		omap3_cpuidle_update_states(state, state);
>>  #endif
>>  
>>  	list_for_each_entry(pwrst, &pwrst_list, node) {
>> -		pwrst->next_state = state;
>> -		omap_set_pwrdm_state(pwrst->pwrdm, state);
>> +		if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583) &&
>> +				pwrst->pwrdm == core_pwrdm &&
>> +				state == PWRDM_POWER_OFF) {
>> +			pwrst->next_state = PWRDM_POWER_RET;
>> +			pr_err("%s: Core OFF disabled due to errata i583\n",
>> +				__func__);
> 
> This is a warning, not an error condition, so should probably be
> pr_warning().
> 
> That being said, this could be noisy if enable_off_mode is being toggled
> repeatedly, so using WARN_ONCE() might be more appropriate as suggested
> by others.

ok WARN_ONCE it is then.. :) next rev coming right up in a few more mins..

-- 
Regards,
Nishanth Menon
