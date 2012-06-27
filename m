From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 27 Jun 2012 15:48:49 +0200
Subject: [PATCH v6] ARM: imx: Add basic imx6q thermal driver
In-Reply-To: <1340772715-22117-2-git-send-email-rob.lee@linaro.org>
References: <1340772715-22117-1-git-send-email-rob.lee@linaro.org>
 <1340772715-22117-2-git-send-email-rob.lee@linaro.org>
Message-ID: <20120627134849.GN1623@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 11:51:55PM -0500, Robert Lee wrote:
> +static inline int anatop_get_temp(int *temp, struct thermal_zone_device *tzdev)
> +{
> +	unsigned int n_meas;
> +	unsigned int reg;
> +	struct imx_anatop_tsdata *sd;
> +
> +	sd = &((struct imx_anatop_thdata *)tzdev->devdata)->sensor_data;
> +
> +
> +	do {
> +		/*
> +		 * Every time we measure the temperature, we will power on the
> +		 * temperature sensor, enable measurements, take a reading,
> +		 * disable measurements, power off the temperature sensor.
> +		 */
> +		sd->handle_suspend = false;
> +
> +		anatop_write_reg(sd->anatopmfd, HW_ANADIG_TEMPSENSE0, 0,
> +			BM_ANADIG_TEMPSENSE0_POWER_DOWN);
> +		anatop_write_reg(sd->anatopmfd, HW_ANADIG_TEMPSENSE0,
> +			BM_ANADIG_TEMPSENSE0_MEASURE_TEMP,
> +			BM_ANADIG_TEMPSENSE0_MEASURE_TEMP);
> +		/*
> +		 * According to the anatop temp sensor designers, it may require
> +		 * up to ~17us to complete a measurement (imx6q).
> +		 * But this timing isn't checked on every part nor is it
> +		 * specified in the datasheet,	so sleeping at least 1ms should
> +		 * provide plenty of time.  Sleeping longer than 1ms is ok so no
> +		 * need for usleep_range */
> +		msleep(1);
> +
> +		reg = anatop_read_reg(sd->anatopmfd, HW_ANADIG_TEMPSENSE0);
> +
> +		anatop_write_reg(sd->anatopmfd, HW_ANADIG_TEMPSENSE0, 0,
> +			BM_ANADIG_TEMPSENSE0_MEASURE_TEMP);
> +		anatop_write_reg(sd->anatopmfd, HW_ANADIG_TEMPSENSE0,
> +			BM_ANADIG_TEMPSENSE0_POWER_DOWN,
> +			BM_ANADIG_TEMPSENSE0_POWER_DOWN);
> +
> +	/* if we had a suspend and resume event, we will re-take the reading */
> +	} while (sd->handle_suspend);

[...]

> +static int anatop_thermal_suspend(struct platform_device *pdev,
> +					pm_message_t state)
> +{
> +	struct imx_anatop_thdata *dd = platform_get_drvdata(pdev);
> +	struct imx_anatop_tsdata *sd = &dd->sensor_data;
> +
> +	/* power off the sensor during suspend */
> +	anatop_write_reg(sd->anatopmfd, HW_ANADIG_TEMPSENSE0, 0,
> +		BM_ANADIG_TEMPSENSE0_MEASURE_TEMP);
> +
> +	anatop_write_reg(sd->anatopmfd, HW_ANADIG_TEMPSENSE0,
> +		BM_ANADIG_TEMPSENSE0_POWER_DOWN,
> +		BM_ANADIG_TEMPSENSE0_POWER_DOWN);
> +	return 0;
> +}
> +
> +static int anatop_thermal_resume(struct platform_device *pdev)
> +{
> +	struct imx_anatop_thdata *dd = platform_get_drvdata(pdev);
> +	struct imx_anatop_tsdata *sd = &dd->sensor_data;
> +
> +	sd->handle_suspend = true;
> +	return 0;
> +}

I don't know how to handle this properly or if it's really needed, but
the usage of this handle_suspend variable really looks suspicious. I've
never seen a driver looping around a while-suspended-in-between. Someone
else should have a look over this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
