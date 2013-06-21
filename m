From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 21 Jun 2013 12:51:26 +0200
Subject: [RFC patch 2/2] ARM: at91: cpuidle: move the driver to
 drivers/cpuidle directory
In-Reply-To: <516DD310.6030006@linaro.org>
References: <1366032598-23053-1-git-send-email-daniel.lezcano@linaro.org>
 <1366032598-23053-3-git-send-email-daniel.lezcano@linaro.org>
 <20130415142047.GE15139@game.jcrosoft.org> <516C10C5.4050107@linaro.org>
 <20130415160041.GF15139@game.jcrosoft.org> <516DD310.6030006@linaro.org>
Message-ID: <51C4302E.8010707@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2013 12:39 AM, Daniel Lezcano wrote:
> On 04/15/2013 06:00 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> On 16:37 Mon 15 Apr     , Daniel Lezcano wrote:
>>> On 04/15/2013 04:20 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>> On 15:29 Mon 15 Apr     , Daniel Lezcano wrote:
>>>>> We don't have any dependency with the SoC specific code.
>>>>>
>>>>> Move the driver to the drivers/cpuidle directory.
>>>>>
>>>>> Add Nicolas Ferre as author of the driver, so it will be in copy of the emails.
>>>>>
>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> please use -M when generating the patch
>>>
>>> Oh, right. Thanks for reminding me the option.
>>>
>>> [ ... ]
>>>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/init.h>
>>>>> +#include <linux/cpuidle.h>
>>>>> +#include <asm/cpuidle.h>
>>>>> +
>>>>> +#define AT91_MAX_STATES	2
>>>>> +
>>>>> +extern void (*at91_standby_ops)(void);
>>>> really don't like can we pass it via the pm?
>>>
>>> I agree, it is hackish. Can you elaborate when you say "pass it via the
>>> pm" ?
>>
>> I was thinking about it
>>
>> I would even prefer to have a platfrom driver that pass it via platform data
>> even in DT
>>
>> but not something that can touch globally
>>
>> and for drivers I prefer to do not use cpu_is only for the core
> 
> Is the following code what you had in mind ?

Hi Jean-Christophe,

coming back to move the cpuidle driver to drivers/cpuidle.

I was wondering if the code below would be ok for you ?

Thanks
  -- Daniel


> Please, be lenient, it is the first time I write something based on
> 'platform' :)
> 
> 
> Index: cpuidle-next/arch/arm/mach-at91/cpuidle.c
> ===================================================================
> --- cpuidle-next.orig/arch/arm/mach-at91/cpuidle.c      2013-04-16
> 10:40:21.058315042 +0200
> +++ cpuidle-next/arch/arm/mach-at91/cpuidle.c   2013-04-17
> 00:35:42.836314931 +0200
> @@ -13,32 +13,22 @@
>   * #2 wait-for-interrupt and RAM self refresh
>   */
> 
> -#include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/init.h>
> -#include <linux/platform_device.h>
>  #include <linux/cpuidle.h>
> -#include <linux/io.h>
> -#include <linux/export.h>
> -#include <asm/proc-fns.h>
> +#include <linux/platform_device.h>
>  #include <asm/cpuidle.h>
> -#include <mach/cpu.h>
> -
> -#include "pm.h"
> 
>  #define AT91_MAX_STATES        2
> 
> +static void (*at91_standby_ops)(void);
> +
>  /* Actual code that puts the SoC in different idle states */
>  static int at91_enter_idle(struct cpuidle_device *dev,
>                         struct cpuidle_driver *drv,
>                                int index)
>  {
> -       if (cpu_is_at91rm9200())
> -               at91rm9200_standby();
> -       else if (cpu_is_at91sam9g45())
> -               at91sam9g45_standby();
> -       else
> -               at91sam9_standby();
> -
> +       at91_standby_ops();
>         return index;
>  }
> 
> @@ -58,9 +48,16 @@ static struct cpuidle_driver at91_idle_d
>  };
> 
>  /* Initialize CPU idle by registering the idle states */
> -static int __init at91_init_cpuidle(void)
> +int __init at91_init_cpuidle(struct platform_device *pdev)
>  {
> -       return cpuidle_register(&at91_idle_driver, NULL);
> +       at91_standby_ops = pdata;
> +       return 0;
>  }
> 
> -device_initcall(at91_init_cpuidle);
> +static int __init at91_cpuidle_init(void)
> +{
> +
> +
> +       return cpuidle_register(&at91_idle_driver, NULL);
> +}
> +device_initcall(at91_cpuidle_init);
> Index: cpuidle-next/arch/arm/mach-at91/pm.c
> ===================================================================
> --- cpuidle-next.orig/arch/arm/mach-at91/pm.c   2013-04-16
> 09:52:33.048426618 +0200
> +++ cpuidle-next/arch/arm/mach-at91/pm.c        2013-04-16
> 18:22:03.207420375 +0200
> @@ -312,21 +312,40 @@ static const struct platform_suspend_ops
>         .end    = at91_pm_end,
>  };
> 
> -static int __init at91_pm_init(void)
> +static int __init at91_pm_probe(struct platform_device *pdev)
>  {
> -#ifdef CONFIG_AT91_SLOW_CLOCK
> -       slow_clock = (void *) (AT91_IO_VIRT_BASE - at91_slow_clock_sz);
> -#endif
> -
> -       pr_info("AT91: Power Management%s\n", (slow_clock ? " (with slow
> clock mode)" : ""));
> -
>         /* AT91RM9200 SDRAM low-power mode cannot be used with
> self-refresh. */
> -       if (cpu_is_at91rm9200())
> +       if (of_machine_is_compatible("atmel,at91rm9200")) {
>                 at91_ramc_write(0, AT91RM9200_SDRAMC_LPR, 0);
> +               pdev->dev.platform_data = at91rm9200_standby;
> +       } else if (of_machine_is_compatible("atmel,atmel,at91sam9g45")) {
> +               pdev->dev.platform_data = at91sam9g45_standby;
> +       } else {
> +               pdev->dev.platform_data = at91sam9_standby;
> +       }
> 
>         suspend_set_ops(&at91_pm_ops);
> 
>         show_reset_status();
> +
>         return 0;
>  }
> +
> +static struct platform_driver at91_pm_driver = {
> +       .driver = {
> +               .name    = "pm-at91",
> +               .owner   = THIS_MODULE,
> +       },
> +};
> +
> +static int __init at91_pm_init(void)
> +{
> +#ifdef CONFIG_AT91_SLOW_CLOCK
> +       slow_clock = (void *) (AT91_IO_VIRT_BASE - at91_slow_clock_sz);
> +#endif
> +       pr_info("AT91: Power Management%s\n",
> +               (slow_clock ? " (with slow clock mode)" : ""));
> +
> +       return platform_driver_probe(&at91_pm_driver, at91_pm_probe);
> +}
>  arch_initcall(at91_pm_init);
> Index: cpuidle-next/arch/arm/mach-at91/board-usb-a926x.c
> ===================================================================
> --- cpuidle-next.orig/arch/arm/mach-at91/board-usb-a926x.c
> 2013-04-15 10:31:45.503051053 +0200
> +++ cpuidle-next/arch/arm/mach-at91/board-usb-a926x.c   2013-04-17
> 00:35:38.480314758 +0200
> @@ -49,7 +49,6 @@
>  #include "sam9_smc.h"
>  #include "generic.h"
> 
> -
>  static void __init ek_init_early(void)
>  {
>         /* Initialize processor: 12.00 MHz crystal */
> @@ -319,6 +318,19 @@ static void __init ek_add_device_leds(vo
>         at91_gpio_leds(ek_leds, ARRAY_SIZE(ek_leds));
>  }
> 
> +#ifdef CONFIG_PM
> +static struct platform_device at91_pm_device = {
> +       .name = "pm-at91",
> +       .id = -1,
> +};
> +#endif
> +
> +static struct platform_device *platform_devices[] __initdata = {
> +#ifdef CONFIG_PM
> +       &at91_pm_device,
> +#endif
> +}
> +
>  static void __init ek_board_init(void)
>  {
>         /* Serial */
> @@ -351,6 +363,9 @@ static void __init ek_board_init(void)
>                                 | AT91_SHDW_WKMODE0_LOW
>                                 | AT91_SHDW_RTTWKEN);
>         }
> +
> +       /* Platform devices */
> +       platform_add_devices(&platform_devices,
> ARRAY_SIZE(platform_devices));
>  }
> 
>  MACHINE_START(USB_A9263, "CALAO USB_A9263")
> 
> 
> if (of_machine_is_compatible("atmel,at91rm9200")) {
> 	printk("at91rm9200\n");
> } else if (of_machine_is_compatible("atmel,atmel,at91sam9g45")) {
> 	printk(at91sam9g45\n");
> } else {
> 	printk(other at91 cpu\n");
> }
> 
>>
>> Best Regards,
>> J.
>>>
>>>
>>>
>>> -- 
>>>  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
>>>
>>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>>> <http://twitter.com/#!/linaroorg> Twitter |
>>> <http://www.linaro.org/linaro-blog/> Blog
>>>
> 
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
