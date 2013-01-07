From: zhanzhenbo@gmail.com (steve.zhan)
Date: Mon, 7 Jan 2013 13:50:19 +0800
Subject: [PATCH 1/1] ARM: ux500:mach-ux500/cpuidle.c spinlock dis-matching
In-Reply-To: <50E9A4FE.6090807@linaro.org>
References: <CAKvkGKdoWxmnRbNvn_SikRhzsyyzqEC99XtSM9ZeaVGjEA_Ydw@mail.gmail.com>
 <50E9A4FE.6090807@linaro.org>
Message-ID: <CAKvkGKcPumpRcxQrwWGXoWvG4Sk2niTiojfNU=2PnZ9zq_7EcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

    Happy new year, Thank you for reply.
Sorry for that i have refer the old patch email.
I have updated the patch, Pls check the URL:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/138939.html
Now i am using gmail GUI tools to send mail, i will switch email tool
to MUTT to commit the other patchs in the future.



--------------
steve.zhan

2013/1/7, Daniel Lezcano <daniel.lezcano@linaro.org>:
> On 12/28/2012 08:06 AM, steve.zhan wrote:
>> Hi Daniel,
>
> Hi Steve,
>
> sorry I missed your email.
>
>>
>>        I think we must unlock the master spinlock even
>> prcmu_gic_decouple function now always return 0.
>>        Could you give some infos about this?
>
> I agree, that would be cleaner.
>
> AFAICS, your patch does not solve the problem because 'recouple' will be
> false if prcmu_gic_decouple fails, so the lock will never be release.
>
> That will be simpler to do:
>
> if (prcmu_gic_decouple()) {
> 	spin_unlock(&master);
> 	goto out;
> }
>
> no ?
>
>> Thanks.
>>
>> diff --git a/arch/arm/mach-ux500/cpuidle.c
>> b/arch/arm/mach-ux500/cpuidle.c
>> index b54884bd..b0759ce 100644
>> --- a/arch/arm/mach-ux500/cpuidle.c
>> +++ b/arch/arm/mach-ux500/cpuidle.c
>> @@ -29,6 +29,7 @@ static inline int ux500_enter_idle(struct cpuidle_device
>> *dev,
>>  {
>>         int this_cpu = smp_processor_id();
>>         bool recouple = false;
>> +       bool locked = false;
>>
>>         clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &this_cpu);
>>
>> @@ -39,6 +40,8 @@ static inline int ux500_enter_idle(struct cpuidle_device
>> *dev,
>>                 if (!spin_trylock(&master_lock))
>>                         goto wfi;
>>
>> +               locked = true;
>> +
>>                 /* decouple the gic from the A9 cores */
>>                 if (prcmu_gic_decouple())
>>                         goto out;
>> @@ -76,7 +79,7 @@ static inline int ux500_enter_idle(struct cpuidle_device
>> *dev,
>>                 /* When we switch to retention, the prcmu is in charge
>>                  * of recoupling the gic automatically */
>>                 recouple = false;
>> -
>> +               locked = false;
>>                 spin_unlock(&master_lock);
>>         }
>>  wfi:
>> @@ -86,7 +89,8 @@ out:
>>
>>         if (recouple) {
>>                 prcmu_gic_recouple();
>> -               spin_unlock(&master_lock);
>> +               if (locked)
>> +                       spin_unlock(&master_lock);
>>         }
>>
>>         clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &this_cpu);
>>
>>
>>
>> Steve Zhan
>>
>
>
> --
>  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
>


-- 
Steve Zhan
