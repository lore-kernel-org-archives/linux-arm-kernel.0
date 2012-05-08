From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 8 May 2012 16:31:56 +0100
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <201205081444.30915.arnd@arndb.de>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205071926.08810.arnd@arndb.de>
 <20120508081710.GC15893@opensource.wolfsonmicro.com>
 <201205081444.30915.arnd@arndb.de>
Message-ID: <20120508153155.GW15893@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2012 at 02:44:30PM +0000, Arnd Bergmann wrote:

> How about a IORESOURCE_REGMAP type then with the following semantics:

The trick is allocating a bit for that flag, though I was thinking
earlier on we might be able to get away with carving it out of the bus
specific bits since I think anything using this wouldn't normally be
using resources for anything else except interrupts.  It does mean that
the resource type doesn't do the right thing though.

> Each struct regmap gets an embedded resource that gets a unique
> range in the IORESOURCE_REGMAP space using allocate_resource,
> and each device using that can have its own sub-resources registered
> to that.

> Then we add a helper function that pulls out the regmap from the resource
> using something like container_of(res->parent, struct regmap, resource)
> and calculates the register number by subtracting the parent->start from
> res->start.

That feels complicated with the subtraction there, but modulo that this
is roughly what's happening now.  We would I think want this to work for
non-regmap users too, it's not yet clear that every device with
registers is going to fit into regmap (though it's looking more likely
as things go on).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120508/d4e2a8c4/attachment.sig>
