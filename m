From: tim.gardner@canonical.com (Tim Gardner)
Date: Fri, 13 Apr 2012 08:56:18 -0600
Subject: [PATCH 01/18] led-triggers: create a trigger for CPU activity
In-Reply-To: <1334316377-23915-2-git-send-email-bryan.wu@canonical.com>
References: <1334316377-23915-1-git-send-email-bryan.wu@canonical.com>
 <1334316377-23915-2-git-send-email-bryan.wu@canonical.com>
Message-ID: <4F883E92.60001@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2012 05:26 AM, Bryan Wu wrote:
> Attempting to consolidate the ARM LED code, this removes the
> custom RealView LED trigger code to turn LEDs on and off in
> response to CPU activity and replace it with a standard trigger.
> 
> (bryan.wu at canonical.com:
> It moves arch/arm/kernel/leds.c syscore stubs into this trigger.
> It also provides ledtrig_cpu trigger event stub in <linux/leds.h>.
> Although it was inspired by ARM work, it can be used in other arch.)
> 
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> 
> Reviewed-by: Jamie Iles <jamie@jamieiles.com>
> Tested-by: Jochen Friedrich <jochen@scram.de>
> ---
>  drivers/leds/Kconfig       |   10 ++++
>  drivers/leds/Makefile      |    1 +
>  drivers/leds/ledtrig-cpu.c |  133 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/leds.h       |   23 ++++++++
>  4 files changed, 167 insertions(+)
>  create mode 100644 drivers/leds/ledtrig-cpu.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 9f2b8dd..6e445a0 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -457,6 +457,16 @@ config LEDS_TRIGGER_BACKLIGHT
>  
>  	  If unsure, say N.
>  
> +config LEDS_TRIGGER_CPU
> +	tristate "LED CPU Trigger"
> +	depends on LEDS_TRIGGERS
> +	help
> +	  This allows LEDs to be controlled by active CPUs. This shows
> +	  the active CPUs across an array of LEDs so you can see what
> +	  CPUs are active on the system at any given moment.
> +
> +	  If unsure, say N.
> +
>  config LEDS_TRIGGER_GPIO
>  	tristate "LED GPIO Trigger"
>  	depends on LEDS_TRIGGERS
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 14481cf..8bb20e6 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -55,4 +55,5 @@ obj-$(CONFIG_LEDS_TRIGGER_IDE_DISK)	+= ledtrig-ide-disk.o
>  obj-$(CONFIG_LEDS_TRIGGER_HEARTBEAT)	+= ledtrig-heartbeat.o
>  obj-$(CONFIG_LEDS_TRIGGER_BACKLIGHT)	+= ledtrig-backlight.o
>  obj-$(CONFIG_LEDS_TRIGGER_GPIO)		+= ledtrig-gpio.o
> +obj-$(CONFIG_LEDS_TRIGGER_CPU)		+= ledtrig-cpu.o
>  obj-$(CONFIG_LEDS_TRIGGER_DEFAULT_ON)	+= ledtrig-default-on.o
> diff --git a/drivers/leds/ledtrig-cpu.c b/drivers/leds/ledtrig-cpu.c
> new file mode 100644
> index 0000000..52ef19c
> --- /dev/null
> +++ b/drivers/leds/ledtrig-cpu.c
> @@ -0,0 +1,133 @@
> +/*
> + * ledtrig-cpu.c - LED trigger based on CPU activity
> + *
> + * This LED trigger will be registered for each possible CPU and named as
> + * cpu0, cpu1, cpu2, cpu3, etc.
> + *
> + * It can be binded with any LEDs as other triggers does, either in board
> + * file or via sysfs interface.
> + *

"It can be bound to any LED just like other triggers using either a
board file or via sysfs interface."

> + * An API named ledtrig_cpu is exported for any user, who want to add CPU
> + * activity indication in their code
> + *
> + * Copyright 2011 Linus Walleij <linus.walleij@linaro.org>
> + * Copyright 2011 - 2012 Bryan Wu <bryan.wu@canonical.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/percpu.h>
> +#include <linux/syscore_ops.h>
> +#include "leds.h"
> +
> +#define MAX_NAME_LEN	8
> +

This length accommodates up to 10000 CPUs. How long will that suffice ?

> +static DEFINE_PER_CPU(struct led_trigger *, cpu_trig);
> +static DEFINE_PER_CPU(char [MAX_NAME_LEN], trig_name);
> +
> +void ledtrig_cpu(enum cpu_led_event ledevt)
> +{
> +	struct led_trigger *trig = __get_cpu_var(cpu_trig);
> +
> +	if (!trig)
> +		return;

I don't think __get_cpu_var(cpu_trig) _should_ ever return NULL. See
discussion about exclusion below in ledtrig_cpu_init().

> +
> +	/* Locate the correct CPU LED */
> +	switch (ledevt) {
> +	case CPU_LED_IDLE_END:
> +	case CPU_LED_START:
> +		/* Will turn the LED on, max brightness */
> +		led_trigger_event(trig, LED_FULL);
> +		break;
> +
> +	case CPU_LED_IDLE_START:
> +	case CPU_LED_STOP:
> +	case CPU_LED_HALTED:
> +		/* Will turn the LED off */
> +		led_trigger_event(trig, LED_OFF);
> +		break;
> +
> +	default:
> +		/* Will leave the LED as it is */
> +		break;
> +	}
> +}
> +EXPORT_SYMBOL(ledtrig_cpu);
> +
> +static int ledtrig_cpu_syscore_suspend(void)
> +{
> +	ledtrig_cpu(CPU_LED_STOP);
> +	return 0;
> +}
> +
> +static void ledtrig_cpu_syscore_resume(void)
> +{
> +	ledtrig_cpu(CPU_LED_START);
> +}
> +
> +static void ledtrig_cpu_syscore_shutdown(void)
> +{
> +	ledtrig_cpu(CPU_LED_HALTED);
> +}
> +
> +static struct syscore_ops ledtrig_cpu_syscore_ops = {
> +	.shutdown	= ledtrig_cpu_syscore_shutdown,
> +	.suspend	= ledtrig_cpu_syscore_suspend,
> +	.resume		= ledtrig_cpu_syscore_resume,
> +};
> +
> +static int __init ledtrig_cpu_init(void)
> +{
> +	int cpu;
> +
> +	/*
> +	 * Registering CPU led trigger for each CPU cores here
> +	 * ignores CPU hotplug, but after this CPU hotplug works
> +	 * fine with this trigger.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		struct led_trigger *trig;
> +		char *name = per_cpu(trig_name, cpu);
> +
> +		snprintf(name, MAX_NAME_LEN, "cpu%d", cpu);
> +		led_trigger_register_simple(name, &trig);

Check for trig == NULL. led_trigger_register_simple() does a
kzalloc(GFP_KERNEL). You'll also have to unwind any successful
registrations. Perhaps carve the guts out of ledtrig_cpu_exit() into a
function that can be called from either place.

Furthermore, I think there is a race here. As soon as
led_trigger_register_simple() has completed, then the trigger is
available for use. Won't you need some kind of exclusion to block
consumers before trig is assigned ? There is a similar problem in
ledtrig_cpu().

> +		per_cpu(cpu_trig, cpu) = trig;
> +
> +		pr_info("LED trigger %s indicate activity on CPU %d\n",
> +			trig->name, cpu);

This seems like an unnecessary log filler, especially as the number of
CPUs becomes large. How about just a single line after the loop completes ?

> +	}
> +
> +	register_syscore_ops(&ledtrig_cpu_syscore_ops);
> +
> +	return 0;
> +}
> +module_init(ledtrig_cpu_init);
> +
> +static void __exit ledtrig_cpu_exit(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct led_trigger *trig = per_cpu(cpu_trig, cpu);
> +		char *name = per_cpu(trig_name, cpu);
> +
> +		led_trigger_unregister_simple(trig);
> +		per_cpu(cpu_trig, cpu) = NULL;
> +		memset(name, 0, MAX_NAME_LEN);
> +	}
> +
> +	unregister_syscore_ops(&ledtrig_cpu_syscore_ops);
> +}
> +module_exit(ledtrig_cpu_exit);
> +
> +MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
> +MODULE_AUTHOR("Bryan Wu <bryan.wu@canonical.com>");
> +MODULE_DESCRIPTION("CPU LED trigger");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index 5884def..1215b94 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -210,4 +210,27 @@ struct gpio_led_platform_data {
>  struct platform_device *gpio_led_register_device(
>  		int id, const struct gpio_led_platform_data *pdata);
>  
> +enum cpu_led_event {
> +	CPU_LED_IDLE_START,	/* CPU enters idle */
> +	CPU_LED_IDLE_END,	/* CPU idle ends */
> +	CPU_LED_START,		/* Machine starts, especially resume */
> +	CPU_LED_STOP,		/* Machine stops, especially suspend */
> +	CPU_LED_HALTED,		/* Machine shutdown */
> +};
> +#if defined(CONFIG_LEDS_TRIGGER_CPU) || defined(CONFIG_LEDS_TRIGGER_CPU_MODULE)
> +/**
> + * ledtrig_cpu - emit a CPU event as a trigger
> + * @evt: CPU event to be emitted
> + *
> + * Emit a CPU event on a CPU core, which will trigger a
> + * binded LED to turn on or turn off.
> + */
> +extern void ledtrig_cpu(enum cpu_led_event evt);
> +#else
> +static inline void ledtrig_cpu(enum cpu_led_event evt)
> +{
> +	return;
> +}
> +#endif
> +
>  #endif		/* __LINUX_LEDS_H_INCLUDED */


-- 
Tim Gardner tim.gardner at canonical.com
