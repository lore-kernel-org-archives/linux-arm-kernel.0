From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Dec 2013 16:24:52 +0000
Subject: [PATCH 1/2] regulator: tps65910: Add backup battery regulator
In-Reply-To: <1387378208-26841-1-git-send-email-mpa@pengutronix.de>
References: <1387378208-26841-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20131218162452.GX28455@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 03:50:07PM +0100, Markus Pargmann wrote:

> @@ -771,7 +794,7 @@ static struct regulator_ops tps65910_ops = {
>  	.get_voltage_sel	= tps65910_get_voltage_sel,
>  	.set_voltage_sel	= tps65910_set_voltage_sel,
>  	.list_voltage		= regulator_list_voltage_table,
> -	.map_voltage		= regulator_map_voltage_ascend,
> +	.map_voltage		= regulator_map_voltage_iterate,
>  };

You should make separate ops for this rather than make all the other
regulators take the performance hit.

>  static struct regulator_ops tps65911_ops = {
> @@ -944,6 +967,7 @@ static struct of_regulator_match tps65910_matches[] = {
>  	{ .name = "vaux2",	.driver_data = (void *) &tps65910_regs[10] },
>  	{ .name = "vaux33",	.driver_data = (void *) &tps65910_regs[11] },
>  	{ .name = "vmmc",	.driver_data = (void *) &tps65910_regs[12] },
> +	{ .name = "vbb",	.driver_data = (void *) &tps65910_regs[13] },
>  };

Ugh, these numbered tables aren't good.  Not a problem from this patch
though.

> -		pmic->desc[i].enable_mask = TPS65910_SUPPLY_STATE_ENABLED;
> +		if (tps65910_chip_id(tps65910) == TPS65910 &&
> +				i == TPS65910_REG_VBB)
> +			pmic->desc[i].enable_mask = BBCH_BBCHEN_MASK;
> +		else
> +			pmic->desc[i].enable_mask = TPS65910_SUPPLY_STATE_ENABLED;

switch statements please - it means if additional things need
customising they can drop right in.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131218/7e36be7e/attachment.sig>
