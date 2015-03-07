From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sat,  7 Mar 2015 07:23:28 +0100
Subject: [PATCH v4 0/4] net/macb: merge at91_ether driver into macb driver
Message-ID: <1425709412-4935-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The rm9200 boards use the dedicated at91_ether driver instead of the
regular macb driver.

Both the macb and at91_ether drivers can be compiled as separated
modules.
Since the at91_ether driver uses code from the macb driver, at91_ether.ko
depends on macb.ko.

However the macb.ko module always fails to load on rm9200 boards: the
macb_probe() function expects a hclk clock which doesn't exist on rm9200.
Then the at91_ether.ko can't be loaded in turn due to unresolved
dependencies.

This series of patches fix this issue by merging at91_ether into macb.

Patch 1 is fixing a problem that might happen when enabling ARM
multi-platform suppot.

Best Regards,

Boris

Changes since v3:
- move "net: macb: remove #if defined(CONFIG_ARCH_AT91) sections" patch
  into this series to avoid dependency on other patch series.

Changes since v2:
- rebase after changed brought by commit "net: macb: remove #if
  defined(CONFIG_ARCH_AT91) sections"

Changes since v1:
- rework probe functions to share common probing logic


Boris Brezillon (2):
  ARM: at91/dt: fix macb compatible strings
  net: macb: remove #if defined(CONFIG_ARCH_AT91) sections

Cyrille Pitchen (2):
  net/macb: unify clock management
  net/macb: merge at91_ether driver into macb driver

 arch/arm/boot/dts/at91sam9260.dtsi        |   2 +-
 arch/arm/boot/dts/at91sam9263.dtsi        |   2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi        |   2 +-
 arch/arm/boot/dts/at91sam9x5_macb0.dtsi   |   2 +-
 arch/arm/boot/dts/at91sam9x5_macb1.dtsi   |   2 +-
 arch/arm/boot/dts/sama5d3_emac.dtsi       |   2 +-
 drivers/net/ethernet/cadence/Kconfig      |   8 -
 drivers/net/ethernet/cadence/Makefile     |   1 -
 drivers/net/ethernet/cadence/at91_ether.c | 481 ----------------------
 drivers/net/ethernet/cadence/macb.c       | 662 ++++++++++++++++++++++--------
 drivers/net/ethernet/cadence/macb.h       |  12 +-
 11 files changed, 503 insertions(+), 673 deletions(-)
 delete mode 100644 drivers/net/ethernet/cadence/at91_ether.c

-- 
1.9.1
