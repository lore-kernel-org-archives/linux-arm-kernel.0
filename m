From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 10 Aug 2013 17:11:23 +0100
Subject: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM links between
 codec and cpu DAI
In-Reply-To: <20130806133206.GA6427@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V641A-0004lv-DM@rmk-PC.arm.linux.org.uk>
 <20130805112733.GY9858@sirena.org.uk>
 <20130805113310.GU23006@n2100.arm.linux.org.uk>
 <20130805144054.GE9858@sirena.org.uk>
 <20130805145644.GV23006@n2100.arm.linux.org.uk>
 <20130805203202.GX23006@n2100.arm.linux.org.uk>
 <20130805220639.GB26637@sirena.org.uk>
 <20130805233015.GY23006@n2100.arm.linux.org.uk>
 <20130806133206.GA6427@sirena.org.uk>
Message-ID: <20130810161123.GW23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 02:32:06PM +0100, Mark Brown wrote:
> On Tue, Aug 06, 2013 at 12:30:15AM +0100, Russell King - ARM Linux wrote:
> 
> > I put it to you that DPCM in mainline is incomplete and nonfunctional
> > as it currently stands.  Moreover, it requires either those who know
> > that code to continue to develop it, or someone else who understands
> > the direction that this code is supposed to go picks up to complete it.
> 
> I'd be most distressed if it were far off working; it's close enough to
> the out of tree code I've worked with and I know there were drivers in
> progress when it was submitted.  We've certainly had at least one bug
> fix from the out of tree users, I'd be surprised if we had anything more
> substantial than bitrot in the current code.

Right, so, I've looked at this again today, and I've sort-of got it
working.

It would appear that the problem is that the AIF widgets are not finding
their stream - the implicit routes are not being created.  It _appears_
that the strean name in widgets are only ever connected to the streams
within the same DAPM context.

Hence, to get this stuff right, you _have_ to know about the DAPM
internals, and you _have_ to know that it's more than just "a graph
walk".  Documentation would help there...

Anyway, with that fixed, the widgets get powered up - great, finally
some forward progress.  Not quite, because it still doesn't work right.
ASoC still ends up filling my disk with lots of:

 S!PDIF1: ASoC: no backend DAIs enabled for S/PDIF1

messages.  Throwing a WARN_ON(1) just after that message reveals:

[<c032d334>] (dpcm_fe_dai_prepare+0xe0/0xf0) from [<c030d324>] (snd_pcm_do_prepare+0x14/0x2c)
[<c030d324>] (snd_pcm_do_prepare+0x14/0x2c) from [<c030cedc>] (snd_pcm_action_single+0x38/0x78)
[<c030cedc>] (snd_pcm_action_single+0x38/0x78) from [<c030e8e0>] (snd_pcm_action_nonatomic+0x60/0x78)
[<c030e8e0>] (snd_pcm_action_nonatomic+0x60/0x78) from [<c0311040>] (snd_pcm_common_ioctl1+0x2b4/0x5bc)
[<c0311040>] (snd_pcm_common_ioctl1+0x2b4/0x5bc) from [<c0311398>] (snd_pcm_capture_ioctl1+0x50/0x308)
[<c0311398>] (snd_pcm_capture_ioctl1+0x50/0x308) from [<c00e50bc>] (do_vfs_ioctl+0x80/0x31c)
[<c00e50bc>] (do_vfs_ioctl+0x80/0x31c) from [<c00e5394>] (SyS_ioctl+0x3c/0x60)
[<c00e5394>] (SyS_ioctl+0x3c/0x60) from [<c000e3e0>] (ret_fast_syscall+0x0/0x48)

So, it's because the capture isn't wired up.  The capture isn't wired
up on this platform, so how do I tell ASoC not to bother with the
capture side with DPCM?  Creating a link for the capture side to the
dummy codec is wrong, because that allows capture to be brought up when
in fact there is no capture wired up on the board (and means that we'll
end up trying to use unconnected inputs.)

I think the easiest "solution" to that is to just comment out the damned
warning in the core code for the moment, until a proper solution can be
thought up.

There is also this which seems to be a core ALSA problem - I get two of
these on every boot:

WARNING: at /home/rmk/git/linux-cubox/fs/proc/generic.c:356 proc_register+0xac/0x128()
proc_dir_entry 'asound/oss' already registered
Modules linked in: snd_soc_spdif_tx m25p80 mtd orion_wdt snd_soc_kirkwood snd_soc_kirkwood_spdif
CPU: 0 PID: 388 Comm: kworker/u2:2 Not tainted 3.10.0+ #649
Workqueue: deferwq deferred_probe_work_func
[<c0013d7c>] (unwind_backtrace+0x0/0xf8) from [<c0011bec>] (show_stack+0x10/0x14)
[<c0011bec>] (show_stack+0x10/0x14) from [<c0048b80>] (warn_slowpath_common+0x4c/0x68)
[<c0048b80>] (warn_slowpath_common+0x4c/0x68) from [<c0048c30>] (warn_slowpath_fmt+0x30/0x40)
[<c0048c30>] (warn_slowpath_fmt+0x30/0x40) from [<c0124804>] (proc_register+0xac/0x128)
[<c0124804>] (proc_register+0xac/0x128) from [<c0124910>] (proc_create_data+0x90/0xac)
[<c0124910>] (proc_create_data+0x90/0xac) from [<c0302b48>] (snd_info_register+0x54/0xf0)
[<c0302b48>] (snd_info_register+0x54/0xf0) from [<c03190e8>] (snd_pcm_oss_register_minor+0xcc/0x1cc)
[<c03190e8>] (snd_pcm_oss_register_minor+0xcc/0x1cc) from [<c030bdec>] (snd_pcm_dev_register+0x1ac/0x290)
[<c030bdec>] (snd_pcm_dev_register+0x1ac/0x290) from [<c03069c8>] (snd_device_register_all+0x40/0x80)
[<c03069c8>] (snd_device_register_all+0x40/0x80) from [<c030192c>] (snd_card_register+0x24/0x228)
[<c030192c>] (snd_card_register+0x24/0x228) from [<c03252a4>] (snd_soc_instantiate_card+0x7b4/0x868)
[<c03252a4>] (snd_soc_instantiate_card+0x7b4/0x868) from [<c03255c4>] (snd_soc_register_card+0x26c/0x324)
[<c03255c4>] (snd_soc_register_card+0x26c/0x324) from [<bf00c0b4>] (kirkwood_spdif_probe+0x88/0xd8 [snd_soc_kirkwood_spdif])
[<bf00c0b4>] (kirkwood_spdif_probe+0x88/0xd8 [snd_soc_kirkwood_spdif]) from [<c0259468>] (platform_drv_probe+0x18/0x1c)
[<c0259468>] (platform_drv_probe+0x18/0x1c) from [<c0258144>] (really_probe+0x74/0x1f4)
[<c0258144>] (really_probe+0x74/0x1f4) from [<c02583d8>] (driver_probe_device+0x30/0x48)
[<c02583d8>] (driver_probe_device+0x30/0x48) from [<c0256a48>] (bus_for_each_drv+0x60/0x8c)
[<c0256a48>] (bus_for_each_drv+0x60/0x8c) from [<c0258368>] (device_attach+0x80/0xa4)
[<c0258368>] (device_attach+0x80/0xa4) from [<c02577a8>] (bus_probe_device+0x88/0xac)
[<c02577a8>] (bus_probe_device+0x88/0xac) from [<c0257c34>] (deferred_probe_work_func+0x6c/0x9c)
[<c0257c34>] (deferred_probe_work_func+0x6c/0x9c) from [<c0060a74>] (process_one_work+0x190/0x3f4)
[<c0060a74>] (process_one_work+0x190/0x3f4) from [<c0062544>] (worker_thread+0xf4/0x318)
[<c0062544>] (worker_thread+0xf4/0x318) from [<c006800c>] (kthread+0xa8/0xb4)
[<c006800c>] (kthread+0xa8/0xb4) from [<c000e4a8>] (ret_from_fork+0x14/0x2c)

I suspect if I put another codec into the mix, I'll get four of them
(one pair for each backend stream.)

And /proc/asound ends up looking like this:

total 0
lrwxrwxrwx 1 root root 5 Aug 10 16:14 SPDIF -> card0
dr-xr-xr-x 4 root root 0 Aug 10 16:14 card0
-r--r--r-- 1 root root 0 Aug 10 16:14 cards
-r--r--r-- 1 root root 0 Aug 10 16:14 devices
-rw-r--r-- 1 root root 0 Aug 10 16:14 oss
-rw-r--r-- 1 root root 0 Aug 10 16:14 oss
-rw-r--r-- 1 root root 0 Aug 10 16:14 oss
-r--r--r-- 1 root root 0 Aug 10 16:14 pcm
-r--r--r-- 1 root root 0 Aug 10 16:14 timers
-r--r--r-- 1 root root 0 Aug 10 16:14 version

Yes, three 'oss'es, and /proc/asound/pcm looks like this:

00-00: IEC958 Playback (*) :  : playback 1 : capture 1
00-01: ((null)) :  : playback 1 : capture 1

which doesn't look very healthy.  That ((null)) seems to be down to the
lack of a .stream_name for the backend DAI link - but then Liam doesn't
have that either.  Giving it a stream name fixes the /proc/asound/pcm
output:

00-00: Audio Playback (*) :  : playback 1 : capture 1
00-01: (IEC958 Playback) :  : playback 1 : capture 1

but doesn't stop those warnings (not really surprising, because it isn't
the card level which is being complained about).  Probably the easiest
way to stop that appearing is to just disable OSS compatibility.

That's something which should be documented until it is fixed - that
DPCM is currently incompatible with OSS.

So, there are two issues which still need resolving:
1. The registration of Codec widgets from the platform introduced by
   Liam in be09ad90e17b79fdb0d513a31e814ff4d42e3dff
	ASoC: core: Add platform DAI widget mapping

2. How to deal with disconnected front end streams which have no backend
   provided by their connected codec (in this case, front end can do
   capture and playback, back end can only do playback.)

Both I think are for Liam to solve.

The last issue which doesn't block this provided it is documented is:
3. The core ALSA developers need to comment on the multiple /proc/asound/oss
   creation problem.

Here's the hacky patch against my patch set which gets DPCM "working":

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
index 05d977a..66fc76c 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -500,8 +500,11 @@ static int kirkwood_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 static int kirkwood_i2s_play_i2s(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *ctl, int event)
 {
-	/* This works because the platform and cpu dai are the same dev */
-	struct kirkwood_dma_data *priv = snd_soc_platform_get_drvdata(w->platform);
+	/*
+	 * The CPU DAI is not available via the widget, so pick
+	 * out private data from the device
+	 */
+	struct kirkwood_dma_data *priv = dev_get_drvdata(w->dapm->dev);
 
 	if (SND_SOC_DAPM_EVENT_ON(event))
 		priv->ctl_play_mask |= KIRKWOOD_PLAYCTL_I2S_EN;
@@ -514,8 +517,11 @@ static int kirkwood_i2s_play_i2s(struct snd_soc_dapm_widget *w,
 static int kirkwood_i2s_play_spdif(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *ctl, int event)
 {
-	/* This works because the platform and cpu dai are the same dev */
-	struct kirkwood_dma_data *priv = snd_soc_platform_get_drvdata(w->platform);
+	/*
+	 * The CPU DAI is not available via the widget, so pick
+	 * out private data from the device
+	 */
+	struct kirkwood_dma_data *priv = dev_get_drvdata(w->dapm->dev);
 
 	if (SND_SOC_DAPM_EVENT_ON(event))
 		priv->ctl_play_mask |= KIRKWOOD_PLAYCTL_SPDIF_EN;
@@ -553,8 +559,7 @@ static int kirkwood_i2s_probe(struct snd_soc_dai *dai)
 	}
 
 	/* It appears that these can't be attached to the CPU DAI */
-	snd_soc_dapm_new_controls(&dai->platform->dapm,
-				  widgets, ARRAY_SIZE(widgets));
+	snd_soc_dapm_new_controls(&dai->dapm, widgets, ARRAY_SIZE(widgets));
 
 	/* put system in a "safe" state : */
 	/* disable audio interrupts */
diff --git a/sound/soc/kirkwood/kirkwood-spdif.c b/sound/soc/kirkwood/kirkwood-spdif.c
index e5257ec..d1ee8f7 100644
--- a/sound/soc/kirkwood/kirkwood-spdif.c
+++ b/sound/soc/kirkwood/kirkwood-spdif.c
@@ -57,7 +57,7 @@ static struct snd_soc_ops kirkwood_spdif_ops = {
 };
 
 static const struct snd_soc_dapm_route routes[] = {
-	{ "Playback", NULL, "spdifdo" },
+	{ "spdif-Playback", NULL, "spdifdo" },
 };
 
 static struct snd_soc_dai_link kirkwood_spdif_dai0[] = {
@@ -75,9 +75,18 @@ static struct snd_soc_dai_link kirkwood_spdif_dai0[] = {
 static struct snd_soc_dai_link kirkwood_spdif_dai1[] = {
 	{
 		.name = "S/PDIF1",
-		.stream_name = "IEC958 Playback",
+		.stream_name = "Audio Playback",
 		.platform_name = "mvebu-audio.1",
 		.cpu_dai_name = "mvebu-audio.1",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.dynamic = 1,
+	}, {
+		.name = "Codec",
+		.stream_name = "IEC958 Playback",
+		.cpu_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "snd-soc-dummy",
+		.no_pcm = 1,
 		.codec_dai_name = "dit-hifi",
 		.codec_name = "spdif-dit",
 		.ops = &kirkwood_spdif_ops,
@@ -108,7 +117,7 @@ static int kirkwood_spdif_probe(struct platform_device *pdev)
 		card->dai_link = kirkwood_spdif_dai0;
 	else
 		card->dai_link = kirkwood_spdif_dai1;
-	card->num_links = 1;
+	card->num_links = 2;
 	card->dapm_routes = routes;
 	card->num_dapm_routes = ARRAY_SIZE(routes);
 	card->dev = &pdev->dev;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 48e883e..9176815 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1158,6 +1158,7 @@ static int soc_probe_platform(struct snd_soc_card *card,
 		snd_soc_dapm_new_controls(&platform->dapm,
 			driver->dapm_widgets, driver->num_dapm_widgets);
 
+#if 0 /* This breaks DAPM on Kirkwood */
 	/* Create DAPM widgets for each DAI stream */
 	list_for_each_entry(dai, &dai_list, list) {
 		if (dai->dev != platform->dev)
@@ -1165,6 +1166,7 @@ static int soc_probe_platform(struct snd_soc_card *card,
 
 		snd_soc_dapm_new_dai_widgets(&platform->dapm, dai);
 	}
+#endif
 
 	platform->dapm.idle_bias_off = 1;
 
@@ -1362,7 +1364,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 				return -ENODEV;
 
 			list_add(&cpu_dai->dapm.list, &card->dapm_list);
-//			snd_soc_dapm_new_dai_widgets(&cpu_dai->dapm, cpu_dai);
+			snd_soc_dapm_new_dai_widgets(&cpu_dai->dapm, cpu_dai);
 		}
 
 		if (cpu_dai->driver->probe) {
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index ccb6be4..381df28 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1634,8 +1634,8 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
 
 	/* there is no point preparing this FE if there are no BEs */
 	if (list_empty(&fe->dpcm[stream].be_clients)) {
-		dev_err(fe->dev, "ASoC: no backend DAIs enabled for %s\n",
-				fe->dai_link->name);
+//		dev_err(fe->dev, "ASoC: no backend DAIs enabled for %s\n",
+//				fe->dai_link->name);
 		ret = -EINVAL;
 		goto out;
 	}
