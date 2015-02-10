From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 10 Feb 2015 13:16:55 +0800
Subject: [PATCH v3] ASoC: atmel_ssc_dai: Allow more rates
In-Reply-To: <1423494505-3368-1-git-send-email-peda@lysator.liu.se>
References: <1423494505-3368-1-git-send-email-peda@lysator.liu.se>
Message-ID: <54D99447.3090906@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 02/09/2015 11:08 PM, Peter Rosin wrote:
> From: Peter Rosin <peda@axentia.se>
>
> When the SSC acts as BCK master, use a ratnum rule to limit
> the rate instead of only doing the standard rates. When the SSC
> acts as BCK slave, allow any BCK frequency up to the SSC master
> clock, divided by either of 2, 3 or 6.
>
> Put a cap at 384kHz. Who's /ever/ going to need more than that?
>
> The divider of 2, 3 or 6 is selected based on the Serial Clock Ratio
> Considerations section from the SSC documentation:
>
>      The Transmitter and the Receiver can be programmed to operate
>      with the clock signals provided on either the TK or RK pins.
>      This allows the SSC to support many slave-mode data transfers.
>      In this case, the maximum clock speed allowed on the RK pin is:
>      - Peripheral clock divided by 2 if Receiver Frame Synchro is input
>      - Peripheral clock divided by 3 if Receiver Frame Synchro is output
>      In addition, the maximum clock speed allowed on the TK pin is:
>      - Peripheral clock divided by 6 if Transmit Frame Synchro is input
>      - Peripheral clock divided by 2 if Transmit Frame Synchro is output
>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Thanks for your patch.

Acked-by: Bo Shen <voice.shen@atmel.com>

> ---
>   sound/soc/atmel/atmel_ssc_dai.c |  111 +++++++++++++++++++++++++++++++++++++--
>   sound/soc/atmel/atmel_ssc_dai.h |    1 +
>   2 files changed, 108 insertions(+), 4 deletions(-)
>
> Changes since v2:
>
> - Killed the 500ppm reduction. Just trust the nominal clock
>    rates of the given clocks.
>
> - Don't multiply the given SSC clk rate by two to get to the
>    SSC master clock rate. That factor was the result of some
>    confusion on my part. The SSC clk *is* the SSC master clock.
>
> Changes since v1:
>
> - I have checked all Atmel datasheets I could get my hands on (and
>    that seemed relevant), and in every instance where they have
>    described the SSC, the description have the exact rate limitations
>    on the RK and TK pin that I have implemented here.
>
> - Improved the comments.
>
> - Rebased on top of the latest patches from Bo Chen.
>
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index 379ac2a6ab16..6b8e64899205 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -187,6 +187,94 @@ static irqreturn_t atmel_ssc_interrupt(int irq, void *dev_id)
>   	return IRQ_HANDLED;
>   }
>
> +/*
> + * When the bit clock is input, limit the maximum rate according to the
> + * Serial Clock Ratio Considerations section from the SSC documentation:
> + *
> + *   The Transmitter and the Receiver can be programmed to operate
> + *   with the clock signals provided on either the TK or RK pins.
> + *   This allows the SSC to support many slave-mode data transfers.
> + *   In this case, the maximum clock speed allowed on the RK pin is:
> + *   - Peripheral clock divided by 2 if Receiver Frame Synchro is input
> + *   - Peripheral clock divided by 3 if Receiver Frame Synchro is output
> + *   In addition, the maximum clock speed allowed on the TK pin is:
> + *   - Peripheral clock divided by 6 if Transmit Frame Synchro is input
> + *   - Peripheral clock divided by 2 if Transmit Frame Synchro is output
> + *
> + * When the bit clock is output, limit the rate according to the
> + * SSC divider restrictions.
> + */
> +static int atmel_ssc_hw_rule_rate(struct snd_pcm_hw_params *params,
> +				  struct snd_pcm_hw_rule *rule)
> +{
> +	struct atmel_ssc_info *ssc_p = rule->private;
> +	struct ssc_device *ssc = ssc_p->ssc;
> +	struct snd_interval *i = hw_param_interval(params, rule->var);
> +	struct snd_interval t;
> +	struct snd_ratnum r = {
> +		.den_min = 1,
> +		.den_max = 4095,
> +		.den_step = 1,
> +	};
> +	unsigned int num = 0, den = 0;
> +	int frame_size;
> +	int mck_div = 2;
> +	int ret;
> +
> +	frame_size = snd_soc_params_to_frame_size(params);
> +	if (frame_size < 0)
> +		return frame_size;
> +
> +	switch (ssc_p->daifmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFS:
> +		if ((ssc_p->dir_mask & SSC_DIR_MASK_CAPTURE)
> +		    && ssc->clk_from_rk_pin)
> +			/* Receiver Frame Synchro (i.e. capture)
> +			 * is output (format is _CFS) and the RK pin
> +			 * is used for input (format is _CBM_).
> +			 */
> +			mck_div = 3;
> +		break;
> +
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		if ((ssc_p->dir_mask & SSC_DIR_MASK_PLAYBACK)
> +		    && !ssc->clk_from_rk_pin)
> +			/* Transmit Frame Synchro (i.e. playback)
> +			 * is input (format is _CFM) and the TK pin
> +			 * is used for input (format _CBM_ but not
> +			 * using the RK pin).
> +			 */
> +			mck_div = 6;
> +		break;
> +	}
> +
> +	switch (ssc_p->daifmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		r.num = ssc_p->mck_rate / mck_div / frame_size;
> +
> +		ret = snd_interval_ratnum(i, 1, &r, &num, &den);
> +		if (ret >= 0 && den && rule->var == SNDRV_PCM_HW_PARAM_RATE) {
> +			params->rate_num = num;
> +			params->rate_den = den;
> +		}
> +		break;
> +
> +	case SND_SOC_DAIFMT_CBM_CFS:
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		t.min = 8000;
> +		t.max = ssc_p->mck_rate / mck_div / frame_size;
> +		t.openmin = t.openmax = 0;
> +		t.integer = 0;
> +		ret = snd_interval_refine(i, &t);
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
>
>   /*-------------------------------------------------------------------------*\
>    * DAI functions
> @@ -200,6 +288,7 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
>   	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
>   	struct atmel_pcm_dma_params *dma_params;
>   	int dir, dir_mask;
> +	int ret;
>
>   	pr_debug("atmel_ssc_startup: SSC_SR=0x%u\n",
>   		ssc_readl(ssc_p->ssc->regs, SR));
> @@ -207,6 +296,7 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
>   	/* Enable PMC peripheral clock for this SSC */
>   	pr_debug("atmel_ssc_dai: Starting clock\n");
>   	clk_enable(ssc_p->ssc->clk);
> +	ssc_p->mck_rate = clk_get_rate(ssc_p->ssc->clk);
>
>   	/* Reset the SSC to keep it at a clean status */
>   	ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
> @@ -219,6 +309,17 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
>   		dir_mask = SSC_DIR_MASK_CAPTURE;
>   	}
>
> +	ret = snd_pcm_hw_rule_add(substream->runtime, 0,
> +				  SNDRV_PCM_HW_PARAM_RATE,
> +				  atmel_ssc_hw_rule_rate,
> +				  ssc_p,
> +				  SNDRV_PCM_HW_PARAM_FRAME_BITS,
> +				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
> +	if (ret < 0) {
> +		dev_err(dai->dev, "Failed to specify rate rule: %d\n", ret);
> +		return ret;
> +	}
> +
>   	dma_params = &ssc_dma_params[dai->id][dir];
>   	dma_params->ssc = ssc_p->ssc;
>   	dma_params->substream = substream;
> @@ -783,8 +884,6 @@ static int atmel_ssc_resume(struct snd_soc_dai *cpu_dai)
>   #  define atmel_ssc_resume	NULL
>   #endif /* CONFIG_PM */
>
> -#define ATMEL_SSC_RATES (SNDRV_PCM_RATE_8000_96000)
> -
>   #define ATMEL_SSC_FORMATS (SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_S16_LE |\
>   			  SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
>
> @@ -804,12 +903,16 @@ static struct snd_soc_dai_driver atmel_ssc_dai = {
>   		.playback = {
>   			.channels_min = 1,
>   			.channels_max = 2,
> -			.rates = ATMEL_SSC_RATES,
> +			.rates = SNDRV_PCM_RATE_CONTINUOUS,
> +			.rate_min = 8000,
> +			.rate_max = 384000,
>   			.formats = ATMEL_SSC_FORMATS,},
>   		.capture = {
>   			.channels_min = 1,
>   			.channels_max = 2,
> -			.rates = ATMEL_SSC_RATES,
> +			.rates = SNDRV_PCM_RATE_CONTINUOUS,
> +			.rate_min = 8000,
> +			.rate_max = 384000,
>   			.formats = ATMEL_SSC_FORMATS,},
>   		.ops = &atmel_ssc_dai_ops,
>   };
> diff --git a/sound/soc/atmel/atmel_ssc_dai.h b/sound/soc/atmel/atmel_ssc_dai.h
> index b1f08d511495..80b153857a88 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.h
> +++ b/sound/soc/atmel/atmel_ssc_dai.h
> @@ -115,6 +115,7 @@ struct atmel_ssc_info {
>   	unsigned short rcmr_period;
>   	struct atmel_pcm_dma_params *dma_params[2];
>   	struct atmel_ssc_state ssc_state;
> +	unsigned long mck_rate;
>   };
>
>   int atmel_ssc_set_audio(int ssc_id);
>

Best Regards,
Bo Shen
