From: flatmax@flatmax.org (Matt Flax)
Date: Wed, 22 Feb 2017 16:20:46 +1100
Subject: [PATCH v5] ASoC: bcm2835: Add 8 channel (multitrack) capability
In-Reply-To: <1487740713-27093-1-git-send-email-flatmax@flatmax.org>
References: <1486422576-6958-1-git-send-email-flatmax@flatmax.org>
 <1487740713-27093-1-git-send-email-flatmax@flatmax.org>
Message-ID: <2e48fe6c-0229-3ea3-d957-c3be03b14d16@flatmax.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch doesn't include the update, I will resend as v6


On 22/02/17 16:18, Matt Flax wrote:
> This patch adds multitrack capability if in DSP mode A and the
> codec is master.
>
> In bcm2835_i2s_startup, snd_pcm_hw_constraint_single is used to set
> channels to 8 if both SND_SOC_DAIFMT_CBM_CFM and SND_SOC_DAIFMT_DSP_A
> are set. Otherwise, channels are set to 2. These settings are
> accomplished using the SNDRV_PCM_HW_PARAM_CHANNELS variable.
>
> In bcm2835_i2s_shutdown the channels are set to 2 by default.
>
> In bcm2835_i2s_hw_params, DSP mode A format is now an option.
> Before replicating the format variable (from ch2 to ch1) for
> register loading, requested channels are checked to be either 2 or 8.
> This can be expanded later to accomodate other channel counts if
> supported by the sound card hardware.
>
> Signed-off-by: Matt Flax <flatmax@flatmax.org>
> ---
>   sound/soc/bcm/bcm2835-i2s.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
> index 6ba2049..300516d 100644
> --- a/sound/soc/bcm/bcm2835-i2s.c
> +++ b/sound/soc/bcm/bcm2835-i2s.c
> @@ -296,6 +296,7 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
>   
>   	switch (dev->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>   	case SND_SOC_DAIFMT_I2S:
> +	case SND_SOC_DAIFMT_DSP_A:
>   		data_delay = 1;
>   		break;
>   	default:
> @@ -312,6 +313,7 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
>   
>   	switch (params_channels(params)) {
>   	case 2:
> +	case 8:
>   		format = BCM2835_I2S_CH1(format) | BCM2835_I2S_CH2(format);
>   		format |= BCM2835_I2S_CH1(BCM2835_I2S_CHPOS(ch1pos));
>   		format |= BCM2835_I2S_CH2(BCM2835_I2S_CHPOS(ch2pos));
> @@ -526,7 +528,16 @@ static int bcm2835_i2s_startup(struct snd_pcm_substream *substream,
>   	regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_CS_A_REG,
>   			BCM2835_I2S_STBY, BCM2835_I2S_STBY);
>   
> -	return 0;
> +	/* Set the max channels to 8 if the codec is master and
> +	 * we are in DSP A mode. Otherwise only allow 2 channels.
> +	 */
> +	if (dev->fmt &
> +		(SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_DSP_A))
> +		return snd_pcm_hw_constraint_single(substream->runtime,
> +			SNDRV_PCM_HW_PARAM_CHANNELS, 8);
> +	else
> +		return snd_pcm_hw_constraint_single(substream->runtime,
> +			SNDRV_PCM_HW_PARAM_CHANNELS, 2);
>   }
>   
>   static void bcm2835_i2s_shutdown(struct snd_pcm_substream *substream,
> @@ -549,6 +560,10 @@ static void bcm2835_i2s_shutdown(struct snd_pcm_substream *substream,
>   	 * not stop the clock when SND_SOC_DAIFMT_CONT
>   	 */
>   	bcm2835_i2s_stop_clock(dev);
> +
> +	/* Default to 2 channels */
> +	snd_pcm_hw_constraint_single(substream->runtime,
> +			SNDRV_PCM_HW_PARAM_CHANNELS, 2);
>   }
>   
>   static const struct snd_soc_dai_ops bcm2835_i2s_dai_ops = {
> @@ -576,16 +591,12 @@ static struct snd_soc_dai_driver bcm2835_i2s_dai = {
>   	.name	= "bcm2835-i2s",
>   	.probe	= bcm2835_i2s_dai_probe,
>   	.playback = {
> -		.channels_min = 2,
> -		.channels_max = 2,
>   		.rates =	SNDRV_PCM_RATE_8000_192000,
>   		.formats =	SNDRV_PCM_FMTBIT_S16_LE
>   				| SNDRV_PCM_FMTBIT_S24_LE
>   				| SNDRV_PCM_FMTBIT_S32_LE
>   		},
>   	.capture = {
> -		.channels_min = 2,
> -		.channels_max = 2,
>   		.rates =	SNDRV_PCM_RATE_8000_192000,
>   		.formats =	SNDRV_PCM_FMTBIT_S16_LE
>   				| SNDRV_PCM_FMTBIT_S24_LE
