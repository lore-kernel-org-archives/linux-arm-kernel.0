From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 27 Jul 2016 11:17:31 +0200
Subject: [PATCH v2] reset: uniphier: add reset controller drivers for
 UniPhier SoCs
In-Reply-To: <1469557209-13089-1-git-send-email-yamada.masahiro@socionext.com>
References: <1469557209-13089-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1469611051.2470.15.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,

Am Mittwoch, den 27.07.2016, 03:20 +0900 schrieb Masahiro Yamada:
> This is the initial commit for UniPhier reset controller drivers.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2 (mostly suggested by Philipp Zabel):
>   - Unify multiple module_platform_driver() boilerplates into one
>   - Unify tiny driver code and decrease the number of files

Thank you, this looks much better.

[...]
> +++ b/drivers/reset/uniphier/reset-uniphier-core.c
> @@ -0,0 +1,270 @@
> +/*
> + * Copyright (C) 2016 Socionext Inc.
> + *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +#include "reset-uniphier.h"
> +
> +struct uniphier_reset_priv {
> +	struct reset_controller_dev rcdev;
> +	struct device *dev;
> +	struct regmap *regmap;
> +	const struct uniphier_reset_data *data;
> +};
> +
> +#define to_uniphier_reset_priv(_rcdev) \
> +			container_of(_rcdev, struct uniphier_reset_priv, rcdev)
> +
> +static int uniphier_reset_update(struct reset_controller_dev *rcdev,
> +				 unsigned long id, bool assert)
> +{
> +	struct uniphier_reset_priv *priv = to_uniphier_reset_priv(rcdev);
> +	const struct uniphier_reset_data *p;
> +	bool handled = false;
> +
> +	for (p = priv->data; p->id != UNIPHIER_RESET_ID_END; p++) {
> +		unsigned int val;
> +		int ret;
> +
> +		if (p->id != id)
> +			continue;
> +
> +		val = p->assert_val;
> +		if (!assert)
> +			val = ~val;
> +
> +		ret = regmap_write_bits(priv->regmap, p->reg, p->mask, val);
> +		if (ret)
> +			return ret;
> +
> +		handled = true;

Why does this continue to walk through the list after the correct id was
found?

> +	}
> +
> +	if (!handled) {
> +		dev_err(priv->dev, "reset_id=%lu was not handled\n", id);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
[...]
> +static int uniphier_reset_status(struct reset_controller_dev *rcdev,
> +				 unsigned long id)
> +{
> +	struct uniphier_reset_priv *priv = to_uniphier_reset_priv(rcdev);
> +	const struct uniphier_reset_data *p;
> +	bool handled = false;
> +
> +	for (p = priv->data; p->id != UNIPHIER_RESET_ID_END; p++) {
> +		unsigned int val;
> +		int ret;
> +
> +		if (p->id != id)
> +			continue;
> +
> +		ret = regmap_read(priv->regmap, p->reg, &val);
> +		if (ret)
> +			return ret;
> +
> +		if ((val ^ ~p->assert_val) & p->mask)
> +			return 1;

Same here if not asserted?

> +		handled = true;
> +	}
> +
> +	if (!handled) {
> +		dev_err(priv->dev, "reset_id=%lu was not found\n", id);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
[...]
> diff --git a/drivers/reset/uniphier/reset-uniphier-mio.c b/drivers/reset/uniphier/reset-uniphier-mio.c
> new file mode 100644
> index 0000000..cbcad75
> --- /dev/null
> +++ b/drivers/reset/uniphier/reset-uniphier-mio.c
> @@ -0,0 +1,55 @@
> +/*
> + * Copyright (C) 2016 Socionext Inc.
> + *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/bitops.h>
> +
> +#include "reset-uniphier.h"
> +
> +#define UNIPHIER_MIO_RESET_SD(index, ch)				\
> +	{								\
> +		.id = (index),						\
> +		.reg = 0x110 + 0x200 * (ch),				\
> +		.mask = BIT(26) | BIT(0),				\
> +	}
> +
> +#define UNIPHIER_MIO_RESET_EMMC_HW_RESET(index, ch)			\
> +	UNIPHIER_RESETX_SIMPLE((index), 0x80 + 0x200 * (ch), BIT(0))
> +
> +#define UNIPHIER_MIO_RESET_USB2(index, ch)				\
> +	UNIPHIER_RESETX_SIMPLE((index), 0x110 + 0x200 * (ch), BIT(24)),	\
> +	UNIPHIER_RESETX_SIMPLE((index), 0x114 + 0x200 * (ch), BIT(0))

Ah, so for USB2 reset you have two reset bits in separate registers. Are
you sure these are controlling the same reset line?
If the USB core does in fact have two separate reset inputs that just
happen to need asserting at the same time, this should still get two
separate ids. Same issue for the SD reset above, if the reset lines are
physically separate, please don't combine them in the driver.

[...]
> diff --git a/drivers/reset/uniphier/reset-uniphier-sys.c b/drivers/reset/uniphier/reset-uniphier-sys.c
> new file mode 100644
> index 0000000..bda96c0
> --- /dev/null
> +++ b/drivers/reset/uniphier/reset-uniphier-sys.c
> +const struct uniphier_reset_data uniphier_pxs2_sys_reset_data[] = {
> +	UNIPHIER_SLD3_SYS_RESET_STDMAC(8),		/* HSC, RLE */
> +	UNIPHIER_PRO4_SYS_RESET_USB3(16, 0),
> +	UNIPHIER_PRO4_SYS_RESET_USB3(17, 1),
> +	UNIPHIER_RESETX_SIMPLE(18, 0x2014, 0x15),	/* USB30PHY */
> +	UNIPHIER_RESETX_SIMPLE(19, 0x2014, 0x22),	/* USB31PHY */
[...]
> +	UNIPHIER_RESETX_SIMPLE(18, 0x200c, 0xf000),	/* USB30PHY */

Same here.

regards
Philipp
