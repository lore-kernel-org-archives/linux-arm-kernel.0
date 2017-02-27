From: arnaud.pouliquen@st.com (Arnaud Pouliquen)
Date: Mon, 27 Feb 2017 11:31:51 +0100
Subject: [RFC v2 5/7] ASoC: stm32: add DFSDM DAI support
In-Reply-To: <a9cf136c-2c8c-eafc-d175-4977c7ea4925@kernel.org>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-6-git-send-email-arnaud.pouliquen@st.com>
 <20170214174534.35ytbpax75mxcayg@sirena.org.uk>
 <a9cf136c-2c8c-eafc-d175-4977c7ea4925@kernel.org>
Message-ID: <84f330ab-48a2-6e0b-ab95-6aab5b34c241@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/19/2017 03:56 PM, Jonathan Cameron wrote:
> On 14/02/17 17:45, Mark Brown wrote:
>> On Mon, Feb 13, 2017 at 05:38:27PM +0100, Arnaud Pouliquen wrote:
>>
>> This looks basically fine as a system specific driver but as some of the
>> comments in here say there's bits of it could perhaps be genericised but
>> I'm not sure we need to do that right now.  I'm not sure the abstraction
>> is exactly comfortable but having another bit of hardware doing a bridge
>> to IIO might be the best way to figure out something better.
> Agreed.  To an extent we are fishing around in the dark at the moment.
> Lets wait until we have a few more cases of similar hardware before trying
> too much generalization.  This is acting as a good exploration of what
> is needed.

So for now i keep like this the API between ASOC and IIO, means not
generic API, and DMA handled in ASOC?

Then when some other hardwares come with same kind of requirements, we
will re-discuss a more generic way to do it...

> 
> Ideally Lars might upstream some of the other bits he has in his tree
> to do with DSP processing on ADC streams and that might provide us with
> more clues on generality (at least at the lowest layers)
> (Apparently he's busy - though he always makes that excuse :)
> Joking aside, the exploration Analog and in particular Lars does around
> pushing the limits of how things interact is always useful!)
> 
>>
>>> +	.period_bytes_min = 40, /* 8 khz 5 ms */
>>> +	.period_bytes_max = 4 * PAGE_SIZE,
>>> +	.buffer_bytes_max = 16 * PAGE_SIZE
>>
>> What's the physical minimum period limit?  The comment makes this sound
>> like it's just made up.
>>
>>> +	unsigned int shift = 24 -priv->max_scaling;
>>> +	
>>
>> Missing space after -.
>>
>>> +	dev_dbg(dai->dev, "%s: enter\n", __func__);
>>> +	return 0;
>>> +	return snd_pcm_hw_constraint_list(substream->runtime, 0,
>>> +					  SNDRV_PCM_HW_PARAM_RATE,
>>> +					  &priv->rates_const);
>>
>> Looks like debug changes got left in?
>>
>>> +static int stm32_adfsdm_set_sysclk(struct snd_soc_dai *dai, int clk_id,
>>> +				   unsigned int freq, int dir)
>>> +{
>>> +	struct stm32_adfsdm_priv *priv = snd_soc_dai_get_drvdata(dai);
>>> +	struct stm32_adfsdm_pdata *pdata = priv->pdata;
>>> +
>>> +	dev_dbg(dai->dev, "%s: enter for dai %d\n", __func__, dai->id);
>>> +	if (dir == SND_SOC_CLOCK_IN) {
>>> +		pdata->ops->set_sysclk(pdata->adc, freq);
>>> +		priv->dmic_clk = freq;
>>> +	}
>>> +
>>> +	/* Determine supported rate which depends on SPI/manchester clock */
>>> +	return stm32_adfsdm_get_supported_rates(dai, &priv->rates_const.mask);
>>
>> Since the DAI is unidirectional it doesn't matter but obviously if it
>> weren't then the fact that getting the supported rates involves setting
>> the hwparams means this could become disruptive.  If we're going to
>> genericise this to be a more general IIO/ASoC bridge that could matter.
>>
>>> +static int stm32_adfsdm_dai_remove(struct snd_soc_dai *dai)
>>> +{
>>> +	dev_dbg(dai->dev, "%s: enter for dai %d\n", __func__, dai->id);
>>> +
>>> +	return 0;
>>> +}
>>
>> Remove empty functions, though in this case I think you want to add
>> something to disconnect the XRUN callback just in order to be sure it
>> can't be mistakenly called.
>>
> 
