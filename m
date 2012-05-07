From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 May 2012 20:58:03 +0100
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <201205071926.08810.arnd@arndb.de>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205071509.55166.arnd@arndb.de>
 <20120507151744.GI17002@opensource.wolfsonmicro.com>
 <201205071926.08810.arnd@arndb.de>
Message-ID: <20120507195802.GB15893@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2012 at 07:26:08PM +0000, Arnd Bergmann wrote:
> On Monday 07 May 2012, Mark Brown wrote:
> > On Mon, May 07, 2012 at 03:09:54PM +0000, Arnd Bergmann wrote:
> > > On Monday 07 May 2012, Mark Brown wrote:

> > > > Given what I'm saying about platform devices above perhaps we should be
> > > > factoring some of the platform device stuff up to struct device level.

> > > Isn't that what devres is for? We should be able to just attach arbitrary
> > > data to a device with this, e.g. a struct regmap to use for doing I/O
> > > that a driver can use. Maybe we should add some wrappers around that
> > > to make it more obvious to use.

> > Not as far as I understand it, it's more about making error handling and
> > unregistration code less error prone by automating the freeing of
> > things when a device goes away or probe() fails.  The managed versions

> Yes, it also does that, but have a look at how drivers/pci/pci.c uses
> devres to attach auxiliary attributes to a device. We can do the same
> thing for other devices to attach any data.

Right, but that's essentially just the bus doing the equivalent of
devm_kzalloc() to allocate some private data which is a separate thing.
It doesn't really address the problem of passing information from
registration code to the device through the bus which is what the
resource API is currently doing for these devices.

We probably should be making a bit more use of devres for this than we
are (using it to bounce through a regmap isn't a bad idea, I might just
do that though a lot of the time you need the parent internal data
struct anyway) but it's a separate thing.

Something like pulling the type out of the flags in struct resource to
give us a bit more space (or replace the bits with a pointer, though
that's even more invasive) would address this more...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120507/564ed995/attachment.sig>
