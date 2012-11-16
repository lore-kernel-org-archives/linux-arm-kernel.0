From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 16 Nov 2012 20:16:07 +0100
Subject: [PATCH 1/2] pwm: lpc32xx - Add a driver for the motor PWM
In-Reply-To: <1352897985-15419-2-git-send-email-alban.bedel@avionic-design.de>
References: <1352897985-15419-1-git-send-email-alban.bedel@avionic-design.de>
 <1352897985-15419-2-git-send-email-alban.bedel@avionic-design.de>
Message-ID: <20121116191606.GA21566@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 01:59:44PM +0100, Alban Bedel wrote:
> Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>

Hi Alban,

This looks good. There could be some more informative commit message,
maybe something similar to what the DT binding has in the first
paragraph.

I have some other comments inline below.

> ---
>  .../devicetree/bindings/pwm/lpc32xx-motor-pwm.txt  |   24 +++
>  drivers/pwm/Kconfig                                |   10 +
>  drivers/pwm/Makefile                               |    1 +
>  drivers/pwm/pwm-lpc32xx-motor.c                    |  209 ++++++++++++++++++++
>  4 files changed, 244 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/lpc32xx-motor-pwm.txt
>  create mode 100644 drivers/pwm/pwm-lpc32xx-motor.c
> 
> diff --git a/Documentation/devicetree/bindings/pwm/lpc32xx-motor-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc32xx-motor-pwm.txt
> new file mode 100644
> index 0000000..e19b0a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/lpc32xx-motor-pwm.txt
> @@ -0,0 +1,24 @@
> +LPC32XX Motor PWM controller
> +
> +The LPC32xx motor PWMs have two output pin, A and B, with B=!A.

You use two different spellings: LPC32XX and LPC32xx. Can we settle on
one, please? Also "two output pins".

> +Per default the output A should be used, if the output B is used the

"By default, output A..."

> +PWM polarity should be inverted using the linux,polarity property.
> +
> +Required properties:
> +- compatible: should be "nxp,lpc3220-motor-pwm"
> +- reg: physical base address and length of the controller's registers
> +
> +Optional properites:
> +- linux,polarity: Bit mask of the polarity to use for each output,
> +      a bit set to 0 indicate the default polarity, a bit set to 1
> +      indicate an inverted polarity. In other word this set if output
> +      A or output B has the correct polarity.

Maybe this should state explicitly which bits are used for which
outputs.

> +
> +Examples:
> +
> +mpwm at 400e8000 {
> +	compatible = "nxp,lpc3220-motor-pwm";
> +	reg = <0x400E8000 0x78>;
> +	linux,polarity = 5; /* Use outputs B0, A1 and B2 */

Also since this is a bitmask it could make more sense to write it in
hexadecimal. And you may want to add <> around for consistency.

> +	#pwm-cells = <2>;
> +};
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 90c5c73..90fc167 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -57,6 +57,16 @@ config PWM_LPC32XX
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-lpc32xx.
>  
> +config PWM_LPC32XX_MOTOR
> +	tristate "LPC32XX Motor PWM support"

Again the different spelling.

> +	depends on ARCH_LPC32XX
> +	help
> +	  Generic PWM framework driver for LPC32XX motor PWM. The LPC32XX SOC

LPC32XX seems to be your preferred spelling.

> +	  has one motor PWM controllers.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-motor-lpc32xx.

According to the Makefile, the module will be called pwm-lpc32xx-motor.

> +
>  config PWM_MXS
>  	tristate "Freescale MXS PWM support"
>  	depends on ARCH_MXS && OF
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index e4b2c89..510bad8 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -2,6 +2,7 @@ obj-$(CONFIG_PWM)		+= core.o
>  obj-$(CONFIG_PWM_BFIN)		+= pwm-bfin.o
>  obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o
>  obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
> +obj-$(CONFIG_PWM_LPC32XX_MOTOR)	+= pwm-lpc32xx-motor.o
>  obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
>  obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
> diff --git a/drivers/pwm/pwm-lpc32xx-motor.c b/drivers/pwm/pwm-lpc32xx-motor.c
[...]
> +#define to_lpc32xx_motor_pwm_chip(_chip) \
> +	container_of(_chip, struct lpc32xx_motor_pwm_chip, chip)

That's an awfully long name for this macro. Maybe something like
to_motor_pwm_chip() would be long enough already.

> +#define PWM_EN_MASK(pwm)		BIT(0 + (pwm)->hwpwm*8)
> +#define MCLIM_REG_OFFSET(pwm)		(LPC32XX_MCPWM_MCLIM0 + (pwm)->hwpwm*4)
> +#define MCMAT_REG_OFFSET(pwm)		(LPC32XX_MCPWM_MCMAT0 + (pwm)->hwpwm*4)

CodingStyle mandates that you put spaces around binary operators.

> +
> +static int lpc32xx_motor_pwm_config(struct pwm_chip *chip,
> +				    struct pwm_device *pwm,
> +				    int duty_ns, int period_ns)
> +{
> +	struct lpc32xx_motor_pwm_chip *lpc32xx =
> +		to_lpc32xx_motor_pwm_chip(chip);

If you make the macro name shorter this will actually fit on one line.
=)

> +	u64 rate, per, duty;

Maybe rename per to period to make it explicit.

> +static int lpc32xx_motor_pwm_probe(struct platform_device *pdev)
[...]
> +	/* Configure the pins polarity */
> +	ret = of_property_read_u32(pdev->dev.of_node, "linux,polarity",
> +				   &lpc32xx->pins);
> +	if (!ret) {
> +		u32 set = 0, clr = 0;
> +		int i;

This could use a blank line for readability.

> +		for (i = 0 ; i < LPC32XX_MCPWM_COUNT ; i += 1)

Can we make that i++?

> +			if (lpc32xx->pins & BIT(i))
> +				set |= BIT(2 + i*8);

Spaces around '*'.

> +			else
> +				clr |= BIT(2 + i*8);

And another blank line.

> +		ret = clk_enable(lpc32xx->clk);
> +		if (ret)
> +			return ret;

And here.

> +static int __devexit lpc32xx_motor_pwm_remove(struct platform_device *pdev)

__devexit is now officially obsolete.

> +{
> +	struct lpc32xx_motor_pwm_chip *lpc32xx = platform_get_drvdata(pdev);
> +	int i;
> +
> +	for (i = 0 ; i < lpc32xx->chip.npwm ; i += 1)

Again, i++.

> +		pwm_disable(&lpc32xx->chip.pwms[i]);
> +
> +	return pwmchip_remove(&lpc32xx->chip);
> +}
> +
> +static const struct of_device_id lpc32xx_motor_pwm_dt_ids[] __devinitconst = {

__devinitconst is equally obsolete.

> +	{ .compatible = "nxp,lpc3220-motor-pwm", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, lpc32xx_motor_pwm_dt_ids);
> +
> +static struct platform_driver lpc32xx_motor_pwm_driver = {
> +	.driver = {
> +		.name = "lpc32xx-motor-pwm",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(lpc32xx_motor_pwm_dt_ids),
> +	},
> +	.probe = lpc32xx_motor_pwm_probe,
> +	.remove = __devexit_p(lpc32xx_motor_pwm_remove),

__devexit_p as well.

> +};
> +module_platform_driver(lpc32xx_motor_pwm_driver);
> +
> +MODULE_ALIAS("platform:lpc32xx-motor-pwm");
> +MODULE_AUTHOR("Alban Bedel <alban.bedel@avionic-design.de>");
> +MODULE_DESCRIPTION("LPC32XX Motor PWM Driver");

And the spelling again.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/7d21b78d/attachment.sig>
