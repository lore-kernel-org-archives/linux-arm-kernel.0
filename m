From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 13 Feb 2014 12:08:08 +0100
Subject: [PATCH v3 1/7] cpufreq: cpufreq-cpu0: allow use of optional boost
 mode frequencies
In-Reply-To: <CAJuA9agoK4vO+1mTktgc6BoHLO8qR2482uizP1LbG5zgy9Q4kA@mail.gmail.com>
References: <1391788548-13056-1-git-send-email-thomas.ab@samsung.com>
 <1391788548-13056-2-git-send-email-thomas.ab@samsung.com>
 <52FB8C23.30003@samsung.com>
 <CAJuA9agoK4vO+1mTktgc6BoHLO8qR2482uizP1LbG5zgy9Q4kA@mail.gmail.com>
Message-ID: <52FCA798.407@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.02.2014 09:02, Thomas Abraham wrote:
> On Wed, Feb 12, 2014 at 8:28 PM, Tomasz Figa <t.figa@samsung.com> wrote:
>> Hi Thomas,
>>
>>
>> On 07.02.2014 16:55, Thomas Abraham wrote:

[snip]

>>> diff --git a/drivers/cpufreq/cpufreq-cpu0.c
>>> b/drivers/cpufreq/cpufreq-cpu0.c
>>> index 0c12ffc..06539eb 100644
>>> --- a/drivers/cpufreq/cpufreq-cpu0.c
>>> +++ b/drivers/cpufreq/cpufreq-cpu0.c
>>> @@ -195,6 +195,9 @@ static int cpu0_cpufreq_probe(struct platform_device
>>> *pdev)
>>>                          transition_latency += ret * 1000;
>>>          }
>>>
>>> +       if (of_find_property(cpu_dev->of_node, "boost-frequency", NULL))
>>> +               cpu0_cpufreq_driver.boost_supported = true;
>>> +
>>>          ret = cpufreq_register_driver(&cpu0_cpufreq_driver);
>>>          if (ret) {
>>>                  pr_err("failed register driver: %d\n", ret);
>>>
>>
>> I'd say that boost should be enabled depending on user's preference, as done
>> before in Exynos cpufreq driver. So both presence of boost-frequency
>> property and state of CPU_FREQ_BOOST_SW should be considered.
>>
>> As for CPU_FREQ_BOOST_SW, I don't think it should be always selected, but
>> ather, either converted to a user-selectable bool entry or made selectable
>> by other entry, like current ARM_EXYNOS_CPU_FREQ_BOOST_SW.
>
> We still will have the same problem on Exynos multi-platform kernel
> where one Exynos platform needs it and others don't. Same with just
> using the CPU_FREQ_BOOST_SW config option. So that was the reason to
> just fallback on presence of boost property.

I don't think we really have a problem here, because we have well 
defined semantics for particular enable methods:

  - Kconfig is supposed to be a global enable - if an option is 
disabled, it is not even built into the kernel and can be used in any 
way - this is per-user choice, regardless of platform the image is going 
to be running on,

  - device tree is supposed to be telling us whether the hardware we are 
running on supports given feature and all the required data to enable 
it, if yes,

  - then, for per system configuration, you should be able to 
enable/disable given feature by a command line parameter, e.g. 
cpufreq.boost_disable.

If you follow the above description, you should be able to get any 
configuration you want on any system, as long as it's supported by hardware.

Best regards,
Tomasz
