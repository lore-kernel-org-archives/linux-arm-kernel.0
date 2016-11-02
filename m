From: broonie@kernel.org (Mark Brown)
Date: Wed, 02 Nov 2016 10:47:51 -0600
Subject: Applied "ASoC: dapm: Implement stereo mixer control support" to the
 asoc tree
In-Reply-To: <20161102073601.8659-3-wens@csie.org>
Message-ID: <E1c1yhb-0006AQ-49@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: dapm: Implement stereo mixer control support

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

>From e7aa450fe17890e59db7d3c2d8eff5b6b41fc531 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 2 Nov 2016 15:35:59 +0800
Subject: [PATCH] ASoC: dapm: Implement stereo mixer control support

While DAPM is mono or single channel, its controls can be shared between
widgets, such as sharing one stereo mixer control between the left and
right channel widgets. An example such as the following routes

    [Line In Left]----------<Line In Playback Switch>-------[Left Mixer]
                                          ^
          ^           ^                   |                      ^
       (inputs)    (paths)   <shared stereo mixer control>   (outputs)
          v           v                   |                      v
                                          v
    [Line In Right]---------<Line In Playback Switch>-------[Right Mixer]

where we have separate widgets and paths for the left and right channels
from "Line In" to "Mixer", but a shared stereo mixer control for the
2 paths.

This patch introduces support for such shared mixer controls, allowing
more than 1 path to be attached to a single stereo control, and being
able to control left/right channels independently.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 141 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 112 insertions(+), 29 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 32e7af9b93d5..27dd02e57b31 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -330,6 +330,11 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 	case snd_soc_dapm_mixer_named_ctl:
 		mc = (struct soc_mixer_control *)kcontrol->private_value;
 
+		if (mc->autodisable && snd_soc_volsw_is_stereo(mc))
+			dev_warn(widget->dapm->dev,
+				 "ASoC: Unsupported stereo autodisable control '%s'\n",
+				 ctrl_name);
+
 		if (mc->autodisable) {
 			struct snd_soc_dapm_widget template;
 
@@ -723,7 +728,8 @@ static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
 }
 
 /* set up initial codec paths */
-static void dapm_set_mixer_path_status(struct snd_soc_dapm_path *p, int i)
+static void dapm_set_mixer_path_status(struct snd_soc_dapm_path *p, int i,
+				       int nth_path)
 {
 	struct soc_mixer_control *mc = (struct soc_mixer_control *)
 		p->sink->kcontrol_news[i].private_value;
@@ -736,7 +742,25 @@ static void dapm_set_mixer_path_status(struct snd_soc_dapm_path *p, int i)
 
 	if (reg != SND_SOC_NOPM) {
 		soc_dapm_read(p->sink->dapm, reg, &val);
-		val = (val >> shift) & mask;
+		/*
+		 * The nth_path argument allows this function to know
+		 * which path of a kcontrol it is setting the initial
+		 * status for. Ideally this would support any number
+		 * of paths and channels. But since kcontrols only come
+		 * in mono and stereo variants, we are limited to 2
+		 * channels.
+		 *
+		 * The following code assumes for stereo controls the
+		 * first path is the left channel, and all remaining
+		 * paths are the right channel.
+		 */
+		if (snd_soc_volsw_is_stereo(mc) && nth_path > 0) {
+			if (reg != mc->rreg)
+				soc_dapm_read(p->sink->dapm, mc->rreg, &val);
+			val = (val >> mc->rshift) & mask;
+		} else {
+			val = (val >> shift) & mask;
+		}
 		if (invert)
 			val = max - val;
 		p->connect = !!val;
@@ -749,13 +773,13 @@ static void dapm_set_mixer_path_status(struct snd_soc_dapm_path *p, int i)
 static int dapm_connect_mixer(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_path *path, const char *control_name)
 {
-	int i;
+	int i, nth_path = 0;
 
 	/* search for mixer kcontrol */
 	for (i = 0; i < path->sink->num_kcontrols; i++) {
 		if (!strcmp(control_name, path->sink->kcontrol_news[i].name)) {
 			path->name = path->sink->kcontrol_news[i].name;
-			dapm_set_mixer_path_status(path, i);
+			dapm_set_mixer_path_status(path, i, nth_path++);
 			return 0;
 		}
 	}
@@ -2186,7 +2210,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_mux_update_power);
 
 /* test and update the power status of a mixer or switch widget */
 static int soc_dapm_mixer_update_power(struct snd_soc_card *card,
-				   struct snd_kcontrol *kcontrol, int connect)
+				       struct snd_kcontrol *kcontrol,
+				       int connect, int rconnect)
 {
 	struct snd_soc_dapm_path *path;
 	int found = 0;
@@ -2195,8 +2220,33 @@ static int soc_dapm_mixer_update_power(struct snd_soc_card *card,
 
 	/* find dapm widget path assoc with kcontrol */
 	dapm_kcontrol_for_each_path(path, kcontrol) {
+		/*
+		 * Ideally this function should support any number of
+		 * paths and channels. But since kcontrols only come
+		 * in mono and stereo variants, we are limited to 2
+		 * channels.
+		 *
+		 * The following code assumes for stereo controls the
+		 * first path (when 'found == 0') is the left channel,
+		 * and all remaining paths (when 'found == 1') are the
+		 * right channel.
+		 *
+		 * A stereo control is signified by a valid 'rconnect'
+		 * value, either 0 for unconnected, or >= 0 for connected.
+		 * This is chosen instead of using snd_soc_volsw_is_stereo,
+		 * so that the behavior of snd_soc_dapm_mixer_update_power
+		 * doesn't change even when the kcontrol passed in is
+		 * stereo.
+		 *
+		 * It passes 'connect' as the path connect status for
+		 * the left channel, and 'rconnect' for the right
+		 * channel.
+		 */
+		if (found && rconnect >= 0)
+			soc_dapm_connect_path(path, rconnect, "mixer update");
+		else
+			soc_dapm_connect_path(path, connect, "mixer update");
 		found = 1;
-		soc_dapm_connect_path(path, connect, "mixer update");
 	}
 
 	if (found)
@@ -2214,7 +2264,7 @@ int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_context *dapm,
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 	card->update = update;
-	ret = soc_dapm_mixer_update_power(card, kcontrol, connect);
+	ret = soc_dapm_mixer_update_power(card, kcontrol, connect, -1);
 	card->update = NULL;
 	mutex_unlock(&card->dapm_mutex);
 	if (ret > 0)
@@ -3039,22 +3089,28 @@ int snd_soc_dapm_get_volsw(struct snd_kcontrol *kcontrol,
 	int reg = mc->reg;
 	unsigned int shift = mc->shift;
 	int max = mc->max;
+	unsigned int width = fls(max);
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
-	unsigned int val;
+	unsigned int reg_val, val, rval = 0;
 	int ret = 0;
 
-	if (snd_soc_volsw_is_stereo(mc))
-		dev_warn(dapm->dev,
-			 "ASoC: Control '%s' is stereo, which is not supported\n",
-			 kcontrol->id.name);
-
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 	if (dapm_kcontrol_is_powered(kcontrol) && reg != SND_SOC_NOPM) {
-		ret = soc_dapm_read(dapm, reg, &val);
-		val = (val >> shift) & mask;
+		ret = soc_dapm_read(dapm, reg, &reg_val);
+		val = (reg_val >> shift) & mask;
+
+		if (ret == 0 && reg != mc->rreg)
+			ret = soc_dapm_read(dapm, mc->rreg, &reg_val);
+
+		if (snd_soc_volsw_is_stereo(mc))
+			rval = (reg_val >> mc->rshift) & mask;
 	} else {
-		val = dapm_kcontrol_get_value(kcontrol);
+		reg_val = dapm_kcontrol_get_value(kcontrol);
+		val = reg_val & mask;
+
+		if (snd_soc_volsw_is_stereo(mc))
+			rval = (reg_val >> width) & mask;
 	}
 	mutex_unlock(&card->dapm_mutex);
 
@@ -3066,6 +3122,13 @@ int snd_soc_dapm_get_volsw(struct snd_kcontrol *kcontrol,
 	else
 		ucontrol->value.integer.value[0] = val;
 
+	if (snd_soc_volsw_is_stereo(mc)) {
+		if (invert)
+			ucontrol->value.integer.value[1] = max - rval;
+		else
+			ucontrol->value.integer.value[1] = rval;
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_get_volsw);
@@ -3089,46 +3152,66 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	int reg = mc->reg;
 	unsigned int shift = mc->shift;
 	int max = mc->max;
-	unsigned int mask = (1 << fls(max)) - 1;
+	unsigned int width = fls(max);
+	unsigned int mask = (1 << width) - 1;
 	unsigned int invert = mc->invert;
-	unsigned int val;
-	int connect, change, reg_change = 0;
+	unsigned int val, rval = 0;
+	int connect, rconnect = -1, change, reg_change = 0;
 	struct snd_soc_dapm_update update = { NULL };
 	int ret = 0;
 
-	if (snd_soc_volsw_is_stereo(mc))
-		dev_warn(dapm->dev,
-			 "ASoC: Control '%s' is stereo, which is not supported\n",
-			 kcontrol->id.name);
-
 	val = (ucontrol->value.integer.value[0] & mask);
 	connect = !!val;
 
 	if (invert)
 		val = max - val;
 
+	if (snd_soc_volsw_is_stereo(mc)) {
+		rval = (ucontrol->value.integer.value[1] & mask);
+		rconnect = !!rval;
+		if (invert)
+			rval = max - rval;
+	}
+
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 
-	change = dapm_kcontrol_set_value(kcontrol, val);
+	/* This assumes field width < (bits in unsigned int / 2) */
+	if (width > sizeof(unsigned int) * 8 / 2)
+		dev_warn(dapm->dev,
+			 "ASoC: control %s field width limit exceeded\n",
+			 kcontrol->id.name);
+	change = dapm_kcontrol_set_value(kcontrol, val | (rval << width));
 
 	if (reg != SND_SOC_NOPM) {
-		mask = mask << shift;
 		val = val << shift;
+		rval = rval << mc->rshift;
+
+		reg_change = soc_dapm_test_bits(dapm, reg, mask << shift, val);
 
-		reg_change = soc_dapm_test_bits(dapm, reg, mask, val);
+		if (snd_soc_volsw_is_stereo(mc))
+			reg_change |= soc_dapm_test_bits(dapm, mc->rreg,
+							 mask << mc->rshift,
+							 rval);
 	}
 
 	if (change || reg_change) {
 		if (reg_change) {
+			if (snd_soc_volsw_is_stereo(mc)) {
+				update.has_second_set = true;
+				update.reg2 = mc->rreg;
+				update.mask2 = mask << mc->rshift;
+				update.val2 = rval;
+			}
 			update.kcontrol = kcontrol;
 			update.reg = reg;
-			update.mask = mask;
+			update.mask = mask << shift;
 			update.val = val;
 			card->update = &update;
 		}
 		change |= reg_change;
 
-		ret = soc_dapm_mixer_update_power(card, kcontrol, connect);
+		ret = soc_dapm_mixer_update_power(card, kcontrol, connect,
+						  rconnect);
 
 		card->update = NULL;
 	}
-- 
2.10.1
