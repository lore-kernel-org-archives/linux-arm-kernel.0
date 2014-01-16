From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 16 Jan 2014 09:31:23 +0800
Subject: [PATCH 2/3] ASoC: atmel_wm8904: make it available to choose clock
In-Reply-To: <20140114203650.GX15567@sirena.org.uk>
References: <1389669956-2304-1-git-send-email-voice.shen@atmel.com>
 <1389669956-2304-3-git-send-email-voice.shen@atmel.com>
 <20140114203650.GX15567@sirena.org.uk>
Message-ID: <52D7366B.1030909@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 01/15/2014 04:36 AM, Mark Brown wrote:
> On Tue, Jan 14, 2014 at 11:25:55AM +0800, Bo Shen wrote:
>> Make it available to choose the clock from TK pin or RK pin. This
>> is hardware design decided.
>
>> --- a/sound/soc/atmel/atmel_wm8904.c
>> +++ b/sound/soc/atmel/atmel_wm8904.c
>> @@ -108,6 +108,7 @@ static int atmel_asoc_wm8904_dt_init(struct platform_device *pdev)
>>   	struct device_node *codec_np, *cpu_np;
>>   	struct snd_soc_card *card = &atmel_asoc_wm8904_card;
>>   	struct snd_soc_dai_link *dailink = &atmel_asoc_wm8904_dailink;
>> +	struct atmel_ssc_info *ssc_info;
>>   	int ret;
>>
>>   	if (!np) {
>> @@ -115,6 +116,15 @@ static int atmel_asoc_wm8904_dt_init(struct platform_device *pdev)
>>   		return -EINVAL;
>>   	}
>>
>> +	ssc_info = devm_kzalloc(&pdev->dev, sizeof(*ssc_info), GFP_KERNEL);
>> +	if (!ssc_info)
>> +		return -ENOMEM;
>> +
>> +	ssc_info->clk_from_rk_pin =
>> +		of_property_read_bool(np, "clk_from_rk_pin");
>> +
>> +	card->drvdata = (void *)ssc_info;
>
> Shouldn't this code be in the DAI driver?  Otherwise this series looks
> fine to me, though the DT folks might have something to say I guess.

   For audio on Atmel SoC, it depends on three device nodes, one is SSC 
node, one is the codec node and the sound node.
   The sound node will parse by machine driver, and machine driver is 
mainly for hardware connection. As the "clk_from_rk_pin" is decided by 
hardware, so, I put it here.
   If I move the code to dai driver, it will parse the sound node in dai 
driver, I think it will make the code a little bit not explicit. What do 
you think?

Best Regards,
Bo Shen
