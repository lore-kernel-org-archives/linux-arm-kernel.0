From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 6 May 2016 14:53:24 +0300
Subject: [PATCH v7 3/3] gpio: move clps711x, moxart, ts4800 and gpio-ge
 into gpio-mmio
In-Reply-To: <e936c3c38deee5cd954862c5ed11f9cffa2ba6a9.1462372360.git.chunkeey@googlemail.com>
References: <cover.1462372360.git.chunkeey@googlemail.com>
 <e936c3c38deee5cd954862c5ed11f9cffa2ba6a9.1462372360.git.chunkeey@googlemail.com>
Message-ID: <CAHp75VeFjcPX+f3j+h+OL2jEpfGP+aqL78ymcsj4JwUfO0RvtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 6, 2016 at 2:10 PM, Christian Lamparter
<chunkeey@googlemail.com> wrote:
> This patch integrates these GPIO drivers into gpio-mmio.

Would be nice to repeat a list here.

>  config GPIO_GENERIC_PLATFORM
>         tristate "Generic memory-mapped GPIO controller support (MMIO platform device)"
>         select GPIO_GENERIC
>         help
> +         Select this to support many generic memory-mapped GPIO controllers.
> +
> +         This driver also includes support for the following GPIOs:
> +           CLPS711X SoCs
> +           MOXA ART SoC
> +           TS-4800 FPGA DIO blocks and compatibles.
> +           GPIOs found on some GE Single Board Computers.
> +
>           Say yes here to support basic platform_device memory-mapped GPIO controllers.
>
>  config GPIO_GRGPIO
> @@ -285,14 +274,6 @@ config GPIO_MM_LANTIQ
>           (EBU) found on Lantiq SoCs. The gpios are output only as they are
>           created by attaching a 16bit latch to the bus.
>
> -config GPIO_MOXART
> -       bool "MOXART GPIO support"
> -       depends on ARCH_MOXART || COMPILE_TEST
> -       select GPIO_GENERIC
> -       help
> -         Select this option to enable GPIO driver for
> -         MOXA ART SoC devices.
> -

Doesn't it change behaviour? So, as a user of old .config I expect to
have driver enabled. How is it achieved now?

> --- a/drivers/gpio/gpio-mmio.c
> +++ b/drivers/gpio/gpio-mmio.c
> @@ -610,10 +610,200 @@ static int bgpio_basic_mmio_parse_dt(struct platform_device *pdev,
>         return 0;
>  }
>
> +static int clps711x_parse_dt(struct platform_device *pdev,
> +                            struct bgpio_pdata *pdata,
> +                            unsigned long *flags)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct resource *res;
> +       const char *dir_reg_name;
> +       int id = np ? of_alias_get_id(np, "gpio") : pdev->id;
> +
> +       if ((id < 0) || (id > 4))
> +               return -ENODEV;
> +

> +       /* PORTE is 3 lines only */
> +       pdata->ngpio = (id == 4) ? 3 : /* determined by register width */ 0;
> +
> +       /* PORTD is inverted logic for direction register */
> +       dir_reg_name = (id == 3) ? "dirin" : "dirout",

Just a nit: possible to use switch case?

> +
> +       pdata->base = id * 8;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -EINVAL;
> +       if (!res->name || strcmp("dat", res->name))
> +               res->name = devm_kstrdup(&pdev->dev, "dat", GFP_KERNEL);
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +       if (!res)
> +               return -EINVAL;
> +       if (!res->name || strcmp(dir_reg_name, res->name))
> +               res->name = devm_kstrdup(&pdev->dev, dir_reg_name, GFP_KERNEL);
> +
> +       return 0;
> +}
> +
> +static int ge_dt_cb(struct platform_device *pdev,
> +                   struct bgpio_pdata *pdata,
> +                   unsigned long *flags)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +
> +       pdata->label = devm_kstrdup(&pdev->dev, np->full_name, GFP_KERNEL);
> +       if (!pdata->label)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +static int moxart_dt_cb(struct platform_device *pdev,
> +                       struct bgpio_pdata *pdata,
> +                       unsigned long *flags)
> +{
> +       pdata->base = 0;
> +       pdata->label = "moxart-gpio";
> +       return 0;
> +}
> +
> +
> +static int ts4800_dt_cb(struct platform_device *pdev,
> +                       struct bgpio_pdata *pdata,
> +                       unsigned long *flags)
> +{
> +       int err;
> +
> +       err = of_property_read_u32(pdev->dev.of_node, "ngpios", &pdata->ngpio);
> +       if (err == -EINVAL) {
> +               pdata->ngpio = 16;
> +               err = 0;

return 0; ? (Up to you)

> +       }
> +       return err;
> +}
> +
> +struct compat_gpio_device_data {
> +       unsigned int expected_resource_size;
> +       unsigned int ngpio;
> +       resource_size_t register_width;
> +       unsigned long flags;
> +       int (*call_back)(struct platform_device *pdev,
> +                        struct bgpio_pdata *pdata,
> +                        unsigned long *flags);
> +       struct resource_replacement {
> +               resource_size_t start_offset;
> +               const char *name;
> +       } resources[5];

I would define magic number with a description what are those 5.

> +};

[...]

> +static int compat_parse_dt(struct platform_device *pdev,
> +                          struct bgpio_pdata *pdata,
> +                          unsigned long *flags)
> +{
> +       const struct device_node *node = pdev->dev.of_node;
> +       const struct compat_gpio_device_data *entry;
> +       const struct of_device_id *of_id;
> +       struct resource *res;
> +       int err;
> +
> +       of_id = of_match_node(compat_gpio_devices, node);
> +       if (!of_id)
> +               return -ENODEV;
> +
> +       entry = of_id->data;
> +       if (!entry || !entry->resources[0].name)
> +               return -EINVAL;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -EINVAL;
> +
> +       if (!res->name || strcmp(entry->resources[0].name, res->name)) {
> +               struct resource nres[ARRAY_SIZE(entry->resources)];
> +               int i;

unsigned int i; ?

> +
> +               if (resource_size(res) != entry->expected_resource_size)
> +                       return -EINVAL;
> +
> +               for (i = 0; i < ARRAY_SIZE(entry->resources); i++) {
> +                       if (!entry->resources[i].name)
> +                               continue;
> +
> +                       nres[i].name = devm_kstrdup(&pdev->dev,
> +                               entry->resources[i].name, GFP_KERNEL);
> +                       nres[i].start = res->start +
> +                               entry->resources[i].start_offset;
> +                       nres[i].end = nres[i].start +
> +                               entry->register_width - 1;
> +                       nres[i].flags = IORESOURCE_MEM;
> +               }
> +
> +               err = platform_device_add_resources(pdev, nres, i);
> +               if (err)
> +                       return err;
> +       }
> +
> +       pdata->base = -1;
> +       pdata->ngpio = entry->ngpio;
> +       *flags = entry->flags;
> +
> +       if (entry->call_back)
> +               err = entry->call_back(pdev, pdata, flags);
> +
> +       return err;
> +}

-- 
With Best Regards,
Andy Shevchenko
