From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 3 Jan 2018 18:36:22 +0000
Subject: [RESEND PATCH v2 14/15] ASoC: qcom: apq8096: Add db820c machine
 driver
In-Reply-To: <f72f32dd-e248-47c3-23cc-eabe1b85d9ae@codeaurora.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-15-srinivas.kandagatla@linaro.org>
 <f72f32dd-e248-47c3-23cc-eabe1b85d9ae@codeaurora.org>
Message-ID: <4db358ab-3171-bb08-ca26-ec9bf282e8d4@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your review comments,

On 03/01/18 17:20, Stephen Boyd wrote:
> On 12/14/2017 09:34 AM, srinivas.kandagatla at linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>

>> diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
>> new file mode 100644
>> index 000000000000..5b2036317f71
>> --- /dev/null
>> +++ b/sound/soc/qcom/apq8096.c
>> @@ -0,0 +1,124 @@

>> + */
>> +#include <linux/clk.h>
> 
> No clk usage though?
Will remove it in next version.

> 
>> +#include <linux/platform_device.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <sound/soc.h>
> [...]

>> +static int apq8096_sbc_parse_of(struct snd_soc_card *card)
>> +{
>> +	struct device *dev = card->dev;
>> +	int ret;
>> +
>> +	ret = snd_soc_of_parse_card_name(card, "qcom,model");
>> +	if (ret)
>> +		dev_err(dev, "Error parsing card name: %d\n", ret);
> 
> So this prints an error, and the caller also prints an error when it
> fails. Double error messages?
> 

looks redundant, will remove it.
>> +
>> +	return ret;
>> +}
>> +
>> +static int msm_snd_apq8096_probe(struct platform_device *pdev)
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
> 
> Why do we need to do this? Can you add some sort of comment in the code
> about why?

Even though dsp supports 64 bit addresses, but the sid sits at offset of 
32, which brings this restriction of supporting only 32 bit iova.

thanks,
srini

> 
