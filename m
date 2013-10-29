From: neko@bakuhatsu.net (Matt Sealey)
Date: Tue, 29 Oct 2013 11:56:54 -0500
Subject: [PATCHv7][ 2/5] ASoC: eukrea-tlv320: Add DT support.
In-Reply-To: <20131026114840.GX2443@sirena.org.uk>
References: <1382616832-23593-1-git-send-email-denis@eukrea.com>
 <1382616832-23593-2-git-send-email-denis@eukrea.com>
 <20131025191513.5345BC4042C@trevor.secretlab.ca>
 <20131026114840.GX2443@sirena.org.uk>
Message-ID: <CAHCPf3vHWt5XJCwvGDMfX9rTPKqHU43SHORqpxLtLaDL6RGb8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 26, 2013 at 6:48 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Oct 25, 2013 at 08:15:13PM +0100, Grant Likely wrote:
>> On Thu, 24 Oct 2013 14:13:49 +0200, Denis Carikli <denis@eukrea.com> wrote:
>
>> > +- mux-int-port : The internal port of the i.MX audio muxer (AUDMUX).
>> > +- mux-ext-port : The external port of the i.MX audio muxer.
>
>> > +Note: The AUDMUX port numbering should start at 1, which is consistent with
>> > +hardware manual.
>
>> Looks okay to me. I've not been following the sound bindings very
>> closely. Are the described properties a common pattern for sound complex
>> bindings?
>
> They're standard for i.MX - it's a mux within the SoC.

And these bindings all suck, which is not a fault of Eukrea. There
shouldn't be yet another duplication of the sound{} node though.

There is nothing specific to Eukrea in any of this. This is a TI audio
codec connected via i.MX SSI and routed through the SoC fabric by one
or another i.MX AUDMUX port.

Maybe this is a reasonable place to ask since I am holding off on
doing any audio support for the i.MX platform I want to push a DT for,
and I am still bashing my head over the logic in this. Why is this so
much more complicated than it needs to be? I can see codec specific
and Linux-specific things floating in trees. I can see redundancy in
property naming and misplacement of properties.. this whole thing
needs to be cleaned up because it's been done as "binding a Linux
driver into the device tree" and this is another example of the same
thing - taking the way ASoC is working right now and dumping platform
data externally.

The existing MXS and IMX SGTL5000 bindings are not SGTL5000 specific.
The sound node references a phandle for a codec - those properties
should be present in the codec node. In this vein, Eukrea's bindings
should not be codec or platform specific at all. This is a TI audio
codec being referenced in an SoC-specific audio fabric definition.

The better way of thinking here is to stop being so insular with
bindings. One binding for all these SoCs would suffice; codecs are
codec-specific and codec properties like audio routing from mixers to
pins should not be in the audio fabric definition. You can find the
codec from the existing binding; you can find the controller. One
thing it NEVER refers to is the audmux controller.. but it does
magically specify the internal and external ports required.. and all
the drivers (so far, sgtl5000 and wm8962) magically know what they're
doing here.

It is NOT some kind of undefined, unholy evil to reach outside of the
node you found the compatible property of to look elsewhere - the
fabric driver in this case has all the capability to dereference the
codec, controller, audiomux etc. nodes it's got phandles to, and find
the properties it needs to stuff into the handoff data for dai and
dapm. Sure, you can have a generic driver have some codec-specific
stuff in there where it has to be handled externally to a codec
driver.. This just shows there should be another level in the driver
subsystem (actually there sort of is already, isn't there?).

As it stands; Neither imx-sgtl5000.c or imx-wm8962.c do anything with
the controller or codec nodes except to stuff it into a handoff data
structure for the rest of the subsystem to glue ASoC together.
eukrea-tlv320.c is the same way even in this patch and imx-mc13783 is
languishing..

They are essentially line-for-line identical except a couple hacks
here and there - things that are understandably outside of the control
of the codec driver itself.  Some of it could even be driven down to
lower levels of the subsystem.

What we should have is something simpler and more "realistic" vs.
hardware design, and imx-sgtl5000, imx-wm8962, imx-mc13783, and
eukrea-tlv320 should be merged into a single fabric driver with a
single all-encompassing and altogether simpler binding.Please don't
continue to layer crappier parts of the Linux abstractions into the
device tree. The device tree should present the structure and layout
of the devices - not of the OS subsystems involved. Parsing the device
tree at various points in the subsystems - even if you end up doing it
3 times over - is the correct way. Not to try and consolidate and
optimize your tree to make your drivers smaller.

As it stands this could be easily changed right now with a couple
tweaks; compatibility can be maintained with the older bindings, too.
I'll write it up (binding def at least, I can't fix the drivers in a
reasonable time, unfortunately) and throw it out tonight if we're all
agreeable..

-- 
Matt Sealey <neko@bakuhatsu.net>
