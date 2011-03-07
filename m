From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 07 Mar 2011 11:20:29 +0100
Subject: [PATCHv2 2/4] mach-mx31_3ds: Add support for the MMC slot of
	the personality board
In-Reply-To: <1299492694.2468.32.camel@realization>
References: <1299492598.2468.30.camel@realization>
	<1299492694.2468.32.camel@realization>
Message-ID: <4D74B16D.4080904@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/2011 11:11 AM, Alberto Panizzo wrote:
> 
> 
> Signed-off-by: Alberto Panizzo <alberto@amarulasolutions.com>
> ---
>  arch/arm/mach-mx3/mach-mx31_3ds.c |   99 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 99 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
> index f1dbb9d..cff9206 100644
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
> @@ -99,6 +100,85 @@ static int mx31_3ds_pins[] = {
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
> +#define MX31_3DS_GPIO_SDHC1_CD IOMUX_TO_GPIO(MX31_PIN_GPIO3_1)
> +#define MX31_3DS_GPIO_SDHC1_BE IOMUX_TO_GPIO(MX31_PIN_GPIO3_0)
> +
> +static struct gpio mx31_3ds_sdhc1_gpios[] = {
> +	{ MX31_3DS_GPIO_SDHC1_CD, GPIOF_IN, "sdhc1-card-detect" },
> +	{ MX31_3DS_GPIO_SDHC1_BE, GPIOF_OUT_INIT_LOW, "sdhc1-bus-en" },
> +};
> +
> +static int mx31_3ds_sdhc1_init(struct device *dev,
> +			       irq_handler_t detect_irq,
> +			       void *data)
> +{
> +	int ret;
> +
> +	ret = gpio_request_array(mx31_3ds_sdhc1_gpios,
> +				 ARRAY_SIZE(mx31_3ds_sdhc1_gpios));
> +	if (ret) {
> +		pr_warning("Unable to request the SD/MMC GPIOs.\n");
> +		return ret;
> +	}
> +
> +	ret = request_irq(IOMUX_TO_IRQ(MX31_PIN_GPIO3_1),
> +			  detect_irq, IRQF_DISABLED |
> +			  IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
> +			  "sdhc1-detect", data);
> +	if (ret) {
> +		pr_warning("Unable to request the SD/MMC card-detect IRQ.\n");
> +		goto gpio_free;
> +	}
> +
> +	return 0;
> +
> +gpio_free:
> +	gpio_free_array(mx31_3ds_sdhc1_gpios,
> +			ARRAY_SIZE(mx31_3ds_sdhc1_gpios));
> +	return ret;
> +}
> +
> +static void mx31_3ds_sdhc1_exit(struct device *dev, void *data)
> +{
> +	free_irq(IOMUX_TO_IRQ(MX31_PIN_GPIO3_1), data);
> +	gpio_free_array(mx31_3ds_sdhc1_gpios,
> +			 ARRAY_SIZE(mx31_3ds_sdhc1_gpios));
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

If you write this, you can remove the comment...

	if (vdd > ilog2(MMC_VDD_165_195))

> +		gpio_set_value(MX31_3DS_GPIO_SDHC1_BE, 1);
> +	else
> +		gpio_set_value(MX31_3DS_GPIO_SDHC1_BE, 0);
> +}
> +
> +static struct imxmmc_platform_data sdhc1_pdata = {
> +	.init		= mx31_3ds_sdhc1_init,
> +	.exit		= mx31_3ds_sdhc1_exit,
> +	.setpower	= mx31_3ds_sdhc1_setpower,
>  };
>  
>  /*
> @@ -137,6 +217,21 @@ static struct regulator_init_data gpo_init = {
>  	}
>  };
>  
> +static struct regulator_consumer_supply vmmc2_consumers[] = {
> +	REGULATOR_SUPPLY("vmmc", "mxc-mmc.0"),
> +};
> +
> +static struct regulator_init_data vmmc2_init = {
> +	.constraints = {
> +		.min_uV = 3000000,
> +		.max_uV = 3000000,
> +		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
> +				  REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies = ARRAY_SIZE(vmmc2_consumers),
> +	.consumer_supplies = vmmc2_consumers,
> +};
> +
>  static struct mc13xxx_regulator_init_data mx31_3ds_regulators[] = {
>  	{
>  		.id = MC13783_REG_PWGT1SPI, /* Power Gate for ARM core. */
> @@ -151,6 +246,9 @@ static struct mc13xxx_regulator_init_data mx31_3ds_regulators[] = {
>  	}, {
>  		.id = MC13783_REG_GPO3, /* Turn on 3.3V */
>  		.init_data = &gpo_init,
> +	}, {
> +		.id = MC13783_REG_VMMC2, /* Power MMC/SD, WiFi/Bluetooth. */
> +		.init_data = &vmmc2_init,
>  	},
>  };
>  
> @@ -362,6 +460,7 @@ static void __init mx31_3ds_init(void)
>  				    "devices on the debug board are unusable.\n");
>  	imx31_add_imx2_wdt(NULL);
>  	imx31_add_imx_i2c0(&mx31_3ds_i2c0_data);
> +	imx31_add_mxc_mmc(0, &sdhc1_pdata);
>  }
>  
>  static void __init mx31_3ds_timer_init(void)


-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110307/6bb0164f/attachment-0001.sig>
