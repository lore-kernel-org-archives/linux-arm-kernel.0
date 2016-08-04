From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Aug 2016 21:26:46 +0100
Subject: [PATCH 2/2] regmap: debugfs: Add support for dumping write only
 device registers
In-Reply-To: <1470322558-7501-3-git-send-email-cristian.birsan@microchip.com>
References: <1470322558-7501-1-git-send-email-cristian.birsan@microchip.com>
 <1470322558-7501-3-git-send-email-cristian.birsan@microchip.com>
Message-ID: <20160804202646.GH10383@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 05:55:58PM +0300, Cristian Birsan wrote:
> Add support for dumping write only device registers in debugfs. This is
> useful for audio codecs that have write only registers (like WM8731).
> The logic that decides if a value can be printed is moved to
> regmap_printable() function to allow for easier future updates.

Please check your CC list when sending things upstream - try to ensure
that people you're sending patches to are relevant to the patch.
Maintainers often get lots of mail and having to sort out mail that's
not really relevant to them can make it easier for relevant mail to get
missed.

> +static bool regmap_printable(struct regmap *map, unsigned int reg)
> +{
> +	if (regmap_precious(map, reg))
> +		return false;
> +
> +	if (!regmap_readable(map, reg) && !regmap_cached(map, reg))
> +		return false;
> +
> +	return true;
> +}

This only has one user...

>  	for (i = start_reg; i <= to; i += map->reg_stride) {
> -		if (!regmap_readable(map, i))
> +		if (!regmap_readable(map, i) && !regmap_cached(map, i))
>  			continue;
>  

...though it could have more.

> -			ret = regmap_read(map, i, &val);
> +			if (regmap_readable(map, i))
> +				ret = regmap_read(map, i, &val);
> +			else
> +				ret = regcache_read(map, i, &val);
> +

I don't understand this change, a read will go to cache anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160804/d65aa7b6/attachment.sig>
