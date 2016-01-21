From: olof@lixom.net (Olof Johansson)
Date: Wed, 20 Jan 2016 17:14:36 -0800
Subject: [GIT PULL 3/9] ARM: SoC multiplatform code changes for v4.5
In-Reply-To: <1453338882-31300-1-git-send-email-olof@lixom.net>
References: <1453338882-31300-1-git-send-email-olof@lixom.net>
Message-ID: <1453338882-31300-4-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch is the culmination of 5 years of effort to bring the ARMv6
and ARMv7 platforms together such that they can all be enabled and
boot the same kernel. It has been a tremendous amount of cleanup and
refactoring by a huge number of people, and creation of several new
(and major) subsystems to better abstract out all the platform details
in an appropriate manner.

The bulk of this branch is a large patchset from Arnd that brings several
of the more minor and older platforms we have closer to multiplatform
support.  Among these are MMP, S3C64xx, Orion5x, mv78xx0 and realview
Much of this is moving around header files from old mach directories,
but there are also some cleanup patches of debug_ll (lowlevel debug
per-platform options) and other parts.

Linus Walleij also has some patchs to clean up the older ARM Realview
platforms by finally introducing DT support, and Rob Herring has some
for ARM Versatile which is now DT-only. Both of these platforms are
now multiplatform.

Finally, a couple of patches from Russell for Dove PMU, and a fix from
Valentin Rothberg for Exynos ADC, which were rebased on top of the
series to avoid conflicts.


Conflicts:

Include file rename conflicts with media includes. Keep the
platform_data/media/ version from HEAD, and go with the local file option
from branch.

----------------------------------------------------------------

The following changes since commit d62948942b595415de0e38674c17c806b1a8c0c0:

  Merge branch 'next/cleanup' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-multiplatform

for you to fetch changes up to 2cb58c016673c4c8b8ec59e71c5ec4b2c6a76afb:

  ARM: realview: don't select SMP_ON_UP for UP builds

----------------------------------------------------------------

Arnd Bergmann (70):
      clk: mmp: stop using platform headers
      ARM: make xscale iwmmxt code multiplatform aware
      ARM: mohawk: allow building with MMU disabled
      ARM: mmp: remove remaining legacy pxa-dma support
      ARM: mmp: make plat-pxa build standalone
      ARM: mmp: make all header files local
      ARM: mmp: move into ARCH_MULTIPLATFORM
      ARM: mmp: avoid unused functions
      Input: s3c2410_ts: fix S3C_ADC dependency
      ASoC: samsung/smartq: use dynamic registration
      gpio: samsung: move gpio-samsung driver back to platform code
      ARM: s3c64xx: prepare initcalls for multiplatform
      ARM: s3c64xx: enable sparse IRQ support
      iio: exynos-adc: add experimental touchscreen support
      ARM: s3c64xx: use new adc/touchscreen driver
      ARM: s3c64xx: use common debug-ll implementation
      ARM: s3c64xx: multiplatform support
      ARM: s3c64xx: allow building without board support
      ARM: pxa: make more mach/*.h files local
      ARM: omap1: make headers more local
      ARM: ks8695: make headers more local
      ARM: davinci: make headers more local
      ARM: iop13xx: make headers more local
      ARM: w90x900: make headers more local
      ARM: netx: remove unused mach/param.h
      ARM: orion: move watchdog setup to mach-orion5x
      ARM: orion: always use MULTI_IRQ_HANDLER
      ARM: orion: use SPARSE_IRQ everywhere
      ARM: mv78xx0: clean up mach/*.h headers
      ARM: mv78xx0: multiplatform support
      ARM: orion5x: clean up mach/*.h headers
      ARM: orion5x: multiplatform support
      ARM: realview: remove sparsemem hack
      ARM: realview: don't map undefined PCI registers
      clk/realview: stop using machine headers
      ARM: no longer force unbuffered DMA for realview
      ARM: realview: remove private barrier implementation
      ARM: debug-ll: fix UART configuration with ARCH_KEYSTONE
      ARM: debug-ll: reorganize mvebu debug uart config
      ARM: debug-ll: rework ep93xx handling
      ARM: debug-ll: rework SPEAr handling
      ARM: debug-ll: rework integrator/versatile handling
      ARM: debug-ll: rework gemini handling
      ARM: debug-ll: rework lpc32xx handling
      ARM: debug-ll: rework footbridge handling
      ARM: debug-ll: reorder Kconfig alphanumerically
      Merge branch 'multiplatform/debug-ll' into next/multiplatform
      Merge branch 's3c64xx/multiplatform' into next/multiplatform
      Merge branch 'mmp/multiplatform' into next/multiplatform
      ARM: pxa: cm-x2xx: avoid duplicate macro warnings
      ARM: pxa: mark raumfeld init functions as __maybe_unused
      ARM: pxa: mark ezx structures as __maybe_unused
      Merge branch 'versatile/multiplatform' into next/multiplatform
      Merge tag 'realview-base-armsoc-1-tag' of git://git.kernel.org/.../linusw/linux-integrator into next/multiplatform
      Merge tag 'mvebu-soc-4.5-1' of git://git.infradead.org/linux-mvebu into next/multiplatform
      ARM: defconfig: use correct debug_ll settings
      ARM: debug-ll: move DEBUG_LL_UART_EFM32 to correct Kconfig location
      ARM: make default platform work for NOMMU
      Merge branch 'fixes' into next/multiplatform
      ARM: realview: enable multiplatform
      ARM: integrator: use explicit core module options
      ARM: no longer make CPU targets visible separately
      ARM: realview: make all header files local
      ARM: realview: clean up header files
      Merge tag 'realview-multiplatform-tag' of git://git.kernel.org/.../linusw/linux-integrator into next/multiplatform
      ARM: realview: build realview-dt SMP support only when used
      Merge branch 'treewide/cleanup' into next/multiplatform
      ARM: s3c64xx: fix pm-debug compilation
      ARM: s3c: simplify s3c_irqwake_{e,}intallow definition
      ARM: realview: don't select SMP_ON_UP for UP builds

Linus Walleij (7):
      clk: versatile-icst: convert to use regmap
      clk: versatile-icst: refactor to allocate regmap separately
      clk: versatile-icst: add device tree support
      soc: versatile: add support for the PB11MPCore
      ARM: realview: select SP810 and ICST for the DT variant
      ARM: realview: add an DT SMP boot method
      ARM: realview: select apropriate targets

Rob Herring (4):
      ARM: versatile: add DT based PCI detection
      ARM: versatile: switch to DT only booting and remove legacy code
      ARM: versatile: merge mach code into a single file
      ARM: versatile: convert to multi-platform

Russell King (2):
      soc: dove: add legacy support to PMU driver
      ARM: dove: convert legacy dove to PMU support

Valentin Rothberg (1):
      iio: exynos-adc: fix irqf_oneshot.cocci warnings


 Documentation/arm/pxa/mfp.txt                   |  26 +-
 Documentation/devicetree/bindings/arm/cpus.txt  |   1 +
 .../bindings/arm/samsung/exynos-adc.txt         |   3 +
 arch/arm/Kconfig                                | 107 +--
 arch/arm/Kconfig.debug                          | 391 +++++----
 arch/arm/configs/ep93xx_defconfig               |   1 -
 arch/arm/configs/lpc32xx_defconfig              |   1 -
 arch/arm/configs/multi_v7_defconfig             |   3 +
 arch/arm/configs/mv78xx0_defconfig              |   4 +-
 arch/arm/configs/orion5x_defconfig              |   4 +-
 arch/arm/configs/realview-smp_defconfig         |   9 +
 arch/arm/configs/realview_defconfig             |   8 +
 arch/arm/configs/s3c6400_defconfig              |   2 +
 arch/arm/configs/versatile_defconfig            |   3 +-
 arch/arm/include/asm/cputype.h                  |  22 +-
 .../debug-macro.S => include/debug/dc21285.S}   |   0
 arch/arm/kernel/devtree.c                       |   2 +-
 arch/arm/kernel/xscale-cp0.c                    |   7 +
 arch/arm/mach-davinci/board-da830-evm.c         |   2 +-
 arch/arm/mach-davinci/board-da850-evm.c         |   4 +-
 arch/arm/mach-davinci/board-mityomapl138.c      |   2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c     |   2 +-
 arch/arm/mach-davinci/clock.c                   |   2 +-
 arch/arm/mach-davinci/cp_intc.c                 |   2 +-
 .../mach-davinci/{include/mach => }/cp_intc.h   |   0
 arch/arm/mach-davinci/cpuidle.c                 |   4 +-
 .../mach-davinci/{include/mach => }/cpuidle.h   |   0
 arch/arm/mach-davinci/da830.c                   |   2 +-
 arch/arm/mach-davinci/da850.c                   |   2 +-
 arch/arm/mach-davinci/da8xx-dt.c                |   2 +-
 arch/arm/mach-davinci/{include/mach => }/ddr2.h |   0
 arch/arm/mach-davinci/devices-da8xx.c           |   4 +-
 arch/arm/mach-davinci/dm355.c                   |   2 +-
 arch/arm/mach-davinci/dm365.c                   |   2 +-
 arch/arm/mach-davinci/dm644x.c                  |   2 +-
 arch/arm/mach-davinci/dm646x.c                  |   2 +-
 arch/arm/mach-davinci/pm.c                      |   2 +-
 arch/arm/mach-davinci/psc.c                     |   2 +-
 arch/arm/mach-davinci/{include/mach => }/psc.h  |   0
 arch/arm/mach-davinci/sleep.S                   |   4 +-
 arch/arm/mach-davinci/sram.c                    |   2 +-
 arch/arm/mach-davinci/{include/mach => }/sram.h |   0
 arch/arm/mach-dove/cm-a510.c                    |   1 +
 arch/arm/mach-dove/common.c                     |  43 +
 arch/arm/mach-dove/dove-db-setup.c              |   1 +
 arch/arm/mach-dove/include/mach/dove.h          |   2 +
 arch/arm/mach-dove/include/mach/entry-macro.S   |  33 -
 arch/arm/mach-dove/include/mach/irqs.h          |   2 +-
 arch/arm/mach-dove/include/mach/pm.h            |  20 +-
 arch/arm/mach-dove/irq.c                        | 100 +--
 arch/arm/mach-integrator/Kconfig                | 132 ++-
 arch/arm/mach-iop13xx/include/mach/pci.h        |  57 --
 arch/arm/mach-iop13xx/iq81340mc.c               |   2 +-
 arch/arm/mach-iop13xx/iq81340sc.c               |   2 +-
 arch/arm/mach-iop13xx/irq.c                     |   2 +-
 arch/arm/mach-iop13xx/{include/mach => }/msi.h  |   0
 arch/arm/mach-iop13xx/pci.c                     |   2 +-
 arch/arm/mach-iop13xx/pci.h                     |  58 ++
 arch/arm/mach-ks8695/board-acs5k.c              |   2 +-
 arch/arm/mach-ks8695/board-dsm320.c             |   2 +-
 arch/arm/mach-ks8695/board-micrel.c             |   2 +-
 arch/arm/mach-ks8695/board-og.c                 |   2 +-
 arch/arm/mach-ks8695/board-sg.c                 |   2 +-
 arch/arm/mach-ks8695/cpu.c                      |   2 +-
 arch/arm/mach-ks8695/devices.c                  |   6 +-
 .../mach-ks8695/{include/mach => }/devices.h    |   0
 arch/arm/mach-ks8695/pci.c                      |   4 +-
 .../mach-ks8695/{include/mach => }/regs-hpna.h  |   0
 .../mach-ks8695/{include/mach => }/regs-lan.h   |   0
 .../mach-ks8695/{include/mach => }/regs-mem.h   |   0
 .../mach-ks8695/{include/mach => }/regs-pci.h   |   0
 .../mach-ks8695/{include/mach => }/regs-sys.h   |   0
 .../mach-ks8695/{include/mach => }/regs-wan.h   |   0
 arch/arm/mach-mmp/Kconfig                       |  34 +-
 arch/arm/mach-mmp/Makefile                      |   1 +
 arch/arm/mach-mmp/{include/mach => }/addr-map.h |   2 -
 arch/arm/mach-mmp/aspenite.c                    |   8 +-
 arch/arm/mach-mmp/avengers_lite.c               |   8 +-
 arch/arm/mach-mmp/brownstone.c                  |   8 +-
 arch/arm/mach-mmp/clock-mmp2.c                  |   6 +-
 arch/arm/mach-mmp/clock-pxa168.c                |   6 +-
 arch/arm/mach-mmp/clock-pxa910.c                |   6 +-
 arch/arm/mach-mmp/clock.c                       |   2 +-
 arch/arm/mach-mmp/clock.h                       |   2 -
 arch/arm/mach-mmp/common.c                      |   4 +-
 arch/arm/mach-mmp/common.h                      |   3 -
 arch/arm/mach-mmp/{include/mach => }/cputype.h  |   0
 arch/arm/mach-mmp/devices.c                     |  13 +-
 arch/arm/mach-mmp/{include/mach => }/devices.h  |   0
 arch/arm/mach-mmp/flint.c                       |   8 +-
 arch/arm/mach-mmp/gplugd.c                      |   6 +-
 arch/arm/mach-mmp/include/mach/dma.h            |  13 -
 arch/arm/mach-mmp/include/mach/hardware.h       |   4 -
 arch/arm/mach-mmp/include/mach/regs-smc.h       |  37 -
 arch/arm/mach-mmp/include/mach/uncompress.h     |  45 --
 arch/arm/mach-mmp/{include/mach => }/irqs.h     |   0
 arch/arm/mach-mmp/jasper.c                      |   8 +-
 arch/arm/mach-mmp/{include/mach => }/mfp-mmp2.h |   2 +-
 .../mach-mmp/{include/mach => }/mfp-pxa168.h    |   2 +-
 .../mach-mmp/{include/mach => }/mfp-pxa910.h    |   2 +-
 arch/arm/mach-mmp/{include/mach => }/mfp.h      |   0
 arch/arm/mach-mmp/mmp2.c                        |  23 +-
 arch/arm/mach-mmp/{include/mach => }/mmp2.h     |   3 +-
 arch/arm/mach-mmp/pm-mmp2.c                     |  12 +-
 arch/arm/mach-mmp/{include/mach => }/pm-mmp2.h  |   2 +-
 arch/arm/mach-mmp/pm-pxa910.c                   |  12 +-
 .../arm/mach-mmp/{include/mach => }/pm-pxa910.h |   0
 arch/arm/mach-mmp/pxa168.c                      |  29 +-
 arch/arm/mach-mmp/{include/mach => }/pxa168.h   |   5 +-
 arch/arm/mach-mmp/pxa910.c                      |  24 +-
 arch/arm/mach-mmp/{include/mach => }/pxa910.h   |   3 +-
 .../arm/mach-mmp/{include/mach => }/regs-apbc.h |   4 +-
 .../arm/mach-mmp/{include/mach => }/regs-apmu.h |   4 +-
 arch/arm/mach-mmp/{include/mach => }/regs-icu.h |   4 +-
 .../mach-mmp/{include/mach => }/regs-timers.h   |   4 +-
 arch/arm/mach-mmp/{include/mach => }/regs-usb.h |   0
 arch/arm/mach-mmp/tavorevb.c                    |   8 +-
 arch/arm/mach-mmp/teton_bga.c                   |  10 +-
 .../arm/mach-mmp/{include/mach => }/teton_bga.h |   2 -
 arch/arm/mach-mmp/time.c                        |  11 +-
 arch/arm/mach-mmp/ttc_dkb.c                     |  10 +-
 arch/arm/mach-mv78xx0/Kconfig                   |  15 +-
 arch/arm/mach-mv78xx0/Makefile                  |   2 +
 .../{include/mach => }/bridge-regs.h            |   4 +-
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c       |   3 +-
 arch/arm/mach-mv78xx0/common.c                  |   4 +-
 arch/arm/mach-mv78xx0/db78x00-bp-setup.c        |   3 +-
 .../arm/mach-mv78xx0/include/mach/entry-macro.S |  41 -
 arch/arm/mach-mv78xx0/include/mach/hardware.h   |  14 -
 arch/arm/mach-mv78xx0/include/mach/uncompress.h |  46 --
 arch/arm/mach-mv78xx0/irq.c                     |  35 +-
 arch/arm/mach-mv78xx0/{include/mach => }/irqs.h |   4 +-
 arch/arm/mach-mv78xx0/mpp.c                     |   2 +-
 .../mach-mv78xx0/{include/mach => }/mv78xx0.h   |   4 +-
 arch/arm/mach-mv78xx0/pcie.c                    |   2 +-
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c      |   3 +-
 arch/arm/mach-netx/include/mach/param.h         |  18 -
 arch/arm/mach-omap1/board-ams-delta.c           |   2 +-
 arch/arm/mach-omap1/board-fsample.c             |   2 +-
 arch/arm/mach-omap1/board-h2.c                  |   2 +-
 arch/arm/mach-omap1/board-h3.c                  |   2 +-
 arch/arm/mach-omap1/board-innovator.c           |   2 +-
 arch/arm/mach-omap1/board-osk.c                 |   2 +-
 arch/arm/mach-omap1/board-palmte.c              |   2 +-
 arch/arm/mach-omap1/board-palmtt.c              |   2 +-
 arch/arm/mach-omap1/board-palmz71.c             |   2 +-
 arch/arm/mach-omap1/board-perseus2.c            |   2 +-
 arch/arm/mach-omap1/board-sx1-mmc.c             |   2 +-
 arch/arm/mach-omap1/board-sx1.c                 |   4 +-
 .../mach-omap1/{include/mach => }/board-sx1.h   |   0
 arch/arm/mach-omap1/{include/mach => }/camera.h |   0
 arch/arm/mach-omap1/devices.c                   |   2 +-
 arch/arm/mach-omap1/flash.c                     |   2 +-
 arch/arm/mach-omap1/{include/mach => }/flash.h  |   0
 arch/arm/mach-orion5x/Kconfig                   |  18 +-
 arch/arm/mach-orion5x/Makefile                  |   2 +
 arch/arm/mach-orion5x/board-d2net.c             |   2 +-
 arch/arm/mach-orion5x/board-dt.c                |   4 +-
 arch/arm/mach-orion5x/board-mss2.c              |   4 +-
 arch/arm/mach-orion5x/board-rd88f5182.c         |   2 +-
 .../{include/mach => }/bridge-regs.h            |   4 +-
 arch/arm/mach-orion5x/common.c                  |  20 +-
 arch/arm/mach-orion5x/db88f5281-setup.c         |   3 +-
 arch/arm/mach-orion5x/dns323-setup.c            |   3 +-
 .../arm/mach-orion5x/include/mach/entry-macro.S |  25 -
 arch/arm/mach-orion5x/include/mach/hardware.h   |  14 -
 arch/arm/mach-orion5x/include/mach/uncompress.h |  48 --
 arch/arm/mach-orion5x/irq.c                     |  13 +-
 arch/arm/mach-orion5x/{include/mach => }/irqs.h |   4 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c       |   4 +-
 arch/arm/mach-orion5x/ls-chl-setup.c            |   3 +-
 arch/arm/mach-orion5x/ls_hgl-setup.c            |   3 +-
 arch/arm/mach-orion5x/mpp.c                     |   2 +-
 arch/arm/mach-orion5x/mv2120-setup.c            |   3 +-
 arch/arm/mach-orion5x/net2big-setup.c           |   3 +-
 .../mach-orion5x/{include/mach => }/orion5x.h   |   4 +-
 arch/arm/mach-orion5x/pci.c                     |   2 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c    |   3 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c     |   3 +-
 arch/arm/mach-orion5x/rd88f5182-setup.c         |   3 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c    |   3 +-
 arch/arm/mach-orion5x/terastation_pro2-setup.c  |   3 +-
 arch/arm/mach-orion5x/ts209-setup.c             |   3 +-
 arch/arm/mach-orion5x/ts409-setup.c             |   3 +-
 arch/arm/mach-orion5x/ts78xx-setup.c            |   3 +-
 arch/arm/mach-orion5x/tsx09-common.c            |   2 +-
 arch/arm/mach-orion5x/wnr854t-setup.c           |   3 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c        |   3 +-
 arch/arm/mach-pxa/am200epd.c                    |   4 +-
 arch/arm/mach-pxa/am300epd.c                    |   4 +-
 arch/arm/mach-pxa/balloon3.c                    |   6 +-
 arch/arm/mach-pxa/capc7117.c                    |   4 +-
 arch/arm/mach-pxa/cm-x255.c                     |   2 +-
 arch/arm/mach-pxa/cm-x270.c                     |   2 +-
 arch/arm/mach-pxa/cm-x2xx.c                     |  13 +-
 arch/arm/mach-pxa/cm-x300.c                     |   4 +-
 arch/arm/mach-pxa/colibri-evalboard.c           |   6 +-
 arch/arm/mach-pxa/colibri-pxa270-income.c       |   4 +-
 arch/arm/mach-pxa/colibri-pxa270.c              |   4 +-
 arch/arm/mach-pxa/colibri-pxa300.c              |   4 +-
 arch/arm/mach-pxa/colibri-pxa320.c              |   8 +-
 arch/arm/mach-pxa/colibri-pxa3xx.c              |   4 +-
 arch/arm/mach-pxa/{include/mach => }/colibri.h  |   0
 arch/arm/mach-pxa/corgi.c                       |   6 +-
 arch/arm/mach-pxa/corgi_pm.c                    |   2 +-
 arch/arm/mach-pxa/csb726.c                      |   4 +-
 arch/arm/mach-pxa/{include/mach => }/csb726.h   |   2 +-
 arch/arm/mach-pxa/devices.c                     |   2 +-
 arch/arm/mach-pxa/em-x270.c                     |   4 +-
 .../mach-pxa/{include/mach => }/eseries-irq.h   |   0
 arch/arm/mach-pxa/eseries.c                     |   6 +-
 arch/arm/mach-pxa/ezx.c                         |  12 +-
 arch/arm/mach-pxa/gumstix.c                     |   6 +-
 arch/arm/mach-pxa/{include/mach => }/gumstix.h  |   2 +-
 arch/arm/mach-pxa/h5000.c                       |   6 +-
 arch/arm/mach-pxa/{include/mach => }/h5000.h    |   2 +-
 arch/arm/mach-pxa/himalaya.c                    |   2 +-
 arch/arm/mach-pxa/hx4700.c                      |   2 +-
 arch/arm/mach-pxa/icontrol.c                    |   4 +-
 arch/arm/mach-pxa/idp.c                         |   4 +-
 arch/arm/mach-pxa/{include/mach => }/idp.h      |   2 +-
 arch/arm/mach-pxa/littleton.c                   |   4 +-
 .../arm/mach-pxa/{include/mach => }/littleton.h |   0
 arch/arm/mach-pxa/lpd270.c                      |   4 +-
 arch/arm/mach-pxa/{include/mach => }/lpd270.h   |   0
 arch/arm/mach-pxa/lubbock.c                     |   6 +-
 arch/arm/mach-pxa/magician.c                    |   6 +-
 arch/arm/mach-pxa/mainstone.c                   |   2 +-
 .../mach-pxa/{include/mach => }/mfp-pxa25x.h    |   2 +-
 .../mach-pxa/{include/mach => }/mfp-pxa27x.h    |   2 +-
 arch/arm/mach-pxa/mfp-pxa2xx.c                  |   2 +-
 .../mach-pxa/{include/mach => }/mfp-pxa2xx.h    |   0
 .../mach-pxa/{include/mach => }/mfp-pxa300.h    |   2 +-
 .../mach-pxa/{include/mach => }/mfp-pxa320.h    |   2 +-
 arch/arm/mach-pxa/mfp-pxa3xx.c                  |   2 +-
 .../mach-pxa/{include/mach => }/mfp-pxa3xx.h    |   0
 .../mach-pxa/{include/mach => }/mfp-pxa930.h    |   2 +-
 arch/arm/mach-pxa/mioa701.c                     |  10 +-
 arch/arm/mach-pxa/{include/mach => }/mioa701.h  |   0
 arch/arm/mach-pxa/mp900.c                       |   2 +-
 arch/arm/mach-pxa/mxm8x10.c                     |   4 +-
 arch/arm/mach-pxa/{include/mach => }/mxm8x10.h  |   0
 arch/arm/mach-pxa/palm27x.c                     |   6 +-
 arch/arm/mach-pxa/{include/mach => }/palm27x.h  |   0
 arch/arm/mach-pxa/palmld.c                      |   4 +-
 arch/arm/mach-pxa/palmt5.c                      |   8 +-
 arch/arm/mach-pxa/{include/mach => }/palmt5.h   |   2 +-
 arch/arm/mach-pxa/palmtc.c                      |   4 +-
 arch/arm/mach-pxa/palmte2.c                     |   6 +-
 arch/arm/mach-pxa/{include/mach => }/palmte2.h  |   0
 arch/arm/mach-pxa/palmtreo.c                    |  10 +-
 arch/arm/mach-pxa/{include/mach => }/palmtreo.h |   0
 arch/arm/mach-pxa/palmtx.c                      |   6 +-
 arch/arm/mach-pxa/palmz72.c                     |  10 +-
 arch/arm/mach-pxa/{include/mach => }/palmz72.h  |   0
 arch/arm/mach-pxa/pcm027.c                      |   4 +-
 arch/arm/mach-pxa/{include/mach => }/pcm027.h   |   2 +-
 arch/arm/mach-pxa/pcm990-baseboard.c            |   4 +-
 .../{include/mach => }/pcm990_baseboard.h       |   4 +-
 arch/arm/mach-pxa/pm.c                          |   2 +-
 arch/arm/mach-pxa/{include/mach => }/pm.h       |   0
 arch/arm/mach-pxa/poodle.c                      |   4 +-
 arch/arm/mach-pxa/pxa25x.c                      |   4 +-
 arch/arm/mach-pxa/{include/mach => }/pxa25x.h   |   2 +-
 .../mach-pxa/{include/mach => }/pxa27x-udc.h    |   0
 arch/arm/mach-pxa/pxa27x.c                      |   4 +-
 arch/arm/mach-pxa/{include/mach => }/pxa27x.h   |   2 +-
 arch/arm/mach-pxa/pxa2xx.c                      |   2 +-
 arch/arm/mach-pxa/pxa300.c                      |   2 +-
 arch/arm/mach-pxa/{include/mach => }/pxa300.h   |   4 +-
 arch/arm/mach-pxa/pxa320.c                      |   2 +-
 arch/arm/mach-pxa/{include/mach => }/pxa320.h   |   4 +-
 arch/arm/mach-pxa/pxa3xx-ulpi.c                 |   2 +-
 arch/arm/mach-pxa/pxa3xx.c                      |   2 +-
 arch/arm/mach-pxa/{include/mach => }/pxa3xx.h   |   0
 arch/arm/mach-pxa/pxa930.c                      |   2 +-
 arch/arm/mach-pxa/{include/mach => }/pxa930.h   |   4 +-
 arch/arm/mach-pxa/raumfeld.c                    |   8 +-
 arch/arm/mach-pxa/{include/mach => }/regs-rtc.h |   0
 arch/arm/mach-pxa/{include/mach => }/regs-u2d.h |   0
 arch/arm/mach-pxa/saar.c                        |   2 +-
 arch/arm/mach-pxa/sharpsl_pm.c                  |   6 +-
 .../mach-pxa/{include/mach => }/sharpsl_pm.h    |   0
 arch/arm/mach-pxa/spitz.c                       |   6 +-
 arch/arm/mach-pxa/spitz_pm.c                    |   4 +-
 arch/arm/mach-pxa/stargate2.c                   |   6 +-
 arch/arm/mach-pxa/tavorevb.c                    |   2 +-
 arch/arm/mach-pxa/tosa-bt.c                     |   2 +-
 arch/arm/mach-pxa/tosa.c                        |   6 +-
 arch/arm/mach-pxa/{include/mach => }/tosa_bt.h  |   0
 arch/arm/mach-pxa/trizeps4.c                    |   2 +-
 arch/arm/mach-pxa/{include/mach => }/udc.h      |   0
 arch/arm/mach-pxa/viper.c                       |   4 +-
 arch/arm/mach-pxa/{include/mach => }/viper.h    |   0
 arch/arm/mach-pxa/vpac270.c                     |   6 +-
 arch/arm/mach-pxa/xcep.c                        |   2 +-
 arch/arm/mach-pxa/z2.c                          |   6 +-
 arch/arm/mach-pxa/zeus.c                        |  10 +-
 arch/arm/mach-pxa/{include/mach => }/zeus.h     |   0
 arch/arm/mach-pxa/zylonite.c                    |   4 +-
 arch/arm/mach-pxa/{include/mach => }/zylonite.h |   0
 arch/arm/mach-pxa/zylonite_pxa300.c             |   4 +-
 arch/arm/mach-pxa/zylonite_pxa320.c             |   4 +-
 arch/arm/mach-realview/Kconfig                  |  66 +-
 arch/arm/mach-realview/Makefile                 |   9 +-
 .../mach-realview/{include/mach => }/board-eb.h |   4 +-
 .../{include/mach => }/board-pb1176.h           |   4 +-
 .../{include/mach => }/board-pb11mp.h           |   4 +-
 .../{include/mach => }/board-pba8.h             |   4 +-
 .../{include/mach => }/board-pbx.h              |   4 +-
 arch/arm/mach-realview/core.c                   |   6 +-
 arch/arm/mach-realview/core.h                   |   2 -
 .../mach-realview/{include/mach => }/hardware.h |   2 -
 arch/arm/mach-realview/include/mach/barriers.h  |   8 -
 arch/arm/mach-realview/include/mach/irqs.h      |  40 -
 arch/arm/mach-realview/include/mach/memory.h    |  64 --
 .../arm/mach-realview/include/mach/uncompress.h |  77 --
 .../mach-realview/{include/mach => }/irqs-eb.h  |  20 +-
 .../{include/mach => }/irqs-pb1176.h            |  23 -
 .../{include/mach => }/irqs-pb11mp.h            |  27 +-
 .../{include/mach => }/irqs-pba8.h              |  23 -
 .../mach-realview/{include/mach => }/irqs-pbx.h |  24 +-
 .../mach-realview/{include/mach => }/platform.h |   2 -
 arch/arm/mach-realview/platsmp-dt.c             |  91 +++
 arch/arm/mach-realview/platsmp.c                |   8 +-
 arch/arm/mach-realview/realview-dt.c            |   1 -
 arch/arm/mach-realview/realview_eb.c            |  13 +-
 arch/arm/mach-realview/realview_pb1176.c        |   6 +-
 arch/arm/mach-realview/realview_pb11mp.c        |  12 +-
 arch/arm/mach-realview/realview_pba8.c          |  14 +-
 arch/arm/mach-realview/realview_pbx.c           |  14 +-
 arch/arm/mach-s3c24xx/include/mach/pm-core.h    |  14 +
 arch/arm/mach-s3c24xx/irq-pm.c                  |  11 +-
 arch/arm/mach-s3c64xx/Kconfig                   |  31 +-
 arch/arm/mach-s3c64xx/Makefile                  |  24 +-
 arch/arm/mach-s3c64xx/common.c                  |   5 +-
 arch/arm/mach-s3c64xx/cpuidle.c                 |   5 +-
 arch/arm/mach-s3c64xx/dev-uart.c                |   1 +
 .../arm/mach-s3c64xx/include/mach/debug-macro.S |  38 -
 .../mach-s3c64xx/include/mach/gpio-samsung.h    |   3 +
 arch/arm/mach-s3c64xx/include/mach/irqs.h       |  20 +-
 arch/arm/mach-s3c64xx/include/mach/pm-core.h    |   9 +-
 arch/arm/mach-s3c64xx/irq-pm.c                  |   2 +-
 arch/arm/mach-s3c64xx/mach-anw6410.c            |   3 +-
 arch/arm/mach-s3c64xx/mach-crag6410-module.c    |   6 +
 arch/arm/mach-s3c64xx/mach-crag6410.c           |   2 +
 arch/arm/mach-s3c64xx/mach-hmt.c                |   2 +
 arch/arm/mach-s3c64xx/mach-mini6410.c           |   5 +-
 arch/arm/mach-s3c64xx/mach-ncp.c                |   2 +
 arch/arm/mach-s3c64xx/mach-real6410.c           |   6 +-
 arch/arm/mach-s3c64xx/mach-smartq.c             |  16 +-
 arch/arm/mach-s3c64xx/mach-smartq5.c            |   2 +
 arch/arm/mach-s3c64xx/mach-smartq7.c            |   2 +
 arch/arm/mach-s3c64xx/mach-smdk6400.c           |   3 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c           |   6 +-
 arch/arm/mach-s3c64xx/pl080.c                   |   4 +
 arch/arm/mach-s3c64xx/pm.c                      |   4 +
 arch/arm/mach-s3c64xx/s3c6400.c                 |   2 +-
 arch/arm/mach-s3c64xx/s3c6410.c                 |   2 +-
 arch/arm/mach-versatile/Kconfig                 |  41 +-
 arch/arm/mach-versatile/Makefile                |   6 +-
 arch/arm/mach-versatile/Makefile.boot           |   4 -
 arch/arm/mach-versatile/core.c                  | 808 -------------------
 arch/arm/mach-versatile/core.h                  |  46 --
 arch/arm/mach-versatile/include/mach/clkdev.h   |  16 -
 arch/arm/mach-versatile/include/mach/hardware.h |  38 -
 arch/arm/mach-versatile/include/mach/irqs.h     | 134 ---
 arch/arm/mach-versatile/include/mach/platform.h | 416 ----------
 .../mach-versatile/include/mach/uncompress.h    |  45 --
 arch/arm/mach-versatile/pci.c                   | 368 ---------
 arch/arm/mach-versatile/versatile_ab.c          |  44 -
 arch/arm/mach-versatile/versatile_dt.c          | 376 ++++++++-
 arch/arm/mach-versatile/versatile_pb.c          |  91 ---
 arch/arm/mach-w90x900/cpu.c                     |   4 +-
 .../mach-w90x900/{include/mach => }/regs-ebi.h  |   0
 .../mach-w90x900/{include/mach => }/regs-gcr.h  |   0
 .../{include/mach => }/regs-timer.h             |   0
 .../mach-w90x900/{include/mach => }/regs-usb.h  |   0
 arch/arm/mach-w90x900/time.c                    |   2 +-
 arch/arm/mm/Kconfig                             |  32 +-
 arch/arm/mm/idmap.c                             |   2 +-
 arch/arm/mm/mmu.c                               |   2 +-
 arch/arm/mm/proc-mohawk.S                       |   2 +
 arch/arm/plat-orion/common.c                    |  21 -
 arch/arm/plat-orion/include/plat/common.h       |   2 -
 arch/arm/plat-orion/irq.c                       |   1 -
 arch/arm/plat-orion/mpp.c                       |   1 -
 arch/arm/plat-pxa/Makefile                      |   3 +-
 arch/arm/plat-pxa/ssp.c                         |   1 -
 arch/arm/plat-samsung/Kconfig                   |   5 +-
 arch/arm/plat-samsung/Makefile                  |   5 +-
 arch/arm/plat-samsung/devs.c                    |  22 +-
 .../arm/plat-samsung}/gpio-samsung.c            |  12 +-
 arch/arm/plat-samsung/include/plat/pm.h         |   8 -
 arch/arm/plat-samsung/init.c                    |   5 +
 arch/arm/plat-samsung/pm.c                      |   4 -
 drivers/clk/mmp/clk-mmp2.c                      |  11 +-
 drivers/clk/mmp/clk-pxa168.c                    |  11 +-
 drivers/clk/mmp/clk-pxa910.c                    |  13 +-
 drivers/clk/pxa/clk-pxa25x.c                    |   1 -
 drivers/clk/versatile/Kconfig                   |   5 +-
 drivers/clk/versatile/clk-icst.c                | 194 ++++-
 drivers/clk/versatile/clk-realview.c            |  10 +-
 drivers/gpio/Kconfig                            |   7 -
 drivers/gpio/Makefile                           |   1 -
 drivers/iio/adc/exynos_adc.c                    | 224 ++++-
 drivers/input/touchscreen/Kconfig               |   2 +-
 drivers/irqchip/irq-versatile-fpga.c            |   5 -
 drivers/soc/Makefile                            |   1 +
 drivers/soc/dove/pmu.c                          |  43 +
 drivers/soc/versatile/soc-realview.c            |   4 +
 include/linux/clk/mmp.h                         |  17 +
 .../linux/platform_data/touchscreen-s3c2410.h   |   1 +
 include/linux/soc/dove/pmu.h                    |  19 +
 sound/soc/samsung/smartq_wm8987.c               |  76 +-
 415 files changed, 2369 insertions(+), 4001 deletions(-)
 rename arch/arm/{mach-footbridge/include/mach/debug-macro.S => include/debug/dc21285.S} (100%)
 rename arch/arm/mach-davinci/{include/mach => }/cp_intc.h (100%)
 rename arch/arm/mach-davinci/{include/mach => }/cpuidle.h (100%)
 rename arch/arm/mach-davinci/{include/mach => }/ddr2.h (100%)
 rename arch/arm/mach-davinci/{include/mach => }/psc.h (100%)
 rename arch/arm/mach-davinci/{include/mach => }/sram.h (100%)
 delete mode 100644 arch/arm/mach-dove/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-iop13xx/include/mach/pci.h
 rename arch/arm/mach-iop13xx/{include/mach => }/msi.h (100%)
 rename arch/arm/mach-ks8695/{include/mach => }/devices.h (100%)
 rename arch/arm/mach-ks8695/{include/mach => }/regs-hpna.h (100%)
 rename arch/arm/mach-ks8695/{include/mach => }/regs-lan.h (100%)
 rename arch/arm/mach-ks8695/{include/mach => }/regs-mem.h (100%)
 rename arch/arm/mach-ks8695/{include/mach => }/regs-pci.h (100%)
 rename arch/arm/mach-ks8695/{include/mach => }/regs-sys.h (100%)
 rename arch/arm/mach-ks8695/{include/mach => }/regs-wan.h (100%)
 rename arch/arm/mach-mmp/{include/mach => }/addr-map.h (96%)
 rename arch/arm/mach-mmp/{include/mach => }/cputype.h (100%)
 rename arch/arm/mach-mmp/{include/mach => }/devices.h (100%)
 delete mode 100644 arch/arm/mach-mmp/include/mach/dma.h
 delete mode 100644 arch/arm/mach-mmp/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-mmp/include/mach/regs-smc.h
 delete mode 100644 arch/arm/mach-mmp/include/mach/uncompress.h
 rename arch/arm/mach-mmp/{include/mach => }/irqs.h (100%)
 rename arch/arm/mach-mmp/{include/mach => }/mfp-mmp2.h (99%)
 rename arch/arm/mach-mmp/{include/mach => }/mfp-pxa168.h (99%)
 rename arch/arm/mach-mmp/{include/mach => }/mfp-pxa910.h (99%)
 rename arch/arm/mach-mmp/{include/mach => }/mfp.h (100%)
 rename arch/arm/mach-mmp/{include/mach => }/mmp2.h (99%)
 rename arch/arm/mach-mmp/{include/mach => }/pm-mmp2.h (98%)
 rename arch/arm/mach-mmp/{include/mach => }/pm-pxa910.h (100%)
 rename arch/arm/mach-mmp/{include/mach => }/pxa168.h (98%)
 rename arch/arm/mach-mmp/{include/mach => }/pxa910.h (98%)
 rename arch/arm/mach-mmp/{include/mach => }/regs-apbc.h (88%)
 rename arch/arm/mach-mmp/{include/mach => }/regs-apmu.h (91%)
 rename arch/arm/mach-mmp/{include/mach => }/regs-icu.h (96%)
 rename arch/arm/mach-mmp/{include/mach => }/regs-timers.h (93%)
 rename arch/arm/mach-mmp/{include/mach => }/regs-usb.h (100%)
 rename arch/arm/mach-mmp/{include/mach => }/teton_bga.h (92%)
 rename arch/arm/mach-mv78xx0/{include/mach => }/bridge-regs.h (92%)
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/uncompress.h
 rename arch/arm/mach-mv78xx0/{include/mach => }/irqs.h (95%)
 rename arch/arm/mach-mv78xx0/{include/mach => }/mv78xx0.h (98%)
 delete mode 100644 arch/arm/mach-netx/include/mach/param.h
 rename arch/arm/mach-omap1/{include/mach => }/board-sx1.h (100%)
 rename arch/arm/mach-omap1/{include/mach => }/camera.h (100%)
 rename arch/arm/mach-omap1/{include/mach => }/flash.h (100%)
 rename arch/arm/mach-orion5x/{include/mach => }/bridge-regs.h (92%)
 delete mode 100644 arch/arm/mach-orion5x/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-orion5x/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-orion5x/include/mach/uncompress.h
 rename arch/arm/mach-orion5x/{include/mach => }/irqs.h (94%)
 rename arch/arm/mach-orion5x/{include/mach => }/orion5x.h (99%)
 rename arch/arm/mach-pxa/{include/mach => }/colibri.h (100%)
 rename arch/arm/mach-pxa/{include/mach => }/csb726.h (93%)
 rename arch/arm/mach-pxa/{include/mach => }/eseries-irq.h (100%)
 rename arch/arm/mach-pxa/{include/mach => }/gumstix.h (98%)
 rename arch/arm/mach-pxa/{include/mach => }/h5000.h (99%)
 rename arch/arm/mach-pxa/{include/mach => }/idp.h (99%)
 rename arch/arm/mach-pxa/{include/mach => }/littleton.h (100%)
 rename arch/arm/mach-pxa/{include/mach => }/lpd270.h (100%)
 rename arch/arm/mach-pxa/{include/mach => }/mfp-pxa25x.h (99%)
 rename arch/arm/mach-pxa/{include/mach => }/mfp-pxa27x.h (99%)
 rename arch/arm/mach-pxa/{include/mach => }/mfp-pxa2xx.h (100%)
 rename arch/arm/mach-pxa/{include/mach => }/mfp-pxa300.h (99%)
 rename arch/arm/mach-pxa/{include/mach => }/mfp-pxa320.h (99%)
 rename arch/arm/mach-pxa/{include/mach => }/mfp-pxa3xx.h (100%)
 rename arch/arm/mach-pxa/{include/mach => }/mfp-pxa930.h (99%)
 rename arch/arm/mach-pxa/{include/mach => }/mioa701.h (100%)
 rename arch/arm/mach-pxa/{include/mach => }/mxm8x10.h (100%)
 rename arch/arm/mach-pxa/{include/mach => }/palm27x.h (100%)
 rename arch/arm/mach-pxa/{include/mach => }/palmt5.h (98%)
 rename arch/arm/mach-pxa/{include/mach => }/palmte2.h (100%)
 rename arch/arm/mach-pxa/{include/mach => }/palmtreo.h (100%)
 rename arch/arm/mach-pxa/{include/mach => }/palmz72.h (100%)
 rename arch/arm/mach-pxa/{include/mach => }/pcm027.h (98%)
 rename arch/arm/mach-pxa/{include/mach => }/pcm990_baseboard.h (99%)
 rename arch/arm/mach-pxa/{include/mach => }/pm.h (100%)
 rename arch/arm/mach-pxa/{include/mach => }/pxa25x.h (84%)
 rename arch/arm/mach-pxa/{include/mach => }/pxa27x-udc.h (100%)
 rename arch/arm/mach-pxa/{include/mach => }/pxa27x.h (97%)
 rename arch/arm/mach-pxa/{include/mach => }/pxa300.h (59%)
 rename arch/arm/mach-pxa/{include/mach => }/pxa320.h (59%)
 rename arch/arm/mach-pxa/{include/mach => }/pxa3xx.h (100%)
 rename arch/arm/mach-pxa/{include/mach => }/pxa930.h (59%)
 rename arch/arm/mach-pxa/{include/mach => }/regs-rtc.h (100%)
 rename arch/arm/mach-pxa/{include/mach => }/regs-u2d.h (100%)
 rename arch/arm/mach-pxa/{include/mach => }/sharpsl_pm.h (100%)
 rename arch/arm/mach-pxa/{include/mach => }/tosa_bt.h (100%)
 rename arch/arm/mach-pxa/{include/mach => }/udc.h (100%)
 rename arch/arm/mach-pxa/{include/mach => }/viper.h (100%)
 rename arch/arm/mach-pxa/{include/mach => }/zeus.h (100%)
 rename arch/arm/mach-pxa/{include/mach => }/zylonite.h (100%)
 rename arch/arm/mach-realview/{include/mach => }/board-eb.h (97%)
 rename arch/arm/mach-realview/{include/mach => }/board-pb1176.h (97%)
 rename arch/arm/mach-realview/{include/mach => }/board-pb11mp.h (98%)
 rename arch/arm/mach-realview/{include/mach => }/board-pba8.h (97%)
 rename arch/arm/mach-realview/{include/mach => }/board-pbx.h (98%)
 rename arch/arm/mach-realview/{include/mach => }/hardware.h (95%)
 delete mode 100644 arch/arm/mach-realview/include/mach/barriers.h
 delete mode 100644 arch/arm/mach-realview/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-realview/include/mach/memory.h
 delete mode 100644 arch/arm/mach-realview/include/mach/uncompress.h
 rename arch/arm/mach-realview/{include/mach => }/irqs-eb.h (91%)
 rename arch/arm/mach-realview/{include/mach => }/irqs-pb1176.h (87%)
 rename arch/arm/mach-realview/{include/mach => }/irqs-pb11mp.h (90%)
 rename arch/arm/mach-realview/{include/mach => }/irqs-pba8.h (87%)
 rename arch/arm/mach-realview/{include/mach => }/irqs-pbx.h (90%)
 rename arch/arm/mach-realview/{include/mach => }/platform.h (99%)
 create mode 100644 arch/arm/mach-realview/platsmp-dt.c
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-versatile/Makefile.boot
 delete mode 100644 arch/arm/mach-versatile/core.c
 delete mode 100644 arch/arm/mach-versatile/core.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/platform.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-versatile/pci.c
 delete mode 100644 arch/arm/mach-versatile/versatile_ab.c
 delete mode 100644 arch/arm/mach-versatile/versatile_pb.c
 rename arch/arm/mach-w90x900/{include/mach => }/regs-ebi.h (100%)
 rename arch/arm/mach-w90x900/{include/mach => }/regs-gcr.h (100%)
 rename arch/arm/mach-w90x900/{include/mach => }/regs-timer.h (100%)
 rename arch/arm/mach-w90x900/{include/mach => }/regs-usb.h (100%)
 rename {drivers/gpio => arch/arm/plat-samsung}/gpio-samsung.c (99%)
 create mode 100644 include/linux/clk/mmp.h
