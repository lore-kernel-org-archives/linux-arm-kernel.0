From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Feb 2012 17:03:33 +0000
Subject: [PATCH 6/6] ARM: ux500: select I2C for U8500
In-Reply-To: <CACRpkdaYmScZKq9rT1z1MEQ4WwJC8Ow7vyS8zBB4r5Q7o6YJTQ@mail.gmail.com>
References: <1330199334-5133-1-git-send-email-mathieu.poirier@linaro.org>
 <201202291634.41686.arnd@arndb.de>
 <CACRpkdaYmScZKq9rT1z1MEQ4WwJC8Ow7vyS8zBB4r5Q7o6YJTQ@mail.gmail.com>
Message-ID: <201202291703.33907.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 February 2012, Linus Walleij wrote:
> > That's a different question: I2C is needed to build the kernel
> > successfully, while I2C_NOMADIK is (probably) needed to actually
> > run on a given hardware.
> >
> > We normally don't prevent people from selecting silly combinations
> > of config options, but we do try to make sure that any random
> > configuration actually builds.
> >
> > Maybe the answer is instead to remove the 'select TPS6105X'
> > and make sure the platform actually builds without I2C
> 
> Oh yeah wait that's the proper solution. Instead I get to update
> the defconfig to include necessary drivers.
> 
> I'll post a patch for this instead.

Ok, great!

I got one more build error when actually disabling CONFIG_I2C on ux500:

arnd at klappe2:~/linux-arm$ make O=obj-arm/  ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -s  -j3 -k
/git/arnd/linux-arm/arch/arm/mach-ux500/board-mop500-uib.c: In function 'mop500_uib_i2c_add':
/git/arnd/linux-arm/arch/arm/mach-ux500/board-mop500-uib.c:74:2: error: implicit declaration of function 'i2c_get_adapter' [-Werror=implicit-function-declaration]
/git/arnd/linux-arm/arch/arm/mach-ux500/board-mop500-uib.c:81:3: error: implicit declaration of function 'i2c_new_device' [-Werror=implicit-function-declaration]
/git/arnd/linux-arm/arch/arm/mach-ux500/board-mop500-uib.c:121:2: error: implicit declaration of function 'i2c_smbus_xfer' [-Werror=implicit-function-declaration]

I guess those need to be fixed, too. Ideally the API could just
get stubbed out for !CONFIG_I2C, but it might be easier to
conditionally build the code using it.

	Arnd
