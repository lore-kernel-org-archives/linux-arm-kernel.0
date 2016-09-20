From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 20 Sep 2016 19:49:00 +0200 (CEST)
Subject: [PATCH V6 2/6] thermal: bcm2835: add thermal driver for bcm2835
 soc
In-Reply-To: <1474275600-19378-3-git-send-email-kernel@martin.sperl.org>
References: <1474275600-19378-1-git-send-email-kernel@martin.sperl.org>
 <1474275600-19378-3-git-send-email-kernel@martin.sperl.org>
Message-ID: <965620984.74888.75ab17c4-a160-4b45-ac45-90b43175f85a.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

> kernel at martin.sperl.org hat am 19. September 2016 um 10:59 geschrieben:
> 
> 
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Add basic thermal driver for bcm2835 SOC.
> 
> This driver currently relies on the firmware setting up the
> tsense HW block and does not set it up itself.
> 
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> Acked-by: Eric Anholt <eric@anholt.net>
> 
> ChangeLog:
>  V1 -> V2: added specific settings depending on compatiblity
> 	   added trip point based on register
> 	   setting up ctrl-register if HW is not enabled by firmware
> 	     as per recommendation of Eric (untested)
> 	   check that clock frequency is in range
> 	     (1.9 - 5MHz - as per comment in clk-bcm2835.c)
>  V2 -> V4: moved back to thermal (not using bcm sub-directory)
>        	   set polling interval to 1second (was 0ms, so interrupt driven)
>  V5 -> V6: added correct depends in KConfig
> 	   removed defined default for RESET_DELAY
> 	   removed obvious comments
> 	   clarify HW setup comments if not set up by FW already
> 	   move clk_prepare_enable to an earlier stage and add error handling
> 	   clarify warning when TS-clock runs out of recommended range
> 	   clk_disable_unprepare added in bcm2835_thermal_remove
> 	   added comment on recommended temperature ranges for SOC
> ---
>  drivers/thermal/Kconfig           |   8 +
>  drivers/thermal/Makefile          |   1 +
>  drivers/thermal/bcm2835_thermal.c | 340
> ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 349 insertions(+)
>  create mode 100644 drivers/thermal/bcm2835_thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 2d702ca..6489723 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -399,4 +399,12 @@ config GENERIC_ADC_THERMAL
>  	  to this driver. This driver reports the temperature by reading ADC
>  	  channel and converts it to temperature based on lookup table.
>  
> +config BCM2835_THERMAL
> +	tristate "Thermal sensors on bcm2835 SoC"
> +	depends on ARCH_BCM2835 || ARCH_BCM2836 || ARCH_BCM2837 || COMPILE_TEST

AFAIK there are no ARCH_BCM2836 or ARCH_BCM2837

After fixing that, you can add my ACK.

> +	depends on OF
> +	depends on HAS_IOMEM
> +	help
> +	  Support for thermal sensors on Broadcom bcm2835 SoCs.
> +
> ...
> +
> +static const struct of_device_id bcm2835_thermal_of_match_table[];
> +static int bcm2835_thermal_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match;
> +	struct thermal_zone_device *tz;
> +	struct bcm2835_thermal_data *data;
> +	struct resource *res;
> +	int err;
> +	u32 val;
> +	unsigned long rate;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	match = of_match_device(bcm2835_thermal_of_match_table,
> +				&pdev->dev);
> +	if (!match)
> +		return -EINVAL;
> +	data->info = match->data;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(data->regs)) {
> +		err = PTR_ERR(data->regs);
> +		dev_err(&pdev->dev, "Could not get registers: %d\n", err);
> +		return err;
> +	}
> +
> +	data->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(data->clk)) {
> +		err = PTR_ERR(data->clk);
> +		if (err != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Could not get clk: %d\n", err);
> +		return err;
> +	}
> +
> +	err = clk_prepare_enable(data->clk);
> +	if (err)
> +		return err;
> +
> +	rate = clk_get_rate(data->clk);
> +	if ((rate < 1920000) || (rate > 5000000))
> +		dev_warn(&pdev->dev,
> +			 "Clock %pCn running at %pCr Hz is outside of the recommended range: 1.92
> to 5MHz\n",
> +			 data->clk, data->clk);
> +
> +	/*
> +	 * right now the FW does set up the HW-block, so we are not
> +	 * touching the configuration registers.
> +	 * But if the HW is not enabled, then set it up
> +	 * using "sane" values used by the firmware right now.
> +	 */
> +	val = readl(data->regs + BCM2835_TS_TSENSCTL);
> +	if (!(val & BCM2835_TS_TSENSCTL_RSTB)) {
> +		/* the basic required flags */
> +		val = (BCM2835_TS_TSENSCTL_CTRL_DEFAULT <<
> +		       BCM2835_TS_TSENSCTL_CTRL_SHIFT) |
> +		      BCM2835_TS_TSENSCTL_REGULEN;
> +
> +		/*
> +		 * reset delay using the current firmware value of 14
> +		 * - units of time are unknown.
> +		 */

I've have open a thread in the Raspberry Pi Forum regards to this. If i get a
positive feedback then i will send an incremental patch.

Stefan

> +		val |= (14 << BCM2835_TS_TSENSCTL_RSTDELAY_SHIFT);
> +
> +		/*  trip_adc value from info */
> +		val |= bcm2835_thermal_temp2adc(data->info,
> +						data->info->trip_temp) <<
> +			BCM2835_TS_TSENSCTL_THOLD_SHIFT;
> +
> +		/* write the value back to the register as 2 steps */
> +		writel(val, data->regs + BCM2835_TS_TSENSCTL);
> +		val |= BCM2835_TS_TSENSCTL_RSTB;
> +		writel(val, data->regs + BCM2835_TS_TSENSCTL);
> +	}
> +
