From: jon.mason@broadcom.com (Jon Mason)
Date: Tue,  1 Nov 2016 16:04:35 -0400
Subject: [PATCH v4 0/7] add NS2 support to bgmac 
Message-ID: <1478030682-27012-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v4:
* Actually send out the lane swap binding doc patch (Per Scott Branden)
* Remove unused #define (Per Andrew Lunn)


Changes in v3:
* Clean-up the bgmac DT binding doc (per Rob Herring)
* Document the lane swap binding and make it generic (Per Andrew Lunn)


Changes in v2:
* Remove the PHY power-on (per Andrew Lunn)
* Misc PHY clean-ups regarding comments and #defines (per Andrew Lunn)
  This results on none of the original PHY code from Vikas being
  present.  So, I'm removing him as an author and giving him
  "Inspired-by" credit.
* Move PHY lane swapping to PHY driver (per Andrew Lunn and Florian
  Fainelli)
* Remove bgmac sleep (per Florian Fainelli)
* Re-add bgmac chip reset (per Florian Fainelli and Ray Jui)
* Rebased on latest net-next
* Added patch for bcm54xx_auxctl_read, which is used in the BCM54810


Add support for the amac found in the Broadcom Northstar2 SoC to the
bgmac driver.  This necessitates adding support to connect to an
externally defined phy (as described in the device tree) in the driver.
These phy changes are in addition to the changes necessary to get NS2
working.


Jon Mason (7):
  net: phy: broadcom: add bcm54xx_auxctl_read
  Documentation: devicetree: add PHY lane swap binding
  net: phy: broadcom: Add BCM54810 PHY entry
  Documentation: devicetree: net: add NS2 bindings to amac
  net: ethernet: bgmac: device tree phy enablement
  net: ethernet: bgmac: add NS2 support
  arm64: dts: NS2: add AMAC ethernet support

 .../devicetree/bindings/net/brcm,amac.txt          |  16 ++--
 Documentation/devicetree/bindings/net/phy.txt      |   3 +
 arch/arm64/boot/dts/broadcom/ns2-svk.dts           |   5 ++
 arch/arm64/boot/dts/broadcom/ns2.dtsi              |  12 +++
 drivers/net/ethernet/broadcom/bgmac-bcma.c         |  48 ++++++++++
 drivers/net/ethernet/broadcom/bgmac-platform.c     | 100 ++++++++++++++++++++-
 drivers/net/ethernet/broadcom/bgmac.c              |  55 ++----------
 drivers/net/ethernet/broadcom/bgmac.h              |   8 ++
 drivers/net/phy/Kconfig                            |   2 +-
 drivers/net/phy/broadcom.c                         |  68 +++++++++++++-
 include/linux/brcmphy.h                            |  10 +++
 11 files changed, 270 insertions(+), 57 deletions(-)

-- 
2.7.4
