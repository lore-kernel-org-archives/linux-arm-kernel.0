From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 1 Jul 2015 09:08:12 +0200
Subject: [RFC 2/3] i2c: mux: demux-pinctrl: add driver
In-Reply-To: <1435700651-3543-3-git-send-email-wsa@the-dreams.de>
References: <1435700651-3543-1-git-send-email-wsa@the-dreams.de>
 <1435700651-3543-3-git-send-email-wsa@the-dreams.de>
Message-ID: <CAMuHMdW+rd+U0VQjitbyJ3AiZakhLztdYe27n1rkK9tFWT=z4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Tue, Jun 30, 2015 at 11:44 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> This driver allows an I2C bus to switch between multiple masters. This
> is not hot-switching because connected I2C slaves will be
> re-instantiated. It is meant to select the best I2C core at runtime once
> the task is known. Example: Prefer i2c-gpio over another I2C core
> because of HW errata affecting your use case.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  .../devicetree/bindings/i2c/i2c-demux-pinctrl.txt  |  44 ++++
>  drivers/i2c/muxes/Kconfig                          |   9 +
>  drivers/i2c/muxes/Makefile                         |   2 +
>  drivers/i2c/muxes/i2c-demux-pinctrl.c              | 266 +++++++++++++++++++++
>  4 files changed, 321 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
>  create mode 100644 drivers/i2c/muxes/i2c-demux-pinctrl.c
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt b/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
> new file mode 100644
> index 00000000000000..2211f6acbf8c0c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt

> +Changing I2C controllers:
> +
> +The created mux-device will have a file "cur_master" in its sysfs-entry. Write
> +0 there for the first master listed in the "i2c-parent" property, 1 for the
> +second etc. Reading the file will give you a list with the active master
> +marked.

This paragraph doesn't belong in the DT binding doc, but somewhere
under Documentation/i2c/

> diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
> new file mode 100644
> index 00000000000000..5444c65de76c55
> --- /dev/null
> +++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
> @@ -0,0 +1,266 @@
> +/*
> + * Pinctrl based I2C DeMultiplexer V2 PROTOTYPE!
> + *
> + * Copyright (C) 2015 by Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
> + * Copyright (C) 2015 by Renesas Electronics Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; version 2 of the License.
> + *
> + * See the bindings doc for DTS setup.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +
> +struct i2c_demux_pinctrl_chan {
> +       struct device_node *parent_np;
> +       struct i2c_adapter *parent_adap;
> +       struct of_changeset chgset;
> +};
> +
> +struct i2c_demux_pinctrl_priv {
> +       int cur_chan;
> +       int num_chan;

unsigned int

> +       struct device *dev;
> +       const char *bus_name;
> +       struct i2c_adapter cur_adap;
> +       struct i2c_algorithm algo;
> +       struct i2c_demux_pinctrl_chan chan[];
> +};
> +
> +static struct property status_okay = { .name = "status", .length = 3, .value = "ok" };

"okay" or "ok"?

> +static ssize_t cur_master_show(struct device *dev, struct device_attribute *attr,
> +                          char *buf)
> +{
> +       struct i2c_demux_pinctrl_priv *priv = dev_get_drvdata(dev);
> +       int count = 0, i;

unsigned int i

> +
> +       for (i = 0; i < priv->num_chan; i++)
> +               count += sprintf(buf + count, "%c %d - %s\n",
> +                                i == priv->cur_chan ? '*' : ' ', i,
> +                                priv->chan[i].parent_np->full_name);
> +       //FIXME: Check count > PAGE_SIZE

Can you use seq_printf() for device attributes?

> +
> +       return count;
> +}
> +
> +static ssize_t cur_master_store(struct device *dev, struct device_attribute *attr,
> +                           const char *buf, size_t count)
> +{
> +       struct i2c_demux_pinctrl_priv *priv = dev_get_drvdata(dev);
> +       unsigned long val;

unsigned int

> +       int ret;
> +
> +       ret = kstrtoul(buf, 0, &val);

kstrtouint()

> +       if (ret < 0)
> +               return ret;
> +
> +       if (val >= priv->num_chan)
> +               return -EINVAL;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
