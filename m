From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 23 Dec 2009 04:07:34 -0500
Subject: [PATCH] pxa: fix gpio_to_irq() for GPIOs on expander chips
In-Reply-To: <74d0deb30912140149hc20c19dy605a259dc3f6e6e0@mail.gmail.com>
References: <1259148990-10372-1-git-send-email-mad_soft@inbox.ru>
	<74d0deb30912140149hc20c19dy605a259dc3f6e6e0@mail.gmail.com>
Message-ID: <771cded00912230107v5d2cbb18y733b62b0d6303887@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2009 at 4:49 AM, pHilipp Zabel <philipp.zabel@gmail.com> wrote:
> On Wed, Nov 25, 2009 at 12:36 PM, Dmitry Artamonow <mad_soft@inbox.ru> wrote:
>> Commit 9db95cb6c430b added support for gpios on PXA93x/950 and
>> increased PXA_GPIO_IRQ_NUM from 128 to 192, but missed to update
>> NR_BUILTIN_GPIO. This led to broken gpio_to_irq() for off-chip GPIOs.
>> Adjust NR_BUILTIN_GPIO accordingly, and also increase ARCH_NR_GPIOS,
>> as there exist platforms (hx4700) with more than 64 off-chip GPIOs,
>> so default value 256 is not enough.
>>
>> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
>
> Hi, are there any opinions on this one?
>
> Personally, I'd prefer not to increase PXA_GPIO_IRQ_NUM to 196 unless
> PXA9xx support is enabled. But as it is now, we either need to
> increase NR_BUILTIN_GPIO and ARCH_NR_GPIOS too (moving hx4700's 70
> ASIC3 GPIOs to 196..265), or add support for the gpiolib to_irq method
> to the PXA gpio_to_irq macro (which Eric didn't like, see the thread
> at http://www.spinics.net/lists/arm-kernel/msg53803.html) in order to
> keep the ASIC3 GPIOs in the 128...197 range.
>
> regards
> Philipp
>
>> ---
>> ?arch/arm/mach-pxa/include/mach/gpio.h | ? ?4 +++-
>> ?1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> This is a fix for 2.6.32 regression.
>> Found this while testing 2.6.32-rc8 on hx4700. Here's errors in log
>> on unpatched kernel (all related to gpios on ASIC3 chip):
>> [ ? 37.369051] gpio-vbus gpio-vbus: can't request irq 286, err: -22
>> [ ? 37.398158] gpio-vbus: probe of gpio-vbus failed with error -22
>> ...
>> [ ? 37.683452] gpio-keys: Unable to claim irq 278; error -22
>> [ ? 37.700759] gpio-keys: probe of gpio-keys failed with error -22
>> ...
>> [ ? 38.025748] pda-power pda-power: request ac irq failed
>> [ ? 38.044569] pda-power: probe of pda-power failed with error -22
>>
>> And after increasing NR_BUILTIN_GPIO to 192, I got this:
>> [ ?207.323467] gpiochip_add: gpios 256..263 (htc-egpio) not registered
>>
>> With both NR_BUILTIN_GPIO and ARCH_NR_GPIOS increased there's no more
>> gpio-related errors.
>>
>> I'm a bit unsure if this patch don't have any side effects on other PXA
>> platforms, and I even don't understand how exactly NR_BUILTIN_GPIO
>> and PXA_GPIO_IRQ_NUM affect gpios on expanders, so please check thoroughly!
>>
>> diff --git a/arch/arm/mach-pxa/include/mach/gpio.h b/arch/arm/mach-pxa/include/mach/gpio.h
>> index b024a8b..bf53894 100644
>> --- a/arch/arm/mach-pxa/include/mach/gpio.h
>> +++ b/arch/arm/mach-pxa/include/mach/gpio.h
>> @@ -24,6 +24,8 @@
>> ?#ifndef __ASM_ARCH_PXA_GPIO_H
>> ?#define __ASM_ARCH_PXA_GPIO_H
>>
>> +#define ARCH_NR_GPIOS ?320
>> +
>> ?#include <mach/irqs.h>
>> ?#include <mach/hardware.h>
>> ?#include <asm-generic/gpio.h>
>> @@ -99,7 +101,7 @@
>> ?#define GAFR(x) ? ? ? ? ? ? ? ?GPIO_REG(0x54 + (((x) & 0x70) >> 2))
>>
>>
>> -#define NR_BUILTIN_GPIO 128
>> +#define NR_BUILTIN_GPIO 192
>>
>> ?#define gpio_to_bank(gpio) ? ? ((gpio) >> 5)
>> ?#define gpio_to_irq(gpio) ? ? ?IRQ_GPIO(gpio)
>> --
>> 1.6.3.4
>>
>>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

Hi Philipp & Dmitry,

Excuse me on response late.

I not prefer the patch in that link
(http://www.spinics.net/lists/arm-kernel/msg53803.html). I think
gpio_to_irq() macro is enough. When we handle gpio expander, we could
implement an independant gpio_to_irq() function in expander driver.
It's like Marc's patch
((http://www.spinics.net/lists/arm-kernel/msg79587.html).

In platform driver, we can declare the relationship directly in below.

 static struct pca953x_platform_data gpio_exp[] = {
        [0] = {
               .gpio_base      = PXA_GPIO_IRQ_NUM,
               .irq_base       = PXA_GPIO_IRQ_BASE + PXA_GPIO_IRQ_NUM,
        },
        [1] = {
               .gpio_base      = PXA_GPIO_IRQ_NUM + 16,
               .irq_base       = PXA_GPIO_IRQ_BASE + PXA_GPIO_IRQ_NUM + 16,
        },
 };

But I don't suggest to append ARCH_NR_GPIOS in gpio.h. Could it be
appended into platform driver only? Since not each platform have more
than 256 GPIOs.

Thanks
Haojian
