From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Aug 2016 11:23:28 +0100
Subject: [RFC PATCH 00/33] SA11x0/PXA GPIO rework (Core + PCMCIA only)
In-Reply-To: <20160829100232.GC1041@n2100.armlinux.org.uk>
References: <20160829100232.GC1041@n2100.armlinux.org.uk>
Message-ID: <20160829102328.GA28796@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following on from the PCMCIA fixes, this series reworks GPIO on SA11x0
and PXA platforms.  This is a subset of a larger series, which I'm
splitting up due to its size.  This part contains the base and PCMCIA
updates.  Further updates for IrDA drivers, DMA engine, serial, and
ethernet will follow in time.

Modern gpiolib provides us with a very flexible way to handle hardware
control and status signals without distributing board specifics in
drivers.  Legacy board files are able to describe the relationship
between physical GPIOs to drivers through gpio lookup tables, as well
as their polarity.

Drivers using the gpio descriptor APIs are able to lookup these GPIOs,
which may be optional, and binding to the appropriate GPIO provider.
What's even nicer is that this is forwards compatible with DT.

Several platforms provide "miscellaneous" control and status registers
which are very GPIO-like.  We add a fixed-direction GPIO driver to
gpiolib to support these, where the register address, number of GPIOs,
and their direction are all fixed at initialisation time.  This allows
(eg) the Assabet board control/status register, the Neponset control
and modem signal registers, and Lubbock miscellaneous write register
to be modelled as a set of GPIOs.

This permits us to implement reusable drivers for PCMCIA - we can
get rid of several board specific PCMCIA drivers in favour of a more
generic driver for the SoC.

Over the full series, we have a net increase in kernel LoC of less
than 200 lines, with the following significant changes:

 59 files changed, 1690 insertions(+), 1504 deletions(-)
 rename arch/arm/mach-sa1100/{include/mach => }/cerf.h (66%)
 delete mode 100644 arch/arm/mach-sa1100/include/mach/neponset.h
 rename arch/arm/mach-sa1100/{include/mach => }/nanoengine.h (69%)
 create mode 100644 drivers/gpio/gpio-reg.c
 create mode 100644 drivers/pcmcia/max1600.c
 create mode 100644 drivers/pcmcia/max1600.h
 delete mode 100644 drivers/pcmcia/sa1100_assabet.c
 delete mode 100644 drivers/pcmcia/sa1100_cerf.c
 delete mode 100644 drivers/pcmcia/sa1100_nanoengine.c
 create mode 100644 include/linux/gpio-reg.h
 delete mode 100644 include/linux/platform_data/irda-sa11x0.h
 delete mode 100644 include/linux/sa11x0-dma.h

However, deleting the unused SA-1101.h header file gives is a net
decrease in LoC.

For this series only:

 arch/arm/common/sa1111.c                    | 227 ++++++++++++++++++--------
 arch/arm/include/asm/hardware/sa1111.h      |   4 -
 arch/arm/mach-pxa/Kconfig                   |   1 +
 arch/arm/mach-pxa/lubbock.c                 |  40 ++++-
 arch/arm/mach-sa1100/Kconfig                |   1 +
 arch/arm/mach-sa1100/assabet.c              | 130 +++++++++++++--
 arch/arm/mach-sa1100/cerf.c                 |  18 ++-
 arch/arm/mach-sa1100/clock.c                |   2 +
 arch/arm/mach-sa1100/generic.c              |  14 +-
 arch/arm/mach-sa1100/generic.h              |   3 +
 arch/arm/mach-sa1100/h3xxx.c                |  17 ++
 arch/arm/mach-sa1100/include/mach/assabet.h |   6 -
 arch/arm/mach-sa1100/jornada720.c           |  12 ++
 arch/arm/mach-sa1100/nanoengine.c           |  23 +++
 arch/arm/mach-sa1100/neponset.c             | 172 +++++++++++++-------
 arch/arm/mach-sa1100/shannon.c              |  13 ++
 arch/arm/mach-sa1100/simpad.c               |  12 ++
 drivers/gpio/Kconfig                        |   6 +
 drivers/gpio/Makefile                       |   1 +
 drivers/gpio/gpio-reg.c                     | 139 ++++++++++++++++
 drivers/gpio/gpio-sa1100.c                  | 218 ++++++++++++++++---------
 drivers/pcmcia/Kconfig                      |   5 +
 drivers/pcmcia/Makefile                     |   3 +-
 drivers/pcmcia/max1600.c                    | 119 ++++++++++++++
 drivers/pcmcia/max1600.h                    |  31 ++++
 drivers/pcmcia/sa1100_assabet.c             | 106 -------------
 drivers/pcmcia/sa1100_cerf.c                |  92 -----------
 drivers/pcmcia/sa1100_generic.c             | 129 +++++++++++++--
 drivers/pcmcia/sa1100_generic.h             |   3 -
 drivers/pcmcia/sa1100_h3600.c               |  16 +-
 drivers/pcmcia/sa1100_nanoengine.c          | 133 ----------------
 drivers/pcmcia/sa1100_shannon.c             |  29 +---
 drivers/pcmcia/sa1100_simpad.c              |  16 +-
 drivers/pcmcia/sa1111_generic.h             |   1 +
 drivers/pcmcia/sa1111_jornada720.c          |  81 ++++++----
 drivers/pcmcia/sa1111_lubbock.c             | 110 +++----------
 drivers/pcmcia/sa1111_neponset.c            |  79 +++------
 drivers/pcmcia/soc_common.c                 | 238 +++++++++++++++++++---------
 drivers/pcmcia/soc_common.h                 |  24 ++-
 include/linux/gpio-reg.h                    |  12 ++
 40 files changed, 1400 insertions(+), 886 deletions(-)
 create mode 100644 drivers/gpio/gpio-reg.c
 create mode 100644 drivers/pcmcia/max1600.c
 create mode 100644 drivers/pcmcia/max1600.h
 delete mode 100644 drivers/pcmcia/sa1100_assabet.c
 delete mode 100644 drivers/pcmcia/sa1100_cerf.c
 delete mode 100644 drivers/pcmcia/sa1100_nanoengine.c
 create mode 100644 include/linux/gpio-reg.h

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
