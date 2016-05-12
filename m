From: eric@anholt.net (Eric Anholt)
Date: Thu, 12 May 2016 16:23:46 -0700
Subject: [PATCH 2/4] thermal: bcm2835: add thermal driver for bcm2835 soc
In-Reply-To: <1463063738-11506-3-git-send-email-kernel@martin.sperl.org>
References: <1463063738-11506-1-git-send-email-kernel@martin.sperl.org>
 <1463063738-11506-3-git-send-email-kernel@martin.sperl.org>
Message-ID: <87shxmamil.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> Add basic thermal driver for bcm2835 SOC.
>
> This driver currently relies on the firmware setting up the
> tsense HW block and does not set it up itself.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  drivers/thermal/Kconfig               |   5 +
>  drivers/thermal/Makefile              |   1 +
>  drivers/thermal/bcm/Kconfig           |   4 +
>  drivers/thermal/bcm/Makefile          |   1 +
>  drivers/thermal/bcm/bcm2835_thermal.c | 205 ++++++++++++++++++++++++++++++++++
>  5 files changed, 216 insertions(+)
>  create mode 100644 drivers/thermal/bcm/Kconfig
>  create mode 100644 drivers/thermal/bcm/Makefile
>  create mode 100644 drivers/thermal/bcm/bcm2835_thermal.c
>

> diff --git a/drivers/thermal/bcm/bcm2835_thermal.c b/drivers/thermal/bcm/bcm2835_thermal.c
> new file mode 100644
> index 0000000..a1fdc84
> --- /dev/null
> +++ b/drivers/thermal/bcm/bcm2835_thermal.c
> @@ -0,0 +1,205 @@
> +/*
> + * Driver for Broadcom BCM2835 soc temperature sensor
> + *
> + * Copyright (C) 2015 Martin Sperl
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
> +#include <linux/clk.h>
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/thermal.h>
> +
> +#define BCM2835_TS_TSENSCTL			0x00
> +#define BCM2835_TS_TSENSSTAT			0x04
> +
> +#define BCM2835_TS_TSENSCTL_PRWDW		BIT(0)
> +#define BCM2835_TS_TSENSCTL_RSTB		BIT(1)
> +#define BCM2835_TS_TSENSCTL_CTRL		BIT(0)
> +#define BCM2835_TS_TSENSCTL_EN_INT		BIT(0)
> +#define BCM2835_TS_TSENSCTL_DIRECT		BIT(0)
> +#define BCM2835_TS_TSENSCTL_CLR_INT		BIT(0)

Bad bit definitions here.  CTRL is a field from 2:4, en_int is bit 5,
direct is bit 6, clr is bit 7.

> +#define BCM2835_TS_TSENSCTL_THOLD_SHIFT		8
> +#define BCM2835_TS_TSENSCTL_THOLD_BITS		10
> +#define BCM2835_TS_TSENSCTL_THOLD_MASK		     \
> +	GENMASK(BCM2835_TS_TSENSCTL_THOLD_BITS +     \
> +		BCM2835_TS_TSENSCTL_THOLD_SHIFT - 1, \
> +		BCM2835_TS_TSENSCTL_THOLD_SHIFT)
> +#define BCM2835_TS_TSENSCTL_RSTDELAY_SHIFT	18
> +#define BCM2835_TS_TSENSCTL_RSTDELAY_BITS	8
> +#define BCM2835_TS_TSENSCTL_REGULEN		BIT(26)
> +
> +#define BCM2835_TS_TSENSSTAT_DATA_BITS		10
> +#define BCM2835_TS_TSENSSTAT_DATA_SHIFT		0
> +#define BCM2835_TS_TSENSSTAT_DATA_MASK		     \
> +	GENMASK(BCM2835_TS_TSENSSTAT_DATA_BITS +     \
> +		BCM2835_TS_TSENSSTAT_DATA_SHIFT - 1, \
> +		BCM2835_TS_TSENSSTAT_DATA_SHIFT)

Optional: Just use GENMASK with the bit numbers and drop the BITS/SHIFT
definitions, since they aren't used.

> +#define BCM2835_TS_TSENSSTAT_VALID		BIT(10)
> +#define BCM2835_TS_TSENSSTAT_INTERRUPT		BIT(11)
> +
> +/* empirical linear approximation for conversion to temperature */
> +#define BCM2835_TS_VALUE_OFFSET			407000
> +#define BCM2835_TS_VALUE_SLOPE			-538

This matches for pi1/2.  However, apparently on Pi3 the sensor was
reporting low so the firmware adjusts the answer it up by 5C.  Not
required, but it would be nice to have a brcm,bcm2837-thermal compatible
string that increased the offset by 5C, so that we can enable this
driver right away for pi3.

> +struct bcm2835_thermal_data {
> +	void __iomem *regs;
> +	struct clk *clk;
> +	struct dentry *debugfsdir;
> +};
> +
> +static int bcm2835_thermal_get_temp(struct thermal_zone_device *tz,
> +				    int *temp)
> +{
> +	struct bcm2835_thermal_data *data = tz->devdata;
> +	u32 val = readl(data->regs + BCM2835_TS_TSENSSTAT);
> +
> +	/* mask the relevant bits */
> +	val &= BCM2835_TS_TSENSSTAT_DATA_MASK;
> +
> +	/* linear approximation */
> +	*temp = BCM2835_TS_VALUE_OFFSET +
> +		(val * BCM2835_TS_VALUE_SLOPE);
> +
> +	return 0;
> +}

You need to check if the VALID bit is set and do something appropriate
(I suspect just throw an error) if unset.

> +	/*
> +	 * for now we assume the firmware sets up the device,
> +	 * so we will not write to ctl, we just prepare the clock
> +	 */
> +	clk_prepare_enable(data->clk);

Optional setup: given the values you can read out of tsensctl set up by
the firmware currently, if at boot RSTB isn't set, then set the values
except for rstb in one writel, then OR in rstb in in the next writel.
Then the driver should be ready in case we ever get a firmware that does
less work.

Thanks for writing the driver!  With the bit definition fix and the
VALID check, I'll be ready to add a reviewed-by.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160512/8eb260e4/attachment-0001.sig>
