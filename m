From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 16 Jun 2016 15:56:31 +0100
Subject: [PATCH v2 3/5] regulator: rn5t618: add RN5T567 PMIC support
In-Reply-To: <20160608010429.19618-4-stefan@agner.ch>
References: <20160608010429.19618-1-stefan@agner.ch>
 <20160608010429.19618-4-stefan@agner.ch>
Message-ID: <20160616145631.GC4948@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 07 Jun 2016, Stefan Agner wrote:

> Extend the driver to support Ricoh RN5T567. Support the additional
> DCDC and slightly different voltage range of LDORTC1.
> 
> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/regulator/Kconfig             |  5 +++--
>  drivers/regulator/rn5t618-regulator.c | 40 +++++++++++++++++++++++++++++++----
>  include/linux/mfd/rn5t618.h           |  1 +
>  3 files changed, 40 insertions(+), 6 deletions(-)

For my own reference:
  Acked-by: Lee Jones <lee.jones@linaro.org>
  
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 144cbf5..5472694 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -636,10 +636,11 @@ config REGULATOR_RK808
>  	  outputs which can be controlled by i2c communication.
>  
>  config REGULATOR_RN5T618
> -	tristate "Ricoh RN5T618 voltage regulators"
> +	tristate "Ricoh RN5T567/618 voltage regulators"
>  	depends on MFD_RN5T618
>  	help
> -	  Say y here to support the regulators found on Ricoh RN5T618 PMIC.
> +	  Say y here to support the regulators found on Ricoh RN5T567 or
> +	  RN5T618 PMIC.
>  
>  config REGULATOR_RT5033
>  	tristate "Richtek RT5033 Regulators"
> diff --git a/drivers/regulator/rn5t618-regulator.c b/drivers/regulator/rn5t618-regulator.c
> index b85ceb8..9c930eb 100644
> --- a/drivers/regulator/rn5t618-regulator.c
> +++ b/drivers/regulator/rn5t618-regulator.c
> @@ -46,6 +46,23 @@ static struct regulator_ops rn5t618_reg_ops = {
>  		.vsel_mask	= (vmask),				\
>  	}
>  
> +static struct regulator_desc rn5t567_regulators[] = {
> +	/* DCDC */
> +	REG(DCDC1, DC1CTL, BIT(0), DC1DAC, 0xff, 600000, 3500000, 12500),
> +	REG(DCDC2, DC2CTL, BIT(0), DC2DAC, 0xff, 600000, 3500000, 12500),
> +	REG(DCDC3, DC3CTL, BIT(0), DC3DAC, 0xff, 600000, 3500000, 12500),
> +	REG(DCDC4, DC4CTL, BIT(0), DC4DAC, 0xff, 600000, 3500000, 12500),
> +	/* LDO */
> +	REG(LDO1, LDOEN1, BIT(0), LDO1DAC, 0x7f, 900000, 3500000, 25000),
> +	REG(LDO2, LDOEN1, BIT(1), LDO2DAC, 0x7f, 900000, 3500000, 25000),
> +	REG(LDO3, LDOEN1, BIT(2), LDO3DAC, 0x7f, 600000, 3500000, 25000),
> +	REG(LDO4, LDOEN1, BIT(3), LDO4DAC, 0x7f, 900000, 3500000, 25000),
> +	REG(LDO5, LDOEN1, BIT(4), LDO5DAC, 0x7f, 900000, 3500000, 25000),
> +	/* LDO RTC */
> +	REG(LDORTC1, LDOEN2, BIT(4), LDORTCDAC, 0x7f, 1200000, 3500000, 25000),
> +	REG(LDORTC2, LDOEN2, BIT(5), LDORTC2DAC, 0x7f, 900000, 3500000, 25000),
> +};
> +
>  static struct regulator_desc rn5t618_regulators[] = {
>  	/* DCDC */
>  	REG(DCDC1, DC1CTL, BIT(0), DC1DAC, 0xff, 600000, 3500000, 12500),
> @@ -67,18 +84,33 @@ static int rn5t618_regulator_probe(struct platform_device *pdev)
>  	struct rn5t618 *rn5t618 = dev_get_drvdata(pdev->dev.parent);
>  	struct regulator_config config = { };
>  	struct regulator_dev *rdev;
> +	struct regulator_desc *regulators;
>  	int i;
>  
> +	switch (rn5t618->variant) {
> +	case RN5T567:
> +		regulators = rn5t567_regulators;
> +		break;
> +	case RN5T618:
> +		regulators = rn5t618_regulators;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	config.dev = pdev->dev.parent;
> +	config.regmap = rn5t618->regmap;
> +
>  	for (i = 0; i < RN5T618_REG_NUM; i++) {
> -		config.dev = pdev->dev.parent;
> -		config.regmap = rn5t618->regmap;
> +		if (!regulators[i].name)
> +			continue;
>  
>  		rdev = devm_regulator_register(&pdev->dev,
> -					       &rn5t618_regulators[i],
> +					       &regulators[i],
>  					       &config);
>  		if (IS_ERR(rdev)) {
>  			dev_err(&pdev->dev, "failed to register %s regulator\n",
> -				rn5t618_regulators[i].name);
> +				regulators[i].name);
>  			return PTR_ERR(rdev);
>  		}
>  	}
> diff --git a/include/linux/mfd/rn5t618.h b/include/linux/mfd/rn5t618.h
> index 54179c2..cadc654 100644
> --- a/include/linux/mfd/rn5t618.h
> +++ b/include/linux/mfd/rn5t618.h
> @@ -217,6 +217,7 @@ enum {
>  	RN5T618_DCDC1,
>  	RN5T618_DCDC2,
>  	RN5T618_DCDC3,
> +	RN5T618_DCDC4,
>  	RN5T618_LDO1,
>  	RN5T618_LDO2,
>  	RN5T618_LDO3,

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
