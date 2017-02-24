From: hias@horus.com (Matthias Reichl)
Date: Fri, 24 Feb 2017 21:25:53 +0100
Subject: [alsa-devel] [PATCH v8] ASoC: bcm2835: Add 8 channel
 (multitrack) capability
In-Reply-To: <3b693ff9-b3a6-1c10-5b1a-78be04006113@flatmax.org>
References: <1486422576-6958-1-git-send-email-flatmax@flatmax.org>
 <1487746600-11065-1-git-send-email-flatmax@flatmax.org>
 <20170224121832.GA19227@camel2.lan>
 <3b693ff9-b3a6-1c10-5b1a-78be04006113@flatmax.org>
Message-ID: <20170224202553.GA28529@camel2.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 25, 2017 at 12:50:47AM +1100, Matt Flax wrote:
> 
> 
> On 24/02/17 23:18, Matthias Reichl wrote:
> >Hi Matt,
> >
> >please include me in CC, your emails don't seem to get through
> >linux-rpi-kernel reliably.
> >
> >I did a few tests with WM5102 in DSP A mode connected to RPi3
> >with downstream kernel 4.9.11 plus your patch. wm5102 was configured
> >as master, cpu<->codec dai_link.dai_fmt =
> >SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM
> >
> >Comments are inline.
> 
> Sure will do, thanks for testing. My comments are also inline.
> 
> >
> >On Wed, Feb 22, 2017 at 05:56:40PM +1100, Matt Flax wrote:
> >>This patch adds multitrack capability if in DSP mode A and the
> >>codec is master.
> >>
> >>In bcm2835_i2s_startup, snd_pcm_hw_constraint_single is used to set
> >>channels to 8 if both SND_SOC_DAIFMT_CBM_CFM and SND_SOC_DAIFMT_DSP_A
> >>are set. Otherwise, channels are set to 2. These settings are
> >>accomplished using the SNDRV_PCM_HW_PARAM_CHANNELS variable.
> >>
> >>In bcm2835_i2s_shutdown the channels are set to 2 by default.
> >>
> >>In bcm2835_i2s_hw_params, DSP mode A format is now an option.
> >>Before replicating the format variable (from ch2 to ch1) for
> >>register loading, requested channels are checked to be either 2 or 8.
> >>This can be expanded later to accomodate other channel counts if
> >>supported by the sound card hardware.
> >>
> >>Signed-off-by: Matt Flax <flatmax@flatmax.org>
> >>---
> >>  sound/soc/bcm/bcm2835-i2s.c | 22 +++++++++++++++++-----
> >>  1 file changed, 17 insertions(+), 5 deletions(-)
> >>
> >>diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
> >>index 6ba2049..4b5f3f1 100644
> >>--- a/sound/soc/bcm/bcm2835-i2s.c
> >>+++ b/sound/soc/bcm/bcm2835-i2s.c
> >>@@ -296,6 +296,7 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
> >>  	switch (dev->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> >>  	case SND_SOC_DAIFMT_I2S:
> >>+	case SND_SOC_DAIFMT_DSP_A:
> >>  		data_delay = 1;
> >In DSP_A mode data_delay should be set to 0. With data_delay = 1
> >the MSB is transmitted 1 clock cycle too late and the LSB of the
> >previous sample is received as MSB (i.e. you get loud noise).
> >
> >See these screenshots, I2S data was 0xF000 (S16_LE format)
> >
> >data_delay = 1:
> >http://www.horus.com/~hias/tmp/rpi/bcm2835-dsp-a-delay-1.png
> >
> >data_delay = 0:
> >http://www.horus.com/~hias/tmp/rpi/bcm2835-dsp-a-delay-0.png
> 
> I can do this, however that would require DSP mode B to have an offset of
> -1, which can't be set in the BCM2835 position register.

I don't see where you are using mode B - you only added support for
mode A. Not quite sure what you mean with that.

> I really like your approach, however it needs extra resources at the
> hardware level. Without those resources it will never be usable and stable.
> The reason is that you will never be able to get proper synchrony and your
> channels will be randomly shifted. It is the curious nature of the BCM2835
> I2S silicon - I have used an FPGA to overcome this problem.

I don't quite follow you here. DSP mode A timing usually means that
the MSB follows immediately after the 1-cycle LR pulse. Or, if the
pulse is longer than one cycle, MSB starts 1 clk after the leading
LR pulse edge.

With data delay=1 you are using I2S timing, not mode A timing.

> >>  		break;
> >>  	default:
> >>@@ -312,6 +313,7 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
> >>  	switch (params_channels(params)) {
> >>  	case 2:
> >>+	case 8:
> >>  		format = BCM2835_I2S_CH1(format) | BCM2835_I2S_CH2(format);
> >>  		format |= BCM2835_I2S_CH1(BCM2835_I2S_CHPOS(ch1pos));
> >>  		format |= BCM2835_I2S_CH2(BCM2835_I2S_CHPOS(ch2pos));
> >>@@ -526,7 +528,17 @@ static int bcm2835_i2s_startup(struct snd_pcm_substream *substream,
> >>  	regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_CS_A_REG,
> >>  			BCM2835_I2S_STBY, BCM2835_I2S_STBY);
> >>-	return 0;
> >>+	/* Set the max channels to 8 if the codec is master and
> >>+	 * we are in DSP A mode. Otherwise only allow 2 channels.
> >>+	 */
> >>+	if ((dev->fmt &
> >>+		(SND_SOC_DAIFMT_MASTER_MASK | SND_SOC_DAIFMT_FORMAT_MASK))
> >>+			== (SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_DSP_A))
> >>+		return snd_pcm_hw_constraint_single(substream->runtime,
> >>+			SNDRV_PCM_HW_PARAM_CHANNELS, 8);
> >I'm not sure why you are limiting to exactly 8 channels. 2 channels
> >worked fine here, too. Haven't tested with 4 or 6 channels yet but I
> >guess any even number of channels should work.
> >
> >In 8-channel configuration I often got swapped/shifted channels.
> >Not 100% sure why, but probably because bcm2835 hadn't DMAed the
> >data in when the codec started the clocks - in that case bcm2835 seems
> >to repeat the last stereo frame data it had in it's buffer. I haven't
> >digged into that deeper though, could be something in my test setup as
> >well.
> 
> Ah - there you go - I would imagine they are only shifted, not swapped !
> 
> I have a very robust stream, where I never get swapped channels. In other
> words, I find that the channels 1 to 8 are always locked to the correct
> pins.
> 
> Multichannel simply can't be done (on the BCM2835) without a suitable
> FPGA/ASIC/chip between the codec and the BCM2835.

I'd put it in another way: it seems to me that the bcm2835 I2S
won't reliably sync in DSP mode A.

I did some more tests and noticed channel/sample shifts both in
2-channel and in 8-channel DSP mode A. When using 2-channel I2S
mode I never got any channel/sample shifts.

Here are screenshots of 8-channel S16_LE data, first transmitted
sample is 0xf000, then 0xf100, then 0xf200 ... up to 0xf700.

This is the first full frame with data from bcm2835. Before that
the clocks were active for about 1.2ms and bcm2835 transmitted
a low data signal:

http://www.horus.com/~hias/tmp/rpi/bcm2835-dsp-a-8ch-frame1.png

Note that immediately after LR pulse there's not a 0xf000 sample
but 0x0000. The transmitted data doesn't seem to be synced on
sample boundaries at all (i.e. the seem to be bit-shifted),
let alone frame-synced.

Here's the second full frame:

http://www.horus.com/~hias/tmp/rpi/bcm2835-dsp-a-8ch-frame2.png

Note that the first sample is rather odd, MSB isn't 1 but 0
and then a long run of 1 bits follow. About 8us after that
the data sees to be sample-synced.

But also note that at the 3rd frame with data starts with 0xf500,
not 0xf000 as expected. At least the samples are now synced
and MSB occurs on the correct position. Still, the rest of the
stream has the samples/channels shifted by 5.

> 
> >>+	else
> >>+		return snd_pcm_hw_constraint_single(substream->runtime,
> >>+			SNDRV_PCM_HW_PARAM_CHANNELS, 2);
> >>  }
> >>  static void bcm2835_i2s_shutdown(struct snd_pcm_substream *substream,
> >>@@ -549,6 +561,10 @@ static void bcm2835_i2s_shutdown(struct snd_pcm_substream *substream,
> >>  	 * not stop the clock when SND_SOC_DAIFMT_CONT
> >>  	 */
> >>  	bcm2835_i2s_stop_clock(dev);
> >>+
> >>+	/* Default to 2 channels */
> >>+	snd_pcm_hw_constraint_single(substream->runtime,
> >>+			SNDRV_PCM_HW_PARAM_CHANNELS, 2);
> >>  }
> >>  static const struct snd_soc_dai_ops bcm2835_i2s_dai_ops = {
> >>@@ -576,16 +592,12 @@ static struct snd_soc_dai_driver bcm2835_i2s_dai = {
> >>  	.name	= "bcm2835-i2s",
> >>  	.probe	= bcm2835_i2s_dai_probe,
> >>  	.playback = {
> >>-		.channels_min = 2,
> >>-		.channels_max = 2,
> >>  		.rates =	SNDRV_PCM_RATE_8000_192000,
> >>  		.formats =	SNDRV_PCM_FMTBIT_S16_LE
> >>  				| SNDRV_PCM_FMTBIT_S24_LE
> >>  				| SNDRV_PCM_FMTBIT_S32_LE
> >>  		},
> >>  	.capture = {
> >>-		.channels_min = 2,
> >>-		.channels_max = 2,
> >>  		.rates =	SNDRV_PCM_RATE_8000_192000,
> >>  		.formats =	SNDRV_PCM_FMTBIT_S16_LE
> >>  				| SNDRV_PCM_FMTBIT_S24_LE
> >With .channels_max removed I get no alsa PCMs with the downstream
> >card drivers - "aplay -L" only reported the "null" PCM.
> >
> >Changing that to .channels_min = 2, .channels_max = 8 brought
> >back the PCMs.
> >
> >
> That is curious, channels_max and channels_min are set in _startup
> implicitly in the snd_pcm_hw_constraint_single call which is inlined to the
> snd_pcm_hw_constraint_minmax call.
> 
> I have tested with an Audio Injector stereo card for the Pi ... I can
> confirm this problem. I will look into it further.
> 
> Can anyone explain why this would happen ?
> 
> Matt
> 
