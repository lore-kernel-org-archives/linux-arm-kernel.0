From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Aug 2013 00:30:15 +0100
Subject: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM links between
 codec and cpu DAI
In-Reply-To: <20130805220639.GB26637@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V641A-0004lv-DM@rmk-PC.arm.linux.org.uk>
 <20130805112733.GY9858@sirena.org.uk>
 <20130805113310.GU23006@n2100.arm.linux.org.uk>
 <20130805144054.GE9858@sirena.org.uk>
 <20130805145644.GV23006@n2100.arm.linux.org.uk>
 <20130805203202.GX23006@n2100.arm.linux.org.uk>
 <20130805220639.GB26637@sirena.org.uk>
Message-ID: <20130805233015.GY23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 11:06:39PM +0100, Mark Brown wrote:
> On Mon, Aug 05, 2013 at 09:32:02PM +0100, Russell King - ARM Linux wrote:
> 
> > which is similar to what's in Liam's driver.  However, There is no
> > .dpcm_playback member in mainline ASoC.
> 
> OK, that's interesting...  presumably there's some other framework
> changes need upstreaming here, I've really not been paying attention to
> any out of tree code here.
> 
> > So, let's summarise this.  You're saying that I'm doing it all wrong in
> > my driver creating those widgets and paths.  Yet, the widgets and paths
> > are exactly what Liam creates in his driver.
> 
> Including the CPU<->CODEC paths?  Huh, so it seems.  That wasn't
> required in any of the previous out of tree DPCM systems I've worked on
> in the past.  Something's changed somewhere along the line here...
> 
> If those are required they really should be created by the framework in
> the same way as we do for CODEC<->CODEC links, it's not at all sensible
> to have to supply them twice and like I say it's just asking for problems.
> 
> > Not only that, but we have even more duplicated widgets created with this
> > method, even with the hack from this patch set.
> 
> > snd_soc_dapm_new_dai_widgets: creating playback widget Playback:Playback
> >   for dai d81247c0 dapm d8263f10 (playback_widget  was   (null), new c05ab080)
> > snd_soc_dapm_new_dai_widgets: creating playback widget Playback:Playback
> >   for dai d81247c0 dapm d8263c70 (playback_widget was c05ab080, new d8fe2b40)
> 
> OK, that's not good.  
> 
> > It seems Liam's commit needs to be reverted to fix that.  Whether that's
> > correct or not, I've no idea.
> 
> Needs a closer look I think.
> 
> > Plus, when I try to set things up as Liam has, the result doesn't work,
> > because of the widget naming scheme having no disambiguation.
> 
> That's easy enough to sidestep for now.

... which does almost nothing to fix the problem.

 S!PDIF1: ASoC: found 0 audio playback paths
 S!PDIF1: ASoC: S/PDIF1 no valid playback route
 S!PDIF1: ASoC: found 0 new BE paths
 S!PDIF1: ASoC: open FE S/PDIF1
 S!PDIF1: ASoC: hw_params FE S/PDIF1 rate 44100 chan 2 fmt 2
 S!PDIF1: ASoC: prepare FE S/PDIF1
 S!PDIF1: ASoC: no backend DAIs enabled for S/PDIF1
 S!PDIF1: ASoC: hw_free FE S/PDIF1
 S!PDIF1: ASoC: hw_params FE S/PDIF1 rate 44100 chan 2 fmt 2

Here's what the DAPM widgets look like - this is only those which ASoC
places into debugfs which is not all of them:

mvebu-audio.1/dapm/bias_level:Off
mvebu-audio.1/dapm/i2sdi:i2sdi: Off  in 0 out 0
mvebu-audio.1/dapm/i2sdi: stream dma-rx inactive
mvebu-audio.1/dapm/i2sdo:i2sdo: Off  in 0 out 0
mvebu-audio.1/dapm/i2sdo: stream dma-tx inactive
mvebu-audio.1/dapm/spdifdo:spdifdo: Off  in 0 out 1
mvebu-audio.1/dapm/spdifdo: stream dma-tx inactive
mvebu-audio.1/dapm/spdifdo: out "static" "spdif-Playback"
snd-soc-dummy/dapm/Capture:Capture: Off  in 0 out 0
snd-soc-dummy/dapm/Capture: stream Capture inactive
snd-soc-dummy/dapm/Playback:Playback: Off  in 0 out 0
snd-soc-dummy/dapm/Playback: stream Playback inactive
snd-soc-dummy/dapm/bias_level:Standby
spdif-dit/dapm/bias_level:Standby
spdif-dit/dapm/spdif-Playback:spdif-Playback: Off  in 0 out 1
spdif-dit/dapm/spdif-Playback: stream spdif-Playback inactive
spdif-dit/dapm/spdif-Playback: in  "static" "spdifdo"
spdif-dit/dapm/spdif-Playback: out "static" "spdif-out"
spdif-dit/dapm/spdif-out:spdif-out: Off  in 0 out 1
spdif-dit/dapm/spdif-out: in  "static" "spdif-Playback"

And below is the diff against my original working build.  Much of the
diff is debugging for investigations into DAPM to discover various
things about it which I was unable to find out by asking.

I put it to you that DPCM in mainline is incomplete and nonfunctional
as it currently stands.  Moreover, it requires either those who know
that code to continue to develop it, or someone else who understands
the direction that this code is supposed to go picks up to complete it.
Add to that that you say that this was being developed with TI and
the TI situation happened, it seems unlikely to me that there's any
significant chance of movement on that.

So, insisting that DPCM is used for this driver is grossly unfair.

What I have implemented so far in these patches is not _that_ far from
apparantly what is required for a DPCM solution, if only it would work.
Therefore, there is no reason for you to refuse this patch based on your
original assertion.

The main thing is that it _works_ and, as far as is currently known,
it should not cause a regression for existing mainline kernel users.
Hopefully the t5325 folk will be able to test on their platform.

If DPCM moves forward to a state where it becomes usable, or if Liam can
provide some input on what's wrong and how it can be addressed, we can
then look at converting the driver over to use it.  Given everything I've
discovered about DPCM thus far should be a trivial matter of something
like the diff below (without the debug hacks) - provided of course that
the structure in Liam's driver was correct.

Let's not forget: Liam may be working on this stuff, and may have his own
set of patches to sort out DPCM, so having patches from me messing around
with the DPCM code apparantly "fixing" problems with it may very well be
counter-productive.  Again - Liam needs to provide some input on this.

diff --git a/sound/soc/codecs/spdif_transciever.c b/sound/soc/codecs/spdif_transciever.c
index 553708d..fde0150 100644
--- a/sound/soc/codecs/spdif_transciever.c
+++ b/sound/soc/codecs/spdif_transciever.c
@@ -36,7 +36,7 @@ static const struct snd_soc_dapm_widget dit_widgets[] = {
 };
 
 static const const struct snd_soc_dapm_route dit_routes[] = {
-	{ "spdif-out", NULL, "Playback" },
+	{ "spdif-out", NULL, "spdif-Playback" },
 };
 
 static struct snd_soc_codec_driver soc_codec_spdif_dit = {
@@ -49,7 +49,7 @@ static struct snd_soc_codec_driver soc_codec_spdif_dit = {
 static struct snd_soc_dai_driver dit_stub_dai = {
 	.name		= "dit-hifi",
 	.playback 	= {
-		.stream_name	= "Playback",
+		.stream_name	= "spdif-Playback",
 		.channels_min	= 1,
 		.channels_max	= 384,
 		.rates		= STUB_RATES,
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 05d977a..977e461 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -372,7 +372,7 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 			dev_notice(dai->dev, "timed out waiting for busy to deassert: %08x\n",
 				   ctl);
 	}
-
+printk("%s: %02x %02x\n", __func__, priv->ctl_play, priv->ctl_play_mask);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		/* configure */
diff --git a/sound/soc/kirkwood/kirkwood-spdif.c b/sound/soc/kirkwood/kirkwood-spdif.c
index e5257ec..13f2fcd 100644
--- a/sound/soc/kirkwood/kirkwood-spdif.c
+++ b/sound/soc/kirkwood/kirkwood-spdif.c
@@ -57,7 +57,7 @@ static struct snd_soc_ops kirkwood_spdif_ops = {
 };
 
 static const struct snd_soc_dapm_route routes[] = {
-	{ "Playback", NULL, "spdifdo" },
+	{ "spdif-Playback", NULL, "spdifdo" },
 };
 
 static struct snd_soc_dai_link kirkwood_spdif_dai0[] = {
@@ -78,6 +78,14 @@ static struct snd_soc_dai_link kirkwood_spdif_dai1[] = {
 		.stream_name = "IEC958 Playback",
 		.platform_name = "mvebu-audio.1",
 		.cpu_dai_name = "mvebu-audio.1",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.dynamic = 1,
+	}, {
+		.name = "Codec",
+		.cpu_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "snd-soc-dummy",
+		.no_pcm = 1,
 		.codec_dai_name = "dit-hifi",
 		.codec_name = "spdif-dit",
 		.ops = &kirkwood_spdif_ops,
@@ -108,7 +116,7 @@ static int kirkwood_spdif_probe(struct platform_device *pdev)
 		card->dai_link = kirkwood_spdif_dai0;
 	else
 		card->dai_link = kirkwood_spdif_dai1;
-	card->num_links = 1;
+	card->num_links = 2;
 	card->dapm_routes = routes;
 	card->num_dapm_routes = ARRAY_SIZE(routes);
 	card->dev = &pdev->dev;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 48e883e..c312ad6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1163,7 +1163,7 @@ static int soc_probe_platform(struct snd_soc_card *card,
 		if (dai->dev != platform->dev)
 			continue;
 
-		snd_soc_dapm_new_dai_widgets(&platform->dapm, dai);
+//		snd_soc_dapm_new_dai_widgets(&platform->dapm, dai);
 	}
 
 	platform->dapm.idle_bias_off = 1;
@@ -1362,7 +1362,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 				return -ENODEV;
 
 			list_add(&cpu_dai->dapm.list, &card->dapm_list);
-//			snd_soc_dapm_new_dai_widgets(&cpu_dai->dapm, cpu_dai);
+			snd_soc_dapm_new_dai_widgets(&cpu_dai->dapm, cpu_dai);
 		}
 
 		if (cpu_dai->driver->probe) {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 9f67976..a3ba010 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -22,7 +22,7 @@
  *      device reopen.
  *
  */
-
+#define DEBUG
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -305,6 +305,7 @@ static int snd_soc_dapm_set_bias_level(struct snd_soc_dapm_context *dapm,
 	int ret = 0;
 
 	trace_snd_soc_bias_level_start(card, level);
+	printk("%s(%p,%u)\n", __func__, card, level);
 
 	if (card && card->set_bias_level)
 		ret = card->set_bias_level(card, dapm, level);
@@ -1110,6 +1111,7 @@ EXPORT_SYMBOL_GPL(dapm_clock_event);
 
 static int dapm_widget_power_check(struct snd_soc_dapm_widget *w)
 {
+printk("%s(%p): %s %u %u %u\n", __func__, w, w->name, w->power_checked, w->new_power, w->force);
 	if (w->power_checked)
 		return w->new_power;
 
@@ -1119,6 +1121,7 @@ static int dapm_widget_power_check(struct snd_soc_dapm_widget *w)
 		w->new_power = w->power_check(w);
 
 	w->power_checked = true;
+printk("%s: %s %u %u %u\n", __func__, w->name, w->power_checked, w->new_power, w->force);
 
 	return w->new_power;
 }
@@ -1135,6 +1138,7 @@ static int dapm_generic_check_power(struct snd_soc_dapm_widget *w)
 	dapm_clear_walk_input(w->dapm, &w->sources);
 	out = is_connected_output_ep(w, NULL);
 	dapm_clear_walk_output(w->dapm, &w->sinks);
+printk("%s(%p): %u %u\n", __func__, w, out, in);
 	return out != 0 && in != 0;
 }
 
@@ -1163,6 +1167,7 @@ static int dapm_dac_check_power(struct snd_soc_dapm_widget *w)
 
 	if (w->active) {
 		out = is_connected_output_ep(w, NULL);
+		printk("%s(%p): %u\n", __func__, w, out);
 		dapm_clear_walk_output(w->dapm, &w->sinks);
 		return out != 0;
 	} else {
@@ -1576,6 +1581,7 @@ static void dapm_widget_set_power(struct snd_soc_dapm_widget *w, bool power,
 		return;
 
 	trace_snd_soc_dapm_widget_power(w, power);
+	printk("%s(%p,%u): %s\n", __func__, w, power, w->name);
 
 	/* If we changed our power state perhaps our neigbours changed
 	 * also.
@@ -1652,6 +1658,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	enum snd_soc_bias_level bias;
 
 	trace_snd_soc_dapm_start(card);
+	printk("%s(%p,%u)\n", __func__, dapm, event);
 
 	list_for_each_entry(d, &card->dapm_list, list) {
 		if (d->idle_bias_off)
@@ -1669,6 +1676,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	 * iterate.
 	 */
 	list_for_each_entry(w, &card->dapm_dirty, dirty) {
+printk("%s: dirty %s power %u active %u\n", __func__, w->name, w->power, w->active);
 		dapm_power_one_widget(w, &up_list, &down_list);
 	}
 
@@ -1682,7 +1690,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 			list_del_init(&w->dirty);
 			break;
 		}
-
+printk("%s: widget %s power %u active %u\n", __func__, w->name, w->power, w->active);
 		if (w->power) {
 			d = w->dapm;
 
@@ -2256,7 +2264,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 			route->sink);
 		return -ENODEV;
 	}
-
+printk("%s: adding a route from %s to %s (%p->%p)\n", __func__, wsource->name, wsink->name, wsource, wsink);
 	path = kzalloc(sizeof(struct snd_soc_dapm_path), GFP_KERNEL);
 	if (!path)
 		return -ENOMEM;
@@ -2562,6 +2570,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 {
 	struct snd_soc_dapm_widget *w;
 	unsigned int val;
+printk("%s(%p)\n", __func__, dapm);
 
 	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
 
@@ -3060,6 +3069,7 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 
 	if ((w = dapm_cnew_widget(widget)) == NULL)
 		return NULL;
+printk("%s(%p, %p): %s => %p\n", __func__, dapm, widget, widget->name, w);
 
 	switch (w->id) {
 	case snd_soc_dapm_regulator_supply:
@@ -3184,6 +3194,7 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *w;
 	int i;
 	int ret = 0;
+printk("%s(%p)\n", __func__, dapm);
 
 	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
 	for (i = 0; i < num; i++) {
@@ -3326,6 +3337,8 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 		return -ENOMEM;
 	snprintf(link_name, len, "%s-%s", source->name, sink->name);
 
+	printk("%s: linking %s to %s via %s\n", __func__, source->name, sink->name, link_name);
+
 	memset(&template, 0, sizeof(template));
 	template.reg = SND_SOC_NOPM;
 	template.id = snd_soc_dapm_dai_link;
@@ -3376,6 +3389,8 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 			template.name);
 
 		w = snd_soc_dapm_new_control(dapm, &template);
+printk("%s: creating playback widget %s:%s for dai %p dapm %p (playback_widget was %p, new %p)\n",
+ __func__, template.name, template.sname, dai, dapm, dai->playback_widget, w);
 		if (!w) {
 			dev_err(dapm->dev, "ASoC: Failed to create %s widget\n",
 				dai->driver->playback.stream_name);
@@ -3394,6 +3409,8 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 			template.name);
 
 		w = snd_soc_dapm_new_control(dapm, &template);
+printk("%s: creating capture widget %s:%s for dai %p dapm %p (capture_widget was %p, new %p)\n",
+ __func__, template.name, template.sname, dai, dapm, dai->capture_widget, w);
 		if (!w) {
 			dev_err(dapm->dev, "ASoC: Failed to create %s widget\n",
 				dai->driver->capture.stream_name);
@@ -3423,7 +3440,7 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 		default:
 			continue;
 		}
-
+printk("%s: found dai widget %s:%s (%p)\n", __func__, dai_w->name, dai_w->sname, dai_w);
 		dai = dai_w->priv;
 
 		/* ...find all widgets with the same stream and link them */
@@ -3441,6 +3458,7 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 
 			if (!w->sname || !strstr(w->sname, dai_w->name))
 				continue;
+printk("%s: found widget %s:%s (%p)\n", __func__, w->name, w->sname, w);
 
 			if (dai->driver->playback.stream_name &&
 			    strstr(w->sname,
@@ -3484,7 +3502,7 @@ static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
 		w_cpu = cpu_dai->capture_widget;
 		w_codec = codec_dai->capture_widget;
 	}
-
+printk("%s: w_cpu %p w_codec %p event %u\n", __func__, w_cpu, w_codec, event);
 	if (w_cpu) {
 
 		dapm_mark_dirty(w_cpu, "stream event");
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index ccb6be4..b1c98b5 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -15,7 +15,7 @@
  *  option) any later version.
  *
  */
-
+#define DEBUG
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
