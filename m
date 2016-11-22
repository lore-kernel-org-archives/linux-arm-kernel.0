From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 22 Nov 2016 11:22:05 +0100
Subject: [PATCH 1/6] reset: hisilicon: add reset core
In-Reply-To: <1479800961-6249-2-git-send-email-zhangfei.gao@linaro.org>
References: <1479800961-6249-1-git-send-email-zhangfei.gao@linaro.org>
 <1479800961-6249-2-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1479810125.3112.26.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhangfei,

Am Dienstag, den 22.11.2016, 15:49 +0800 schrieb Zhangfei Gao:
> reset.c will be shared by hisilicon chips like hi3660 and hi6220
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/reset/Makefile           |   2 +-
>  drivers/reset/hisilicon/Makefile |   1 +
>  drivers/reset/hisilicon/reset.c  | 108 +++++++++++++++++++++++++++++++++++++++
>  drivers/reset/hisilicon/reset.h  |  37 ++++++++++++++
>  4 files changed, 147 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/reset/hisilicon/reset.c
>  create mode 100644 drivers/reset/hisilicon/reset.h
> 
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index bbe7026..7e3dc4e 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -1,8 +1,8 @@
>  obj-y += core.o
> -obj-y += hisilicon/
>  obj-$(CONFIG_ARCH_STI) += sti/
>  obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
>  obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
> +obj-$(CONFIG_ARCH_HISI) += hisilicon/
>  obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
>  obj-$(CONFIG_RESET_MESON) += reset-meson.o
>  obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
> diff --git a/drivers/reset/hisilicon/Makefile b/drivers/reset/hisilicon/Makefile
> index c932f86..df511f5 100644
> --- a/drivers/reset/hisilicon/Makefile
> +++ b/drivers/reset/hisilicon/Makefile
> @@ -1 +1,2 @@
> +obj-y	+= reset.o
>  obj-$(CONFIG_COMMON_RESET_HI6220) += hi6220_reset.o
> diff --git a/drivers/reset/hisilicon/reset.c b/drivers/reset/hisilicon/reset.c
> new file mode 100644
> index 0000000..c4971c9
> --- /dev/null
> +++ b/drivers/reset/hisilicon/reset.c
> @@ -0,0 +1,108 @@
> +/*
> + * Copyright (c) 2016-2017 Linaro Ltd.
> + * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/types.h>
> +#include <linux/of_device.h>
> +#include <linux/mfd/syscon.h>
> +
> +#include "reset.h"
> +
> +struct hisi_reset_controller {
> +	struct reset_controller_dev rst;
> +	const struct hisi_reset_channel_data *channels;
> +	struct regmap *map;
> +};
> +
> +#define to_hisi_reset_controller(_rst) \
> +	container_of(_rst, struct hisi_reset_controller, rst)
> +
> +static int hisi_reset_program_hw(struct reset_controller_dev *rcdev,
> +				 unsigned long idx, bool assert)
> +{
> +	struct hisi_reset_controller *rc = to_hisi_reset_controller(rcdev);
> +	const struct hisi_reset_channel_data *ch;
> +
> +	if (idx >= rcdev->nr_resets)
> +		return -EINVAL;
> +
> +	ch = &rc->channels[idx];
> +
> +	if (assert)
> +		return regmap_write(rc->map, ch->enable.reg,
> +				    GENMASK(ch->enable.msb, ch->enable.lsb));
> +	else
> +		return regmap_write(rc->map, ch->disable.reg,
> +				    GENMASK(ch->disable.msb, ch->disable.lsb));

These fields are always 1-bit wide and you are not using the
regmap_field functions to access them, so I'd suggest to remove the
struct reg_field indirection and overhead and just write

	if (assert)
		return regmap_write(rc->map, ch->enable_reg, ch->bit);
	else
		return regmap_write(rc->map, ch->disable_reg, ch->bit);

here.

> +}
> +
> +static int hisi_reset_assert(struct reset_controller_dev *rcdev,
> +			     unsigned long idx)
> +{
> +	return hisi_reset_program_hw(rcdev, idx, true);
> +}
> +
> +static int hisi_reset_deassert(struct reset_controller_dev *rcdev,
> +			       unsigned long idx)
> +{
> +	return hisi_reset_program_hw(rcdev, idx, false);
> +}
> +
> +static int hisi_reset_dev(struct reset_controller_dev *rcdev,
> +			  unsigned long idx)
> +{
> +	int err;
> +
> +	err = hisi_reset_assert(rcdev, idx);
> +	if (err)
> +		return err;
> +
> +	return hisi_reset_deassert(rcdev, idx);
> +}
> +
> +static struct reset_control_ops hisi_reset_ops = {
> +	.reset    = hisi_reset_dev,
> +	.assert   = hisi_reset_assert,
> +	.deassert = hisi_reset_deassert,
> +};
> +
> +int hisi_reset_probe(struct platform_device *pdev)
> +{
> +	struct hisi_reset_controller *rc;
> +	struct device_node *np = pdev->dev.of_node;
> +	struct hisi_reset_controller_data *d;
> +	struct device *dev = &pdev->dev;
> +	const struct of_device_id *match;
> +
> +	match = of_match_device(dev->driver->of_match_table, dev);
> +	if (!match || !match->data)
> +		return -EINVAL;
> +
> +	d = (struct hisi_reset_controller_data *)match->data;
> +	rc = devm_kzalloc(dev, sizeof(*rc), GFP_KERNEL);
> +	if (!rc)
> +		return -ENOMEM;
> +
> +	rc->map = syscon_regmap_lookup_by_phandle(np, "hisi,rst-syscon");
> +	if (IS_ERR(rc->map)) {
> +		dev_err(dev, "failed to get hisi,rst-syscon\n");
> +		return PTR_ERR(rc->map);
> +	}
> +
> +	rc->rst.ops = &hisi_reset_ops,
> +	rc->rst.of_node = np;
> +	rc->rst.nr_resets = d->nr_channels;
> +	rc->channels = d->channels;
> +
> +	return reset_controller_register(&rc->rst);
> +}
> +EXPORT_SYMBOL_GPL(hisi_reset_probe);
> diff --git a/drivers/reset/hisilicon/reset.h b/drivers/reset/hisilicon/reset.h
> new file mode 100644
> index 0000000..77259ee
> --- /dev/null
> +++ b/drivers/reset/hisilicon/reset.h
> @@ -0,0 +1,37 @@
> +/*
> + * Copyright (c) 2016-2017 Linaro Ltd.
> + * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef __HISILICON_RESET_H
> +#define __HISILICON_RESET_H
> +
> +#include <linux/device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +/* reset separated register offset is 0x4 */
> +#define HISI_RST_SEP(off, bit)					\
> +	{ .enable	= REG_FIELD(off, bit, bit),		\
> +	  .disable	= REG_FIELD(off + 0x4, bit, bit),	\
> +	  .status	= REG_FIELD(off + 0x8, bit, bit), }
> +
> +struct hisi_reset_channel_data {
> +	struct reg_field enable;
> +	struct reg_field disable;
> +	struct reg_field status;
> +};

Are you expecting the bits to be at different positions in the
enable/disable/status registers? How about just

#define HISI_RST_SEP(off, _bit)		\
	{ .enable_reg	= (off),	\
	  .disable_reg	= (off) + 0x4,	\
	  .status_reg	= (off) + 0x8,	\
	  .bit		= (_bit), }

struct hisi_reset_channel_data {
	unsigned int enable_reg;
	unsigned int disable_reg;
	unsigned int status_reg;
	unsigned int bit;
};

as those struct reg_field are not accessed via regmap_field_* functions
anyway.

> +
> +struct hisi_reset_controller_data {
> +	int nr_channels;
> +	const struct hisi_reset_channel_data *channels;
> +};
> +
> +int hisi_reset_probe(struct platform_device *pdev);
> +
> +#endif /* __HISILICON_RESET_H */

regards
Philipp
