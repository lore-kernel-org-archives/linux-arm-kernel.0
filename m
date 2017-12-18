From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 18 Dec 2017 18:03:14 +0100
Subject: [PATCH 0/6] Add CPU Frequency scaling support on Armada 37xx
In-Reply-To: <732df1c4-416b-8174-576b-c51db5a08c9c@gmail.com> (Andre Heider's
 message of "Wed, 6 Dec 2017 15:08:51 +0100")
References: <20171201112508.14121-1-gregory.clement@free-electrons.com>
 <f9ebd3e3-143a-b7e3-7b16-f09750b4c320@gmail.com>
 <874lp4ulbs.fsf@free-electrons.com>
 <732df1c4-416b-8174-576b-c51db5a08c9c@gmail.com>
Message-ID: <87wp1kge99.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,
 
 On mer., d?c. 06 2017, Andre Heider <a.heider@gmail.com> wrote:

> On 06/12/17 12:50, Gregory CLEMENT wrote:
>> I did a last rebase before sending the series to remove the avs part not
>> working yet. And during this rebase I introduced an bug.
>>
>> I will send a v2 soon if  you are intersected by testing it right now,
>> here it is the fix:
>>
>> iff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
>> index 40c9a744cc6e..96c2600009b5 100644
>> --- a/drivers/cpufreq/armada-37xx-cpufreq.c
>> +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
>> @@ -219,7 +219,8 @@ static int __init armada37xx_cpufreq_driver_init(void)
>>           */
>>          for (load_level = ARMADA_37XX_DVFS_LOAD_0; load_level < LOAD_LEVEL_NR;
>>               load_level++) {
>> -               unsigned long freq = dvfs->divider[load_level];
>> +               unsigned long freq = cur_frequency /
>> +                       dvfs->divider[load_level];
>>                    ret = dev_pm_opp_add(cpu_dev, freq, 0);
>>                  if (ret)
>
> Much better, that seems to work so far, thanks!
>
> My espressobin now gets these frequencies: 200 MHz, 250 MHz, 500 MHz
> and 1000 MHz.
>
> With the schedutil governor and `watch -n 0.2 cpufreq-info -f -m` it
> jumps over all of those depending on the load, nice:
>
> Tested-by: Andre Heider <a.heider@gmail.com>
>
> The measured power usage doesn't drop though, I guess that requires
> the AVS part you mentioned? Looking forward to it ;)

Well I did some measurement and i saw some drop, according to my notes:

@ 250MHz: 222mA at 12V => 2.66W
@ 1000MHz: 238mA at 12CV => 2.87W

Not something huge, but only the CPUs which are concerned so it's not so
bad.

>
> On a related note: Do you know if power usage can be lowered by
> disabling eth phys? Is that possible on mainline?

For the test I have done just by removing an Ethernet cable we save a
lot of power, so it helps. I'm sure it is doable on mainline, but maybe
 currently, there is something still missing.

Gregory

>
> Regards,
> Andre
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
