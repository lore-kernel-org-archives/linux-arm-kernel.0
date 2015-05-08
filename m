From: linux.amoon@gmail.com (Anand Moon)
Date: Fri, 8 May 2015 14:30:05 +0530
Subject: [PATCHv2] clk samsung exynos5420 add CLK_RECALC_NEW_RATES flag to
 mout_apll and mout_kpll clock.
In-Reply-To: <CAJKOXPdd=7Xp8_QBc2PuEfepLF1a_K2yVOYp_6C3Uj16v9LY9w@mail.gmail.com>
References: <1431072605-12234-1-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPdd=7Xp8_QBc2PuEfepLF1a_K2yVOYp_6C3Uj16v9LY9w@mail.gmail.com>
Message-ID: <CANAwSgRrW-S1PCR1y0aS_jYv=O2VTuhL0-QHK2+Up8vJ2YxJnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krysztof,

I will prepare a table as suggested by you and resend it. Thanks for
you comments.

-Anand Moon

On 8 May 2015 at 13:57, Krzysztof Koz?owski <k.kozlowski.k@gmail.com> wrote:
> 2015-05-08 17:10 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
>> Addition of CLK_RECALC_NEW_RATES flag to support Exynos5420 cpu clk so that
>> correct divider values are re-calculated after both pre/post
>> clock notifiers had run for mout_apll clock and mout_kpll clock.
>>
>> Below is the output of cpupower utility.
>> Observation their is considreable improvement in cpufreq stats
>
> s/considreable/considerable/
>
>> after applying this patch.
>>
>> Before this patch applied below is the output of cpupower.
>> ----------------------------------------------------------
>> root at odroidxu3:/usr/src/odroidxu3-4.y-testing# echo performance | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
>> performance
>> root at odroidxu3:/usr/src/odroidxu3-4.y-testing#
>> root at odroidxu3:/usr/src/odroidxu3-4.y-testing#
>> root at odroidxu3:/usr/src/odroidxu3-4.y-testing# cpupower -c 1 frequency-info
>> analyzing CPU 1:
>>   driver: arm-big-little
>>   CPUs which run at the same hardware frequency: 1 2 3 4
>>   CPUs which need to have their frequency coordinated by software: 1 2 3 4
>>   maximum transition latency: 154 us.
>>   hardware limits: 200 MHz - 1.80 GHz
>>   available frequency steps: 200 MHz, 300 MHz, 400 MHz, 500 MHz, 600 MHz, 700 MHz, 800 MHz, 900 MHz, 1000 MHz, 1.10 GHz, 1.20 GHz, 1.30 GHz, 1.40 GHz, 1.50 GHz, 1.60 GHz, 1.70 GHz, 1.80 GHz
>>   available cpufreq governors: ondemand, conservative, userspace, powersave, performance
>>   current policy: frequency should be within 200 MHz and 1.80 GHz.
>>                   The governor "performance" may decide which speed to use
>>                   within this range.
>>   current CPU frequency is 1.80 GHz (asserted by call to hardware).
>>   cpufreq stats: 200 MHz:22.07%, 300 MHz:1.08%, 400 MHz:0.17%, 500 MHz:0.24%, 600 MHz:0.37%, 700 MHz:0.20%, 800 MHz:0.09%, 900 MHz:0.05%, 1000 MHz:0.02%, 1.10 GHz:0.12%, 1.20 GHz:0.05%, 1.30 GHz:0.07%, 1.40 GHz:0.04%, 1.50 GHz:0.02%, 1.60 GHz:0.00%, 1.70 GHz:0.00%, 1.80 GHz:75.43%  (137)
>>
>> After applied this patch below is the output of cpupower.
>> ---------------------------------------------------------
>> root at odroidxu3:~# echo performance | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
>> performance
>> root at odroidxu3:~# cpupower -c 1 frequency-info
>> analyzing CPU 1:
>>   driver: arm-big-little
>>   CPUs which run at the same hardware frequency: 1 2 3 4
>>   CPUs which need to have their frequency coordinated by software: 1 2 3 4
>>   maximum transition latency: 154 us.
>>   hardware limits: 200 MHz - 1.80 GHz
>>   available frequency steps: 200 MHz, 300 MHz, 400 MHz, 500 MHz, 600 MHz, 700 MHz, 800 MHz, 900 MHz, 1000 MHz, 1.10 GHz, 1.20 GHz, 1.30 GHz, 1.40 GHz, 1.50 GHz, 1.60 GHz, 1.70 GHz, 1.80 GHz
>>   available cpufreq governors: ondemand, conservative, userspace, powersave, performance
>>   current policy: frequency should be within 200 MHz and 1.80 GHz.
>>                   The governor "performance" may decide which speed to use
>>                   within this range.
>>   current CPU frequency is 1.80 GHz (asserted by call to hardware).
>>   cpufreq stats: 200 MHz:46.57%, 300 MHz:8.18%, 400 MHz:1.93%, 500 MHz:3.51%, 600 MHz:2.13%, 700 MHz:0.88%, 800 MHz:1.69%, 900 MHz:1.02%, 1000 MHz:2.55%, 1.10 GHz:1.17%, 1.20 GHz:0.88%, 1.30 GHz:0.38%, 1.40 GHz:0.27%, 1.50 GHz:0.00%, 1.60 GHz:0.15%, 1.70 GHz:0.44%, 1.80 GHz:28.26%  (95)
>
>
> It is too much... Especially lines like:
> "root at odroidxu3:/usr/src/odroidxu3-4.y-testing#"
>
> Leave only necessary information showing the difference, like
> 1. governor - performance
> 2. $ cpupower -c 1 frequency-info
> 3. and some nicely formatted table showing the time spent in
> frequencies... limited to some reasonable wide (75 characters).
> Example:
> Difference observed in following frequencies:
> freq [MHz] |  200   | 300  | 1800 |
> before     | 22.07% | ...  | ...  |
> after      | 46.57% | ...  | ...  |
>
>> ---------------------------------------------------------
>
> Triple dash. I mentioned it already, this should not be in commit message.
>
>> PATCHv2 Fixed the commit log with stats.
>>
>> Depend on https://lkml.org/lkml/2015/4/3/388
>>
>> Tested on OdroidXU3 Board
>> ---------------------------------------------------------
>>
>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>
> But this should be, so above.
>
> Best regards,
> Krzysztof
