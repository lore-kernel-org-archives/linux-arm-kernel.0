From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 1 Sep 2013 07:42:16 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <5222562B.8010001@metafoo.de>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de> <20130831172853.GL18608@sirena.org.uk>
 <20130831191956.GH6617@n2100.arm.linux.org.uk> <5222562B.8010001@metafoo.de>
Message-ID: <20130901064216.GN6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 31, 2013 at 10:46:35PM +0200, Lars-Peter Clausen wrote:
> On 08/31/2013 09:19 PM, Russell King - ARM Linux wrote:
> > On Sat, Aug 31, 2013 at 06:28:53PM +0100, Mark Brown wrote:
> >> On Sat, Aug 31, 2013 at 05:28:26PM +0200, Lars-Peter Clausen wrote:
> >>
> >>> Then connect the SPDIF AIF widgets to the SPDIF streams and the I2S AIF
> >>> widgets to the I2S streams. In your machine driver setup the link config to
> >>> use DAI 0 if the board uses I2S and DAI 1 if the board uses SPDIF. The ASoC
> >>> framework will then create the necessary routes all by itself. Of course
> >>> this won't work on a platform where both the SPDIF and I2S controller are
> >>> used at the same time, but neither does your current solution.
> >>
> >> This is the either/or approach I've been suggesting.
> > 
> > Ah, here we go again.  This is precisely why I can't work with you.
> > Nothing I say seems to stick in your mind.  I've been telling you for the
> > last four weeks that it doesn't work - and I've shown you the oopses and
> > warnings I get from trying it.  Your response to date: nothing of any
> > real use.
> > 
> > If you're not going to provide any useful responses on bug reports, it is
> > totally unreasonable that you even suggest that _that_ is how it should
> > be done when I've already proved that it's impossible at present.
> 
> Russell, please stop being such a bitch. You seem to be the only one who has
> any problems working with Mark, which maybe should make you wonder if the
> problem is not on your side. Insulting and screaming at people all the time
> won't exactly motivate them to help you with your problems. Please try to be
> constructive, it will makes things much easier for everyone.

Here's what was said on August 4th, which is also where I'm being
encouraged to persue the DPCM route.  Since IRC is technically public
forum, there is no problem posting this, and this was all discussed
openly in a channel where others were present.

This discussion happened after the previous set of patches were posted.

16:29 < broonie> I have a pretty good idea of how I'd expect to see the hardware represented - two BEs for the DAIs connected to a FE for the DMA.
16:29 < broonie> Probably just hard wired, or perhaps with a soft switch between the two.
16:31 < rmk> so I have Liam's (example) driver.  It doesn't help me understand this DPCM stuff - as I said in my emails over the weekend.
16:31 < broonie> Right, I've never actually looked at that.
16:31 < broonie> Since he's not posted it ye.t
16:32 < rmk> right, so what you're basically saying is "stop working around ASoC, and use a subsystem which no one except Liam understands"
16:32 < rmk> ... which not even _you_ understand yet
16:33 < broonie> I'd expect people like Peter to have a good handle on it too.
16:34 < broonie> Do things not hang together if ou create the links like he has in haswell_dais?
16:35 < broonie> With the dummy CODEC on the FE and the dummy CPU on the BE?
16:35 < rmk> well, if I'm reading it correctly, it has multiple frontends connected to two backends and I can't work out how the frontends are connected backends
16:36 < broonie> Yes, that's what it should be doing.
16:37 < rmk> the problem I have is the same old problem: how do I know which backend(s) are active from the frontend's perspective?
16:37 < broonie> They're hooked in via the Playback VMixer AFAICT (I can't run this stuff obviously).
16:38 < broonie> I'd expect the BE to do the caring but I know you need to enable them simultaneously.
16:38 < broonie> So I'd have the BEs set flags prior to being powered
16:38 < broonie> Then check in the FE.
16:39 < broonie> Or to a first approximation you can probably get away with just always enabling both if the pinmux is set up to output them.
16:39 < broonie> and/or the DAI links are present.
16:41 < rmk> so, I need to put two DAI drivers in the CPU level, a DAI link to setup the frontends, DAPM links to connect the front end streams to the back ends yes?
16:42 < broonie> Yes.
16:44 < rmk> and I can register the front end DAI driver separately from the two backends?
16:44 < rmk> via two snd_soc_register_component
16:45 < broonie> That should be possible, yes.
16:48 < rmk> right, I'll give that a go sometime this week, and I'll add some kind of documentation on this if I get it to work, because its really not fair not to have anything on this stuff.
16:49 < rmk> oh, another question
16:49 < rmk> .dynamic in the dai link structure, that's for backends only, right?
16:50 < broonie> Think so, yes.
16:52 < rmk> hmm
16:52 < rmk>         if (rtd->dai_link->dynamic) {
16:52 < rmk>                 rtd->ops.open           = dpcm_fe_dai_open;
16:52 < rmk> probably needed for frontends
17:53 < rmk> no, this can't work, all the DAI links have to be registered in one place and one place only.
17:53 < rmk> that's at the soc_card level
17:53 < broonie> Yes, currently it involves cut'n'paste in the cards which is sucky.
17:57 < rmk> well, having been through the (Liam's example) stuff, what I've currently got in kirkwood-i2s is correct and to what Liam's doing
17:58 < rmk> Liam has this:

(table of DAI drivers and stream names omitted)

17:58 < rmk> He then sets up a set of widgets and routing like this:

(diagram of widgets and routes removed)

17:58 < rmk> where [s] are streams, [w] are non-aif widgets, and [aif] are aif widgets
18:00 < rmk> what's different is the DAI links, and the backend codec streams are attached with DAPM routes to those aif widgets
18:12 < rmk> and I already have the DAPM routes.
18:13 < rmk> so literally the only change I've made so far is changing the DAI links
19:10 < rmk> broonie: well, with that change, I see no widgets being powered up

(output from /sys/kernel/debug/asoc/... cut)

19:12 < broonie> OK.
19:13 < broonie> Looking at that we don't seem to be kicking *any* of the DAIs to power up.
19:16 < broonie> Are all the relevant trigger functions getting called?
19:20 * rmk hits another error on reloading the modules...
19:21 < rmk> ------------[ cut here ]------------
19:21 < rmk> WARNING: at /home/rmk/git/linux-cubox/fs/proc/generic.c:356 proc_register+0xac/0
19:21 < rmk> x128()
19:21 < rmk> proc_dir_entry 'asound/oss' already registered
19:21 < rmk> but...
19:21 < rmk> kirkwood_i2s_play_trigger: 101b ffffffe7
19:21 < rmk> yes it does get called but because the widgets aren't powered up neither enable bit is set
19:31 < broonie> OK, I was checking to see how much it was missing doing.
19:37 < broonie> The be_clients list on the front end must be empty...
19:38 < rmk> err...
19:38 < broonie> Which in turn comes from dpcm_add_paths() not noticing the links.
19:43 < rmk> well, I have no_pcm set in the backend dai_link
19:43 < broonie> Probably easiest to debug with prints.
19:43 < rmk> there's quite a few errors in the logs too
19:43 < rmk> snd-soc-dummy snd-soc-dummy: ASoC: Failed to create platform debugfs directory
19:47 < broonie> That's probably getting added twice somehow then.
19:49 < rmk> The DAI widgets are being overwritten... again
19:49 < rmk> snd_soc_dapm_new_dai_widgets: creating playback widget Playback:Playback for dai d81247c0 dapm d8263f10 (playback_widget was   (null), new c05ab080)
19:50 < rmk> snd_soc_dapm_new_dai_widgets: creating playback widget Playback:Playback for dai d81247c0 dapm d8263c70 (playback_widget was c05ab080, new d8fe2b40)
19:51 < rmk> that's output by this in snd_soc_dapm_new_dai_widgets:
19:51 < rmk>                 w = snd_soc_dapm_new_control(dapm, &template);
19:51 < rmk> printk("%s: creating playback widget %s:%s for dai %p dapm %p (playback_widget was %p, new %p)\n", __func__, template.name, template.sname, dai, dapm, dai->playback_widget, w);
19:51 < rmk>                 if (!w) {
19:51 < rmk>                         dev_err(dapm->dev, "ASoC: Failed to create %s widget\n",
20:04 * rmk tries commenting out Liam's addition and uncommenting the one in my HACK patch
20:09 < rmk> nope, that doesn't fix it either
20:19 < rmk> broonie: looks like this also sends pulseaudio into a hissy fit
20:20 < broonie> Not surprising, pulseaudio is probably the best testsuite we have for DMA related stuff.
20:38 < rmk> not so helpful when it hammers on the mixer opening and closing it continuously, flooding the kernel log
20:42 < rmk>  S!PDIF1: ASoC: found 0 audio playback paths
20:42 < rmk>  S!PDIF1: ASoC: S/PDIF1 no valid playback route
20:42 < rmk>  S!PDIF1: ASoC: found 0 new BE paths
20:42 < rmk>  S!PDIF1: ASoC: open FE S/PDIF1
20:42 < rmk>  S!PDIF1: ASoC: hw_params FE S/PDIF1 rate 44100 chan 2 fmt 2
20:42 < rmk>  S!PDIF1: ASoC: prepare FE S/PDIF1
20:42 < rmk>  S!PDIF1: ASoC: no backend DAIs enabled for S/PDIF1
20:42 < rmk>  S!PDIF1: ASoC: hw_free FE S/PDIF1
20:42 < rmk>  S!PDIF1: ASoC: hw_params FE S/PDIF1 rate 44100 chan 2 fmt 2
20:42 < rmk>  S!PDIF1: ASoC: prepare FE S/PDIF1
20:42 < rmk> ...
20:58 < rmk> right, the problem is this - look carefully at this:
20:58 < rmk> snd-soc-dummy/dapm/Playback:Playback: Off  in 0 out 0
20:58 < rmk> snd-soc-dummy/dapm/Playback: stream Playback inactive
20:58 < rmk> snd-soc-dummy/dapm/Playback: in  "static" "spdifdo"
20:58 < rmk> spdif-dit/dapm/Playback:Playback: Off  in 0 out 1
20:58 < rmk> spdif-dit/dapm/Playback: stream Playback inactive
20:58 < rmk> spdif-dit/dapm/Playback: out "static" "spdif-out"
20:59 < rmk> how do I tell asoc to connect to the spdif-dit "playback" widget rather than the dummy "playback" widget which has the same name?
21:00 < broonie> Ugh. simplest thing for now is going to be to rename one of them I expect.
21:00 < broonie> That's not nice or a good long term fix but it should get you over the hurdle.
21:00 < rmk> so... the answer to my question from yesterday is that yes, we're going to have to give all these things unique names
21:01 < broonie> If they're in the same DAPM context it should be fine.
21:01 < rmk> are they with this?
21:01 < rmk> aren't they in separate contexts?
21:02 < broonie> You're linking spdif-dit to something outside spdif-dit though.
21:02 < rmk> ones in the dummy codec's dapm context, the other in the spdif-dit dapm context
21:02 < broonie> I mean if the source and destination are in the same context.
21:02 < broonie> That's the case that we do the deupe for.
21:05 < rmk> well, it still looks to me like there's a fair number of problems with this stuff which need sorting
21:05 < rmk> not only this but the multiple widget creation problem
21:06 < broonie> It's not perfect, no - I'd certainly expect the CPU side stuff to need fixups since it's never been used in anger.
21:06 < broonie> In mainline.
21:07 < rmk> well, someone needs to come up with a fix for these duplicated widgets, and that's not me.
21:07 < rmk> because... at the moment... asoc is completely useless for this hardware

The reason for my last couple of lines there is not that I'm being
difficult - I really don't know what the correct fix for the duplicated
widget problem is, and I still don't know.  What I do know is that I've
been able to work around it for _this_ patch set and not require the
hack to get it working in this form.

As far as I'm aware, the only person who knows what the answer to that
problem is Liam.

Notice the first two lines: this is the solution which Liam suggested,
which is the DPCM solution, and that's the solution I've been working
towards.  Mark there confirms that it's his expected solution.

Here's my patch which converts the Cubox SPDIF-only support to DPCM, with
all the side effects of the warnings from procfs and the oops from ALSA,
and shuts up a very annoying warning which fills the kernel log at a
rediculous rate, preventing other kernel messages from being seen.  You
can issues discussed above being solved in this patch, namely the
duplicated "Playback" widget.

As the single-frontend single-backend DPCM arrangement triggers warnings
and a kernel oops, there's not much point trying to move forward to a
multi-backend arrangement.

diff --git a/sound/soc/codecs/spdif_transciever.c b/sound/soc/codecs/spdif_transciever.c
index 553708d..fde0150 100644
--- a/sound/soc/codecs/spdif_transciever.c
+++ b/sound/soc/codecs/spdif_transciever.c
@@ -34,7 +34,7 @@ static const struct snd_soc_dapm_widget dit_widgets[] = {
 };
 
 static const const struct snd_soc_dapm_route dit_routes[] = {
-	{ "spdif-out", NULL, "Playback" },
+	{ "spdif-out", NULL, "spdif-Playback" },
 };
 
 static struct snd_soc_codec_driver soc_codec_spdif_dit = {
@@ -47,7 +47,7 @@ static struct snd_soc_codec_driver soc_codec_spdif_dit = {
 static struct snd_soc_dai_driver dit_stub_dai = {
 	.name		= "dit-hifi",
 	.playback 	= {
-		.stream_name	= "Playback",
+		.stream_name	= "spdif-Playback",
 		.channels_min	= 1,
 		.channels_max	= 384,
 		.rates		= STUB_RATES,
diff --git a/sound/soc/kirkwood/kirkwood-spdif.c b/sound/soc/kirkwood/kirkwood-spdif.c
index e5257ec..d1ee8f7 100644
--- a/sound/soc/kirkwood/kirkwood-spdif.c
+++ b/sound/soc/kirkwood/kirkwood-spdif.c
@@ -21,7 +21,7 @@ static struct snd_soc_ops kirkwood_spdif_ops = {
 #include <sound/soc.h>
 
 static const struct snd_soc_dapm_route routes[] = {
-	{ "Playback", NULL, "spdifdo" },
+	{ "spdif-Playback", NULL, "spdifdo" },
 };
 
 static struct snd_soc_dai_link kirkwood_spdif_dai0[] = {
@@ -38,9 +38,18 @@ static struct snd_soc_dai_link kirkwood_spdif_dai0[] = {
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
 	},
@@ -70,7 +79,7 @@ static int kirkwood_spdif_probe(struct platform_device *pdev)
 		card->dai_link = kirkwood_spdif_dai0;
 	else
 		card->dai_link = kirkwood_spdif_dai1;
-	card->num_links = 1;
+	card->num_links = 2;
 	card->dapm_routes = routes;
 	card->num_dapm_routes = ARRAY_SIZE(routes);
 	card->dev = &pdev->dev;
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
