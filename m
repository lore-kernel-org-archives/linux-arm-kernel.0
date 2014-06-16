From: broonie@kernel.org (Mark Brown)
Date: Mon, 16 Jun 2014 20:25:00 +0100
Subject: [PATCH v2 07/10] regulator: Add driver for Maxim 77802 PMIC
 regulators
In-Reply-To: <1402941758-11216-8-git-send-email-javier.martinez@collabora.co.uk>
References: <1402941758-11216-1-git-send-email-javier.martinez@collabora.co.uk>
 <1402941758-11216-8-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140616192500.GJ5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 08:02:35PM +0200, Javier Martinez Canillas wrote:

> --- a/drivers/mfd/max77802.c
> +++ b/drivers/mfd/max77802.c
> @@ -37,6 +37,7 @@
>  #include <linux/err.h>
>  
>  static const struct mfd_cell max77802_devs[] = {
> +	{ .name = "max77802-pmic", },
>  };
>  
>  static bool max77802_pmic_is_accessible_reg(struct device *dev,

Please don't do things like this, it makes it harder to apply your
series.  Just register all the devices in the MFD when you add the MFD
driver.

> +	default:
> +		pr_warn("%s: regulator_suspend_mode : 0x%x not supported\n",
> +			rdev->desc->name, mode);
> +		return -EINVAL;

dev_warn().

> +static void max77802_copy_reg(struct device *dev, struct regmap *regmap,
> +			      int from_reg, int to_reg)
> +{
> +	int val;
> +	int ret;
> +
> +	if (from_reg == to_reg)
> +		return;
> +
> +	ret = regmap_read(regmap, from_reg, &val);
> +	if (!ret)
> +		ret = regmap_write(regmap, to_reg, val);
> +
> +	if (ret)
> +		dev_warn(dev, "Copy err %d => %d (%d)\n",
> +			 from_reg, to_reg, ret);
> +}

Again, this looks like it should be generic.

> +static int max77802_pmic_probe(struct platform_device *pdev)
> +{

> +	dev_dbg(&pdev->dev, "%s\n", __func__);

This isn't adding anything, just remove it - the core already logs
probes if you want.

> +	config.dev = &pdev->dev;

Are you sure this shouldn't be the MFD?

> +	for (i = 0; i < MAX77802_MAX_REGULATORS; i++) {
> +		struct regulator_dev *rdev;
> +		int id = pdata->regulators[i].id;
> +
> +		config.init_data = pdata->regulators[i].initdata;
> +		config.of_node = pdata->regulators[i].of_node;
> +
> +		max77802->opmode[id] = MAX77802_OPMODE_NORMAL;

Why isn't this being read from the hardware, this may lead to a
configuration change the first time we pay attention?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140616/4cc76c61/attachment.sig>
