From: broonie@kernel.org (Mark Brown)
Date: Mon, 27 Jun 2016 16:10:08 +0100
Subject: [PATCH v2 04/14] regulator: SY8106A regulator driver
In-Reply-To: <20160625034511.7966-5-megous@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-5-megous@megous.com>
Message-ID: <20160627151008.GZ28202@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 25, 2016 at 05:45:01AM +0200, megous at megous.com wrote:

> +	config.init_data = of_get_regulator_init_data(dev, dev->of_node, &sy8106a_reg);
> +	if (!config.init_data) {
> +		return -EINVAL;
> +	}

This is broken, constraints are entirely optional - the driver should
just instantiate no matter what (if anything) the constraints are.  This
means people can read the current state even if there is no need for
runtime configuration.

> +	dev_info(&i2c->dev, "SY8106A voltage at boot: %u mV\n", SY8106A_MIN_MV + 
> +		 SY8106A_STEP_MV * (selector & SY8106A_REG_VOUT1_SEL_MASK));

This is just noise, remove it - if we want to list the voltage for
regulators at probe we should be doing it consistently for all
regulators in the core rather than in individual drivers.

> +/*
> + * This is useless for OF-enabled devices, but it is needed by I2C subsystem
> + */
> +static const struct i2c_device_id sy8106a_i2c_id[] = {
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, sy8106a_i2c_id);

No, this is not the case - supporting DT does not mean that other
enumeration mechanisms can't be supported and there's no reason not to
list a sensible ID here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160627/1d409030/attachment.sig>
