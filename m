From: florian@openwrt.org (Florian Fainelli)
Date: Fri, 22 Mar 2013 14:39:24 +0100
Subject: [PATCH 0/4 v3] mv643xx_eth: use mvmdio MDIO bus driver
In-Reply-To: <1363284515-9865-1-git-send-email-florian@openwrt.org>
References: <1363284515-9865-1-git-send-email-florian@openwrt.org>
Message-ID: <1363959568-16976-1-git-send-email-florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch converts the mv643xx_eth driver to use the mvmdio MDIO bus driver
instead of rolling its own implementation. As a result, all users of this
mv643xx_eth driver are converted to register an "orion-mdio" platform_device.
The mvmdio driver is also updated to support an interrupt line which reports
SMI error/completion, and to allow traditionnal platform device registration
instead of just device tree.

David, I think it makes sense for you to merge all of this, since we do
not want the architecture files to be desynchronized from the mv643xx_eth to
avoid runtime breakage. The potential for merge conflicts should be very small.

Florian Fainelli (4):
  net: mvmdio: allow platform device style registration
  net: mvmdio: rename base register cookie from smireg to regs
  net: mvmdio: enhance driver to support SMI error/done interrupts
  mv643xx_eth: convert to use the Marvell Orion MDIO driver

 .../devicetree/bindings/net/marvell-orion-mdio.txt |    3 +
 arch/arm/plat-orion/common.c                       |   54 +++---
 arch/powerpc/platforms/chrp/pegasos_eth.c          |   20 ++
 arch/powerpc/sysdev/mv64x60_dev.c                  |   16 +-
 drivers/net/ethernet/marvell/Kconfig               |    5 +-
 drivers/net/ethernet/marvell/Makefile              |    2 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c         |  195 ++------------------
 drivers/net/ethernet/marvell/mvmdio.c              |  130 ++++++++++---
 include/linux/mv643xx_eth.h                        |    1 -
 9 files changed, 187 insertions(+), 239 deletions(-)

-- 
1.7.10.4
