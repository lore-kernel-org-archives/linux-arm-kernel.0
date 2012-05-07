From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 7 May 2012 15:09:54 +0000
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <20120507140634.GD17002@opensource.wolfsonmicro.com>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205071314.51886.arnd@arndb.de>
 <20120507140634.GD17002@opensource.wolfsonmicro.com>
Message-ID: <201205071509.55166.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 May 2012, Mark Brown wrote:
> On Mon, May 07, 2012 at 01:14:51PM +0000, Arnd Bergmann wrote:
> 
> > There are two distinct problems here:
> 
> > * conflicts in request_resource() between stuff that is in fundamentally
> >   different.
> > * defining the __io() address space to have a zero offset, which causes
> >   NULL pointer dereferences in legacy ISA drivers.
> 
> Right, though in the MFD case neither of these things should be relevant
> as the resources should never actually be used in this way.

Well, particularly patch 2 of this series introduces those problems,
but yes, it should be a separate issue.

> > My feeling is that the resource model is just hasn't moved along
> > with the times (predates and doesn't really map to the device model) and
> > is used in a consistent way (request_resource, allocate_resource and
> > request_region operate on the same types, but in different ways).
> > It's not clear to me whether it makes sense to continue this path
> > for new kinds of resources.
> 
> This is true.  On the other hand there's some infrastructure around
> resources which is pretty helpful, though now I look at it most of this
> is actually specific to platform devices rather than being a platform
> device wrapper for a generic thing.  Things like platform_get_resource()
> are pretty good to use, and in the context of platform devices the whole
> resource conflict thing is normally pretty much irrelevant.

Right.

> > My understanding is also that the uses in MFD (e.g. max8925 and wm831x)
> > are only interested in the aspect of passing information to child devices
> > rather than arbitrating between conflicting accesses. If that's the case,
> > a separate mechanism that doesn't use a global numbering scheme might
> > be more appropriate.
> 
> Given what I'm saying about platform devices above perhaps we should be
> factoring some of the platform device stuff up to struct device level.
> Another option would be to work on separating the management of the
> number spaces and the interfaces for getting the numbers back out to
> make it easier to add more number spaces.

Isn't that what devres is for? We should be able to just attach arbitrary
data to a device with this, e.g. a struct regmap to use for doing I/O
that a driver can use. Maybe we should add some wrappers around that
to make it more obvious to use.

	Arnd
