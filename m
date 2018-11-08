From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 7 Nov 2018 18:36:12 -0600
Subject: [PATCH 0/5] hy: core: rework phy_set_mode to accept phy mode and
 submode
Message-ID: <20181108003617.10334-1-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon, All,

As was discussed in [1] I'm posting series which introduces rework of
phy_set_mode to accept phy mode and submode. I've dropped TI specific patches as
this change is pretty big by itself.

Patch 1 is cumulative change which refactors PHY framework code to
support dual level PHYs mode configuration - PHY mode and PHY submode. It
extends .set_mode() callback to support additional parameter "int submode"
and converts all corresponding PHY drivers to support new .set_mode()
callback declaration.
The new extended PHY API
 int phy_set_mode_ext(struct phy *phy, enum phy_mode mode, int submode)
is introduced to support dual level PHYs mode configuration and existing
phy_set_mode() API is converted to macros, so PHY framework consumers do
not need to be changed (~21 matches).

Patches 2-4: Add new PHY's mode to be used by Ethernet PHY interface drivers or
multipurpose PHYs like serdes and convert ocelot-serdes and mvebu-cp110-comphy
PHY drivers to use recently introduced PHY_MODE_ETHERNET and phy_set_mode_ext().

Patch 5 - removes unused, ethernet specific phy modes from enum phy_mode.

[1] https://lkml.org/lkml/2018/10/25/366

Grygorii Strashko (5):
  phy: core: rework phy_set_mode to accept phy mode and submode
  phy: core: add PHY_MODE_ETHERNET
  phy: ocelot-serdes: convert to use eth phy mode and submode
  phy: mvebu-cp110-comphy: convert to use eth phy mode and submode
  phy: core: clean up unused ethernet specific phy modes

 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 21 ++-----
 drivers/net/ethernet/mscc/ocelot.c              |  9 +--
 drivers/phy/allwinner/phy-sun4i-usb.c           |  3 +-
 drivers/phy/amlogic/phy-meson-gxl-usb2.c        |  5 +-
 drivers/phy/amlogic/phy-meson-gxl-usb3.c        |  5 +-
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c    | 83 ++++++++++++++-----------
 drivers/phy/mediatek/phy-mtk-tphy.c             |  2 +-
 drivers/phy/mediatek/phy-mtk-xsphy.c            |  2 +-
 drivers/phy/mscc/phy-ocelot-serdes.c            | 16 +++--
 drivers/phy/phy-core.c                          |  6 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c             |  3 +-
 drivers/phy/qualcomm/phy-qcom-qusb2.c           |  3 +-
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c    |  3 +-
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c    |  3 +-
 drivers/phy/qualcomm/phy-qcom-usb-hs.c          |  3 +-
 drivers/phy/ti/phy-da8xx-usb.c                  |  3 +-
 drivers/phy/ti/phy-tusb1210.c                   |  2 +-
 include/linux/phy/phy.h                         | 18 +++---
 18 files changed, 100 insertions(+), 90 deletions(-)

-- 
2.10.5
