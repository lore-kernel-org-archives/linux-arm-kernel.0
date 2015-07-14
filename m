From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jul 2015 10:53:04 +0200
Subject: [PATCH 7/9] arm: twr-k70f120m: IOMUX driver for Kinetis SoC
In-Reply-To: <1435094387-20146-8-git-send-email-pawelo@king.net.pl>
References: <1435094387-20146-1-git-send-email-pawelo@king.net.pl>
 <1435094387-20146-8-git-send-email-pawelo@king.net.pl>
Message-ID: <CACRpkdYHBt7YJWM3Bg8ENfw7uL4fuENqW+g8YaO+P6UPBCX4HQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 23, 2015 at 11:19 PM, Paul Osmialowski <pawelo@king.net.pl> wrote:
> This is very cheap and simple implementation of pinctrl driver
> for Kinetis SoC - its primary role is to provide means for enabling UART
> fuctionality on I/O PORT_E which will be utilized by the commits
> yet to come.
>
> Signed-off-by: Paul Osmialowski <pawelo@king.net.pl>

OK...

I want Shawn and Sascha to look at this as they worked with
other Freescale pin controllers. Especially I want to know if this
is a sibling to the other Freescale controllers or a separate hardware.

If it is *not* a sibling I will *insist* that it use more generic pin
control bindings and move away from the older Freescale-specific
stuff.

>  arch/arm/Kconfig                                   |   1 +
>  arch/arm/boot/dts/kinetis.dtsi                     |  48 ++
>  arch/arm/mach-kinetis/Kconfig                      |   6 +
>  drivers/clk/clk-kinetis.c                          |  28 ++

>  include/dt-bindings/clock/kinetis-mcg.h            |   8 +-

I see that you are trying to hold together "pin control support" in a
patch hitting all over the world. I don't think this is good, I think it is
better if you make a separate patch for bindings, clock, DTS and
mach-kinetis.

I think the clock support could go into the one big clock support
patch in the series simply, but its a question for the clk maintainer.

I only want the below change for the pin control subsystem and I
want to merge that into my tree. I will also merge the device tree
bindings for it. The rest goes to the clock tree and ARM SoC.
You can merge the Kconfig selects
of the symbols orthogonally so you need not keep it together,
and DTS changes are by definition orthogonal.

>  .../bindings/pinctrl/fsl,kinetis-pinctrl.txt       |  31 ++

>  drivers/pinctrl/freescale/Kconfig                  |   8 +
>  drivers/pinctrl/freescale/Makefile                 |   1 +
>  drivers/pinctrl/freescale/pinctrl-kinetis.c        | 529 +++++++++++++++++++++
>  9 files changed, 659 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,kinetis-pinctrl.txt
>  create mode 100644 drivers/pinctrl/freescale/pinctrl-kinetis.c

So I will take these things once we are done with review etc.

> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,kinetis-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,kinetis-pinctrl.txt
> new file mode 100644
> index 0000000..04798c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,kinetis-pinctrl.txt
> @@ -0,0 +1,31 @@
> +Freescale Kinetis IOMUX Controller
> +
> +This controller is largely based on i.MX IOMUX Controller. Please refer to
> +fsl,imx-pinctrl.txt in this directory for more detailed description.
> +
> +Required properties:
> +- compatible: Should be "fsl,kinetis-iomuxc".
> +- reg: Should contain the physical address and length of the gpio/pinmux
> +  register range.
> +- clocks: Clock that drives this I/O port.
> +- fsl,pins: Two integers array, represents a group of pins mux and config
> +  setting. The format is fsl,pins = <PIN_FUNC_ID CONFIG>, PIN_FUNC_ID is
> +  a pin working on a specific function, CONFIG is the pad setting value
> +  such as pull enable, pull select, drive strength enable. Please refer to
> +  Kinetis datasheet for the valid pad config settings.

There exist generic pin config bindings, see
Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt

I suggest to to function+group paring and then use generic pin config
with this driver unless it is a very close sibling to the existing Freescale
pin controllers.

Hint: if it is a sibling, it should share code with them.

There are several drivers doing generic pin control/pin config in the kernel
tree.

> diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
> index 12ef544..2d0dfa9 100644
> --- a/drivers/pinctrl/freescale/Kconfig
> +++ b/drivers/pinctrl/freescale/Kconfig
> @@ -94,6 +94,14 @@ config PINCTRL_IMX7D
>         help
>           Say Y here to enable the imx7d pinctrl driver
>
> +config PINCTRL_KINETIS
> +       bool "Kinetis pinctrl driver"
> +       depends on OF
> +       depends on SOC_K70

I don't know if that cryptic symbol is very good. FREESCALE_SOC_K70
makes more sense.

> @@ -0,0 +1,529 @@
> +/*
> + * pinctrl-kinetis.c - iomux for Kinetis MCUs
> + *
> + * Based on pinctrl-imx.c by Dong Aisheng <dong.aisheng@linaro.org>
> + *
> + * Copyright (C) 2015 Paul Osmialowski <pawelo@king.net.pl>
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/clk.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pinctrl/machine.h>

Why are you including this? It seems wrong. Machine
definitions should not be in the driver, in your case it should
probably be in the device tree.

> +/*
> + * PORTx register map
> + */
> +struct kinetis_port_regs {
> +       u32 pcr[32];    /* Pin Control Registers */
> +       u32 gpclr;      /* Global Pin Control Low Register */
> +       u32 gpchr;      /* Global Pin Control High Register */
> +       u32 rsv0[6];
> +       u32 isfr;       /* Interrupt Status Flag Register */
> +       u32 rsv1[7];
> +       u32 dfer;       /* Digital Filter Enable Register */
> +       u32 dfcr;       /* Digital Filter Clock Register */
> +       u32 dfwr;       /* Digital Filter Width Register */
> +};

Why do you need this ... I don't get it.
Please elaborate on why you are keeping a struct model of
the register map around.

> +/*
> + * PORTx registers base
> + */
> +#define KINETIS_PORT_PTR(base, reg) \
> +       (&(((struct kinetis_port_regs *)(base))->reg))
> +#define KINETIS_PORT_RD(base, reg) readl_relaxed(KINETIS_PORT_PTR(base, reg))
> +#define KINETIS_PORT_WR(base, reg, val) \
> +               writel_relaxed((val), KINETIS_PORT_PTR(base, reg))
> +#define KINETIS_PORT_SET(base, reg, mask) \
> +       KINETIS_PORT_WR(base, reg, (KINETIS_PORT_RD(base, reg)) | (mask))
> +#define KINETIS_PORT_RESET(base, reg, mask) \
> +       KINETIS_PORT_WR(base, reg, (KINETIS_PORT_RD(base, reg)) & (~(mask)))

Convert these to static inline functions instead. It is way easier to read
than this compact and terse defines.

> +static int kinetis_dt_node_to_map(struct pinctrl_dev *pctldev,
> +                       struct device_node *np,
> +                       struct pinctrl_map **map, unsigned *num_maps)
> +{
> +       struct kinetis_pinctrl *kpctl = pinctrl_dev_get_drvdata(pctldev);
> +       const struct kinetis_pinctrl_soc_info *info = &kpctl->info;
> +       const struct kinetis_pin_group *grp;
> +       struct pinctrl_map *new_map;
> +       struct device_node *parent;
> +
> +       /*
> +        * first find the group of this node and check if we need create
> +        * config maps for pins
> +        */
> +       grp = kinetis_pinctrl_find_group_by_name(info, np->name);
> +       if (!grp) {
> +               dev_err(info->dev, "unable to find group for node %s\n",
> +                       np->name);
> +               return -EINVAL;
> +       }
> +
> +       new_map = kmalloc(sizeof(struct pinctrl_map), GFP_KERNEL);
> +       if (!new_map)
> +               return -ENOMEM;


Use pinctrl_utils_reserve_map() from pinctrl-utils.h

> +static void kinetis_dt_free_map(struct pinctrl_dev *pctldev,
> +                               struct pinctrl_map *map, unsigned num_maps)
> +{
> +       kfree(map);
> +}

Use pinctrl_utils_dt_free_map().

> +static int kinetis_pinctrl_probe_dt(struct platform_device *pdev,
> +                               struct kinetis_pinctrl_soc_info *info)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct device_node *child;
> +       u32 nfuncs = 0;
> +       u32 i = 0;
> +       bool flat_funcs;
> +
> +       if (!np)
> +               return -ENODEV;
> +
> +       flat_funcs = kinetis_pinctrl_dt_is_flat_functions(np);

Why is there an _is_ in that function name? Totally unintuitive
to me.

I think I will have more comments on v2, this is just a first rough look.

Yours,
Linus Walleij
