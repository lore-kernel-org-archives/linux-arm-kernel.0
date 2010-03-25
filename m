From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 25 Mar 2010 08:27:51 +0100
Subject: [PATCH 5/8] MXC: mach-mx31_3ds: Add support for SD card slot
	in the personality board.
In-Reply-To: <1269370438.3276.173.camel@realization>
References: <1269369741.3276.162.camel@realization>
	<1269370017.3276.165.camel@realization>
	<1269370175.3276.168.camel@realization>
	<1269370228.3276.169.camel@realization>
	<1269370305.3276.171.camel@realization>
	<1269370438.3276.173.camel@realization>
Message-ID: <20100325072751.GY2241@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 23, 2010 at 07:53:58PM +0100, Alberto Panizzo wrote:
> The lock detection goes through the pmic and need to be implemented.
> 
> Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
> ---
>  arch/arm/mach-mx3/mach-mx31_3ds.c |  164 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 164 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
> index f54af1e..51e060c 100644
> --- a/arch/arm/mach-mx3/mach-mx31_3ds.c
> +++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
> @@ -26,6 +26,9 @@
>  #include <linux/mfd/mc13783.h>
>  #include <linux/spi/spi.h>
>  #include <linux/regulator/machine.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/log2.h>
> +#include <linux/err.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> @@ -39,6 +42,7 @@
>  #include <mach/iomux-mx3.h>
>  #include <mach/mxc_nand.h>
>  #include <mach/spi.h>
> +#include <mach/mmc.h>
>  #include "devices.h"
>  
>  /*!
> @@ -65,6 +69,112 @@ static int mx31_3ds_pins[] = {
>  	MX31_PIN_CSPI2_SS2__SS2, /*CS for MC13783 */
>  	/* MC13783 IRQ */
>  	IOMUX_MODE(MX31_PIN_GPIO1_3, IOMUX_CONFIG_GPIO),
> +	/* SDHC1 */
> +	MX31_PIN_SD1_DATA3__SD1_DATA3,
> +	MX31_PIN_SD1_DATA2__SD1_DATA2,
> +	MX31_PIN_SD1_DATA1__SD1_DATA1,
> +	MX31_PIN_SD1_DATA0__SD1_DATA0,
> +	MX31_PIN_SD1_CLK__SD1_CLK,
> +	MX31_PIN_SD1_CMD__SD1_CMD,
> +	MX31_PIN_GPIO3_0__GPIO3_0, /*OE*/
> +};
> +
> +/*
> + * Support for SD card slot in personality board
> + */
> +static struct regulator *vmmc_reg;
> +
> +static int mx31_3ds_sd1_init(struct device *dev,
> +				   irq_handler_t detect_irq, void *data)
> +{
> +	int ret;
> +	int gpio_det, gpio_bus_en;
> +
> +	gpio_det = IOMUX_TO_GPIO(MX31_PIN_GPIO3_1);
> +	gpio_bus_en = IOMUX_TO_GPIO(MX31_PIN_GPIO3_0);
> +
> +	ret = gpio_request(gpio_det, "sd1-card-detect");
> +	if (ret) {
> +		pr_warning("Unable to request sd card detect gpio.\n");
> +		return ret;
> +	}
> +
> +	ret = gpio_request(gpio_bus_en, "sd1-bus-enable");
> +	if (ret) {
> +		pr_warning("Unable to request sd card bus enable gpio.\n");
> +		goto gpio_free;
> +	}
> +
> +	gpio_direction_input(gpio_det);
> +	ret = request_irq(IOMUX_TO_IRQ(MX31_PIN_GPIO3_1),
> +			  detect_irq, IRQF_DISABLED |
> +			  IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
> +			  "sd1-detect", data);
> +
> +	if (ret) {
> +		pr_warning("Unable to request sd card detect irq.\n");
> +		goto gpio_free_all;
> +	}
> +
> +	vmmc_reg = regulator_get(dev, "sd1_vdd");

I think the driver should handle the regulator stuff, not the platform.
drivers/mmc/host/pxamci.c looks like a good example.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
