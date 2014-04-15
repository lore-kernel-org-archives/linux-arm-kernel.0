From: broonie@kernel.org (Mark Brown)
Date: Tue, 15 Apr 2014 13:56:54 +0100
Subject: [RFC PATCH v2] regmap: smbus: add support for regmap over smbus
In-Reply-To: <534D252B.8060009@metafoo.de>
References: <1397292335-5516-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397480885-11962-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140414210429.GJ25182@sirena.org.uk>
 <534CE16D.8010508@free-electrons.com>
 <20140415100922.GN12304@sirena.org.uk>
 <534D1DDA.40207@free-electrons.com> <534D252B.8060009@metafoo.de>
Message-ID: <20140415125654.GD12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 02:25:15PM +0200, Lars-Peter Clausen wrote:
> On 04/15/2014 01:54 PM, Boris BREZILLON wrote:

> >And, should I keep one method to register an smbus regmap or should I
> >provide one method per access type and get rid of the
> >regmap_smbus_transfer_type enum ?

> I don't think we should leave the decision which bus to use to the driver.
> Neither should the driver have to choose whether to use smbus or native I2C.
> We want to use native I2C when available, because it is more efficient than
> going through the smbus emulation layer. On the other hand we want to
> automatically switch to smbus when native I2C is not available and the
> device can work fine with smbus. Also I'm afraid that we'll otherwise soon
> see code popping up like:

I have to say I'd misread the commit message (due to the multiple copies
that arrived before I actually reviewed it I think I just skimmed it and
went into incremental review) and was reviewing this as being for
*device* limitations not controller ones.  That also matches with what
Boris was saying about not being able to decide to use the word or byte
at a time operations automatically, though the commit message does say
it's about controller limitations.

> My suggestion is that in regmap_init_i2c() you check the capabilities of the
> I2C adapter. If it supports native I2C you setup the regmap with the
> regmap_i2c struct just as it does right now. If the adapter does not support
> native I2C, check if the device can be supported by smbus (reg_bytes == 8 &&
> val_bytes % 8 == 0). For each type of smbus operations have one regmap_bus
> struct, and if you can fallback to smbus choose the bus depending on the
> config's val_bytes.

That'd definitely be useful but potentially orthogonal, we can also do
both and expose smbus explicitly with I2C falling back to it
transparently.

If the device *is* limited to smbus and the controller supports both
(some do) I'd naively have expected that the native smbus support would
do a little better - otherwise why bother using it?  We could identify
the constraint set automatically for I2C devices though it's more for
the client driver to specify.

This means there's two changes to consider here:

 - Providing APIs for registering actual smbus devices as a convenience
   for devices with that constraint, regardless of how that is done
   behind the scenes.

 - Having the I2C implementation automatically use the smbus APIs if
   it can and either the controller is smbus only or it makes sense to
   do so for optimisation.

both of which are independently useful.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140415/980758da/attachment.sig>
