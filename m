From: olof@lixom.net (Olof Johansson)
Date: Tue, 17 Feb 2015 00:33:26 -0800
Subject: [GIT PULL 5/7] ARM: SoC driver updates
In-Reply-To: <1424162008-23768-1-git-send-email-olof@lixom.net>
References: <1424162008-23768-1-git-send-email-olof@lixom.net>
Message-ID: <1424162008-23768-6-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are changes for drivers that are intimately tied to some SoC
and for some reason could not get merged through the respective
subsystem maintainer tree.

This time around, much of this is for at91, with the bulk of it being syscon
and udc drivers.

Also, there's:
- coupled cpuidle support for Samsung Exynos4210
- Renesas 73A0 common-clk work
- of/platform changes to tear down DMA mappings on device destruction
- a few updates to the TI Keystone knav code


Conflicts:

arch/arm/boot/dts/rk3288.dtsi:  add/add: Keep both sides                
arch/arm/boot/dts/stih407-family.dtsi: Duplicate patch causes context
mismatch, keep branch contents
arch/arm/boot/dts/stih410.dtsi: Duplicate patch causes context mismatch,
keep branch contents
arch/arm/boot/dts/sun5i-a13.dtsi: add/remove: Remove aliases, keep chosen
arch/arm/boot/dts/sun8i-a23.dtsi: add/remove: Remove aliases, keep chosen

----------------------------------------------------------------

The following changes since commit eaa27f34e91a14cdceed26ed6c6793ec1d186115:

  linux 3.19-rc4 (2015-01-11 12:44:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/drivers-for-linus

for you to fetch changes up to 6f4554bdff6870c9e0f0b152bbec71d7a0f366f1:

  Merge tag 'samsung-cpuidle' of git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung into next/drivers

----------------------------------------------------------------

Alexandre Belloni (1):
      pcmcia: at91_cf: depend on !ARCH_MULTIPLATFORM

Bartlomiej Zolnierkiewicz (2):
      ARM: EXYNOS: apply S5P_CENTRAL_SEQ_OPTION fix only when necessary
      cpuidle: exynos: add coupled cpuidle support for exynos4210

Boris Brezillon (12):
      mfd: syscon: Add atmel-matrix registers definition
      mfd: syscon: Add Atmel Matrix bus DT binding documentation
      mfd: syscon: Add atmel-smc registers definition
      mfd: syscon: Add Atmel SMC binding doc
      usb: gadget: at91_udc: Fix clock names
      usb: gadget: at91_udc: Drop uclk clock
      usb: gadget: at91_udc: Document DT clocks and clock-names property
      usb: gadget: at91_udc: Remove non-DT handling code
      usb: gadget: at91_udc: Simplify probe and remove functions
      usb: gadget: at91_udc: Rework for multi-platform kernel support
      usb: gadget: at91_udc: Update DT binding documentation
      usb: gadget: at91_udc: Allocate udc instance

Murali Karicheri (3):
      soc: ti: knav_qmss_queue: export API calls for use by user driver
      soc: ti: knav_qmss_queue: makefile tweak to build as dynamic module
      soc: ti: knav_qmss_queue: change knav_range_setup_acc_irq to static

Olof Johansson (5):
      Merge tag 'renesas-sh73a0-ccf-for-v3.20' of git://git.kernel.org/.../horms/renesas into next/drivers
      Merge tag 'at91-drivers' of git://git.kernel.org/.../nferre/linux-at91 into next/drivers
      Merge tag 'renesas-sh73a0-ccf2-for-v3.20' of git://git.kernel.org/.../horms/renesas into next/drivers
      Merge tag 'drivers-soc-ti' of git://git.kernel.org/.../ssantosh/linux-keystone into next/drivers
      Merge tag 'samsung-cpuidle' of git://git.kernel.org/.../kgene/linux-samsung into next/drivers

Ulrich Hecht (6):
      clk: shmobile: sh73a0 common clock framework implementation
      ARM: shmobile: sh73a0: Add CPG register bits header
      ARM: shmobile: sh73a0: Common clock framework DT description
      ARM: shmobile: kzm9g-reference: Common clock framework DT description
      ARM: shmobile: sh73a0: add MSTP clock assignments to DT
      ARM: shmobile: sh73a0: disable legacy clock initialization

Wei Yongjun (1):
      clk: shmobile: fix sparse NULL pointer warning

Will Deacon (1):
      of/platform: teardown DMA mappings on device destruction


 .../clock/renesas,sh73a0-cpg-clocks.txt         |  35 ++
 .../devicetree/bindings/mfd/atmel-matrix.txt    |  24 +
 .../devicetree/bindings/mfd/atmel-smc.txt       |  19 +
 .../devicetree/bindings/usb/atmel-usb.txt       |  10 +-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts    |   4 +
 arch/arm/boot/dts/sh73a0.dtsi                   | 358 +++++++++++++
 arch/arm/mach-exynos/common.h                   |   4 +
 arch/arm/mach-exynos/exynos.c                   |   4 +
 arch/arm/mach-exynos/platsmp.c                  |   2 +-
 arch/arm/mach-exynos/pm.c                       | 133 ++++-
 arch/arm/mach-exynos/suspend.c                  |   4 +
 arch/arm/mach-shmobile/setup-sh73a0.c           |   5 +-
 drivers/clk/shmobile/Makefile                   |   1 +
 drivers/clk/shmobile/clk-sh73a0.c               | 218 ++++++++
 drivers/cpuidle/Kconfig.arm                     |   1 +
 drivers/cpuidle/cpuidle-exynos.c                |  76 ++-
 drivers/of/platform.c                           |   1 +
 drivers/pcmcia/Kconfig                          |   1 +
 drivers/soc/ti/Makefile                         |   3 +-
 drivers/soc/ti/knav_qmss_acc.c                  |   2 +-
 drivers/soc/ti/knav_qmss_queue.c                |   9 +
 drivers/usb/gadget/udc/Kconfig                  |   1 +
 drivers/usb/gadget/udc/at91_udc.c               | 525 ++++++++++---------
 drivers/usb/gadget/udc/at91_udc.h               |   9 +-
 include/dt-bindings/clock/sh73a0-clock.h        |  79 +++
 include/linux/mfd/syscon/atmel-matrix.h         | 117 +++++
 include/linux/mfd/syscon/atmel-smc.h            | 173 ++++++
 include/linux/platform_data/cpuidle-exynos.h    |  20 +
 28 files changed, 1570 insertions(+), 268 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh73a0-cpg-clocks.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel-matrix.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel-smc.txt
 create mode 100644 drivers/clk/shmobile/clk-sh73a0.c
 create mode 100644 include/dt-bindings/clock/sh73a0-clock.h
 create mode 100644 include/linux/mfd/syscon/atmel-matrix.h
 create mode 100644 include/linux/mfd/syscon/atmel-smc.h
 create mode 100644 include/linux/platform_data/cpuidle-exynos.h
