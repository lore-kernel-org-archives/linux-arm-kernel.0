From: broonie@kernel.org (Mark Brown)
Date: Fri, 14 Aug 2015 17:40:00 +0100
Subject: [PATCH 09/20] regmap: _regmap_raw_write fix for busses without
 write()
In-Reply-To: <20150812130518.GM19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-10-git-send-email-mpa@pengutronix.de>
 <20150812112035.GX10748@sirena.org.uk>
 <20150812122011.GE19600@pengutronix.de>
 <20150812123406.GG10748@sirena.org.uk>
 <20150812130518.GM19600@pengutronix.de>
Message-ID: <20150814164000.GZ10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 03:05:18PM +0200, Markus Pargmann wrote:
> On Wed, Aug 12, 2015 at 01:34:06PM +0100, Mark Brown wrote:

> > > Yes right. On the other hand if bus->read() and bus->write() was not set
> > > in the init method (before this patch series) no formatting functions at
> > > all were assigned. So it was always ignored for bus->reg_read() and
> > > bus->reg_write()?!

> > I'm not sure what the "it" you're talking about here is, sorry.  There
> > are unsupported features in the API especially for cases that don't make
> > a huge amount of sense, the error handling isn't always complete.  It
> > sounds like you might be trying to support one of these nonsensical
> > cases - it's not obvious what raw I/O on a device where we don't know
> > the raw format of the device should mean or how anything could sensibly
> > use that.

> The bus and the regmap user are separate. So as a regmap user, I am not
> able to know if the bus the device is connected to actually supports raw
> reads/writes. At least it should not fail with a null pointer when using

You should generally have a pretty good idea simply by knowing which
device you're working with - unless you're writing generic code you know
which device you're working with and what it's capabilities are.  A
driver that doesn't know these things should never be trying to do raw
I/O, and a driver that is doing raw I/O clearly depends on having the
ability to get a bytestream to and from the device since that's what raw
I/O does.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150814/deb79824/attachment.sig>
