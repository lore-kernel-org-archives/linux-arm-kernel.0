From: erin.lo@mediatek.com (Erin Lo)
Date: Tue, 16 Aug 2016 15:30:20 +0800
Subject: [PATCH v10 0/9] Add clock support for Mediatek MT2701
Message-ID: <1471332629-15722-1-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is based on v4.8-rc1, add clock and reset controller support
for Mediatek MT2701.

This series also refined makefile and Kconfig to support configurable
multiple SoC clock support.

changes since v9:
- Rebase to v4.8-rc1.
- Drop a fix patch of parent clock initial state. It will be replaced by a new
  patch from Mike/Stephen.
- Replace clk.h with clk-provider.h.
- Correct register settings of clocks.

changes since v8:
- Rebase to v4.7-rc1.
- Include mt2701-resets.h in mt2701.dtsi.
- Remove an unused property from apmixedsys DT node.

changes since v7:
- Rebase to clk-next.
- Implement subsystem clocks in seperated files.
- Replace critical clock enabling with CLK_IS_CRITICAL flag.
- Reduce most clock registrations in CLK_OF_DECLARE().
- Remove __init and __initconst from most init fucntions and data,
  and replace driver registration with platform_driver_register().
- Replace some common function or variable names with unique names.
- Use real clock for UARTs.

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

Erin Lo (1):
  arm: dts: mt2701: Use real clock for UARTs

James Liao (4):
  clk: mediatek: remove __init from clk registration functions
  clk: mediatek: Refine the makefile to support multiple clock drivers
  dt-bindings: ARM: Mediatek: Document bindings for MT2701
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
 arch/arm/boot/dts/mt2701.dtsi                      |   50 +-
 drivers/clk/Kconfig                                |    1 +
 drivers/clk/mediatek/Kconfig                       |   73 ++
 drivers/clk/mediatek/Makefile                      |   13 +-
 drivers/clk/mediatek/clk-gate.c                    |   54 +-
 drivers/clk/mediatek/clk-gate.h                    |    2 +
 drivers/clk/mediatek/clk-mt2701-bdp.c              |  140 +++
 drivers/clk/mediatek/clk-mt2701-eth.c              |   82 ++
 drivers/clk/mediatek/clk-mt2701-hif.c              |   81 ++
 drivers/clk/mediatek/clk-mt2701-img.c              |   82 ++
 drivers/clk/mediatek/clk-mt2701-mm.c               |  125 +++
 drivers/clk/mediatek/clk-mt2701-vdec.c             |   93 ++
 drivers/clk/mediatek/clk-mt2701.c                  | 1037 ++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                     |   52 +-
 drivers/clk/mediatek/clk-mtk.h                     |   41 +-
 drivers/clk/mediatek/clk-pll.c                     |    3 +-
 include/dt-bindings/clock/mt2701-clk.h             |  486 +++++++++
 include/dt-bindings/reset/mt2701-resets.h          |   83 ++
 28 files changed, 2559 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
 create mode 100644 drivers/clk/mediatek/Kconfig
 create mode 100644 drivers/clk/mediatek/clk-mt2701-bdp.c
 create mode 100644 drivers/clk/mediatek/clk-mt2701-eth.c
 create mode 100644 drivers/clk/mediatek/clk-mt2701-hif.c
 create mode 100644 drivers/clk/mediatek/clk-mt2701-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt2701-mm.c
 create mode 100644 drivers/clk/mediatek/clk-mt2701-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt2701.c
 create mode 100644 include/dt-bindings/clock/mt2701-clk.h
 create mode 100644 include/dt-bindings/reset/mt2701-resets.h

--
1.9.1
