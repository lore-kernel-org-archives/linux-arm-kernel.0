From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Thu, 21 Dec 2017 20:12:54 +0900
Subject: [PATCH net-next v7 0/2] add UniPhier AVE ethernet support
Message-ID: <1513854776-4149-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for Socionext AVE ethernet controller implemented
on UniPhier SoCs. This driver supports RGMII/RMII modes.

v6: https://www.spinics.net/lists/netdev/msg472133.html

The PHY patch included in v1 has already separated in:
http://www.spinics.net/lists/netdev/msg454595.html

Changes since v6:
- sort the order of local variables from longest to shortest line
- fix ave_probe() which calls register_netdev() at the end of initialization
- dt-bindings: remove phy node descriptions in mdio node

Changes since v5:
- replace license boilerplate with SPDX Identifier
- remove inline directives and an unused function

Changes since v4:
- fix larger integer warning on AVE_PFMBYTE_MASK0

Changes since v3:
- remove checking dma address and use dma_set_mask() to restirct address
- replace ave_mdio_busywait() with read_poll_timeout()
- replace functions to access to registers with readl/writel() directly
- replace a function to access to macaddr with ave_hw_write_macaddr()
- change return value of ave_dma_map() to error value
- move mdiobus_unregister() from ave_remove() to ave_uninit()
- eliminate else block at the end of ave_dma_map()
- add mask definitions for packet filter
- sort bitmap definitions in descending order
- add error check to some functions
- rename and sort functions to clear sub-categories
- fix error value consistency
- remove unneeded initializers
- change type of constant arrays

Changes since v2:
- replace clk_get() with devm_clk_get()
- replace reset_control_get() with devm_reset_control_get_optional_shared()
- add error return when the error occurs on the above *_get functions
- sort soc data and compatible strings
- remove clearly obvious comments
- modify dt-bindings document consistent with these modifications

Changes since v1:
- add/remove devicetree properties and sub-node
  - remove "internal-phy-interrupt" and "desc-bits" property
  - add SoC data structures based on compatible strings
  - add node operation to apply "mdio" sub-node
- add support for features
  - add support for {get,set}_pauseparam and pause frame operations
  - add support for ndo_get_stats64 instead of ndo_get_stats
- replace with desiable functions
  - replace check for valid phy_mode with phy_interface{_mode}_is_rgmii()
  - replace phy attach message with phy_attached_info()
  - replace 32bit operation with {upper,lower}_32_bits() on ave_wdesc_addr()
  - replace nway_reset and get_link with generic functions
- move operations to proper functions
  - move phy_start_aneg() to ndo_open,
    and remove unnecessary PHY interrupt operations
    See http://www.spinics.net/lists/netdev/msg454590.html
  - move irq initialization and descriptor memory allocation to ndo_open
  - move initialization of reset and clock and mdiobus to ndo_init
- fix skbuffer operations
  - fix skb alignment operations and add Rx buffer adjustment for descriptor
    See http://www.spinics.net/lists/netdev/msg456014.html
  - add error returns when dma_map_single() failed 
- clean up code structures
  - clean up wait-loop and wake-queue conditions
  - add ave_wdesc_addr() and offset definitions
  - add ave_macaddr_init() to clean up mac-address operation
  - fix checking whether Tx entry is not enough
  - fix supported features of phydev
  - add necessary free/disable operations
  - add phydev check on ave_{get,set}_wol()
  - remove netif_carrier functions, phydev initializer, and Tx budget check
- change obsolate codes
  - replace ndev->{base_addr,irq} with the members of ave_private
- rename goto labels and mask definitions, and remove unused codes

Kunihiko Hayashi (2):
  dt-bindings: net: add DT bindings for Socionext UniPhier AVE
  net: ethernet: socionext: add AVE ethernet driver

 .../bindings/net/socionext,uniphier-ave4.txt       |   45 +
 drivers/net/ethernet/Kconfig                       |    1 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/socionext/Kconfig             |   22 +
 drivers/net/ethernet/socionext/Makefile            |    5 +
 drivers/net/ethernet/socionext/sni_ave.c           | 1736 ++++++++++++++++++++
 6 files changed, 1810 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
 create mode 100644 drivers/net/ethernet/socionext/Kconfig
 create mode 100644 drivers/net/ethernet/socionext/Makefile
 create mode 100644 drivers/net/ethernet/socionext/sni_ave.c

-- 
2.7.4
