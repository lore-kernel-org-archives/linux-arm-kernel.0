From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 06 Aug 2017 11:50:24 +0200
Subject: [GIT PULL 3/4] Rockchip dts32 changes for 4.14
In-Reply-To: <12145142.47nS8LyXIe@phil>
References: <12145142.47nS8LyXIe@phil>
Message-ID: <3167861.YfTzp5M1RE@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.14-rockchip-dts32-1

for you to fetch changes up to 0f4dc7e154d054303c4dd6b5c3e3207f9a7f8714:

  ARM: dts: rockchip: fix property-ordering in rv1108 mmc nodes (2017-07-22 22:41:35 +0200)

----------------------------------------------------------------
Removal of the deprectated num-slots property from all Rockchip dw-mmc
nodes. The rv1108 gains support for sd-cards on the evaluation board and
the general nodes get a bit of cosmetic. On rk3288 the evb gains support
saradc and the adc-key connected to it while some more boards also get
their mali gpu enabled (fennec, evb, tinker).

The biggest set of changes can be found on the rk3228/rk3229 combo this
time. It gets core support for efuse, sdmmc, sdio, io-domans and spdif
as well as a separate rk3229.dtsi that will keep the slight differences
between the two brothers rk3228/rk3229. The evaluation board also gets
some attention and abled nodes (regulators, io-domains, emmc, tsadc keys)

But I think the most interesting change is the cpu enable-method for it.
Instead of using the older in-kernel method, we're now also moving to
handling this in firmware via the psci interface on 32bit Rockchip socs.
In a recently merged pull request [0] support for the rk3228/rk3229 was
added to OP-TEE including the psci support and it seems supporting other
32bit Rockchip socs that way is also planned for the future.

[0] https://github.com/OP-TEE/optee_os/pull/1666

----------------------------------------------------------------
Andy Yan (1):
      ARM: dts: rockchip: enable sdmmc for rv1108 evb

David Wu (2):
      ARM: dts: rockchip: Add io-domain node for rk3228
      ARM: dts: rockchip: enable io-domain for rk3229-evb

Finley Xiao (2):
      ARM: dts: rockchip: add cpu-supply property for cpu node of rk3229-evb
      ARM: dts: rockchip: add efuse device node for rk3228

Frank Wang (6):
      ARM: dts: rockchip: add basic dtsi file for RK3229 SoC
      ARM: dts: rockchip: add cpu enable method for rk3228 SoC
      ARM: dts: rockchip: add regulator nodes for rk3229-evb
      ARM: dts: rockchip: enable eMMC for rk3229-evb
      ARM: dts: rockchip: enable tsadc for rk3229-evb
      ARM: dts: rockchip: add gpio power-key for rk3229-evb

Heiko Stuebner (1):
      ARM: dts: rockchip: fix property-ordering in rv1108 mmc nodes

Jacob Chen (5):
      ARM: dts: rockchip: enable ARM Mali GPU on rk3288-tinker
      ARM: dts: rockchip: enable ARM Mali GPU on rk3288-evb
      ARM: dts: rockchip: enable ARM Mali GPU on rk3288-fennec
      ARM: dts: rockchip: enable saradc for rk3288-evb
      ARM: dts: rockchip: enable adc key for rk3288-evb

Jaehoon Chung (1):
      ARM: dts: rockchip: change to "max-frequency" from "clock-freq-min-max" on rv1108

Klaus Goger (1):
      ARM: dts: rockchip: fix typo in rk3036 mmc pinctrl

Shawn Lin (3):
      ARM: dts: rockchip: remove num-slots from all platforms
      ARM: dts: rockchip: fix compatible string for eMMC node of rk3228 SoC
      ARM: dts: rockchip: add sdmmc and sdio nodes for rk3228 SoC

Sugar Zhang (1):
      ARM: dts: rockchip: add rk322x spdif node

 arch/arm/boot/dts/rk3036-kylin.dts                |   2 -
 arch/arm/boot/dts/rk3036.dtsi                     |   3 +-
 arch/arm/boot/dts/rk3066a-bqcurie2.dts            |   2 -
 arch/arm/boot/dts/rk3066a-mk808.dts               |   2 -
 arch/arm/boot/dts/rk3066a-rayeager.dts            |   3 -
 arch/arm/boot/dts/rk3188-px3-evb.dts              |   2 -
 arch/arm/boot/dts/rk3188-radxarock.dts            |   1 -
 arch/arm/boot/dts/rk3229-evb.dts                  | 129 +++++++++++++++++++++-
 arch/arm/boot/dts/rk3229.dtsi                     |  89 +++++++++++++++
 arch/arm/boot/dts/rk322x.dtsi                     | 113 ++++++++++++++++++-
 arch/arm/boot/dts/rk3288-evb.dtsi                 |  49 +++++++-
 arch/arm/boot/dts/rk3288-fennec.dts               |   6 +-
 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi |   1 -
 arch/arm/boot/dts/rk3288-firefly-reload.dts       |   2 -
 arch/arm/boot/dts/rk3288-firefly.dtsi             |   3 -
 arch/arm/boot/dts/rk3288-miqi.dts                 |   2 -
 arch/arm/boot/dts/rk3288-phycore-rdk.dts          |   1 -
 arch/arm/boot/dts/rk3288-phycore-som.dtsi         |   1 -
 arch/arm/boot/dts/rk3288-popmetal.dts             |   2 -
 arch/arm/boot/dts/rk3288-r89.dts                  |   1 -
 arch/arm/boot/dts/rk3288-rock2-som.dtsi           |   1 -
 arch/arm/boot/dts/rk3288-rock2-square.dts         |   2 -
 arch/arm/boot/dts/rk3288-tinker.dts               |   6 +-
 arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi        |   1 -
 arch/arm/boot/dts/rk3288-veyron.dtsi              |   2 -
 arch/arm/boot/dts/rv1108-evb.dts                  |   4 +
 arch/arm/boot/dts/rv1108.dtsi                     |  20 ++--
 27 files changed, 401 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3229.dtsi
