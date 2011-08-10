From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 10 Aug 2011 14:44:55 +0200
Subject: [PATCH] detect conflicting zreladdrs
Message-ID: <1312980298-28035-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With CONFIG_ARM_PATCH_PHYS_VIRT and CONFIG_AUTO_ZRELADDR the kernel
is ready to calculate zreladdr at runtime. Currently the boards specify
zreladdr using := in their Makefile.boot. This means the value maybe
overwritten silently if multiple zreladdr-y exist. This series changes
the := into += so that we have multiple words in zreladdr instead.
This makes it possible to catch conflicting zreladdrs during build.

Without CONFIG_AUTO_ZRELADDR=y multiple zreladdrs are not allowed for
zImages, so we bail out if we detect it.

uImages are generally incompatible with multiple zreladdrs, so we
bail out if we detect it. In this case an uImage can still be built
by specifying LOADADDR= on the command line.

Sascha

Sascha Hauer (3):
      ARM: Check for multiple zreladdrs
      ARM: Check for multiple load addresses before building a uImage
      ARM: allow to detect conflicting zreladdrs

 arch/arm/boot/Makefile                 |    9 +++++++++
 arch/arm/boot/compressed/Makefile      |    8 ++++++++
 arch/arm/mach-at91/Makefile.boot       |    6 +++---
 arch/arm/mach-bcmring/Makefile.boot    |    2 +-
 arch/arm/mach-clps711x/Makefile.boot   |    2 +-
 arch/arm/mach-cns3xxx/Makefile.boot    |    2 +-
 arch/arm/mach-davinci/Makefile.boot    |    4 ++--
 arch/arm/mach-dove/Makefile.boot       |    2 +-
 arch/arm/mach-ebsa110/Makefile.boot    |    2 +-
 arch/arm/mach-ep93xx/Makefile.boot     |   10 +++++-----
 arch/arm/mach-exynos4/Makefile.boot    |    2 +-
 arch/arm/mach-footbridge/Makefile.boot |    2 +-
 arch/arm/mach-gemini/Makefile.boot     |    4 ++--
 arch/arm/mach-h720x/Makefile.boot      |    2 +-
 arch/arm/mach-imx/Makefile.boot        |   10 +++++-----
 arch/arm/mach-integrator/Makefile.boot |    2 +-
 arch/arm/mach-iop13xx/Makefile.boot    |    2 +-
 arch/arm/mach-iop32x/Makefile.boot     |    2 +-
 arch/arm/mach-iop33x/Makefile.boot     |    2 +-
 arch/arm/mach-ixp2000/Makefile.boot    |    2 +-
 arch/arm/mach-ixp23xx/Makefile.boot    |    2 +-
 arch/arm/mach-ixp4xx/Makefile.boot     |    2 +-
 arch/arm/mach-kirkwood/Makefile.boot   |    2 +-
 arch/arm/mach-ks8695/Makefile.boot     |    2 +-
 arch/arm/mach-lpc32xx/Makefile.boot    |    2 +-
 arch/arm/mach-mmp/Makefile.boot        |    2 +-
 arch/arm/mach-msm/Makefile.boot        |    2 +-
 arch/arm/mach-mv78xx0/Makefile.boot    |    2 +-
 arch/arm/mach-mx5/Makefile.boot        |    6 +++---
 arch/arm/mach-mxs/Makefile.boot        |    2 +-
 arch/arm/mach-netx/Makefile.boot       |    2 +-
 arch/arm/mach-nomadik/Makefile.boot    |    2 +-
 arch/arm/mach-nuc93x/Makefile.boot     |    2 +-
 arch/arm/mach-omap1/Makefile.boot      |    2 +-
 arch/arm/mach-omap2/Makefile.boot      |    2 +-
 arch/arm/mach-orion5x/Makefile.boot    |    2 +-
 arch/arm/mach-pnx4008/Makefile.boot    |    2 +-
 arch/arm/mach-prima2/Makefile.boot     |    2 +-
 arch/arm/mach-pxa/Makefile.boot        |    2 +-
 arch/arm/mach-realview/Makefile.boot   |    4 ++--
 arch/arm/mach-rpc/Makefile.boot        |    2 +-
 arch/arm/mach-s3c2410/Makefile.boot    |    4 ++--
 arch/arm/mach-s3c64xx/Makefile.boot    |    2 +-
 arch/arm/mach-s5p64x0/Makefile.boot    |    2 +-
 arch/arm/mach-s5pc100/Makefile.boot    |    2 +-
 arch/arm/mach-s5pv210/Makefile.boot    |    2 +-
 arch/arm/mach-sa1100/Makefile.boot     |    5 +++--
 arch/arm/mach-shark/Makefile.boot      |    2 +-
 arch/arm/mach-shmobile/Makefile.boot   |    2 +-
 arch/arm/mach-spear3xx/Makefile.boot   |    2 +-
 arch/arm/mach-spear6xx/Makefile.boot   |    2 +-
 arch/arm/mach-tcc8k/Makefile.boot      |    2 +-
 arch/arm/mach-tegra/Makefile.boot      |    2 +-
 arch/arm/mach-u300/Makefile.boot       |    4 ++--
 arch/arm/mach-ux500/Makefile.boot      |    2 +-
 arch/arm/mach-versatile/Makefile.boot  |    2 +-
 arch/arm/mach-vexpress/Makefile.boot   |    2 +-
 arch/arm/mach-vt8500/Makefile.boot     |    2 +-
 arch/arm/mach-w90x900/Makefile.boot    |    2 +-
 arch/arm/mach-zynq/Makefile.boot       |    2 +-
 60 files changed, 94 insertions(+), 76 deletions(-)
