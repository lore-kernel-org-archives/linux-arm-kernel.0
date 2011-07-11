From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 11 Jul 2011 16:09:31 +0800
Subject: [PATCH 1/1] sgtl5000: fix i2c r/w issue add neglect VDDIO and VDDI=
Message-ID: <mailman.22.1310559558.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

O

This is caused by sgtl5000 using register address step is 2,
and snd-soc-core can't handle this as we expect, so we have to
fill the register cache by reading register out when initialization
instead of providing a default value array.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 sound/soc/codecs/sgtl5000.c |  159 ++++++++++++++-------------------------=
----
 1 files changed, 52 insertions(+), 107 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index ff29380..c29f153 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -33,87 +33,18 @@
 #define SGTL5000_DAP_REG_OFFSET	0x0100
 #define SGTL5000_MAX_REG_OFFSET	0x013A
=20
-/* default value of sgtl5000 registers except DAP */
-static const u16 sgtl5000_regs[SGTL5000_MAX_REG_OFFSET >> 1] =3D  {
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
-static const u16 sgtl5000_dap_regs[] =3D {
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
-};
-
 /* regulator supplies for sgtl5000, VDDD is an optional external supply */
 enum sgtl5000_regulator_supplies {
-	VDDA,
-	VDDIO,
+//	VDDA,
+//	VDDIO,
 	VDDD,
 	SGTL5000_SUPPLY_NUM
 };
=20
 /* vddd is optional supply */
 static const char *supply_names[SGTL5000_SUPPLY_NUM] =3D {
-	"VDDA",
-	"VDDIO",
+//	"VDDA",
+//	"VDDIO",
 	"VDDD"
 };
=20
@@ -780,6 +711,11 @@ static int ldo_regulator_is_enabled(struct regulator_d=
ev *dev)
 	return ldo->enabled;
 }
=20
+/*
+ * enable internal VDDD power supply. Since register
+ * cache not fill yet, we have to use hw_read and write
+ * instead of snd_soc_read and snd_soc_write.
+ */
 static int ldo_regulator_enable(struct regulator_dev *dev)
 {
 	struct ldo_regulator *ldo =3D rdev_get_drvdata(dev);
@@ -797,17 +733,17 @@ static int ldo_regulator_enable(struct regulator_dev =
*dev)
 	ldo->voltage =3D (1600 - reg * 50) * 1000;
=20
 	/* set voltage to register */
-	snd_soc_update_bits(codec, SGTL5000_CHIP_LINREG_CTRL,
-				(0x1 << 4) - 1, reg);
+	codec->write(codec, SGTL5000_CHIP_LINREG_CTRL, reg);
=20
-	snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
-				SGTL5000_LINEREG_D_POWERUP,
-				SGTL5000_LINEREG_D_POWERUP);
+	reg =3D codec->hw_read(codec, SGTL5000_CHIP_ANA_POWER);
+	reg |=3D SGTL5000_LINEREG_D_POWERUP;
+	codec->write(codec, SGTL5000_CHIP_ANA_POWER, reg);
=20
+	reg &=3D ~SGTL5000_LINREG_SIMPLE_POWERUP;
 	/* when internal ldo enabled, simple digital power can be disabled */
-	snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
-				SGTL5000_LINREG_SIMPLE_POWERUP,
-				0);
+	codec->write(codec, SGTL5000_CHIP_ANA_POWER, reg);
+
+	udelay(10);
=20
 	ldo->enabled =3D 1;
 	return 0;
@@ -1022,13 +958,11 @@ static int sgtl5000_suspend(struct snd_soc_codec *co=
dec, pm_message_t state)
 static int sgtl5000_restore_regs(struct snd_soc_codec *codec)
 {
 	u16 *cache =3D codec->reg_cache;
-	int i;
-	int regular_regs =3D SGTL5000_CHIP_SHORT_CTRL >> 1;
+	int reg;
+	int step =3D codec->driver->reg_cache_step;
=20
 	/* restore regular registers */
-	for (i =3D 0; i < regular_regs; i++) {
-		int reg =3D i << 1;
-
+	for (reg =3D 0; reg < SGTL5000_CHIP_SHORT_CTRL; reg +=3D step) {
 		/* this regs depends on the others */
 		if (reg =3D=3D SGTL5000_CHIP_ANA_POWER ||
 			reg =3D=3D SGTL5000_CHIP_CLK_CTRL ||
@@ -1037,35 +971,32 @@ static int sgtl5000_restore_regs(struct snd_soc_code=
c *codec)
 			reg =3D=3D SGTL5000_CHIP_CLK_CTRL)
 			continue;
=20
-		snd_soc_write(codec, reg, cache[i]);
+		snd_soc_write(codec, reg, cache[reg]);
 	}
=20
 	/* restore dap registers */
-	for (i =3D SGTL5000_DAP_REG_OFFSET >> 1;
-			i < SGTL5000_MAX_REG_OFFSET >> 1; i++) {
-		int reg =3D i << 1;
-
-		snd_soc_write(codec, reg, cache[i]);
-	}
+	for (reg =3D SGTL5000_DAP_REG_OFFSET;
+			reg < SGTL5000_MAX_REG_OFFSET; reg +=3D step)
+		snd_soc_write(codec, reg, cache[reg]);
=20
 	/*
 	 * restore power and other regs according
 	 * to set_power() and set_clock()
 	 */
 	snd_soc_write(codec, SGTL5000_CHIP_LINREG_CTRL,
-			cache[SGTL5000_CHIP_LINREG_CTRL >> 1]);
+			cache[SGTL5000_CHIP_LINREG_CTRL]);
=20
 	snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER,
-			cache[SGTL5000_CHIP_ANA_POWER >> 1]);
+			cache[SGTL5000_CHIP_ANA_POWER]);
=20
 	snd_soc_write(codec, SGTL5000_CHIP_CLK_CTRL,
-			cache[SGTL5000_CHIP_CLK_CTRL >> 1]);
+			cache[SGTL5000_CHIP_CLK_CTRL]);
=20
 	snd_soc_write(codec, SGTL5000_CHIP_REF_CTRL,
-			cache[SGTL5000_CHIP_REF_CTRL >> 1]);
+			cache[SGTL5000_CHIP_REF_CTRL]);
=20
 	snd_soc_write(codec, SGTL5000_CHIP_LINE_OUT_CTRL,
-			cache[SGTL5000_CHIP_LINE_OUT_CTRL >> 1]);
+			cache[SGTL5000_CHIP_LINE_OUT_CTRL]);
 	return 0;
 }
=20
@@ -1105,12 +1036,12 @@ static int sgtl5000_set_power_regs(struct snd_soc_c=
odec *codec)
 	int vag;
 	struct sgtl5000_priv *sgtl5000 =3D snd_soc_codec_get_drvdata(codec);
=20
-	vdda  =3D regulator_get_voltage(sgtl5000->supplies[VDDA].consumer);
-	vddio =3D regulator_get_voltage(sgtl5000->supplies[VDDIO].consumer);
+//	vdda  =3D regulator_get_voltage(sgtl5000->supplies[VDDA].consumer);
+//	vddio =3D regulator_get_voltage(sgtl5000->supplies[VDDIO].consumer);
 	vddd  =3D regulator_get_voltage(sgtl5000->supplies[VDDD].consumer);
=20
-	vdda  =3D vdda / 1000;
-	vddio =3D vddio / 1000;
+	vdda  =3D 3300;
+	vddio =3D 3300;
 	vddd  =3D vddd / 1000;
=20
 	if (vdda <=3D 0 || vddio <=3D 0 || vddd < 0) {
@@ -1335,6 +1266,22 @@ err_regulator_free:
=20
 }
=20
+static int sgtl5000_fill_reg_cache(struct snd_soc_codec *codec)
+{
+	int reg;
+	int step =3D codec->driver->reg_cache_step;
+	u16 *cache =3D codec->reg_cache;
+
+	for (reg =3D SGTL5000_DAP_REG_OFFSET;
+		reg <=3D SGTL5000_MAX_REG_OFFSET; reg +=3D step)
+		cache[reg] =3D codec->hw_read(codec, reg);
+
+	for (reg =3D 0; reg <=3D SGTL5000_CHIP_SHORT_CTRL; reg +=3D step)
+		cache[reg] =3D codec->hw_read(codec, reg);
+
+	return 0;
+}
+
 static int sgtl5000_probe(struct snd_soc_codec *codec)
 {
 	int ret;
@@ -1351,6 +1298,8 @@ static int sgtl5000_probe(struct snd_soc_codec *codec=
)
 	if (ret)
 		return ret;
=20
+	sgtl5000_fill_reg_cache(codec);
+
 	/* power up sgtl5000 */
 	ret =3D sgtl5000_set_power_regs(codec);
 	if (ret)
@@ -1443,10 +1392,9 @@ static struct snd_soc_codec_driver sgtl5000_driver =
=3D {
 	.suspend =3D sgtl5000_suspend,
 	.resume =3D sgtl5000_resume,
 	.set_bias_level =3D sgtl5000_set_bias_level,
-	.reg_cache_size =3D ARRAY_SIZE(sgtl5000_regs),
+	.reg_cache_size =3D SGTL5000_MAX_REG_OFFSET,
 	.reg_word_size =3D sizeof(u16),
 	.reg_cache_step =3D 2,
-	.reg_cache_default =3D sgtl5000_regs,
 	.volatile_register =3D sgtl5000_volatile_register,
 };
=20
@@ -1466,9 +1414,6 @@ static __devinit int sgtl5000_i2c_probe(struct i2c_cl=
ient *client,
 	 * at init phase makes life easy.
 	 * FIXME: should we drop 'const' of sgtl5000_regs?
 	 */
-	memcpy((void *)(&sgtl5000_regs[0] + (SGTL5000_DAP_REG_OFFSET >> 1)),
-			sgtl5000_dap_regs,
-			SGTL5000_MAX_REG_OFFSET - SGTL5000_DAP_REG_OFFSET);
=20
 	i2c_set_clientdata(client, sgtl5000);
=20
--=20
1.7.0.4
