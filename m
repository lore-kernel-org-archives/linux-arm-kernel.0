From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 May 2012 15:06:35 +0100
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <201205071314.51886.arnd@arndb.de>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205071014.03632.arnd@arndb.de>
 <20120507103724.GF4415@opensource.wolfsonmicro.com>
 <201205071314.51886.arnd@arndb.de>
Message-ID: <20120507140634.GD17002@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2012 at 01:14:51PM +0000, Arnd Bergmann wrote:

> There are two distinct problems here:

> * conflicts in request_resource() between stuff that is in fundamentally
>   different.
> * defining the __io() address space to have a zero offset, which causes
>   NULL pointer dereferences in legacy ISA drivers.

Right, though in the MFD case neither of these things should be relevant
as the resources should never actually be used in this way.

> My feeling is that the resource model is just hasn't moved along
> with the times (predates and doesn't really map to the device model) and
> is used in a consistent way (request_resource, allocate_resource and
> request_region operate on the same types, but in different ways).
> It's not clear to me whether it makes sense to continue this path
> for new kinds of resources.

This is true.  On the other hand there's some infrastructure around
resources which is pretty helpful, though now I look at it most of this
is actually specific to platform devices rather than being a platform
device wrapper for a generic thing.  Things like platform_get_resource()
are pretty good to use, and in the context of platform devices the whole
resource conflict thing is normally pretty much irrelevant.

> My understanding is also that the uses in MFD (e.g. max8925 and wm831x)
> are only interested in the aspect of passing information to child devices
> rather than arbitrating between conflicting accesses. If that's the case,
> a separate mechanism that doesn't use a global numbering scheme might
> be more appropriate.

Given what I'm saying about platform devices above perhaps we should be
factoring some of the platform device stuff up to struct device level.
Another option would be to work on separating the management of the
number spaces and the interfaces for getting the numbers back out to
make it easier to add more number spaces.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120507/5b4129d5/attachment.sig>
