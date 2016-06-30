From: jon.mason@broadcom.com (Jon Mason)
Date: Thu, 30 Jun 2016 18:59:07 -0400
Subject: [PATCH 0/7] net: ethernet: bgmac: Add platform device support
Message-ID: <1467327554-22074-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Well, no compilained too loudly at the RFC version of this patch series
(see https://lkml.org/lkml/2016/6/28/863).  So, I'm officially sending
this out for inclusion.  All comments from the RFC were addressed in
this version.

This patch series adds support for other, non-bcma iProc SoC's to the
bgmac driver.  This series only adds NSP support, but we are interested
in adding support for the Cygnus and NS2 families (with more possible
down the road).

To support non-bcma enabled SoCs, we need to add the standard device
tree "platform device" support.  Unfortunately, this driver is very
tighly coupled with the bcma bus and much unwinding is needed.  I tried
to break this up into a number of patches to make it more obvious what
was being done to add platform device support.  I was able to verify
that the bcma code still works using a 53012K board (NS SoC), and that
the platform code works using a 58625K board (NSP SoC).

Thanks,
Jon

Jon Mason (7):
  net: ethernet: bgmac: change bgmac_* prints to dev_* prints
  net: ethernet: bgmac: add dma_dev pointer
  net: ethernet: bgmac: move BCMA MDIO Phy code into a separate file
  net: ethernet: bgmac: convert to feature flags
  net: ethernet: bgmac: Add platform device support
  dt-bindings: net: bgmac: add bindings documentation for bgmac
  ARM: dts: NSP: Add bgmac entries

 .../devicetree/bindings/net/brcm,bgmac-nsp.txt     |  24 +
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  18 +
 arch/arm/boot/dts/bcm958625k.dts                   |   8 +
 drivers/net/ethernet/broadcom/Kconfig              |  23 +-
 drivers/net/ethernet/broadcom/Makefile             |   2 +
 drivers/net/ethernet/broadcom/bgmac-bcma-mdio.c    | 266 +++++++++
 drivers/net/ethernet/broadcom/bgmac-bcma.c         | 315 ++++++++++
 drivers/net/ethernet/broadcom/bgmac-platform.c     | 210 +++++++
 drivers/net/ethernet/broadcom/bgmac.c              | 658 +++++----------------
 drivers/net/ethernet/broadcom/bgmac.h              | 112 +++-
 10 files changed, 1120 insertions(+), 516 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/brcm,bgmac-nsp.txt
 create mode 100644 drivers/net/ethernet/broadcom/bgmac-bcma-mdio.c
 create mode 100644 drivers/net/ethernet/broadcom/bgmac-bcma.c
 create mode 100644 drivers/net/ethernet/broadcom/bgmac-platform.c

-- 
1.9.1
