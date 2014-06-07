From: gnurou@gmail.com (Alexandre Courbot)
Date: Sat, 7 Jun 2014 21:28:22 +0900
Subject: [PATCH v2 1/3] gpio: Add APM X-Gene SoC GPIO controller support
In-Reply-To: <CAL85gmBjZ_JWctRN+0GHAA6Wyeq_NpQV941OKgppuJrmh2yx6A@mail.gmail.com>
References: <1401391413-3833-1-git-send-email-fkan@apm.com>
 <1401391413-3833-2-git-send-email-fkan@apm.com>
 <CAAVeFuKwcO=kjijG-Sh66_pod4=-mSjKN3+_a8P-ppomv9wq7g@mail.gmail.com>
 <CAL85gmBjZ_JWctRN+0GHAA6Wyeq_NpQV941OKgppuJrmh2yx6A@mail.gmail.com>
Message-ID: <CAAVeFuL_hit8FRjktuNP8k4EUGAYRMHqRBnGhCU-TzYrOW4J2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 7, 2014 at 7:46 AM, Feng Kan <fkan@apm.com> wrote:
> On Thu, Jun 5, 2014 at 10:04 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
>> On Fri, May 30, 2014 at 4:23 AM, Feng Kan <fkan@apm.com> wrote:
>>> Add APM X-Gene SoC gpio controller driver.
>>>
>>> Signed-off-by: Feng Kan <fkan@apm.com>
>>> ---
>>>  drivers/gpio/Kconfig      |   9 ++
>>>  drivers/gpio/Makefile     |   1 +
>>>  drivers/gpio/gpio-xgene.c | 231 ++++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 241 insertions(+)
>>>  create mode 100644 drivers/gpio/gpio-xgene.c
>>>
>>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>>> index a86c49a..9a15983 100644
>>> --- a/drivers/gpio/Kconfig
>>> +++ b/drivers/gpio/Kconfig
>>> @@ -324,6 +324,15 @@ config GPIO_TZ1090_PDC
>>>         help
>>>           Say yes here to support Toumaz Xenif TZ1090 PDC GPIOs.
>>>
>>> +config GPIO_XGENE
>>> +       bool "APM X-Gene GPIO controller support"
>>> +       depends on ARM64 && OF_GPIO
>>> +       help
>>> +         This driver is to support the GPIO block within the APM X-Gene SoC
>>> +         platform's generic flash controller. The GPIO pins are muxed with
>>> +         the generic flash controller's address and data pins. Say yes
>>> +         here to enable the GFC GPIO functionality.
>>> +
>>>  config GPIO_XILINX
>>>         bool "Xilinx GPIO support"
>>>         depends on PPC_OF || MICROBLAZE || ARCH_ZYNQ
>>> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
>>> index 6309aff..f0f2830 100644
>>> --- a/drivers/gpio/Makefile
>>> +++ b/drivers/gpio/Makefile
>>> @@ -98,6 +98,7 @@ obj-$(CONFIG_GPIO_VX855)      += gpio-vx855.o
>>>  obj-$(CONFIG_GPIO_WM831X)      += gpio-wm831x.o
>>>  obj-$(CONFIG_GPIO_WM8350)      += gpio-wm8350.o
>>>  obj-$(CONFIG_GPIO_WM8994)      += gpio-wm8994.o
>>> +obj-$(CONFIG_GPIO_XGENE)       += gpio-xgene.o
>>>  obj-$(CONFIG_GPIO_XILINX)      += gpio-xilinx.o
>>>  obj-$(CONFIG_GPIO_XTENSA)      += gpio-xtensa.o
>>>  obj-$(CONFIG_GPIO_ZEVIO)       += gpio-zevio.o
>>> diff --git a/drivers/gpio/gpio-xgene.c b/drivers/gpio/gpio-xgene.c
>>> new file mode 100644
>>> index 0000000..a542f76
>>> --- /dev/null
>>> +++ b/drivers/gpio/gpio-xgene.c
>>> @@ -0,0 +1,231 @@
>>> +/*
>>> + * AppliedMicro X-Gene SoC GPIO Driver
>>> + *
>>> + * Copyright (c) 2014, Applied Micro Circuits Corporation
>>> + * Author: Feng Kan <fkan@apm.com>.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
>>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>> + */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/init.h>
>>> +#include <linux/io.h>
>>> +#include <linux/spinlock.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/of_gpio.h>
>>> +#include <linux/of.h>
>>> +#include <linux/gpio.h>
>>> +#include <linux/types.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/bitops.h>
>>> +
>>> +#define GPIO_SET_MASK(x)       BIT(x + 16)
>>> +
>>> +#define GPIO_SET_DR_OFFSET     0x00
>>> +#define GPIO_DATA_OFFSET       0x08
>>> +
>>> +#define XGENE_MAX_GPIO_PER_BANK        16
>>> +
>>> +struct xgene_gpio;
>>> +
>>> +struct xgene_gpio {
>>> +       struct  device          *dev;
>>> +       struct xgene_gpio_bank  *banks;
>>
>> I am not seeing this member being used at all in your driver, apart
>> from being kzalloc'd.
>>
>>> +       struct gpio_chip        chip;
>>> +       void __iomem            *base;
>>> +       spinlock_t              lock;
>>> +#ifdef CONFIG_PM
>>> +       u32                     set_dr_val;
>>> +       u32                     od_val;
>>> +#endif
>>> +};
>>> +
>>> +static inline struct xgene_gpio *to_xgene_gpio(struct gpio_chip *chip)
>>> +{
>>> +       return container_of(chip, struct xgene_gpio, chip);
>>> +}
>>> +
>>> +static int xgene_gpio_get(struct gpio_chip *gc, unsigned int offset)
>>> +{
>>> +       struct xgene_gpio *bank = to_xgene_gpio(gc);
>>> +
>>> +       return !!(ioread32(bank->base + GPIO_DATA_OFFSET) & BIT(offset));
>>> +}
>>> +
>>> +static void xgene_gpio_set(struct gpio_chip *gc, unsigned int offset, int val)
>>> +{
>>> +       struct xgene_gpio *bank = to_xgene_gpio(gc);
>>> +       unsigned long flags;
>>> +       u32 setval;
>>> +
>>> +       spin_lock_irqsave(&bank->lock, flags);
>>> +
>>> +       setval = ioread32(bank->base + GPIO_SET_DR_OFFSET);
>>> +       if (val)
>>> +               setval |= GPIO_SET_MASK(offset);
>>> +       else
>>> +               setval &= ~GPIO_SET_MASK(offset);
>>
>> Let's use __set_bit and __clear_bit here and everywhere it applies.
> This is a bit of issue on arm64, where the op for set_bit requires
> unsigned long.
> Any suggestions?

You could change setval to be an unsigned long as well, and have it
casted to u32 in your call to iowrite32 below, but that's not
necessarily better. Maybe the current form is ok indeed.

>
>>
>>> +       iowrite32(setval, bank->base + GPIO_SET_DR_OFFSET);
>>> +
>>> +       spin_unlock_irqrestore(&bank->lock, flags);
>>> +}
>>> +
>>> +static int xgene_gpio_dir_in(struct gpio_chip *gc, unsigned int offset)
>>> +{
>>> +       struct xgene_gpio *bank = to_xgene_gpio(gc);
>>> +       unsigned long flags;
>>> +       u32 dirval;
>>> +
>>> +       spin_lock_irqsave(&bank->lock, flags);
>>> +
>>> +       dirval = ioread32(bank->base + GPIO_SET_DR_OFFSET);
>>> +       dirval |= BIT(offset);
>>> +       iowrite32(dirval, bank->base + GPIO_SET_DR_OFFSET);
>>> +
>>> +       spin_unlock_irqrestore(&bank->lock, flags);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int xgene_gpio_dir_out(struct gpio_chip *gc,
>>> +                                       unsigned int offset, int val)
>>> +{
>>> +       struct xgene_gpio *bank = to_xgene_gpio(gc);
>>> +       unsigned long flags;
>>> +       u32 dirval;
>>> +
>>> +       spin_lock_irqsave(&bank->lock, flags);
>>> +
>>> +       dirval = ioread32(bank->base + GPIO_SET_DR_OFFSET);
>>> +       dirval &= ~BIT(offset);
>>> +       iowrite32(dirval, bank->base + GPIO_SET_DR_OFFSET);
>>> +
>>> +       spin_unlock_irqrestore(&bank->lock, flags);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +#ifdef CONFIG_PM
>>> +static int xgene_gpio_suspend(struct device *dev)
>>> +{
>>> +       struct xgene_gpio *gpio = dev_get_drvdata(dev);
>>> +
>>> +       gpio->set_dr_val = ioread32(gpio->base + GPIO_SET_DR_OFFSET);
>>> +       return 0;
>>> +}
>>> +
>>> +static int xgene_gpio_resume(struct device *dev)
>>> +{
>>> +       struct xgene_gpio *gpio = dev_get_drvdata(dev);
>>> +
>>> +       iowrite32(gpio->set_dr_val, gpio->base + GPIO_SET_DR_OFFSET);
>>> +       return 0;
>>> +}
>>> +
>>> +static SIMPLE_DEV_PM_OPS(xgene_gpio_pm, xgene_gpio_suspend, xgene_gpio_resume);
>>> +#define XGENE_GPIO_PM_OPS      (&xgene_gpio_pm)
>>> +#else
>>> +#define XGENE_GPIO_PM_OPS      NULL
>>> +#endif
>>> +
>>> +static int xgene_gpio_probe(struct platform_device *pdev)
>>> +{
>>> +       struct device_node *np = pdev->dev.of_node;
>>> +       struct resource *res;
>>> +       struct xgene_gpio *gpio;
>>> +       int err = 0;
>>> +       unsigned int bank = 0, ngpio = 0;
>>> +
>>> +       gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
>>> +       if (!gpio) {
>>> +               err = -ENOMEM;
>>> +               goto err;
>>> +       }
>>> +       gpio->dev = &pdev->dev;
>>> +
>>> +       gpio->banks = devm_kzalloc(&pdev->dev,
>>> +                                  sizeof(struct xgene_gpio), GFP_KERNEL);
>>> +       if (!gpio->banks) {
>>> +               err = -ENOMEM;
>>> +               goto err;
>>> +       }
>>> +
>>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +       gpio->base = devm_ioremap_nocache(&pdev->dev, res->start,
>>> +                                                       resource_size(res));
>>> +       if (IS_ERR(gpio->base)) {
>>> +               err = PTR_ERR(gpio->base);
>>> +               goto err;
>>> +       }
>>> +
>>> +       /*
>>> +        * Determine gpio bank using gpio resource address
>>> +        */
>>> +       bank = (res->start & 0xff) / 0xc - 1;
>>> +       if (bank > 2) {
>>> +               dev_err(gpio->dev, "incorrect gpio base specified\n");
>>> +               goto err;
>>> +       }
>>> +
>>> +       ngpio = XGENE_MAX_GPIO_PER_BANK;
>>> +       gpio->chip.ngpio = ngpio;
>>
>> Maybe use XGENE_MAX_GPIO_PER_BANK directly instead of ngpio which is
>> not used otherwise.
>>
>>> +       gpio->chip.of_node = np;
>>> +       gpio->chip.base = bank * ngpio;
>>
>> This is dangerous. You are assuming that your chip will be the first
>> GPIO chip to be registered. Can't you leave chip.base uninitialized?
> In a SoC system where there are multiple gpio blocks by different vendor, how
> do one assign base to each block? I want them to boot up the system in a way
> that the gpio values make sense each time.

This used to be done in board files ; some older arm boards are still
doing it. But this is really legacy and in your case you don't use
board files anyway.

Ideally you should really not rely on global GPIO numbers. Device tree
lets you assign GPIO to functions without having to rely on that
knowledge. The gpiod interface completely gets rid of it. The only
use-case I can think of is if you need to access the GPIO from the
sysfs interface. Is it the case? If so, I'd suggest we try to devise a
solution for this too. Otherwise, can you elaborate on why the GPIO
numbers are important to you?

In any case you cannot have your driver just assume that some range in
the GPIO numberspace will be free. That's just not portable.

Alex.
