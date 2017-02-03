From: broonie@kernel.org (Mark Brown)
Date: Fri, 03 Feb 2017 13:03:00 +0100
Subject: Applied "ASoC: sun8i-codec-analog: Add amplifier event to fix first
 delay" to the asoc tree
In-Reply-To: <20170117140230.23142-7-mylene.josserand@free-electrons.com>
Message-ID: <E1cZcZw-0000kv-Q7@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun8i-codec-analog: Add amplifier event to fix first delay

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From bf14da7e55169964a1e6f35dc9d7428dc9e9013c Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
 <mylene.josserand@free-electrons.com>
Date: Thu, 2 Feb 2017 10:24:18 +0100
Subject: [PATCH] ASoC: sun8i-codec-analog: Add amplifier event to fix first
 delay
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When playing a sound for the first time, a short delay, where the audio
file is not played, can be noticed.
On a second play (right after), the sound is played correctly.
If we wait a short time (~5 sec which corresponds to the aplay
timeout), the delay is back.

This patch fixes it by using an event on headphone amplifier.
It allows to keep the amplifier enable while playing a sound.
A delay of 700ms allows to wait that the amplifier is powered-up
before playing the sound.

Signed-off-by: Myl??ne Josserand <mylene.josserand@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
