From: broonie@kernel.org (Mark Brown)
Date: Tue, 15 Apr 2014 17:46:13 +0100
Subject: [RFC PATCH v2] regmap: smbus: add support for regmap over smbus
In-Reply-To: <534D357F.9040906@metafoo.de>
References: <1397292335-5516-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397480885-11962-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140414210429.GJ25182@sirena.org.uk>
 <534CE16D.8010508@free-electrons.com>
 <20140415100922.GN12304@sirena.org.uk>
 <534D1DDA.40207@free-electrons.com> <534D252B.8060009@metafoo.de>
 <20140415125654.GD12304@sirena.org.uk>
 <534D357F.9040906@metafoo.de>
Message-ID: <20140415164613.GF12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 03:34:55PM +0200, Lars-Peter Clausen wrote:
> On 04/15/2014 02:56 PM, Mark Brown wrote:

> >  - Providing APIs for registering actual smbus devices as a convenience
> >    for devices with that constraint, regardless of how that is done
> >    behind the scenes.

> >  - Having the I2C implementation automatically use the smbus APIs if
> >    it can and either the controller is smbus only or it makes sense to
> >    do so for optimisation.

> I don't think it makes sense to expose smbus explicitly. We can already
> describe smbus restricted devices just fine with the current regmap_config
> and already support them with the current I2C regmap implementation. Using

Please note what I said about convenience - if lots of devices have
exactly the same set of constraints to set up it's possible sensible to
have a standard way of specifying them.  It's going to be a bit easier
to just say it's smbus than to remember exactly what that means.

> native I2C to access these devices will be more efficient than going through
> the smbus emulation layer. The smbus emulation layer essentially does the
> same as we do in regmap, so using the smbus emulation layer through regmap
> means doing the same thing twice.

Right, that's why I said it's probably only worth it if the controller
does smbus natively.

> As I see it there are currently 3 cases:

> 1) Device is strictly smbus only and the controller supports native smbus
>    => Use smbus
> 2) The device is smbus compatible but has extensions (e.g. support for multi
> register writes) and the controller supports only smbus.
>    => Use smbus
> 3) For every other case
>    => Use native I2C.

It's not clear to me that if the controller supports smbus we shouldn't
use it; presumably it's adding some value to have written the code to
take advantage of it.  That would mean another case for device is smbus
only and controller has explicit smbus support.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140415/43481013/attachment.sig>
