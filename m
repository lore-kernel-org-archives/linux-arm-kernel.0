From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Thu,  8 Oct 2015 15:31:11 +0200
Subject: [PATCH v4 0/8] Add SPDIF support for rockchip
Message-ID: <1444311079-2892-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the Rockchip SPDIF transceiver as present
on RK3066, RK3188 and RK3288 boards and enables it on a Radxa rock pro.
Tested on a Radxa Rock Pro board and Radxa Rock 2 Square board.

Quite a few changes since v3 (mostly based on review comment). One
important addition is proper RK3288 SoC support; While according to the
documentation it has 2 SPDIF "solutions" with the default being the old
one, this variation doesn't actually work.. So support has been added
to switch to the new SPDIF solution on RK3288.

Changes in v4:
- Require rockchip,grf on RK3288 as the 8 channel solution has to be
  selected on that SoC
- Make the compatibility string one of a known list rather then
  requiring a precise list of options.
- Change the clock names to hclk and mclk instead of spdif_hclk and
  spdif_mclk to better match the implementation and data sheets.
- Use hclk and mclk as the clock names matching the update devicetree
  documentation
- Drop something useless to_info function
- Open-code tx control in rk_spdif_trigge
- Use devm_regmap_init_mmio_clk to allow the regmap subsystem to manage
  the hclk as needed
- Use a more conventionale pm setup (turn everything on,
  mark the device as active, enable pm and request the device to go
  idle)
- re-add the platfrorm:rockchip-spdif module alias
- Also manage the hclk in the PM callbacks
- Check the return code of clk_set_rate
- Switch to the 8 channel spdif solutions on RK3288
- Add support for 192khz audio rate
- Adjust clock names to match the new names (hclk/mclk)

Changes in v3:
- Fix typos in commit message
- Resent patches to a more complete list of maintainers.

Changes in v2:
- Remove platform: module alias as it was unused
- Call MODULE_DEVICE_TABLE(of, ) right after the of match table
- use rk_spdif as a prefix consistenly throughout the driver
- Check return code of regmap_update and bubble it up
- Sort the spdif node properties
- Drop the 0x prefix from the node name
- Rename the spdif@ node to sound@

Sjoerd Simons (8):
  ASoC: dt-bindings: add rockchip tranceiver bindings
  ASoC: rockchip: Add rockchip SPDIF transceiver driver
  ARM: dts: rockchip: Add SPDIF transceiver for RK3188
  ARM: dts: rockchip: Add SPDIF optical out on Radxa Rock
  clk: rockchip: Allow the RK3288 SPDIF clocks to change their parent
  ARM: dts: rockchip: Add SPDIF transceiver for RK3288
  ARM: dts: rockchip: Add SPDIF optical out on Radxa Rock2 Square
  ARM: multi_v7_defconfig: Add rockchip audio support

 .../devicetree/bindings/sound/rockchip-spdif.txt   |  44 +++
 arch/arm/boot/dts/rk3188-radxarock.dts             |  19 +
 arch/arm/boot/dts/rk3188.dtsi                      |  22 ++
 arch/arm/boot/dts/rk3288-rock2-square.dts          |  18 +
 arch/arm/boot/dts/rk3288.dtsi                      |  23 ++
 arch/arm/configs/multi_v7_defconfig                |   5 +
 drivers/clk/rockchip/clk-rk3288.c                  |  16 +-
 sound/soc/rockchip/Kconfig                         |   8 +
 sound/soc/rockchip/Makefile                        |   2 +
 sound/soc/rockchip/rockchip_spdif.c                | 409 +++++++++++++++++++++
 sound/soc/rockchip/rockchip_spdif.h                |  63 ++++
 11 files changed, 621 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-spdif.txt
 create mode 100644 sound/soc/rockchip/rockchip_spdif.c
 create mode 100644 sound/soc/rockchip/rockchip_spdif.h

-- 
2.6.1
