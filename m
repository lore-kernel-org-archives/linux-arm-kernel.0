From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 30 Jun 2014 15:23:04 -0600
Subject: [PATCH 6/6] thermal: Add Tegra SOCTHERM thermal management driver
In-Reply-To: <1403856699-2140-7-git-send-email-mperttunen@nvidia.com>
References: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com>
 <1403856699-2140-7-git-send-email-mperttunen@nvidia.com>
Message-ID: <53B1D538.6000704@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 02:11 AM, Mikko Perttunen wrote:
> This adds support for the Tegra SOCTHERM thermal sensing and management
> system found in the Tegra124 system-on-chip. This initial driver supports
> the four thermal zones with hardware-tracked trip points.

> diff --git a/drivers/thermal/tegra_soctherm.c b/drivers/thermal/tegra_soctherm.c

> +static struct tegra_tsensor t124_tsensors[] = {
> +	{
> +		.base = 0xc0,
> +		.name = "cpu0",
> +		.config = &t124_tsensor_config,
> +		.calib_fuse_offset = 0x098,
> +		.fuse_corr_alpha = 1135400,
> +		.fuse_corr_beta = -6266900,
> +	},

I wonder why some of those fields are named "fuse_xxx" when the values
are hard-coded in these tables rather than read from fuses? These values
don't seem to be used to adjust values read from fuses.

> +static int tegra_thermctl_get_temp(void *data, long *out_temp)

> +	switch (zone->sensor) {
> +	case 0:
> +		val = readl(zone->tegra->regs + SENSOR_TEMP1)
> +			>> SENSOR_TEMP1_CPU_TEMP_SHIFT;

Can't the register offset and shift be stored in *zone, so that this
whole switch can be replaced with something generic:

val = readl(zone->tegra->regs + zone->reg_offset) >> zone->value_shift;

> +static int tegra_soctherm_probe(struct platform_device *pdev)

> +	irq = platform_get_irq(pdev, 0);
> +	if (irq <= 0) {
> +		dev_err(&pdev->dev, "can't get interrupt\n");
> +		return -EINVAL;
> +	}

irq is assigned once here ... (see later)

> +	for (i = 0; i < 4; ++i) {

Why "4"? Should the loop count be the ARRAY_SIZE(some array)? At the
very least, a named constant that describes the value would be useful...

> +		err = devm_request_threaded_irq(&pdev->dev, irq, soctherm_isr,
> +						soctherm_isr_thread,
> +						IRQF_SHARED, "tegra_soctherm",
> +						zone);

Why request the same IRQ 4 times here. Rather, shouldn't the IRQ be
requested once, and the ISR simply loop over the status register (or
whatever there are 4 of)?
