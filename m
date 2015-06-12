From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Jun 2015 14:13:25 +0100
Subject: [PATCH 2/3] ASoC: mediatek: Add machine driver for MAX98090 codec
In-Reply-To: <1433946276-25969-3-git-send-email-koro.chen@mediatek.com>
References: <1433946276-25969-1-git-send-email-koro.chen@mediatek.com>
 <1433946276-25969-3-git-send-email-koro.chen@mediatek.com>
Message-ID: <20150612131325.GA1921@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 10, 2015 at 10:24:35PM +0800, Koro Chen wrote:

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mt8173-max98090.txt
> @@ -0,0 +1,17 @@
> +MT8173 with MAX98090 CODEC
> +
> +Required properties:
> +- compatible : "mediatek,mt8173-max98090"
> +- mediatek,audio-codec: the phandle of the MAX98090 audio codec
> +- dvdd-supply : the phandle of regulator to supply 1.2V
> +- avdd-supply : the phandle of regulator to supply 1.8V

Why are these supplies part of the machine driver?

> +config SND_SOC_MT8173_MAX98090
> +	bool "ASoC Audio driver for MT8173 with MAX98090 codec"

Why bool?

> +	codec_node = of_parse_phandle(pdev->dev.of_node,
> +				      "mediatek,audio-codec", 0);
> +	if (!codec_node) {
> +		dev_err(&pdev->dev,
> +			"Property 'audio-codec' missing or invalid\n");
> +	} else {

Isn't this a fatal error?

> +	/* set codec DVDD voltage */
> +	reg_dvdd = devm_regulator_get(&pdev->dev, "dvdd");
> +	if (IS_ERR(reg_dvdd)) {
> +		dev_err(&pdev->dev, "failed to get dvdd\n");
> +		return PTR_ERR(reg_dvdd);
> +	}
> +	ret = regulator_set_voltage(reg_dvdd, 1220000, 1220000);
> +	if (ret != 0) {
> +		dev_err(&pdev->dev, "Failed to set dvdd: %d\n", ret);
> +		return ret;
> +	}

No, this is not appropriate for a machine driver - this is something the
regulator constraints set for the board should do.

> +	dev_info(&pdev->dev, "dvdd = %d uv\n",
> +		 regulator_get_voltage(reg_dvdd));

Don't include debugging stuff like this please.

> +	ret = regulator_enable(reg_dvdd);
> +	if (ret != 0) {
> +		dev_err(&pdev->dev, "Failed to enable dvdd: %d\n", ret);
> +		return ret;
> +	}

IF this is for the CODEC then you should add regulator support to the
CODEC driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150612/38267582/attachment.sig>
