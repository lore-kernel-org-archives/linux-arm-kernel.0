From: tiwai@suse.de (Takashi Iwai)
Date: Tue, 02 Aug 2011 18:13:11 +0200
Subject: [alsa-devel] [PATCH 1/1] ASoC: core: cache index fix
In-Reply-To: <20110802154815.GE25884@opensource.wolfsonmicro.com>
References: <65EE16ACC360FA4D99C96DC085B3F7721F410B@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110802083850.GB9553@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721F427D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hy5zcnlu8.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F43AA@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hoc08nk7t.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F443D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hlivcnhe2.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F45A8@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5haabsnfg2.wl%tiwai@suse.de>
	<20110802154815.GE25884@opensource.wolfsonmicro.com>
Message-ID: <s5hipqfn65k.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Wed, 3 Aug 2011 00:48:16 +0900,
Mark Brown wrote:
> 
> On Tue, Aug 02, 2011 at 02:52:29PM +0200, Takashi Iwai wrote:
> 
> > Mark, Liam, could you guys take a deeper look and clean these messes
> > up?
> 
> Like I've indicated several times now we should just get rid of the code
> or hide it from the rest of the subsystem, it's being too cute for
> vanishingly little value.  The register maps for these devices are
> usually at most 255 registers so the memory savings are really not
> meaningful.  I'm hoping the guys working with this device will find time
> to look at fixing things, but if not I'd imagine we'll get to it at some
> point in the release cycle.

Well, there aren't so many drivers suffering from this bug, so a
temporary fix would be easy like below (totally untested).


Takashi

---
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 923b364..6aea8e2 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -244,7 +244,7 @@ static int ad1980_soc_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_ad1980 = {
 	.probe = 	ad1980_soc_probe,
 	.remove = 	ad1980_soc_remove,
-	.reg_cache_size = ARRAY_SIZE(ad1980_reg),
+	.reg_cache_size = ARRAY_SIZE(ad1980_reg) << 1,
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = ad1980_reg,
 	.reg_cache_step = 2,
diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 76258f2..52e5ba3 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1437,7 +1437,7 @@ static struct snd_soc_codec_driver sgtl5000_driver = {
 	.suspend = sgtl5000_suspend,
 	.resume = sgtl5000_resume,
 	.set_bias_level = sgtl5000_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(sgtl5000_regs),
+	.reg_cache_size = SGTL5000_MAX_REG_OFFSET,
 	.reg_word_size = sizeof(u16),
 	.reg_cache_step = 2,
 	.reg_cache_default = sgtl5000_regs,
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 646b58d..7088a89 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -374,7 +374,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9705 = {
 	.resume =	wm9705_soc_resume,
 	.read = ac97_read,
 	.write = ac97_write,
-	.reg_cache_size = ARRAY_SIZE(wm9705_reg),
+	.reg_cache_size = ARRAY_SIZE(wm9705_reg) << 1,
 	.reg_word_size = sizeof(u16),
 	.reg_cache_step = 2,
 	.reg_cache_default = wm9705_reg,
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 90117f8..6149f02 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -662,7 +662,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9712 = {
 	.read = ac97_read,
 	.write = ac97_write,
 	.set_bias_level = wm9712_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(wm9712_reg),
+	.reg_cache_size = ARRAY_SIZE(wm9712_reg) << 1,
 	.reg_word_size = sizeof(u16),
 	.reg_cache_step = 2,
 	.reg_cache_default = wm9712_reg,
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 7167cb6..1995671 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1245,7 +1245,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9713 = {
 	.read = ac97_read,
 	.write = ac97_write,
 	.set_bias_level = wm9713_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(wm9713_reg),
+	.reg_cache_size = ARRAY_SIZE(wm9713_reg) << 1,
 	.reg_word_size = sizeof(u16),
 	.reg_cache_step = 2,
 	.reg_cache_default = wm9713_reg,
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index d9f8ade..d999bc8 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -408,6 +408,7 @@ static int snd_soc_rbtree_cache_init(struct snd_soc_codec *codec)
 	unsigned int val;
 	int i;
 	int ret;
+	int step = 1;
 
 	codec->reg_cache = kmalloc(sizeof *rbtree_ctx, GFP_KERNEL);
 	if (!codec->reg_cache)
@@ -421,7 +422,9 @@ static int snd_soc_rbtree_cache_init(struct snd_soc_codec *codec)
 		return 0;
 
 	word_size = codec->driver->reg_word_size;
-	for (i = 0; i < codec->driver->reg_cache_size; ++i) {
+	if (codec->driver->reg_cache_step)
+		step = codec->driver->reg_cache_step;
+	for (i = 0; i < codec->driver->reg_cache_size; i += step) {
 		val = snd_soc_get_cache_val(codec->reg_def_copy, i,
 					    word_size);
 		if (!val)
@@ -820,9 +823,12 @@ static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
 	int ret;
 	const struct snd_soc_codec_driver *codec_drv;
 	unsigned int val;
+	int step = 1;
 
 	codec_drv = codec->driver;
-	for (i = 0; i < codec_drv->reg_cache_size; ++i) {
+	if (codec_drv->reg_cache_step)
+		step = codec_drv->reg_cache_step;
+	for (i = 0; i < codec_drv->reg_cache_size; i += step) {
 		WARN_ON(codec->writable_register &&
 			codec->writable_register(codec, i));
 		ret = snd_soc_cache_read(codec, i, &val);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 83ad8ca..596773c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3269,12 +3269,25 @@ int snd_soc_register_codec(struct device *dev,
 		 * the cache.
 		 */
 		if (codec_drv->reg_cache_default) {
-			codec->reg_def_copy = kmemdup(codec_drv->reg_cache_default,
-						      reg_size, GFP_KERNEL);
+			codec->reg_def_copy = kzalloc(reg_size, GFP_KERNEL);
 			if (!codec->reg_def_copy) {
 				ret = -ENOMEM;
 				goto fail;
 			}
+			if (codec_drv->reg_cache_step > 1) {
+				/* FIXME: reg_cache_default with step > 1 is
+				 * supposed to be a packed array, so here we
+				 * expand into the flat cache array
+				 */
+				int step = codec_drv->reg_cache_step;
+				int wsize = codec_dev->reg_word_size;
+				for (i = 0; i < reg_size / step; i += wsize)
+					memcpy(codec->reg_def_copy + i * step,
+					       codec->reg_cache_default + i,
+					       wsize);
+			} else
+				memcpy(codec->reg_def_copy,
+				       codec_drv->reg_cache_default, reg_size);
 		}
 	}
 
