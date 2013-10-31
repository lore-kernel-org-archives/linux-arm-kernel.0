From: neko@bakuhatsu.net (Matt Sealey)
Date: Thu, 31 Oct 2013 10:32:00 -0500
Subject: [PATCHv7][ 2/5] ASoC: eukrea-tlv320: Add DT support.
In-Reply-To: <20131031012830.GZ2493@sirena.org.uk>
References: <1382616832-23593-1-git-send-email-denis@eukrea.com>
 <1382616832-23593-2-git-send-email-denis@eukrea.com>
 <20131025191513.5345BC4042C@trevor.secretlab.ca>
 <20131026114840.GX2443@sirena.org.uk>
 <CAHCPf3vHWt5XJCwvGDMfX9rTPKqHU43SHORqpxLtLaDL6RGb8A@mail.gmail.com>
 <20131029174445.GB20251@sirena.org.uk>
 <CAHCPf3sm9BawgCKrPH_mbD-Mhb-uXzSyZTjxhJf1W25pG3wZUA@mail.gmail.com>
 <20131030212927.GM2493@sirena.org.uk>
 <CAHCPf3s46E=s85ohfqajr-VbavAM+gernXkkYeSwd4NYN8AEHw@mail.gmail.com>
 <20131031012830.GZ2493@sirena.org.uk>
Message-ID: <CAHCPf3vUvg6w-OYO5yM8wj1Gr3p0xQZ=+bZ29ZKrZiQGAYektA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 8:28 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Oct 30, 2013 at 05:29:31PM -0500, Matt Sealey wrote:
>> On Wed, Oct 30, 2013 at 4:29 PM, Mark Brown <broonie@kernel.org> wrote:
>> > On Tue, Oct 29, 2013 at 10:05:40PM -0500, Matt Sealey wrote:
>
>> > Picking a consistent name for this might be nice, yes.  Feel free to
>> > send patches...
>
>> When - if - I have time.
>
> Please consider prioritising this over writing e-mails; talking about
> device tree does often seem more popular than solving the harder
> problems.

If it doesn't get talked about, what happens is people copy paste crap
from unreviewed bindings or just make things up and throw them at the
tree. If there's no discussion about it, how do people find the
information they need (there's no documentation, and no.. I don't feel
like writing any because it mostly already exists. Device trees aren't
something that appeared a year and a half ago and are new
technology.).

Right now I don't think I can actually come up with a binding for
these things, what I can say is I can throw something simple out here;

* Cover the SGTL5000 and WM8962 and TLV320 case for i.MX
* Be a good framework for future device support and parsing
* Not solve any "hardcoded driver strings" issue
* Reduce functional driver code
* Increase the amount of DT parsing that gets done (a healthy
trade-off for the above)

Am I going to cover all cases? No idea.. I don't have the right
information, and it's not on the 'previous discussions' I could
review, there are no block diagrams, I can't trapse through 150 codec
and controller specs to figure it out if you want patches.

>> Yes, but I am not sure having a single property with pairs of strings
>> makes any more sense - sure, you require a node for each, but how does
>> just requiring a static string for each do this any better? Now you
>> need a string for each, which has to match a driver in Linux.. what
>> about another OS?
>
> Look at where the names come from...

What I get is...

audio-routing = "sink", "source", "sink", "source", und so weiter.

Either sink or source could be internal (therefore probably be in the
codec or controller manual) or external component (headphone jack,
internal speaker, magic codec link).

What I don't get is..

Why some of those internal names don't match the manuals despite the
binding saying they do. It's because if you go through history of the
driver, they were hardcoded into the driver originally or someone took
the prefix off a preprocessor macro and dumped it in the tree. Someone
threw underscores in or took them out or aren't reading the manual
properly. This can slide as long as the bindings are consistent per
codec binding and my worry is, they are only consistent because there
are <= 2 bindings per codec and where it's >1, it's a copy paste from
the first.

Why the external names seem to be hardcoded into the drivers - the
behavior of those external names in what they control is also fixed
per-driver in the default definitions of the widgets. What
audio-routing describes is the path between hardcoded audio paths in
the DAPM domain (which may be some of the above), and the fixed names
of some pre-defined DAPM widgets, which have fixed types in the
driver.

While it wouldn't necessarily be ASoC DAPM specific, the binding here
makes no attempt whatsoever to define what these might be, or even
their purpose - the tree properties have no 'knowledge' built into
them except to allow Linux to do some associative array tricks. Adding
flags to say this is a headphone, this is a microphone, this is a
named mixer control would end up being Linux-specific (perhaps even
version-specific). But there's no attempt whatsoever to move the
information on the audio paths into the tree so all 'cards' can
eventually just probe for their connections.

As it stands, the SGTL5000 is so simple it only has microphone in (and
bias out for the 32pin package), headphone out, line in, line out.

Thing is, line out doesn't mean always connect an external speaker
here.. nor could there be a jack at all for the headphone socket (who
knows.. ) but that description is hardcoded in the 'card' driver.
Which means for every SoC, every codec, implemented on each board,
there needs to be a magic card driver. Sure, this is fine, but this
isn't how a board is designed, around a magic concept of a collection
of audio components as a single, isolated entity that needs to be
described in a 'collection' node. This is how Linux is designed (the
concept of a "sound card" is almost redundant on the consumer PC space
too) and how Linux wants to parse it because it maps 1:1 to the way
it's driver model works. That's not right.

>> I would have thought using the clock bindings, and judicious use of
>> clkdev internal to the codec or controller driver, would fix this.
>
> The clock configuration bindings don't currently exist, won't cover the
> dynamic cases and won't help non-DT platforms.
>  Remember also that we
> don't even have a clock API of any kind on a good proportion at the
> minute and don't have the common clock API on some of the rest.

Yergh.

>> this all ends up at the codec level by dereference.. so why would it
>> need to *be* defined at the card level in any of these cases? In all
>
> This is the sort of information that you should be able to discover if
> you review the previous discussions.

Reviewing, not finding the information I really need here..

>> of these cases, maybe not for all cases forever and ever, but the ones
>> we're looking at here where we have a goodly selection of codecs and
>> maybe 4 or 5 controllers and 2 or 3 implementations of each, there's
>> no reason for it.
>
> One of the devices you're looking at here is WM8962 - it does actually
> have the ability to do a bunch of the things that make decisions about
> clocking interesting.

I understand why the Linux driver model here does it this way, what I
am asking is why is this done in the current driver implementations
this way? Why define bias level settings for audio paths at the "card"
level (thus creating a need for a special card driver in these
implementations) when snd_soc_dapm_set_bias_level calls

card->set_bias_level
codec->set_bias_level
card->set_bias_level_post

All of which exist here. There are levels of indirection for a good
reason, I understand that, but in this implementation
card->set_bias_level calls functions which do purely codec-level
operations (set fll/mclk/sysclk), codec->set_bias_level does it's
obviously purely codec-level operations, and then
card->set_bias_level_post finishes up by doing some, again,
codec-level operations.

If the current WM8962 bias level ops were rolled into the codec driver
where all the magic happens anyway, card->set_bias_level does nothing,
codec->set_bias_level does the right thing, card->set_bias_level_post
does nothing, and supplementally the codec driver can pick up it's own
clock (ironically the i.MX6 device tree passes it a clock, but the
codec driver ignores it) - the "imx-wm8962" collector becomes
*completely* generic apart from some hardcoded dapm widgets, and is
more suitable for replacement by simple-card.c.

Same goes for imx-sgtl5000, and both suffer the "inline, hardcoded
audmux settings" problem, which can be moved out of the "marshalling"
driver to support code in the sense that both of them do *identical*
operations based on identical properties.

DRM has this same problem, it's been designed around probing a single,
hotpluggable entity which collects a bunch of components somewhere,
initialized internally in a batch at probe time. An nVidia card may
have an i2c bus on some GPU logic somewhere, which talks to an
external transmitter, and it works because the GPU driver will
*create* an i2c bus for that GPU, register it with the i2c subsystem,
add a hardcoded set of devices, and then go ahead and use them later
by reference.

This isn't how SoCs or embedded systems are designed, it is not how
device trees are parsed and it is also not how drivers are probed
against them in Linux.

What's needed, really, is a way of marshalling the information for
Linux's card abstraction. Luckily, device trees from 20 years ago had
this already - device_type = "sound" (or device_type = "display" for
the above case). They were defined and used in a time when they
represented an API to do function calls against them (i.e. sound had
ops to play a sound, display had ops to.. well, do nothing) and they
ended up being single-chip devices with some bare minimum support
logic. The reason they're dirt simple device tree descriptuons in
every implementation is because sound devices were headphone and
microphone and maybe an internal speaker with no power management
worth a damn, and display devices were identically dumb (we're talking
about soundblaster and cirrus logic 2D kind of era, the same kind of
HW you can bring up on any ancient version of QEMU).

With a bit more complexity (understatement), the description has to
get more complicated. SoC clocks and pad mux definitions are a good
example (big love to the TI guys for making a dent in this) where the
bindings are well-formed, but you do end up with sprawling, monster
trees. This is the only way to actually describe the hardware without
hardcoding it inside the kernel, though.

We can't just say "device type is sound" anymore, but we can use it as
a marker for collecting the complexity of the audio components. In
this case, inputs and outputs are codec-based and the rest is fabric.
This is where the device_type = "sound" lives. Linux would need to
parse the tree to find a "sound" device_type and then figure out where
all the codecs, buses and controllers and dma channels and interrupts
go, right now this is thankfully frightfully simple since the card
abstraction is quite well defined.

For now there aren't any codec->codec links on any board I can find,
so I can't even see how they're linked let alone think of a spec for
defining it. I will start with the simplest case (where it works on
i.MX and Samsung boards since they are the closest to doing it
correctly and taking advantage of generic cards, and because I have
enough i.MX boards and access to a couple Samsungs that I can test it
on) and work outwards. You can always add new properties to a binding,
but changing the existing ones and node layouts is a pain - this is
why it needs discussing and laying down and fixed in stone for the
future and why I want it not to keep layering and layering.

The Eukrea guys can just as well put this in the tree (how could I
even stop them?) since it suffers the same solvable problems and they
can (will, if I put my mind to it) be solved later, but there is a
much better way to do this globally, and I'd like to hash it out as a
design and not an agile codebase which leaves everyone wondering when
it'll be done or how it affects the board support they're writing for
their board.

Matt Sealey <neko@bakuhatsu.net>
