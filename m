From: isubramanian@apm.com (Iyappan Subramanian)
Date: Wed,  6 Jul 2016 17:35:01 -0700
Subject: [PATCH v4 00/11] drivers: net: xgene: Fix module crash and 1G hot-plug
Message-ID: <1467851712-24780-1-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset addresses the following issues,

1. Fixes the kernel crash when the driver loaded as an kernel module
	- by fixing hardware cleanups and rearrange kernel API calls

2. Hot-plug issue on the SGMII 1G interface
	- by adding a driver for MDIO management

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Tested-by: Fushen Chen <fchen@apm.com>
Tested-by: Toan Le <toanle@apm.com>
---

v4: Address review comments from v3
	- Reorganized into smaller patches
	- Added wrapper functions for sgmii_control_reset and sgmii_tbi_control_reset
	- Removed clk_get warning info
	- mdio: Changed the order of 'if' statements and removed the 'else' statement
	- mdio: Removed the mdio_read(write) indirection wrapper functions
	- ethtool: Fixed SGMII 1G get_settings and set_settings
	- Documentation: dtb: Added MDIO node information
	- MAINTAINERS: Added MDIO driver and documentation path

v3: Address review comments from v2
	- Add comment about hardware clock reset sequence on xgene_mdio_reset

v2: Address review comments from v1
	- Fixed patch 1 compilation error
	- Fixed mdio at 1f610000 xge0clk reference
	- Squashed dtb patches
	- Added PORT_OFFSET macro

v1:
	- Initial version
---

Iyappan Subramanian (11):
  drivers: net: xgene: Separate set_speed from mac_init
  drivers: net: xgene: Fix module unload crash - hw resource cleanup
  drivers: net: xgene: Fix module unload crash - change sw sequence
  drivers: net: xgene: Fix module unload crash - clkrst sequence
  drivers: net: phy: xgene: Add MDIO driver
  drivers: net: xgene: Add backward compatibility
  drivers: net: xgene: Enable MDIO driver
  drivers: net: xgene: ethtool: Use phy_ethtool_gset and sset
  dtb: xgene: Add MDIO node
  Documentation: dtb: xgene: Add MDIO node
  MAINTAINERS: xgene: Add driver and documentation path

 .../devicetree/bindings/net/apm-xgene-mdio.txt     |  37 ++
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/apm/apm-mustang.dts            |  12 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |  36 +-
 drivers/net/ethernet/apm/xgene/Kconfig             |   1 +
 .../net/ethernet/apm/xgene/xgene_enet_ethtool.c    |  22 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c     | 149 +++++--
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h     |  11 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c   | 220 ++++++----
 drivers/net/ethernet/apm/xgene/xgene_enet_main.h   |  33 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_sgmac.c  | 228 ++++++++--
 drivers/net/ethernet/apm/xgene/xgene_enet_sgmac.h  |   8 +
 drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c  |  57 ++-
 drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.h  |   3 +
 drivers/net/phy/Kconfig                            |   6 +
 drivers/net/phy/Makefile                           |   1 +
 drivers/net/phy/mdio-xgene.c                       | 477 +++++++++++++++++++++
 drivers/net/phy/mdio-xgene.h                       | 140 ++++++
 18 files changed, 1242 insertions(+), 201 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/apm-xgene-mdio.txt
 create mode 100644 drivers/net/phy/mdio-xgene.c
 create mode 100644 drivers/net/phy/mdio-xgene.h

-- 
1.9.1
