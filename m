From: david@lechnology.com (David Lechner)
Date: Sun, 31 Dec 2017 17:39:41 -0600
Subject: =?UTF-8?q?=5BPATCH=20v4=200/7=5D=20ARM=3A=20davinci=3A=20convert=20to=20common=20clock=20framework=E2=80=8B?=
Message-ID: <1514763588-31560-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series converts mach-davinci to use the common clock framework.

Basically, this series does some cleanup and rearranging to get things
ready for the conversion. Then there is a patch to add new driver in
drivers/clk and finally a patch to make the conversion from the mach
clock drivers to the new drivers.

I have tested this on LEGO MINDSTORMS EV3 (TI AM1808), so I am confident
that I haven't broken anything (too badly) in da850. But, I don't have
other hardware to test.

The one thing that I know I have broken is CPU frequency scaling on da850.
I don't think it was working with device tree anyway, so I can't really test
it with the hardware I have. I'm hoping that it will be OK to defer fixing
it and add device tree support at the same time.

Dependencies:
* This series applies on top of "ARM: davinici: move watchdog restart from
  mach to drivers?" [1][2]
* On da850, you will also need a patch to prevent problems with the USB PHY
  clocks [3]
* Or get it all at once:
    git fetch https://github.com/dlech/ev3dev-kernel.git common-clk-v4

[1]: https://patchwork.kernel.org/patch/10105623/
[2]: https://patchwork.kernel.org/patch/10105613/
[3]: https://patchwork.kernel.org/patch/10133193/


v4 changes:
* Basically, the whole series is new/reworked except for the first patch.
* Instead of having an intermediate conversion of the clocks in mach-davinci,
  new clock drivers are introduced in drivers/clk.
* There are a few more cleanup patches added before making the conversion.

v3 changes:
* Remove leftovers from rebasing in "ARM: davinci: don't use static clk_lookup"
  (fixes compile error)

v2 changes:
* Dropped "ARM: davinci: clean up map_io functions" - will resend as separate
  patch series
* Reworked remaining patches so that there is less shuffling around



David Lechner (7):
  ARM: davinci: move davinci_clk_init() to init_time
  ARM: davinci: don't use static clk_lookup
  ARM: davinci: fix duplicate clocks
  ARM: davinci: remove davinci_set_refclk_rate()
  clk: Introduce davinci clocks
  ARM: davinci: convert to common clock framework
  ARM: davinci_all_defconfig: remove CONFIG_DAVINCI_RESET_CLOCKS

 arch/arm/Kconfig                            |   2 +-
 arch/arm/configs/davinci_all_defconfig      |   1 -
 arch/arm/mach-davinci/Kconfig               |  12 -
 arch/arm/mach-davinci/Makefile              |   2 +-
 arch/arm/mach-davinci/board-da830-evm.c     |  17 +-
 arch/arm/mach-davinci/board-da850-evm.c     |   2 +-
 arch/arm/mach-davinci/board-dm355-evm.c     |   2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c |   2 +-
 arch/arm/mach-davinci/board-dm365-evm.c     |   2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c    |   2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c    |  17 +-
 arch/arm/mach-davinci/board-mityomapl138.c  |   2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c   |   2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c |  17 +-
 arch/arm/mach-davinci/board-sffsdr.c        |   2 +-
 arch/arm/mach-davinci/clock.c               | 745 --------------------------
 arch/arm/mach-davinci/clock.h               |  72 ---
 arch/arm/mach-davinci/common.c              |   1 -
 arch/arm/mach-davinci/da830.c               | 536 +++++--------------
 arch/arm/mach-davinci/da850.c               | 785 ++++++----------------------
 arch/arm/mach-davinci/da8xx-dt.c            |  17 +-
 arch/arm/mach-davinci/davinci.h             |   4 +
 arch/arm/mach-davinci/devices-da8xx.c       |  46 +-
 arch/arm/mach-davinci/dm355.c               | 452 ++++------------
 arch/arm/mach-davinci/dm365.c               | 594 ++++++---------------
 arch/arm/mach-davinci/dm644x.c              | 401 ++++----------
 arch/arm/mach-davinci/dm646x.c              | 451 +++++-----------
 arch/arm/mach-davinci/include/mach/clock.h  |   3 -
 arch/arm/mach-davinci/include/mach/common.h |   9 -
 arch/arm/mach-davinci/include/mach/da8xx.h  |  11 +-
 arch/arm/mach-davinci/psc.c                 | 137 -----
 arch/arm/mach-davinci/psc.h                 |  14 -
 arch/arm/mach-davinci/usb-da8xx.c           | 225 +-------
 drivers/clk/Makefile                        |   1 +
 drivers/clk/davinci/Makefile                |   3 +
 drivers/clk/davinci/da8xx-cfgchip-clk.c     | 380 ++++++++++++++
 drivers/clk/davinci/pll.c                   | 333 ++++++++++++
 drivers/clk/davinci/psc.c                   | 217 ++++++++
 include/linux/clk/davinci.h                 |  46 ++
 include/linux/platform_data/davinci_clk.h   |  25 +
 40 files changed, 1875 insertions(+), 3717 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/clock.c
 delete mode 100644 arch/arm/mach-davinci/psc.c
 create mode 100644 drivers/clk/davinci/Makefile
 create mode 100644 drivers/clk/davinci/da8xx-cfgchip-clk.c
 create mode 100644 drivers/clk/davinci/pll.c
 create mode 100644 drivers/clk/davinci/psc.c
 create mode 100644 include/linux/clk/davinci.h
 create mode 100644 include/linux/platform_data/davinci_clk.h

-- 
2.7.4
