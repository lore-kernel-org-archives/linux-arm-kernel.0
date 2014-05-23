From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 22 May 2014 23:05:39 -0300
Subject: [alsa-devel] The resume of sgtl5000 causes kernel Oops
In-Reply-To: <CAOMZO5CCFnZSz_jaipe4Fz0sTxXOajp7QRPiaM5f5wg_Di0ftA@mail.gmail.com>
References: <20140522145650.GD32184@dragon>
 <20140522174818.GN12304@sirena.org.uk>
 <CAOMZO5CCFnZSz_jaipe4Fz0sTxXOajp7QRPiaM5f5wg_Di0ftA@mail.gmail.com>
Message-ID: <CAOMZO5D8u9BmQH6K-oGcNA77o-WbmTtSEcWuVYrBTx5vbimkiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 6:33 PM, Fabio Estevam <festevam@gmail.com> wrote:
> sgtl5000 1-000a: Failed to restore cache: -5
> sgtl5000 1-000a: Failed to restore cache: -5
> sgtl5000 1-000a: ASoC: Failed to turn on bias: -5
> sgtl5000 1-000a: Failed to restore cache: -5
> sgtl5000 1-000a: ASoC: Failed to turn on bias: -5
> sgtl5000 1-000a: Failed to restore cache: -5
> sgtl5000 1-000a: ASoC: Failed to turn on bias: -5

These errors are gone if on top of the previous change I add:

--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -36,29 +36,55 @@

 /* default value of sgtl5000 registers */
 static const struct reg_default sgtl5000_reg_defaults[] = {
-    { SGTL5000_CHIP_CLK_CTRL,        0x0008 },
-    { SGTL5000_CHIP_I2S_CTRL,        0x0010 },
-    { SGTL5000_CHIP_SSS_CTRL,        0x0010 },
+    { SGTL5000_CHIP_DIG_POWER,         0x0000 },
+    { SGTL5000_CHIP_CLK_CTRL,         0x0008 },
+    { SGTL5000_CHIP_I2S_CTRL,         0x0010 },
+    { SGTL5000_CHIP_SSS_CTRL,         0x0010 },
+    { SGTL5000_CHIP_ADCDAC_CTRL,         0x020c },
     { SGTL5000_CHIP_DAC_VOL,        0x3c3c },
     { SGTL5000_CHIP_PAD_STRENGTH,        0x015f },
-    { SGTL5000_CHIP_ANA_HP_CTRL,        0x1818 },
+    { SGTL5000_CHIP_ANA_ADC_CTRL,        0x0000 },
+    { SGTL5000_CHIP_ANA_HP_CTRL,         0x1818 },
     { SGTL5000_CHIP_ANA_CTRL,        0x0111 },
+    { SGTL5000_CHIP_LINREG_CTRL,        0x0000 },
+    { SGTL5000_CHIP_REF_CTRL,        0x0000 },
+    { SGTL5000_CHIP_MIC_CTRL,        0x0000 },
+    { SGTL5000_CHIP_LINE_OUT_CTRL,        0x0000 },
     { SGTL5000_CHIP_LINE_OUT_VOL,        0x0404 },
     { SGTL5000_CHIP_ANA_POWER,        0x7060 },
     { SGTL5000_CHIP_PLL_CTRL,        0x5000 },
+    { SGTL5000_CHIP_CLK_TOP_CTRL,        0x0000 },
+    { SGTL5000_CHIP_ANA_STATUS,        0x0000 },
+    { SGTL5000_CHIP_SHORT_CTRL,        0x0000 },
+    { SGTL5000_CHIP_ANA_TEST2,        0x0000 },
+    { SGTL5000_DAP_CTRL,            0x0000 },
+    { SGTL5000_DAP_PEQ,            0x0000 },
     { SGTL5000_DAP_BASS_ENHANCE,        0x0040 },
     { SGTL5000_DAP_BASS_ENHANCE_CTRL,    0x051f },
+    { SGTL5000_DAP_AUDIO_EQ,        0x0000 },
     { SGTL5000_DAP_SURROUND,        0x0040 },
+    { SGTL5000_DAP_FLT_COEF_ACCESS,        0x0000 },
+    { SGTL5000_DAP_COEF_WR_B0_MSB,        0x0000 },
+    { SGTL5000_DAP_COEF_WR_B0_LSB,        0x0000 },
     { SGTL5000_DAP_EQ_BASS_BAND0,        0x002f },
     { SGTL5000_DAP_EQ_BASS_BAND1,        0x002f },
     { SGTL5000_DAP_EQ_BASS_BAND2,        0x002f },
     { SGTL5000_DAP_EQ_BASS_BAND3,        0x002f },
-    { SGTL5000_DAP_EQ_BASS_BAND4,        0x002f },
+    { SGTL5000_DAP_EQ_BASS_BAND4,        0x002f },
     { SGTL5000_DAP_MAIN_CHAN,        0x8000 },
+    { SGTL5000_DAP_MIX_CHAN,        0x0000 },
     { SGTL5000_DAP_AVC_CTRL,        0x0510 },
     { SGTL5000_DAP_AVC_THRESHOLD,        0x1473 },
     { SGTL5000_DAP_AVC_ATTACK,        0x0028 },
     { SGTL5000_DAP_AVC_DECAY,        0x0050 },
+    { SGTL5000_DAP_COEF_WR_B1_MSB,        0x0000 },
+    { SGTL5000_DAP_COEF_WR_B1_LSB,        0x0000 },
+    { SGTL5000_DAP_COEF_WR_B2_MSB,        0x0000 },
+    { SGTL5000_DAP_COEF_WR_B2_LSB,        0x0000 },
+    { SGTL5000_DAP_COEF_WR_A1_MSB,        0x0000 },
+    { SGTL5000_DAP_COEF_WR_A1_LSB,        0x0000 },
+    { SGTL5000_DAP_COEF_WR_A2_MSB,        0x0000 },
+    { SGTL5000_DAP_COEF_WR_A2_LSB,        0x0000 },
 };

,but now I am not able to play audio again after suspend/resume.
