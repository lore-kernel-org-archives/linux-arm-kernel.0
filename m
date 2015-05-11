From: broonie@kernel.org (Mark Brown)
Date: Mon, 11 May 2015 15:09:38 +0100
Subject: [PATCH 2/2] Regulator: add driver for Freescale MC34708
In-Reply-To: <555070A7.2060808@parkeon.com>
References: <20150428141740.16243.79036.stgit@localhost>
 <20150430194552.GE22845@sirena.org.uk>
 <555070A7.2060808@parkeon.com>
Message-ID: <20150511140938.GA3458@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 11, 2015 at 11:04:39AM +0200, Martin Fuzzey wrote:

Please leave blank lines between paragraphs and between old text and new
text, it makes things a lot easier to read - this is extremely difficult
to follow.

> On 30/04/15 21:45, Mark Brown wrote:
> >On Tue, Apr 28, 2015 at 04:17:40PM +0200, Martin Fuzzey wrote:
> >>Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> >Please use subject lines reflecting the style for the subsystem.

> You mean
> regulator: mc34708: Add driver?

> I ommitted the mc34708 part because it's a new driver

That and the fact that you spelt regulator Regulator.

> >Ick, this looks confusing - it's wrapping something which should hopefully
> >be a regmap in multiple layer.  The bitfield access helper does seem
> >reasonable though.

> The reason for this wrapping stuff is that this is not a standalone driver,
> rather a "subdriver" of the mc13xxx MFD driver.
> That already exists and supports the mc34708 (for the RTC for example) but
> not yet the regulator parts.
> It does not expose regmap (although it does use it internally).

Well, fix that then...

> Would you be happier if I rename this to mc34708_set_bitfield() for example?

I guess, it would probably be preferable to go with the more common
_update_bits() pattern though.

> Then the way I handle all this is just use mc34708_sw_find_hw_mode_sel() to
> recalculate the hardware mode by walking the tables every time something
> needs to change.
> The table is different depending on the regulator type.
> 
> This turned out to be *much* simpler that the initial open code approach I
> first tried.

This all needs to be apparent to someone reading the code.  Probably
having comments about what individual functions are supposed to be doing
would help a lot here.

> >I don't really understand what the above is supposed to do, some
> >comments would probably help.

> We need to store the desired modes (for normal and standby state) since
> .set_mode() and .set_suspend_mode() are not always called before enable() /
> disable().

The point is that this needs to be something someone reading the code
could reasonably be expected to understand.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150511/0b2dbba1/attachment.sig>
