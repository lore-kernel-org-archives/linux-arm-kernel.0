From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 04 Aug 2013 23:45:30 +0200
Subject: [PATCH RFC 00/13] Adding SPDIF support to kirkwood-i2s
In-Reply-To: <20130804192136.GK23006@n2100.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
Message-ID: <51FECB7A.6010208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/2013 09:21 PM, Russell King - ARM Linux wrote:
> This is only a RFC at present due to the need to test on Kirkwood and
> fix at least one bug in ASoC core code.
>
> I can't say that this stuff is fully tested, because I don't have any
> Kirkwood platforms, but I do have one Dove platform, which as I've
> said in the past doesn't run mainline.  I don't run DT on it, so these
> patches also don't contain anything DT related.

Added Thomas Petazzoni to Cc, IIRC he has access to a T5325. I'll add
DT support as I already did for Jean-Francois' patches. But as currently
DT maintainers are very busy, I suggest to have a separate patch set for
those and take these in earlier.

> However, this patch set is aimed at sorting out the SPDIF on Dove and
> Kirkwood, which the Dove-based Cubox uses.

[...]

> What I haven't included is the board file (like the openrd and t5325
> ones already present) for SPDIF support on Dove, as that's based on the
> pre-DT setups, and I'm not sure anyone in mainline is interested in
> that.  So the above provides the components necessary, hopefully someone
> with ASoC & DT knowledge can bind these components together via
> appropriate DT bindings.  For reference, the DAI link looks like this:
>
>                  .name = "S/PDIF1",
>                  .stream_name = "IEC958 Playback",
>                  .platform_name = "mvebu-audio.1",
>                  .cpu_dai_name = "mvebu-audio.1",
>                  .codec_dai_name = "dit-hifi",
>                  .codec_name = "spdif-dit",

Not a big deal for DT. I suggest to have a "audio-codecs" property that
link CPU DAI to codec(s). One thing, I have noticed is that currently
you need to supply both codec_name (or DT node) _and_ codec_dai_name.
For that it would be helpful, if ASoC supplies helpers to get the DAI
by index and use phandle with args here.

As an example, the nodes could look like:

spdif: spdif-transmitter {
	compatible = "linux,spdif-dit";
};

i2s1: audio-controller at b0000 {
	compatible = "marvell,dove-i2s";
	reg = <0xb0000 0x2345>;
	audio-codecs = <&spdif 0>;
};

ASoC then should resolve DT node and index to codec_dai and
codec_dai_name. (Or have child nodes for each dai? Will also look
through other drivers first).

Also, the compatibles for mvebu-audio driver should be
marvell,dove-i2s, marvell,kirkwood-i2s, and marvell,armada-370-i2s
(if supported). With those, we can distinguish the controller features 
easily.

> and the required route:
>
> static const struct snd_soc_dapm_route routes[] = {
>          { "Playback", NULL, "spdifdo" },
> };

I am not sure about how to represent DAPM in DT but I guess there are
already drivers that make use of it.

Sebastian
