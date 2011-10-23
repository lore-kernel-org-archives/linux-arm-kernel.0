From: zdevai@gmail.com (Zoltan Devai)
Date: Sun, 23 Oct 2011 10:18:29 +0200
Subject: [RFC][PATCH] uncompress.h cleanup and DT support
Message-ID: <CAGVye5MSqdxh0DzCMt79sKk+Z0Trfro0RNDr-4zccMh7O7vGiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Originally, I just wanted to get rid of arch_decomp_* in all the uncompress.h
files, that were mostly empty. But then, I couldn't stop. Which may also mean
I have gone too far.

Plase consider all this as RFC, it's mostly not even compile-tested.
If you think it's worth to follow-up, I'm happy to do it.

What this series does:
- Remove all instances of arch_decomp_wdog

- Restructure the decompression code just a bit,
  to separate the UART-printing stuff

- Introduce a low-level serial driver of the style
  "check a reg if there's space for a TX char",
  "output char", "wait for flush reg"

- Add init functions for the two common UARTs:
  8250 and the amba.
  This finally gets rid of that dozen re-implementations
  that all use different register access methods and
  register defines, but do the same.

- Some basic style cleanup

- Allow the uncompress UART definitions to be overridden
  by a device tree description.
  This would allow the removal of all the
  "if machine_is_xxx, serial base is 123" lookup tables.

Remarks:
- Just to see how it works out, I converted most of the
  arches/machines to use the ucuart driver.
  I didn't convert any Samsung machines, because the
  code is just too convoluted for me to dive into now.
- The overall patch is above 100K, so I didn't want
  to post it here.
  It's available here:
  git://github.com/zdevai/linux.git uncompress-h

- Overall diffstat below.

Comments welcome.

Cheers,
Zoltan

 arch/arm/Kconfig                                   |    9 +
 arch/arm/boot/compressed/Makefile                  |    9 +-
 arch/arm/boot/compressed/decompress.c              |   78 ++++--
 arch/arm/boot/compressed/head.S                    |    8 +
 arch/arm/boot/compressed/misc.c                    |  154 -----------
 arch/arm/boot/compressed/print.c                   |  290 ++++++++++++++++++++
 arch/arm/mach-at91/include/mach/uncompress.h       |   62 +----
 arch/arm/mach-bcmring/include/mach/uncompress.h    |   47 +---
 arch/arm/mach-clps711x/include/mach/uncompress.h   |   49 +---
 arch/arm/mach-cns3xxx/include/mach/uncompress.h    |   49 +---
 arch/arm/mach-davinci/include/mach/uncompress.h    |   24 +--
 arch/arm/mach-dove/include/mach/uncompress.h       |   30 +--
 arch/arm/mach-ebsa110/include/mach/uncompress.h    |   40 +---
 arch/arm/mach-ep93xx/include/mach/uncompress.h     |   49 +---
 arch/arm/mach-exynos4/include/mach/uncompress.h    |   15 +-
 arch/arm/mach-footbridge/include/mach/uncompress.h |   34 +--
 arch/arm/mach-gemini/include/mach/uncompress.h     |   41 +---
 arch/arm/mach-h720x/include/mach/uncompress.h      |   39 +--
 arch/arm/mach-integrator/include/mach/uncompress.h |   49 +---
 arch/arm/mach-iop13xx/include/mach/uncompress.h    |   26 +--
 arch/arm/mach-iop32x/include/mach/uncompress.h     |   37 +--
 arch/arm/mach-iop33x/include/mach/uncompress.h     |   34 +--
 arch/arm/mach-ixp2000/include/mach/uncompress.h    |   48 +---
 arch/arm/mach-ixp23xx/include/mach/uncompress.h    |   33 +--
 arch/arm/mach-ixp4xx/include/mach/uncompress.h     |   44 +---
 arch/arm/mach-kirkwood/include/mach/uncompress.h   |   40 +---
 arch/arm/mach-ks8695/include/mach/uncompress.h     |   32 +--
 arch/arm/mach-lpc32xx/include/mach/uncompress.h    |   57 +----
 arch/arm/mach-mmp/include/mach/uncompress.h        |   38 +---
 arch/arm/mach-msm/include/mach/uncompress.h        |   45 +---
 arch/arm/mach-mv78xx0/include/mach/uncompress.h    |   40 +---
 arch/arm/mach-mxs/include/mach/uncompress.h        |   63 +----
 arch/arm/mach-netx/include/mach/uncompress.h       |   73 +-----
 arch/arm/mach-nomadik/include/mach/uncompress.h    |   58 +----
 arch/arm/mach-omap1/include/mach/uncompress.h      |    4 -
 arch/arm/mach-omap2/include/mach/uncompress.h      |    4 -
 arch/arm/mach-orion5x/include/mach/uncompress.h    |   48 +---
 arch/arm/mach-picoxcell/include/mach/uncompress.h  |   18 +-
 arch/arm/mach-pnx4008/include/mach/uncompress.h    |   43 +---
 arch/arm/mach-prima2/include/mach/uncompress.h     |   41 +---
 arch/arm/mach-pxa/include/mach/uncompress.h        |   77 +-----
 arch/arm/mach-realview/include/mach/uncompress.h   |   70 +----
 arch/arm/mach-rpc/include/mach/uncompress.h        |    9 +-
 arch/arm/mach-s3c2410/include/mach/uncompress.h    |    2 +
 arch/arm/mach-s3c64xx/include/mach/uncompress.h    |   18 +-
 arch/arm/mach-s5p64x0/include/mach/uncompress.h    |   39 +---
 arch/arm/mach-s5pc100/include/mach/uncompress.h    |    6 +-
 arch/arm/mach-s5pv210/include/mach/uncompress.h    |   17 +-
 arch/arm/mach-sa1100/include/mach/uncompress.h     |   62 ++---
 arch/arm/mach-shark/include/mach/uncompress.h      |   52 +----
 arch/arm/mach-shmobile/include/mach/uncompress.h   |   17 +-
 arch/arm/mach-spear3xx/include/mach/uncompress.h   |   18 --
 arch/arm/mach-spear6xx/include/mach/uncompress.h   |   18 --
 arch/arm/mach-tegra/include/mach/uncompress.h      |   62 +----
 arch/arm/mach-u300/include/mach/uncompress.h       |   45 +---
 arch/arm/mach-ux500/include/mach/uncompress.h      |   54 +----
 arch/arm/mach-versatile/include/mach/uncompress.h  |   45 +---
 arch/arm/mach-vexpress/include/mach/uncompress.h   |   51 +----
 arch/arm/mach-vt8500/include/mach/uncompress.h     |   40 +---
 arch/arm/mach-w90x900/include/mach/uncompress.h    |   47 +---
 arch/arm/mach-zynq/include/mach/uncompress.h       |   53 +---
 arch/arm/plat-mxc/include/mach/uncompress.h        |   37 +--
 arch/arm/plat-omap/include/plat/uncompress.h       |   45 +---
 arch/arm/plat-samsung/Kconfig                      |    8 -
 arch/arm/plat-samsung/include/plat/uncompress.h    |   35 +---
 arch/arm/plat-spear/include/plat/uncompress.h      |   43 +---
 arch/arm/plat-tcc/include/mach/uncompress.h        |   33 +--
 67 files changed, 671 insertions(+), 2234 deletions(-)
