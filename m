From: plaes@plaes.org (Priit Laes)
Date: Tue, 29 Mar 2016 12:51:30 +0300
Subject: [linux-sunxi] [PATCH resend v2 4/9] regulator: axp20x: support
 AXP809 variant
In-Reply-To: <1459243352-23344-5-git-send-email-wens@csie.org>
References: <1459243352-23344-1-git-send-email-wens@csie.org>
 <1459243352-23344-5-git-send-email-wens@csie.org>
Message-ID: <1459245090.14208.1.camel@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-03-29 at 17:22 +0800, Chen-Yu Tsai wrote:
> The X-Powers AXP809 PMIC has a similar set of regulators as the
> AXP221,
> though a few LDOs were removed, and a new switch output added. Like
> the
> AXP221, AXP809 also has DC1SW and DC5LDO, which are internally
> chained
> to DCDC1 and DCDC5, respectively.
> 
> Add support for this new variant. Also remove the "axp22x_" prefix
> from
> DC1SW/DC5LDO supply handling code, as the AXP809 uses it as well.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/regulator/axp20x-regulator.c | 119
> ++++++++++++++++++++++++++---------
>  1 file changed, 90 insertions(+), 29 deletions(-)
> 

[...]

> @@ -420,17 +481,17 @@ static int axp20x_regulator_probe(struct
> platform_device *pdev)
>  		/*
>  		 * Save AXP22X DCDC1 / DCDC5 regulator names for
> later.
>  		 */

You should probably update this comment too, due to changes below.

> -		if (regulators == axp22x_regulators) {
> -			/* Can we use rdev->constraints->name
> instead? */
> -			if (i == AXP22X_DCDC1)
> -				of_property_read_string(rdev
> ->dev.of_node,
> -							"regulator
> -name",
> -							&axp22x_dc1_
> name);
> -			else if (i == AXP22X_DCDC5)
> -				of_property_read_string(rdev
> ->dev.of_node,
> -							"regulator
> -name",
> -							&axp22x_dc5_
> name);
> -		}
> +		if ((regulators == axp22x_regulators && i ==
> AXP22X_DCDC1) ||
> +		    (regulators == axp809_regulators && i ==
> AXP809_DCDC1))
> +			of_property_read_string(rdev->dev.of_node,
> +						"regulator-name",
> +						&dcdc1_name);
> +
> +		if ((regulators == axp22x_regulators && i ==
> AXP22X_DCDC5) ||
> +		    (regulators == axp809_regulators && i ==
> AXP809_DCDC5))
> +			of_property_read_string(rdev->dev.of_node,
> +						"regulator-name",
> +						&dcdc5_name);
>  	}
>  
>  	return 0;
> -- 
> 2.7.0
> 
