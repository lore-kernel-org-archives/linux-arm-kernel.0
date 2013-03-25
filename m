From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 25 Mar 2013 22:55:23 +0100
Subject: [PATCH 00/15] ARM: cpuidle: code consolidation
In-Reply-To: <5150B327.5010507@gmail.com>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
 <5150B327.5010507@gmail.com>
Message-ID: <5150C7CB.6080400@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2013 09:27 PM, Rob Herring wrote:
> On 03/25/2013 12:55 PM, Daniel Lezcano wrote:
>> The flag CPUIDLE_FLAG_TIMER_STOP has been introduced in the commit
>> 89878baa73f0f1c679355006bd8632e5d78f96c2.
>>
>> The flag tells the cpuidle framework the local timer will stop in the
>> idle state.
>>
>> It is now easy to know if the cpuidle driver will use or not the broadcast
>> timer by looking at the different states for this flag and then setup
>> the broadcast timer consequently.
>>
>> When we remove the timer initialization duplicated code in the different
>> drivers, we have most of the drivers with the same init function. This
>> init function is changed to be generic and moved in the ARM cpuidle driver
>> and used from the drivers. That cleanups code and removes a lot of annoying
>> duplicated code.
>>
>> There is still some modification in OMAP4, tegra2, tegra3 and imx, especially
>> around the coupled idle states, but we are more and more closer to a common
>> squeleton for all the ARM drivers.
>>
>> Daniel Lezcano (15):
>>   timer: move enum definition out of ifdef section
>>   cpuidle: initialize the broadcast timer framework
>>   cpuidle: ux500: remove timer broadcast initialization
>>   cpuidle: OMAP4: remove timer broadcast initialization
>>   cpuidle: imx6: remove timer broadcast initialization
>>   ARM: cpuidle: remove useless declaration
>>   ARM: cpuidle: add init/exit routine
>>   ARM: ux500: cpuidle: use init/exit common routine
>>   ARM: at91: cpuidle: use init/exit common routine
>>   ARM: OMAP3: cpuidle: use init/exit common routine
>>   ARM: s3c64xx: cpuidle: use init/exit common routine
>>   ARM: tegra1: cpuidle: use init/exit common routine
>>   ARM: shmobile: pm: fix init sections
>>   ARM: shmobile: cpuidle: remove useless WFI function
>>   ARM: shmobile: cpuidle: use init/exit common routine
>>
>>  arch/arm/include/asm/cpuidle.h         |   11 +++---
>>  arch/arm/kernel/cpuidle.c              |   57 +++++++++++++++++++++++++++++++-
>>  arch/arm/mach-at91/cpuidle.c           |   17 ++--------
>>  arch/arm/mach-imx/cpuidle-imx6q.c      |   15 ---------
>>  arch/arm/mach-omap2/cpuidle34xx.c      |   18 ++--------
>>  arch/arm/mach-omap2/cpuidle44xx.c      |   14 --------
>>  arch/arm/mach-s3c64xx/cpuidle.c        |   15 ++-------
>>  arch/arm/mach-shmobile/cpuidle.c       |   22 ++----------
>>  arch/arm/mach-shmobile/pm-sh7372.c     |    4 +--
>>  arch/arm/mach-tegra/cpuidle-tegra114.c |   27 +--------------
>>  arch/arm/mach-ux500/cpuidle.c          |   50 +---------------------------
>>  drivers/cpuidle/driver.c               |   35 ++++++++++++++++++--
>>  include/linux/clockchips.h             |   22 ++++++------
>>  include/linux/cpuidle.h                |    2 ++
>>  14 files changed, 120 insertions(+), 189 deletions(-)
> 
> What happened to the Calxeda driver?

On the way...


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
