From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 May 2012 16:26:27 +0000
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <20120509160747.GA10241@n2100.arm.linux.org.uk>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205091243.13206.arnd@arndb.de>
 <20120509160747.GA10241@n2100.arm.linux.org.uk>
Message-ID: <201205091626.27829.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 May 2012, Russell King - ARM Linux wrote:
> Instead, we should be having per-device resources trees.  So, for instance,
> an I2C device with two functions, function 1 say owns register indices
> 0-0x3f and function 2 owns 0x40-0x7f.  We should have:
> 
> struct i2c_blah_driver_info {
>         struct resource reg_res;
> };
> 
>         priv->reg_res.start = 0;
>         priv->reg_res.end = 0x7f;
>         priv->reg_res.flags = 0;
> 
>         subdev1->resource[0].start = 0;
>         subdev1->resource[0].end = 0x3f;
>         subdev1->resource[0].flags = 0;
> 
>         ret = request_resource(&priv->reg_res, &subdev1->resource[0]);
>         /* check ret */
> 
>         subdev2->resource[0].start = 0x40;
>         subdev2->resource[0].end = 0x7f;
>         subdev2->resource[0].flags = 0;
> 
>         ret = request_resource(&priv->reg_res, &subdev2->resource[0]);
>         /* check ret */
> 
> This means that we end up with lots of per-device resource trees rooted
> at the top-level-device driver, each effectively with their own separate
> name spaces.

Ah, I had not realized that this is possible. In this case, it certainly
makes sense to have a separate space for each device that provides a
register range.

> Do we care about making them appear in procfs?  I suspect at this stage
> that would be wrong.  If we care at all, they should probably be per-
> top-level-device sysfs files - and we should have a function which sysfs
> can use along with the root resource to create that output.

If the resources have separate roots, I see no way how to make them
all appear in the same procfs file. Having them represented in sysfs
the way you describe sounds useful but not important.

	Arnd
