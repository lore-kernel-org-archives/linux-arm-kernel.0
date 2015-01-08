From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 08 Jan 2015 11:02:54 +0100
Subject: [PATCH] drivers: cpuidle: don't initialize big.LITTLE driver
 if MCPM is unavailable
In-Reply-To: <54AE4ADF.3030307@arm.com>
References: <1420698544-10277-1-git-send-email-sudeep.holla@arm.com>
 <54AE459B.8010703@linaro.org> <54AE4ADF.3030307@arm.com>
Message-ID: <54AE55CE.6040201@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2015 10:16 AM, Sudeep Holla wrote:
> Hi Daniel,
>
> On Thursday 08 January 2015 02:23 PM, Daniel Lezcano wrote:
>> On 01/08/2015 07:29 AM, Sudeep Holla wrote:
>>> If big.LITTLE driver is initialized even when MCPM is unavailable,
>>> we get the below warning the first time cpu tries to enter deeper
>>> C-states.
>>
>> Can you elaborate why MCPM could be unavailable when the tc2 pm code
>> registers the mcpm platform ops before the cpuidle driver ?
>>
>>
> I can think of 3 possible scenarios. Let me know if these make sense.
>
> 1. If the firmware settings in Vexpress configuration files are set to
>     boot in legacy mode, but MCPM is enabled in the kernel.

If I am not wrong, we have a BUG_ON in this path, right ?

> 2. If some failure occurs during MCPM initialization
> 3. For example, if CCI is not accessible as in some Exynos boards [1],
>     we don't want to wait till mpcm_cpu_suspend ?

Well, I think if the firmware is preventing us to play with the CCI but 
MCPM is enabled. We should add BUG_ON also in the same initialization 
path. IIRC, Kevin spent some time to figure out what was happening to 
its odroid-xu3 board before understanding mcpm wasn't able to deal with 
the CCI due to the broken firmware.

The patch you are proposing is valid. Nevertheless, I would really like 
to have the firmwares to be fixed and your patch is hiding an 
incompatible firmware with the kernel configuration and letting the 
kernel continue to work in degraded mode.

IMO, it would be better to be more strict with the mcpm initialization 
and not let the system boot if something is wrong with it which I 
believe is coming from the firmware and let the user to figure out what 
is really happening by letting him to disable mcpm in the kernel 
configuration (which in turn will disable cpuidle).

Nico, Kevin, what is your opinion ?



> [1]
> https://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg39624.html



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
