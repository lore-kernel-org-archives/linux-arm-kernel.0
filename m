From: flatmax@flatmax.org (Matt Flax)
Date: Wed, 15 Feb 2017 07:36:34 +1100
Subject: [alsa-devel] [PATCH v2] ASoC: bcm2835: Add 8 channel (multitrack)
 capability
In-Reply-To: <20170214093201.GY1754@localhost.localdomain>
References: <1486422576-6958-1-git-send-email-flatmax@flatmax.org>
 <1486942035-24038-1-git-send-email-flatmax@flatmax.org>
 <20170214093201.GY1754@localhost.localdomain>
Message-ID: <6fadcd15-f26a-b586-3a4b-c598ef8109ba@flatmax.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/02/17 20:32, Charles Keepax wrote:
> On Mon, Feb 13, 2017 at 10:27:15AM +1100, Matt Flax wrote:
>> This patch adds multitrack capability if in DSP mode A and the
>> codec is master.
>>
>> In bcm2835_i2s_startup, snd_pcm_hw_constraint_minmax is used to set
>> max channels to 8 if both SND_SOC_DAIFMT_CBM_CFM and
>> SND_SOC_DAIFMT_DSP_A are set. Otherwise, max channels is set to 2.
>> Min channels is always set to 2. These settings are accomplished
>> using the SNDRV_PCM_HW_PARAM_CHANNELS variable.
>>
>> In bcm2835_i2s_shutdown max channels is set to 2 by default.
>>
>> In bcm2835_i2s_hw_params, DSP mode A format is now an option.
>> Before replicating the format variable (from ch2 to ch1) for
>> register loading, requested channels are checked to be either 2 or 8.
>> This can be expaneded later to accomodate other channel counts if
>> supported by the sound card hardware.
>>
>> Signed-off-by: Matt Flax <flatmax@flatmax.org>
>> ---
> <snip>
>> @@ -312,6 +313,7 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
>>   
>>   	switch (params_channels(params)) {
>>   	case 2:
>> +	case 8:
>>   		format = BCM2835_I2S_CH1(format) | BCM2835_I2S_CH2(format);
>>   		format |= BCM2835_I2S_CH1(BCM2835_I2S_CHPOS(ch1pos));
>>   		format |= BCM2835_I2S_CH2(BCM2835_I2S_CHPOS(ch2pos));
>> @@ -526,7 +528,16 @@ static int bcm2835_i2s_startup(struct snd_pcm_substream *substream,
>>   	regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_CS_A_REG,
>>   			BCM2835_I2S_STBY, BCM2835_I2S_STBY);
>>   
>> -	return 0;
>> +	/* Set the max channels to 8 if the codec is master and
>> +	 * we are in DSP A mode. Otherwise only allow 2 channels.
>> +	 */
>> +	if (dev->fmt &
>> +		(SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_DSP_A))
>> +		return snd_pcm_hw_constraint_minmax(substream->runtime,
>> +			SNDRV_PCM_HW_PARAM_CHANNELS, 2, 8);
> Would it be worth using snd_pcm_hw_constraint_list here? We are
> going to error out of hw_params if the user requests anything
> other than 2 or 8 channels so we should probably just constrain
> to those two.

Actually, I didn't think of this, but there is no reason to have 2 
channels available in DSP A mode with codec master. I will change this 
to constrain the channels to 8.
>
>> +	else
>> +		return snd_pcm_hw_constraint_minmax(substream->runtime,
>> +			SNDRV_PCM_HW_PARAM_CHANNELS, 2, 2);
> snd_pcm_hw_constraint_single, it's exactly the same thing but I
> guess we should probably use the helper if it exists.

Will do.

>>   }
>>   
>>   static void bcm2835_i2s_shutdown(struct snd_pcm_substream *substream,
>> @@ -549,6 +560,10 @@ static void bcm2835_i2s_shutdown(struct snd_pcm_substream *substream,
>>   	 * not stop the clock when SND_SOC_DAIFMT_CONT
>>   	 */
>>   	bcm2835_i2s_stop_clock(dev);
>> +
>> +	/* Default to 2 channels */
>> +	snd_pcm_hw_constraint_minmax(substream->runtime,
>> +			SNDRV_PCM_HW_PARAM_CHANNELS, 2, 2);
>>   }
> ditto.

Will do.

>
> Thanks,
> Charles
