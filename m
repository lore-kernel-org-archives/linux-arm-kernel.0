From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Feb 2015 12:48:08 +0000
Subject: [PATCH 01/11] mfd: add the Berlin controller driver
In-Reply-To: <1423671332-24580-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1423671332-24580-1-git-send-email-antoine.tenart@free-electrons.com>
 <1423671332-24580-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20150216124808.GC14545@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Feb 2015, Antoine Tenart wrote:

> Marvell Berlin SoC have two nodes providing multiple devices (clk,
> pinctrl, reset). While until now these drivers were initialized using
> initcalls, this wasn't a proper solution. This mfd driver will be
> responsible of adding these devices, to be probed properly.
> 
> It currently registers the pin controllers and the reset drivers for
> BG2, BG2CD and BG2Q in the soc and system controller nodes.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  drivers/mfd/Kconfig       |   5 ++
>  drivers/mfd/Makefile      |   2 +
>  drivers/mfd/berlin-ctrl.c | 180 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 187 insertions(+)
>  create mode 100644 drivers/mfd/berlin-ctrl.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 2e6b7311fabc..eda6dbec02ff 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -840,6 +840,11 @@ config STMPE_SPI
>  	  This is used to enable SPI interface of STMPE
>  endmenu
>  
> +config MFD_BERLIN_CTRL
> +	bool

Missing description.

Why can't this driver be built as a module?

> +	select MFD_CORE
> +	select MFD_SYSCON

Missing help.

>  config MFD_STA2X11
>  	bool "STMicroelectronics STA2X11"
>  	depends on STA2X11
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 53467e211381..adf60e85df20 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -179,3 +179,5 @@ obj-$(CONFIG_MFD_DLN2)		+= dln2.o
>  
>  intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
> +
> +obj-$(CONFIG_MFD_BERLIN_CTRL)	+= berlin-ctrl.o
> diff --git a/drivers/mfd/berlin-ctrl.c b/drivers/mfd/berlin-ctrl.c
> new file mode 100644
> index 000000000000..e3ce6f069f16
> --- /dev/null
> +++ b/drivers/mfd/berlin-ctrl.c
> @@ -0,0 +1,180 @@
> +/*
> + * Copyright (C) 2015 Marvell Technology Group Ltd.
> + *
> + * Antoine Tenart <antoine.tenart@free-electrons.com>

Author: Antoine Tenart <antoine.tenart@free-electrons.com>

> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/of.h>

kernel.h?

> +struct berlin_ctrl_priv {
> +	const struct mfd_cell	*devs;
> +	unsigned		ndevs;
> +};
> +
> +/*
> + * BG2 devices
> + */
> +static const struct mfd_cell berlin2_ctrl_chip_ctrl_subdevs[] = {
> +	{
> +		.name		= "berlin2-soc-pinctrl",
> +		.of_compatible	= "marvell,berlin2-soc-pinctrl",
> +	},
> +	{
> +		.name		= "berlin2-reset",
> +		.of_compatible	= "marvell,berlin2-reset",
> +	},
> +};
> +
> +static const struct mfd_cell berlin2_ctrl_system_ctrl_subdevs[] = {
> +	{
> +		.name		= "berlin2-system-pinctrl",
> +		.of_compatible	= "marvell,berlin2-system-pinctrl",
> +	},
> +};
> +
> +static const struct berlin_ctrl_priv berlin2_ctrl_chip_ctrl_data = {
> +	.devs	= berlin2_ctrl_chip_ctrl_subdevs,
> +	.ndevs	= ARRAY_SIZE(berlin2_ctrl_chip_ctrl_subdevs),
> +};
> +
> +static const struct berlin_ctrl_priv berlin2_ctrl_system_data = {
> +	.devs	= berlin2_ctrl_system_ctrl_subdevs,
> +	.ndevs	= ARRAY_SIZE(berlin2_ctrl_system_ctrl_subdevs),
> +};
> +
> +

Superfluous '\n'

> +/*
> + * BG2CD devices
> + */
> +static const struct mfd_cell berlin2cd_ctrl_chip_ctrl_subdevs[] = {
> +	{
> +		.name		= "berlin2cd-soc-pinctrl",
> +		.of_compatible	= "marvell,berlin2cd-soc-pinctrl",
> +	},
> +	{
> +		.name		= "berlin2-reset",
> +		.of_compatible	= "marvell,berlin2-reset",
> +	},
> +};
> +
> +static const struct mfd_cell berlin2cd_ctrl_system_ctrl_subdevs[] = {
> +	{
> +		.name		= "berlin2cd-system-pinctrl",
> +		.of_compatible	= "marvell,berlin2cd-system-pinctrl",
> +	},
> +};
> +
> +static const struct berlin_ctrl_priv berlin2cd_ctrl_chip_ctrl_data = {
> +	.devs	= berlin2cd_ctrl_chip_ctrl_subdevs,
> +	.ndevs	= ARRAY_SIZE(berlin2cd_ctrl_chip_ctrl_subdevs),
> +};
> +
> +static const struct berlin_ctrl_priv berlin2cd_ctrl_system_data = {
> +	.devs	= berlin2cd_ctrl_system_ctrl_subdevs,
> +	.ndevs	= ARRAY_SIZE(berlin2cd_ctrl_system_ctrl_subdevs),
> +};
> +
> +/*
> + * BG2Q devices
> + */
> +static const struct mfd_cell berlin2q_ctrl_chip_ctrl_subdevs[] = {
> +	{
> +		.name		= "berlin2q-soc-pinctrl",
> +		.of_compatible	= "marvell,berlin2q-soc-pinctrl",
> +	},
> +	{
> +		.name		= "berlin2-reset",
> +		.of_compatible	= "marvell,berlin2-reset",
> +	},
> +};
> +
> +static const struct mfd_cell berlin2q_ctrl_system_ctrl_subdevs[] = {
> +	{
> +		.name		= "berlin2q-system-pinctrl",
> +		.of_compatible	= "marvell,berlin2q-system-pinctrl",
> +	},
> +};
> +
> +static const struct berlin_ctrl_priv berlin2q_ctrl_chip_ctrl_data = {
> +	.devs	= berlin2q_ctrl_chip_ctrl_subdevs,
> +	.ndevs	= ARRAY_SIZE(berlin2q_ctrl_chip_ctrl_subdevs),
> +};
> +
> +static const struct berlin_ctrl_priv berlin2q_ctrl_system_data = {
> +	.devs	= berlin2q_ctrl_system_ctrl_subdevs,
> +	.ndevs	= ARRAY_SIZE(berlin2q_ctrl_system_ctrl_subdevs),
> +};
> +
> +
> +static const struct of_device_id berlin_ctrl_of_match[] = {
> +	/* BG2 */
> +	{
> +		.compatible	= "marvell,berlin2-chip-ctrl",
> +		.data		= &berlin2_ctrl_chip_ctrl_data,
> +	},
> +	{
> +		.compatible	= "marvell,berlin2-system-ctrl",
> +		.data		= &berlin2_ctrl_system_data,
> +	},
> +	/* BG2CD */
> +	{
> +		.compatible	= "marvell,berlin2cd-chip-ctrl",
> +		.data		= &berlin2cd_ctrl_chip_ctrl_data,
> +	},
> +	{
> +		.compatible	= "marvell,berlin2cd-system-ctrl",
> +		.data		= &berlin2cd_ctrl_system_data,
> +	},
> +	/* BG2Q */
> +	{
> +		.compatible	= "marvell,berlin2q-chip-ctrl",
> +		.data		= &berlin2q_ctrl_chip_ctrl_data,
> +	},
> +	{
> +		.compatible	= "marvell,berlin2q-system-ctrl",
> +		.data		= &berlin2q_ctrl_system_data,
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, berlin_ctrl_of_match);
> +
> +static int berlin_ctrl_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct of_device_id *match;
> +	const struct berlin_ctrl_priv *priv;
> +	int ret;
> +
> +	match = of_match_node(berlin_ctrl_of_match, dev->of_node);
> +	if (!match)
> +		return -EINVAL;
> +
> +	priv = match->data;
> +
> +	ret = mfd_add_devices(dev, 0, priv->devs, priv->ndevs, NULL, -1, NULL);
> +	if (ret) {
> +		dev_err(dev, "Failed to add devices: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}

I'm not sure I see the point in this driver.  Why can't you just
register these devices directly from DT?

> +static struct platform_driver berlin_ctrl_driver = {
> +	.probe	= berlin_ctrl_probe,
> +	.driver	= {
> +		.name = "berlin-ctrl",
> +		.of_match_table = berlin_ctrl_of_match,
> +	},
> +};
> +module_platform_driver(berlin_ctrl_driver);
> +
> +MODULE_AUTHOR("Antoine Tenart <antoine.tenart@free-electrons.com>");
> +MODULE_DESCRIPTION("Marvell Berlin controller driver (mfd)");
> +MODULE_LICENSE("GPL");

v2

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
