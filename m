From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  3 Oct 2016 19:07:54 +0800
Subject: [PATCH 02/12] ASoC: dapm: Implement stereo mixer control support
In-Reply-To: <20161003110804.28235-1-wens@csie.org>
References: <20161003110804.28235-1-wens@csie.org>
Message-ID: <20161003110804.28235-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While DAPM is mono or single channel, its controls can be shared between
widgets, such as sharing one stereo mixer control between the left and
right channel widgets.

This patch introduces support for such shared mixer controls.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 sound/soc/soc-dapm.c | 103 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 74 insertions(+), 29 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 535c20e4fac9..1739018ef81d 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -723,7 +723,8 @@ static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
 }
 
 /* set up initial codec paths */
-static void dapm_set_mixer_path_status(struct snd_soc_dapm_path *p, int i)
+static void dapm_set_mixer_path_status(struct snd_soc_dapm_path *p, int i,
+				       int nth_path)
 {
 	struct soc_mixer_control *mc = (struct soc_mixer_control *)
 		p->sink->kcontrol_news[i].private_value;
@@ -736,7 +737,13 @@ static void dapm_set_mixer_path_status(struct snd_soc_dapm_path *p, int i)
 
 	if (reg != SND_SOC_NOPM) {
 		soc_dapm_read(p->sink->dapm, reg, &val);
-		val = (val >> shift) & mask;
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
@@ -749,13 +756,13 @@ static void dapm_set_mixer_path_status(struct snd_soc_dapm_path *p, int i)
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
@@ -2195,7 +2202,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_mux_update_power);
 
 /* test and update the power status of a mixer or switch widget */
 static int soc_dapm_mixer_update_power(struct snd_soc_card *card,
-				   struct snd_kcontrol *kcontrol, int connect)
+				       struct snd_kcontrol *kcontrol,
+				       int connect, int rconnect)
 {
 	struct snd_soc_dapm_path *path;
 	int found = 0;
@@ -2204,8 +2212,16 @@ static int soc_dapm_mixer_update_power(struct snd_soc_card *card,
 
 	/* find dapm widget path assoc with kcontrol */
 	dapm_kcontrol_for_each_path(path, kcontrol) {
+		/*
+		 * If status for the second channel was given ( >= 0 ),
+		 * consider the second and later paths as the second
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
@@ -2223,7 +2239,7 @@ int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_context *dapm,
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 	card->update = update;
-	ret = soc_dapm_mixer_update_power(card, kcontrol, connect);
+	ret = soc_dapm_mixer_update_power(card, kcontrol, connect, -1);
 	card->update = NULL;
 	mutex_unlock(&card->dapm_mutex);
 	if (ret > 0)
@@ -3048,22 +3064,28 @@ int snd_soc_dapm_get_volsw(struct snd_kcontrol *kcontrol,
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
 
@@ -3075,6 +3097,13 @@ int snd_soc_dapm_get_volsw(struct snd_kcontrol *kcontrol,
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
@@ -3098,46 +3127,62 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
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
 	struct snd_soc_dapm_update update = { 0 };
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
+	change = dapm_kcontrol_set_value(kcontrol, val | (rval << width));
 
 	if (reg != SND_SOC_NOPM) {
-		mask = mask << shift;
 		val = val << shift;
+		rval = rval << mc->rshift;
 
-		reg_change = soc_dapm_test_bits(dapm, reg, mask, val);
+		reg_change = soc_dapm_test_bits(dapm, reg, mask << shift, val);
+
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
2.9.3
