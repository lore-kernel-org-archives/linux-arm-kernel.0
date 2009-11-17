From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 17 Nov 2009 22:03:06 +0100
Subject: my IXP4xx patch queue
Message-ID: <m3bpj06f05.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've updated my IXP4xx git tree (it's still being mirrored from hera at
the moment). The usual disclaimer applies: it may be rebased at any
time.

git://git.kernel.org/pub/scm/linux/kernel/git/chris/linux-2.6.git ixp4xx
http://git.kernel.org/?p=linux/kernel/git/chris/linux-2.6.git

It includes (discussed earlier):

28b393 IXP4xx: change the timer base frequency to 66.666000 MHz.
3b739c IXP4xx: Fix normally-disabled debugging text in drivers/net/arm/ixp4xx_eth.c.
b7aa5a ARM: fix insl() and outsl() endianness on IXP4xx architecture.
1f6d89 IXP4xx: Ensure index is positive in irq_to_gpio() and npe_request().
7ea97d IXP4xx: Rename indirect MMIO primitives from __ixp4xx_* to __indirect_*.
78091c ARM: Introduce HAVE_IOREAD_AND_IOWRITE macro.
766853 IXP4xx: Drop "__ixp4xx_" prefix from in/out/ioread/iowrite functions for clarity.
c7c4c8 IXP4xx: Fix compilation failure with CONFIG_IXP4XX_INDIRECT_PCI.
c11693 IXP4xx: Extend PCI MMIO indirect address space to 1 GB.

and my latest stuff with which I'm trying to simplify the IXP4xx code:

072725 IXP4xx: move IXDP425 platform macros to the platform code.
13c284 IXP4xx: move AVILA platform macros to the platform code.
cb1f52 IXP4xx: move Coyote platform macros to the platform code.
cab003 IXP4xx: move NSLU2 platform macros to the platform code.
2abc9f IXP4xx: move NAS100D platform macros to the platform code.
b38cf7 IXP4xx: move DSM G600 platform macros to the platform code.
cd2939 IXP4xx: move FSG platform macros to the platform code.
b764f5 IXP4xx: Remove unused Motorola PrPMC1100 platform macros.
d09273 IXP4xx: move Gemtek GTWX5715 platform macros to the platform
code.

I'm not sure I like this one very much:

e13d20 IXP4xx: Introduce IXP4XX_GPIO_IRQ(n) macro and convert IXP4xx platform files.


Comments welcome as always.

I'll git-send-email the latest stuff now. No In-Reply-To:/References
since I think the mailserver will hold/drop any mail lacking "Re: "
with these headers.

 arch/arm/include/asm/io.h                     |    2 +-
 arch/arm/mach-ixp2000/include/mach/io.h       |    2 +

These 2 changes are parts of the HAVE_IOREAD_AND_IOWRITE patch.

 arch/arm/mach-ixp4xx/Kconfig                  |   22 +-
 arch/arm/mach-ixp4xx/avila-pci.c              |   42 ++--
 arch/arm/mach-ixp4xx/avila-setup.c            |    4 +-
 arch/arm/mach-ixp4xx/common-pci.c             |    6 +-
 arch/arm/mach-ixp4xx/common.c                 |    2 +-
 arch/arm/mach-ixp4xx/coyote-pci.c             |   22 +-
 arch/arm/mach-ixp4xx/coyote-setup.c           |    9 +
 arch/arm/mach-ixp4xx/dsmg600-pci.c            |   46 +++--
 arch/arm/mach-ixp4xx/dsmg600-setup.c          |   17 ++
 arch/arm/mach-ixp4xx/fsg-pci.c                |   31 ++-
 arch/arm/mach-ixp4xx/fsg-setup.c              |    8 +-
 arch/arm/mach-ixp4xx/goramo_mlr.c             |   45 ++--
 arch/arm/mach-ixp4xx/gtwx5715-pci.c           |   46 ++--
 arch/arm/mach-ixp4xx/gtwx5715-setup.c         |   30 +++-
 arch/arm/mach-ixp4xx/include/mach/avila.h     |   39 ----
 arch/arm/mach-ixp4xx/include/mach/coyote.h    |   33 ---
 arch/arm/mach-ixp4xx/include/mach/dsmg600.h   |   52 -----
 arch/arm/mach-ixp4xx/include/mach/fsg.h       |   50 -----
 arch/arm/mach-ixp4xx/include/mach/gpio.h      |    2 +-
 arch/arm/mach-ixp4xx/include/mach/gtwx5715.h  |  116 ----------
 arch/arm/mach-ixp4xx/include/mach/hardware.h  |   18 +-
 arch/arm/mach-ixp4xx/include/mach/io.h        |  292 ++++++++++---------------
 arch/arm/mach-ixp4xx/include/mach/irqs.h      |   69 +------
 arch/arm/mach-ixp4xx/include/mach/ixdp425.h   |   39 ----
 arch/arm/mach-ixp4xx/include/mach/nas100d.h   |   52 -----
 arch/arm/mach-ixp4xx/include/mach/npe.h       |    2 +-
 arch/arm/mach-ixp4xx/include/mach/nslu2.h     |   55 -----
 arch/arm/mach-ixp4xx/include/mach/prpmc1100.h |   33 ---
 arch/arm/mach-ixp4xx/include/mach/timex.h     |    2 +-
 arch/arm/mach-ixp4xx/ixdp425-pci.c            |   43 ++--
 arch/arm/mach-ixp4xx/ixdp425-setup.c          |   12 +-
 arch/arm/mach-ixp4xx/ixp4xx_npe.c             |    2 +-
 arch/arm/mach-ixp4xx/nas100d-pci.c            |   41 ++--
 arch/arm/mach-ixp4xx/nas100d-setup.c          |   16 ++-
 arch/arm/mach-ixp4xx/nslu2-pci.c              |   35 ++--
 arch/arm/mach-ixp4xx/nslu2-setup.c            |   21 ++-
 drivers/leds/leds-fsg.c                       |    7 +
 drivers/net/arm/ixp4xx_eth.c                  |    2 +-
 40 files changed, 460 insertions(+), 907 deletions(-)
-- 
Krzysztof Halasa
