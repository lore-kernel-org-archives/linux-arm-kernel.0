From: broonie@kernel.org (Mark Brown)
Date: Thu, 8 Aug 2013 12:01:36 +0100
Subject: [PATCH v2 1/3] hwmon: (lm90) Add power control
In-Reply-To: <1375944991-29182-2-git-send-email-wni@nvidia.com>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1375944991-29182-2-git-send-email-wni@nvidia.com>
Message-ID: <20130808110136.GA6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 02:56:29PM +0800, Wei Ni wrote:

> +	mutex_lock(&data->update_lock);
> +
> +	if (is_enable)
> +		ret = regulator_enable(data->lm90_reg);
> +	else
> +		ret = regulator_disable(data->lm90_reg);
> +
> +	if (ret < 0)
> +		dev_err(&client->dev,
> +			"Error in %s rail vdd, error %d\n",
> +			(is_enable) ? "enabling" : "disabling", ret);
> +	else
> +		dev_info(&client->dev, "success in %s rail vdd\n",
> +			 (is_enable) ? "enabling" : "disabling");
> +
> +	mutex_unlock(&data->update_lock);

Two things here.  One is that it's not clear what this lokc is
protecting since the only thing in the locked region is the regulator
operation and that is thread safe.  The other thing is that I'm not
seeing anthing that ensures that enables and disables are matched -
regulators are reference counted so two enables need two disables.

> +	data->lm90_reg = regulator_get(&client->dev, "vdd");
> +	if (IS_ERR_OR_NULL(data->lm90_reg)) {

NULL is a valid regulator, use IS_ERR().

> +		if (PTR_ERR(data->lm90_reg) == -ENODEV)
> +			dev_info(&client->dev,
> +				 "No regulator found for vdd. Assuming vdd is always powered.");
> +		else
> +			dev_warn(&client->dev,
> +				 "Error [%ld] in getting the regulator handle for vdd.\n",
> +				 PTR_ERR(data->lm90_reg));

You shouldn't just be ignoring errors here, though there are deployment
difficulties with making sure a stub regulator is provided.  These
should be getting easier after the next merge window, the stubs will be
being tweaked slightly to have an "assume it's there" option even when
regulators are used.  Especially in cases with device tree you should be
paying attention to -EPROBE_DEFER, that will accurately reflect if a
regulator is present but not loaded yet.

That said if you *are* going to do this you should request the
regulator using devm_regulator_get_optional(), this is intended to
support things that don't need regulators (though that's not the case
here).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130808/243e1ee6/attachment.sig>
