From: neko@bakuhatsu.net (Matt Sealey)
Date: Thu, 31 Oct 2013 16:19:05 -0500
Subject: [PATCHv7][ 2/5] ASoC: eukrea-tlv320: Add DT support.
In-Reply-To: <20131031174549.GG2493@sirena.org.uk>
References: <1382616832-23593-2-git-send-email-denis@eukrea.com>
 <20131025191513.5345BC4042C@trevor.secretlab.ca>
 <20131026114840.GX2443@sirena.org.uk>
 <CAHCPf3vHWt5XJCwvGDMfX9rTPKqHU43SHORqpxLtLaDL6RGb8A@mail.gmail.com>
 <20131029174445.GB20251@sirena.org.uk>
 <CAHCPf3sm9BawgCKrPH_mbD-Mhb-uXzSyZTjxhJf1W25pG3wZUA@mail.gmail.com>
 <20131030212927.GM2493@sirena.org.uk>
 <CAHCPf3s46E=s85ohfqajr-VbavAM+gernXkkYeSwd4NYN8AEHw@mail.gmail.com>
 <20131031012830.GZ2493@sirena.org.uk>
 <CAHCPf3vUvg6w-OYO5yM8wj1Gr3p0xQZ=+bZ29ZKrZiQGAYektA@mail.gmail.com>
 <20131031174549.GG2493@sirena.org.uk>
Message-ID: <CAHCPf3tt8sbXnABUomg_w1ttBTgBQL=VNwsRoFazzuVdgzzO=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 12:45 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> Why some of those internal names don't match the manuals despite the
>> binding saying they do. It's because if you go through history of the
>
> Do you see any specific issues here?  It sounds like you're perfectly
> aware of what the bindings are supposed to be doing with routing signals
> to and from CODECs and have found some errors but you haven't told us
> what those are.

Yes, I can make a big list and even send a patch, but I think it's
putting a band-aid on a non-surgical limb amputation.

In summary, concisely:

* The internal components don't match the manuals they say they
follow, and that is if they even say they follow them at all.
* The external components names in the routing paths have arbitrary,
potentially non-real-life names and are hardcoded into the driver at
certain DAPM widgets, in order for the DAPM paths to work

What I've got going right now is, respectively:

* a 90% done rewrite of these bindings with no functional changes
(i.e. documentation clarification ONLY)
* a fully complete addition to the bindings and a patch to the drivers
that rationalizes the internal path name strings to the manuals (i.e.
documentation AND binding change with code to match)

That's basically the band-aid, but the second one is like rubbing salt
on the wound first because of the binding change. Given that "make
arbitrary strings less arbitrary" constitutes a binding change, this
is what both annoys and worries the piss out of me with the current
bindings.

What I am trying to figure out is a way to have real component names
for the external ones, and somehow codify the internal path naming, so
that if a binding change comes in, it's worth it, and drivers don't
need to include string names of parts of the chips in question, when
they're stuffed way, way down into some abstracted sub-layer anyway.

Close.. not there yet.

> Like I keep saying, do concrete things to move things forwards.

I don't want to be the source of an incremental, agile binding change
going on for every merge window, just because I didn't fully grasp one
issue right at the start.

>> All of which exist here. There are levels of indirection for a good
>> reason, I understand that, but in this implementation
>> card->set_bias_level calls functions which do purely codec-level
>> operations (set fll/mclk/sysclk), codec->set_bias_level does it's
>> obviously purely codec-level operations, and then
>> card->set_bias_level_post finishes up by doing some, again,
>> codec-level operations.
>
> To repeat myself yet again: what is done to the CODEC here is system
> dependent.  This includes interaction with other components in the
> system.

In this particular use case (init setting sysclk, and bias_level
callbacks setting sysclk and pll for WM8962), there is no system
dependency except a fixed, unchanging parent clock (it's fixed at card
init and NEVER updated) which the DT binding can solve really easily
by using the existing clock bindings. The only other example I can
find is the "Cragganmore 6410" board support (which mentions wm8692 in
passing, it seems) vs. specific speyside/wm8996/wm9081/wm1250/wm0010
audio support (which mostly all has your name at the top) and it
doesn't do anything "system dependent", either, except defining it in
the card layer, and doing things which only affect register changes at
the codec level. It doesn't even use or set data at the card layer.

If every implementation eventually gets down to a call inside the
actual codec driver, making the extra abstraction just something
that's fuzzing the issue, and reproducing the same layering in
separate drivers doing almost the same thing - only different by some
clock id and direction - is a lot of code with the potential for
consolidation under one roof with a DT binding that takes it into
account.

For the SGTL5000 case, setting the sysclk on init is overridden by the
DT provided clock anyway inside the codec driver (it gets the clock in
both places, and shoves the value) so this is a compatibility stub for
non-DT boards (none of which should exist by now).. it shouldn't do
anything if it's on devicetree (or at least, in every implementation
existing, it's basically pointless), which is a patch in itself I
should add to the list.

BTW speyside is a good demonstration of a pre-DT "hardcoded strings"
issue. The DAPM widgets get hardcoded and that's where those route
strings come from in the bindings (as above, they don't exist in the
drivers anymore).. it's entirely board-specific because that card
driver is board-specific, but for a single SoC, or even where SoCs use
codecs in exactly the same way, we shouldn't need to entertain a whole
new card driver where that information can be ascertained from the
device tree - that's what device trees are for! If it ever goes DT,
porting this to the DT bindings just means moving the audio routing
table from the middle of the driver into the tree, except this bit:

        { "MICB2", NULL, "Headset Mic", speyside_get_micbias },

.. which can't be represented and would mean parsing the routing
property, then hacking that callback in afterwards.

After that, it's ditching all the very-board-specific i2c addressing,
and it shows the same "system dependent" clocking and bias level
setting which essentially all calls down to the codec level. Would you
consider it a good example of the kind of linking of codecs and audio
interfaces you're talking about? Is there a block diagram? :)

Thanks,
Matt Sealey <neko@bakuhatsu.net>
