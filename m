From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 16 Jan 2012 19:19:07 +0000
Subject: [PATCH] mx53_loco: add DA9053 PMIC support
In-Reply-To: <1326733853-13956-2-git-send-email-paul.liu@linaro.org>
References: <1326733853-13956-1-git-send-email-paul.liu@linaro.org>
 <1326733853-13956-2-git-send-email-paul.liu@linaro.org>
Message-ID: <20120116191907.GB23228@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2012 at 01:10:53AM +0800, Ying-Chun Liu (PaulLiu) wrote:

> +#define DA9052_LDO1_VOLT_UPPER			1800
> +#define DA9052_LDO1_VOLT_LOWER			600
> +#define DA9052_LDO1_VOLT_STEP			50

This is almost certainly wrong - you should rarely if ever need the
voltage step in a consumer or machine driver.  

> +#define DA9052_LDO(max, min, rname, suspend_mv) \
> +{\
> +	.constraints = {\
> +		.name		= (rname), \
> +		.max_uV		= (max) * 1000,\
> +		.min_uV		= (min) * 1000,\
> +		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE\
> +		|REGULATOR_CHANGE_STATUS | REGULATOR_CHANGE_MODE,\
> +		.valid_modes_mask = REGULATOR_MODE_NORMAL,\

This looks *very* odd - apart from anything else you're setting
REGULATOR_CHANGE_MODE but only permitting one mode.  You're also
allowing things to be changed but not providing any consumers which
means nothing can ever change any of them.

It looks awfully like you've just copied the supported feature set of
the PMIC rather than configured things for your board.

> +static struct regulator_init_data da9052_regulators_init[] = {
> +	/* BUCKS */
> +	DA9052_LDO(DA9052_BUCK_CORE_PRO_VOLT_UPPER,
> +		   DA9052_BUCK_CORE_PRO_VOLT_LOWER, "DA9052_BUCK_CORE", 850),

If you're going to specify names they should be names which are
meaningful for your board - usually the name used to identify the
relevant rail or rails in the schematic.

> +#define MX53_LOCO_DA9052_IRQ			(6*32 + 11)	/* GPIO7_11 */
> +
> +static int __init loco_da9052_init(struct da9052 *da9052)
> +{
> +	/* Configuring for DA9052 interrupt servce */
> +	/* s3c_gpio_setpull(DA9052_IRQ_PIN, S3C_GPIO_PULL_UP); */
> +

I apprecate that my code can be inspirational at times but you probably
don't want to cut'n'paste this bit.  :)

> +	/* Set interrupt as LOW LEVEL interrupt source */
> +	irq_set_irq_type(gpio_to_irq(MX53_LOCO_DA9052_IRQ),
> +			 IRQF_TRIGGER_LOW);

Why is this needed?  The PMIC driver should do the right thing when it
requests the interrupt...

> @@ -273,6 +397,10 @@ static struct i2c_board_info mx53loco_i2c_devices[] = {
>  	{
>  		I2C_BOARD_INFO("mma8450", 0x1C),
>  	},
> +	{
> +		I2C_BOARD_INFO("da9053-aa", 0x90 >> 1),
> +		.platform_data = &da9052_plat,
> +	},

You're mixing different ways of numbering I2C devices here.
