From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 17 Jun 2011 14:12:58 +0530
Subject: [RFC PATCH 07/16] ARM: local timers: move OMAP4 to
	LOCAL_TIMER_DEVICES/ARM_SMP_TWD
In-Reply-To: <4DFB12BC.1010601@arm.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
	<1308251204-16719-8-git-send-email-marc.zyngier@arm.com>
	<4DFB0D49.4090702@ti.com> <4DFB12BC.1010601@arm.com>
Message-ID: <4DFB1392.8050209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/17/2011 2:09 PM, Marc Zyngier wrote:
> Hi Santosh,
>
> On 17/06/11 09:16, Santosh Shilimkar wrote:
>> On 6/17/2011 12:36 AM, Marc Zyngier wrote:
>>> Convert the OMAP4 platforms to use the new arm_smp_twd driver.
>>> Add the platform device and register it as early platform device.
>>>
>>> Tested on a Pandaboard.
>>>
>>> Cc: Tony Lindgren<tony@atomide.com>
>>> Cc: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>> Signed-off-by: Marc Zyngier<marc.zyngier@arm.com>
>>> ---
>>>    arch/arm/mach-omap2/Kconfig     |    3 +-
>>>    arch/arm/mach-omap2/Makefile    |    1 -
>>>    arch/arm/mach-omap2/timer-gp.c  |   40 ++++++++++++++++++++++++++++++++------
>>>    arch/arm/mach-omap2/timer-mpu.c |   40 ---------------------------------------
>>>    4 files changed, 35 insertions(+), 49 deletions(-)
>>>    delete mode 100644 arch/arm/mach-omap2/timer-mpu.c
>>>
>>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>>> index 19d5891..805d7b9 100644
>>> --- a/arch/arm/mach-omap2/Kconfig
>>> +++ b/arch/arm/mach-omap2/Kconfig
>>> @@ -44,7 +44,8 @@ config ARCH_OMAP4
>>>    	depends on ARCH_OMAP2PLUS
>>>    	select CPU_V7
>>>    	select ARM_GIC
>>> -	select LOCAL_TIMERS if SMP
>>> +	select LOCAL_TIMER_DEVICES if SMP
>>> +	select ARM_SMP_TWD
>>>    	select PL310_ERRATA_588369
>>>    	select PL310_ERRATA_727915
>>>    	select ARM_ERRATA_720789
>>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
>>> index b148077..f48c989 100644
>>> --- a/arch/arm/mach-omap2/Makefile
>>> +++ b/arch/arm/mach-omap2/Makefile
>>> @@ -22,7 +22,6 @@ obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
>>>
>>>    # SMP support ONLY available for OMAP4
>>>    obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
>>> -obj-$(CONFIG_LOCAL_TIMERS)		+= timer-mpu.o
>>>    obj-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
>>>    obj-$(CONFIG_ARCH_OMAP4)		+= omap44xx-smc.o omap4-common.o
>>>
>>> diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
>>> index 3b9cf85..f2f0db6 100644
>>> --- a/arch/arm/mach-omap2/timer-gp.c
>>> +++ b/arch/arm/mach-omap2/timer-gp.c
>>> @@ -35,10 +35,10 @@
>>>    #include<linux/irq.h>
>>>    #include<linux/clocksource.h>
>>>    #include<linux/clockchips.h>
>>> +#include<linux/platform_device.h>
>>>
>>>    #include<asm/mach/time.h>
>>>    #include<plat/dmtimer.h>
>>> -#include<asm/localtimer.h>
>>>    #include<asm/sched_clock.h>
>>>    #include<plat/common.h>
>>>    #include<plat/omap_hwmod.h>
>>> @@ -247,18 +247,44 @@ static void __init omap2_gp_clocksource_init(void)
>>>    }
>>>    #endif
>>>
>>> +#ifdef CONFIG_ARM_SMP_TWD
>>> +static struct resource omap2_gp_twd_resources[] = {
>>> +	{
>>> +		.start	= OMAP44XX_LOCAL_TWD_BASE,
>>> +		.end	= OMAP44XX_LOCAL_TWD_BASE + 0x10,
>>> +		.flags	= IORESOURCE_MEM,
>>> +	},
>>> +	{
>>> +		.start	= OMAP44XX_IRQ_LOCALTIMER,
>>> +		.end	= OMAP44XX_IRQ_LOCALTIMER,
>>> +		.flags	= IORESOURCE_IRQ,
>>> +	},
>>> +};
>>> +
>>> +static struct platform_device omap2_gp_twd_device = {
>>> +	.name		= "arm_smp_twd",
>>> +	.id		= -1,
>> Why is the id set to -1 ?
>
> This is the normal way of indicating that there is only one such device
> in the system. The device ends being called "arm_smp_twd" instead of
> "arm_smp_twd.0". See Documentation/driver-model/platform.txt for details.
>
Thanks. It's clear to me.

Regards
Santosh
