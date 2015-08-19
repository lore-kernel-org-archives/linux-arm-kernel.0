From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 19 Aug 2015 09:48:48 -0500
Subject: [PATCH v3 0/14] Add Analogix Core Display Port Driver
Message-ID: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi all,
   The Samsung Exynos eDP controller and Rockchip RK3288 eDP controller
share the same IP, so a lot of parts can be re-used. I split the common
code into bridge directory, then rk3288 and exynos only need to keep
some platform code. Cause I can't find the exact IP name of exynos dp
controller, so I decide to name dp core driver with "analogix" which I
find in rk3288 eDP TRM ;)

Beyond that, there are three light registers setting differents bewteen
exynos and rk3288.
1. RK3288 have five special pll resigters which not indicata in exynos
   dp controller.
2. The address of DP_PHY_PD(dp phy power manager register) are different
   between rk3288 and exynos.
3. Rk3288 and exynos have different setting with AUX_HW_RETRY_CTL(dp debug
   register).

I have verified this series on two kinds of rockchip platform board, one
is rk3288 sdk board which connect with a 2K display port monitor, the other
is google jerry chromebook which connect with a eDP screen "cnm,n116bgeea2",
both of them works rightlly.

I haven't verified the dp function on samsung platform, cause I haven't got
exynos boards. I can only ensure that there are no build error on samsung
platform, wish some samsung guys help to test. ;)

Thanks,
- Yakir

Changes in v3:
- Take Thierry Reding suggest, move exynos's video_timing code
  to analogix_dp-exynos platform driver, add get_modes method
  to struct analogix_dp_plat_data.
- Take Heiko suggest, rename some "samsung*" dts propery to "analogix*".
- Take Thierry Reding suggest, dynamic parse video timing info from
  struct drm_display_mode and struct drm_display_info.
- Take Thierry Reding suggest, link_rate and lane_count shouldn't config to
  the DT property value directly, but we can take those as hardware limite.
  For example, RK3288 only support 4 physical lanes of 2.7/1.62 Gbps/lane,
  so DT property would like "link-rate = 0x0a" "lane-count = 4".
- Take Heiko suggest, add devicetree binding documents.
- Take Thierry Reding suggest, remove sync pol & colorimetry properies
  from the new analogix dp driver devicetree binding.
- Update the exist exynos dtsi file with the latest DP DT properies.
- Take Thierry Reding and Heiko suggest, leave "sclk_edp_24m" to rockchip
  dp phy driver which name to "24m", and leave "sclk_edp" to analogix dp
  core driver which name to "dp", and leave "pclk_edp" to rockchip dp platform
  driver which name to "pclk".
- Take Heiko suggest, add devicetree binding document.
- Take Heiko suggest, remove "rockchip,panel" DT property, take use of remote
  point to get panel node.
- Add the new function point analogix_dp_platdata.get_modes init.
- Take Heiko suggest, add rockchip dp phy driver,
  collect the phy clocks and power control.
- Add "analogix,need-force-hpd" to indicate whether driver need foce
  hpd when hpd detect failed.
- move dp hpd detect to connector detect function.
- Add edid modes parse support

Changes in v2:
- Take Joe Preches advise, improved commit message more readable, and
  avoid using some uncommon style like bellow:
  -  retval = exynos_dp_read_bytes_from_i2c(...
				...)
  +  retval =
  +  exynos_dp_read_bytes_from_i2c(......);
- Take Jingoo Han suggest, just remove my name from author list.
- Take Jingoo Han suggest, remove new copyright
- Fix compiled failed dut to analogix_dp_device misspell
- Take Heiko suggest, get panel node with remote-endpoint method,
  and create devicetree binding for driver.
- Remove the clock enable/disbale with "sclk_edp" & "sclk_edp_24m",
  leave those clock to rockchip dp phy driver.
- Add GNU license v2 declared and samsung copyright
- Fix compile failed dut to phy_pd_addr variable misspell error

Yakir Yang (14):
  drm: exynos/dp: fix code style
  drm: exynos/dp: convert to drm bridge mode
  drm: bridge: analogix_dp: split exynos dp driver to bridge dir
  drm: bridge/analogix_dp: dynamic parse sync_pol & interlace &
    colorimetry
  drm: bridge/analogix_dp: fix link_rate & lane_count bug
  Documentation: drm/bridge: add document for analogix_dp
  drm: rockchip/dp: add rockchip platform dp driver
  phy: Add driver for rockchip Display Port PHY
  drm: bridge/analogix_dp: add platform device type support
  drm: bridge: analogix_dp: add some rk3288 special registers setting
  drm: bridge: analogix_dp: try force hpd after plug in lookup failed
  drm: bridge/analogix_dp: expand the delay time for hpd detect
  drm: bridge/analogix_dp: move hpd detect to connector detect function
  drm: bridge/analogix_dp: add edid modes parse in get_modes method

 .../devicetree/bindings/drm/bridge/analogix_dp.txt |   73 +
 .../devicetree/bindings/phy/rockchip-dp-phy.txt    |   26 +
 .../bindings/video/analogix_dp-rockchip.txt        |   83 ++
 .../devicetree/bindings/video/exynos_dp.txt        |   51 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           |   10 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   10 +-
 arch/arm/boot/dts/exynos5250-snow.dts              |   12 +-
 arch/arm/boot/dts/exynos5250-spring.dts            |   12 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   12 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   10 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |   12 +-
 drivers/gpu/drm/bridge/Kconfig                     |    5 +
 drivers/gpu/drm/bridge/Makefile                    |    1 +
 drivers/gpu/drm/bridge/analogix_dp_core.c          | 1382 +++++++++++++++++++
 drivers/gpu/drm/bridge/analogix_dp_core.h          |  286 ++++
 drivers/gpu/drm/bridge/analogix_dp_reg.c           | 1294 ++++++++++++++++++
 .../exynos_dp_reg.h => bridge/analogix_dp_reg.h}   |  270 ++--
 drivers/gpu/drm/exynos/Kconfig                     |    5 +-
 drivers/gpu/drm/exynos/Makefile                    |    2 +-
 drivers/gpu/drm/exynos/analogix_dp-exynos.c        |  347 +++++
 drivers/gpu/drm/exynos/exynos_dp_core.c            | 1416 --------------------
 drivers/gpu/drm/exynos/exynos_dp_core.h            |  282 ----
 drivers/gpu/drm/exynos/exynos_dp_reg.c             | 1263 -----------------
 drivers/gpu/drm/rockchip/Kconfig                   |    9 +
 drivers/gpu/drm/rockchip/Makefile                  |    1 +
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |  390 ++++++
 drivers/phy/Kconfig                                |    7 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-rockchip-dp.c                      |  185 +++
 include/drm/bridge/analogix_dp.h                   |   40 +
 30 files changed, 4325 insertions(+), 3172 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
 create mode 100644 Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt
 create mode 100644 drivers/gpu/drm/bridge/analogix_dp_core.c
 create mode 100644 drivers/gpu/drm/bridge/analogix_dp_core.h
 create mode 100644 drivers/gpu/drm/bridge/analogix_dp_reg.c
 rename drivers/gpu/drm/{exynos/exynos_dp_reg.h => bridge/analogix_dp_reg.h} (62%)
 create mode 100644 drivers/gpu/drm/exynos/analogix_dp-exynos.c
 delete mode 100644 drivers/gpu/drm/exynos/exynos_dp_core.c
 delete mode 100644 drivers/gpu/drm/exynos/exynos_dp_core.h
 delete mode 100644 drivers/gpu/drm/exynos/exynos_dp_reg.c
 create mode 100644 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
 create mode 100644 drivers/phy/phy-rockchip-dp.c
 create mode 100644 include/drm/bridge/analogix_dp.h

-- 
1.9.1
