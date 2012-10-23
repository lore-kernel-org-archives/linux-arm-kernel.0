From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 23 Oct 2012 18:54:56 +0200
Subject: [PATCH v3] Network driver for the Armada 370 and Armada XP ARM
 Marvell SoCs
Message-ID: <1351011300-26964-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David, Lennert,

This patch set adds a new network driver for the network unit
available in the newest Marvell ARM SoCs Armada 370 and Armada XP, as
well as the necessary Device Tree information to use this driver in
the two evaluation platforms of those SoCs.

In details:

 * Patch 1 contains the driver itself. The commit log contains a
   detailed explanation about why a new driver is needed for this new
   Marvell SoC, compared to older Marvell SoCs (Orion, Kirkwood, Dove)
   that use the mv643xx_eth driver.

 * Patch 2 adds the necessary entry to the MAINTAINERS file.

 * Patch 3 adds the SoC-level Device Tree information for Armada 370
   and Armada XP.

 * Patch 4 adds the board-level Device Tree information for the
   Marvell evaluation boards of Armada 370 and Armada XP.

Changes since v2:
 * Change compatible string from 'marvell,neta' to
   'marvell,armada-370-neta'. Requested by Rob Herring.
 * Rename Ethernet DT nodes from eth at ... to ethernet at ... Requested by
   Rob Herring.
 * Remove device_type DT property. Requested by Rob Herring.
 * Change the PHY interface for eth0/eth1 to be rgmii-id, which allows
   to enable TX/RX delay mechanisms at the PHY level. This fixes CRC
   errors on received packets during iperf tests (it was a bug in v2).
 * Remove the mvneta_ prefix from module parameters. Requested by
   Baruch Siach.
 * Many code style improvements suggested by Fran?ois Romieu.
 * Properly stop/restart the TX queue when the number of TX
   descriptors available becomes low, instead of returning
   NETDEV_TX_BUSY. Requested by Fran?ois Romieu.
 * Properly drop packets on the TX path when DMA mapping functions
   return an error, instead of returning NETDEV_TX_BUSY. Requested by
   Fran?ois Romieu.
 * Rebased on top of Linux 3.7-rc2.

Changes since v1:
 * Reduced the Cc: list in order to make the patch set acceptable for
   the netdev@ mailing list.
 * Merge the mvneta.h contents into mvneta.c, since the header was
   only used by the driver. Requested by Arnd Bergmann.
 * Completely reorganize the organization of the register list and
   register values, in order to make it more consistent, and hopefully
   easier to read (especially easier to match register values with the
   corresponding register).
 * Integrate with the phylib, as suggested by Florian Fainelli, and
   remove the link management code that has become useless as the
   result of this integration
 * Fix many small details suggested by Florian Fainelli in his review
   of the first driver
 * Simplify various parts of the driver (descriptors array allocation,
   data structures, etc.)

Thanks,

Thomas Petazzoni
