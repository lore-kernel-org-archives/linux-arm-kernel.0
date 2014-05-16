From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 16 May 2014 23:12:00 +0800
Subject: [GIT PULL] ARM: imx: soc changes for 3.16
Message-ID: <20140516151158.GC10685@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d1db0eea852497762cab43b905b879dfcd3b8987:

  Linux 3.15-rc3 (2014-04-27 19:29:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-3.16

for you to fetch changes up to 46ae42498ef6febdaa6b51359f1ede38cd6b5a47:

  ARM: mx25: Add CLKO support (2014-05-16 22:51:34 +0800)

----------------------------------------------------------------
i.MX SoC changes for 3.16:
 - A few cleanups on mx21ads board file, which should make the later
   conversion to DT a little bit easier.
 - Add some missing clocks and drop unused clk lookups for i.MX1 and
   i.MX27 clock drivers
 - Add initial i.MX SoloX (imx6sx) SoC support
 - Remove mx51_babbage and mach-cpuimx51sd board files, as the
   equivalent DT support is ready for the boards
 - Clean up device tree timer initialization a little bit
 - Add missing i2c4 clock for i.MX6 DualLite/Solo
 - Add missing CKO clock i.MX25
 - Add shared gate clock support for i.MX specific clk_gate2
 - Add low-level debug support for SoC VF610
 - Some random code cleanups and defconfig updates

----------------------------------------------------------------
Alexander Shiyan (10):
      ARM: i.MX: mx21ads: Replace direct handling of peripheral bits with GPIOs
      ARM: i.MX: mx21ads: Use fixed voltage regulator for LCD power
      ARM: i.MX: mx21ads: Cleanup board
      ARM: i.MX: Remove #ifdef CONFIG_OF
      ARM: i.MX27 clk: Add missing clocks for MSHC and RTIC
      ARM: i.MX27 clk: Remove clk_register_clkdev() for unused clocks
      ARM: i.MX: Fix eMMa PrP resource size
      ARM: i.MX: Setup IRQ handler from IRQ driver
      ARM: i.MX1 clk: Add missing clocks
      ARM: i.MX1 clk: Remove clk_register_clkdev() for unused clocks

Anson Huang (1):
      ARM: imx: add clock driver for imx6sx

Brian Norris (1):
      ARM: imx/mxs defconfigs: add MTD_SPI_NOR (new dependency for M25P80)

Denis Carikli (2):
      ARM: imx_v4_v5_defconfig: Enable drivers for i.MX25/i.MX35 USB support.
      ARM: imx_v6_v7_defconfig: Add more drm drivers.

Fabio Estevam (4):
      ARM: imx: Remove mx51_babbage board file
      ARM: mxs_defconfig: Select CONFIG_CRYPTO_DEV_MXS_DCP
      ARM: mx51: Remove mach-cpuimx51sd board file
      ARM: mx25: Add CLKO support

Gilles Chanteperdrix (1):
      ARM: imx: factor device tree timer initialization

Iain Paton (1):
      ARM: imx6: clk: i.MX6 DualLite/Solo i2c4 clock

Juan Solano (1):
      ARM: i.MX27 pca100: remove deprecated IRQF_DISABLED

Philipp Zabel (1):
      ARM: i.MX5: Remove outdated VPU clock lookups

Shawn Guo (10):
      ARM: imx_v6_v7_defconfig: enable cpufreq and CMA support
      ARM: imx: drop CONFIG_MMC_UNSAFE_RESUME from defconfig
      ARM: imx_v6_v7_defconfig: enable option CONFIG_LOCALVERSION_AUTO
      ARM: imx: define struct clk_gate2 on our own
      ARM: imx: lock is always valid for clk_gate2
      ARM: imx: add shared gate clock support
      ARM: imx6q: add the missing esai_ahb clock
      ARM: imx_v4_v5_defconfig: drop CONFIG_COMMON_CLK_DEBUG option
      ARM: imx: add low-level debug support for imx6sx
      ARM: imx: add basic imx6sx SoC support

Stefan Agner (1):
      ARM: vf610: add UART choice for low-level debug

 .../devicetree/bindings/clock/imx25-clock.txt      |   3 +
 .../devicetree/bindings/clock/imx27-clock.txt      |   7 +-
 .../devicetree/bindings/clock/imx6q-clock.txt      |   1 +
 .../devicetree/bindings/clock/imx6sx-clock.txt     |  13 +
 arch/arm/Kconfig.debug                             |  22 +-
 arch/arm/configs/imx_v4_v5_defconfig               |   8 +-
 arch/arm/configs/imx_v6_v7_defconfig               |  12 +-
 arch/arm/configs/mxs_defconfig                     |   7 +-
 arch/arm/include/debug/imx-uart.h                  |  11 +
 arch/arm/include/debug/vf.S                        |  15 +-
 arch/arm/mach-imx/Kconfig                          |  69 +--
 arch/arm/mach-imx/Makefile                         |   6 +-
 arch/arm/mach-imx/avic.c                           |   4 +-
 arch/arm/mach-imx/clk-gate2.c                      |  47 +-
 arch/arm/mach-imx/clk-imx1.c                       |  41 +-
 arch/arm/mach-imx/clk-imx25.c                      |  24 +-
 arch/arm/mach-imx/clk-imx27.c                      |  27 +-
 arch/arm/mach-imx/clk-imx31.c                      |   2 -
 arch/arm/mach-imx/clk-imx51-imx53.c                |  20 +-
 arch/arm/mach-imx/clk-imx6q.c                      |  21 +-
 arch/arm/mach-imx/clk-imx6sl.c                     |   6 +-
 arch/arm/mach-imx/clk-imx6sx.c                     | 524 +++++++++++++++++++++
 arch/arm/mach-imx/clk.h                            |  13 +-
 arch/arm/mach-imx/common.h                         |  15 +-
 arch/arm/mach-imx/cpu.c                            |   3 +
 arch/arm/mach-imx/devices/platform-mx2-emma.c      |   2 +-
 arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c     | 231 ---------
 arch/arm/mach-imx/imx25-dt.c                       |   1 -
 arch/arm/mach-imx/imx27-dt.c                       |   1 -
 arch/arm/mach-imx/imx31-dt.c                       |   1 -
 arch/arm/mach-imx/imx35-dt.c                       |   1 -
 arch/arm/mach-imx/imx51-dt.c                       |   1 -
 arch/arm/mach-imx/mach-apf9328.c                   |   1 -
 arch/arm/mach-imx/mach-armadillo5x0.c              |   1 -
 arch/arm/mach-imx/mach-bug.c                       |   1 -
 arch/arm/mach-imx/mach-cpuimx27.c                  |   1 -
 arch/arm/mach-imx/mach-cpuimx35.c                  |   1 -
 arch/arm/mach-imx/mach-cpuimx51sd.c                | 364 --------------
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c           |   1 -
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c        |   1 -
 arch/arm/mach-imx/mach-imx27ipcam.c                |   1 -
 arch/arm/mach-imx/mach-imx27lite.c                 |   1 -
 arch/arm/mach-imx/mach-imx50.c                     |   1 -
 arch/arm/mach-imx/mach-imx53.c                     |   1 -
 arch/arm/mach-imx/mach-imx6sx.c                    |  51 ++
 arch/arm/mach-imx/mach-kzm_arm11_01.c              |   1 -
 arch/arm/mach-imx/mach-mx1ads.c                    |   2 -
 arch/arm/mach-imx/mach-mx21ads.c                   | 174 +++----
 arch/arm/mach-imx/mach-mx25_3ds.c                  |   1 -
 arch/arm/mach-imx/mach-mx27_3ds.c                  |   1 -
 arch/arm/mach-imx/mach-mx27ads.c                   |   1 -
 arch/arm/mach-imx/mach-mx31_3ds.c                  |   1 -
 arch/arm/mach-imx/mach-mx31ads.c                   |   1 -
 arch/arm/mach-imx/mach-mx31lilly.c                 |   1 -
 arch/arm/mach-imx/mach-mx31lite.c                  |   1 -
 arch/arm/mach-imx/mach-mx31moboard.c               |   1 -
 arch/arm/mach-imx/mach-mx35_3ds.c                  |   1 -
 arch/arm/mach-imx/mach-mx51_babbage.c              | 428 -----------------
 arch/arm/mach-imx/mach-mxt_td60.c                  |   1 -
 arch/arm/mach-imx/mach-pca100.c                    |   4 +-
 arch/arm/mach-imx/mach-pcm037.c                    |   1 -
 arch/arm/mach-imx/mach-pcm038.c                    |   1 -
 arch/arm/mach-imx/mach-pcm043.c                    |   1 -
 arch/arm/mach-imx/mach-qong.c                      |   1 -
 arch/arm/mach-imx/mach-scb9328.c                   |   1 -
 arch/arm/mach-imx/mach-vpr200.c                    |   1 -
 arch/arm/mach-imx/mxc.h                            |   6 +
 arch/arm/mach-imx/time.c                           |  15 +
 arch/arm/mach-imx/tzic.c                           |   4 +-
 include/dt-bindings/clock/imx6sx-clock.h           | 256 ++++++++++
 70 files changed, 1152 insertions(+), 1339 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx6sx-clock.txt
 create mode 100644 arch/arm/mach-imx/clk-imx6sx.c
 delete mode 100644 arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c
 delete mode 100644 arch/arm/mach-imx/mach-cpuimx51sd.c
 create mode 100644 arch/arm/mach-imx/mach-imx6sx.c
 delete mode 100644 arch/arm/mach-imx/mach-mx51_babbage.c
 create mode 100644 include/dt-bindings/clock/imx6sx-clock.h
