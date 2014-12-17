From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed, 17 Dec 2014 08:22:35 -0700
Subject: [PATCH v14 03/10] qcom: spm: Add Subsystem Power Manager driver
In-Reply-To: <5490857A.1000808@codeaurora.org>
References: <1417541958-56907-1-git-send-email-lina.iyer@linaro.org>
 <2519415.GklIQeMgWR@wuerfel> <54903DC6.8010308@linaro.org>
 <2663853.2Q3kHisMT7@wuerfel> <5490857A.1000808@codeaurora.org>
Message-ID: <20141217152235.GA1437@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16 2014 at 12:18 -0700, Stephen Boyd wrote:
>On 12/16/2014 06:38 AM, Arnd Bergmann wrote:
>> On Tuesday 16 December 2014 15:12:22 Daniel Lezcano wrote:
>>> At the beginning, all that become from not including mach files from the
>>> drivers directory which make sense.
>>>
>>> Perhaps it is time to write a similar mechanism for the cpuidle drivers
>>> where we can still separate the low level PM code from the generic
>>> cpuidle code.
>> That way you basically duplicate the same thing we already have, which
>> isn't much better.
>>
>> In the example of drivers/soc/qcom/spm.c, just call cpuidle_register
>> from the spm_dev_probe() function and be done with it. You already
>> have a device that is responsible for handling this, don't try to
>> construct more than you already need.
>>
>> I would assume that the same can be done for most other platforms.
>>
>> There are probably cases where the same piece of hardware is responsible
>> for both cpuidle and cpufreq, but what that means is really that you
>> should have a single driver for it that does both things. Same for
>> SMP support: if you have one register block that does both the SMP
>> bringup and the cpuidle stuff, then have *one* driver for this block
>> that does it all. There are currently a few dependencies that require
>> doing SMP bringup early during boot, but we decided years ago that those
>> are all artificial dependencies and we should be able to boot secondary
>> CPUs much later than we currently do.
>>
>
>+1. The SPM harware is used for hotplug, suspend, cpuidle, as well as
>provides a regulator for a CPU, so all these things should be done in a
>single driver. Booting secondary CPUs early is not hard here either if
>we move the smp ops into the same driver. The only downside then is that
>it can't be a module, but I would guess that we can work on making that
>possible by allowing smp ops to be inserted and removed at any time.
>
I am not sure, just because the hardware supports multiple
functionality, everything should go into the same file.

If you think of a SPM driver as something that provides a service, you
would see that all the functionality of cpuidle, hotplug, suspend, use
the service and can have their own place to share their commonality. SPM
h/w is not just for cpus. It could be a generic power controller (to an
extent) for the cpu, cache, coherenency interface and pretty much any
bus/clock exports the services of that device. There needs to be a
distinction between an entity that provides the functionality and a one
that uses it. You cannot build on additional functionality neatly if you
have them all together.

As such, I am quite appalled by the addition of the idle functions in
the SPM driver, but seems like its the direction many want, hence went
with it. But, please dont suggest using SPM driver as a dumping ground
for all functionality that SPM may indirectly influence.

Thanks,
Lina
