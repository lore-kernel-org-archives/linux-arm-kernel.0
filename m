From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 9 Jun 2017 17:01:09 +0200
Subject: [PATCH v5 2/3] nvmem: add snvs_lpgpr driver
In-Reply-To: <20170609125730.25502-3-o.rempel@pengutronix.de>
References: <20170609125730.25502-1-o.rempel@pengutronix.de>
 <20170609125730.25502-3-o.rempel@pengutronix.de>
Message-ID: <2b309881-0134-c3f8-2037-b0e106719a64@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleksij,

please add the NXP guys in CC in order to give them a chance to review.

Am 09.06.2017 um 14:57 schrieb Oleksij Rempel:
> This is a driver for Low Power General Purpose Register (LPGPR)
> available on i.MX6 SoCs in Secure Non-Volatile Storage (SNVS)
> of this chip.
>
> It is a 32-bit read/write register located in the low power domain.
> Since LPGPR is located in the battery-backed power domain, LPGPR can
> be used by any application for retaining data during an SoC power-down
> mode.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/nvmem/Kconfig      |  10 ++++
>  drivers/nvmem/Makefile     |   2 +
>  drivers/nvmem/snvs_lpgpr.c | 138 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 150 insertions(+)
>  create mode 100644 drivers/nvmem/snvs_lpgpr.c
>
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 101ced4c84be..ea3044c5d6ee 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -144,4 +144,14 @@ config MESON_EFUSE
>  	  This driver can also be built as a module. If so, the module
>  	  will be called nvmem_meson_efuse.
>  
> +config NVMEM_SNVS_LPGPR
> +	tristate "Support for Low Power General Purpose Register"
> +	depends on SOC_IMX6 || COMPILE_TEST
> +	help
> +	  This is a driver for Low Power General Purpose Register (LPGPR) available on
> +	  i.MX6 SoCs in Secure Non-Volatile Storage (SNVS) of this chip.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nvmem-snvs-lpgpr.
> +
>  endif
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index 173140658693..4c589184acee 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -30,3 +30,5 @@ obj-$(CONFIG_NVMEM_VF610_OCOTP)	+= nvmem-vf610-ocotp.o
>  nvmem-vf610-ocotp-y		:= vf610-ocotp.o
>  obj-$(CONFIG_MESON_EFUSE)	+= nvmem_meson_efuse.o
>  nvmem_meson_efuse-y		:= meson-efuse.o
> +obj-$(CONFIG_NVMEM_SNVS_LPGPR)	+= nvmem_snvs_lpgpr.o
> +nvmem_snvs_lpgpr-y		:= snvs_lpgpr.o
> diff --git a/drivers/nvmem/snvs_lpgpr.c b/drivers/nvmem/snvs_lpgpr.c
> new file mode 100644
> index 000000000000..acb3ddc0d990
> --- /dev/null
> +++ b/drivers/nvmem/snvs_lpgpr.c
> @@ -0,0 +1,138 @@
> +/*
> + * Copyright (c) 2015 Pengutronix, Steffen Trumtrar <kernel@pengutronix.de>
> + * Copyright (c) 2017 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2
> + * as published by the Free Software Foundation.
> + */
> +
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +
> +struct snvs_lpgpr_cfg {
> +	int offset;
> +};
> +
> +struct snvs_lpgpr_priv {
> +	struct device_d			*dev;
> +	struct regmap			*regmap;
> +	struct nvmem_config		cfg;
> +	const struct snvs_lpgpr_cfg	*dcfg;
> +};
> +
> +static const struct snvs_lpgpr_cfg snvs_lpgpr_cfg_imx6q = {
> +	.offset = 0x68,
> +};
> +
> +static int snvs_lpgpr_write(void *context, unsigned int offset, void *_val,
> +			    size_t bytes)
> +{
> +	struct snvs_lpgpr_priv *priv = context;
> +	const struct snvs_lpgpr_cfg *dcfg = priv->dcfg;
> +	const u32 *val = _val;
> +	int i = 0, words = bytes / 4;
> +
> +	while (words--)
> +		regmap_write(priv->regmap, dcfg->offset + offset + (i++ * 4),
> +			     *val++);

according to the reference manual "57.9.14 SNVS_LP General Purpose
Register (SNVS_LPGPR)":

    When GPR_SL or GPR_HL bit is set, the register cannot be programmed.

I think the driver should handle this error case properly.

Best regards
Stefan
