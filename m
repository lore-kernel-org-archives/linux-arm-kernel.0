From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 Apr 2016 09:24:09 +0100
Subject: [PATCH resend v2 3/9] mfd: axp20x: Add support for AXP809 PMIC
In-Reply-To: <1459243352-23344-4-git-send-email-wens@csie.org>
References: <1459243352-23344-1-git-send-email-wens@csie.org>
 <1459243352-23344-4-git-send-email-wens@csie.org>
Message-ID: <20160411082409.GG4592@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Mar 2016, Chen-Yu Tsai wrote:

> The X-Powers AXP809 is a new PMIC that is paired with Allwinner's A80
> SoC, along with a slave AXP806 PMIC.
> 
> This PMIC is quite similar to the earlier AXP223, though the interrupts
> and regulator have changed a bit.
> 
> This patch adds support for the interrupts and power button of the PMIC.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mfd/axp20x-rsb.c   |  1 +
>  drivers/mfd/axp20x.c       | 79 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/axp20x.h | 59 ++++++++++++++++++++++++++++++++++
>  3 files changed, 139 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/axp20x-rsb.c b/drivers/mfd/axp20x-rsb.c
> index 28c20247c112..a407527bcd09 100644
> --- a/drivers/mfd/axp20x-rsb.c
> +++ b/drivers/mfd/axp20x-rsb.c
> @@ -61,6 +61,7 @@ static int axp20x_rsb_remove(struct sunxi_rsb_device *rdev)
>  
>  static const struct of_device_id axp20x_rsb_of_match[] = {
>  	{ .compatible = "x-powers,axp223", .data = (void *)AXP223_ID },
> +	{ .compatible = "x-powers,axp809", .data = (void *)AXP809_ID },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, axp20x_rsb_of_match);
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index a57d6e940610..1ce923277cc8 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -37,6 +37,7 @@ static const char * const axp20x_model_names[] = {
>  	"AXP221",
>  	"AXP223",
>  	"AXP288",
> +	"AXP809",
>  };
>  
>  static const struct regmap_range axp152_writeable_ranges[] = {
> @@ -85,6 +86,7 @@ static const struct regmap_access_table axp20x_volatile_table = {
>  	.n_yes_ranges	= ARRAY_SIZE(axp20x_volatile_ranges),
>  };
>  
> +/* AXP22x ranges are shared with the AXP809, as they cover the same range */
>  static const struct regmap_range axp22x_writeable_ranges[] = {
>  	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
>  	regmap_reg_range(AXP20X_DCDC_MODE, AXP22X_BATLOW_THRES1),
> @@ -211,6 +213,20 @@ static struct resource axp288_fuel_gauge_resources[] = {
>  	},
>  };
>  
> +static struct resource axp809_pek_resources[] = {
> +	{
> +		.name   = "PEK_DBR",
> +		.start  = AXP809_IRQ_PEK_RIS_EDGE,
> +		.end    = AXP809_IRQ_PEK_RIS_EDGE,
> +		.flags  = IORESOURCE_IRQ,
> +	}, {
> +		.name   = "PEK_DBF",
> +		.start  = AXP809_IRQ_PEK_FAL_EDGE,
> +		.end    = AXP809_IRQ_PEK_FAL_EDGE,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +};
> +
>  static const struct regmap_config axp152_regmap_config = {
>  	.reg_bits	= 8,
>  	.val_bits	= 8,
> @@ -378,6 +394,41 @@ static const struct regmap_irq axp288_regmap_irqs[] = {
>  	INIT_REGMAP_IRQ(AXP288, BC_USB_CHNG,            5, 1),
>  };
>  
> +static const struct regmap_irq axp809_regmap_irqs[] = {
> +	INIT_REGMAP_IRQ(AXP809, ACIN_OVER_V,		0, 7),
> +	INIT_REGMAP_IRQ(AXP809, ACIN_PLUGIN,		0, 6),
> +	INIT_REGMAP_IRQ(AXP809, ACIN_REMOVAL,	        0, 5),
> +	INIT_REGMAP_IRQ(AXP809, VBUS_OVER_V,		0, 4),
> +	INIT_REGMAP_IRQ(AXP809, VBUS_PLUGIN,		0, 3),
> +	INIT_REGMAP_IRQ(AXP809, VBUS_REMOVAL,	        0, 2),
> +	INIT_REGMAP_IRQ(AXP809, VBUS_V_LOW,		0, 1),
> +	INIT_REGMAP_IRQ(AXP809, BATT_PLUGIN,		1, 7),
> +	INIT_REGMAP_IRQ(AXP809, BATT_REMOVAL,	        1, 6),
> +	INIT_REGMAP_IRQ(AXP809, BATT_ENT_ACT_MODE,	1, 5),
> +	INIT_REGMAP_IRQ(AXP809, BATT_EXIT_ACT_MODE,	1, 4),
> +	INIT_REGMAP_IRQ(AXP809, CHARG,		        1, 3),
> +	INIT_REGMAP_IRQ(AXP809, CHARG_DONE,		1, 2),
> +	INIT_REGMAP_IRQ(AXP809, BATT_CHG_TEMP_HIGH,	2, 7),
> +	INIT_REGMAP_IRQ(AXP809, BATT_CHG_TEMP_HIGH_END,	2, 6),
> +	INIT_REGMAP_IRQ(AXP809, BATT_CHG_TEMP_LOW,	2, 5),
> +	INIT_REGMAP_IRQ(AXP809, BATT_CHG_TEMP_LOW_END,	2, 4),
> +	INIT_REGMAP_IRQ(AXP809, BATT_ACT_TEMP_HIGH,	2, 3),
> +	INIT_REGMAP_IRQ(AXP809, BATT_ACT_TEMP_HIGH_END,	2, 2),
> +	INIT_REGMAP_IRQ(AXP809, BATT_ACT_TEMP_LOW,	2, 1),
> +	INIT_REGMAP_IRQ(AXP809, BATT_ACT_TEMP_LOW_END,	2, 0),
> +	INIT_REGMAP_IRQ(AXP809, DIE_TEMP_HIGH,	        3, 7),
> +	INIT_REGMAP_IRQ(AXP809, LOW_PWR_LVL1,	        3, 1),
> +	INIT_REGMAP_IRQ(AXP809, LOW_PWR_LVL2,	        3, 0),
> +	INIT_REGMAP_IRQ(AXP809, TIMER,		        4, 7),
> +	INIT_REGMAP_IRQ(AXP809, PEK_RIS_EDGE,	        4, 6),
> +	INIT_REGMAP_IRQ(AXP809, PEK_FAL_EDGE,	        4, 5),
> +	INIT_REGMAP_IRQ(AXP809, PEK_SHORT,		4, 4),
> +	INIT_REGMAP_IRQ(AXP809, PEK_LONG,		4, 3),
> +	INIT_REGMAP_IRQ(AXP809, PEK_OVER_OFF,		4, 2),
> +	INIT_REGMAP_IRQ(AXP809, GPIO1_INPUT,		4, 1),
> +	INIT_REGMAP_IRQ(AXP809, GPIO0_INPUT,		4, 0),
> +};
> +
>  static const struct regmap_irq_chip axp152_regmap_irq_chip = {
>  	.name			= "axp152_irq_chip",
>  	.status_base		= AXP152_IRQ1_STATE,
> @@ -428,6 +479,18 @@ static const struct regmap_irq_chip axp288_regmap_irq_chip = {
>  
>  };
>  
> +static const struct regmap_irq_chip axp809_regmap_irq_chip = {
> +	.name			= "axp809",
> +	.status_base		= AXP20X_IRQ1_STATE,
> +	.ack_base		= AXP20X_IRQ1_STATE,
> +	.mask_base		= AXP20X_IRQ1_EN,
> +	.mask_invert		= true,
> +	.init_ack_masked	= true,
> +	.irqs			= axp809_regmap_irqs,
> +	.num_irqs		= ARRAY_SIZE(axp809_regmap_irqs),
> +	.num_regs		= 5,
> +};
> +
>  static struct mfd_cell axp20x_cells[] = {
>  	{
>  		.name		= "axp20x-pek",
> @@ -572,6 +635,16 @@ static struct mfd_cell axp288_cells[] = {
>  	},
>  };
>  
> +static struct mfd_cell axp809_cells[] = {
> +	{
> +		.name			= "axp20x-pek",
> +		.num_resources		= ARRAY_SIZE(axp809_pek_resources),
> +		.resources		= axp809_pek_resources,
> +	}, {
> +		.name			= "axp20x-regulator",
> +	},
> +};
> +
>  static struct axp20x_dev *axp20x_pm_power_off;
>  static void axp20x_power_off(void)
>  {
> @@ -631,6 +704,12 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
>  		axp20x->regmap_cfg = &axp288_regmap_config;
>  		axp20x->regmap_irq_chip = &axp288_regmap_irq_chip;
>  		break;
> +	case AXP809_ID:
> +		axp20x->nr_cells = ARRAY_SIZE(axp809_cells);
> +		axp20x->cells = axp809_cells;
> +		axp20x->regmap_cfg = &axp22x_regmap_config;
> +		axp20x->regmap_irq_chip = &axp809_regmap_irq_chip;
> +		break;
>  	default:
>  		dev_err(dev, "unsupported AXP20X ID %lu\n", axp20x->variant);
>  		return -EINVAL;
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index d82e7d51372b..0be4982f08fe 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -20,6 +20,7 @@ enum {
>  	AXP221_ID,
>  	AXP223_ID,
>  	AXP288_ID,
> +	AXP809_ID,
>  	NR_AXP20X_VARIANTS,
>  };
>  
> @@ -264,6 +265,29 @@ enum {
>  	AXP22X_REG_ID_MAX,
>  };
>  
> +enum {
> +	AXP809_DCDC1 = 0,
> +	AXP809_DCDC2,
> +	AXP809_DCDC3,
> +	AXP809_DCDC4,
> +	AXP809_DCDC5,
> +	AXP809_DC1SW,
> +	AXP809_DC5LDO,
> +	AXP809_ALDO1,
> +	AXP809_ALDO2,
> +	AXP809_ALDO3,
> +	AXP809_ELDO1,
> +	AXP809_ELDO2,
> +	AXP809_ELDO3,
> +	AXP809_DLDO1,
> +	AXP809_DLDO2,
> +	AXP809_RTC_LDO,
> +	AXP809_LDO_IO0,
> +	AXP809_LDO_IO1,
> +	AXP809_SW,
> +	AXP809_REG_ID_MAX,
> +};
> +
>  /* IRQs */
>  enum {
>  	AXP152_IRQ_LDO0IN_CONNECT = 1,
> @@ -390,6 +414,41 @@ enum axp288_irqs {
>  	AXP288_IRQ_BC_USB_CHNG,
>  };
>  
> +enum axp809_irqs {
> +	AXP809_IRQ_ACIN_OVER_V = 1,
> +	AXP809_IRQ_ACIN_PLUGIN,
> +	AXP809_IRQ_ACIN_REMOVAL,
> +	AXP809_IRQ_VBUS_OVER_V,
> +	AXP809_IRQ_VBUS_PLUGIN,
> +	AXP809_IRQ_VBUS_REMOVAL,
> +	AXP809_IRQ_VBUS_V_LOW,
> +	AXP809_IRQ_BATT_PLUGIN,
> +	AXP809_IRQ_BATT_REMOVAL,
> +	AXP809_IRQ_BATT_ENT_ACT_MODE,
> +	AXP809_IRQ_BATT_EXIT_ACT_MODE,
> +	AXP809_IRQ_CHARG,
> +	AXP809_IRQ_CHARG_DONE,
> +	AXP809_IRQ_BATT_CHG_TEMP_HIGH,
> +	AXP809_IRQ_BATT_CHG_TEMP_HIGH_END,
> +	AXP809_IRQ_BATT_CHG_TEMP_LOW,
> +	AXP809_IRQ_BATT_CHG_TEMP_LOW_END,
> +	AXP809_IRQ_BATT_ACT_TEMP_HIGH,
> +	AXP809_IRQ_BATT_ACT_TEMP_HIGH_END,
> +	AXP809_IRQ_BATT_ACT_TEMP_LOW,
> +	AXP809_IRQ_BATT_ACT_TEMP_LOW_END,
> +	AXP809_IRQ_DIE_TEMP_HIGH,
> +	AXP809_IRQ_LOW_PWR_LVL1,
> +	AXP809_IRQ_LOW_PWR_LVL2,
> +	AXP809_IRQ_TIMER,
> +	AXP809_IRQ_PEK_RIS_EDGE,
> +	AXP809_IRQ_PEK_FAL_EDGE,
> +	AXP809_IRQ_PEK_SHORT,
> +	AXP809_IRQ_PEK_LONG,
> +	AXP809_IRQ_PEK_OVER_OFF,
> +	AXP809_IRQ_GPIO1_INPUT,
> +	AXP809_IRQ_GPIO0_INPUT,
> +};
> +
>  #define AXP288_TS_ADC_H		0x58
>  #define AXP288_TS_ADC_L		0x59
>  #define AXP288_GP_ADC_H		0x5a

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
