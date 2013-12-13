From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Fri, 13 Dec 2013 10:29:43 +0000
Subject: [PATCH 2/2] ASoC: sgtl5000: clean up sgtl5000_enable_regulators()
In-Reply-To: <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
References: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
 <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <00a7a941be434caf829f9fd246879c6d@BY2PR03MB505.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> -	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(sgtl5000->supplies),
> -				sgtl5000->supplies);
> -	if (!ret)
> -		external_vddd = 1;
> -	else {
> +	/* External VDDD only works before revision 0x11 */
> +	if (sgtl5000->revision < 0x11) {
> +		vddd = regulator_get_optional(codec->dev, "VDDD");
> +		if (IS_ERR(vddd)) {
> +			/* See if it's just not registered yet */
> +			if (PTR_ERR(vddd) == -EPROBE_DEFER)
> +				return -EPROBE_DEFER;
> +		} else {
> +			external_vddd = 1;
> +			regulator_put(vddd);
> +		}

Shouldn't we handle other errors ?
We can see that from the regulator_get_optional()-->_regulator_get(), there
are many other errors maybe returned. Not considering other error cases, If
the dt is used here, only ERR_PTR(-ENODEV) will be returned if the external
VDDD is absent, and only this case the ERR_PTR(_ENODEV) error will be returned,
Or if dt is not used and there has no external VDDD was found, the
ERR_PTR(-EPROBE_DEFER) will be returned.

So, if the external VDDD is not used, only ERR_PTR(-ENODEV) and ERR_PTR(-EPROBE_DEFER)
maybe returned ignoring other errors.

How about the following ? 
-----------------
+	if (IS_ERR(vddd)) {
+		/* See if it's just not registered yet */
+		if (PTR_ERR(vddd) != -ENODEV)
+			return PTR_ERR(vddd);
+	} else {
+		external_vddd = 1;
+		regulator_put(vddd);
+	}
-----------------


--
Xiubo
