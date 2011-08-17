From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 17 Aug 2011 21:29:12 +0800
Subject: [PATCH 1/1] sgtl5000: fix record unwork issue
Message-ID: <mailman.99.1314184109.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 sound/soc/codecs/sgtl5000.c |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 5a0d8e4..ef52890 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -198,13 +198,13 @@ static int small_pop_event(struct snd_soc_dapm_widget=
 *w,
 {
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
-			SGTL5000_VAG_POWERUP, SGTL5000_VAG_POWERUP);
+//		snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
+//			SGTL5000_VAG_POWERUP, SGTL5000_VAG_POWERUP);
 		break;
=20
 	case SND_SOC_DAPM_PRE_PMD:
-		snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
-			SGTL5000_VAG_POWERUP, 0);
+//		snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
+//			SGTL5000_VAG_POWERUP, 0);
 		msleep(400);
 		break;
 	default:
@@ -1153,11 +1153,13 @@ static int sgtl5000_set_power_regs(struct snd_soc_c=
odec *codec)
 				SGTL5000_VDDC_CHRGPMP_POWERUP, 0);
=20
 		/* VDDC use VDDIO rail */
-		lreg_ctrl |=3D SGTL5000_VDDC_ASSN_OVRD;
-		lreg_ctrl |=3D SGTL5000_VDDC_MAN_ASSN_VDDIO <<
-			    SGTL5000_VDDC_MAN_ASSN_SHIFT;
+//		lreg_ctrl |=3D SGTL5000_VDDC_ASSN_OVRD;
+//		lreg_ctrl |=3D SGTL5000_VDDC_MAN_ASSN_VDDIO <<
+//			    SGTL5000_VDDC_MAN_ASSN_SHIFT;
 	}
=20
+//	ana_pwr |=3D SGTL5000_VDDC_CHRGPMP_POWERUP | SGTL5000_VAG_POWERUP | SGT=
L5000_HP_POWERUP;
+	ana_pwr |=3D 0x5afb;
 	snd_soc_write(codec, SGTL5000_CHIP_LINREG_CTRL, lreg_ctrl);
=20
 	snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER, ana_pwr);
@@ -1194,9 +1196,9 @@ static int sgtl5000_set_power_regs(struct snd_soc_cod=
ec *codec)
 	else
 		vag =3D (vag - SGTL5000_ANA_GND_BASE) / SGTL5000_ANA_GND_STP;
=20
-	snd_soc_update_bits(codec, SGTL5000_CHIP_REF_CTRL,
-			vag << SGTL5000_ANA_GND_SHIFT,
-			vag << SGTL5000_ANA_GND_SHIFT);
+//	snd_soc_update_bits(codec, SGTL5000_CHIP_REF_CTRL,
+//			vag << SGTL5000_ANA_GND_SHIFT,
+///			vag << SGTL5000_ANA_GND_SHIFT);
=20
 	/* set line out VAG to vddio / 2, in range (0.8v, 1.675v) */
 	vag =3D vddio / 2;
@@ -1208,14 +1210,15 @@ static int sgtl5000_set_power_regs(struct snd_soc_c=
odec *codec)
 	else
 		vag =3D (vag - SGTL5000_LINE_OUT_GND_BASE) /
 		    SGTL5000_LINE_OUT_GND_STP;
-
+#if 1
 	snd_soc_update_bits(codec, SGTL5000_CHIP_LINE_OUT_CTRL,
-			vag << SGTL5000_LINE_OUT_GND_SHIFT |
+//			vag << SGTL5000_LINE_OUT_GND_SHIFT |
 			SGTL5000_LINE_OUT_CURRENT_360u <<
 				SGTL5000_LINE_OUT_CURRENT_SHIFT,
-			vag << SGTL5000_LINE_OUT_GND_SHIFT |
+//			vag << SGTL5000_LINE_OUT_GND_SHIFT |
 			SGTL5000_LINE_OUT_CURRENT_360u <<
 				SGTL5000_LINE_OUT_CURRENT_SHIFT);
+#endif
=20
 	return 0;
 }
@@ -1378,7 +1381,8 @@ static int sgtl5000_probe(struct snd_soc_codec *codec=
)
=20
 	snd_soc_write(codec, SGTL5000_CHIP_ANA_CTRL,
 			SGTL5000_HP_ZCD_EN |
-			SGTL5000_ADC_ZCD_EN);
+			SGTL5000_ADC_ZCD_EN=20
+			| SGTL5000_LINE_OUT_MUTE);
=20
 	snd_soc_write(codec, SGTL5000_CHIP_MIC_CTRL, 0);
=20
--=20
1.7.0.4
