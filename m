From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 31 Aug 2011 11:25:30 +0100
Subject: [PATCH] ARM: S3C64XX: Fix clkdev device names for I2C clocks
In-Reply-To: <CAJuYYwQikeoPbDX5DV4Y_HzOz2t04otLEUMye8CPpGLvhjwhyw@mail.gmail.com>
References: <1314739841-13522-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<CAH9JG2UEZVQ+5AJbbtXQhuVzvDp_8-wJdNgOjwHs14Zj7_KP+g@mail.gmail.com>
	<20110831002133.GA1164@opensource.wolfsonmicro.com>
	<CAJuYYwQikeoPbDX5DV4Y_HzOz2t04otLEUMye8CPpGLvhjwhyw@mail.gmail.com>
Message-ID: <20110831102530.GV2061@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2011 at 01:44:20PM +0530, Thomas Abraham wrote:

> There are two instances of clock with name i2c registered for s3c64xx.
> One has a devname and the other does not. So this continued to work.
> The i2c0 clock instance did not get a devname because its instance id
> was -1 (prior to clkdev support).

Not having devname will *work* - the problem is that it'll work too
often and return the wrong clock whenever anything goes wrong.

> If a devname is added to i2c0 clock instance for s3c64xx, it should be
> set to "s3c2440-i2c". If the devname is set to "s3c2440-i2c.0", then
> CONFIG_S3C_DEV_I2C1 will have to defined for s3c64xx, otherwise, as
> per arch/arm/plat-samsung/dev-i2c0.c, the platform device id for i2c0
> instance will be -1 and the clock lookup for i2c0 will fail.

All of which is just asking for fragility; the ifdefs for renumbering
the device are really unhelpful here - the system always has two I2C
controllers and the numbering is going to change depending on which
boards are built in so you can break things by enabling support for a
second board.

Frankly I'm not convinced that all this dancing about with explicitly
selecting which devices to enable is worth it; the space savings are
extremely small and the complexity regularly causes issues that just
shouldn't exist.
