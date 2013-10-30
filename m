From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Oct 2013 14:29:27 -0700
Subject: [PATCHv7][ 2/5] ASoC: eukrea-tlv320: Add DT support.
In-Reply-To: <CAHCPf3sm9BawgCKrPH_mbD-Mhb-uXzSyZTjxhJf1W25pG3wZUA@mail.gmail.com>
References: <1382616832-23593-1-git-send-email-denis@eukrea.com>
 <1382616832-23593-2-git-send-email-denis@eukrea.com>
 <20131025191513.5345BC4042C@trevor.secretlab.ca>
 <20131026114840.GX2443@sirena.org.uk>
 <CAHCPf3vHWt5XJCwvGDMfX9rTPKqHU43SHORqpxLtLaDL6RGb8A@mail.gmail.com>
 <20131029174445.GB20251@sirena.org.uk>
 <CAHCPf3sm9BawgCKrPH_mbD-Mhb-uXzSyZTjxhJf1W25pG3wZUA@mail.gmail.com>
Message-ID: <20131030212927.GM2493@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 10:05:40PM -0500, Matt Sealey wrote:

> To be specific, there are several "braindeadisms" in the current
> bindings for mxs-audio-sgtl5000 and imx-audio-sgtl5000 and
> imx-audio-wm8962 existing bindings which are being dragged into
> Eukrea's bindings.

*Please* also try to be a bit more concise and focused, this mail is
very long and verbose for the amount of content in it.  As I said in my
previous e-mail please review the previous extensive discussions on
these topics and avoid going over old ground, similiarly like I said if
you want to work on making things more generic that's great but please
work with the people doing this already.

Endlessly going over old ground and starting from scratch is not going
to help move anything forward.

> 1) saif-controllers and ssi-controller could be a single property -
> controllers - which list the controller. It will be obvious which kind
> of controller it is by delving into that node referenced by the
> phandle.

Picking a consistent name for this might be nice, yes.  Feel free to
send patches...

> 2) audio-codec is redundantly named as we're defining audio devices
> here.. but it should/could be "codecs" since it should be an array of
> phandles just like controllers (there's no reason you can't have
> multiple codecs attached to the same i2s bus, it's just not entirely
> common).

I don't think bikeshedding the name is a worthwhile activity.  

If you want to convert it into an array you're adding substantial
complication to both defining the link and the software required to
support it, it's definitely specialist hardware time and there's a lot
of ways that cat can be skinned.

> 3) the compatible properties define a specific board and codec style
> which simply isn't used in the drivers, because there's no opportunity
> to use it. The only reason 3 different compatible properties exist are
> to probe the 3 different drivers which all do nearly exactly the same
> thing - collect controllers, codecs, the routing information (for
> power management, of all reasons..) and stuff them in a handoff
> structure to allow ASoC to individually probe components.

To repeat yet again, if this concerns you please work with Morimoto-san
on his generic card driver.  There are some code differences with clock
setup for the devices which are encoded in the board definitions as
well, plus the external connections.

> 4) The drivers themselves just call imx_audmux_v2_foo() with the
> contents of the mux-int-port and mux-ext-port properties - this is
> Linux subsystem layout dictated by quickly and poorly architected

I don't think anyone is happy with the audmux code but nobody has much
interest in spending the time and effort on it so we're stuck just
typing the data in statically.  If the situation improves we can always
just ignore the properties in future.

> A lot of it comes from this weird concept that for every file in Linux
> that can probe on it's own, a device tree needs to somehow define ONE
> node per file, and define platform properties in that node. This comes
> eventually from the platform_data concept the original drivers were
> written against.

> Writing device tree bindings is not about looking an an existing
> driver, platform, or private data structure and creating a new node

That's not what's going on here, let me once again ask you to review the
previous discussion on device tree bindings and make sure that you
understand the needs of advanced audio hardware.

> 5) for some reason the drivers picking up these nodes do some really
> strange things like use the "model" property to fill in the card name.
> This is a perfectly valid case, but everyone has missed the
> opportunity to give this an actual friendly name. If you get to a
> "desktop" and open the mixer properties in PulseAudio,
> "imx51-babbage-sgtl5000" is not a particularly useful name, nor is
> "MXC_SPDIF" (from the BSP, I always hated this) or "imx-spdif". This
> is purely a nitpick at how this ends up in userspace, but it's kind of
> important as it shows nobody is really caring about how these items
> get represented in the real system.

So submit patches changing people's model names in the DTSs for the
affected boards to be something you find more pleasing...  that's what
they're there for.  I imagine that the people using these boards aren't
using UIs that present the names to the user and hence didn't care.

In any case this doesn't seem to be anything to do with the device tree
bindings, if you want to complain about specific DTS files go and talk
to them.

> codec at b {
>     controllers = <&ssi2>;
>     audio-sinks = <&connector1>, <&connector1>, <&mic_in>;
>     audio-sources = <&hp_l>, <&hp_r>, <&connector2>;
> }

That's not going to scale well to boards that have inter CODEC analogue
links, we'd need a node for every single thing that could be a source
and sink on every device which seems tedious.

> match the hardware in the cases described above - they're defined by
> picking what the existing Linux drivers used. "Ext Spk", for example,
> in the SGTL5000 bindings is a Linuxism dragged into the tree. There
> are many ways to define the actual hardware outputs depending on which
> part of the docs you trust most, but strings like "LINE_OUT" "Ext Spk"
> then this is not only poorly documented in it's intent, but erroneous
> in describing actual hardware (if it's external pin/pads, none of the
> names match the pad names in the electrical spec for SGTL5000, and a
> couple of the internal connections are also misnamed..).

No, you've not understood what these are.  They are not the pads on the
CODEC (as you can tell from the fact that the routing map connects the
pads on the CODEC to them...), they are external things on the boards
like transducers or jacks.

Feel free to send patches for the documentation if you feel that the
documentation is not adequate for your needs.  Again I don't think it's
terribly useful to spend much time bikeshedding the names, improving the
documentation and adding a set of standard names that seem useful might
be worthwhile.

> > Please take a look at Morimoto-san's work on the generic sound card if
> > you want to work on a generic card, it'd be good if some of the people
> > complaining about this stuff could help him work on that as he doesn't
> > seem to be getting any help or review from anyone.

> I'll have a good look at it some more if I can find anything more than
> the file in Linus' current tree and it's rather small history of
> commits.. if anything new popped up it didn't hit my radar as I'm
> apparently not subscribed to every Linux mailing list under the sun
> (nor do I have the time to watch every one of them).

There are patches on the list to add device tree bindings to it, which
he's got precious little feedback on - this one e-mail from you is far
more feedback by volume than he's had up until now.

> In theory, the purpose of these functions is to notify the codec of a
> change to one of it's input clocks. In what world where the clk_id and
> the direction be able to be 0 from simple-card if every driver we can
> see here seems to need something very specific?

We can't, one of the problems with this stuff is that clocking design
(especially for the advanced use cases) is not as simple or general as
one might desire for a bunch of totally sensible electrical engineering
and system design reasons.  When we get to the point of deploying simple
card widely it's just typing to define a standard constant that everyone
can use for whatever the default sensible clocks are, and of course
people working on simple card can do that as they're going.

> Why would the card driver need to set the sysclk in a very
> codec-specific way like this *at init time*? Surely this gets hammered
> into the codec as it starts up it's first stream (and possibly torn
> down by the upper layers afterwards, and informed again next stream)?

A large proportion of systems (especially simple ones) have a fixed
master clock for audio, telling it what rate it's running at is
orthogonal to starting and stopping it (assuming that control even
exists).

> Same for setting the dai_fmt in the same places in both above drivers
> (and all the rest).

It is vanishingly rare (though possible and possibly even sensible in
extremely unusual situations) for the system to want to reconfigure the
DAI format dynamically at runtime.  No point in doing the same thing
over and over again...

> Same for the bias level callbacks at the card level which are called
> by abstraction from another part of the framework, but they nigh on
> always set codec-level configuration items such as PLLs and sysclks in
> most if not all cases. The codec has bias level callbacks too, which
> get called after the card callbacks - I can't find a good example of
> where snd_soc_card isn't ultimately dereferenced to snd_soc_dai or
> snd_soc_codec member and then passed to lower level subsystems. They
> never seem to do anything at the *card* level.

The particular decisions about what to do are a system integration
decision, the system integration is a card decision since devices are in
general flexible enough to support many system designs.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131030/d3569dfb/attachment.sig>
