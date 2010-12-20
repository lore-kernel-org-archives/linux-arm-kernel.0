From: nm@ti.com (Nishanth Menon)
Date: Mon, 20 Dec 2010 05:22:07 -0600
Subject: [PATCH v4 7/7] OMAP3630: PM: Erratum i583: disable coreoff if
	< ES1.2
In-Reply-To: <7a43d84df0170f80e31c3e3f3eb8b249@mail.gmail.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com>
	<1292712817-24999-8-git-send-email-nm@ti.com>
	<7a43d84df0170f80e31c3e3f3eb8b249@mail.gmail.com>
Message-ID: <4D0F3C5F.8060405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar wrote, on 12/20/2010 12:51 AM:
[...]
>> +
>> +	/*
>> +	 * Erratum i583: implementation for ES rev<  Es1.2 on 3630. We
>> cannot
>> +	 * enable OFF mode in a stable form for previous revisions.
>> +	 * we disable C7 state as a result.
>> +	 */
>> +	if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583)) {
>> +		omap3_power_states[OMAP3_STATE_C7].valid = 0;
>> +		cpuidle_params_table[OMAP3_STATE_C7].valid = 0;
> WARN_ONCE in IDLE also would be good.
>> +	}
this state will not be active anyways as enable_off_mode is 0 by default.


>>   }
>>
>>   struct cpuidle_driver omap3_idle_driver = {
>> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
>> index 92ef400..9032d09 100644
>> --- a/arch/arm/mach-omap2/pm.h
>> +++ b/arch/arm/mach-omap2/pm.h
>> @@ -87,6 +87,7 @@ extern unsigned int omap24xx_cpu_suspend_sz;
>>   extern unsigned int omap34xx_cpu_suspend_sz;
>>
>>   #define PM_RTA_ERRATUM_i608		(1<<  0)
>> +#define PM_SDRC_WAKEUP_ERRATUM_i583	(1<<  1)
>>
>>   #if defined(CONFIG_PM)&&  defined(CONFIG_ARCH_OMAP3)
>>   extern u16 pm34xx_errata;
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index 21cd36e..7faea55 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -928,12 +928,28 @@ void omap3_pm_off_mode_enable(int enable)
>>   		state = PWRDM_POWER_RET;
>>
>>   #ifdef CONFIG_CPU_IDLE
>> -	omap3_cpuidle_update_states(state, state);
>> +	/*
>> +	 * Erratum i583: implementation for ES rev<  Es1.2 on 3630. We
>> cannot
>> +	 * enable OFF mode in a stable form for previous revisions,
> restrict
>> +	 * instead to RET
>> +	 */
>> +	if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583))
>> +		omap3_cpuidle_update_states(state, PWRDM_POWER_RET);
>> +	else
>> +		omap3_cpuidle_update_states(state, state);
>>   #endif
>>
>>   	list_for_each_entry(pwrst,&pwrst_list, node) {
>> -		pwrst->next_state = state;
>> -		omap_set_pwrdm_state(pwrst->pwrdm, state);
>> +		if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583)&&
>> +				pwrst->pwrdm == core_pwrdm&&
>> +				state == PWRDM_POWER_OFF) {
>> +			pwrst->next_state = PWRDM_POWER_RET;
>> +			pr_err("%s: Core OFF disabled due to errata
> i583\n",
> Shoud we do this in every iteration or just WARN_ONCE do ??
every time off mode is enabled? this path is not exercised for every cpu 
idle/suspend iteration.

-- 
Regards,
Nishanth Menon
