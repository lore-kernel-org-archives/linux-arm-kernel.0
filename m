From: bgoswami@codeaurora.org (Banajit Goswami)
Date: Wed, 9 May 2018 02:15:18 -0700
Subject: [PATCH v7 23/24] ASoC: qcom: apq8096: Add db820c machine driver
In-Reply-To: <20180501120820.11016-24-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-24-srinivas.kandagatla@linaro.org>
Message-ID: <c52fc35d-95a6-6675-6c6e-32a0d5f486d4@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to DB820c machine driver.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   sound/soc/qcom/Kconfig   |   9 ++
>   sound/soc/qcom/Makefile  |   2 +
>   sound/soc/qcom/apq8096.c | 238 +++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 249 insertions(+)
>   create mode 100644 sound/soc/qcom/apq8096.c
<snip>

> +
> +static int apq8096_sbc_parse_of(struct snd_soc_card *card)
> +{
> +	struct device_node *np, *codec, *platform, *cpu, *node;
> +	struct device *dev = card->dev;
> +	struct snd_soc_dai_link *link;
> +	int ret, num_links;
> +
> +	ret = snd_soc_of_parse_card_name(card, "qcom,model");
> +	if (ret) {
> +		dev_err(dev, "Error parsing card name: %d\n", ret);
> +		return ret;
> +	}
> +
> +	node = dev->of_node;
> +
> +	/* DAPM routes */
> +	if (of_property_read_bool(node, "qcom,audio-routing")) {
> +		ret = snd_soc_of_parse_audio_routing(card,
> +					"qcom,audio-routing");
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Populate links */
> +	num_links = of_get_child_count(node);
> +
> +	/* Allocate the DAI link array */
> +	card->dai_link = kcalloc(num_links, sizeof(*link), GFP_KERNEL);
> +	if (!card->dai_link)
> +		return -ENOMEM;
> +
> +	card->num_links	= num_links;
> +	link = card->dai_link;
> +
> +	for_each_child_of_node(node, np) {
> +		cpu = of_get_child_by_name(np, "cpu");
> +		platform = of_get_child_by_name(np, "platform");
> +		codec = of_get_child_by_name(np, "codec");
> +
> +		if (!cpu) {
> +			dev_err(dev, "Can't find cpu DT node\n");
clean up missing to kfree(card->dai_link)?

> +			return -EINVAL;
> +		}
> +
> +		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
> +		if (!link->cpu_of_node) {
> +			dev_err(card->dev, "error getting cpu phandle\n");
ditto

> +			return -EINVAL;
> +		}
> +
> +		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
> +		if (ret) {
> +			dev_err(card->dev, "error getting cpu dai name\n");
ditto

> +			return ret;
> +		}
> +
> +		if (codec && platform) {
> +			link->platform_of_node = of_parse_phandle(platform,
> +								  "sound-dai",
> +								   0);
> +			if (!link->platform_of_node) {
> +				dev_err(card->dev, "platform dai not found\n");
ditto

> +				return -EINVAL;
> +			}
> +
> +			ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
> +			if (ret < 0) {
> +				dev_err(card->dev, "codec dai not found\n");
ditto

> +				return ret;
> +			}
> +			link->no_pcm = 1;
> +			link->ignore_suspend = 1;
ignore_suspend will also need to be set for FE DAIs?

> +			link->ignore_pmdown_time = 1;
> +			link->be_hw_params_fixup = apq8096_be_hw_params_fixup;
> +		} else {
> +			link->platform_of_node = link->cpu_of_node;
> +			link->codec_dai_name = "snd-soc-dummy-dai";
> +			link->codec_name = "snd-soc-dummy";
> +			link->dynamic = 1;
> +		}
> +
> +		ret = of_property_read_string(np, "link-name", &link->name);
> +		if (ret) {
> +			dev_err(card->dev, "error getting codec dai_link name\n");
clean up

> +			return ret;
> +		}
> +
> +		link->dpcm_playback = 1;
> +		link->dpcm_capture = 1;
> +		link->stream_name = link->name;
> +		link++;
> +	}
> +
> +	return ret;
> +}
> +
> +static int apq8096_bind(struct device *dev)
> +{
> +	struct snd_soc_card *card;
> +	int ret;
> +
> +	card = kzalloc(sizeof(*card), GFP_KERNEL);
> +	if (!card)
> +		return -ENOMEM;
> +
> +	component_bind_all(dev, card);
> +	card->dev = dev;
> +	ret = apq8096_sbc_parse_of(card);
> +	if (ret) {
> +		dev_err(dev, "Error parsing OF data\n");
> +		component_unbind_all(dev, card);
> +		return ret;
> +	}
> +
> +	return snd_soc_register_card(card);
> +}
> +
> +static void apq8096_unbind(struct device *dev)
> +{
> +	struct snd_soc_card *card = dev_get_drvdata(dev);
> +
> +	component_unbind_all(dev, card);
> +	snd_soc_unregister_card(card);
Should sound card not be unregistered first, before calling 
component_unbind_all()?

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
