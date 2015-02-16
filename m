From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 Feb 2015 13:51:10 +0100
Subject: [PATCH v3 0/2] ARM: mvebu: a385-db-ap: Enable the NAND controller
Message-ID: <1424091072-7738-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch serie enable the NAND support on the Armada 385 Access
Point DB.

In the process, some timeouts were found when we were accessing a
freshly erased NAND page, which turned out to be an issue when
draining the read FIFO where we were not following the datasheet.

This has been fixed with the first patch, with stable CC'd. The second
patch just enables the NAND controller in the DT.

Thanks,
Maxime

Changes from v2:
  - Read the status bits only every 32 bytes read, and not 32 bits
    like was done before.
  - Changed the timeout routine code not use the jiffies that won't
    change in an interrupt context.

Changes from v1:
  - Added a timeout to the busy waiting loop for RDDREQ


Maxime Ripard (2):
  mtd: nand: pxa3xx: Fix PIO FIFO draining
  ARM: mvebu: a385-db-ap: Enable the NAND

 arch/arm/boot/dts/armada-385-db-ap.dts | 13 ++++++++++
 drivers/mtd/nand/pxa3xx_nand.c         | 47 +++++++++++++++++++++++++++++-----
 2 files changed, 54 insertions(+), 6 deletions(-)

-- 
2.3.0
