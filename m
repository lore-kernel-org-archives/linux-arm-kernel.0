From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 3 Jan 2018 16:27:28 +0000
Subject: [RESEND PATCH v2 14/15] ASoC: qcom: apq8096: Add db820c machine
 driver
In-Reply-To: <20180103001654.GU478@tuxbook>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-15-srinivas.kandagatla@linaro.org>
 <20180103001654.GU478@tuxbook>
Message-ID: <3acca412-4ef7-6e61-d250-2b35c1fe9fe8@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the review comments.


On 03/01/18 00:16, Bjorn Andersson wrote:
> On Thu 14 Dec 09:34 PST 2017, srinivas.kandagatla at linaro.org wrote:
> 
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> uThis patch adds support to DB820c machine driver.
> 
> Drop 'u' and expand the message to claim that this is the machine driver
> for 8996, used by the db820c.
> 
> [..]
>> +static struct snd_soc_dai_link msm8996_dai_links[] = {
> 
> Are there any differences between the DAI links of apq8096 and msm8996?
> 
This driver is more of board specific,
Am not 100% sure about msm8996, on apq8096 in particularly on db820c we 
got hdmi and analog audio connected via slimbus and also I2S on lowspeed 
connector.

>> +	/* FrontEnd DAI Links */
>> +	{
>> +		.name		= "MultiMedia1 Playback",
>> +		.stream_name	= "MultiMedia1",
>> +		.cpu_dai_name	= "MM_DL1",
>> +		.platform_name	= "q6asm_dai",
>> +		.dynamic	= 1,
>> +		.dpcm_playback	= 1,
>> +
>> +		.codec_dai_name	= "snd-soc-dummy-dai",
>> +		.codec_name = "snd-soc-dummy",
>> +	},
>> +	/* Backend DAI Links */
>> +	{
>> +		.name		= "HDMI Playback",
>> +		.stream_name	= "q6afe_dai",
>> +		.cpu_dai_name	= "HDMI",
>> +		.platform_name	= "q6routing",
>> +		.no_pcm		= 1,
>> +		.dpcm_playback	= 1,
>> +		.be_hw_params_fixup = msm8996_be_hw_params_fixup,
>> +		.codec_dai_name	= "i2s-hifi",
>> +		.codec_name = "hdmi-audio-codec.0.auto",
>> +	},
>> +};
>> +
>> +static int apq8096_sbc_parse_of(struct snd_soc_card *card)
> 
> msm8996_parse_of()

sure if it helps.

> 
>> +{
>> +	struct device *dev = card->dev;
>> +	int ret;
>> +
>> +	ret = snd_soc_of_parse_card_name(card, "qcom,model");
>> +	if (ret)
>> +		dev_err(dev, "Error parsing card name: %d\n", ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int msm_snd_apq8096_probe(struct platform_device *pdev)
> 
> msm_snd_msm8996_probe()?
sure
> 
>> +{
>> +	int ret;
>> +	struct snd_soc_card *card;
>> +
>> +	card = devm_kzalloc(&pdev->dev, sizeof(*card), GFP_KERNEL);
>> +	if (!card)
>> +		return -ENOMEM;
>> +
>> +	card->dev = &pdev->dev;
>> +
>> +	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));
>> +	if (ret)
>> +		return ret;
>> +
>> +	card->dai_link = msm8996_dai_links;
>> +	card->num_links	= ARRAY_SIZE(msm8996_dai_links);
>> +
>> +	ret = apq8096_sbc_parse_of(card);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Error parsing OF data\n");
> 
> No need to print in both parse_of() and here.
> 
yep.

>> +		return ret;
>> +	}
>> +
>> +	ret = devm_snd_soc_register_card(&pdev->dev, card);
>> +	if (ret)
>> +		dev_err(&pdev->dev, "sound card register failed (%d)!\n", ret);
>> +	else
>> +		dev_err(&pdev->dev, "sound card register Sucessfull\n");
> 
> This isn't an error, skip the print here.
> 
yep.

>> +
>> +	return ret;
>> +}
>> +
>> +static const struct of_device_id msm_snd_apq8096_dt_match[] = {
>> +	{.compatible = "qcom,apq8096-sndcard"},
>> +	{}
>> +};
>> +
>> +static struct platform_driver msm_snd_apq8096_driver = {
>> +	.probe  = msm_snd_apq8096_probe,
>> +	.driver = {
>> +		.name = "msm-snd-apq8096",
>> +		.owner = THIS_MODULE,
> 
> Drop the .owner
> 
yep
> Regards,
> Bjorn
> 
