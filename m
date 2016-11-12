From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 12 Nov 2016 16:35:49 +0100
Subject: [GIT PULL 2/3] Rockchip dts32 changes for 4.10
In-Reply-To: <1698724.ZQnZMjf8xY@phil>
References: <1698724.ZQnZMjf8xY@phil>
Message-ID: <2517910.T56YgEDzxC@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.10-rockchip-dts32-1

for you to fetch changes up to 6a8883d614c7bede1075a4850139daa9723c291e:

  ARM: dts: rockchip: replace to "max-frequency" instead of "clock-freq-min-max" (2016-11-09 14:46:04 +0100)

----------------------------------------------------------------
32bit devicetree changes for Rockchip including removal of skeleton.dtsi
inclusion, missing unit names for memory nodes, various frequency
optimizations allowing for better performance on rk3066, the usage of
pin constants to bridge between the two numbering schemes used (gpio
controllers using 0-31 and pins being labeled A0-A7,..., D0-D7)
and UHS/HS modes for the mmc controllers on the popmetal board.

Two new boards, the PX3-based evaluation board, with the PX3 being an
industrial variant of the rk3188 soc and the Rikomagic MK808 board
based around the rk3066 are also added.

----------------------------------------------------------------
Andy Yan (3):
      ARM: dts: rockchip: add rockchip PX3 Evaluation board
      include: dt-bindings: Add GPIO pin index definition for rockchip pinctrl
      ARM: dts: rockchip: use pin constants to describe gpios on Popmetal-RK3288

Finley Xiao (1):
      ARM: dts: rockchip: update compatible strings for Rockchip efuse

Heiko Stuebner (2):
      Merge branch 'v4.10-shared/clkids' into v4.10-armsoc/dts32
      Merge branch 'v4.10-shared/pinctrl' into v4.10-armsoc/dts32

Jaehoon Chung (1):
      ARM: dts: rockchip: replace to "max-frequency" instead of "clock-freq-min-max"

Javier Martinez Canillas (8):
      ARM: dts: rockchip: Remove skeleton.dtsi inclusion in rk3036.dtsi
      ARM: dts: rockchip: Remove skeleton.dtsi inclusion in rk322x.dtsi
      ARM: dts: rockchip: Remove skeleton.dtsi inclusion in rk3288.dtsi
      ARM: dts: rockchip: Remove skeleton.dtsi inclusion in rk3xxx.dtsi
      ARM: dts: rockchip: Add missing unit name to memory nodes in rk3036 boards
      ARM: dts: rockchip: Add missing unit name to memory nodes in rk322x boards
      ARM: dts: rockchip: Add missing unit name to memory nodes in rk3288 boards
      ARM: dts: rockchip: Add missing unit name to memory nodes in rk3xxx boards

Pawe? Jarosz (5):
      clk: rockchip: Add binding ids for cpu and peri clocks on rk3066
      ARM: dts: rockchip: initialize rk3066 PLL clock rate
      devicetree: Add vendor prefix for Rikomagic
      ARM: dts: rockchip: Add rk3066 MK808 board
      ARM: dts: rockchip: Set sdmmc frequency at boot time for rk3066a

Shawn Lin (3):
      ARM: dts: rockchip: remove always-on and boot-on from vcc_sd for px3-evb
      ARM: dts: rockchip: Support UHS mode for SD card on PopMetal-RK3288 board
      ARM: dts: rockchip: enable HS200/DDR52 mode for emmc on rk3288-popmetal

 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/rk3036-evb.dts                   |   2 +-
 arch/arm/boot/dts/rk3036-kylin.dts                 |   2 +-
 arch/arm/boot/dts/rk3036.dtsi                      |  10 +-
 arch/arm/boot/dts/rk3066a-bqcurie2.dts             |   2 +-
 arch/arm/boot/dts/rk3066a-marsboard.dts            |   2 +-
 arch/arm/boot/dts/rk3066a-mk808.dts                | 195 ++++++++++++
 arch/arm/boot/dts/rk3066a-rayeager.dts             |   2 +-
 arch/arm/boot/dts/rk3066a.dtsi                     |  12 +-
 arch/arm/boot/dts/rk3188-px3-evb.dts               | 328 +++++++++++++++++++++
 arch/arm/boot/dts/rk3188-radxarock.dts             |   2 +-
 arch/arm/boot/dts/rk3188.dtsi                      |   2 +-
 arch/arm/boot/dts/rk3228-evb.dts                   |   2 +-
 arch/arm/boot/dts/rk3229-evb.dts                   |   2 +-
 arch/arm/boot/dts/rk322x.dtsi                      |   6 +-
 arch/arm/boot/dts/rk3288-evb.dtsi                  |   2 +-
 arch/arm/boot/dts/rk3288-fennec.dts                |   2 +-
 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi  |   2 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi              |   2 +-
 arch/arm/boot/dts/rk3288-miqi.dts                  |   2 +-
 arch/arm/boot/dts/rk3288-popmetal.dts              |  34 ++-
 arch/arm/boot/dts/rk3288-r89.dts                   |   2 +-
 arch/arm/boot/dts/rk3288-rock2-som.dtsi            |   2 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi               |   2 +-
 arch/arm/boot/dts/rk3288.dtsi                      |  14 +-
 arch/arm/boot/dts/rk3xxx.dtsi                      |   4 +-
 include/dt-bindings/clock/rk3188-cru-common.h      |   8 +-
 include/dt-bindings/pinctrl/rockchip.h             |  33 +++
 30 files changed, 639 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3066a-mk808.dts
 create mode 100644 arch/arm/boot/dts/rk3188-px3-evb.dts
