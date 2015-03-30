From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 30 Mar 2015 07:36:36 +0200
Subject: [PATCH] pinctrl: imx: Allow parsing DT without function nodes
In-Reply-To: <1427664004-21056-1-git-send-email-mpa@pengutronix.de>
References: <1427664004-21056-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20150330053636.GN32677@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Markus,

On Sun, Mar 29, 2015 at 11:20:04PM +0200, Markus Pargmann wrote:
> The old format to define pinctrl settings for imx in DT has two
> hierarchy levels. The first level are function device nodes. The second
> level are pingroups which contain a property fsl,pins. The original
> intention was to define all pin functions in a single dtsi file and just
> reference the correct ones in the board files.
> This idea was rejected some time ago leading to the current design to
> have all the pinfunctions defined in the board files. So we don't need
> the function device nodes anymore.
> 
> This patch changes the pinctrl driver to accept devicetrees which do not
> have the first hierarchy level, function device nodes. For example
> karo-tx25 already has such a devicetree. Old devicetrees are still
> parsed and supported.
Documentation/devicetree/bindings/pinctrl/fsl,imx* needs adaption if the
new format should be the recommended one.

> -	nfuncs = of_get_child_count(np);
> -	if (nfuncs <= 0) {
> -		dev_err(&pdev->dev, "no functions defined\n");
> -		return -EINVAL;
> +	/*
> +	 * Check if the DT contains pins in the direct child nodes. This
> +	 * indicates the newer DT format to store pins. The old format with
> +	 * function devicenodes which contain group nodes which contain
> +	 * fsl,pins is still parsed if flat_funcs is false.
> +	 */
> +	child = of_get_next_child(np, NULL);
If of_get_next_child picked imx27's gpio at 10015000 here, ...

> +	if (child)
> +		flat_funcs = of_property_read_bool(child, "fsl,pins");
... flat_funcs is assigned false which might be wrong.

These nodes must be special cased also in imx_pinctrl_parse_functions I
think.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
