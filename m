From: romain.perier@gmail.com (Romain Perier)
Date: Tue, 20 Jan 2015 07:09:36 +0000
Subject: [PATCH v2 0/4] net: stmmac: dwmac-rk: Fix phy regulator issues
Message-ID: <1421737780-1533-1-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes few issues in dwmac-rk:

1. Voltage settings was hardcoded into the driver for the phy regulator.
   The driver now uses the default voltage settings found in the devicetree,
   which are applied throught the regulator framework.
2. The regulator name used to power on or power off the phy was put in the devicetree
   variable "phy_regulator", which is not standard and added a lot of code for nothing.
   The driver now uses the devicetree property "phy-supply" and the corresponding functions
   to manipulate this regulator.

The corresponding devicetree files are also updated. As this new binding for
rk3288 has not been released with any official kernel yet (not until 3.20),
I don't need to care about keeping compatibility with the old non standard property.

Romain Perier (4):
  net: stmmac: dwmac-rk: Don't set the regulator voltage for phy from
    the driver
  ARM: dts: Add regulator voltage settings for vcc_phy in
    rk3288-evb.dtsi
  net: stmmac: dwmac-rk: Use standard devicetree property for phy
    regulator
  dt-bindings: Document phy-supply property in rockchip-dwmac

 .../devicetree/bindings/net/rockchip-dwmac.txt     |  1 +
 arch/arm/boot/dts/rk3288-evb-rk808.dts             |  2 +-
 arch/arm/boot/dts/rk3288-evb.dtsi                  |  2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     | 64 +++++++---------------
 4 files changed, 25 insertions(+), 44 deletions(-)

-- 
1.9.1
