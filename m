From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Thu, 24 Jan 2013 09:33:34 +0000
Subject: [alsa-devel] [PATCH V2 2/2] ASoC: Davinci: machine: Add device
 tree binding
In-Reply-To: <20130123154804.GB4565@opensource.wolfsonmicro.com>
References: <1357293277-25543-1-git-send-email-gururaja.hebbar@ti.com>
 <1357293277-25543-3-git-send-email-gururaja.hebbar@ti.com>
 <20130104122612.GM4627@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EB50DCF@DBDE01.ent.ti.com>
 <20130123154804.GB4565@opensource.wolfsonmicro.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EB52FD9@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 21:18:12, Mark Brown wrote:
> On Wed, Jan 23, 2013 at 12:39:35PM +0000, Hebbar, Gururaja wrote:
> > On Fri, Jan 04, 2013 at 17:56:12, Mark Brown wrote:
> 
> > > The CODEC driver biases should be changed over to be supplies, this
> > > makes the above much more natural - the routing there is a hack for
> > > older versions of ASoc.  Otherwise this looks fine.
> 
> > ON TLV320AIC3x Codec, MIC Bias power on/off share the same register bits
> > with Bias voltage output.
> 
> So you need to use an event to write the actual enable bit.

Yes. Bias Enable/Disable is possible using SND_SOC_DAPM_SUPPLY. However the 
actual Bias voltage should be user selectable.

> 
> > SGTL5000 --> Single register for MIC BIAS enable & output impedance of MIC
> > Bias. The driver uses SND_SOC_DAPM_POST_PMU & SND_SOC_DAPM_PRE_PMD macro to
> > handle the MIC Bias enable & disable event.
> 
> This is the way these things should be handled.

However, as mentioned before, TLV320AIC3x Codec there is no separate 
enable/disable bit. It is mixed with Bias Voltage settings.

So it is either 
	a. Bias is disabled 
	b. Bias is enabled with some voltage. This voltage should be user 
         configurable.

So, by just using the SND_SOC_DAPM_POST_PMU & SND_SOC_DAPM_PRE_PMD I can mask 
& handle one particular voltage. 

Now I am not able understand how to make this user configurable using
SND_SOC_DAPM_xx macro.


I believe the below code change [1] should work in this situation. What is your opinion?



Thanks & Regards
Gururaja

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 5708a97..2c17e46 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -268,6 +268,11 @@ static DECLARE_TLV_DB_SCALE(adc_tlv, 0, 50, 0);
  */
 static DECLARE_TLV_DB_SCALE(output_stage_tlv, -5900, 50, 1);
 
+static const char *mic_bias_level_txt[] = { "off", "2V", "2.5V", "AVDD" };
+
+static const struct soc_enum mic_bias_level =
+SOC_ENUM_SINGLE(MICBIAS_CTRL, 6, 4, mic_bias_level_txt);
+
 static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	/* Output */
 	SOC_DOUBLE_R_TLV("PCM Playback Volume",
@@ -391,6 +396,9 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	SOC_DOUBLE_R("PGA Capture Switch", LADC_VOL, RADC_VOL, 7, 0x01, 1),
 
 	SOC_ENUM("ADC HPF Cut-off", aic3x_enum[ADC_HPF_ENUM]),
+
+	/* Mic Bias Level */
+	SOC_ENUM("Mic Bias Level", mic_bias_level),
 };
 
 /*
@@ -596,12 +604,7 @@ static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 			 AIC3X_ASD_INTF_CTRLA, 0, 3, 3, 0),
 
 	/* Mic Bias */
-	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "Mic Bias 2V",
-			 MICBIAS_CTRL, 6, 3, 1, 0),
-	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "Mic Bias 2.5V",
-			 MICBIAS_CTRL, 6, 3, 2, 0),
-	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "Mic Bias AVDD",
-			 MICBIAS_CTRL, 6, 3, 3, 0),
+	SND_SOC_DAPM_SUPPLY("Mic Bias", MICBIAS_CTRL, 6, 0, NULL, 0),
 
 	/* Output mixers */
 	SND_SOC_DAPM_MIXER("Left Line Mixer", SND_SOC_NOPM, 0, 0,
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 82d29a5..37b8e78 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -128,9 +128,9 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Line Out", NULL, "RLOUT"},
 
 	/* Mic connected to (MIC3L | MIC3R) */
-	{"MIC3L", NULL, "Mic Bias 2V"},
-	{"MIC3R", NULL, "Mic Bias 2V"},
-	{"Mic Bias 2V", NULL, "Mic Jack"},
+	{"MIC3L", NULL, "Mic Bias"},
+	{"MIC3R", NULL, "Mic Bias"},
+	{"Mic Bias", NULL, "Mic Jack"},
 
 	/* Line In connected to (LINE1L | LINE2L), (LINE1R | LINE2R) */
 	{"LINE1L", NULL, "Line In"},
