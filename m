From: lznuaa@gmail.com (Zhi Li)
Date: Mon, 6 Jul 2015 22:02:48 -0500
Subject: [PATCH 3/4][v2] ARM: imx: pinctrl-imx: imx7d: add support for
 iomuxc lpsr
In-Reply-To: <1436223546-6333-3-git-send-email-aalonso@freescale.com>
References: <1436223546-6333-1-git-send-email-aalonso@freescale.com>
 <1436223546-6333-3-git-send-email-aalonso@freescale.com>
Message-ID: <CAHrpEqQJk+n=FwF_G-ugXmRtboyD2uc9LcAU9_2r2S+ra5brXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 6, 2015 at 5:59 PM, Adrian Alonso <aalonso@freescale.com> wrote:
> * Extend pinctrl-imx driver to support iomux lpsr conntroller,
> * iMX7D has two iomuxc controllers, iomuxc controller similar as
>   previous iMX SoC generation and iomuxc-lpsr which provides
>   low power state rentetion capabilities on gpios that are part of
>   iomuxc-lpsr (GPIO1_IO7..GPIO1_IO0).
> * Use IOMUXC_LPSR_SUPPORT and iput_val most significant bits to
>   properly configure iomuxc/iomuxc-lpsr settings.
> * Version 2:
>   - Add suggested comment for input select register shared between
>     iomuxc-lpsr and normal iomuxc controller.
>   - Use IOMUXC_LPSR_MASK to extract pad group id and aling pin_id to
>     16 bit representation.
>
> Signed-off-by: Adrian Alonso <aalonso@freescale.com>
> ---

Change log should be here

 * Version 2:
   - Add suggested comment for input select register shared between
     iomuxc-lpsr and normal iomuxc controller.
   - Use IOMUXC_LPSR_MASK to extract pad group id and aling pin_id to
     16 bit representation.

>  drivers/pinctrl/freescale/pinctrl-imx.c | 73 ++++++++++++++++++++++-----------
>  drivers/pinctrl/freescale/pinctrl-imx.h |  7 +++-
>  2 files changed, 56 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
> index d7b98ba..8de1790 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> @@ -1,7 +1,7 @@
>  /*
>   * Core driver for the imx pin controller
>   *
> - * Copyright (C) 2012 Freescale Semiconductor, Inc.
> + * Copyright (C) 2012-2015 Freescale Semiconductor, Inc.
>   * Copyright (C) 2012 Linaro Ltd.
>   *
>   * Author: Dong Aisheng <dong.aisheng@linaro.org>
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/of_address.h>
>  #include <linux/pinctrl/machine.h>
>  #include <linux/pinctrl/pinconf.h>
>  #include <linux/pinctrl/pinctrl.h>
> @@ -38,7 +39,6 @@
>  struct imx_pinctrl {
>         struct device *dev;
>         struct pinctrl_dev *pctl;
> -       void __iomem *base;
>         const struct imx_pinctrl_soc_info *info;
>  };
>
> @@ -212,12 +212,12 @@ static int imx_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
>
>                 if (info->flags & SHARE_MUX_CONF_REG) {
>                         u32 reg;
> -                       reg = readl(ipctl->base + pin_reg->mux_reg);
> +                       reg = readl(pin_reg->base + pin_reg->mux_reg);
>                         reg &= ~(0x7 << 20);
>                         reg |= (pin->mux_mode << 20);
> -                       writel(reg, ipctl->base + pin_reg->mux_reg);
> +                       writel(reg, pin_reg->base + pin_reg->mux_reg);
>                 } else {
> -                       writel(pin->mux_mode, ipctl->base + pin_reg->mux_reg);
> +                       writel(pin->mux_mode, pin_reg->base + pin_reg->mux_reg);
>                 }
>                 dev_dbg(ipctl->dev, "write: offset 0x%x val 0x%x\n",
>                         pin_reg->mux_reg, pin->mux_mode);
> @@ -245,16 +245,22 @@ static int imx_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
>                          * The input_reg[i] here is actually some IOMUXC general
>                          * purpose register, not regular select input register.
>                          */
> -                       val = readl(ipctl->base + pin->input_reg);
> +                       val = readl(pin_reg->base + pin->input_reg);
>                         val &= ~mask;
>                         val |= select << shift;
> -                       writel(val, ipctl->base + pin->input_reg);
> +                       writel(val, pin_reg->base + pin->input_reg);
>                 } else if (pin->input_reg) {
>                         /*
>                          * Regular select input register can never be at offset
>                          * 0, and we only print register value for regular case.
>                          */
> -                       writel(pin->input_val, ipctl->base + pin->input_reg);
> +                       if (info->flags & IOMUXC_LPSR_SUPPORT &&
> +                                       IOMUXC_LPSR_MASK(pin->input_val))
> +                       /* iomuxc-lpsr select input register shared with normal iomuxc */
> +                               writel(pin->input_val, info->base + pin->input_reg);
> +                       else
> +                               writel(pin->input_val, pin_reg->base + pin->input_reg);
> +
>                         dev_dbg(ipctl->dev,
>                                 "==>select_input: offset 0x%x val 0x%x\n",
>                                 pin->input_reg, pin->input_val);
> @@ -326,10 +332,10 @@ static int imx_pmx_gpio_request_enable(struct pinctrl_dev *pctldev,
>         return -EINVAL;
>
>  mux_pin:
> -       reg = readl(ipctl->base + pin_reg->mux_reg);
> +       reg = readl(pin_reg->base + pin_reg->mux_reg);
>         reg &= ~(0x7 << 20);
>         reg |= imx_pin->config;
> -       writel(reg, ipctl->base + pin_reg->mux_reg);
> +       writel(reg, pin_reg->base + pin_reg->mux_reg);
>
>         return 0;
>  }
> @@ -354,12 +360,12 @@ static int imx_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
>                 return -EINVAL;
>
>         /* IBE always enabled allows us to read the value "on the wire" */
> -       reg = readl(ipctl->base + pin_reg->mux_reg);
> +       reg = readl(pin_reg->base + pin_reg->mux_reg);
>         if (input)
>                 reg &= ~0x2;
>         else
>                 reg |= 0x2;
> -       writel(reg, ipctl->base + pin_reg->mux_reg);
> +       writel(reg, pin_reg->base + pin_reg->mux_reg);
>
>         return 0;
>  }
> @@ -386,7 +392,7 @@ static int imx_pinconf_get(struct pinctrl_dev *pctldev,
>                 return -EINVAL;
>         }
>
> -       *config = readl(ipctl->base + pin_reg->conf_reg);
> +       *config = readl(pin_reg->base + pin_reg->conf_reg);
>
>         if (info->flags & SHARE_MUX_CONF_REG)
>                 *config &= 0xffff;
> @@ -415,12 +421,12 @@ static int imx_pinconf_set(struct pinctrl_dev *pctldev,
>         for (i = 0; i < num_configs; i++) {
>                 if (info->flags & SHARE_MUX_CONF_REG) {
>                         u32 reg;
> -                       reg = readl(ipctl->base + pin_reg->conf_reg);
> +                       reg = readl(pin_reg->base + pin_reg->conf_reg);
>                         reg &= ~0xffff;
>                         reg |= configs[i];
> -                       writel(reg, ipctl->base + pin_reg->conf_reg);
> +                       writel(reg, pin_reg->base + pin_reg->conf_reg);
>                 } else {
> -                       writel(configs[i], ipctl->base + pin_reg->conf_reg);
> +                       writel(configs[i], pin_reg->base + pin_reg->conf_reg);
>                 }
>                 dev_dbg(ipctl->dev, "write: offset 0x%x val 0x%lx\n",
>                         pin_reg->conf_reg, configs[i]);
> @@ -442,7 +448,7 @@ static void imx_pinconf_dbg_show(struct pinctrl_dev *pctldev,
>                 return;
>         }
>
> -       config = readl(ipctl->base + pin_reg->conf_reg);
> +       config = readl(pin_reg->base + pin_reg->conf_reg);
>         seq_printf(s, "0x%lx", config);
>  }
>
> @@ -551,14 +557,25 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
>                 }
>
>                 pin_id = mux_reg ? mux_reg / 4 : conf_reg / 4;
> +
> +               pin->input_reg = be32_to_cpu(*list++);
> +               pin->mux_mode = be32_to_cpu(*list++);
> +               pin->input_val = be32_to_cpu(*list++);
> +
> +               if (info->flags & IOMUXC_LPSR_SUPPORT &&
> +                       IOMUXC_LPSR_MASK(pin->input_val))
> +                               pin_id = IOMUXC_LPSR_MASK(pin->input_val);
> +
>                 pin_reg = &info->pin_regs[pin_id];
>                 pin->pin = pin_id;
>                 grp->pin_ids[i] = pin_id;
>                 pin_reg->mux_reg = mux_reg;
>                 pin_reg->conf_reg = conf_reg;
> -               pin->input_reg = be32_to_cpu(*list++);
> -               pin->mux_mode = be32_to_cpu(*list++);
> -               pin->input_val = be32_to_cpu(*list++);
> +               pin_reg->base = info->base;
> +
> +               if (info->flags & IOMUXC_LPSR_SUPPORT &&
> +                       IOMUXC_LPSR_MASK(pin->input_val))
> +                               pin_reg->base = info->base_lpsr;
>
>                 /* SION bit is in mux register */
>                 config = be32_to_cpu(*list++);
> @@ -683,6 +700,7 @@ static int imx_pinctrl_probe_dt(struct platform_device *pdev,
>  int imx_pinctrl_probe(struct platform_device *pdev,
>                       struct imx_pinctrl_soc_info *info)
>  {
> +       struct device_node *dev_np = pdev->dev.of_node;
>         struct imx_pinctrl *ipctl;
>         struct resource *res;
>         int ret, i;
> @@ -709,9 +727,18 @@ int imx_pinctrl_probe(struct platform_device *pdev,
>         }
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       ipctl->base = devm_ioremap_resource(&pdev->dev, res);
> -       if (IS_ERR(ipctl->base))
> -               return PTR_ERR(ipctl->base);
> +       info->base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(info->base))
> +               return PTR_ERR(info->base);
> +
> +       if (info->flags & IOMUXC_LPSR_SUPPORT) {
> +               info->base_lpsr = of_iomap(dev_np, 1);

Can you use ?
           res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
           info->base_lpsr = evm_ioremap_resource(&pdev->dev, res);

> +               if (IS_ERR(info->base_lpsr)) {
> +                       dev_err(&pdev->dev,
> +                               "iomuxc-lpsr base address not found\n");
> +                       return PTR_ERR(info->base_lpsr);
> +               }
> +       }
>
>         imx_pinctrl_desc.name = dev_name(&pdev->dev);
>         imx_pinctrl_desc.pins = info->pins;
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.h b/drivers/pinctrl/freescale/pinctrl-imx.h
> index 49e55d3..5e0f2e0 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.h
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.h
> @@ -1,7 +1,7 @@
>  /*
>   * IMX pinmux core definitions
>   *
> - * Copyright (C) 2012 Freescale Semiconductor, Inc.
> + * Copyright (C) 2012-2015 Freescale Semiconductor, Inc.
>   * Copyright (C) 2012 Linaro Ltd.
>   *
>   * Author: Dong Aisheng <dong.aisheng@linaro.org>
> @@ -69,6 +69,7 @@ struct imx_pmx_func {
>  struct imx_pin_reg {
>         s16 mux_reg;
>         s16 conf_reg;
> +       void __iomem *base;
>  };
>
>  struct imx_pinctrl_soc_info {
> @@ -81,9 +82,13 @@ struct imx_pinctrl_soc_info {
>         struct imx_pmx_func *functions;
>         unsigned int nfunctions;
>         unsigned int flags;
> +       void __iomem *base;
> +       void __iomem *base_lpsr;
>  };
>
>  #define SHARE_MUX_CONF_REG     0x1
> +#define IOMUXC_LPSR_SUPPORT    0x2
> +#define IOMUXC_LPSR_MASK(id)   ((id >> 0x10) & 0xffff)
>
>  #define NO_MUX         0x0
>  #define NO_PAD         0x0
> --
> 2.1.4
>
