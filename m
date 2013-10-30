From: neko@bakuhatsu.net (Matt Sealey)
Date: Tue, 29 Oct 2013 22:05:40 -0500
Subject: [PATCHv7][ 2/5] ASoC: eukrea-tlv320: Add DT support.
In-Reply-To: <20131029174445.GB20251@sirena.org.uk>
References: <1382616832-23593-1-git-send-email-denis@eukrea.com>
 <1382616832-23593-2-git-send-email-denis@eukrea.com>
 <20131025191513.5345BC4042C@trevor.secretlab.ca>
 <20131026114840.GX2443@sirena.org.uk>
 <CAHCPf3vHWt5XJCwvGDMfX9rTPKqHU43SHORqpxLtLaDL6RGb8A@mail.gmail.com>
 <20131029174445.GB20251@sirena.org.uk>
Message-ID: <CAHCPf3sm9BawgCKrPH_mbD-Mhb-uXzSyZTjxhJf1W25pG3wZUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 12:44 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Oct 29, 2013 at 11:56:54AM -0500, Matt Sealey wrote:
>
>> Maybe this is a reasonable place to ask since I am holding off on
>> doing any audio support for the i.MX platform I want to push a DT for,
>> and I am still bashing my head over the logic in this. Why is this so
>> much more complicated than it needs to be? I can see codec specific
>> and Linux-specific things floating in trees. I can see redundancy in
>> property naming and misplacement of properties.. this whole thing
>> needs to be cleaned up because it's been done as "binding a Linux
>> driver into the device tree" and this is another example of the same
>> thing - taking the way ASoC is working right now and dumping platform
>> data externally.
>
> Can you be more specific about all these points please?  It's hard to
> engage without concrete technical discussion which there is very little
> of in your rather lengthy mail.  Please also take a look at the previous
> discussions on this stuff and make sure you understand the needs of more
> advanced audio subsystems like those found in smartphones.

To be specific, there are several "braindeadisms" in the current
bindings for mxs-audio-sgtl5000 and imx-audio-sgtl5000 and
imx-audio-wm8962 existing bindings which are being dragged into
Eukrea's bindings.

None of the three bindings above do anything that is particularly
codec *OR* SoC-variant specific.

Now this patch comes in that defines eukrea-tvl320 as a special magic
binding but 90% of it is identical to the existing bindings. Still,
none of it is codec, SoC-variant or even Eukrea-specific.

>From imx-audio-sgtl5000, the example is covering all the definitions
in the binding documented before it:

sound {
compatible = "fsl,imx51-babbage-sgtl5000",
    "fsl,imx-audio-sgtl5000";
model = "imx51-babbage-sgtl5000";
ssi-controller = <&ssi1>;
audio-codec = <&sgtl5000>;
audio-routing =
"MIC_IN", "Mic Jack",
"Mic Jack", "Mic Bias",
"Headphone Jack", "HP_OUT";
mux-int-port = <1>;
mux-ext-port = <3>;
};

and..

sound {
compatible = "fsl,imx6q-sabresd-wm8962",
    "fsl,imx-audio-wm8962";
model = "wm8962-audio";
ssi-controller = <&ssi2>;
audio-codec = <&codec>;
audio-routing =
"Headphone Jack", "HPOUTL",
"Headphone Jack", "HPOUTR",
"Ext Spk", "SPKOUTL",
"Ext Spk", "SPKOUTR",
"MICBIAS", "AMIC",
"IN3R", "MICBIAS",
"DMIC", "MICBIAS",
"DMICDAT", "DMIC";
mux-int-port = <2>;
mux-ext-port = <3>;
};

and..

sound {
compatible = "fsl,imx28-evk-sgtl5000",
    "fsl,mxs-audio-sgtl5000";
model = "imx28-evk-sgtl5000";
saif-controllers = <&saif0 &saif1>;
audio-codec = <&sgtl5000>;
};


Right, so here are the main braindeadisms that immediately jump out;

1) saif-controllers and ssi-controller could be a single property -
controllers - which list the controller. It will be obvious which kind
of controller it is by delving into that node referenced by the
phandle.

2) audio-codec is redundantly named as we're defining audio devices
here.. but it should/could be "codecs" since it should be an array of
phandles just like controllers (there's no reason you can't have
multiple codecs attached to the same i2s bus, it's just not entirely
common).

3) the compatible properties define a specific board and codec style
which simply isn't used in the drivers, because there's no opportunity
to use it. The only reason 3 different compatible properties exist are
to probe the 3 different drivers which all do nearly exactly the same
thing - collect controllers, codecs, the routing information (for
power management, of all reasons..) and stuff them in a handoff
structure to allow ASoC to individually probe components.

4) The drivers themselves just call imx_audmux_v2_foo() with the
contents of the mux-int-port and mux-ext-port properties - this is
Linux subsystem layout dictated by quickly and poorly architected
drivers leaking into the device tree. This is almost entirely wrong
from the conceptual purpose of a device tree and how it defines
structure. You may be able to *assume* that given those properties,
this is what needs to be done, but you shouldn't be describing
hardware this way.

A lot of it comes from this weird concept that for every file in Linux
that can probe on it's own, a device tree needs to somehow define ONE
node per file, and define platform properties in that node. This comes
eventually from the platform_data concept the original drivers were
written against.

Writing device tree bindings is not about looking an an existing
driver, platform, or private data structure and creating a new node
for every one and shuffling the data into it. It is for describing
hardware. In this case, none of the bindings above describe hardware,
they describe the current driver structure in Linux - worse still,
they were describing it as that abstraction was being defined, which
also does not describe hardware, per se.

5) for some reason the drivers picking up these nodes do some really
strange things like use the "model" property to fill in the card name.
This is a perfectly valid case, but everyone has missed the
opportunity to give this an actual friendly name. If you get to a
"desktop" and open the mixer properties in PulseAudio,
"imx51-babbage-sgtl5000" is not a particularly useful name, nor is
"MXC_SPDIF" (from the BSP, I always hated this) or "imx-spdif". This
is purely a nitpick at how this ends up in userspace, but it's kind of
important as it shows nobody is really caring about how these items
get represented in the real system.

A more reasonable and correct binding for ALL of this hardware,
whereby it would be able to determine all of the current information
while allowing a single set of parsing, configuring, stuffing handoff
data into card and dai stuff for ASoC is an actual tree structure, not
a large unwieldy single node which defines everything as peer
properties.

Maybe;

codec at b {
    controllers = <&ssi2>;
    audio-sinks = <&connector1>, <&connector1>, <&mic_in>;
    audio-sources = <&hp_l>, <&hp_r>, <&connector2>;
}

ssi2 at 7000000 {
   pinctrl-0 = <&audmux_ssi2_3_2>; // there's no reason a pinctrl node
has to JUST contain one property?
};

audmux_ssi2_3_2: as232 {
   fsl,pins = < ... >;
   fsl,audmux = < ... >;
};

sound {
   compatible = "fsl,imx51-audio", "fsl,imx-audio"; // if there IS
anything to workaround that's hardware-specific... we can still do
something
   model = "Front Audio Ports"; // this is not a 'compatible' or
'device_type', model is a freeform string that ALSA happens to make
user facing so make it nice
   codecs = <&codec>;
   controllers = <&ssi2>;

   connectors {
     connector1: c1 at 1 {
         compatible = "rca,audio-jack";
         model = "Speakers";
     }
   }

};

Yes, that's a lot of work, and a lot of it describes fixed properties
of the codecs, but where those fixed features are not used on a board
design, they can be ommitted..

The codec node could also maybe contain the audio-routing property (I
am not sure it ever turns out to really be 'card' specific), although
this is a complete SNAFU as well since none of the defined properties
match the hardware in the cases described above - they're defined by
picking what the existing Linux drivers used. "Ext Spk", for example,
in the SGTL5000 bindings is a Linuxism dragged into the tree. There
are many ways to define the actual hardware outputs depending on which
part of the docs you trust most, but strings like "LINE_OUT" "Ext Spk"
then this is not only poorly documented in it's intent, but erroneous
in describing actual hardware (if it's external pin/pads, none of the
names match the pad names in the electrical spec for SGTL5000, and a
couple of the internal connections are also misnamed..).

A cursory look at the actual code, and it turns out the audio-routing
property - which nVidia's drivers call nvidia,audio-routing and TI's
call ti,audio-routing by the way, which says a lot about the property
definition in itself - is defined as pairs of strings for "sink" and
"source" and I would nitpick about the order of those to be honest -
but the naming is totally defined by the driver logic.

~~~
  Each entry is a pair of strings, the first being the connection's sink,
  the second being the connection's source. Valid names could be power
  supplies, SGTL5000 pins, and the jacks on the board:

  Power supplies:
   * Mic Bias

  SGTL5000 pins:
   * MIC_IN
   * LINE_IN
   * HP_OUT
   * LINE_OUT

  Board connectors:
   * Mic Jack
   * Line In Jack
   * Headphone Jack
   * Line Out Jack
   * Ext Spk
~~~

nVidia's definition of nvidia,audio-routing:

~~~
  Each entry is a pair of strings, the first being the connection's sink,
  the second being the connection's source. Valid names for sources and
  sinks are the WM8903's pins (documented in the WM8903 binding document),
  and the jacks on the board:
~~~

Note the difference here. The nVidia doc says where these valid
sources and sink names come from. SGTL5000 does not (nor does WM8962
for that matter), it just lists a bunch in the "card" binding. So
these definitions are, as above, poorly documented and poorly defined,
and even if you make the assumption - they don't match the SGTL5000 or
WM8962 docs in the i.MX cases. Is the sink or source a freeform
string? Which one? In which cases?

Also, who says the connector on *my* board is called "Ext Spk"? On the
Efika MX, we actually call it the internal speaker because it's inside
the case. What if you had one connected to a 4- or 5-conductor jack
that supported stereo microphone on the same jack? Can you define a
sink and source twice (i.e. MIC_IN -> Headphone Jack and Headphone
Jack -> HP_OUT)? This isn't covered by ANY of the bindings, complex or
not (I can give a use case on a real board, but I don't have access to
it anymore) except in one real-life example. Those strings should be
freeform where the connector is board-specific, but they're actually
hardcoded into the drivers.

Every one of these is also seemingly going to have to also have a
custom set of controls for external amplifier (I have a use case on a
real board that I *do* have access to) or headphone jack insertion
gpio (TI use ti,jack-det-gpio, I need one on my board too..) which
while it is seemingly necessary to define them in the top level card
driver under Linux, doesn't describe the real connection at a hardware
level. They have been stuffed in the top level "card" node because of
the former..

I notice almost 90% code duplication in the drivers that run off these
nodes; fsl/imx-sgtl5000.c, fsl/imx-mc13783.c, fsl/imx-wm8962.c, (now)
fsl/eukrea-tvl320.c, mxs/mxs-sgtl5000.c and, ironically, since it uses
the wm8962 codec but it doesn't support device tree yet..
samsung/tobermory.c which if it got support for device tree would
probably be except for constant string definitions be line for line
identical to the imx one.

And duplicated functionality everywhere. I don't know how the i.MX
version of it ended up without a vendor prefix if ti and nvidia did
the same thing (in the case it got "standardized", how come nobody
updated the drivers to follow suit?)

>> should not be codec or platform specific at all. This is a TI audio
>> codec being referenced in an SoC-specific audio fabric definition.
>
> Please take a look at Morimoto-san's work on the generic sound card if
> you want to work on a generic card, it'd be good if some of the people
> complaining about this stuff could help him work on that as he doesn't
> seem to be getting any help or review from anyone.

I'll have a good look at it some more if I can find anything more than
the file in Linus' current tree and it's rather small history of
commits.. if anything new popped up it didn't hit my radar as I'm
apparently not subscribed to every Linux mailing list under the sun
(nor do I have the time to watch every one of them).

My understanding is that it should fix some of this, but what it also
seems to be doing is identifying some slightly weird design in the
ASoC framework as it goes:

in simple-card.c dai_init()
      ret = snd_soc_dai_set_sysclk(dai, 0, set->sysclk, 0);

in imx-sgtl5000.c dai_init()

    ret = snd_soc_dai_set_sysclk(rtd->codec_dai, SGTL5000_SYSCLK,
             data->clk_frequency, SND_SOC_CLOCK_IN);

In theory, the purpose of these functions is to notify the codec of a
change to one of it's input clocks. In what world where the clk_id and
the direction be able to be 0 from simple-card if every driver we can
see here seems to need something very specific?

Why would the card driver need to set the sysclk in a very
codec-specific way like this *at init time*? Surely this gets hammered
into the codec as it starts up it's first stream (and possibly torn
down by the upper layers afterwards, and informed again next stream)?

Same for setting the dai_fmt in the same places in both above drivers
(and all the rest).

Same for the bias level callbacks at the card level which are called
by abstraction from another part of the framework, but they nigh on
always set codec-level configuration items such as PLLs and sysclks in
most if not all cases. The codec has bias level callbacks too, which
get called after the card callbacks - I can't find a good example of
where snd_soc_card isn't ultimately dereferenced to snd_soc_dai or
snd_soc_codec member and then passed to lower level subsystems. They
never seem to do anything at the *card* level.

Such "one-time init" and weird layering is, I'm guessing and I haven't
looked too hard, a workaround for the framework not doing the right
thing while the drivers get up to scratch to be able to do the right
thing in the absence of some other functionality.. Surely the codec
should be able to query the other layers for this information at
runtime, or even set the "card" callbacks on codec probe? In whatever
situation, this information and structure shouldn't leak into device
tree bindings.

What we have right now is a single node trying to describe all the
properties and pointers, within itself, required to link these things
together in what ends up being a very Linux-specific way. What it
should be is a node which contains enough information to further walk
the tree and collect all the information based on some commonality
between other bindings (for instance, as above) without being scared
for it to link to a node and have that node contain a link to it's
logical (if not tree) parent.

What I'm looking at now needs a hell of a lot of thought, and all I
can say right now with certainty is not "how it should be" (yet) but
that what we have right now doesn't cut it, and only goes so far as to
use device trees as a place to shove platform_data.

Matt Sealey <neko@bakuhatsu.net>
