From: fu.wei@linaro.org (Fu Wei)
Date: Wed, 18 Jan 2017 07:49:43 +0800
Subject: [PATCH v19 05/15] clocksource/drivers/arm_arch_timer: rework PPI
 determination
In-Reply-To: <20170116172927.GI5908@leverpostej>
References: <20161221064603.11830-1-fu.wei@linaro.org>
 <20161221064603.11830-6-fu.wei@linaro.org>
 <20170116172927.GI5908@leverpostej>
Message-ID: <CADyBb7sP42WqpJ5xiD9Yujn3ZjDBH_3-Te5-xF_adVDTo5fQqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 17 January 2017 at 01:29, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Dec 21, 2016 at 02:45:53PM +0800, fu.wei at linaro.org wrote:
> [...]
>
>> -     if (is_hyp_mode_available() || !arch_timer_ppi[ARCH_TIMER_VIRT_PPI]) {
>> -             bool has_ppi;
>> +     if (is_hyp_mode_available() && is_kernel_in_hyp_mode())
>> +             return ARCH_TIMER_HYP_PPI;
>>
>> -             if (is_kernel_in_hyp_mode()) {
>> -                     arch_timer_uses_ppi = ARCH_TIMER_HYP_PPI;
>> -                     has_ppi = !!arch_timer_ppi[ARCH_TIMER_HYP_PPI];
>> -             } else {
>> -                     arch_timer_uses_ppi = ARCH_TIMER_PHYS_SECURE_PPI;
>> -                     has_ppi = (!!arch_timer_ppi[ARCH_TIMER_PHYS_SECURE_PPI] ||
>> -                                !!arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]);
>> -             }
>> +     if (arch_timer_ppi[ARCH_TIMER_VIRT_PPI])
>> +             return ARCH_TIMER_VIRT_PPI;
>>
>> -             if (!has_ppi) {
>> -                     pr_warn("No interrupt available, giving up\n");
>> -                     return -EINVAL;
>> -             }
>> -     }
>> +     if (IS_ENABLED(CONFIG_ARM64))
>> +             return ARCH_TIMER_PHYS_NONSECURE_PPI;
>> +
>> +     return ARCH_TIMER_PHYS_SECURE_PPI;
>
> For a 32-bit platform booted at hyp (with a virt PPI available), the new
> logic will select ARCH_TIMER_VIRT_PPI. I beleive that will break KVM.
>
> I think the logic should be:
>
>         if (is_kernel_in_hyp_mode())
>                 return ARCH_TIMER_HYP_PPI;
>
>         if (!is_hyp_mode_available() &&
>             arch_timer_ppi[ARCH_TIMER_VIRT_PPI])
>                 return ARCH_TIMER_VIRT_PPI;
>
>         if (IS_ENABLED(CONFIG_ARM64))
>                 return ARCH_TIMER_PHYS_NONSECURE_PPI;
>
>         return ARCH_TIMER_PHYS_SECURE_PPI;
>
> Please use that instead (keeping the comment you retained).

Great thanks for pointing it out, that is bug.
also got this bug report from Huawei engineer.

I have fixed it using your example code, thanks!


>
>> +static int __init arch_timer_init(void)
>> +{
>> +     int ret;
>>
>>       ret = arch_timer_register();
>>       if (ret)
>> @@ -904,6 +906,13 @@ static int __init arch_timer_of_init(struct device_node *np)
>>       if (IS_ENABLED(CONFIG_ARM) &&
>>           of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
>>               arch_timer_uses_ppi = ARCH_TIMER_PHYS_SECURE_PPI;
>> +     else
>> +             arch_timer_uses_ppi = arch_timer_select_ppi();
>> +
>> +     if (!arch_timer_ppi[arch_timer_uses_ppi]) {
>> +             pr_err("No interrupt available, giving up\n");
>> +             return -EINVAL;
>> +     }
>>
>>       /* On some systems, the counter stops ticking when in suspend. */
>>       arch_counter_suspend_stop = of_property_read_bool(np,
>> @@ -1049,6 +1058,12 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
>>       /* Get the frequency from CNTFRQ */
>>       arch_timer_detect_rate(NULL, NULL);
>>
>> +     arch_timer_uses_ppi = arch_timer_select_ppi();
>> +     if (!arch_timer_ppi[arch_timer_uses_ppi]) {
>> +             pr_err("No interrupt available, giving up\n");
>> +             return -EINVAL;
>> +     }
>
> I see that we have to duplicate this so we can special-case the
> DT-specific behaviour, so that's fine by me.

Yes, that is the reason of the duplication :-)

>
> If you can fix the arch_timer_select_ppi() logic as above, this should
> be fine.

Done, thanks :-)

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
