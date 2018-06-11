From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Mon, 11 Jun 2018 11:03:20 +0900
Subject: [alsa-devel] [PATCH] ASoC: audio-graph-card: add hp and mic
 detect gpios same as simple-card
In-Reply-To: <87h8makxt7.wl-kuninori.morimoto.gx@renesas.com>
References: <20180608080843.11097-1-suzuki.katsuhiro@socionext.com>
 <87h8makxt7.wl-kuninori.morimoto.gx@renesas.com>
Message-ID: <a397e5b7-f6bd-17b5-2105-5875085467e5@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Morimoto-san,

Thank you for your reviewing.

On 06/11/18 08:52, Kuninori Morimoto wrote:
> 
> Hi Katsuhiro-san
> 
> Thank you for your patch
> 
>> This patch adds headphone and microphone jack detection gpios as same
>> as simple-card driver. This feature move into simple-card-utils from
>> simple-card to avoid the duplicating code.
>>
>> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
>> ---
> 
> I think it can be 2 patches ?
>   1. move function from simple-card to simple-card-utils
>   2. use it from audio-graph-card
> 

OK, I'll split this patch.


>> +static int asoc_graph_soc_card_probe(struct snd_soc_card *card)
>> +{
>> +	struct graph_card_data *priv = snd_soc_card_get_drvdata(card);
>> +	int ret;
>> +
>> +	ret = asoc_simple_card_init_hp(card, &priv->hp_jack, NULL);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = asoc_simple_card_init_mic(card, &priv->mic_jack, NULL);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>>   static int asoc_graph_card_probe(struct platform_device *pdev)
>>   {
>>   	struct graph_card_data *priv;
>> @@ -319,6 +336,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
>>   	card->num_links	= num;
>>   	card->dapm_widgets = asoc_graph_card_dapm_widgets;
>>   	card->num_dapm_widgets = ARRAY_SIZE(asoc_graph_card_dapm_widgets);
>> +	card->probe	= asoc_graph_soc_card_probe;
> 
> Current simple-card is calling init_hp/init_mic from
> asoc_simple_card_dai_init(), and audio-graph-card has
> asoc_graph_card_dai_init().
> simple/audio card are doing samethings in different style.
> Thus, I want to synchronized whole simple/audio card.
> 

Ah, right. I need to add more one patch.

   1. move function from simple-card to simple-card-utils
   2. change calling init_hp/mic from soc_dai_link.init() to
      soc_card.probe()
   3. use it from audio-graph-card


Regards,
--
Katsuhiro Suzuki


> Best regards
> ---
> Kuninori Morimoto
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
