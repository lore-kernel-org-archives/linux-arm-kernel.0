From: nm@ti.com (Nishanth Menon)
Date: Mon, 20 Dec 2010 20:11:29 -0600
Subject: [PATCH v5 6/7] OMAP3: PM: make omap3_cpuidle_update_states
	independent of enable_off_mode
In-Reply-To: <87mxo02bv9.fsf@deeprootsystems.com>
References: <1292875509-9896-1-git-send-email-nm@ti.com>	<1292875509-9896-7-git-send-email-nm@ti.com>	<87hbe83tcy.fsf@deeprootsystems.com>
	<87mxo02bv9.fsf@deeprootsystems.com>
Message-ID: <4D100CD1.8000100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman wrote, on 12/20/2010 06:44 PM:
> Kevin Hilman<khilman@deeprootsystems.com>  writes:
>
>> Nishanth Menon<nm@ti.com>  writes:
>>
>>> Currently omap3_cpuidle_update_states makes whole sale decision
>>> on which C states to update based on enable_off_mode variable
>>> Instead, achieve the same functionality by independently providing
>>> mpu and core deepest states the system is allowed to achieve and
>>> update the idle states accordingly.
>>>
>>> Acked-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>> Acked-by: Jean Pihet<j-pihet@ti.com>
>>>
>>> Signed-off-by: Nishanth Menon<nm@ti.com>
>>
>> This patch doesnt' compile with CPUidle enabled.
>>
>> You missed one other caller of the update_states function inside
>> cpuidle34xx.c which is only there when CONFIG_CPU_IDLE=y
>>
>
> Something like the following folded into this patch makes it compile and
> work as before.
>
> If this looks OK to you, I'll fold it in.
>

Kevin,
thanks. apologies on missing this. looks fine to me.

> Kevin
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx
> index ab4c862..0fb619c 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -517,7 +517,10 @@ int __init omap3_idle_init(void)
>                  return -EINVAL;
>          dev->state_count = count;
>
> -       omap3_cpuidle_update_states();
> +       if (enable_off_mode)
> +               omap3_cpuidle_update_states(PWRDM_POWER_OFF, PWRDM_POWER_OFF);
> +       else
> +               omap3_cpuidle_update_states(PWRDM_POWER_RET, PWRDM_POWER_RET);
>
>          if (cpuidle_register_device(dev)) {
>                  printk(KERN_ERR "%s: CPUidle register device failed\n",


-- 
Regards,
Nishanth Menon
