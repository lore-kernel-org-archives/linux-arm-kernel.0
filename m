From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 20 Apr 2016 15:30:42 +0200
Subject: [PATCH 2/2 v6] ASoC: mediatek: Add second I2S on mt8173-rt5650
 machine driver
In-Reply-To: <1461134447-42001-3-git-send-email-pc.liao@mediatek.com>
References: <1461134447-42001-1-git-send-email-pc.liao@mediatek.com>
 <1461134447-42001-3-git-send-email-pc.liao@mediatek.com>
Message-ID: <57178482.9090705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/04/16 08:40, PC Liao wrote:
> This patch adds second I2S connection to rt5650 codec for capture path on
> mt8173-rt5650 machine driver.
>
> Signed-off-by: PC Liao <pc.liao@mediatek.com>
> ---
>   .../devicetree/bindings/sound/mt8173-rt5650.txt    |    6 +++
>   sound/soc/mediatek/mt8173-rt5650.c                 |   44 ++++++++++++++++++--
>   2 files changed, 47 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt b/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
> index fe5a5ef..802dd1b 100644
> --- a/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
> +++ b/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
> @@ -5,11 +5,17 @@ Required properties:
>   - mediatek,audio-codec: the phandles of rt5650 codecs
>   - mediatek,platform: the phandle of MT8173 ASoC platform
>
> +Optional properties:
> +- capture-dai: audio codec dai on capture path
> +  <&rt5650 0> : Default setting. Connect rt5650 I2S1 for capture. (dai_name = rt5645-aif1)
> +  <&rt5650 1> : Connect rt5650 I2S2 for capture. (dai_name = rt5645-aif2)
> +
>   Example:
>
>   	sound {
>   		compatible = "mediatek,mt8173-rt5650";
>   		mediatek,audio-codec = <&rt5650>;
>   		mediatek,platform = <&afe>;
> +		capture-dai = <&rt5650 1>;
>   	};
>
> diff --git a/sound/soc/mediatek/mt8173-rt5650.c b/sound/soc/mediatek/mt8173-rt5650.c
> index bb09bb1..45dea22 100644
> --- a/sound/soc/mediatek/mt8173-rt5650.c
> +++ b/sound/soc/mediatek/mt8173-rt5650.c
> @@ -85,12 +85,26 @@ static int mt8173_rt5650_init(struct snd_soc_pcm_runtime *runtime)
>   {
>   	struct snd_soc_card *card = runtime->card;
>   	struct snd_soc_codec *codec = runtime->codec_dais[0]->codec;
> +	const char *codec_dai_capture = runtime->codec_dais[1]->name;
>   	int ret;
>
>   	rt5645_sel_asrc_clk_src(codec,
> -				RT5645_DA_STEREO_FILTER |
> -				RT5645_AD_STEREO_FILTER,
> +				RT5645_DA_STEREO_FILTER,
>   				RT5645_CLK_SEL_I2S1_ASRC);
> +
> +	if (!strcmp(codec_dai_capture, "rt5645-aif1")) {
> +		rt5645_sel_asrc_clk_src(codec,
> +					RT5645_AD_STEREO_FILTER,
> +					RT5645_CLK_SEL_I2S1_ASRC);
> +	} else if (!strcmp(codec_dai_capture, "rt5645-aif2")) {
> +		rt5645_sel_asrc_clk_src(codec,
> +					RT5645_AD_STEREO_FILTER,
> +					RT5645_CLK_SEL_I2S2_ASRC);
> +	} else {

For compatibility you should change this to something like:

    dev_warn(card->dev, "Only one dai codec found in DTS, enabled rt5645
                         AD filter\n");
    rt5645_sel_asrc_clk_src(codec, RT5645_AD_STEREO_FILTER,
                                   RT5645_CLK_SEL_I2S1_ASRC);
}

Regards,
Matthias
