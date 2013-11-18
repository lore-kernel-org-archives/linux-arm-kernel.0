From: florian.meier@koalo.de (Florian Meier)
Date: Mon, 18 Nov 2013 16:56:33 +0100
Subject: [PATCHv3] ASoC: Add support for BCM2835
In-Reply-To: <1384776479.14845.208.camel@smile>
References: <5289F9DF.8060406@koalo.de> <1384776479.14845.208.camel@smile>
Message-ID: <528A38B1.5010107@koalo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
>> +				 struct snd_pcm_hw_params *params,
>> +				 struct snd_soc_dai *dai)
>> +{
>> +	struct bcm2835_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
>> +
>> +	unsigned int sampling_rate = params_rate(params);
>> +	unsigned int data_length, data_delay, bclk_ratio;
>> +	unsigned int ch1pos, ch2pos, mode, format;
>> +	unsigned int mash = BCM2835_CLK_MASH_1;
>> +	unsigned int divi, divf, target_frequency;
>> +	int clk_src = -1;
>> +	unsigned int master = dev->fmt & SND_SOC_DAIFMT_MASTER_MASK;
>> +	uint32_t bit_master =	(master == SND_SOC_DAIFMT_CBS_CFS
>> +					|| master == SND_SOC_DAIFMT_CBS_CFM);
>> +
>> +	uint32_t frame_master =	(master == SND_SOC_DAIFMT_CBS_CFS
> 
> So, if master == SND_SOC_DAIFMT_CBS_CFS both bit_master and frame_master
> will be true. Is it correct?

Yes. That is exactly what CBS_CFS expresses:
Codec Bit Slave and Codec Frame Slave
So the interface is bit master as well as frame master.
Did I miss anything?
