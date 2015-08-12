From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 12 Aug 2015 15:17:50 +0200
Subject: [PATCH 10/20] regmap: _regmap_raw_multi_reg_write: Add
 reg_write() support
In-Reply-To: <20150812123923.GI10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-11-git-send-email-mpa@pengutronix.de>
 <20150812123923.GI10748@sirena.org.uk>
Message-ID: <20150812131750.GO19600@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 01:39:23PM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:12:35PM +0200, Markus Pargmann wrote:
> > Define a fallback for busses which do not define a write() function.
> > Instead we write one register at a time using reg_write().
> > 
> > Without this patch, _regmap_raw_multi_reg_write would break as it tries
> > to call bus->write() without checking if it exists before.
> 
> Why are we trying to use multi write APIs in the first place if we can't
> do raw I/O?

Because we may not know if the bus supports raw IO and I would prefer
if it is not necessary to know in the driver that just uses the regmap
API if the underlying bus supports it.

Sorry this patch is wrong, instead it should set can_multi_write
properly depending on the availability of map->bus->write(). The code
would already handle multi writes then.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/24bf2036/attachment.sig>
