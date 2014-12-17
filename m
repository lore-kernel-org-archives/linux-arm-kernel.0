From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 17 Dec 2014 14:15:28 +0100
Subject: [PATCH v14 03/10] qcom: spm: Add Subsystem Power Manager driver
In-Reply-To: <2663853.2Q3kHisMT7@wuerfel>
References: <1417541958-56907-1-git-send-email-lina.iyer@linaro.org>
 <2519415.GklIQeMgWR@wuerfel> <54903DC6.8010308@linaro.org>
 <2663853.2Q3kHisMT7@wuerfel>
Message-ID: <549181F0.3010408@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/16/2014 03:38 PM, Arnd Bergmann wrote:
> On Tuesday 16 December 2014 15:12:22 Daniel Lezcano wrote:
>> At the beginning, all that become from not including mach files from the
>> drivers directory which make sense.
>>
>> Perhaps it is time to write a similar mechanism for the cpuidle drivers
>> where we can still separate the low level PM code from the generic
>> cpuidle code.
>
> That way you basically duplicate the same thing we already have, which
> isn't much better.
>
> In the example of drivers/soc/qcom/spm.c, just call cpuidle_register
> from the spm_dev_probe() function and be done with it. You already
> have a device that is responsible for handling this, don't try to
> construct more than you already need.

If you have to call cpuidle_register, then the cpuidle_driver should be 
provided with all the idle states definition and so on.

That is exactly the opposite of what we have been doing since a couple 
of years where each SoC had their own driver, in their own directory and 
duplicating the code again and again from one platform to another platform.

The changes we have been through cleaned up most of the situation but 
still we have more to do and I would like to prevent stepping back or 
give the opportunity to step back.

I don't think we separated code which is not supposed to be. That has a 
positive side effect of cleaning up the drivers.

Also, I understand your point and I am willing to solve this issue but 
still by keeping the pm low level code separated from the cpuidle driver.

> I would assume that the same can be done for most other platforms.
>
> There are probably cases where the same piece of hardware is responsible
> for both cpuidle and cpufreq, but what that means is really that you
> should have a single driver for it that does both things. Same for
> SMP support: if you have one register block that does both the SMP
> bringup and the cpuidle stuff, then have *one* driver for this block
> that does it all. There are currently a few dependencies that require
> doing SMP bringup early during boot, but we decided years ago that those
> are all artificial dependencies and we should be able to boot secondary
> CPUs much later than we currently do.

I agree with this point and given the number of drivers, the easiest way 
to do that is to create cpu pm ops as I gave in the previous email and 
reuse them for cpu hotplug/bringup. And I believe that is possible if we 
continue our approach by splitting the low level pm code from the 
cpuidle driver.

What about doing something simple ? Like creating a struct 
arm_cpu_pm_ops variable visible from everywhere and filled by the 
different platform ?

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
