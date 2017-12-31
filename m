From: mw@semihalf.com (Marcin Wojtas)
Date: Sun, 31 Dec 2017 12:58:35 +0100
Subject: [net-next: PATCH v2 0/5] Armada 7k/8k PP2 ACPI support
Message-ID: <1514721520-18964-1-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This a second version of a patchset, which introduces ACPI support
in mvpp2 driver. Comparing to the initial one, all patches
touching generic ACPI MDIO bus / PHY handling were removed
and after some modifications will be resend separately. They
may require a longer discussion in terms of phylink support
and ACPI specification extensions.

This way mvpp2 driver is able to operate using the link interrupt
capability (a.k.a. in-band management) on all ports, 1000BaseT RGMII
included. Driver operation was tested on top of the net-next branch
with both DT and ACPI on MacchiatoBin and Armada 7040 DB boards.

mvpp2 driver can work with the ACPI representation, as exposed
on a public branch:
https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/commits/marvell-armada-wip
It was compiled together with the most recent Tianocore EDK2 revision.
Please refer to the firmware build instruction on MacchiatoBin board:
http://wiki.macchiatobin.net/tiki-index.php?page=Build+from+source+-+UEFI+EDK+II

ACPI representation of PP2 controllers (withouth PHY support) can
be viewed in the github:
* MacchiatoBin:
https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/blob/marvell-armada-wip/Platforms/Marvell/Armada/AcpiTables/Armada80x0McBin/Dsdt.asl#L201

* Armada 7040 DB:
https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/blob/marvell-armada-wip/Platforms/Marvell/Armada/AcpiTables/Armada70x0/Dsdt.asl#L131

I will appreciate any comments or remarks.

Best regards,
Marcin

Changelog:
v1 -> v2:
* Remove MDIO patches
* Use PP2 ports only with link interrupts
* Release second region resources in mvpp2 driver (code moved from
  mvmdio), as explained in details in 5/5 commit message.

Marcin Wojtas (5):
  device property: Introduce fwnode_get_mac_address()
  device property: Introduce fwnode_get_phy_mode()
  net: mvpp2: simplify maintaining enabled ports' list
  net: mvpp2: use device_*/fwnode_* APIs instead of of_*
  net: mvpp2: enable ACPI support in the driver

 drivers/base/property.c              |  52 +++--
 drivers/net/ethernet/marvell/mvpp2.c | 222 ++++++++++++--------
 include/linux/property.h             |   3 +
 3 files changed, 180 insertions(+), 97 deletions(-)

-- 
2.7.4
