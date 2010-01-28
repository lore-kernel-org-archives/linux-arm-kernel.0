From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 28 Jan 2010 07:05:18 +0000
Subject: Problems with device compilation by subsystem config
Message-ID: <20100128070518.GS10014@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having just had a discussion with Jasswinder Singh Brar about device
definitions, I had a closer look at the dev-audio.c building in
arch/arm/plat-s3c64xx and have several comments and questions from
this.

For reference, the relvant bits of arch/arm/plat-s3c64xx/Makefile:

    49  obj-$(CONFIG_SND_S3C24XX_SOC) += dev-audio.o
    50  obj-$(CONFIG_SPI_S3C64XX) += dev-spi.o

My first response is that this forces the user to rebuild the kernel
every time they decide to change the subsytems included, which if just
building things as modules isn't nice. However this wasn't a strong enough
objection at the time to reject the patches.

People might say that building everything is a waste of kernel space, but
we cluttering mach-xxx.c with #ifdefs is also not pleasant, and if we have
as currently for many of the other devices CONFIG to build the devices
selected by the machine then we are reasonably efficient.

The second item, which is the actual observed problem is when such a
subsystem or drive is selected as a module. This means in the case of
CONFIG_SPI_S3C64XX=m or CONFIG_SND_S3C24XX_SOC=m then these support
files will end up being built as modules and thus the mach-xxx.c will
not be able to reference, and as such my test branch fails:

arch/arm/mach-s3c6410/built-in.o:(.init.data+0xa4): undefined reference to `s3c64xx_device_spi0'

Now, I've had a preference in the past to use S3C_DEV_xxx to select the
devices where it makes sense not to build in just as a preference as it
made sense to me. Now, it seems to be a fortuitous piece of good planning
to not depend on the selected devie support.

To fix thsi I propose changing the SPI and Audio support to have their
own 'config S3C_DEV_xxx' entries which are selected by the boards that
use them (this removes the need for #ifdef in the board file) and these
entries should not be dependant on the subsytem defines.

Note, the CONFIG_REGULATOR in mach-smdk6410.c shouldn't be a problem as the
regulator driver core is a boolean optopn.

Second Note, building as many devies as possible ensures that we have build
coverage of as much of the core SoC support as possible.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
