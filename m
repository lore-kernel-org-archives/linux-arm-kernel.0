From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 11 Jun 2018 12:25:30 +0200
Subject: handling voice calls in ALSA soc (on Droid 4)
Message-ID: <20180611102529.GA1272@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

During voice call, I need audio components to be active "as if" aplay
or arecord was running, because modem needs to comunicate with speaker
and microphone.

I hacked something up, but... I believe I'll need help here. Look at
"enable_call" for "interesting" stuff I had to do.

...and also. What is right interface for this? Mixer component that
says if voice call is active or not?

Any ideas?

Thanks,
									Pavel

(edited).
+++ b/sound/soc/codecs/cpcap.c
@@ -330,6 +330,10 @@ static const char * const cpcap_in_left_mux_texts[] = {
 	"Off", "Mic 2", "Ext Left"
 };
 
+static const char * const cpcap_mode_texts[] = {
+	"Normal", "Handsfree", "Call",
+};
+
 /*
  * input muxes use unusual register layout, so that we need to use custom
  * getter/setter methods
@@ -354,6 +358,8 @@ static SOC_ENUM_SINGLE_DECL(cpcap_hs_l_mux_enum, 0, 6, cpcap_out_mux_texts);
 static SOC_ENUM_SINGLE_DECL(cpcap_emu_l_mux_enum, 0, 7, cpcap_out_mux_texts);
 static SOC_ENUM_SINGLE_DECL(cpcap_emu_r_mux_enum, 0, 8, cpcap_out_mux_texts);
 
+static SOC_ENUM_SINGLE_DECL(cpcap_mode_enum, 0, 9, cpcap_mode_texts);
+
 static int cpcap_output_mux_get_enum(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_value *ucontrol)
 {
@@ -442,6 +448,211 @@ static int cpcap_output_mux_put_enum(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int mode;
+
+static int cpcap_mode_get_enum(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.enumerated.item[0] = mode;
+
+	return 0;
+}
+
+static struct snd_soc_dai *voice_codec_dai_hack;
+
+static int enable_call(struct snd_soc_component *component, int on)
+{
+	struct cpcap_audio *cpcap = snd_soc_component_get_drvdata(component);

+		struct snd_soc_pcm_runtime *rt;
+
+		rt = snd_soc_get_pcm_runtime(component->card, "40126000.mcbsp-cpcap-voice");
+		printk("num_dai: %d, got runtime %lx\n", component->num_dai, rt);
+
+		if (rt) {
+		snd_soc_dapm_stream_event(rt, SNDRV_PCM_STREAM_PLAYBACK, SND_SOC_DAPM_STREAM_START);
+		snd_soc_dapm_stream_event(rt, SNDRV_PCM_STREAM_CAPTURE, SND_SOC_DAPM_STREAM_START);
+		}
+
+		cpcap_set_sysclk(cpcap, CPCAP_DAI_VOICE, 1, 19200000);
+		cpcap_set_samprate(cpcap, CPCAP_DAI_VOICE, 8000);
+		
+		cpcap_voice_set_dai_fmt(voice_codec_dai_hack,
+					SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM );
+
+	return 0;
+}
+
+static int cpcap_mode_put_enum(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
+	struct cpcap_audio *cpcap = snd_soc_component_get_drvdata(component);
+	unsigned int muxval = ucontrol->value.enumerated.item[0];
+
+	printk("Requested mode %d\n", muxval);
+
+	mode = muxval;
+
+	switch (muxval) {
+	case 1:
+		enable_call(component, 1);
+		break;
+	case 2:
+		enable_call(component, 1);
+
+		regmap_assert(cpcap, CPCAP_REG_TXI, 0xffff, 0x0cc6);
		...
+		break;
+		
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int cpcap_input_right_mux_get_enum(struct snd_kcontrol *kcontrol,
 					  struct snd_ctl_elem_value *ucontrol)
 {
@@ -630,6 +841,10 @@ static const struct snd_kcontrol_new cpcap_earpiece_mux =
 	SOC_DAPM_ENUM_EXT("Earpiece", cpcap_earpiece_mux_enum,
 			  cpcap_output_mux_get_enum, cpcap_output_mux_put_enum);
 
+static const struct snd_kcontrol_new cpcap_mode =
+	SOC_DAPM_ENUM_EXT("Mode", cpcap_mode_enum,
+			  cpcap_mode_get_enum, cpcap_mode_put_enum);
+
 static const struct snd_kcontrol_new cpcap_hifi_mono_mixer_controls[] = {
 	SOC_DAPM_SINGLE("HiFi Mono Playback Switch",
 		CPCAP_REG_RXSDOA, CPCAP_BIT_MONO_DAC1, 1, 0),
@@ -771,6 +986,9 @@ static const struct snd_soc_dapm_widget cpcap_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("EMU Left Playback Route", SND_SOC_NOPM, 0, 0,
 		&cpcap_emu_left_mux),
 
+	SND_SOC_DAPM_MUX("Mode", SND_SOC_NOPM, 0, 0,
+		&cpcap_mode),
+	
 	/* Output Amplifier */
 	SND_SOC_DAPM_PGA("Earpiece PGA",
 		CPCAP_REG_RXOA, CPCAP_BIT_A1_EAR_EN, 0, NULL, 0),
@@ -791,7 +1009,7 @@ static const struct snd_soc_dapm_widget cpcap_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("EMU Left PGA",
 		CPCAP_REG_RXOA, CPCAP_BIT_EMU_SPKR_L_EN, 0, NULL, 0),
 
-	/* Headet Charge Pump */
+	/* Headset Charge Pump */
 	SND_SOC_DAPM_SUPPLY("Headset Charge Pump",
 		CPCAP_REG_RXOA, CPCAP_BIT_ST_HS_CP_EN, 0, NULL, 0),
 
@@ -1304,6 +1525,7 @@ static int cpcap_voice_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	u16 val = 0x0000;
 	int err;
 
+	voice_codec_dai_hack = codec_dai;
 	dev_dbg(component->dev, "Voice setup dai format (%08x)", fmt);
 
 	/*
@@ -1343,10 +1565,7 @@ static int cpcap_voice_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		break;
 	}
 
-	if (val & BIT(CPCAP_BIT_CLK_INV))
-		val &= ~BIT(CPCAP_BIT_CLK_INV);
-	else
-		val |= BIT(CPCAP_BIT_CLK_INV);
+	val ^= BIT(CPCAP_BIT_CLK_INV);
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180611/55bdfbe3/attachment.sig>
