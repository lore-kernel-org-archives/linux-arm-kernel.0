From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Thu, 28 Apr 2016 12:58:03 +0300
Subject: [RFC v4 3/8] gpio: generic: add DT support for generic
 memory-mapped GPIOs
In-Reply-To: <a5d6bb7bb73ff9396c9e8053a8e8e0975b857934.1461806071.git.chunkeey@googlemail.com>
References: <cover.1461806071.git.chunkeey@googlemail.com>
 <a5d6bb7bb73ff9396c9e8053a8e8e0975b857934.1461806071.git.chunkeey@googlemail.com>
Message-ID: <CAHp75VeSf_=rQBRQ+1ox=fn7aJ53mGg_huH7HRbZck0HEhxBAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2016 at 12:05 PM, Christian Lamparter
<chunkeey@googlemail.com> wrote:
> From: ?lvaro Fern?ndez Rojas <noltari@gmail.com>
>
> This patch adds support for defining memory-mapped GPIOs
> which provide a compatible interface for the existing
> generic-gpio driver.

> +static inline void set_resource_address(struct resource *res,
> +                                       resource_size_t start,
> +                                       resource_size_t len)
> +{
> +       res->start = start;
> +       res->end = start + len - 1;
> +}

It might make sense to put this in the generic (resource related, e.g.
ioport.h) header. There are plenty users of such already and who knows
how many will come.

>  #include <linux/bitops.h>
>  #include <linux/platform_device.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>

Perhaps + empty line?

> +#include "gpio-mmio-compat.h"

[]

> +#ifdef CONFIG_OF
> +static int bgpio_basic_mmio_parse_dt(struct platform_device *pdev,
> +                                    struct bgpio_pdata *pdata,
> +                                    unsigned long *flags)
> +{
> +       struct device *dev = &pdev->dev;
> +       int err;
> +
> +       err = of_property_read_u32(dev->of_node, "ngpio", &pdata->ngpio);
> +       if (err && err != -EINVAL)
> +               return err;

I think check for -EINVAL needs explanation.

> +}

[]

> +       pdata = bgpio_parse_dt(pdev, &flags);
> +       if (IS_ERR(pdata)) {
> +               return PTR_ERR(pdata);

> +       } else if (!pdata) {

Redundant else

> +               pdata = dev_get_platdata(dev);
> +               flags = pdev->id_entry->driver_data;
> +       }
>
>         r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dat");
>         if (!r)
> @@ -646,6 +734,9 @@ MODULE_DEVICE_TABLE(platform, bgpio_id_table);
>  static struct platform_driver bgpio_driver = {
>         .driver = {
>                 .name = "basic-mmio-gpio",

> +#ifdef CONFIG_OF

Doesn't of_match_ptr do this for you?


> +               .of_match_table = of_match_ptr(bgpio_of_match),
> +#endif

-- 
With Best Regards,
Andy Shevchenko
