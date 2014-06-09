From: broonie@kernel.org (Mark Brown)
Date: Mon, 9 Jun 2014 20:47:13 +0100
Subject: [PATCH 1/5] mfd: Add driver for Maxim 77802 Power Management IC
In-Reply-To: <1402306670-17041-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1402306670-17041-1-git-send-email-javier.martinez@collabora.co.uk>
 <1402306670-17041-2-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140609194713.GF5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 09, 2014 at 11:37:46AM +0200, Javier Martinez Canillas wrote:

> +Optional node:
> +- voltage-regulators : The regulators of max77802 have to be instantiated
> +  under subnode named "voltage-regulators" using the following format.

Every other PMIC calls this node regulators...

> +	regulator_name {
> +		regulator-compatible = LDOn/BUCKn

regulator-compatible is deprecated, use the node name instead.

> +config MFD_MAX77802
> +	bool "Maxim Integrated MAX77802 PMIC Support"

Why is this bool and not tristate?

> +int max77802_irq_resume(struct max77802_dev *max77802)
> +{
> +	/*
> +	 * The IRQ that woke us up may still need to be ACK'ed on resume.
> +	 * If it isn't ever ACK'ed, future IRQs may not be delivered.
> +	 */
> +	if (max77802->irq)
> +		max77802_irq_thread(0, max77802);
> +
> +	return 0;
> +}

As covered in another subthread all this code looks like it should be
regmap-irq.

> +	if (regmap_read(max77802->regmap,
> +			 MAX77802_REG_DEVICE_ID, &data) < 0) {
> +		dev_err(max77802->dev,
> +			"device not found on this channel (this is not an error)\n");
> +		return -ENODEV;

If this is not an error why is it printed as dev_err()?  It does look
like an error to me, though.

> +	} else {
> +		dev_info(max77802->dev, "device found\n");
> +	}

These sort of prints are just noise, remove this unless there is some
revision information you can display.  It's also better practice to
check that the device ID is actually what was expected in case there was
an error in the DT.

> +static const struct i2c_device_id max77802_i2c_id[] = {
> +	{ "max77802", TYPE_MAX77802 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max77802_i2c_id);

We have type information here but not in the OF ID table (not that we
ever look at it).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140609/4eb88b9b/attachment-0001.sig>
