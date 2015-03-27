From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Mar 2015 10:20:20 +0100
Subject: [PATCH v9]: clk: Add common clock support for Mediatek MT8135
 and MT8173
In-Reply-To: <1427447925-18030-1-git-send-email-s.hauer@pengutronix.de>
References: <1427447925-18030-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150327092020.GV9742@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 10:18:39AM +0100, Sascha Hauer wrote:
> This patchset contains the initial common clock support for Mediatek SoCs.
> Mediatek SoC's clock architecture comprises of various PLLs, dividers, muxes
> and clock gates.

Can be pulled here:

The following changes since commit 9eccca0843205f87c00404b663188b88eb248051:

  Linux 4.0-rc3 (2015-03-08 16:09:09 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/v4.0-clk-mediatek-v9

for you to fetch changes up to 8b1aaacc33fba5561c41f9aca054bf2335761775:

  dt-bindings: ARM: Mediatek: Document devicetree bindings for clock/reset controllers (2015-03-27 10:08:59 +0100)

----------------------------------------------------------------
This patchset contains the initial common clock support for Mediatek SoCs.
Mediatek SoC's clock architecture comprises of various PLLs, dividers, muxes
and clock gates.

Changes in v9:
- rename 'lock' to 'mt81xx_clk_lock' to get better lockdep output

Changes in v8:
- add patch to allow to put parent_name arrays in __initconst
- put parent_name arrays into __initconst

Changes in v7:
- fix duplicate definition/declaration of mtk_register_reset_controller
- fix pd_reg offset of tvdpll
- make clk initialization arrays const

Changes in v6:
- rework PLL support, only a fraction of original size now
- Move binding docs to Documentation/devicetree/bindings/arm/mediatek since
  the units are not really clock specific (they contain reset controllers)

Changes in v5:
- Add reset controller support for pericfg/infracfg
- Use regmap for the gates
- remove now unnecessary spinlock for the gates
- Add PMIC wrapper support as of v3

Changes in v4:
- Support MT8173 platform.
- Re-ordered patchset. driver/clk/Makefile in 2nd patch.
- Extract the common part definition(mtk_gate/mtk_pll/mtk_mux) from
  clk-mt8135.c/clk-mt8173.c to clk-mtk.c.
- Refine code. Rmove unnessacary debug information and unsed defines,
  add prefix "mtk_" for static functions.
- Remove flag CLK_IGNORE_UNUSED and set flag CLK_SET_RATE_PARENT on
  gate/mux/fixed-factor.
- Use spin_lock_irqsave(&clk_ops_lock, flags) instead of mtk_clk_lock.
- Example above include a node for the clock controller itself, followed
  by the i2c controller example above.

Changes in v3:
- Rebase to 3.19-rc1.
- Refine code. Remove unneed functions, debug logs and comments, and fine tune
  error logs.

Changes in v2:
- Re-ordered patchset. Fold include/dt-bindings and DT document in 1st patch.

----------------------------------------------------------------
James Liao (3):
      clk: mediatek: Add initial common clock support for Mediatek SoCs.
      clk: mediatek: Add basic clocks for Mediatek MT8135.
      clk: mediatek: Add basic clocks for Mediatek MT8173.

Sascha Hauer (3):
      clk: make strings in parent name arrays const
      clk: mediatek: Add reset controller support
      dt-bindings: ARM: Mediatek: Document devicetree bindings for clock/reset controllers

 .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |  23 +
 .../bindings/arm/mediatek/mediatek,infracfg.txt    |  30 +
 .../bindings/arm/mediatek/mediatek,pericfg.txt     |  30 +
 .../bindings/arm/mediatek/mediatek,topckgen.txt    |  23 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-composite.c                        |   2 +-
 drivers/clk/clk-mux.c                              |   4 +-
 drivers/clk/mediatek/Makefile                      |   4 +
 drivers/clk/mediatek/clk-gate.c                    | 137 ++++
 drivers/clk/mediatek/clk-gate.h                    |  49 ++
 drivers/clk/mediatek/clk-mt8135.c                  | 640 ++++++++++++++++
 drivers/clk/mediatek/clk-mt8173.c                  | 826 +++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                     | 197 +++++
 drivers/clk/mediatek/clk-mtk.h                     | 165 ++++
 drivers/clk/mediatek/clk-pll.c                     | 325 ++++++++
 drivers/clk/mediatek/reset.c                       |  99 +++
 include/dt-bindings/clock/mt8135-clk.h             | 190 +++++
 include/dt-bindings/clock/mt8173-clk.h             | 231 ++++++
 .../dt-bindings/reset-controller/mt8135-resets.h   |  64 ++
 .../dt-bindings/reset-controller/mt8173-resets.h   |  63 ++
 include/linux/clk-provider.h                       |   8 +-
 21 files changed, 3104 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
 create mode 100644 drivers/clk/mediatek/Makefile
 create mode 100644 drivers/clk/mediatek/clk-gate.c
 create mode 100644 drivers/clk/mediatek/clk-gate.h
 create mode 100644 drivers/clk/mediatek/clk-mt8135.c
 create mode 100644 drivers/clk/mediatek/clk-mt8173.c
 create mode 100644 drivers/clk/mediatek/clk-mtk.c
 create mode 100644 drivers/clk/mediatek/clk-mtk.h
 create mode 100644 drivers/clk/mediatek/clk-pll.c
 create mode 100644 drivers/clk/mediatek/reset.c
 create mode 100644 include/dt-bindings/clock/mt8135-clk.h
 create mode 100644 include/dt-bindings/clock/mt8173-clk.h
 create mode 100644 include/dt-bindings/reset-controller/mt8135-resets.h
 create mode 100644 include/dt-bindings/reset-controller/mt8173-resets.h

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
