From: broonie@kernel.org (Mark Brown)
Date: Mon, 17 Nov 2014 23:40:12 +0000
Subject: [PATCH 3/7] regulator: MT6397: Add support for MT6397 regulator
In-Reply-To: <1416210027-5562-4-git-send-email-flora.fu@mediatek.com>
References: <1416210027-5562-1-git-send-email-flora.fu@mediatek.com>
 <1416210027-5562-4-git-send-email-flora.fu@mediatek.com>
Message-ID: <20141117234012.GE22111@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 03:40:23PM +0800, Flora Fu wrote:

This looks mostly good but there are a few fairly straightfoward things:

> @@ -725,5 +725,11 @@ config REGULATOR_WM8994
>  	  This driver provides support for the voltage regulators on the
>  	  WM8994 CODEC.
>  
> +config REGULATOR_MT6397
> +	tristate "MediaTek MT6397 PMIC"
> +	depends on MFD_MT6397
> +	help
> +	   This driver provides support for the voltage regulators on the MediaTek MT6397 PMIC.
> +
>  endif

Keep this and the Makefile sorted.

> +static int mt6397_buck_set_voltage_sel(struct regulator_dev *rdev, unsigned sel)
> +{


> +	vosel = info->buck_conf.vosel_reg;
> +	voselon = info->buck_conf.voselon_reg;
> +	vosel_mask = info->buck_conf.vosel_mask;

Please use the standard way of specifying data even if you can't use the
standard function.

> +
> +	ret = regmap_update_bits(rdev->regmap, vosel, vosel_mask, sel);
> +	if (ret != 0) {
> +		dev_err(&rdev->dev, "Failed to update vosel: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(rdev->regmap, voselon, vosel_mask, sel);
> +	if (ret != 0) {
> +		dev_err(&rdev->dev, "Failed to update vosel_on: %d\n", ret);
> +		return ret;
> +	}
> +	return 0;

You should add comments here explaining what's going on - it's very
strange to have to write the same value to two different registers and
the names of the registers look suspicously like this is something to do
with a suspend mode...

Missing blank line before the return too.

> +static int mt6397_buck_get_voltage_sel(struct regulator_dev *rdev)
> +{

You could use the regmap based helper for this.

> +static int mt6397_ldo_set_voltage_sel(struct regulator_dev *rdev, unsigned sel)
> +{

The LDO operations appear to be identical to the standard regmap
helpers, please use them.

> +	if (is_fixed)
> +		return 0;

You should use the standard fixed voltage regulator support rather than 

> +static int mt6397_regulator_is_enabled(struct regulator_dev *rdev)
> +{

Again this looks like it should be using helpers.

> +#define MT6397_REGULATOR_OF_MATCH(_name, _id)			\
> +[MT6397_ID_##_id] = {						\
> +	.name = #_name,						\
> +	.driver_data = &mt6397_regulators[MT6397_ID_##_id],	\
> +}

Define regulators_node and of_match in the regulator desc and you can
remove both this table and all your DT matching code in the driver, the
core will handle it for you.

> +	if ((reg_value & 0xFF) == MT6397_REGULATOR_ID91) {
> +		j = MT6397_ID_VCAMIO;
> +		mt6397_regulator_matches[j].init_data->constraints.min_uV =
> +		1000000;
> +		mt6397_regulators[j].desc.volt_table = ldo_volt_table5_v2;
> +	}

Use a switch statement, that way other variants can be added more
easily.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141117/852c230e/attachment.sig>
