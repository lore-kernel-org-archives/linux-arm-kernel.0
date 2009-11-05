From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 5 Nov 2009 22:36:14 +0800
Subject: [PATCH 02/02] pxa: extend gpio pins from 128 to 256
In-Reply-To: <f17812d70911050537rf925e09md0e73f7cb4224744@mail.gmail.com>
References: <771cded00911041858g437c5b35t3f76497d6668f949@mail.gmail.com>
	<f17812d70911050537rf925e09md0e73f7cb4224744@mail.gmail.com>
Message-ID: <771cded00911050636o784c7fb0v254871b41ae4faa0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 5, 2009 at 9:37 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Thu, Nov 5, 2009 at 10:58 AM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
>> From 859055136e56e4342ab1869f0050633ab52607e0 Mon Sep 17 00:00:00 2001
>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Date: Thu, 5 Nov 2009 05:37:26 -0500
>> Subject: [PATCH] [ARM] pxa: extend gpio pins from 128 to 256
>>
>> GPIO pins exceeds 128 pins on PXA935. Extend IRQ GPIO to support it.
>> Add new macro mfp256_to_gpio() and PXA935_NR_BUILTIN_GPIO.
>>
>> Original mfp_to_gpio() and NR_BUILTIN_GPIO isn't changed.
>
> Will this impact the possibility of pxa935 being not able to build with
> other pxa?
>
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> ---
>> ?arch/arm/mach-pxa/include/mach/gpio.h | ? ?3 ++-
>> ?arch/arm/mach-pxa/include/mach/irqs.h | ? ?2 +-
>> ?arch/arm/mach-pxa/pxa3xx.c ? ? ? ? ? ?| ? ?2 +-
>> ?arch/arm/plat-pxa/include/plat/mfp.h ?| ? ?3 ++-
>> ?4 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-pxa/include/mach/gpio.h
>> b/arch/arm/mach-pxa/include/mach/gpio.h
>> index b024a8b..d08227d 100644
>> --- a/arch/arm/mach-pxa/include/mach/gpio.h
>> +++ b/arch/arm/mach-pxa/include/mach/gpio.h
>> @@ -99,7 +99,8 @@
>> ?#define GAFR(x) ? ? ? ? ? ? ? ?GPIO_REG(0x54 + (((x) & 0x70) >> 2))
>>
>>
>> -#define NR_BUILTIN_GPIO 128
>> +#define NR_BUILTIN_GPIO ? ? ? ? ? ? ? ?128
>> +#define PXA935_NR_BUILTIN_GPIO 256
>>
>> ?#define gpio_to_bank(gpio) ? ? ((gpio) >> 5)
>> ?#define gpio_to_irq(gpio) ? ? ?IRQ_GPIO(gpio)
>> diff --git a/arch/arm/mach-pxa/include/mach/irqs.h
>> b/arch/arm/mach-pxa/include/mach/irqs.h
>> index 3677a9a..9565b0f 100644
>> --- a/arch/arm/mach-pxa/include/mach/irqs.h
>> +++ b/arch/arm/mach-pxa/include/mach/irqs.h
>> @@ -106,7 +106,7 @@
>> ?#endif
>>
>> ?#define PXA_GPIO_IRQ_BASE ? ? ?PXA_IRQ(96)
>> -#define PXA_GPIO_IRQ_NUM ? ? ? (192)
>> +#define PXA_GPIO_IRQ_NUM ? ? ? (256)
>>
>> ?#define GPIO_2_x_TO_IRQ(x) ? ? (PXA_GPIO_IRQ_BASE + (x))
>> ?#define IRQ_GPIO(x) ? ?(((x) < 2) ? (IRQ_GPIO0 + (x)) : GPIO_2_x_TO_IRQ(x))
>> diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
>> index 09b7b1a..7783ac9 100644
>> --- a/arch/arm/mach-pxa/pxa3xx.c
>> +++ b/arch/arm/mach-pxa/pxa3xx.c
>> @@ -539,7 +539,7 @@ void __init pxa3xx_init_irq(void)
>> ? ? ? ?__asm__ __volatile__("mcr p15, 0, %0, c15, c1, 0\n": :"r"(value));
>>
>> ? ? ? ?pxa_init_irq(56, pxa3xx_set_wake);
>> - ? ? ? pxa_init_gpio(IRQ_GPIO_2_x, 2, 127, NULL);
>> + ? ? ? pxa_init_gpio(IRQ_GPIO_2_x, 2, 255, NULL);
>
> This isn't ideal, provided on most pxa3xx there are less than 127 GPIOs.
> I'd suggest we invent pxa935_init_irq() to support IRQs more than 56,
> and more GPIOs, possibly in pxa930.c (and renaming that to pxa93x.c
> sounds reasonable then).
OK. I'll create the new pxa935_init_irq().
>
>> ?}
>>
>> ?/*
>> diff --git a/arch/arm/plat-pxa/include/plat/mfp.h
>> b/arch/arm/plat-pxa/include/plat/mfp.h
>> index 22086e6..66a0295 100644
>> --- a/arch/arm/plat-pxa/include/plat/mfp.h
>> +++ b/arch/arm/plat-pxa/include/plat/mfp.h
>> @@ -16,7 +16,8 @@
>> ?#ifndef __ASM_PLAT_MFP_H
>> ?#define __ASM_PLAT_MFP_H
>>
>> -#define mfp_to_gpio(m) ((m) % 128)
>> +#define mfp_to_gpio(m) ? ? ? ? ((m) % 128)
>
> Giving that the MFP_PIN_GPIO* has been extended beyond 128, this
> macro is already wrong. (e.g. mfp_to_gpio(MFP_PIN_GPIO130) == 2??)
I'd prefer that platform driver use mfp256_to_gpio() macro when chip
is pxa935. mfp_to_gpio() is left for pxa27x and most pxa3xx.
Otherwise, mfp_to_gpio() has to support 256 pins. pxa27x mfp driver
have to be updated.
>
>> +#define mfp256_to_gpio(m) ? ? ?((m) % 256) ? ? /* GPIO is more than 128 */
>>
>> ?/* list of all the configurable MFP pins */
>> ?enum {
>> --
>> 1.5.6.5
>>
>
