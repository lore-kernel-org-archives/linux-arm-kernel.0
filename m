From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Jun 2015 11:11:56 +0100
Subject: [PATCH 1/3] mfd: ax20x: Add axp152 support
In-Reply-To: <1435088503-20776-2-git-send-email-hdegoede@redhat.com>
References: <1435088503-20776-1-git-send-email-hdegoede@redhat.com>
 <1435088503-20776-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150625095031.GA15013@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Jun 2015, Hans de Goede wrote:

> From: Michal Suchanek <hramrach@gmail.com>
> 
> The axp152 is a stripped down version of the axp202 pmic with the battery
> charging function removed as it is intended for top-set boxes.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt |  4 +-

This should be in a separate patch.

>  drivers/mfd/axp20x.c                             | 92 ++++++++++++++++++++++++
>  include/linux/mfd/axp20x.h                       | 61 +++++++++++++++-
>  3 files changed, 155 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index 753f14f..4181122 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -1,12 +1,14 @@
>  AXP family PMIC device tree bindings
>  
>  The axp20x family current members :
> +axp152 (X-Powers)
>  axp202 (X-Powers)
>  axp209 (X-Powers)
>  axp221 (X-Powers)
>  
>  Required properties:
> -- compatible: "x-powers,axp202", "x-powers,axp209", "x-powers,axp221"
> +- compatible: "x-powers,axp152", "x-powers,axp202", "x-powers,axp209",
> +	      "x-powers,axp221"
>  - reg: The I2C slave address for the AXP chip
>  - interrupt-parent: The parent interrupt controller
>  - interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin

For this patch, when it is separated out:
  Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index ca4a604..49bba28 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -30,12 +30,34 @@
>  #define AXP20X_OFF	0x80
>  
>  static const char * const axp20x_model_names[] = {
> +	"AXP152",
>  	"AXP202",
>  	"AXP209",
>  	"AXP221",
>  	"AXP288",
>  };
>  
> +static const struct regmap_range axp152_writeable_ranges[] = {
> +	regmap_reg_range(AXP152_LDO3456_DC1234_CTRL, AXP152_IRQ3_STATE),
> +	regmap_reg_range(AXP152_DCDC_MODE, AXP152_PWM1_DUTY_CYCLE),
> +};
> +
> +static const struct regmap_range axp152_volatile_ranges[] = {
> +	regmap_reg_range(AXP152_PWR_OP_MODE, AXP152_PWR_OP_MODE),
> +	regmap_reg_range(AXP152_IRQ1_EN, AXP152_IRQ3_STATE),
> +	regmap_reg_range(AXP152_GPIO_INPUT, AXP152_GPIO_INPUT),
> +};
> +
> +static const struct regmap_access_table axp152_writeable_table = {
> +	.yes_ranges	= axp152_writeable_ranges,
> +	.n_yes_ranges	= ARRAY_SIZE(axp152_writeable_ranges),
> +};
> +
> +static const struct regmap_access_table axp152_volatile_table = {
> +	.yes_ranges	= axp152_volatile_ranges,
> +	.n_yes_ranges	= ARRAY_SIZE(axp152_volatile_ranges),
> +};
> +
>  static const struct regmap_range axp20x_writeable_ranges[] = {
>  	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
>  	regmap_reg_range(AXP20X_DCDC_MODE, AXP20X_FG_RES),
> @@ -99,6 +121,20 @@ static const struct regmap_access_table axp288_volatile_table = {
>  	.n_yes_ranges	= ARRAY_SIZE(axp288_volatile_ranges),
>  };
>  
> +static struct resource axp152_pek_resources[] = {
> +	{
> +		.name	= "PEK_DBR",
> +		.start	= AXP152_IRQ_PEK_RIS_EDGE,
> +		.end	= AXP152_IRQ_PEK_RIS_EDGE,
> +		.flags	= IORESOURCE_IRQ,
> +	}, {
> +		.name	= "PEK_DBF",
> +		.start	= AXP152_IRQ_PEK_FAL_EDGE,
> +		.end	= AXP152_IRQ_PEK_FAL_EDGE,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};

DEFINE_RES_*()

After you've fixed this up, please add my:

 Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
