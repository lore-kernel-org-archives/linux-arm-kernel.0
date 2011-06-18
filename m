From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 18 Jun 2011 16:12:27 +0100
Subject: [PATCH 1/2] Exynos4 NURI: configure regulators and PMIC
In-Reply-To: <1308215372-17420-1-git-send-email-myungjoo.ham@samsung.com>
References: <1308215372-17420-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <20110618151227.GB25163@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2011 at 06:09:31PM +0900, MyungJoo Ham wrote:

>  static struct regulator_init_data emmc_fixed_voltage_init_data = {
>  	.constraints		= {
> +		.min_uV		= 2800000,
> +		.max_uV		= 2800000,
>  		.name		= "VMEM_VDD_2.8V",
>  		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,

Since the regualtor can't change voltage specifying the voltage here
isn't going to achieve anything - to get the voltage reported through
get_voltage() you need to put the voltage in the platform data for the
fixed regulator.

> +static struct regulator_consumer_supply nuri_max8997_ldo1_consumer[] = {
> +	REGULATOR_SUPPLY("vadc", NULL), /* Used by CPU's ADC drv */
> +};

In the ADC regulator patch you called the supply vdd (though the chip
normally calls it vadc so that's the better name)...

Extra ' too.

> +static struct regulator_consumer_supply nuri_max8997_ldo8_consumer[] = {
> +	REGULATOR_SUPPLY("vusb_d", NULL), /* Used by CPU */
> +	REGULATOR_SUPPLY("vdac", NULL), /* Used by CPU */
> +};

Another VADC?  For a different supply?

> +		.state_mem	= {
> +			.enabled	= 0,

No need to initialize to zero.

> +static struct regulator_init_data nuri_max8997_ldo10_data = {
> +	.constraints	= {

You should be able to use __initdata for a lot of this by the way.

> +#define NURI_PMIC_GPIO		EXYNOS4_GPX0(7)
> +static void __init nuri_pmic_init(void)
> +{
> +	int gpio;
> +
> +	nuri_max8997_pdata.irq_base = irq_get_next_irq(IRQ_GPIO_END);
> +	gpio = NURI_PMIC_GPIO;
> +	gpio_request(gpio, "AP_PMIC_IRQ");
> +	s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0xf));
> +	s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> +}

I'm not sure both the #define and the variable make sense here...
