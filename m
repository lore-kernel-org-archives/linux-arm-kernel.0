From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 18 Oct 2013 11:19:51 +0200
Subject: [Patch v2][ 16/37] ASoC: eukrea-tlv320: Add DT support.
In-Reply-To: <1382022155-21954-17-git-send-email-denis@eukrea.com>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
 <1382022155-21954-17-git-send-email-denis@eukrea.com>
Message-ID: <20131018111951.7508b5d1@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Denis Carikli <denis@eukrea.com> wrote:
> diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
> index 9a4a0ca..975af57 100644
> --- a/sound/soc/fsl/eukrea-tlv320.c
> +++ b/sound/soc/fsl/eukrea-tlv320.c
[...]
> @@ -26,24 +28,33 @@
>  
>  #include "../codecs/tlv320aic23.h"
>  #include "imx-ssi.h"
> +#include "fsl_ssi.h"
>  #include "imx-audmux.h"
>  
>  #define CODEC_CLOCK 12000000
>  
> +struct eukrea_tlv320 {
> +	char of;
> +};
> +
>  static int eukrea_tlv320_hw_params(struct snd_pcm_substream *substream,
>  			    struct snd_pcm_hw_params *params)
>  {
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct eukrea_tlv320 *priv = snd_soc_card_get_drvdata(rtd->card);
>  	struct snd_soc_dai *codec_dai = rtd->codec_dai;
>  	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>  	int ret;
>  
> -	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
> -				  SND_SOC_DAIFMT_NB_NF |
> -				  SND_SOC_DAIFMT_CBM_CFM);
> -	if (ret) {
> -		pr_err("%s: failed set cpu dai format\n", __func__);
>
dev_err(cpu_dai->dev,...);?

> -		return ret;
> +	/* fsl_ssi lacks the set_fmt ops. */
> +	if (!priv->of) {
> +		ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
> +					  SND_SOC_DAIFMT_NB_NF |
> +					  SND_SOC_DAIFMT_CBM_CFM);
> +		if (ret) {
> +			pr_err("%s: failed set cpu dai format\n", __func__);
> +			return ret;
> +		}
>  	}
>  
>  	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
> @@ -60,15 +71,18 @@ static int eukrea_tlv320_hw_params(struct snd_pcm_substream *substream,
>  		pr_err("%s: failed setting codec sysclk\n", __func__);
>
dev_err(codec_dai->dev,...);?

>  		return ret;
>  	}
> -	snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffc, 0xffffffc, 2, 0);
>  
> -	ret = snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, 0,
> -				SND_SOC_CLOCK_IN);
> -	if (ret) {
> -		pr_err("can't set CPU system clock IMX_SSP_SYS_CLK\n");
dto.

> -		return ret;
> -	}
> +	/* fsl_ssi lacks the set_sysclk ops */
> +	if (!priv->of) {
> +		snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffc, 0xffffffc, 2, 0);
>  
> +		ret = snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, 0,
> +					SND_SOC_CLOCK_IN);
> +		if (ret) {
> +			pr_err("can't set CPU system clock IMX_SSP_SYS_CLK\n");
dto.

> @@ -97,8 +110,56 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)
>  {
>  	int ret;
>  	int int_port = 0, ext_port;
> +	struct platform_device *ssi_pdev;
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *ssi_np;
> +	struct eukrea_tlv320 *priv;
> +
> +	priv = devm_kzalloc(&pdev->dev,
> +				sizeof(struct eukrea_tlv320), GFP_KERNEL);
> +	if (priv == NULL)
> +		return -ENOMEM;
> +
> +	if (np) {
> +		ssi_np = of_parse_phandle(pdev->dev.of_node,
> +					  "ssi-controller", 0);
> +		ssi_pdev = of_find_device_by_node(ssi_np);
> +		if (!ssi_pdev) {
> +			dev_err(&pdev->dev, "ssi-controller missing or "
> +				"invalid.\n");
>
Please don't line wrap error message strings as it makes it harder to
grep the kernel source for messages appearing in a logfile.

 [...]
> @@ -149,10 +229,17 @@ static int eukrea_tlv320_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id imx_tlv320_dt_ids[] = {
> +	{ .compatible = "eukrea,eukrea-tlv320"},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_tlv320_dt_ids);
> +
>  static struct platform_driver eukrea_tlv320_driver = {
>  	.driver = {
>  		.name = "eukrea_tlv320",
>  		.owner = THIS_MODULE,
> +		.of_match_table = imx_tlv320_dt_ids,
>  	},
>  	.probe = eukrea_tlv320_probe,
>  	.remove = eukrea_tlv320_remove,};

While at it you could fix the position of the '}' in the last line.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
