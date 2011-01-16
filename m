From: subaparts@yandex.ru (Alexander)
Date: Sun, 16 Jan 2011 15:48:05 +0300
Subject: [PATCH] ASoC: EP93xx: fixed LRCLK rate and DMA oper. in I2S code
In-Reply-To: <20101208124637.GD16418@rakim.wolfsonmicro.main>
References: <1291809693.31916.2.camel@r60e>
	<20101208124637.GD16418@rakim.wolfsonmicro.main>
Message-ID: <1295182085.15631.231.camel@r60e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Sverdlin <subaparts@yandex.ru>

Changelog:
1. I2S module of EP93xx should be feed by 32bit DMA transfers. This is 
hardware limitation and that's the way original Cirrus's driver worked.
This will fix distorted sound playback and make capture actually work in
present ep93xx drivers.

I've found, that author of code, on which modern ep93xx-i2s.c and
ep93xx-pcm.c are based, had faced this problem also in 2007:
http://blog.gmane.org/gmane.linux.ports.arm.cirrus/month=20070101/page=3

Now SoC code uses his developments, but not overcomes the hardware
issues. Some details from EP93xx users guide:

Both I2S transmitter and receiver have similar 16x32bit FIFO, where they
store 8 samples for both left and right channels. The FIFO is always
32bit wide and should be properly aligned if you use samples of other
width. Transmitter and receiver have configuration registers for
selection of I2S word length (16, 24, 32). They are I2STXWrdLen and
I2SRXWrdLen.

Yes, EP93xx DMA can do byte, word and quad-word transfers. The width for
transfers to and from peripherals is selected by particular module
configuration. Lucky AC97 module has such configuration: AC97RXCRx
registers, bit CM (Compact mode enable) switches between 16 and 32 bit
samples. AC97TXCRx registers have the same bits for transmitters.
ep93xx-ac97.c enables this compact mode and so has all the rights to use
S16_LE format.
No one has found such a configuration in I2S module until now in any
Cirrus manuals. I2S module always feeds it's 32bit wide FIFO with 32bit
samples consecutively for left and right channels. You cannot use 32-bit
DMA transfers to transfer two 16-bit samples. 

So we can use two formats for AC97, but should remove all but S32_LE for
I2S. Always using 32 bit chunks is not a problem for I2S, the codec I
use uses less bits too (24), it's permitted by I2S standard.

In proposed patch formats list shortened to just S32_LE, this makes all
the DMA transactions right, while ALSA will do all sample format
translation for us.

2. Incorrect setting of LRCLK (2 times slower) in original ep93xx-i2s.c 
masks the first problem. 

DMA takes two 16 bit samples instead of one, overall sound speed seems
to be normal, but you get actually 4000 sampling rate instead of
requested 8000 and therefore some noise... This is also the reason why
the capture function not worked at all in this driver...

If we take a look into I2S specification, we will figure that LRCLK MUST
be equal to sample rate, if we are talking about stereo (in mono too,
but it's not our case at all).

In proposed patch SCLK and LRCLK rates are corrected, assuming we always
send 32 bits * 2 channels to codec.

Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
---

 sound/soc/ep93xx/ep93xx-i2s.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/ep93xx/ep93xx-i2s.c b/sound/soc/ep93xx/ep93xx-i2s.c
index 4f48733..3e4c3d9 100644
--- a/sound/soc/ep93xx/ep93xx-i2s.c
+++ b/sound/soc/ep93xx/ep93xx-i2s.c
@@ -267,14 +267,16 @@ static int ep93xx_i2s_hw_params(struct snd_pcm_substream *substream,
 		ep93xx_i2s_write_reg(info, EP93XX_I2S_RXWRDLEN, word_len);
 
 	/*
-	 * Calculate the sdiv (bit clock) and lrdiv (left/right clock) values.
-	 * If the lrclk is pulse length is larger than the word size, then the
-	 * bit clock will be gated for the unused bits.
+	 * EP93xx I2S module can be setup so SCLK / LRCLK value can be
+	 * 32, 64, 128. MCLK / SCLK value can be 2 and 4.
+	 * We set LRCLK equal to `rate' and minimum SCLK / LRCLK 
+	 * value is 64, because our sample size is 32 bit * 2 channels.
+	 * I2S standard permits us to transmit more bits than
+	 * the codec uses.
 	 */
-	div = (clk_get_rate(info->mclk) / params_rate(params)) *
-		params_channels(params);
+	div = clk_get_rate(info->mclk) / params_rate(params);
 	for (sdiv = 2; sdiv <= 4; sdiv += 2)
-		for (lrdiv = 32; lrdiv <= 128; lrdiv <<= 1)
+		for (lrdiv = 64; lrdiv <= 128; lrdiv <<= 1)
 			if (sdiv * lrdiv == div) {
 				found = 1;
 				goto out;
@@ -341,9 +343,7 @@ static struct snd_soc_dai_ops ep93xx_i2s_dai_ops = {
 	.set_fmt	= ep93xx_i2s_set_dai_fmt,
 };
 
-#define EP93XX_I2S_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
-			    SNDRV_PCM_FMTBIT_S24_LE | \
-			    SNDRV_PCM_FMTBIT_S32_LE)
+#define EP93XX_I2S_FORMATS (SNDRV_PCM_FMTBIT_S32_LE)
 
 static struct snd_soc_dai_driver ep93xx_i2s_dai = {
 	.symmetric_rates= 1,
