From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 29 Sep 2009 16:15:39 +0200
Subject: [PATCH v2] Add cpuidle support for at91
In-Reply-To: <20090909151417.GA4014@pc-ras4041.res.insa>
References: <1247680190-19674-1-git-send-email-albin.tonnerre@free-electrons.com>
	<200908111200.58866.marc.pignat@hevs.ch>
	<20090812165700.GC4051@pc-ras4041.res.insa>
	<200908130858.47487.marc.pignat@hevs.ch>
	<20090813193241.GA5985@pc-ras4041.res.insa>
	<20090909151417.GA4014@pc-ras4041.res.insa>
Message-ID: <4AC2168B.60903@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Salut Albin !

Albin Tonnerre :
> Nicolas, Andrew: ping?

Indeed it's been a long time...

> On Thu, 13 Aug 2009 21:32 +0200, Albin Tonnerre wrote :
>> This patch adds the support for cpuidle on AT91 SoCs, taken from the
>> cpuidle support in mach-kirkwood.
>> cpuidle needs sdram_selfrefresh_enable and _disable, so move their
>> definition to a separate header file instead of duplicating the code
>> already used in pm.c.
>>
>> Signed-off-by: Albin Tonnerre <albin.tonnerre@free-electrons.com>

[nicolas.ferre at atmel.com: tested on at91sam9263ek]
Tested-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Works very well and allow to save some power. After quick measures, we
run at 172mA at 12V instead of 190mA at 12V so ~2.06W and a saving of ~10% :
nice job !
This is of course in my test conditions.

Just one precision: what is the difference, entering state0 with only
the current cpu_do_idle() that is activated by default ?

>> ---
>> Changelog since V1:
>> Updated thanks to feedback from Marc Pignat:
>>  - On AT91RM200, it is necessary to make sure that the Low-power mode is
>>    left before entering the self-refresh mode
>>  - Document the fact that restoring the low-power mode when we're not
>>    sure we're out of self-refresh mode is not recommended on RM200
>>
>>  arch/arm/mach-at91/Makefile  |    1 +
>>  arch/arm/mach-at91/cpuidle.c |  101 ++++++++++++++++++++++++++++++++++++++++++
>>  arch/arm/mach-at91/pm.c      |   62 ++------------------------
>>  arch/arm/mach-at91/pm.h      |   62 ++++++++++++++++++++++++++
>>  4 files changed, 168 insertions(+), 58 deletions(-)
>>  mode change 100644 => 100755 arch/arm/mach-at91/Makefile
>>  create mode 100644 arch/arm/mach-at91/cpuidle.c
>>  create mode 100644 arch/arm/mach-at91/pm.h
>>
>> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
>> old mode 100644
>> new mode 100755
>> index c69ff23..06d189d
>> --- a/arch/arm/mach-at91/Makefile
>> +++ b/arch/arm/mach-at91/Makefile
>> @@ -67,6 +67,7 @@ obj-y				+= leds.o
>>  # Power Management
>>  obj-$(CONFIG_PM)		+= pm.o
>>  obj-$(CONFIG_AT91_SLOW_CLOCK)	+= pm_slowclock.o
>> +obj-$(CONFIG_CPU_IDLE)	+= cpuidle.o
>>  
>>  ifeq ($(CONFIG_PM_DEBUG),y)
>>  CFLAGS_pm.o += -DDEBUG
>> diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
>> new file mode 100644
>> index 0000000..9146135
>> --- /dev/null
>> +++ b/arch/arm/mach-at91/cpuidle.c
>> @@ -0,0 +1,101 @@
>> +/*
>> + * based on arch/arm/mach-kirkwood/cpuidle.c
>> + *
>> + * CPU idle support for AT91 SoC
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + *
>> + * The cpu idle uses wait-for-interrupt and RAM self refresh in order
>> + * to implement two idle states -
>> + * #1 wait-for-interrupt
>> + * #2 wait-for-interrupt and RAM self refresh
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/cpuidle.h>
>> +#include <asm/proc-fns.h>
>> +#include <linux/io.h>
>> +
>> +#include "pm.h"
>> +
>> +#define AT91_MAX_STATES	2
>> +
>> +static DEFINE_PER_CPU(struct cpuidle_device, at91_cpuidle_device);
>> +
>> +static struct cpuidle_driver at91_idle_driver = {
>> +	.name =         "at91_idle",
>> +	.owner =        THIS_MODULE,
>> +};
>> +
>> +/* Actual code that puts the SoC in different idle states */
>> +static int at91_enter_idle(struct cpuidle_device *dev,
>> +			       struct cpuidle_state *state)
>> +{
>> +	struct timeval before, after;
>> +	int idle_time;
>> +	u32 saved_lpr;
>> +
>> +	local_irq_disable();
>> +	do_gettimeofday(&before);
>> +	if (state == &dev->states[0])
>> +		/* Wait for interrupt state */
>> +		cpu_do_idle();
>> +	else if (state == &dev->states[1]) {
>> +		asm("b 1f; .align 5; 1:");
>> +		asm("mcr p15, 0, r0, c7, c10, 4");	/* drain write buffer */
>> +		saved_lpr = sdram_selfrefresh_enable();
>> +		cpu_do_idle();
>> +		/*
>> +		 * On AT91RM200, self-refresh mode is exited as soon as a memory access
>> +		 * is made, but we don't know for sure when that happens. However, we
>> +		 * need to restore the low-power mode if it was enabled before going
>> +		 * idle. Restoring low-power mode while still in self-refresh is "not
>> +		 * recommended", but seems to work.
>> +		 */
>> +		sdram_selfrefresh_disable(saved_lpr);
>> +	}
>> +	do_gettimeofday(&after);
>> +	local_irq_enable();
>> +	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
>> +			(after.tv_usec - before.tv_usec);
>> +	return idle_time;
>> +}
>> +
>> +/* Initialize CPU idle by registering the idle states */
>> +static int at91_init_cpuidle(void)
>> +{
>> +	struct cpuidle_device *device;
>> +
>> +	cpuidle_register_driver(&at91_idle_driver);
>> +
>> +	device = &per_cpu(at91_cpuidle_device, smp_processor_id());
>> +	device->state_count = AT91_MAX_STATES;
>> +
>> +	/* Wait for interrupt state */
>> +	device->states[0].enter = at91_enter_idle;
>> +	device->states[0].exit_latency = 1;
>> +	device->states[0].target_residency = 10000;
>> +	device->states[0].flags = CPUIDLE_FLAG_TIME_VALID;
>> +	strcpy(device->states[0].name, "WFI");
>> +	strcpy(device->states[0].desc, "Wait for interrupt");
>> +
>> +	/* Wait for interrupt and RAM self refresh state */
>> +	device->states[1].enter = at91_enter_idle;
>> +	device->states[1].exit_latency = 10;
>> +	device->states[1].target_residency = 10000;
>> +	device->states[1].flags = CPUIDLE_FLAG_TIME_VALID;
>> +	strcpy(device->states[1].name, "RAM_SR");
>> +	strcpy(device->states[1].desc, "WFI and RAM Self Refresh");
>> +
>> +	if (cpuidle_register_device(device)) {
>> +		printk(KERN_ERR "at91_init_cpuidle: Failed registering\n");
>> +		return -EIO;
>> +	}
>> +	return 0;
>> +}
>> +
>> +device_initcall(at91_init_cpuidle);
>> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
>> index e26c4fe..0a68c46 100644
>> --- a/arch/arm/mach-at91/pm.c
>> +++ b/arch/arm/mach-at91/pm.c
>> @@ -29,62 +29,7 @@
>>  #include <mach/cpu.h>
>>  
>>  #include "generic.h"
>> -
>> -#ifdef CONFIG_ARCH_AT91RM9200
>> -#include <mach/at91rm9200_mc.h>
>> -
>> -/*
>> - * The AT91RM9200 goes into self-refresh mode with this command, and will
>> - * terminate self-refresh automatically on the next SDRAM access.
>> - */
>> -#define sdram_selfrefresh_enable()	at91_sys_write(AT91_SDRAMC_SRR, 1)
>> -#define sdram_selfrefresh_disable()	do {} while (0)
>> -
>> -#elif defined(CONFIG_ARCH_AT91CAP9)
>> -#include <mach/at91cap9_ddrsdr.h>
>> -
>> -static u32 saved_lpr;
>> -
>> -static inline void sdram_selfrefresh_enable(void)
>> -{
>> -	u32 lpr;
>> -
>> -	saved_lpr = at91_sys_read(AT91_DDRSDRC_LPR);
>> -
>> -	lpr = saved_lpr & ~AT91_DDRSDRC_LPCB;
>> -	at91_sys_write(AT91_DDRSDRC_LPR, lpr | AT91_DDRSDRC_LPCB_SELF_REFRESH);
>> -}
>> -
>> -#define sdram_selfrefresh_disable()	at91_sys_write(AT91_DDRSDRC_LPR, saved_lpr)
>> -
>> -#else
>> -#include <mach/at91sam9_sdramc.h>
>> -
>> -#ifdef CONFIG_ARCH_AT91SAM9263
>> -/*
>> - * FIXME either or both the SDRAM controllers (EB0, EB1) might be in use;
>> - * handle those cases both here and in the Suspend-To-RAM support.
>> - */
>> -#define	AT91_SDRAMC	AT91_SDRAMC0
>> -#warning Assuming EB1 SDRAM controller is *NOT* used
>> -#endif
>> -
>> -static u32 saved_lpr;
>> -
>> -static inline void sdram_selfrefresh_enable(void)
>> -{
>> -	u32 lpr;
>> -
>> -	saved_lpr = at91_sys_read(AT91_SDRAMC_LPR);
>> -
>> -	lpr = saved_lpr & ~AT91_SDRAMC_LPCB;
>> -	at91_sys_write(AT91_SDRAMC_LPR, lpr | AT91_SDRAMC_LPCB_SELF_REFRESH);
>> -}
>> -
>> -#define sdram_selfrefresh_disable()	at91_sys_write(AT91_SDRAMC_LPR, saved_lpr)
>> -
>> -#endif
>> -
>> +#include "pm.h"
>>  
>>  /*
>>   * Show the reason for the previous system reset.
>> @@ -259,6 +204,7 @@ extern u32 at91_slow_clock_sz;
>>  
>>  static int at91_pm_enter(suspend_state_t state)
>>  {
>> +	u32 saved_lpr;
>>  	at91_gpio_suspend();
>>  	at91_irq_suspend();
>>  
>> @@ -314,9 +260,9 @@ static int at91_pm_enter(suspend_state_t state)
>>  			 */
>>  			asm("b 1f; .align 5; 1:");
>>  			asm("mcr p15, 0, r0, c7, c10, 4");	/* drain write buffer */
>> -			sdram_selfrefresh_enable();
>> +			saved_lpr = sdram_selfrefresh_enable();
>>  			asm("mcr p15, 0, r0, c7, c0, 4");	/* wait for interrupt */
>> -			sdram_selfrefresh_disable();
>> +			sdram_selfrefresh_disable(saved_lpr);
>>  			break;
>>  
>>  		case PM_SUSPEND_ON:
>> diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
>> new file mode 100644
>> index 0000000..0b8b717
>> --- /dev/null
>> +++ b/arch/arm/mach-at91/pm.h
>> @@ -0,0 +1,62 @@
>> +#ifdef CONFIG_ARCH_AT91RM9200
>> +#include <mach/at91rm9200_mc.h>
>> +
>> +/*
>> + * The AT91RM9200 goes into self-refresh mode with this command, and will
>> + * terminate self-refresh automatically on the next SDRAM access.
>> + */
>> +
>> +static inline u32 sdram_selfrefresh_enable(void)
>> +{
>> +	u32 saved_lpr = at91_sys_read(AT91_SDRAMC_LPR);
>> +
>> +	at91_sys_write(AT91_SDRAMC_LPR, 0);
>> +	at91_sys_write(AT91_SDRAMC_SRR, 1);
>> +	return saved_lpr;
>> +}
>> +
>> +#define sdram_selfrefresh_disable(saved_lpr)	do { at91_sys_write(AT91_SDRAMC_LPR, saved_lpr); } while (0)
>> +
>> +#elif defined(CONFIG_ARCH_AT91CAP9)
>> +#include <mach/at91cap9_ddrsdr.h>
>> +
>> +
>> +static inline u32 sdram_selfrefresh_enable(void)
>> +{
>> +	u32 saved_lpr, lpr;
>> +
>> +	saved_lpr = at91_sys_read(AT91_DDRSDRC_LPR);
>> +
>> +	lpr = saved_lpr & ~AT91_DDRSDRC_LPCB;
>> +	at91_sys_write(AT91_DDRSDRC_LPR, lpr | AT91_DDRSDRC_LPCB_SELF_REFRESH);
>> +	return saved_lpr;
>> +}
>> +
>> +#define sdram_selfrefresh_disable(saved_lpr)	at91_sys_write(AT91_DDRSDRC_LPR, saved_lpr)
>> +
>> +#else
>> +#include <mach/at91sam9_sdramc.h>
>> +
>> +#ifdef CONFIG_ARCH_AT91SAM9263
>> +/*
>> + * FIXME either or both the SDRAM controllers (EB0, EB1) might be in use;
>> + * handle those cases both here and in the Suspend-To-RAM support.
>> + */
>> +#define	AT91_SDRAMC	AT91_SDRAMC0
>> +#warning Assuming EB1 SDRAM controller is *NOT* used
>> +#endif
>> +
>> +static inline u32 sdram_selfrefresh_enable(void)
>> +{
>> +	u32 saved_lpr, lpr;
>> +
>> +	saved_lpr = at91_sys_read(AT91_SDRAMC_LPR);
>> +
>> +	lpr = saved_lpr & ~AT91_SDRAMC_LPCB;
>> +	at91_sys_write(AT91_SDRAMC_LPR, lpr | AT91_SDRAMC_LPCB_SELF_REFRESH);
>> +	return saved_lpr;
>> +}
>> +
>> +#define sdram_selfrefresh_disable(saved_lpr)	at91_sys_write(AT91_SDRAMC_LPR, saved_lpr)
>> +
>> +#endif


-- 
Nicolas Ferre
