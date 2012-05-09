From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 May 2012 17:07:47 +0100
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <201205091243.13206.arnd@arndb.de>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205081444.30915.arnd@arndb.de>
 <20120508153155.GW15893@opensource.wolfsonmicro.com>
 <201205091243.13206.arnd@arndb.de>
Message-ID: <20120509160747.GA10241@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 12:43:13PM +0000, Arnd Bergmann wrote:
> I think the subtraction in some form is needed if you want to register
> the resources, to guarantee that they are non-conflicting. Registering
> them has the advantage that we can print them in a similar way to what
> we do for /proc/{ioports,iomem}.

You don't need to - you only need them non-conflicting if they're part of
the same tree.

It seems to me that having all device register resources being part of
the same tree is the wrong approach, it's certainly the wrong model for
this kind of thing.

Instead, we should be having per-device resources trees.  So, for instance,
an I2C device with two functions, function 1 say owns register indices
0-0x3f and function 2 owns 0x40-0x7f.  We should have:

struct i2c_blah_driver_info {
	struct resource reg_res;
};

	priv->reg_res.start = 0;
	priv->reg_res.end = 0x7f;
	priv->reg_res.flags = 0;

	subdev1->resource[0].start = 0;
	subdev1->resource[0].end = 0x3f;
	subdev1->resource[0].flags = 0;

	ret = request_resource(&priv->reg_res, &subdev1->resource[0]);
	/* check ret */

	subdev2->resource[0].start = 0x40;
	subdev2->resource[0].end = 0x7f;
	subdev2->resource[0].flags = 0;

	ret = request_resource(&priv->reg_res, &subdev2->resource[0]);
	/* check ret */

This means that we end up with lots of per-device resource trees rooted
at the top-level-device driver, each effectively with their own separate
name spaces.

If we care about marking resources busy to avoid drivers conflicting, I
would also suggest that we augment the resource interfaces so that we can
have mark_resource_busy(dev, res, drivername) which takes the 'bus'
resource and adds the IORESOURCE_BUSY resource below it.  I'd also suggest
at this point that we don't have a corresponding release function for this
as I believe we should be using devm stuff internally for this now.

Do we care about making them appear in procfs?  I suspect at this stage
that would be wrong.  If we care at all, they should probably be per-
top-level-device sysfs files - and we should have a function which sysfs
can use along with the root resource to create that output.
