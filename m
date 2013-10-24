From: broonie@kernel.org (Mark Brown)
Date: Thu, 24 Oct 2013 11:01:55 +0100
Subject: [PATCHv6][ 1/4] ASoC: eukrea-tlv320: Add DT support.
In-Reply-To: <1382519766-17359-1-git-send-email-denis@eukrea.com>
References: <1382519766-17359-1-git-send-email-denis@eukrea.com>
Message-ID: <20131024100155.GI31415@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 11:16:03AM +0200, Denis Carikli wrote:

> +	/* fsl_ssi lacks the set_fmt ops. */
> +	if (!priv->of) {
> +		ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
> +					  SND_SOC_DAIFMT_NB_NF |
> +					  SND_SOC_DAIFMT_CBM_CFM);
> +		if (ret) {
> +			dev_err(cpu_dai->dev,
> +				"Failed to set the cpu dai format\n");
> +			return ret;
> +		}

This is unrelated to OF support, whatever version of the DAI does have
the operation might be used on an ACPI system for example.  What would
be better would be to check the return value for -ENOTSUPP and ignore
that while still passing on other errors.  The same thing applies to the
other ops that aren't supported.

>  	if (ret) {
> -		pr_err("%s: failed set codec dai format\n", __func__);
> +		dev_err(cpu_dai->dev,
> +			"Failed to set the codec dai format.\n");
>  		return ret;

This is a useful cleanup but should be done in a separate patch.

> +	/* fsl_ssi lacks the set_sysclk ops */
> +	if (!priv->of) {
> +		snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffc, 0xffffffc, 2, 0);

This is nothing to do with sysclk, but that's just a minor point about
the grouping and commenting.

> @@ -80,7 +97,6 @@ static struct snd_soc_dai_link eukrea_tlv320_dai = {
>  	.name		= "tlv320aic23",
>  	.stream_name	= "TLV320AIC23",
>  	.codec_dai_name	= "tlv320aic23-hifi",
> -	.platform_name	= "imx-ssi.0",

Does this not break existing users?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131024/d579bbfc/attachment.sig>
