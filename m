From: ralf@linux-mips.org (Ralf Baechle)
Date: Mon, 9 Oct 2017 16:24:03 +0200
Subject: [PATCH 1/7] i2c: gpio: Convert to use descriptors
In-Reply-To: <20170917093906.16325-2-linus.walleij@linaro.org>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-2-linus.walleij@linaro.org>
Message-ID: <20171009142403.GA17971@linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 17, 2017 at 11:39:00AM +0200, Linus Walleij wrote:

> This converts the GPIO-based I2C-driver to using GPIO
> descriptors instead of the old global numberspace-based
> GPIO interface. We:
> 
> - Convert the driver to unconditionally grab two GPIOs
>   from the device by index 0 (SDA) and 1 (SCL) which
>   will work fine with device tree and descriptor tables.
>   The existing device trees will continue to work just
>   like before, but without any roundtrip through the
>   global numberspace.
> 
> - Brutally convert all boardfiles still passing global
>   GPIOs by registering descriptor tables associated with
>   the devices instead so this driver does not need to keep
>   supporting passing any GPIO numbers as platform data.
> 
> There is no stepwise approach as elegant as this, I
> strongly prefer this big hammer over any antsteps for this
> conversion. This way the old GPIO numbers go away and
> NEVER COME BACK.
> 
> Special conversion for the different boards utilizing
> I2C-GPIO:
> 
> - EP93xx (arch/arm/mach-ep93xx): pretty straight forward as
>   all boards were using the same two GPIO lines, just define
>   these two in a lookup table for "i2c-gpio" and register
>   these along with the device. None of them define any
>   other platform data so just pass NULL as platform data.
>   This platform selects GPIOLIB so all should be smooth.
>   The pins appear on a gpiochip for bank "G" as pins 1 (SDA)
>   and 0 (SCL).
> 
> - IXP4 (arch/arm/mach-ixp4): descriptor tables have to
>   be registered for each board separately. They all use
>   "IXP4XX_GPIO_CHIP" so it is pretty straight forward.
>   Most board define no other platform data than SCL/SDA
>   so they can drop the #include of <linux/i2c-gpio.h> and
>   assign NULL to platform data.
> 
>   The "goramo_mlr" (Goramo Multilink Router) board is a bit
>   worrisome: it implements its own I2C bit-banging in the
>   board file, and optionally registers an I2C serial port,
>   but claims the same GPIO lines for itself in the board file.
>   This is not going to work: there will be competition for the
>   GPIO lines, so delete the optional extra I2C bus instead, no
>   I2C devices are registered on it anyway, there are just hints
>   that it may contain an EEPROM that may be accessed from
>   userspace. This needs to be fixed up properly by the serial
>   clock using I2C emulation so drop a note in the code.
> 
> - KS8695 board acs5k (arch/arm/mach-ks8695/board-acs5.c)
>   has some platform data in addition to the pins so it needs to
>   be kept around sans GPIO lines. Its GPIO chip is named
>   "KS8695" and the arch selects GPIOLIB.
> 
> - PXA boards (arch/arm/mach-pxa/*) use some of the platform
>   data so it needs to be preserved here. The viper board even
>   registers two GPIO I2Cs. The gpiochip is named "gpio-pxa" and
>   the arch selects GPIOLIB.
> 
> - SA1100 Simpad (arch/arm/mach-sa1100/simpad.c) defines a GPIO
>   I2C bus, and the arch selects GPIOLIB.
> 
> - Blackfin boards (arch/blackfin/bf533 etc) for these I assume
>   their I2C GPIOs refer to the local gpiochip defined in
>   arch/blackfin/kernel/bfin_gpio.c names "BFIN-GPIO".
>   The arch selects GPIOLIB. The boards get spiked with
>   IF_ENABLED(I2C_GPIO) but that is a side effect of it
>   being like that already (I would just have Kconfig select
>   I2C_GPIO and get rid of them all.) I also delete any
>   platform data set to 0 as it will get that value anyway
>   from static declartions of platform data.
> 
> - The MIPS selects GPIOLIB and the Alchemy machine is using
>   two local GPIO chips, one of them has a GPIO I2C. We need
>   to adjust the local offset from the global number space here.
>   The ATH79 has a proper GPIO driver in drivers/gpio/gpio-ath79.c
>   and AFAICT the chip is named "ath79-gpio" and the PB44
>   PCF857x expander spawns from this on GPIO 1 and 0. The latter
>   board only use the platform data to specify pins so it can be
>   cut altogether after this.
> 
> - The MFD Silicon Motion SM501 is a special case. It dynamically
>   spawns an I2C bus off the MFD using sm501_create_subdev().
>   We use an approach to dynamically create a machine descriptor
>   table and attach this to the "SM501-LOW" or "SM501-HIGH"
>   gpiochip. We use chip-local offsets to grab the right lines.
>   We can get rid of two local static inline helpers as part
>   of this refactoring.
> 
> Cc: Steven Miao <realmz6@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Ville Syrj?l? <ville.syrjala@linux.intel.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Ben Dooks <ben.dooks@codethink.co.uk>
> Cc: Heiko Schocher <hs@denx.de>
> Acked-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Fix a minor typo in error path (scl was sda from copy-paste)
> - Collected Olof's ACK
> 
> Steven (Blackfin): requesting ACK for Wolfram to take this patch.
> Ralf (MIPS): requesting ACK for Wolfram to take this patch.
> Lee: requesting ACK for Wolfram to take this patch.
> SM501 users: requesting Tested-by on this patch.
> ---
>  arch/arm/mach-ep93xx/core.c                  |  39 ++++----
>  arch/arm/mach-ep93xx/edb93xx.c               |  15 +--
>  arch/arm/mach-ep93xx/include/mach/platform.h |   4 +-
>  arch/arm/mach-ep93xx/simone.c                |  12 +--
>  arch/arm/mach-ep93xx/snappercl15.c           |  12 +--
>  arch/arm/mach-ep93xx/vision_ep9307.c         |   7 +-
>  arch/arm/mach-ixp4xx/avila-setup.c           |  17 +++-
>  arch/arm/mach-ixp4xx/dsmg600-setup.c         |  16 +++-
>  arch/arm/mach-ixp4xx/fsg-setup.c             |  16 +++-
>  arch/arm/mach-ixp4xx/goramo_mlr.c            |  24 ++---
>  arch/arm/mach-ixp4xx/ixdp425-setup.c         |  16 +++-
>  arch/arm/mach-ixp4xx/nas100d-setup.c         |  16 +++-
>  arch/arm/mach-ixp4xx/nslu2-setup.c           |  16 +++-
>  arch/arm/mach-ks8695/board-acs5k.c           |  13 ++-
>  arch/arm/mach-pxa/palmz72.c                  |  12 ++-
>  arch/arm/mach-pxa/viper.c                    |  27 +++++-
>  arch/arm/mach-sa1100/simpad.c                |  12 ++-
>  arch/blackfin/mach-bf533/boards/blackstamp.c |  19 +++-
>  arch/blackfin/mach-bf533/boards/ezkit.c      |  18 +++-
>  arch/blackfin/mach-bf533/boards/stamp.c      |  18 +++-
>  arch/blackfin/mach-bf561/boards/ezkit.c      |  18 +++-
>  arch/mips/alchemy/board-gpr.c                |  19 +++-
>  arch/mips/ath79/mach-pb44.c                  |  16 +++-

For MIPS:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
