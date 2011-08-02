From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 2 Aug 2011 11:51:41 +0200
Subject: [PATCH 1/1] ASoC: core: cache index fix
In-Reply-To: <20110802083850.GB9553@opensource.wolfsonmicro.com>
References: <1312198690-13237-1-git-send-email-b29396@freescale.com>
	<20110801115150.GB16629@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721F410B@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110802083850.GB9553@opensource.wolfsonmicro.com>
Message-ID: <20110802095141.GA2095@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> It occurs to me that what we want to do here may be to make a new
> register cache type for step sizes then hide all the complexity for
> these devices in there.  That keeps everything together and ensures that
> newer devices don't pay a complexity cost.
> 
> For the register default tables it's probably sensible to just pad them
> out with the zero registers; it'll cost a little space but not too much.

So, do I get it right, that my initial patch (attached below again)
might be interesting after all, because it makes the register layout
truly flat (also makes the driver usable for me). Then, based on that, a
new cache type which takes step size into account could be added to the
soc-core and the codec driver can be later switched to the new cache
type?

Regards,

   Wolfram

From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 3/3] ASoC: sgtl5000: fix cache handling

Cache handling in this driver is seriously broken. The chip has 16-bit
registers, yet their register numbering also increases by 2 per register, i.e.
there are only even-numbered registers. The default cache in this driver,
though, simply increments register numbers, so it does need some mapping as
seen in sgtl5000_restore_regs(), note the '>> 1':

	snd_soc_write(codec, SGTL5000_CHIP_LINREG_CTRL,
                        cache[SGTL5000_CHIP_LINREG_CTRL >> 1]);

That, of course, won't work with snd_soc_update_bits(). (Thus, we won't even
notice the missing register 0x1c in the default regs which shifted all follwing
registers to wrong values.) Noticed on the MX28EVK where enabling the regulators
simply locked up the chip.

Refactor the routines and use a properly sized default_regs array which matches
the register layout of the underlying chip. Also saves some code which should
make up for the bigger array a little.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Dong Aisheng <b29396@freescale.com>
Cc: Zeng Zhaoming <b32542@freescale.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/sgtl5000.c |  128 ++++++++++++-------------------------------
 1 files changed, 35 insertions(+), 93 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 76258f2..7e4066e 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -33,73 +33,31 @@
 #define SGTL5000_DAP_REG_OFFSET	0x0100
 #define SGTL5000_MAX_REG_OFFSET	0x013A
 
-/* default value of sgtl5000 registers except DAP */
-static const u16 sgtl5000_regs[SGTL5000_MAX_REG_OFFSET >> 1] =  {
-	0xa011, /* 0x0000, CHIP_ID. 11 stand for revison 17 */
-	0x0000, /* 0x0002, CHIP_DIG_POWER. */
-	0x0008, /* 0x0004, CHIP_CKL_CTRL */
-	0x0010, /* 0x0006, CHIP_I2S_CTRL */
-	0x0000, /* 0x0008, reserved */
-	0x0008, /* 0x000A, CHIP_SSS_CTRL */
-	0x0000, /* 0x000C, reserved */
-	0x020c, /* 0x000E, CHIP_ADCDAC_CTRL */
-	0x3c3c, /* 0x0010, CHIP_DAC_VOL */
-	0x0000, /* 0x0012, reserved */
-	0x015f, /* 0x0014, CHIP_PAD_STRENGTH */
-	0x0000, /* 0x0016, reserved */
-	0x0000, /* 0x0018, reserved */
-	0x0000, /* 0x001A, reserved */
-	0x0000, /* 0x001E, reserved */
-	0x0000, /* 0x0020, CHIP_ANA_ADC_CTRL */
-	0x1818, /* 0x0022, CHIP_ANA_HP_CTRL */
-	0x0111, /* 0x0024, CHIP_ANN_CTRL */
-	0x0000, /* 0x0026, CHIP_LINREG_CTRL */
-	0x0000, /* 0x0028, CHIP_REF_CTRL */
-	0x0000, /* 0x002A, CHIP_MIC_CTRL */
-	0x0000, /* 0x002C, CHIP_LINE_OUT_CTRL */
-	0x0404, /* 0x002E, CHIP_LINE_OUT_VOL */
-	0x7060, /* 0x0030, CHIP_ANA_POWER */
-	0x5000, /* 0x0032, CHIP_PLL_CTRL */
-	0x0000, /* 0x0034, CHIP_CLK_TOP_CTRL */
-	0x0000, /* 0x0036, CHIP_ANA_STATUS */
-	0x0000, /* 0x0038, reserved */
-	0x0000, /* 0x003A, CHIP_ANA_TEST2 */
-	0x0000, /* 0x003C, CHIP_SHORT_CTRL */
-	0x0000, /* reserved */
-};
-
-/* default value of dap registers */
-static const u16 sgtl5000_dap_regs[] = {
-	0x0000, /* 0x0100, DAP_CONTROL */
-	0x0000, /* 0x0102, DAP_PEQ */
-	0x0040, /* 0x0104, DAP_BASS_ENHANCE */
-	0x051f, /* 0x0106, DAP_BASS_ENHANCE_CTRL */
-	0x0000, /* 0x0108, DAP_AUDIO_EQ */
-	0x0040, /* 0x010A, DAP_SGTL_SURROUND */
-	0x0000, /* 0x010C, DAP_FILTER_COEF_ACCESS */
-	0x0000, /* 0x010E, DAP_COEF_WR_B0_MSB */
-	0x0000, /* 0x0110, DAP_COEF_WR_B0_LSB */
-	0x0000, /* 0x0112, reserved */
-	0x0000, /* 0x0114, reserved */
-	0x002f, /* 0x0116, DAP_AUDIO_EQ_BASS_BAND0 */
-	0x002f, /* 0x0118, DAP_AUDIO_EQ_BAND0 */
-	0x002f, /* 0x011A, DAP_AUDIO_EQ_BAND2 */
-	0x002f, /* 0x011C, DAP_AUDIO_EQ_BAND3 */
-	0x002f, /* 0x011E, DAP_AUDIO_EQ_TREBLE_BAND4 */
-	0x8000, /* 0x0120, DAP_MAIN_CHAN */
-	0x0000, /* 0x0122, DAP_MIX_CHAN */
-	0x0510, /* 0x0124, DAP_AVC_CTRL */
-	0x1473, /* 0x0126, DAP_AVC_THRESHOLD */
-	0x0028, /* 0x0128, DAP_AVC_ATTACK */
-	0x0050, /* 0x012A, DAP_AVC_DECAY */
-	0x0000, /* 0x012C, DAP_COEF_WR_B1_MSB */
-	0x0000, /* 0x012E, DAP_COEF_WR_B1_LSB */
-	0x0000, /* 0x0130, DAP_COEF_WR_B2_MSB */
-	0x0000, /* 0x0132, DAP_COEF_WR_B2_LSB */
-	0x0000, /* 0x0134, DAP_COEF_WR_A1_MSB */
-	0x0000, /* 0x0136, DAP_COEF_WR_A1_LSB */
-	0x0000, /* 0x0138, DAP_COEF_WR_A2_MSB */
-	0x0000, /* 0x013A, DAP_COEF_WR_A2_LSB */
+/* default value of sgtl5000 registers */
+static const u16 sgtl5000_regs[SGTL5000_MAX_REG_OFFSET] =  {
+	[SGTL5000_CHIP_CLK_CTRL] = 0x0008,
+	[SGTL5000_CHIP_I2S_CTRL] = 0x0010,
+	[SGTL5000_CHIP_SSS_CTRL] = 0x0008,
+	[SGTL5000_CHIP_DAC_VOL] = 0x3c3c,
+	[SGTL5000_CHIP_PAD_STRENGTH] = 0x015f,
+	[SGTL5000_CHIP_ANA_HP_CTRL] = 0x1818,
+	[SGTL5000_CHIP_ANA_CTRL] = 0x0111,
+	[SGTL5000_CHIP_LINE_OUT_VOL] = 0x0404,
+	[SGTL5000_CHIP_ANA_POWER] = 0x7060,
+	[SGTL5000_CHIP_PLL_CTRL] = 0x5000,
+	[SGTL5000_DAP_BASS_ENHANCE] = 0x0040,
+	[SGTL5000_DAP_BASS_ENHANCE_CTRL] = 0x051f,
+	[SGTL5000_DAP_SURROUND] = 0x0040,
+	[SGTL5000_DAP_EQ_BASS_BAND0] = 0x002f,
+	[SGTL5000_DAP_EQ_BASS_BAND1] = 0x002f,
+	[SGTL5000_DAP_EQ_BASS_BAND2] = 0x002f,
+	[SGTL5000_DAP_EQ_BASS_BAND3] = 0x002f,
+	[SGTL5000_DAP_EQ_BASS_BAND4] = 0x002f,
+	[SGTL5000_DAP_MAIN_CHAN] = 0x8000,
+	[SGTL5000_DAP_AVC_CTRL] = 0x0510,
+	[SGTL5000_DAP_AVC_THRESHOLD] = 0x1473,
+	[SGTL5000_DAP_AVC_ATTACK] = 0x0028,
+	[SGTL5000_DAP_AVC_DECAY] = 0x0050,
 };
 
 /* regulator supplies for sgtl5000, VDDD is an optional external supply */
@@ -1023,12 +981,10 @@ static int sgtl5000_suspend(struct snd_soc_codec *codec, pm_message_t state)
 static int sgtl5000_restore_regs(struct snd_soc_codec *codec)
 {
 	u16 *cache = codec->reg_cache;
-	int i;
-	int regular_regs = SGTL5000_CHIP_SHORT_CTRL >> 1;
+	u16 reg;
 
 	/* restore regular registers */
-	for (i = 0; i < regular_regs; i++) {
-		int reg = i << 1;
+	for (reg = 0; reg <= SGTL5000_CHIP_SHORT_CTRL; reg += 2) {
 
 		/* this regs depends on the others */
 		if (reg == SGTL5000_CHIP_ANA_POWER ||
@@ -1038,35 +994,31 @@ static int sgtl5000_restore_regs(struct snd_soc_codec *codec)
 			reg == SGTL5000_CHIP_CLK_CTRL)
 			continue;
 
-		snd_soc_write(codec, reg, cache[i]);
+		snd_soc_write(codec, reg, cache[reg]);
 	}
 
 	/* restore dap registers */
-	for (i = SGTL5000_DAP_REG_OFFSET >> 1;
-			i < SGTL5000_MAX_REG_OFFSET >> 1; i++) {
-		int reg = i << 1;
-
-		snd_soc_write(codec, reg, cache[i]);
-	}
+	for (reg = SGTL5000_DAP_REG_OFFSET; reg < SGTL5000_MAX_REG_OFFSET; reg += 2)
+		snd_soc_write(codec, reg, cache[reg]);
 
 	/*
 	 * restore power and other regs according
 	 * to set_power() and set_clock()
 	 */
 	snd_soc_write(codec, SGTL5000_CHIP_LINREG_CTRL,
-			cache[SGTL5000_CHIP_LINREG_CTRL >> 1]);
+			cache[SGTL5000_CHIP_LINREG_CTRL]);
 
 	snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER,
-			cache[SGTL5000_CHIP_ANA_POWER >> 1]);
+			cache[SGTL5000_CHIP_ANA_POWER]);
 
 	snd_soc_write(codec, SGTL5000_CHIP_CLK_CTRL,
-			cache[SGTL5000_CHIP_CLK_CTRL >> 1]);
+			cache[SGTL5000_CHIP_CLK_CTRL]);
 
 	snd_soc_write(codec, SGTL5000_CHIP_REF_CTRL,
-			cache[SGTL5000_CHIP_REF_CTRL >> 1]);
+			cache[SGTL5000_CHIP_REF_CTRL]);
 
 	snd_soc_write(codec, SGTL5000_CHIP_LINE_OUT_CTRL,
-			cache[SGTL5000_CHIP_LINE_OUT_CTRL >> 1]);
+			cache[SGTL5000_CHIP_LINE_OUT_CTRL]);
 	return 0;
 }
 
@@ -1454,16 +1406,6 @@ static __devinit int sgtl5000_i2c_probe(struct i2c_client *client,
 	if (!sgtl5000)
 		return -ENOMEM;
 
-	/*
-	 * copy DAP default values to default value array.
-	 * sgtl5000 register space has a big hole, merge it
-	 * at init phase makes life easy.
-	 * FIXME: should we drop 'const' of sgtl5000_regs?
-	 */
-	memcpy((void *)(&sgtl5000_regs[0] + (SGTL5000_DAP_REG_OFFSET >> 1)),
-			sgtl5000_dap_regs,
-			SGTL5000_MAX_REG_OFFSET - SGTL5000_DAP_REG_OFFSET);
-
 	i2c_set_clientdata(client, sgtl5000);
 
 	ret = snd_soc_register_codec(&client->dev,

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110802/2e5dc5cd/attachment.sig>
