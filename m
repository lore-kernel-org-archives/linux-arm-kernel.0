From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 9 Feb 2015 16:37:59 +0800
Subject: [PATCH v2] ASoC: atmel_ssc_dai: Allow more rates
In-Reply-To: <896ef5e9484a494e9e50cbed38919c5f@EMAIL.axentia.se>
References: <1423050745-6372-1-git-send-email-peda@lysator.liu.se>
 <54D824F8.9030804@atmel.com>
 <896ef5e9484a494e9e50cbed38919c5f@EMAIL.axentia.se>
Message-ID: <54D871E7.40902@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 02/09/2015 04:09 PM, Peter Rosin wrote:

[Snip]

>>>
>>>    /*-------------------------------------------------------------------------*\
>>>     * DAI functions
>>> @@ -200,6 +290,7 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
>>>    	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
>>>    	struct atmel_pcm_dma_params *dma_params;
>>>    	int dir, dir_mask;
>>> +	int ret;
>>>
>>>    	pr_debug("atmel_ssc_startup: SSC_SR=0x%u\n",
>>>    		ssc_readl(ssc_p->ssc->regs, SR));
>>> @@ -207,6 +298,7 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
>>>    	/* Enable PMC peripheral clock for this SSC */
>>>    	pr_debug("atmel_ssc_dai: Starting clock\n");
>>>    	clk_enable(ssc_p->ssc->clk);
>>> +	ssc_p->mck_rate = clk_get_rate(ssc_p->ssc->clk) * 2;
>>
>> Why the mck_rate is calculated in this form?
>
> What did you have in mind? Add another clock to the ssc node in the
> device tree?
>
> IIUC, the device tree (at least normally) has the ssc clk as the peripheral
> clock divided by 2, but the ssc specifies (when capturing in the CBM/CFS
> case) the rate limit as the peripheral clock divided by 3 (i.e. ssc clk / 1.5).
> Since the SSC spec expresses the rate limit in terms of the peripheral
> clock, this was what I came up with. I didn't want to require dt changes...

You make a misunderstand for the mck for ssc peripheral. The mck here is 
not the system mck, it only related with the ssc, it is the PMC output. 
For example, in device tree, the ssc clock divided by 2, then the pmc 
output for ssc is "system mck / 2", so the ssc mck is "system mck / 2". 
If divided by 4, then the ssc mck is "system / 4"

>>>    	/* Reset the SSC to keep it at a clean status */
>>>    	ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST)); @@ -219,6
>>> +311,17 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
>>>    		dir_mask = SSC_DIR_MASK_CAPTURE;
>>>    	}
>>>
>>> +	ret = snd_pcm_hw_rule_add(substream->runtime, 0,
>>> +				  SNDRV_PCM_HW_PARAM_RATE,
>>> +				  atmel_ssc_hw_rule_rate,
>>> +				  ssc_p,
>>> +				  SNDRV_PCM_HW_PARAM_FRAME_BITS,
>>> +				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
>>> +	if (ret < 0) {
>>> +		dev_err(dai->dev, "Failed to specify rate rule: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>>    	dma_params = &ssc_dma_params[dai->id][dir];
>>>    	dma_params->ssc = ssc_p->ssc;
>>>    	dma_params->substream = substream;
>>> @@ -783,8 +886,6 @@ static int atmel_ssc_resume(struct snd_soc_dai *cpu_dai)
>>>    #  define atmel_ssc_resume	NULL
>>>    #endif /* CONFIG_PM */
>>>
>>> -#define ATMEL_SSC_RATES (SNDRV_PCM_RATE_8000_96000)
>>> -
>>>    #define ATMEL_SSC_FORMATS (SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_S16_LE |\
>>>    			  SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
>>>
>>> @@ -804,12 +905,16 @@ static struct snd_soc_dai_driver atmel_ssc_dai = {
>>>    		.playback = {
>>>    			.channels_min = 1,
>>>    			.channels_max = 2,
>>> -			.rates = ATMEL_SSC_RATES,
>>> +			.rates = SNDRV_PCM_RATE_CONTINUOUS,
>>> +			.rate_min = 8000,
>>> +			.rate_max = 384000,
>>
>> Why this need to be changed? Do you mean in your application, the rates will
>> exceed 96000?
>
> Yes, we have designed for 250kHz and this works just fine. Why limit
> to 96kHz?
>
> Our application isn't audio, we're generating an FM subcarrier (DARC)
> and need to output signals up to about 100kHz, give or take a few kHz
> depending on how pedantic you are. Basically, we need a sampling rate
> above 208kHz or so (DACs will normally not be usable all the way up to
> the Nyquist frequency), or things are simply not usable for us.

For me, I should consider this is an another application for SSC, but 
not audio, however similar to audio. And as you specified, it is tested 
OK. So, no objection here, then.

>>>    			.formats = ATMEL_SSC_FORMATS,},
>>>    		.capture = {
>>>    			.channels_min = 1,
>>>    			.channels_max = 2,
>>> -			.rates = ATMEL_SSC_RATES,
>>> +			.rates = SNDRV_PCM_RATE_CONTINUOUS,
>>> +			.rate_min = 8000,
>>> +			.rate_max = 384000,
>>
>> Ditto.
>
> We are not capturing in our application, I changed this for symmetry.
>
> Best regards,
> Peter
>
>>>    			.formats = ATMEL_SSC_FORMATS,},
>>>    		.ops = &atmel_ssc_dai_ops,
>>>    };
>>> diff --git a/sound/soc/atmel/atmel_ssc_dai.h
>>> b/sound/soc/atmel/atmel_ssc_dai.h index b1f08d511495..80b153857a88
>>> 100644
>>> --- a/sound/soc/atmel/atmel_ssc_dai.h
>>> +++ b/sound/soc/atmel/atmel_ssc_dai.h
>>> @@ -115,6 +115,7 @@ struct atmel_ssc_info {
>>>    	unsigned short rcmr_period;
>>>    	struct atmel_pcm_dma_params *dma_params[2];
>>>    	struct atmel_ssc_state ssc_state;
>>> +	unsigned long mck_rate;
>>>    };
>>>
>>>    int atmel_ssc_set_audio(int ssc_id);
>>>
>>
>> Best Regards,
>> Bo Shen

Best Regards,
Bo Shen
