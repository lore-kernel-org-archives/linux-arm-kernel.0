From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Wed, 25 Feb 2015 13:03:52 +0100
Subject: [PATCH v2 14/18] ARM: Add STM32 family machine
In-Reply-To: <20150220200019.GU19388@pengutronix.de>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-15-git-send-email-mcoquelin.stm32@gmail.com>
 <20150220200019.GU19388@pengutronix.de>
Message-ID: <CALszF6CeWoTnqXBD3R8Qh4iRmUoAoUJFTBrbdNYXXQ8EWVvoLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-02-20 21:00 GMT+01:00 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Fri, Feb 20, 2015 at 07:01:13PM +0100, Maxime Coquelin wrote:
>> STMicrolectronics's STM32 series is a family of Cortex-M
>> microcontrollers. It is used in various applications, and
>> proposes a wide range of peripherals.
>>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> ---
>>  Documentation/arm/stm32/overview.txt           | 32 ++++++++++++++++++++++++++
>>  Documentation/arm/stm32/stm32f429-overview.txt | 22 ++++++++++++++++++
>>  arch/arm/Kconfig                               | 22 ++++++++++++++++++
>>  arch/arm/Makefile                              |  1 +
>>  arch/arm/mach-stm32/Makefile                   |  1 +
>>  arch/arm/mach-stm32/Makefile.boot              |  0
>>  arch/arm/mach-stm32/board-dt.c                 | 31 +++++++++++++++++++++++++
>>  7 files changed, 109 insertions(+)
>>  create mode 100644 Documentation/arm/stm32/overview.txt
>>  create mode 100644 Documentation/arm/stm32/stm32f429-overview.txt
>>  create mode 100644 arch/arm/mach-stm32/Makefile
>>  create mode 100644 arch/arm/mach-stm32/Makefile.boot
>>  create mode 100644 arch/arm/mach-stm32/board-dt.c
>>

<snip>

>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 97d07ed..cfd9532 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -774,6 +774,28 @@ config ARCH_OMAP1
>>       help
>>         Support for older TI OMAP1 (omap7xx, omap15xx or omap16xx)
>>
>> +config ARCH_STM32
>> +     bool "STMicrolectronics STM32"
>> +     depends on !MMU
>> +     select ARCH_REQUIRE_GPIOLIB
>> +     select ARM_NVIC
>> +     select AUTO_ZRELADDR
>> +     select ARCH_HAS_RESET_CONTROLLER
>> +     select RESET_CONTROLLER
>> +     select PINCTRL
>> +     select PINCTRL_STM32
>> +     select CLKSRC_OF
>> +     select ARMV7M_SYSTICK
>> +     select COMMON_CLK
>> +     select CPU_V7M
>> +     select GENERIC_CLOCKEVENTS
>> +     select NO_DMA
>> +     select NO_IOPORT_MAP
>> +     select SPARSE_IRQ
>> +     select USE_OF
> Please sort this list alphabetically.

Ok, I will do for v3.

>
>> +     help
>> +       Support for STMicorelectronics STM32 processors.
>> +
>>  endchoice
>>
>>  menu "Multiple platform selection"
>> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
>> index c1785ee..7d00659 100644
>> --- a/arch/arm/Makefile
>> +++ b/arch/arm/Makefile
>> @@ -196,6 +196,7 @@ machine-$(CONFIG_ARCH_SHMOBILE)   += shmobile
>>  machine-$(CONFIG_ARCH_SIRF)          += prima2
>>  machine-$(CONFIG_ARCH_SOCFPGA)               += socfpga
>>  machine-$(CONFIG_ARCH_STI)           += sti
>> +machine-$(CONFIG_ARCH_STM32)         += stm32
>>  machine-$(CONFIG_ARCH_SUNXI)         += sunxi
>>  machine-$(CONFIG_ARCH_TEGRA)         += tegra
>>  machine-$(CONFIG_ARCH_U300)          += u300
>> diff --git a/arch/arm/mach-stm32/Makefile b/arch/arm/mach-stm32/Makefile
>> new file mode 100644
>> index 0000000..bd0b7b5
>> --- /dev/null
>> +++ b/arch/arm/mach-stm32/Makefile
>> @@ -0,0 +1 @@
>> +obj-y += board-dt.o
>> diff --git a/arch/arm/mach-stm32/Makefile.boot b/arch/arm/mach-stm32/Makefile.boot
>> new file mode 100644
>> index 0000000..e69de29
> Maybe note there why this file exists and can be empty. Feel free to
> copy the content of efm32's Makefile.boot.

Ok, I will copy efm32's Makefile.boot content.
Do you know why your patch has not been applied yet?

>
>> diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
>> new file mode 100644
>> index 0000000..1d681b3
>> --- /dev/null
>> +++ b/arch/arm/mach-stm32/board-dt.c
>> @@ -0,0 +1,31 @@
>> +/*
>> + * Copyright (C) Maxime Coquelin 2015
>> + * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> + * License terms:  GNU General Public License (GPL), version 2
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/clocksource.h>
>> +#include <linux/reset-controller.h>
>> +#include <asm/v7m.h>
>> +#include <asm/mach/arch.h>
>> +
>> +static const char *const stm32_compat[] __initconst = {
>> +     "st,stm32f429",
>> +     NULL
>> +};
>> +
>> +static void __init stm32_timer_init(void)
>> +{
>> +     of_clk_init(NULL);
>> +     reset_controller_of_init();
>> +     clocksource_of_init();
> Hmm, if reset_controller_of_init was called automatically you wouldn't
> need that, right? Maybe arange for that instead?

This is what I did in the v1:
http://marc.info/?l=linux-arm-kernel&m=142376341008550&w=2

But Rob advised to put it elsewhere.

Thanks,
Maxime

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
