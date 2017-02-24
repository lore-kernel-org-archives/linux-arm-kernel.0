From: hias@horus.com (Matthias Reichl)
Date: Fri, 24 Feb 2017 13:18:32 +0100
Subject: [alsa-devel] [PATCH v8] ASoC: bcm2835: Add 8 channel
 (multitrack) capability
In-Reply-To: <1487746600-11065-1-git-send-email-flatmax@flatmax.org>
References: <1486422576-6958-1-git-send-email-flatmax@flatmax.org>
 <1487746600-11065-1-git-send-email-flatmax@flatmax.org>
Message-ID: <20170224121832.GA19227@camel2.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matt,

please include me in CC, your emails don't seem to get through
linux-rpi-kernel reliably.

I did a few tests with WM5102 in DSP A mode connected to RPi3
with downstream kernel 4.9.11 plus your patch. wm5102 was configured
as master, cpu<->codec dai_link.dai_fmt =
SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM

Comments are inline.

On Wed, Feb 22, 2017 at 05:56:40PM +1100, Matt Flax wrote:
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
>  sound/soc/bcm/bcm2835-i2s.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
> index 6ba2049..4b5f3f1 100644
> --- a/sound/soc/bcm/bcm2835-i2s.c
> +++ b/sound/soc/bcm/bcm2835-i2s.c
> @@ -296,6 +296,7 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
>  
>  	switch (dev->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>  	case SND_SOC_DAIFMT_I2S:
> +	case SND_SOC_DAIFMT_DSP_A:
>  		data_delay = 1;

In DSP_A mode data_delay should be set to 0. With data_delay = 1
the MSB is transmitted 1 clock cycle too late and the LSB of the
previous sample is received as MSB (i.e. you get loud noise).

See these screenshots, I2S data was 0xF000 (S16_LE format)

data_delay = 1:
http://www.horus.com/~hias/tmp/rpi/bcm2835-dsp-a-delay-1.png

data_delay = 0:
http://www.horus.com/~hias/tmp/rpi/bcm2835-dsp-a-delay-0.png

>  		break;
>  	default:
> @@ -312,6 +313,7 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
>  
>  	switch (params_channels(params)) {
>  	case 2:
> +	case 8:
>  		format = BCM2835_I2S_CH1(format) | BCM2835_I2S_CH2(format);
>  		format |= BCM2835_I2S_CH1(BCM2835_I2S_CHPOS(ch1pos));
>  		format |= BCM2835_I2S_CH2(BCM2835_I2S_CHPOS(ch2pos));
> @@ -526,7 +528,17 @@ static int bcm2835_i2s_startup(struct snd_pcm_substream *substream,
>  	regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_CS_A_REG,
>  			BCM2835_I2S_STBY, BCM2835_I2S_STBY);
>  
> -	return 0;
> +	/* Set the max channels to 8 if the codec is master and
> +	 * we are in DSP A mode. Otherwise only allow 2 channels.
> +	 */
> +	if ((dev->fmt &
> +		(SND_SOC_DAIFMT_MASTER_MASK | SND_SOC_DAIFMT_FORMAT_MASK))
> +			== (SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_DSP_A))
> +		return snd_pcm_hw_constraint_single(substream->runtime,
> +			SNDRV_PCM_HW_PARAM_CHANNELS, 8);

I'm not sure why you are limiting to exactly 8 channels. 2 channels
worked fine here, too. Haven't tested with 4 or 6 channels yet but I
guess any even number of channels should work.

In 8-channel configuration I often got swapped/shifted channels.
Not 100% sure why, but probably because bcm2835 hadn't DMAed the
data in when the codec started the clocks - in that case bcm2835 seems
to repeat the last stereo frame data it had in it's buffer. I haven't
digged into that deeper though, could be something in my test setup as
well.

> +	else
> +		return snd_pcm_hw_constraint_single(substream->runtime,
> +			SNDRV_PCM_HW_PARAM_CHANNELS, 2);
>  }
>  
>  static void bcm2835_i2s_shutdown(struct snd_pcm_substream *substream,
> @@ -549,6 +561,10 @@ static void bcm2835_i2s_shutdown(struct snd_pcm_substream *substream,
>  	 * not stop the clock when SND_SOC_DAIFMT_CONT
>  	 */
>  	bcm2835_i2s_stop_clock(dev);
> +
> +	/* Default to 2 channels */
> +	snd_pcm_hw_constraint_single(substream->runtime,
> +			SNDRV_PCM_HW_PARAM_CHANNELS, 2);
>  }
>  
>  static const struct snd_soc_dai_ops bcm2835_i2s_dai_ops = {
> @@ -576,16 +592,12 @@ static struct snd_soc_dai_driver bcm2835_i2s_dai = {
>  	.name	= "bcm2835-i2s",
>  	.probe	= bcm2835_i2s_dai_probe,
>  	.playback = {
> -		.channels_min = 2,
> -		.channels_max = 2,
>  		.rates =	SNDRV_PCM_RATE_8000_192000,
>  		.formats =	SNDRV_PCM_FMTBIT_S16_LE
>  				| SNDRV_PCM_FMTBIT_S24_LE
>  				| SNDRV_PCM_FMTBIT_S32_LE
>  		},
>  	.capture = {
> -		.channels_min = 2,
> -		.channels_max = 2,
>  		.rates =	SNDRV_PCM_RATE_8000_192000,
>  		.formats =	SNDRV_PCM_FMTBIT_S16_LE
>  				| SNDRV_PCM_FMTBIT_S24_LE

With .channels_max removed I get no alsa PCMs with the downstream
card drivers - "aplay -L" only reported the "null" PCM.

Changing that to .channels_min = 2, .channels_max = 8 brought
back the PCMs.

so long,

Hias
