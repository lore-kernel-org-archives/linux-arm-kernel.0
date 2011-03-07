From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 7 Mar 2011 09:27:21 +0100
Subject: [PATCH 2/4] mach-mx31_3ds: Add support for the MMC slot of the
	personality board
In-Reply-To: <1299426001.2624.31.camel@realization>
References: <1299425878.2624.29.camel@realization>
	<1299426001.2624.31.camel@realization>
Message-ID: <20110307082721.GK29521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 06, 2011 at 04:40:01PM +0100, Alberto Panizzo wrote:
> 
> 
> Signed-off-by: Alberto Panizzo <alberto@amarulasolutions.com>
> ---
>  arch/arm/mach-mx3/mach-mx31_3ds.c |  116 ++++++++++++++++++++++++++++++++++++-
>  1 files changed, 114 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
> index f1dbb9d..cd73513 100644
> --- a/arch/arm/mach-mx3/mach-mx31_3ds.c
> +++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
> @@ -35,6 +35,7 @@
>  #include <mach/iomux-mx3.h>
>  #include <mach/3ds_debugboard.h>
>  #include <mach/ulpi.h>
> +#include <mach/mmc.h>
>  
>  #include "devices-imx31.h"
>  #include "devices.h"
> @@ -99,6 +100,98 @@ static int mx31_3ds_pins[] = {
>  	/* I2C1 */
>  	MX31_PIN_I2C_CLK__I2C1_SCL,
>  	MX31_PIN_I2C_DAT__I2C1_SDA,
> +	/* SDHC1 */
> +	MX31_PIN_SD1_DATA3__SD1_DATA3,
> +	MX31_PIN_SD1_DATA2__SD1_DATA2,
> +	MX31_PIN_SD1_DATA1__SD1_DATA1,
> +	MX31_PIN_SD1_DATA0__SD1_DATA0,
> +	MX31_PIN_SD1_CLK__SD1_CLK,
> +	MX31_PIN_SD1_CMD__SD1_CMD,
> +	MX31_PIN_GPIO3_1__GPIO3_1, /* Card detect */
> +	MX31_PIN_GPIO3_0__GPIO3_0, /* OE */
> +};
> +
> +/*
> + * Support for SD card slot in personality board
> + */
> +static int mx31_3ds_sdhc1_init(struct device *dev, irq_handler_t detect_irq,
> +			       void *data)
> +{
> +	int ret;
> +	int gpio_det, gpio_bus_en;
> +
> +	gpio_det = IOMUX_TO_GPIO(MX31_PIN_GPIO3_1);
> +	gpio_bus_en = IOMUX_TO_GPIO(MX31_PIN_GPIO3_0);
> +
> +	ret = gpio_request(gpio_det, "sdhc1-card-detect");
> +	if (ret) {
> +		pr_warning("Unable to request the SD/MMC card-detect GPIO.\n");
> +		return ret;
> +	}
> +
> +	ret = gpio_request(gpio_bus_en, "sdhc1-bus-enable");
> +	if (ret) {
> +		pr_warning("Unable to request the SD/MMC bus enable GPIO.\n");
> +		goto gpio_free_be;
> +	}
> +
> +	ret = gpio_direction_input(gpio_det);
> +	if (ret) {
> +		pr_warning("Unable to manage the SD/MMC card-detect GPIO.\n");
> +		goto gpio_free_all;
> +	}
> +
> +	ret = gpio_direction_output(gpio_bus_en, 0);
> +	if (ret) {
> +		pr_warning("Unable to manage the SD/MMC bus enable GPIO.\n");
> +		goto gpio_free_all;
> +	}

Wolfram just arrived, so I probably have some moments left before he
says it: You should use gpio_request_array here.

> +
> +	ret = request_irq(IOMUX_TO_IRQ(MX31_PIN_GPIO3_1),
> +			  detect_irq, IRQF_DISABLED |
> +			  IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
> +			  "sdhc1-detect", data);
> +	if (ret) {
> +		pr_warning("Unable to request the SD/MMC card-detect IRQ.\n");
> +		goto gpio_free_all;
> +	}
> +
> +	return 0;
> +
> +gpio_free_all:
> +	gpio_free(gpio_bus_en);
> +gpio_free_be:
> +	gpio_free(gpio_det);
> +	return ret;
> +}
> +
> +static void mx31_3ds_sdhc1_exit(struct device *dev, void *data)
> +{
> +	free_irq(IOMUX_TO_IRQ(MX31_PIN_GPIO3_1), data);
> +	gpio_free(IOMUX_TO_GPIO(MX31_PIN_GPIO3_1));
> +	gpio_free(IOMUX_TO_GPIO(MX31_PIN_GPIO3_0));
> +}
> +
> +static void mx31_3ds_sdhc1_setpower(struct device *dev, unsigned int vdd)
> +{
> +	/*
> +	 * While the voltage stuff is done by the driver, activate the
> +	 * Buffer Enable Pin only if there is a card in slot to fix the card
> +	 * voltage issue caused by bi-directional chip TXB0108 on 3Stack.
> +	 * Done here because at this stage we have for sure a debounced value
> +	 * of the presence of the card, showed by the value of vdd.
> +	 * 7 == ilog2(MMC_VDD_165_195)
> +	 */
> +	if (vdd > 7)
> +		gpio_set_value(IOMUX_TO_GPIO(MX31_PIN_GPIO3_0), 1);
> +	else
> +		gpio_set_value(IOMUX_TO_GPIO(MX31_PIN_GPIO3_0), 0);
> +}
> +
> +static struct imxmmc_platform_data sdhc1_pdata = {
> +	.init	= mx31_3ds_sdhc1_init,
> +	.exit	= mx31_3ds_sdhc1_exit,
> +	.setpower = mx31_3ds_sdhc1_setpower,
>  };
>  
>  /*
> @@ -132,11 +225,26 @@ static struct regulator_init_data pwgtx_init = {
>  
>  static struct regulator_init_data gpo_init = {
>  	.constraints = {
> -		.boot_on = 1,
> -		.always_on = 1,
> +		.boot_on	= 1,
> +		.always_on	= 1,
>  	}
>  };


Please just keep it as it is. Some people like the initializers
vertically aligned, others prefer spaces here. But if someone made
a decision, don't change it to increase the chance that git blame
shows something useful.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
