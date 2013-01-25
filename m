From: florian@openwrt.org (Florian Fainelli)
Date: Fri, 25 Jan 2013 11:06:45 +0100
Subject: [RFC PATCH 0/4] net: mvmdio: close the gaps between mv643xx_eth and
 mvmdio
Message-ID: <1359108409-4378-1-git-send-email-florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series attempts to close the gaps between the SMI/MDIO driver
implemented and use by the Marvell MV643XX ethernet driver and Thomas' MVMDIO
driver. I did not convert yet mv643xx_eth to use it as it would require proper
Device Tree bindings (which is being worked on) to easily hook into it.

Note that I could not test this properly yet, thus the RFC, and I would like to
find a better way of setting/getting the PHY address than using two exports,
although I have tried to make them easy enough to use so the following logic in
Ethernet drivers can be used:

- lookup device tree handle from MDIO device tree node
- lookup corresponding struct platform_device from the device tree handle
- call the helpers

Comment welcome!

Florian Fainelli (4):
  net: mvmdio: rename base register cookie from smireg to regs
  net: mvmdio: do not assume SMI reg is at offset 0 of the resource
  net: mvmdio: enhance driver to support SMI error/done interrupts
  net: mvmdio: add getter and setter for PHY addresses

 .../devicetree/bindings/net/marvell-orion-mdio.txt |    5 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               |    2 +-
 drivers/net/ethernet/marvell/mvmdio.c              |  125 +++++++++++++++++---
 include/linux/marvell_mvmdio.h                     |   10 ++
 4 files changed, 122 insertions(+), 20 deletions(-)
 create mode 100644 include/linux/marvell_mvmdio.h

-- 
1.7.10.4
