From: mturquette@baylibre.com (Michael Turquette)
Date: Fri, 08 Jul 2016 10:14:30 -0700
Subject: [PATCH 1/2] tty: amba-pl011: add support for clock frequency
 setting via dt
In-Reply-To: <1467965467-28180-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1467965467-28180-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Message-ID: <146799807004.73491.2602277598493203375@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jorge Ramirez-Ortiz (2016-07-08 01:11:06)
> Allow to specify the clock frequency for any given port via the
> assigned-clock-rates device tree property.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Tested-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  drivers/tty/serial/amba-pl011.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 1b7331e..51867ab 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -55,6 +55,7 @@
>  #include <linux/types.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/clk/clk-conf.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/sizes.h>
>  #include <linux/io.h>
> @@ -2472,6 +2473,10 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>         if (IS_ERR(uap->clk))
>                 return PTR_ERR(uap->clk);
>  
> +       ret = of_clk_set_defaults(dev->dev.of_node, false);

Change looks good to me, but with one question: should this change be
put into more generic code instead of in this specific driver? For
instance, we call of_clk_set_defaults from the following files:

drivers/base/platform.c
drivers/i2c/i2c-core.c
drivers/spi/spi.c

And Stephen posted a patch to do this for devices on the AMBA bus:

https://patchwork.kernel.org/patch/6501691/

Does Stephen's patch mean that you do not need patch #1? Stephen, any
update on what happened to this patch?

Thanks,
Mike

> +       if (ret < 0)
> +               return ret;
> +
>         uap->reg_offset = vendor->reg_offset;
>         uap->vendor = vendor;
>         uap->fifosize = vendor->get_fifosize(dev);
> -- 
> 2.7.4
> 
