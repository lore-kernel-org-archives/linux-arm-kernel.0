From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jan 2013 17:15:53 +0000
Subject: [PATCH 00/15] ARM build regressions in v3.8
Message-ID: <1358788568-11137-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I know this comes late, but we have a number of broken
configurations in ARM in v3.8 that were still building
in v3.7, and I'd like to get them all fixed in the
final 3.8 release.

It would be nice if the respective maintainers could
have a look at these patches and apply them directly
when they are happy with them.

The first patch in the series is strictly speaking
not a build error but just a warning, but it is a
particularly annoying one that came in through the
latest binutils release rather than a kernel change.

The same binutils update also broke the samsung
and w90x900 platforms.

A few of the other changes are the result of the
imx multiplatform conversion. I'm not really fixing
those here, just picking up the pieces. It would
be much nicer if we could actually get those drivers
to work again with CONFIG_MULTIPLATFORM enabled
rather than just disabling them, but it may be
much too late for that. At least the drivers don't
seem to be too essential, as they are only built
in allyesconfig but not in any of the defconfigs.

	Arnd

Arnd Bergmann (15):
  ARM: compressed/head.S: work around new binutils warning
  ARM: mvebu: build coherency_ll.S for arch=armv7-a
  ARM: samsung: fix assembly syntax for new gas
  ARM: w90x900: fix legacy assembly syntax
  ASoC: fsl: fiq and dma cannot both be modules
  clk: export __clk_get_name
  drm/exynos: don't include plat/gpio-cfg.h
  drm/exynos: fimd and ipp are broken on multiplatform
  media: coda: don't build on multiplatform
  mfd/vexpress: export vexpress_config_func_{put,get}
  mtd: davinci_nand: fix OF support
  USB: gadget/freescale: disable non-multiplatform drivers
  USB: ehci: make orion and mxc bus glues coexist
  samples/seccomp: be less stupid about cross compiling
  staging/omapdrm: don't build on multiplatform

 arch/arm/boot/compressed/Makefile                |    2 +-
 arch/arm/boot/compressed/head.S                  |   12 ++++++++++++
 arch/arm/mach-mvebu/coherency_ll.S               |    1 +
 arch/arm/mach-s3c24xx/include/mach/debug-macro.S |   12 ++++++------
 arch/arm/mach-s3c24xx/include/mach/entry-macro.S |    4 ++--
 arch/arm/mach-s3c24xx/pm-h1940.S                 |    2 +-
 arch/arm/mach-s3c24xx/sleep-s3c2410.S            |   12 ++++++------
 arch/arm/mach-s3c24xx/sleep-s3c2412.S            |   12 ++++++------
 arch/arm/mach-w90x900/include/mach/entry-macro.S |    4 ++--
 arch/arm/plat-samsung/include/plat/debug-macro.S |   18 +++++++++---------
 drivers/clk/clk.c                                |    1 +
 drivers/gpu/drm/exynos/Kconfig                   |    4 ++--
 drivers/gpu/drm/exynos/exynos_hdmi.c             |    1 -
 drivers/media/platform/Kconfig                   |    2 +-
 drivers/mfd/vexpress-config.c                    |    3 ++-
 drivers/mtd/nand/davinci_nand.c                  |    2 +-
 drivers/staging/omapdrm/Kconfig                  |    2 +-
 drivers/usb/gadget/Kconfig                       |    3 ++-
 drivers/usb/host/ehci-hcd.c                      |   16 +++++++++++++++-
 samples/seccomp/Makefile                         |    2 ++
 sound/soc/fsl/Kconfig                            |    3 +++
 21 files changed, 76 insertions(+), 42 deletions(-)

-- 
1.7.10.4
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: James Morris <james.l.morris@oracle.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Rob Clark <rob@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel at alsa-project.org
Cc: dri-devel at lists.freedesktop.org
Cc: linux-media at vger.kernel.org
Cc: linux-usb at vger.kernel.org
