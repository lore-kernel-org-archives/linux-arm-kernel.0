From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Aug 2013 21:32:02 +0100
Subject: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM links between
 codec and cpu DAI
In-Reply-To: <20130805145644.GV23006@n2100.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V641A-0004lv-DM@rmk-PC.arm.linux.org.uk>
 <20130805112733.GY9858@sirena.org.uk>
 <20130805113310.GU23006@n2100.arm.linux.org.uk>
 <20130805144054.GE9858@sirena.org.uk>
 <20130805145644.GV23006@n2100.arm.linux.org.uk>
Message-ID: <20130805203202.GX23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 03:56:44PM +0100, Russell King - ARM Linux wrote:
> On Mon, Aug 05, 2013 at 03:40:54PM +0100, Mark Brown wrote:
> > On Mon, Aug 05, 2013 at 12:33:10PM +0100, Russell King - ARM Linux wrote:
> > > On Mon, Aug 05, 2013 at 12:27:33PM +0100, Mark Brown wrote:
> > 
> > > > This doesn't look good - this is adding DAPM routes which should
> > > > correspond to the DAI link that's already been configured.
> > 
> > > No, you're wrong there:
> > 
> > > CPU DAI:				Codec DAI
> > > dma-playback	--->	i2sdo	--->	Playback
> > > 		`-->	spdifdo -> not connected
> > > dma-capture	<---	i2sdi	<---	Capture

Well, having followed your suggestions and re-analysed Liam's driver, it
basically does not work, because none of the widgets get powered up.

Liam's DAPM driver does this:

==== Frontend ====
DAI drivers:    DAI stream names
System Pin      System Playback
Offload0 Pin    Offload0 Playback
Offload1 Pin    Offload1 Playback
Loopback Pin    Loopback Capture
Capture Pin     Analog Capture

Routing:
[s]System Playback   --------v           .----> [aif]SSP0 CODEC OUT
[s]Offload0 Playback ---> [w]Playback VMixer
[s]Offload1 Playback --------^           `----> [s]Loopback Capture

[aif]SSP0 CODEC IN ---> [s]Analog Capture

==== Platform ====
Routing:
[aif]SSP0 CODEC OUT ---> [s]AIF1 Playback
...

==== Codec ====
DAI drivers:    DAI stream names
rt5640-aif1     AIF1 Playback --> AIF1RX --> DAI1 RX Mux --> IF1 DAC -->...
                AIF1 Capture ...


And what I have already in kirkwood-i2s is:

CPU DAI:
[s]dma-playback	---> [aif]i2sdo
		`--> [aif]spdifdo
[s]dma-capture	<--- [aif]i2sdi

So that follows exactly what Liam's driver does.  So no changes are
required there.

I've changed the DAI links to this in kirkwood-spdif.c:

static struct snd_soc_dai_link kirkwood_spdif_dai1[] = {
        {
                .name = "S/PDIF1",
                .stream_name = "IEC958 Playback",
                .platform_name = "mvebu-audio.1",
                .cpu_dai_name = "mvebu-audio.1",
		.dynamic = 1,
                .codec_name = "snd-soc-dummy",
                .codec_dai_name = "snd-soc-dummy-dai",
        }, {
                .name = "Codec",
                .cpu_dai_name = "snd-soc-dummy-dai",
                .platform_name = "snd-soc-dummy",
                .no_pcm = 1,
                .codec_dai_name = "dit-hifi",
                .codec_name = "spdif-dit",
                .ops = &kirkwood_spdif_ops,
        },
};

which is similar to what's in Liam's driver.  However, There is no
.dpcm_playback member in mainline ASoC.

However, when trying to play something:

bash# grep . /sys/kernel/debug/asoc/Kirkwood\ SPDIF/*/dapm/* | \
sed 's,/sys/kernel/debug/asoc/Kirkwood SPDIF/,,'
mvebu-audio.1/dapm/bias_level:Off
mvebu-audio.1/dapm/i2sdi:i2sdi: Off  in 0 out 0
mvebu-audio.1/dapm/i2sdi: stream dma-rx inactive
mvebu-audio.1/dapm/i2sdo:i2sdo: Off  in 0 out 0
mvebu-audio.1/dapm/i2sdo: stream dma-tx inactive
mvebu-audio.1/dapm/spdifdo:spdifdo: Off  in 0 out 0
mvebu-audio.1/dapm/spdifdo: stream dma-tx inactive
mvebu-audio.1/dapm/spdifdo: out "static" "Playback"
snd-soc-dummy/dapm/Capture:Capture: Off  in 0 out 0
snd-soc-dummy/dapm/Capture: stream Capture inactive
snd-soc-dummy/dapm/Playback:Playback: Off  in 0 out 0
snd-soc-dummy/dapm/Playback: stream Playback inactive
snd-soc-dummy/dapm/Playback: in  "static" "spdifdo"
snd-soc-dummy/dapm/bias_level:Standby
spdif-dit/dapm/Playback:Playback: Off  in 0 out 1
spdif-dit/dapm/Playback: stream Playback inactive
spdif-dit/dapm/Playback: out "static" "spdif-out"
spdif-dit/dapm/bias_level:Standby
spdif-dit/dapm/spdif-out:spdif-out: Off  in 0 out 1
spdif-dit/dapm/spdif-out: in  "static" "Playback"

Nothing gets powered up.  This is hardly surprising, because of how
ASoC connects the widgets.

So, let's summarise this.  You're saying that I'm doing it all wrong in
my driver creating those widgets and paths.  Yet, the widgets and paths
are exactly what Liam creates in his driver.

Not only that, but we have even more duplicated widgets created with this
method, even with the hack from this patch set.

snd_soc_dapm_new_dai_widgets: creating playback widget Playback:Playback
  for dai d81247c0 dapm d8263f10 (playback_widget  was   (null), new c05ab080)
snd_soc_dapm_new_dai_widgets: creating playback widget Playback:Playback
  for dai d81247c0 dapm d8263c70 (playback_widget was c05ab080, new d8fe2b40)

It seems Liam's commit needs to be reverted to fix that.  Whether that's
correct or not, I've no idea.

Plus, when I try to set things up as Liam has, the result doesn't work,
because of the widget naming scheme having no disambiguation.
