From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 2 Feb 2012 12:52:50 +0000
Subject: [RFC 7/7] MFD: TWL6040: Add regulator support for VIO, V2V1
 supplies
In-Reply-To: <1328185019-29575-8-git-send-email-peter.ujfalusi@ti.com>
References: <1328185019-29575-1-git-send-email-peter.ujfalusi@ti.com>
 <1328185019-29575-8-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120202125250.GJ7428@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 02:16:59PM +0200, Peter Ujfalusi wrote:

> +	twl6040->vio = regulator_get(&client->dev, "vio");
> +	if (IS_ERR(twl6040->vio)) {
> +		ret = PTR_ERR(twl6040->vio);
> +		dev_err(&client->dev, "Failed to request VIO supply: %d\n",
> +			ret);
> +		goto regulator_get_err;
> +	}
> +	twl6040->v2v1 = regulator_get(&client->dev, "v2v1");
> +	if (IS_ERR(twl6040->v2v1)) {
> +		ret = PTR_ERR(twl6040->v2v1);
> +		dev_err(&client->dev, "Failed to request V2V1 supply: %d\n",
> +			ret);
> +		regulator_put(twl6040->vio);
> +		goto regulator_get_err;
> +	}

Looks like you want regulator_bulk_get() here.  Or (better yet though
it'd be a potential issue for merge via MFD and the benefits aren't that
exciting since you still need to disable) devm_regulator_bulk_get().

> +	ret = regulator_enable(twl6040->vio);
> +	if (ret != 0) {
> +		dev_err(&client->dev, "Failed to enable VIO: %d\n", ret);
> +		goto power_err;
> +	}
> +	ret = regulator_enable(twl6040->v2v1);
> +	if (ret != 0) {
> +		dev_err(&client->dev, "Failed to enable V2V1: %d\n", ret);
> +		regulator_disable(twl6040->vio);
> +		goto power_err;
> +	}

Similarly regulator_bulk_enable() here, and it'll fix...

>  gpio1_err:
> +	regulator_disable(twl6040->v2v1);
> +	regulator_disable(twl6040->vio);

...the fact that if you fail to enable the v2.1 regulator you don't
disable vio.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120202/42b9ecc2/attachment.sig>
