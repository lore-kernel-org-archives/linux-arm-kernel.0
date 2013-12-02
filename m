From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 2 Dec 2013 10:36:23 +0100
Subject: [PATCH v2 2/3] regulator: tps6586x: add and use correct voltage
 table
In-Reply-To: <77c960e6e3a91cf39bc866ccb9cd578ccc5acc95.1385913228.git.stefan@agner.ch>
References: <cover.1385913227.git.stefan@agner.ch>
 <77c960e6e3a91cf39bc866ccb9cd578ccc5acc95.1385913228.git.stefan@agner.ch>
Message-ID: <20131202093622.GF17834@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 01, 2013 at 04:59:14PM +0100, Stefan Agner wrote:
[...]

This looks pretty good generally. A few minor nits below...

> diff --git a/drivers/regulator/tps6586x-regulator.c b/drivers/regulator/tps6586x-regulator.c
[...]
> +#define tps658623_sm2_voltages tps6586x_ldo4_voltages
>  static const unsigned int tps6586x_ldo4_voltages[] = {
>  	1700000, 1725000, 1750000, 1775000, 1800000, 1825000, 1850000, 1875000,
>  	1900000, 1925000, 1950000, 1975000, 2000000, 2025000, 2050000, 2075000,

I'd put the #define below the ldo4 table. This doesn't actually matter
for the preprocessor, but it makes it easier to read the code. Also an
additional blank line would help with readability.

> +	TPS6586X_LDO(LDO_0, "vinldo01", tps6586x_ldo0, SUPPLYV1, 5, 3, ENC, 0,
> +					END, 0),

Perhaps reduce the indentation here so there's more room in case this
ever needs to be extended?

> @@ -351,6 +380,7 @@ static int tps6586x_regulator_probe(struct platform_device *pdev)
>  	struct regulator_init_data *reg_data;
>  	struct tps6586x_platform_data *pdata;
>  	struct of_regulator_match *tps6586x_reg_matches = NULL;
> +	int reg_version;

Why the prefix "reg_"?

> @@ -373,10 +403,27 @@ static int tps6586x_regulator_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> +	reg_version = tps6586x_get_version(pdev->dev.parent);
> +
>  	for (id = 0; id < TPS6586X_ID_MAX_REGULATOR; ++id) {
>  		reg_data = pdata->reg_init_data[id];
>  
> -		ri = find_regulator_info(id);
> +		switch(reg_version) {
> +		case TPS658623:
> +			ri = find_regulator_info(id, tps658623_regulator,
> +					ARRAY_SIZE(tps658623_regulator));
> +			break;
> +		case TPS658643:
> +			ri = find_regulator_info(id, tps658643_regulator,
> +					ARRAY_SIZE(tps658643_regulator));
> +			break;
> +		}

Perhaps instead of repeating the function calls this could be:

		switch (version) {
		case TPS6586XYZ:
			num = ARRAY_SIZE(tps6586xyz_regulator);
			table = tps6586xys_regulator;
			break;

		...
		}

		if (table)
			ri = find_regulator_info(id, table, num);

That's slightly longer, but I find that to be more intuitive. Perhaps
a bit more future-proof since you only have a single call. But that's
perhaps subjective, so I'm fine with your alternative, too.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131202/cd4a8799/attachment.sig>
