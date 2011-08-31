From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 31 Aug 2011 01:21:33 +0100
Subject: [PATCH] ARM: S3C64XX: Fix clkdev device names for I2C clocks
In-Reply-To: <CAH9JG2UEZVQ+5AJbbtXQhuVzvDp_8-wJdNgOjwHs14Zj7_KP+g@mail.gmail.com>
References: <1314739841-13522-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<CAH9JG2UEZVQ+5AJbbtXQhuVzvDp_8-wJdNgOjwHs14Zj7_KP+g@mail.gmail.com>
Message-ID: <20110831002133.GA1164@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2011 at 08:48:03AM +0900, Kyungmin Park wrote:

> It's not matched with your description. and also not matched with
> codes at "arch/arm/mach-s3c64xx/s3c6410.c"

>        /* the i2c devices are directly compatible with s3c2440 */
>         s3c_i2c0_setname("s3c2440-i2c");
>         s3c_i2c1_setname("s3c2440-i2c");

Oh, FFS.  That's what's broken - the names that are actually appearing
in the system are the names that the devices have in the relevant
dev-i2c?.c files and obviously there's no reason one would expect to
find code like the above since it's just a little abstruse to rewrite
the devices like that.

Looking at the code I bet what broke it is the CPU revision
identification changes - it's now responsible for making sure the fixups
are run.  Either it's not matching correctly or it's running too late to
make the fixup before the device is registered.

Though the first part of the issue (the fact that I2C0 isn't using a
device name and I2C1 is) remains an issue.
