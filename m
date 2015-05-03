From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 3 May 2015 20:47:40 +0200
Subject: [PATCH v2 2/7] clocksource: add lpc32xx timer driver
In-Reply-To: <554558B5.70003@vanguardiasur.com.ar>
References: <1430168695-21248-1-git-send-email-manabian@gmail.com>
 <1430168695-21248-3-git-send-email-manabian@gmail.com>
 <554558B5.70003@vanguardiasur.com.ar>
Message-ID: <CAGhQ9Vwvp=NwuCF8x8xMRM_oBvff_+WcoQ0+OHfq-m72iYuGBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 May 2015 at 01:07, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:
> Hi Joachim,
>
> Just a small nitpick.
>
> On 04/27/2015 06:04 PM, Joachim Eastwood wrote:
>> Add support for using the NXP LPC timer as clocksource and
>> clock event. These timers are present on many NXP devices
>> including LPC32xx, LPC17xx, LPC18xx and LPC43xx.
>>
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> ---
>>  drivers/clocksource/Kconfig        |  10 ++
>>  drivers/clocksource/Makefile       |   1 +
>>  drivers/clocksource/time-lpc32xx.c | 258 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 269 insertions(+)
>>  create mode 100644 drivers/clocksource/time-lpc32xx.c
>>
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index 51d7865fdddb..71c532314f1d 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -106,6 +106,16 @@ config CLKSRC_EFM32
>>         Support to use the timers of EFM32 SoCs as clock source and clock
>>         event device.
>>
>> +config CLKSRC_LPC32XX
>> +     bool "Clocksource for NXP's LPC SoC series" if !ARCH_LPC18XX
>> +     depends on OF && ARM && (ARCH_LPC18XX || COMPILE_TEST)
>> +     select CLKSRC_MMIO
>> +     default ARCH_LPC18XX
>> +     help
>> +       Support to use the timers of LPC SoCs as clock source and clock
>> +       event device. These timers are present on many NXP devices
>> +       including LPC32xx, LPC17xx, LPC18xx and LPC43xx.
>> +
>>  config ARM_ARCH_TIMER
>>       bool
>>       select CLKSRC_OF if OF
>> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
>> index 5b85f6adb258..5928e35cb64d 100644
>> --- a/drivers/clocksource/Makefile
>> +++ b/drivers/clocksource/Makefile
>> @@ -37,6 +37,7 @@ obj-$(CONFIG_ARCH_BCM_MOBILE)       += bcm_kona_timer.o
>>  obj-$(CONFIG_CADENCE_TTC_TIMER)      += cadence_ttc_timer.o
>>  obj-$(CONFIG_CLKSRC_EFM32)   += time-efm32.o
>>  obj-$(CONFIG_CLKSRC_EXYNOS_MCT)      += exynos_mct.o
>> +obj-$(CONFIG_CLKSRC_LPC32XX) += time-lpc32xx.o
>>  obj-$(CONFIG_CLKSRC_SAMSUNG_PWM)     += samsung_pwm_timer.o
>>  obj-$(CONFIG_FSL_FTM_TIMER)  += fsl_ftm_timer.o
>>  obj-$(CONFIG_VF_PIT_TIMER)   += vf_pit_timer.o
>> diff --git a/drivers/clocksource/time-lpc32xx.c b/drivers/clocksource/time-lpc32xx.c
>> new file mode 100644
>> index 000000000000..8eb4bacceb74
>> --- /dev/null
>> +++ b/drivers/clocksource/time-lpc32xx.c
>> @@ -0,0 +1,258 @@
>> +/*
>> + * Clocksource driver for NXP LPC32xx/18xx/43xx timer
>> + *
>> + * Copyright (C) 2015 Joachim Eastwood <manabian@gmail.com>
>> + *
>> + * Based on:
>> + * time-efm32 Copyright (C) 2013 Pengutronix
>> + * mach-lpc32xx/timer.c Copyright (C) 2009 - 2010 NXP Semiconductors
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2. This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + *
>> + */
>> +
>
> You can use pr_fmt, right before the header includes:
>
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> and avoid using a __func__ argument in the pr_err's.

Since there are two init functions (clocksource and clockevent) I
think it's useful to prefix any error messages with the function name
and not just the module name. But using the pr_fmt does make the code
a bit nicer.

I will adopt the following macro for the next version.
#define pr_fmt(fmt) "%s: " fmt, __func__

Thanks for the tips about pr_fmt. I will use it in the next version.

> Some drivers use BUG() instead of printing errors, since the kernel
> won't do much without the timers. I guess it doesn't matter much.

That doesn't seem like a good practice. Printing errors is always nice
and in the case where you have multiple clocksources drivers doing a
BUG in any one of them would be a bad thing.
For example for this device (Cortex-M) the ARMv7-M systick clocksource
could be a backup if for some strange reason timer-lpc32xx would fail.

> Other than this, the driver looks good.
>
> Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thank you very much for taking the time to review.

regards,
Joachim Eastwood
