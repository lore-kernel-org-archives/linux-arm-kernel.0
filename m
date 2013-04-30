From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 1 May 2013 01:11:14 +0200
Subject: Latest build results - errors/warnings - lots of them
In-Reply-To: <20130430081739.GP14496@n2100.arm.linux.org.uk>
References: <20130430081739.GP14496@n2100.arm.linux.org.uk>
Message-ID: <201305010111.14247.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 April 2013, Russell King - ARM Linux wrote:
> Latest nightly build of 3.9+my for-next+arm-soc's for-next results in a
> great load of new warnings and errors.  arch/arm/common/mcpm_head.S,
> arch/arm/common/mcpm_platsmp.c, arch/arm/common/vlock.S are the biggest
> source of errors.
> 
> OMAP stuff needs a serious look at too - much Kconfig madness there
> caused by over-use of select, which then goes on to cause build errors
> because it assumes some stuff is always enabled.
> 
> There's also warnings about of_device_id from include/linux/of_platform.h
> via from arch/arm/kernel/setup.c which feature in all the non-OF builds
> too which need addressing.
> 
> See todays http://www.arm.linux.org.uk/developer/build/ results for all
> the details and configs.  Not pushing my tree until some of this stuff
> gets fixed.

A couple hundred kernel builds and 50 patches later, I actually managed to
get a reliably building randconfig.  There are no proper changeset
comments yet, and no Signed-off-by.

I've uploaded this to the test-merge-20130430 branch in the arm-soc
tree if anyone is curious. I suppose we should get all the changes
in arch/arm included in the merge window and then work with the
subsystem maintainers on the other bugs.

	Arnd

---
 arch/Kconfig                                  |   1 +
 arch/arm/Kconfig                              |   4 +-
 arch/arm/boot/compressed/Makefile             |   2 +-
 arch/arm/boot/compressed/head-sa1100.S        |   1 +
 arch/arm/boot/compressed/head-shark.S         |   1 +
 arch/arm/boot/compressed/head.S               |  13 +--
 arch/arm/configs/omap2plus_defconfig          |   6 +-
 arch/arm/kernel/psci_smp.c                    |   4 +-
 arch/arm/kvm/Kconfig                          |  26 ++---
 arch/arm/mach-imx/headsmp.S                   |   2 +-
 arch/arm/mach-imx/src.c                       |   3 +-
 arch/arm/mach-omap2/Kconfig                   | 133 +++++++++++++-------------
 arch/arm/mach-omap2/Makefile                  |   8 +-
 arch/arm/mach-prima2/Kconfig                  |   2 +-
 arch/arm/mach-spear/Makefile                  |   6 +-
 arch/arm/mach-spear/spear13xx.c               |   2 +
 arch/arm/mach-tegra/Kconfig                   |   5 +-
 arch/arm/mach-ux500/Kconfig                   |   2 +
 crypto/Kconfig                                |   2 +
 drivers/cpufreq/Kconfig.arm                   |   1 +
 drivers/cpuidle/Kconfig                       |   1 +
 drivers/gpu/drm/tilcdc/Kconfig                |   1 +
 drivers/gpu/host1x/drm/Kconfig                |   1 +
 drivers/media/platform/Kconfig                |   1 +
 drivers/media/platform/davinci/Kconfig        |   3 +
 drivers/media/radio/Kconfig                   |   1 +
 drivers/mfd/Kconfig                           |   2 +-
 drivers/net/can/Kconfig                       |   6 +-
 drivers/net/ethernet/mellanox/mlx4/en_clock.c |   2 +-
 drivers/net/wireless/iwlegacy/common.h        |   2 +-
 drivers/staging/android/logger.c              |   4 +-
 drivers/staging/android/logger.h              |   2 +-
 drivers/staging/imx-drm/Kconfig               |   4 +
 drivers/staging/media/solo6x10/Kconfig        |   1 +
 drivers/usb/host/Kconfig                      |  76 ++++++++++++---
 drivers/usb/host/Makefile                     |   4 +-
 drivers/usb/host/ehci-hcd.c                   |  17 ----
 drivers/usb/host/ohci-hcd.c                   |  19 ----
 drivers/usb/host/uhci-hcd.c                   |   4 +-
 drivers/usb/storage/realtek_cr.c              |   3 -
 drivers/video/console/Makefile                |   2 +
 drivers/video/omap2/dss/Kconfig               |   1 +
 drivers/xen/Kconfig                           |   2 +-
 include/drm/drmP.h                            |   3 +-
 include/linux/cpu_cooling.h                   |   2 +-
 45 files changed, 207 insertions(+), 181 deletions(-)
