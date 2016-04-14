From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 13 Apr 2016 20:52:28 -0500
Subject: [PATCH] ARM: OMAP3: Fix external abort on 36xx waking from off
 mode idle
In-Reply-To: <20160413193003.GW5995@atomide.com>
References: <1460475837-1984-1-git-send-email-d-gerlach@ti.com>
 <20160413193003.GW5995@atomide.com>
Message-ID: <570EF7DC.1010504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2016 02:30 PM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [160412 08:45]:
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -268,7 +268,6 @@ void omap_sram_idle(void)
>>  	int per_next_state = PWRDM_POWER_ON;
>>  	int core_next_state = PWRDM_POWER_ON;
>>  	int per_going_off;
>> -	int core_prev_state;
>>  	u32 sdrc_pwr = 0;
>>  
>>  	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
>> @@ -348,17 +347,21 @@ void omap_sram_idle(void)
>>  		sdrc_write_reg(sdrc_pwr, SDRC_POWER);
>>  
>>  	/* CORE */
>> -	if (core_next_state < PWRDM_POWER_ON) {
>> -		core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
>> -		if (core_prev_state == PWRDM_POWER_OFF) {
>> -			omap3_core_restore_context();
>> -			omap3_cm_restore_context();
>> -			omap3_push_sram_idle();
>> -			omap3_push_sram_secure_idle();
>> -			omap2_sms_restore_context();
>> -		}
>> +	if (core_next_state < PWRDM_POWER_ON &&
>> +	    pwrdm_read_prev_pwrst(core_pwrdm) == PWRDM_POWER_OFF) {
>> +		omap3_core_restore_context();
>> +		omap3_cm_restore_context();
>> +		omap3_push_sram_idle();
>> +		omap3_push_sram_secure_idle();
>> +		omap2_sms_restore_context();
>> +	} else {
>> +		/*
>> +		 * In off-mode resume path above, omap3_core_restore_context
>> +		 * also handles the INTC autoidle restore done here so limit
>> +		 * this to non-off mode resume paths so we don't do it twice.
>> +		 */
>> +		omap3_intc_resume_idle();
>>  	}
>> -	omap3_intc_resume_idle();
>>  
>>  	pwrdm_post_transition(NULL);
> 
> Can you please repost against v4.7-rc? This does not apply as
> mainline still uses omap3_sram_restore_context(). Should be
> retested again with your patches applied on top of this fix.
> 

Whoops, complete oversight on my part, retested and reported here:
https://patchwork.kernel.org/patch/8830421/

Tests showed the exact same behavior, no abort with or without patch, with my
sram series on top there was also no abort, but if I remove the fix patch the
abort comes back.

Regards,
Dave

> Regards,
> 
> Tony
> 
