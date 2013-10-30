From: neko@bakuhatsu.net (Matt Sealey)
Date: Wed, 30 Oct 2013 17:29:31 -0500
Subject: [PATCHv7][ 2/5] ASoC: eukrea-tlv320: Add DT support.
In-Reply-To: <20131030212927.GM2493@sirena.org.uk>
References: <1382616832-23593-1-git-send-email-denis@eukrea.com>
 <1382616832-23593-2-git-send-email-denis@eukrea.com>
 <20131025191513.5345BC4042C@trevor.secretlab.ca>
 <20131026114840.GX2443@sirena.org.uk>
 <CAHCPf3vHWt5XJCwvGDMfX9rTPKqHU43SHORqpxLtLaDL6RGb8A@mail.gmail.com>
 <20131029174445.GB20251@sirena.org.uk>
 <CAHCPf3sm9BawgCKrPH_mbD-Mhb-uXzSyZTjxhJf1W25pG3wZUA@mail.gmail.com>
 <20131030212927.GM2493@sirena.org.uk>
Message-ID: <CAHCPf3s46E=s85ohfqajr-VbavAM+gernXkkYeSwd4NYN8AEHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 4:29 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Oct 29, 2013 at 10:05:40PM -0500, Matt Sealey wrote:
>
>> To be specific, there are several "braindeadisms" in the current
>> bindings for mxs-audio-sgtl5000 and imx-audio-sgtl5000 and
>> imx-audio-wm8962 existing bindings which are being dragged into
>> Eukrea's bindings.
>
> *Please* also try to be a bit more concise and focused, this mail is
> very long and verbose for the amount of content in it.  As I said in my
> previous e-mail please review the previous extensive discussions on
> these topics and avoid going over old ground, similiarly like I said if
> you want to work on making things more generic that's great but please
> work with the people doing this already.
>
> Endlessly going over old ground and starting from scratch is not going
> to help move anything forward.
>
>> 1) saif-controllers and ssi-controller could be a single property -
>> controllers - which list the controller. It will be obvious which kind
>> of controller it is by delving into that node referenced by the
>> phandle.
>
> Picking a consistent name for this might be nice, yes.  Feel free to
> send patches...

When - if - I have time.

> To repeat yet again, if this concerns you please work with Morimoto-san
> on his generic card driver.  There are some code differences with clock
> setup for the devices which are encoded in the board definitions as
> well, plus the external connections.

Well the main crux of the problem here is that there's been a node
defined with a special compatible property that requires a special
device driver to marshall and collect nodes referenced within it - and
most of these drivers do exactly the same thing, which is why generic
card drivers seem like a good idea.

Where those things are generic it is not only a problem of code
duplication but a bad idea in "creating a special node" to marshall
it. The "sound" node here, with this special compatible property,
doesn't really exist in real hardware design, it exists within the
Linux kernel to allow it to construct a "card" out of a controller,
link and codec. If your SoC has a controller, link and codec, you
should be able to find ONE of them (I'd say start at the codec if it's
the last gasp between a programmers' view of hardware and the outside
world) and then walk the tree to collect the other driver information
required to build the abstract structure Linux requires.

>> 4) The drivers themselves just call imx_audmux_v2_foo() with the
>> contents of the mux-int-port and mux-ext-port properties - this is
>> Linux subsystem layout dictated by quickly and poorly architected
>
> I don't think anyone is happy with the audmux code but nobody has much
> interest in spending the time and effort on it so we're stuck just
> typing the data in statically.  If the situation improves we can always
> just ignore the properties in future.

Well, I am going to fix about 8 other things first, then figure this
out. I want my device tree actually IN the upstream kernel first, but
so far the only things that haven't changed under me are UART and
regulators.. good job that's the bare minimum, right?

> That's not what's going on here, let me once again ask you to review the
> previous discussion on device tree bindings and make sure that you
> understand the needs of advanced audio hardware.

There's no existing example of this advanced audio hardware, no
discussion about what would be required, only a vague assertion that
to build this abstract card structure in Linux, this is the only way
to do it.

Device trees don't exist to allow you to create all kinds of
marshalling structures to keep your data in a nice, concise place and
then "optimize" your Linux driver probe process. If it takes forever
to go through the entire device tree following links, doing probe
deferrals, so be it - you're meant to be pulling a hardware
description and mapping it to your software, not pushing your software
description into the wild.

>> codec at b {
>>     controllers = <&ssi2>;
>>     audio-sinks = <&connector1>, <&connector1>, <&mic_in>;
>>     audio-sources = <&hp_l>, <&hp_r>, <&connector2>;
>> }
>
> That's not going to scale well to boards that have inter CODEC analogue
> links, we'd need a node for every single thing that could be a source
> and sink on every device which seems tedious.

Yes, but I am not sure having a single property with pairs of strings
makes any more sense - sure, you require a node for each, but how does
just requiring a static string for each do this any better? Now you
need a string for each, which has to match a driver in Linux.. what
about another OS?

>> match the hardware in the cases described above - they're defined by
>> picking what the existing Linux drivers used. "Ext Spk", for example,
>> in the SGTL5000 bindings is a Linuxism dragged into the tree. There
>> are many ways to define the actual hardware outputs depending on which
>> part of the docs you trust most, but strings like "LINE_OUT" "Ext Spk"
>> then this is not only poorly documented in it's intent, but erroneous
>> in describing actual hardware (if it's external pin/pads, none of the
>> names match the pad names in the electrical spec for SGTL5000, and a
>> couple of the internal connections are also misnamed..).
>
> No, you've not understood what these are.  They are not the pads on the
> CODEC (as you can tell from the fact that the routing map connects the
> pads on the CODEC to them...), they are external things on the boards
> like transducers or jacks.

The binding documents for nVidia and TI name them after the pads on
the codec, and then gives out some really quite small list of possible
devices to connect on the end - Ext Spk is external, but it's
connected to LINE_OUT. What is worrying is LINE_OUT isn't defined in
the docs at all - it is an arbitrary mishmash across all bindings,
where they don't follow the docs, don't follow the docs even though
they say they do, and where there are no docs, someone has come up
with some arbitrary values which may need expanding, which requires
more bindings and more updates to support.

What frustrates me is that it has gone through the usual "if I type
less characters then it is better" workflow of Linux developers, and
copy pasting it out of the existing driver into the binding and then
into the trees meant no typing at all, just two swift mouse movements
and a middle click. That's what we're dealing with here, little care
about what the best practises have been (since *1993* for crying out
loud) since this is a brand new concept, and just a quick way of
getting your driver to be 'compliant' with this new movement.

> Feel free to send patches for the documentation if you feel that the
> documentation is not adequate for your needs.  Again I don't think it's
> terribly useful to spend much time bikeshedding the names, improving the
> documentation and adding a set of standard names that seem useful might
> be worthwhile.

"Standard names" won't cover the more complex use cases. Where it's an
internal signal or mixer output, it has to follow the docs. That's 85%
of what is there already (the other 15% is what I am frustrated about
where it doesn't match at all, making cross-referencing the manuals a
pain in the backside). Where it's an external signal it should be a
phandle to something. But mixing strings and phandles in a property as
an array is a real shitty thing to do (we discussed this a while back,
it works in Forth, it is not great in C, and it is one place where FDT
writing is very different to OF DT designing).

May as well make them all phandles and describe them properly. The
jack detection - even registering a jack since this is another part of
ASoC - should be properties under a jack node. Not a card node.
Something just needs to round these up, it needs a place to start.

It is tedious but you only have to do it once per board - or even per
SoC or codec since a lot of system designers just use what was on the
reference design and throw away what they don't need - then never
again. This work should be rolled into design tools, synthesis,
simulation, mux configuration tools like Freescale's, prebuilt
software libraries one day.. and if it's not, shame on the design
tools vendors. Altera have one already that will generate a device
tree based on prefab IP blocks and connections on their board.

>> > Please take a look at Morimoto-san's work on the generic sound card if
>> > you want to work on a generic card, it'd be good if some of the people
>> > complaining about this stuff could help him work on that as he doesn't
>> > seem to be getting any help or review from anyone.
>
>> I'll have a good look at it some more if I can find anything more than
>> the file in Linus' current tree and it's rather small history of
>> commits.. if anything new popped up it didn't hit my radar as I'm
>> apparently not subscribed to every Linux mailing list under the sun
>> (nor do I have the time to watch every one of them).
>
> There are patches on the list to add device tree bindings to it, which
> he's got precious little feedback on - this one e-mail from you is far
> more feedback by volume than he's had up until now.

I will take a peek, but I've lost a bunch of mails the past few
months. If I find it on an archive I'll do my best.

>> In theory, the purpose of these functions is to notify the codec of a
>> change to one of it's input clocks. In what world where the clk_id and
>> the direction be able to be 0 from simple-card if every driver we can
>> see here seems to need something very specific?
>
> We can't, one of the problems with this stuff is that clocking design
> (especially for the advanced use cases) is not as simple or general as
> one might desire for a bunch of totally sensible electrical engineering
> and system design reasons.  When we get to the point of deploying simple
> card widely it's just typing to define a standard constant that everyone
> can use for whatever the default sensible clocks are, and of course
> people working on simple card can do that as they're going.

I would have thought using the clock bindings, and judicious use of
clkdev internal to the codec or controller driver, would fix this.

This is the way it ends up for things like, say, i.MX graphics
(drivers/staging/imx-drm/ipu-v3/ipu-di.c:259 or so) because the clock
cannot be provided by device tree description as it is wonderfully
dynamic.

If the clock is entirely internal to the device and not sourced from
elsewhere, it should be defined and done this way in the driver. It
can pick up it's parent or source from the DT, as the above does.

I am not sure I understand why this isn't done.. maybe the whole "but
if I unload my module what happens to my clock tree?!" discussion
comes into it. I am not sure if that got solved...?

>> Same for the bias level callbacks at the card level which are called
>> by abstraction from another part of the framework, but they nigh on
>> always set codec-level configuration items such as PLLs and sysclks in
>> most if not all cases. The codec has bias level callbacks too, which
>> get called after the card callbacks - I can't find a good example of
>> where snd_soc_card isn't ultimately dereferenced to snd_soc_dai or
>> snd_soc_codec member and then passed to lower level subsystems. They
>> never seem to do anything at the *card* level.
>
> The particular decisions about what to do are a system integration
> decision, the system integration is a card decision since devices are in
> general flexible enough to support many system designs.

Right but it's a card decision that ends up rattling it's way down to
the codec. The card-level call resolves the codec and sets some
settings, the codec-level call does some other settings, in the end
this all ends up at the codec level by dereference.. so why would it
need to *be* defined at the card level in any of these cases? In all
of these cases, maybe not for all cases forever and ever, but the ones
we're looking at here where we have a goodly selection of codecs and
maybe 4 or 5 controllers and 2 or 3 implementations of each, there's
no reason for it.

This isn't really a DT issue but a really badly layered driver
approach that works for a bunch of systems, but *not these*.
generic/simple-card.c reproduces it anyway, which means if the driver
gets fixed, simple-card no longer acts as a proxy for it, and custom
code gets written.

I'll keep throwing some stuff around and we'll see what I come up
with. I definitely think my concise point is, though - the current
bindings define a Linux software abstraction to point at hardware, and
this shouldn't be the way it's done. The Linux code should deal with
the lack of hardware abstraction by parsing the tree in a different
way. The real thing to get our heads around is where we start, and I
think this has to be device_type = "sound" which has implications in
the original OF specs which make a lot of sense regarding marshalling
multiple components together.

Can you give any really good examples (block diagram?) of suitably
complex systems so I can get my head around what that parsing would be
like? Because none of the existing platforms go anywhere close to just
linking a controller to a codec. I have ONE platform where I could
possibly link two codecs to the same controller. The Efika MX routes
the same I2S bus from SSI to the HDMI codec and to the SGTL5000, so
you can have HDMI audio from a single source. Selecting one or the
other is necessary or you get output on the speaker AND on the TV or
receiver which is odd (and ever-so-slightly delayed). It never got
realistically implemented because the rate for the SGTL5000 would need
to be locked to one rate and bit width to work properly (you cannot
change the rate going into the HDMI transmitter without tearing down
the display, since it just encodes it as it gets it, there is limited
resampling but not a lot).

Thanks,
Matt Sealey <neko@bakuhatsu.net>
