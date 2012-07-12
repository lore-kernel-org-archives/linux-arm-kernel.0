From: linuxzsc@gmail.com (Richard Zhao)
Date: Thu, 12 Jul 2012 20:16:38 +0800
Subject: [PATCH v3 1/2] pinctrl: pinctrl-imx: add support for set bits
 for general purpose registers
In-Reply-To: <1342093124-24658-1-git-send-email-b29396@freescale.com>
References: <1342093124-24658-1-git-send-email-b29396@freescale.com>
Message-ID: <20120712121636.GA2123@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2012 at 07:38:43PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> The General Purpose Registers (GPR) is used to select operating modes for
> general features in the SoC, usually not related to the IOMUX itself,
> but it does belong to IOMUX controller.
> We simply provide an convient API for driver to call to write/read the general
> purpose register bits if needed.
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> ---
> ChangeLog v2->v3:
> * add spinlock to protect write
> * add a parameter for read API to distinguish with return error
> ChangeLog v1->v2:
> * add gpr read api
> * change api name a bit to *_write and *_read
> * add -EPROBE_DEFER support
> * define macros for gpr registers for imx6q
> * change driver loadding priority to postcore_init at satisfy clients driver
>   to use imx_pinctrl_gpr_{read | write} APIs at best
> ---
>  drivers/pinctrl/pinctrl-imx.c   |   36 ++++
>  drivers/pinctrl/pinctrl-imx51.c |    2 +-
>  drivers/pinctrl/pinctrl-imx53.c |    2 +-
>  drivers/pinctrl/pinctrl-imx6q.c |    2 +-
>  include/linux/fsl/imx-pinctrl.h |  340 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 379 insertions(+), 3 deletions(-)
>  create mode 100644 include/linux/fsl/imx-pinctrl.h
> 
> diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
> index 44e9726..4568f5a 100644
> --- a/drivers/pinctrl/pinctrl-imx.c
> +++ b/drivers/pinctrl/pinctrl-imx.c
> @@ -23,6 +23,7 @@
>  #include <linux/pinctrl/pinctrl.h>
>  #include <linux/pinctrl/pinmux.h>
>  #include <linux/slab.h>
> +#include <linux/spinlock.h>
>  
>  #include "core.h"
>  #include "pinctrl-imx.h"
> @@ -52,8 +53,41 @@ struct imx_pinctrl {
>  	struct pinctrl_dev *pctl;
>  	void __iomem *base;
>  	const struct imx_pinctrl_soc_info *info;
> +	spinlock_t gprlock;
>  };
>  
> +static struct imx_pinctrl *imx_pinctrl;
> +/*
> + * Set bits for general purpose registers
> + */
> +int imx_pinctrl_gpr_write(u8 gpr, u32 mask, u32 val)
> +{
> +	u32 reg;
> +
> +	if (!imx_pinctrl)
> +		return -EPROBE_DEFER;
> +
> +	spin_lock(&imx_pinctrl->gprlock);
spin_lock_irqsave? We don't know whether people call it in isr.

> +	reg = readl(imx_pinctrl->base + gpr);
> +	reg &= ~mask;
> +	writel(reg | (val & mask), imx_pinctrl->base + gpr);
> +	spin_unlock(&imx_pinctrl->gprlock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(imx_pinctrl_gpr_write);
> +
> +int imx_pinctrl_gpr_read(u8 gpr, u32 *val)
> +{
> +	if (!imx_pinctrl)
> +		return -EPROBE_DEFER;
> +
> +	*val = readl(imx_pinctrl->base + gpr);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(imx_pinctrl_gpr_read);
> +
>  static const struct imx_pin_reg *imx_find_pin_reg(
>  				const struct imx_pinctrl_soc_info *info,
>  				unsigned pin, bool is_mux, unsigned mux)
> @@ -587,6 +621,8 @@ int __devinit imx_pinctrl_probe(struct platform_device *pdev,
>  	if (!ipctl->base)
>  		return -EBUSY;
>  
> +	spin_lock_init(&ipctl->gprlock);
> +	imx_pinctrl = ipctl;
>  	imx_pinctrl_desc.name = dev_name(&pdev->dev);
>  	imx_pinctrl_desc.pins = info->pins;
>  	imx_pinctrl_desc.npins = info->npins;
> diff --git a/drivers/pinctrl/pinctrl-imx51.c b/drivers/pinctrl/pinctrl-imx51.c
> index 689b3c8..aa37634 100644
> --- a/drivers/pinctrl/pinctrl-imx51.c
> +++ b/drivers/pinctrl/pinctrl-imx51.c
> @@ -1310,7 +1310,7 @@ static int __init imx51_pinctrl_init(void)
>  {
>  	return platform_driver_register(&imx51_pinctrl_driver);
>  }
> -arch_initcall(imx51_pinctrl_init);
> +postcore_initcall(imx51_pinctrl_init);
>  
>  static void __exit imx51_pinctrl_exit(void)
>  {
> diff --git a/drivers/pinctrl/pinctrl-imx53.c b/drivers/pinctrl/pinctrl-imx53.c
> index 1f49e16..cff42a1 100644
> --- a/drivers/pinctrl/pinctrl-imx53.c
> +++ b/drivers/pinctrl/pinctrl-imx53.c
> @@ -1637,7 +1637,7 @@ static int __init imx53_pinctrl_init(void)
>  {
>  	return platform_driver_register(&imx53_pinctrl_driver);
>  }
> -arch_initcall(imx53_pinctrl_init);
> +postcore_initcall(imx53_pinctrl_init);
>  
>  static void __exit imx53_pinctrl_exit(void)
>  {
> diff --git a/drivers/pinctrl/pinctrl-imx6q.c b/drivers/pinctrl/pinctrl-imx6q.c
> index 7737d4d..6974238 100644
> --- a/drivers/pinctrl/pinctrl-imx6q.c
> +++ b/drivers/pinctrl/pinctrl-imx6q.c
> @@ -2319,7 +2319,7 @@ static int __init imx6q_pinctrl_init(void)
>  {
>  	return platform_driver_register(&imx6q_pinctrl_driver);
>  }
> -arch_initcall(imx6q_pinctrl_init);
> +postcore_initcall(imx6q_pinctrl_init);
>  
>  static void __exit imx6q_pinctrl_exit(void)
>  {
> diff --git a/include/linux/fsl/imx-pinctrl.h b/include/linux/fsl/imx-pinctrl.h
> new file mode 100644
> index 0000000..37ee3a7
> --- /dev/null
> +++ b/include/linux/fsl/imx-pinctrl.h
> @@ -0,0 +1,340 @@
> +/*
> + * Copyright (C) 2012 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __FSL_IMX_PINCTRL_H__
> +#define __FSL_IMX_PINCTRL_H__
> +
> +#include <linux/bitops.h>
> +
> +#define IMX_PINCTRL_GPR_ERR \
> +	"CONFIG_PINCTRL_IMX is not selected, simply return\n"
> +
> +#ifdef CONFIG_PINCTRL_IMX
> +extern int imx_pinctrl_gpr_write(u8 gpr, u32 mask, u32 val);
> +extern int imx_pinctrl_gpr_read(u8 gpr, u32 val);
					   u32 *

> +#else
> +static inline int imx_pinctrl_gpr_write(u8 gpr, u32 mask, u32 val)
> +{
> +	WARN(1, IMX_PINCTRL_GPR_ERR);
> +	return -ENODEV;
> +}
> +
> +static inline int imx_pinctrl_gpr_read(u8 gpr, u32 val)
						  u32 *
> +{
> +	WARN(1, IMX_PINCTRL_GPR_ERR);
> +	return -ENODEV;
> +}
> +#endif

Thanks
Richard
