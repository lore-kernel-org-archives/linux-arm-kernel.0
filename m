From: broonie@kernel.org (Mark Brown)
Date: Thu, 24 Jul 2014 18:39:26 +0100
Subject: [PATCH RFC 2/2] regulator: twl: Re-add clk32kg to get wifi working
In-Reply-To: <53D12044.1060500@kpanic.de>
References: <1405338655-18415-1-git-send-email-sassmann@kpanic.de>
 <1405338655-18415-3-git-send-email-sassmann@kpanic.de>
 <20140714120051.GF6800@sirena.org.uk> <53C3C77F.7080208@kpanic.de>
 <20140714181338.GR6800@sirena.org.uk> <53C525A2.8080609@kpanic.de>
 <20140716212340.GZ17528@sirena.org.uk> <53D12044.1060500@kpanic.de>
Message-ID: <20140724173926.GK17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 05:03:32PM +0200, Stefan Assmann wrote:

> OK, here's a first attempt to add a clock driver for the twl6030. Let
> me know if this is going the right direction and I'll post a proper
> patchset.

Looks reasonable to me, though I'm not a clock expert.  Few comments...

> +static int of_twl6030_clk32kg_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}

Shouldn't need empty functions.

> -	ret = regmap_bulk_write(regmap, twl_priv->twl_map[mod_no].base + reg,
> -				value, num_bytes);
> -
> +	if (num_bytes == 1) {
> +		ret = regmap_write(regmap,
> +				   twl_priv->twl_map[mod_no].base + reg,
> +				   *value);
> +	} else {
> +		ret = regmap_bulk_write(regmap,
> +					twl_priv->twl_map[mod_no].base + reg,
> +					value, num_bytes);
> +	}

Just always use regmap_raw_write() - for single byte values there is no
difference anyway, bulk_write() only makes a difference if the values
are multi-byte.

> -	ret = regmap_bulk_read(regmap, twl_priv->twl_map[mod_no].base + reg,
> -			       value, num_bytes);
> -
> +	if (num_bytes == 1) {

Similarly here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140724/628077f5/attachment.sig>
