From: jamesjj.liao@mediatek.com (James Liao)
Date: Thu, 14 Apr 2016 16:11:45 +0800
Subject: [PATCH v7 0/9] Add clock support for Mediatek MT2701 
Message-ID: <1460621514-65191-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is based on 4.6-rc1, add clock and reset controller support
for Mediatek MT2701.

This series also refined makefile and Kconfig to support configurable
multiple SoC clock support.

changes since v6:
- Rebase to v4.6-rc1.
- Register subsystem clocks in probe() instead of CLK_OF_DECLARE().
- Add clocks that referred by subsystem clocks.
- Fix clk_data size of apmixedsys.
- Add config options for each subsystem clock provider.

changes since v5:
- Rebase to v4.5-rc1 and [1].
- Enable critical clocks for MT2701
- Refine dt-binding documents, add reset controller support for hifsys.

changes since v4:
- Rebase to v4.5-rc1.
- Remove CLK_SET_RATE_PARENT from divider flags.
- Add img_jpgdec_smi clock.
- Move clk/mediatek/Kconfig into menu section in clk/Kconfig.

changes since v3:
- Change the parent of mm_mdp_bls_26m from clk26m to pwm_sel.

changes since v2:
- Fix ethsys definition.
- Replace read-modify-write with regmap_update_bits() in clock operations.
- Move mt2701-resets.h to include/dt-bindings/reset/.
- Add hifsys reset patch from John Crispin.

changes since v1:
- Document MT2701 compatible strings.

[1] https://patchwork.kernel.org/patch/8147901/

James Liao (5):
  clk: mediatek: Refine the makefile to support multiple clock drivers
  dt-bindings: ARM: Mediatek: Document bindings for MT2701
  clk: mediatek: Enable critical clocks for MT2701
  clk: mediatek: Add config options for MT2701 subsystem clocks
  arm: dts: mt2701: Add clock controller device nodes

Shunli Wang (4):
  clk: mediatek: Add dt-bindings for MT2701 clocks
  clk: mediatek: Add MT2701 clock support
  reset: mediatek: Add MT2701 reset controller dt-binding file
  reset: mediatek: Add MT2701 reset driver

 .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |    3 +-
 .../bindings/arm/mediatek/mediatek,bdpsys.txt      |   22 +
 .../bindings/arm/mediatek/mediatek,ethsys.txt      |   22 +
 .../bindings/arm/mediatek/mediatek,hifsys.txt      |   24 +
 .../bindings/arm/mediatek/mediatek,imgsys.txt      |    3 +-
 .../bindings/arm/mediatek/mediatek,infracfg.txt    |    3 +-
 .../bindings/arm/mediatek/mediatek,mmsys.txt       |    3 +-
 .../bindings/arm/mediatek/mediatek,pericfg.txt     |    3 +-
 .../bindings/arm/mediatek/mediatek,topckgen.txt    |    3 +-
 .../bindings/arm/mediatek/mediatek,vdecsys.txt     |    3 +-
 arch/arm/boot/dts/mt2701.dtsi                      |   42 +
 drivers/clk/Kconfig                                |    1 +
 drivers/clk/mediatek/Kconfig                       |   73 +
 drivers/clk/mediatek/Makefile                      |    7 +-
 drivers/clk/mediatek/clk-gate.c                    |   52 +
 drivers/clk/mediatek/clk-gate.h                    |    2 +
 drivers/clk/mediatek/clk-mt2701.c                  | 1417 ++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                     |   25 +
 drivers/clk/mediatek/clk-mtk.h                     |   34 +-
 include/dt-bindings/clock/mt2701-clk.h             |  486 +++++++
 include/dt-bindings/reset/mt2701-resets.h          |   83 ++
 21 files changed, 2298 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
 create mode 100644 drivers/clk/mediatek/Kconfig
 create mode 100644 drivers/clk/mediatek/clk-mt2701.c
 create mode 100644 include/dt-bindings/clock/mt2701-clk.h
 create mode 100644 include/dt-bindings/reset/mt2701-resets.h

--
1.9.1
