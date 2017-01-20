From: edubezval@gmail.com (Eduardo Valentin)
Date: Thu, 19 Jan 2017 20:14:02 -0800
Subject: [PATCH V9] thermal: bcm2835: add thermal driver for bcm2835 soc
In-Reply-To: <1483808145-6206-1-git-send-email-kernel@martin.sperl.org>
References: <1483808145-6206-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <20170120041400.GA24617@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Martin,

On Sat, Jan 07, 2017 at 04:55:45PM +0000, kernel at martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Add basic thermal driver for bcm2835 SOC.
> 
> This driver currently relies on the firmware setting up the
> tsense HW block and does not set it up itself.
> 
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> Acked-by: Eric Anholt <eric@anholt.net>
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> 

<cut>

> +
> +static const struct of_device_id bcm2835_thermal_of_match_table[] = {
> +	{
> +		.compatible = "brcm,bcm2835-thermal",
> +		.data = &(struct bcm2835_thermal_info) {
> +			.offset = 407000,
> +			.slope = -538,
> +			.trip_temp = 80000
> +		}
> +	},
> +	{
> +		.compatible = "brcm,bcm2836-thermal",
> +		.data = &(struct bcm2835_thermal_info) {
> +			.offset = 407000,
> +			.slope = -538,
> +			.trip_temp = 80000
> +		}
> +	},
> +	{
> +		.compatible = "brcm,bcm2837-thermal",
> +		.data = &(struct bcm2835_thermal_info) {
> +			/* the bcm2837 needs adjustment of +5C */
> +			.offset = 407000 + 5000,
> +			.slope = -538,
> +			.trip_temp = 80000
> +		}
> +	},
> +	{},

Just for the same of clarification, is there anything preventing this
driver of using of-thermal API? the above data (slope, offset, and
trip_temps) would be in DT the place where they are supposed to be,
instead of code.

> +};
> +MODULE_DEVICE_TABLE(of, bcm2835_thermal_of_match_table);
> +
> +static struct platform_driver bcm2835_thermal_driver = {
> +	.probe = bcm2835_thermal_probe,
> +	.remove = bcm2835_thermal_remove,
> +	.driver = {
> +		.name = "bcm2835_thermal",
> +		.of_match_table = bcm2835_thermal_of_match_table,
> +	},
> +};
> +module_platform_driver(bcm2835_thermal_driver);
> +
> +MODULE_AUTHOR("Martin Sperl");
> +MODULE_DESCRIPTION("Thermal driver for bcm2835 chip");
> +MODULE_LICENSE("GPL");
> --
> 2.1.4
