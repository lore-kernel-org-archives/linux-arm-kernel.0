From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 22 Jul 2015 14:50:31 +0200
Subject: [PATCH v2 2/2] regulator: mt6311: Add support for mt6311 regulator
In-Reply-To: <1437566453-13117-3-git-send-email-henryc.chen@mediatek.com>
References: <1437566453-13117-1-git-send-email-henryc.chen@mediatek.com>
 <1437566453-13117-3-git-send-email-henryc.chen@mediatek.com>
Message-ID: <CABxcv=ncxfeqo1vfz6XzJWYUOGeFGAbDmz2M_PzM+8PBQvXjgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Henry,

On Wed, Jul 22, 2015 at 2:00 PM, Henry Chen <henryc.chen@mediatek.com> wrote:
> Add regulator support for mt6311.
> It has 2 regulaotrs - Buck and LDO, provide the related buck/ldo voltage
> data to the driver, and creates the regulator_desc table. Supported
> operations for Buck are enabled/disabled and voltage change, only
> enabled/disabled for LDO.
>
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  drivers/regulator/Kconfig            |   9 ++
>  drivers/regulator/Makefile           |   1 +
>  drivers/regulator/mt6311-regulator.c | 208 +++++++++++++++++++++++++++++++++++
>  drivers/regulator/mt6311-regulator.h |  65 +++++++++++
>  include/linux/regulator/mt6311.h     |  29 +++++
>  5 files changed, 312 insertions(+)
>  create mode 100644 drivers/regulator/mt6311-regulator.c
>  create mode 100644 drivers/regulator/mt6311-regulator.h
>  create mode 100644 include/linux/regulator/mt6311.h
>
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index bef3bde..aab09ac 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -451,6 +451,15 @@ config REGULATOR_MC13892
>           Say y here to support the regulators found on the Freescale MC13892
>           PMIC.
>
> +config REGULATOR_MT6311
> +       tristate "MediaTek MT6311 PMIC"
> +       depends on I2C
> +       help
> +         Say y here to select this option to enable the power regulator of
> +         MediaTek MT6311 PMIC.
> +         This driver supports the control of different power rails of device
> +         through regulator interface.
> +
>  config REGULATOR_MT6397
>         tristate "MediaTek MT6397 PMIC"
>         depends on MFD_MT6397
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index 91bf762..45e790f 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -60,6 +60,7 @@ obj-$(CONFIG_REGULATOR_MAX77843) += max77843.o
>  obj-$(CONFIG_REGULATOR_MC13783) += mc13783-regulator.o
>  obj-$(CONFIG_REGULATOR_MC13892) += mc13892-regulator.o
>  obj-$(CONFIG_REGULATOR_MC13XXX_CORE) +=  mc13xxx-regulator-core.o
> +obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
>  obj-$(CONFIG_REGULATOR_MT6397) += mt6397-regulator.o
>  obj-$(CONFIG_REGULATOR_QCOM_RPM) += qcom_rpm-regulator.o
>  obj-$(CONFIG_REGULATOR_QCOM_SPMI) += qcom_spmi-regulator.o
> diff --git a/drivers/regulator/mt6311-regulator.c b/drivers/regulator/mt6311-regulator.c
> new file mode 100644
> index 0000000..d990dc9
> --- /dev/null
> +++ b/drivers/regulator/mt6311-regulator.c
> @@ -0,0 +1,208 @@
> +/*
> + * Copyright (c) 2015 MediaTek Inc.
> + * Author: Henry Chen <henryc.chen@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/gpio.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regulator/of_regulator.h>
> +#include <linux/regulator/mt6311.h>
> +#include <linux/slab.h>
> +#include "mt6311-regulator.h"
> +
> +struct mt6311 {
> +       struct device *dev;
> +       struct regmap *regmap;
> +       struct regulator_dev *rdev[MT6311_MAX_REGULATORS];
> +       int num_regulator;
> +       int chip_cid;
> +};

It seems this struct can be removed, the rdev, num_regulator and
chip_cid fields are set but not used and dev and regmap are only used
to set the struct regulator_config fields in mt6311_regulator_init().
But that won't be necessary if you just remove the
mt6311_regulator_init() function and move the regulator registration
logic to mt6311_i2c_probe().

Best regards,
Javier
