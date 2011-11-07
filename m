From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 7 Nov 2011 15:14:36 +0800
Subject: [PATCH v5 03/11] ARM: pxa: rename gpio_to_irq and irq_to_gpio
In-Reply-To: <20111027091702.GE19187@n2100.arm.linux.org.uk>
References: <1318858517-22494-1-git-send-email-haojian.zhuang@marvell.com>
 <1318858517-22494-4-git-send-email-haojian.zhuang@marvell.com>
 <20111027091702.GE19187@n2100.arm.linux.org.uk>
Message-ID: <CAN1soZwTU6aJy2OP8Skj_pbLFXcWBEa7yyzrMpgcR+FfHAdx8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2011 at 5:17 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Oct 17, 2011 at 09:35:09PM +0800, Haojian Zhuang wrote:
>> Avoid to define gpio_to_irq() and irq_to_gpio() for potential name
>> confliction since multiple architecture will be built together.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>
> I think this patch is partly wrong.
>
>> diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
>> index 06b5ad7..fb7dfc1 100644
>> --- a/arch/arm/mach-mmp/aspenite.c
>> +++ b/arch/arm/mach-mmp/aspenite.c
>> @@ -120,8 +120,8 @@ static struct resource smc91x_resources[] = {
>> ? ? ? ? ? ? ? .flags ?= IORESOURCE_MEM,
>> ? ? ? },
>> ? ? ? [1] = {
>> - ? ? ? ? ? ? .start ?= gpio_to_irq(27),
>> - ? ? ? ? ? ? .end ? ?= gpio_to_irq(27),
>> + ? ? ? ? ? ? .start ?= MMP_GPIO_TO_IRQ(27),
>> + ? ? ? ? ? ? .end ? ?= MMP_GPIO_TO_IRQ(27),
>
> These are fine, because they're fixing static initializers which can't
> call out to functions.
>
>> diff --git a/arch/arm/mach-mmp/include/mach/gpio-pxa.h b/arch/arm/mach-mmp/include/mach/gpio-pxa.h
>> index c017a98..f7bcc30 100644
>> --- a/arch/arm/mach-mmp/include/mach/gpio-pxa.h
>> +++ b/arch/arm/mach-mmp/include/mach/gpio-pxa.h
>> @@ -2,6 +2,7 @@
>> ?#define __ASM_MACH_GPIO_PXA_H
>>
>> ?#include <mach/addr-map.h>
>> +#include <mach/cputype.h>
>> ?#include <mach/irqs.h>
>>
>> ?#define GPIO_REGS_VIRT ? ? ? (APB_VIRT_BASE + 0x19000)
>
> This looks like an unrelated change.
>
>> diff --git a/arch/arm/mach-mmp/include/mach/gpio.h b/arch/arm/mach-mmp/include/mach/gpio.h
>> index 6812623..32b684a 100644
>> --- a/arch/arm/mach-mmp/include/mach/gpio.h
>> +++ b/arch/arm/mach-mmp/include/mach/gpio.h
>> @@ -3,9 +3,6 @@
>>
>> ?#include <asm-generic/gpio.h>
>>
>> -#define gpio_to_irq(gpio) ? ?(IRQ_GPIO_START + (gpio))
>> -#define irq_to_gpio(irq) ? ? ((irq) - IRQ_GPIO_START)
>> -
>
> Doesn't this leave MMP without any definition for gpio_to_irq() ? ?This
> is part of the gpiolib API and really should be implemented. ?If you're
> not providing your own special version, it should be defined to
> __gpio_to_irq() instead. ?(Same comment for PXA.)
>
Excuse me for response so late.

gpio_to_irq() was provided to share between arch-pxa and arch-mmp.
Now it became the obstacle of building arch-pxa and arch-mmp together.

__gpio_to_irq() is defined in drivers/gpio/gpiolib.c. It makes use of
gpio_chip->to_irq(). So I prefer to use __gpio_to_irq() as common interface.

Since some macro may use gpio_to_irq() in legacy pxa code, I define
PXA_GPIO_TO_IRQ() and MMP_GPIO_TO_IRQ() to handle this.

>> diff --git a/arch/arm/mach-pxa/cm-x2xx-pci.c b/arch/arm/mach-pxa/cm-x2xx-pci.c
>> index 6bf479d..dd8443f 100644
>> --- a/arch/arm/mach-pxa/cm-x2xx-pci.c
>> +++ b/arch/arm/mach-pxa/cm-x2xx-pci.c
>> @@ -43,9 +43,9 @@ void __cmx2xx_pci_init_irq(int irq_gpio)
>>
>> ? ? ? cmx2xx_it8152_irq_gpio = irq_gpio;
>>
>> - ? ? irq_set_irq_type(gpio_to_irq(irq_gpio), IRQ_TYPE_EDGE_RISING);
>> + ? ? irq_set_irq_type(PXA_GPIO_TO_IRQ(irq_gpio), IRQ_TYPE_EDGE_RISING);
>>
>> - ? ? irq_set_chained_handler(gpio_to_irq(irq_gpio),
>> + ? ? irq_set_chained_handler(PXA_GPIO_TO_IRQ(irq_gpio),
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? cmx2xx_it8152_irq_demux);
>
> This isn't a static data initializer, which means the standard gpiolib
> gpio_to_irq() function _should_ work here if properly implemented.
>
>> diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
>> index 3358f4d..e71c395 100644
>> --- a/arch/arm/mach-pxa/em-x270.c
>> +++ b/arch/arm/mach-pxa/em-x270.c
>> @@ -558,7 +558,7 @@ static int em_x270_mci_init(struct device *dev,
>> ? ? ? ? ? ? ? return PTR_ERR(em_x270_sdio_ldo);
>> ? ? ? }
>>
>> - ? ? err = request_irq(gpio_to_irq(mmc_cd), em_x270_detect_int,
>> + ? ? err = request_irq(PXA_GPIO_TO_IRQ(mmc_cd), em_x270_detect_int,
>
> Ditto.
>
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? IRQF_DISABLED | IRQF_TRIGGER_RISING |
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? IRQF_TRIGGER_FALLING,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? "MMC card detect", data);
>> @@ -588,7 +588,7 @@ static int em_x270_mci_init(struct device *dev,
>> ? ? ? return 0;
>>
>> ?err_gpio_wp:
>> - ? ? free_irq(gpio_to_irq(mmc_cd), data);
>> + ? ? free_irq(PXA_GPIO_TO_IRQ(mmc_cd), data);
>
> Ditto.
>
>> ?err_irq:
>> ? ? ? regulator_put(em_x270_sdio_ldo);
>>
>> @@ -611,7 +611,7 @@ static void em_x270_mci_setpower(struct device *dev, unsigned int vdd)
>>
>> ?static void em_x270_mci_exit(struct device *dev, void *data)
>> ?{
>> - ? ? free_irq(gpio_to_irq(mmc_cd), data);
>> + ? ? free_irq(PXA_GPIO_TO_IRQ(mmc_cd), data);
>
> Ditto.
>
>> ? ? ? regulator_put(em_x270_sdio_ldo);
>>
>> ? ? ? if (machine_is_em_x270())
> ...
>> diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
>> index b938fc2..1144def 100644
>> --- a/arch/arm/mach-pxa/mioa701.c
>> +++ b/arch/arm/mach-pxa/mioa701.c
>> @@ -314,7 +314,7 @@ static int __init gsm_init(void)
>> ? ? ? rc = gpio_request_array(ARRAY_AND_SIZE(gsm_gpios));
>> ? ? ? if (rc)
>> ? ? ? ? ? ? ? goto err_gpio;
>> - ? ? rc = request_irq(gpio_to_irq(GPIO25_GSM_MOD_ON_STATE), gsm_on_irq,
>> + ? ? rc = request_irq(PXA_GPIO_TO_IRQ(GPIO25_GSM_MOD_ON_STATE), gsm_on_irq,
>
> Ditto. (etc)
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
