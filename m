From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 31 Aug 2011 13:44:20 +0530
Subject: [PATCH] ARM: S3C64XX: Fix clkdev device names for I2C clocks
In-Reply-To: <20110831002133.GA1164@opensource.wolfsonmicro.com>
References: <1314739841-13522-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<CAH9JG2UEZVQ+5AJbbtXQhuVzvDp_8-wJdNgOjwHs14Zj7_KP+g@mail.gmail.com>
	<20110831002133.GA1164@opensource.wolfsonmicro.com>
Message-ID: <CAJuYYwQikeoPbDX5DV4Y_HzOz2t04otLEUMye8CPpGLvhjwhyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 August 2011 05:51, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Aug 31, 2011 at 08:48:03AM +0900, Kyungmin Park wrote:
>
>> It's not matched with your description. and also not matched with
>> codes at "arch/arm/mach-s3c64xx/s3c6410.c"
>
>> ? ? ? ?/* the i2c devices are directly compatible with s3c2440 */
>> ? ? ? ? s3c_i2c0_setname("s3c2440-i2c");
>> ? ? ? ? s3c_i2c1_setname("s3c2440-i2c");
>
> Oh, FFS. ?That's what's broken - the names that are actually appearing
> in the system are the names that the devices have in the relevant
> dev-i2c?.c files and obviously there's no reason one would expect to
> find code like the above since it's just a little abstruse to rewrite
> the devices like that.
>
> Looking at the code I bet what broke it is the CPU revision
> identification changes - it's now responsible for making sure the fixups
> are run. ?Either it's not matching correctly or it's running too late to
> make the fixup before the device is registered.
>
> Though the first part of the issue (the fact that I2C0 isn't using a
> device name and I2C1 is) remains an issue.

There are two instances of clock with name i2c registered for s3c64xx.
One has a devname and the other does not. So this continued to work.
The i2c0 clock instance did not get a devname because its instance id
was -1 (prior to clkdev support).

If a devname is added to i2c0 clock instance for s3c64xx, it should be
set to "s3c2440-i2c". If the devname is set to "s3c2440-i2c.0", then
CONFIG_S3C_DEV_I2C1 will have to defined for s3c64xx, otherwise, as
per arch/arm/plat-samsung/dev-i2c0.c, the platform device id for i2c0
instance will be -1 and the clock lookup for i2c0 will fail.

Regards,
Thomas.
