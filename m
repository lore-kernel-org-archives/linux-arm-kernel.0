From: neko@bakuhatsu.net (Matt Sealey)
Date: Wed, 30 Oct 2013 00:19:28 -0500
Subject: [PATCHv7][ 2/5] ASoC: eukrea-tlv320: Add DT support.
In-Reply-To: <20131029174445.GB20251@sirena.org.uk>
References: <1382616832-23593-1-git-send-email-denis@eukrea.com>
 <1382616832-23593-2-git-send-email-denis@eukrea.com>
 <20131025191513.5345BC4042C@trevor.secretlab.ca>
 <20131026114840.GX2443@sirena.org.uk>
 <CAHCPf3vHWt5XJCwvGDMfX9rTPKqHU43SHORqpxLtLaDL6RGb8A@mail.gmail.com>
 <20131029174445.GB20251@sirena.org.uk>
Message-ID: <CAHCPf3udisV6wfLaMwdnoTcQQiAz-t6gT=2eX7WJZYkQiGj+NA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 12:44 PM, Mark Brown <broonie@kernel.org> wrote:
>
> Please take a look at Morimoto-san's work on the generic sound card if
> you want to work on a generic card, it'd be good if some of the people
> complaining about this stuff could help him work on that as he doesn't
> seem to be getting any help or review from anyone.

Okay I had another thought about it over a cup of tea and a biscuit.
One thing I'm missing is a description (with pictures PLEASE) of the
ASoC framework and how it really fits together, since I'm just going
from the bits I see and the code I've spent a couple hours browsing
with LXR and help from a git checkout.

We can come down to brass tacks on how we'd want to describe a board,
from a hardware/board design level which informs essentially what the
layout of the device tree will be, and who owns what property.

But first we have to decide if we're a Linux ASoC framework, where do
we want to start parsing the tree, and what components do we need to
discover?

I think in the end, what ends up the most flexible way is if in pretty
much any situation you start with the codec or the controller, which
can have a phandle to each other.

On i.MX the audmux settings are a function of the controller and the
iomuxc configuration - audmux connects an SSI or ESAI from an internal
port to an external port, and the iomuxc connects the external port to
actual pads on the chip, connected on the board to the codec. So we
need a handle to the audmux controller and possibly an information
structure (at minimum, internal and external ports) to throw at it.

The audio routing seems to be mostly a property of internal codec
specific features like mixers and DACs going to external ports -
headphones, speakers, microphone in. This would make it a codec
feature.

So the Linux driver structure is not being "catered to" in this sense,
since all we got to configure the board are the fact  that we're on an
imx51, we want to use ssi2 and there's an sgtl5000 codec somewhere.
There's some audio mux configuration going on (and io mux
configuration too) but this is under the pervue of the controller.

How would a top level driver for Linux do this?

Well, I don't know how it'd actually get called to do it, maybe just
start off with the codec compatible property and then dereference the
phandle to the controller, and stuff the data in there. If all it has
to do is fill out card structure and register it, then probing the
codec, finding it's controller, and putting in the information that
maps the OF compatible property for those to the name of the driver
(which is what it does now) is a table of properties vs. static
strings.. right? It would be up to the controller driver (fsl-ssi
here) to do pinctrl and audmux magic when initialized.

I am not entirely sure I understand why you'd need much more than
that, nobody (nvidia, ti, samsung) is defining more than a controller
and codec handle and all of them do some variant this:

~~~~

data->codec_clk = clk_get(&codec_dev->dev, NULL);
if (IS_ERR(data->codec_clk)) {
   ret = PTR_ERR(data->codec_clk);
   goto fail;
}

data->clk_frequency = clk_get_rate(data->codec_clk);

data->dai.name = "HiFi"; // not sure what effect this has
data->dai.stream_name = "HiFi"; // not sure what effect this has
data->dai.codec_dai_name = "sgtl5000"; // hardcoded into the codec
driver, which is how we go find it??
data->dai.codec_of_node = codec_np; // or do we find it from this?
data->dai.cpu_of_node = ssi_np; // same question..?
data->dai.platform_of_node = ssi_np; // or this?
data->dai.init = &imx_sgtl5000_dai_init; // why bother having this if
card->clk_frequency is set above
data->dai.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
   SND_SOC_DAIFMT_CBM_CFM; // and card->dai.dai_fmt is here and
accessible from the snd_soc_codec structure?.
data->card.dev = &pdev->dev;

ret = snd_soc_of_parse_card_name(&data->card, "model"); //ends up in a
PulseAudio dialog..
if (ret)
   goto fail;
ret = snd_soc_of_parse_audio_routing(&data->card, "audio-routing"); //
fills out dapm sink/sources?
if (ret)
   goto fail;

data->card.num_links = 1;
data->card.owner = THIS_MODULE;
data->card.dai_link = &data->dai;
data->card.dapm_widgets = imx_sgtl5000_dapm_widgets;
data->card.num_dapm_widgets = ARRAY_SIZE(imx_sgtl5000_dapm_widgets);
~~~~

As a hardware description, it works fine, matches what's in the SoC
and the connections on the board. Just look for a codec you know you
support and walk the tree.

The only REALLY configurable parts are the controller (cpu/platform)
and codec nodes, the codec_dai_name is used to probe the ACTUAL codec
driver, dai.init() is used to for some reason set the sysclk and
dai_fmt to the codec (.. but it's already there, in the card
structure, and every codec knows it's parent card.. so someone explain
to me why simple-card needs to do these two things by function call?)

What is really missing is a logical, topological view of the audio
routing - which ASoC only really uses to do power management and
manage bias levels - and some of that also comes into play when you
think about physical connections like jacks (which may have detection
logic, no need to turn on that path if there's no device connected),
external amplifiers (which is essentially the same concept as jack
detection logic from the opposite side - you need to turn it on or
there's no sound, but no need to turn it on if there's no sound) and
those connectors - and what they really do on the design - is
important in being described. "imx-spdif" on my board is actually an
input to the HDMI codec, so in reality I want everyone outside in
userland to know this is "HDMI Audio Out" and especially not just bark
the driver name at them.

3.5mm plugs, external amplifiers circuits, speakers, routing to other
codecs, possibly with some kind of jack detection logic - these need
naming and pairing since they can't be hardcoded in the driver, who
knows what LINE_OUT really is connected to, but it may not be "Ext
Spk". It may seem laborious to do so, but in the end you can go look
at the way Marvell and Samsung did their pinctrl drivers - a lot of
tiny nodes with very little information in it. It's a clutter, but how
else would you parse out a configurable setup? Having audio routing be
defined like pinctrl (a handle to a node which contains properties
full of information, which may be entirely device-specific) seems to
make sense. If you need to define a route/path you can use phandles to
define the pairs and the content of the nodes at those phandles would
define the source/sink properly.

I guess what I am saying is that having a top level "audio card
description" makes no sense from a device tree perspective, as long as
the bindings take into account being able to walk from a device you
can match "compatible" with, to every other node you need to reference
to make up a workable setup, you don't need ANOTHER node with ANOTHER
compatible property just to collect them all together.

Also; if the current sound node persists, it is missing a reg property
in all of the bindings. All nodes need reg properties, even if it's
@0, @1. If possible, whatever OS audio subsystem should take on the
reg property as the index of the card, otherwise you get logical
device re-ordering in userspace which pisses me off immensely when
ALSA pcm0 is HDMI on one boot and pcm1 is HDMI on another depending on
deferred probe or some driver init race. I am not sure how that'd get
resolved if the node goes away and the tree gets parsed from the codec
or controller outwards by phandle dereference..

Still thinking about it anyway..

-- 
Matt <neko@bakuhatsu.net>
