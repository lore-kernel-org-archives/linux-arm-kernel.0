From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 29 Apr 2016 11:05:34 +0300
Subject: [RFC v5 3/4] gpio: move clps711x, moxart,
 ts4800 and gpio-ge into gpio-generic
In-Reply-To: <9e5cc9e957144bd5d4081573ef959f931281eaaa.1461888822.git.chunkeey@googlemail.com>
References: <cover.1461888822.git.chunkeey@googlemail.com>
 <9e5cc9e957144bd5d4081573ef959f931281eaaa.1461888822.git.chunkeey@googlemail.com>
Message-ID: <CAHp75Vf_+3ja07Z99k1Grvvg-w3mj0inPdiE69zTs=fa_nn5=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 3:53 AM, Christian Lamparter
<chunkeey@googlemail.com> wrote:
> This patch integrates these GPIO drivers into gpio-generic.
>

>
> +static int clps711x_parse_dt(struct platform_device *pdev,
> +                            struct bgpio_pdata *pdata,
> +                            unsigned long *flags)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       int id = np ? of_alias_get_id(np, "gpio") : pdev->id;
> +       struct resource *res;
> +
> +       if ((id < 0) || (id > 4))
> +               return -ENODEV;
> +
> +       /* PORTE is 3 lines only */
> +       if (id == 4)
> +               pdata->ngpio = 3;
> +
> +       pdata->base = id * 8;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -EINVAL;
> +
> +       res->name = "dat";
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +       if (!res)
> +               return -EINVAL;
> +
> +       /* PORTD is inverted logic for direction register */
> +       res->name = (id == 3) ? "dirin" : "dirout";
> +       return 0;
> +}
> +

I think the three below have enough in common to reorganize data
structure and use one parse function.

So, instead of providing just parsing function, something like

ngpios (0 ? read from property)
resource size
start, end pairs for dat/set/dirin.
flags

Have no idea if it's possible to re-use this approach for case above.

> +static int ge_parse_dt(struct platform_device *pdev,
> +                      struct bgpio_pdata *pdata,
> +                      unsigned long *flags)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +
> +       struct resource *res;
> +       struct resource nres[] = {
> +               DEFINE_RES_MEM_NAMED(0, 1, "dat"),
> +               DEFINE_RES_MEM_NAMED(0, 1, "set"),
> +               DEFINE_RES_MEM_NAMED(0, 1, "dirin"),
> +       };
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res || resource_size(res) != 0x24)
> +               return -EINVAL;
> +
> +       nres[0].start = res->start + 0x04;
> +       nres[0].end = nres[0].start + 3;
> +       nres[1].start = res->start + 0x08;
> +       nres[1].end = nres[1].start + 3;
> +       nres[2].start = res->start + 0x00;
> +       nres[2].end = nres[2].start + 3;
> +       *flags |= BGPIOF_BIG_ENDIAN_BYTE_ORDER;
> +       pdata->label = devm_kstrdup(&pdev->dev, np->full_name, GFP_KERNEL);
> +       if (!pdata->label)
> +               return -ENOMEM;
> +
> +       if (of_device_is_compatible(np, "ge,imp3a-gpio"))
> +               pdata->ngpio = 16;
> +       else if (of_device_is_compatible(np, "gef,sbc310-gpio"))
> +               pdata->ngpio = 6;
> +       else if (of_device_is_compatible(np, "gef,sbc610-gpio"))
> +               pdata->ngpio = 19;
> +
> +       return platform_device_add_resources(pdev, nres, ARRAY_SIZE(nres));
> +}
> +
> +static int moxart_parse_dt(struct platform_device *pdev,
> +                          struct bgpio_pdata *pdata,
> +                          unsigned long *flags)
> +{
> +       struct resource *res;
> +       struct resource nres[] = {
> +               DEFINE_RES_MEM_NAMED(0, 1, "dat"),
> +               DEFINE_RES_MEM_NAMED(0, 1, "set"),
> +               DEFINE_RES_MEM_NAMED(0, 1, "dirout"),
> +       };
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res || resource_size(res) != 0xc)
> +               return -EINVAL;
> +
> +       pdata->label = "moxart-gpio";
> +       *flags |= BGPIOF_READ_OUTPUT_REG_SET;
> +       nres[0].start = res->start + 0x04;
> +       nres[0].end = nres[0].start + 3;
> +       nres[1].start = res->start + 0x00;
> +       nres[1].end = nres[1].start + 3;
> +       nres[2].start = res->start + 0x08;
> +       nres[2].end = nres[2].start + 3;
> +       return platform_device_add_resources(pdev, nres, ARRAY_SIZE(nres));
> +}
> +
> +static int ts4800_parse_dt(struct platform_device *pdev,
> +                          struct bgpio_pdata *pdata,
> +                          unsigned long *flags)
> +{
> +       int err;
> +       struct resource *res;
> +       struct resource nres[] = {
> +               DEFINE_RES_MEM_NAMED(0, 1, "dat"),
> +               DEFINE_RES_MEM_NAMED(0, 1, "set"),
> +               DEFINE_RES_MEM_NAMED(0, 1, "dirout"),
> +       };
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res || resource_size(res) != 0x6)
> +               return -EINVAL;
> +
> +       nres[0].start = res->start;
> +       nres[0].end = nres[0].start + 1;
> +       nres[1].start = res->start + 0x02;
> +       nres[1].end = nres[1].start + 1;
> +       nres[2].start = res->start + 0x04;
> +       nres[2].end = nres[2].start + 1;
> +
> +       err = of_property_read_u32(pdev->dev.of_node, "ngpios", &pdata->ngpio);
> +       if (err == -EINVAL)
> +               pdata->ngpio = 16;
> +       else if (err)
> +               return err;
> +
> +       return platform_device_add_resources(pdev, nres, ARRAY_SIZE(nres));
> +}
> +
>  #define ADD(_name, _func) { .compatible = _name, .data = _func }
>
>  static const struct of_device_id bgpio_of_match[] = {
>         ADD("linux,gpio-mmio", bgpio_basic_mmio_parse_dt),
> +       ADD("cirrus,clps711x-gpio", clps711x_parse_dt),
> +       ADD("ge,imp3a-gpio", ge_parse_dt),
> +       ADD("gef,sbc310-gpio", ge_parse_dt),
> +       ADD("gef,sbc610-gpio", ge_parse_dt),
> +       ADD("moxa,moxart-gpio", moxart_parse_dt),
> +       ADD("technologic,ts4800-gpio", ts4800_parse_dt),
>         { }
>  };
>  #undef ADD
> diff --git a/drivers/gpio/gpio-moxart.c b/drivers/gpio/gpio-moxart.c
> deleted file mode 100644
> index d58d389..0000000
> --- a/drivers/gpio/gpio-moxart.c
> +++ /dev/null
> @@ -1,84 +0,0 @@
> -/*
> - * MOXA ART SoCs GPIO driver.
> - *
> - * Copyright (C) 2013 Jonas Jensen
> - *
> - * Jonas Jensen <jonas.jensen@gmail.com>
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#include <linux/err.h>
> -#include <linux/init.h>
> -#include <linux/irq.h>
> -#include <linux/io.h>
> -#include <linux/platform_device.h>
> -#include <linux/of_address.h>
> -#include <linux/of_gpio.h>
> -#include <linux/pinctrl/consumer.h>
> -#include <linux/delay.h>
> -#include <linux/timer.h>
> -#include <linux/bitops.h>
> -#include <linux/gpio/driver.h>
> -
> -#define GPIO_DATA_OUT          0x00
> -#define GPIO_DATA_IN           0x04
> -#define GPIO_PIN_DIRECTION     0x08
> -
> -static int moxart_gpio_probe(struct platform_device *pdev)
> -{
> -       struct device *dev = &pdev->dev;
> -       struct resource *res;
> -       struct gpio_chip *gc;
> -       void __iomem *base;
> -       int ret;
> -
> -       gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
> -       if (!gc)
> -               return -ENOMEM;
> -
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       base = devm_ioremap_resource(dev, res);
> -       if (IS_ERR(base))
> -               return PTR_ERR(base);
> -
> -       ret = bgpio_init(gc, dev, 4, base + GPIO_DATA_IN,
> -                        base + GPIO_DATA_OUT, NULL,
> -                        base + GPIO_PIN_DIRECTION, NULL,
> -                        BGPIOF_READ_OUTPUT_REG_SET);
> -       if (ret) {
> -               dev_err(&pdev->dev, "bgpio_init failed\n");
> -               return ret;
> -       }
> -
> -       gc->label = "moxart-gpio";
> -       gc->request = gpiochip_generic_request;
> -       gc->free = gpiochip_generic_free;
> -       gc->base = 0;
> -       gc->owner = THIS_MODULE;
> -
> -       ret = devm_gpiochip_add_data(dev, gc, NULL);
> -       if (ret) {
> -               dev_err(dev, "%s: gpiochip_add failed\n",
> -                       dev->of_node->full_name);
> -               return ret;
> -       }
> -
> -       return ret;
> -}
> -
> -static const struct of_device_id moxart_gpio_match[] = {
> -       { .compatible = "moxa,moxart-gpio" },
> -       { }
> -};
> -
> -static struct platform_driver moxart_gpio_driver = {
> -       .driver = {
> -               .name           = "moxart-gpio",
> -               .of_match_table = moxart_gpio_match,
> -       },
> -       .probe  = moxart_gpio_probe,
> -};
> -builtin_platform_driver(moxart_gpio_driver);
> diff --git a/drivers/gpio/gpio-ts4800.c b/drivers/gpio/gpio-ts4800.c
> deleted file mode 100644
> index 0c144a7..0000000
> --- a/drivers/gpio/gpio-ts4800.c
> +++ /dev/null
> @@ -1,81 +0,0 @@
> -/*
> - * GPIO driver for the TS-4800 board
> - *
> - * Copyright (c) 2016 - Savoir-faire Linux
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2. This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#include <linux/gpio/driver.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> -#include <linux/platform_device.h>
> -
> -#define DEFAULT_PIN_NUMBER      16
> -#define INPUT_REG_OFFSET        0x00
> -#define OUTPUT_REG_OFFSET       0x02
> -#define DIRECTION_REG_OFFSET    0x04
> -
> -static int ts4800_gpio_probe(struct platform_device *pdev)
> -{
> -       struct device_node *node;
> -       struct gpio_chip *chip;
> -       struct resource *res;
> -       void __iomem *base_addr;
> -       int retval;
> -       u32 ngpios;
> -
> -       chip = devm_kzalloc(&pdev->dev, sizeof(struct gpio_chip), GFP_KERNEL);
> -       if (!chip)
> -               return -ENOMEM;
> -
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       base_addr = devm_ioremap_resource(&pdev->dev, res);
> -       if (IS_ERR(base_addr))
> -               return PTR_ERR(base_addr);
> -
> -       node = pdev->dev.of_node;
> -       if (!node)
> -               return -EINVAL;
> -
> -       retval = of_property_read_u32(node, "ngpios", &ngpios);
> -       if (retval == -EINVAL)
> -               ngpios = DEFAULT_PIN_NUMBER;
> -       else if (retval)
> -               return retval;
> -
> -       retval = bgpio_init(chip, &pdev->dev, 2, base_addr + INPUT_REG_OFFSET,
> -                           base_addr + OUTPUT_REG_OFFSET, NULL,
> -                           base_addr + DIRECTION_REG_OFFSET, NULL, 0);
> -       if (retval) {
> -               dev_err(&pdev->dev, "bgpio_init failed\n");
> -               return retval;
> -       }
> -
> -       chip->ngpio = ngpios;
> -
> -       platform_set_drvdata(pdev, chip);
> -
> -       return devm_gpiochip_add_data(&pdev->dev, chip, NULL);
> -}
> -
> -static const struct of_device_id ts4800_gpio_of_match[] = {
> -       { .compatible = "technologic,ts4800-gpio", },
> -       {},
> -};
> -
> -static struct platform_driver ts4800_gpio_driver = {
> -       .driver = {
> -                  .name = "ts4800-gpio",
> -                  .of_match_table = ts4800_gpio_of_match,
> -                  },
> -       .probe = ts4800_gpio_probe,
> -};
> -
> -module_platform_driver_probe(ts4800_gpio_driver, ts4800_gpio_probe);
> -
> -MODULE_AUTHOR("Julien Grossholtz <julien.grossholtz@savoirfairelinux.com>");
> -MODULE_DESCRIPTION("TS4800 FPGA GPIO driver");
> -MODULE_LICENSE("GPL v2");
> --
> 2.8.1
>



-- 
With Best Regards,
Andy Shevchenko
