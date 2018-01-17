From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 17 Jan 2018 17:55:39 +0100
Subject: [net-next: PATCH v3 0/7] Armada 7k/8k PP2 ACPI support
Message-ID: <1516208146-4144-1-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a third version of the patchset introducing mvpp2 driver ability
to operate with ACPI. Until follow-up generic MDIO is introduced
it can using the link interrupt capability (a.k.a. in-band management)
on all ports, 1000BaseT RGMII included.
Driver operation was tested on top of the net-next branch
with both DT and ACPI on MacchiatoBin and Armada 7040 DB boards.

The main changes were requested during v2 review, which was
adding generic helper routines for:
* interating over available fwnodes (new patch 4/7)
* getting IRQ directly from fwnode (new patch 3/7)
Thanks to the latter the driver code could be simplified
and allowed to drop formula-based IRQ obtaining. Changes are
summarized in the changelog below.

mvpp2 driver can work with the ACPI representation, as exposed
on a public branch:
https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/commits/marvell-armada-wip
It was compiled together with the most recent Tianocore EDK2 revision.
Please refer to the firmware build instruction on MacchiatoBin board:
http://wiki.macchiatobin.net/tiki-index.php?page=Build+from+source+-+UEFI+EDK+II

ACPI representation of PP2 controllers (withouth PHY support) can
be viewed in the github:
* MacchiatoBin:
https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/blob/71ae395da1661374b0f07d1602afb1eee56e9794/Platforms/Marvell/Armada/AcpiTables/Armada80x0McBin/Dsdt.asl#L201

* Armada 7040 DB:
https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/blob/71ae395da1661374b0f07d1602afb1eee56e9794/Platforms/Marvell/Armada/AcpiTables/Armada70x0/Dsdt.asl#L131

I will appreciate any comments or remarks.

Best regards,
Marcin

Changelog:
v2 -> v3:
* 1/7, 2/7
    - Add Rafael's Acked-by's
* 3/7, 4/7
    - New patches
* 6/7, 7/7
    - Update driver with new helper routines usage
    - Improve commit log.

v1 -> v2:
* Remove MDIO patches
* Use PP2 ports only with link interrupts
* Release second region resources in mvpp2 driver (code moved from
  mvmdio), as explained in details in 5/5 commit message.


Marcin Wojtas (7):
  device property: Introduce fwnode_get_mac_address()
  device property: Introduce fwnode_get_phy_mode()
  device property: Introduce fwnode_irq_get()
  device property: Allow iterating over available child fwnodes
  net: mvpp2: simplify maintaining enabled ports' list
  net: mvpp2: use device_*/fwnode_* APIs instead of of_*
  net: mvpp2: enable ACPI support in the driver

 drivers/base/property.c              | 105 ++++++++--
 drivers/net/ethernet/marvell/mvpp2.c | 206 ++++++++++++--------
 include/linux/property.h             |  11 ++
 3 files changed, 230 insertions(+), 92 deletions(-)

-- 
2.7.4
