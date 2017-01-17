From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Tue, 17 Jan 2017 15:02:26 +0100
Subject: [PATCH v2 06/10] ASoC: sun8i-codec-analog: Add amplifier event to fix
 first delay
In-Reply-To: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
References: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
Message-ID: <20170117140230.23142-7-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When playing a sound for the first time, a short delay, where the audio
file is not played, can be noticed.
On a second play (right after), the sound is played correctly.
If we wait a short time (~5 sec which corresponds to the aplay
timeout), the delay is back.

This patch fixes it by using an event on headphone amplifier.
It allows to keep the amplifier enable while playing a sound.
A delay of 700ms allows to wait that the amplifier is powered-up
before playing the sound.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 sound/soc/sunxi/sun8i-codec-analog.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec-analog.c b/sound/soc/sunxi/sun8i-codec-analog.c
index af02290ebe49..72331332b72e 100644
--- a/sound/soc/sunxi/sun8i-codec-analog.c
+++ b/sound/soc/sunxi/sun8i-codec-analog.c
@@ -398,11 +398,37 @@ static const struct snd_kcontrol_new sun8i_codec_hp_src[] = {
 		      sun8i_codec_hp_src_enum),
 };
 
+static int sun8i_headphone_amp_event(struct snd_soc_dapm_widget *w,
+				     struct snd_kcontrol *k, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		snd_soc_component_update_bits(component, SUN8I_ADDA_PAEN_HP_CTRL,
+					      BIT(SUN8I_ADDA_PAEN_HP_CTRL_HPPAEN),
+					      BIT(SUN8I_ADDA_PAEN_HP_CTRL_HPPAEN));
+		/*
+		 * Need a delay to have the amplifier up. 700ms seems the best
+		 * compromise between the time to let the amplifier up and the
+		 * time not to feel this delay while playing a sound.
+		 */
+		msleep(700);
+	} else if (SND_SOC_DAPM_EVENT_OFF(event)) {
+		snd_soc_component_update_bits(component, SUN8I_ADDA_PAEN_HP_CTRL,
+					      BIT(SUN8I_ADDA_PAEN_HP_CTRL_HPPAEN),
+					      0x0);
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget sun8i_codec_headphone_widgets[] = {
 	SND_SOC_DAPM_MUX("Headphone Source Playback Route",
 			 SND_SOC_NOPM, 0, 0, sun8i_codec_hp_src),
-	SND_SOC_DAPM_OUT_DRV("Headphone Amp", SUN8I_ADDA_PAEN_HP_CTRL,
-			     SUN8I_ADDA_PAEN_HP_CTRL_HPPAEN, 0, NULL, 0),
+	SND_SOC_DAPM_OUT_DRV_E("Headphone Amp", SUN8I_ADDA_PAEN_HP_CTRL,
+			       SUN8I_ADDA_PAEN_HP_CTRL_HPPAEN, 0, NULL, 0,
+			       sun8i_headphone_amp_event,
+			       SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_SUPPLY("HPCOM Protection", SUN8I_ADDA_PAEN_HP_CTRL,
 			    SUN8I_ADDA_PAEN_HP_CTRL_COMPTEN, 0, NULL, 0),
 	SND_SOC_DAPM_REG(snd_soc_dapm_supply, "HPCOM", SUN8I_ADDA_PAEN_HP_CTRL,
-- 
2.11.0
