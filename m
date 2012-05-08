From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 8 May 2012 14:44:30 +0000
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <20120508081710.GC15893@opensource.wolfsonmicro.com>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205071926.08810.arnd@arndb.de>
 <20120508081710.GC15893@opensource.wolfsonmicro.com>
Message-ID: <201205081444.30915.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 May 2012, Mark Brown wrote:
>   On Mon, May 07, 2012 at 07:26:08PM +0000, Arnd Bergmann wrote:
> 
> > Yes, it also does that, but have a look at how drivers/pci/pci.c uses
> > devres to attach auxiliary attributes to a device. We can do the same
> > thing for other devices to attach any data.
> 
> Actually, thinking about this further devres is definitely not what we
> want here: when the device is unbound it'll free all the resources it
> has for the device which is definitely not what we want for things like
> this.  We need the data to persist for as long as the device exists.

Yes, good point.

How about a IORESOURCE_REGMAP type then with the following semantics:
Each struct regmap gets an embedded resource that gets a unique
range in the IORESOURCE_REGMAP space using allocate_resource,
and each device using that can have its own sub-resources registered
to that.

Then we add a helper function that pulls out the regmap from the resource
using something like container_of(res->parent, struct regmap, resource)
and calculates the register number by subtracting the parent->start from
res->start.

	Arnd
