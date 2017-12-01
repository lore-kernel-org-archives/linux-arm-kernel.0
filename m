From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 1 Dec 2017 16:57:02 +0100
Subject: [PATCH v4 02/10] pinctrl: axp209: add pinctrl features
In-Reply-To: <71c9da94df2a5938cb8c092e40f8e36eec0b01c3.1512135804.git-series.quentin.schulz@free-electrons.com>
References: <cover.3ff63fdf302c6bda02ea7d160ad2aa5afee0899d.1512135804.git-series.quentin.schulz@free-electrons.com>
 <71c9da94df2a5938cb8c092e40f8e36eec0b01c3.1512135804.git-series.quentin.schulz@free-electrons.com>
Message-ID: <20171201155702.irfox7vf3kfjvpjx@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 02:44:43PM +0100, Quentin Schulz wrote:
> +static void axp20x_gpio_set(struct gpio_chip *chip, unsigned offset,
> +			    int value)
> +{

checkpatch output:
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

> +static int axp20x_pmx_set_mux(struct pinctrl_dev *pctldev,
> +			      unsigned int function, unsigned int group)
> +{
> +	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
> +	unsigned int mask;
> +
> +	/* Every pin supports GPIO_OUT and GPIO_IN functions */
> +	if (function <= AXP20X_FUNC_GPIO_IN)
> +		return axp20x_pmx_set(pctldev, group,
> +				      gpio->funcs[function].muxval);
> +
> +	if (function == AXP20X_FUNC_LDO)
> +		mask = gpio->desc->ldo_mask;
> +	else
> +		mask = gpio->desc->adc_mask;

What is the point of this test...

> +	if (!(BIT(group) & mask))
> +		return -EINVAL;
> +
> +	/*
> +	 * We let the regulator framework handle the LDO muxing as muxing bits
> +	 * are basically also regulators on/off bits. It's better not to enforce
> +	 * any state of the regulator when selecting LDO mux so that we don't
> +	 * interfere with the regulator driver.
> +	 */
> +	if (function == AXP20X_FUNC_LDO)
> +		return 0;

... if you know that you're not going to do anything with one of the
outcomes. It would be better to just move that part above, instead of
doing the same test twice.

It looks good otherwise, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171201/13676615/attachment-0001.sig>
