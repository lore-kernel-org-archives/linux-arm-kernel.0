From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 18 Dec 2017 10:17:56 +0100
Subject: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
Message-ID: <1513588684-15647-1-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset introduces ACPI support in mvpp2 and mvmdio drivers.
First three patches introduce fwnode helpers for obtaining PHY
information from nodes and also MDIO fwnode API for registering
the bus with its PHY/devices.

Following patches update code of the mvmdio and mvpp2 drivers
to support ACPI tables handling. The latter is done in 4 steps,
as can be seen in the commits. For the details, please
refer to the commit messages.

Drivers operation was tested on top of the net-next branch
with both DT and ACPI. Although for compatibility reasons
with older platforms, the mvmdio driver keeps using
of_ MDIO registering, new fwnode_ one proved to fully work
with DT as well (tested on MacchiatoBin board).

mvpp2/mvmdio driver can work with the ACPI representation, as exposed
on a public branch:
https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/commits/marvell-armada-wip
It was compiled together with the most recent Tianocore EDK2 revision.
Please refer to the firmware build instruction on MacchiatoBin board:
http://wiki.macchiatobin.net/tiki-index.php?page=Build+from+source+-+UEFI+EDK+II

Above support configures 1G to use its PHY normally. 10G can work now
only with the link interrupt mode. Somehow reading of the
string property in fwnode_mdiobus_child_is_phy works only with
DT and cannot cope with 10G PHY nodes as in:
https://pastebin.com/3JnYpU0A

Above root cause will be further checked. In the meantime I will
appreciate any comments or remarks for the kernel patches.

Best regards,
Marcin

Marcin Wojtas (8):
  device property: Introduce fwnode_get_mac_address()
  device property: Introduce fwnode_get_phy_mode()
  mdio_bus: Introduce fwnode MDIO helpers
  net: mvmdio: add ACPI support
  net: mvpp2: simplify maintaining enabled ports' list
  net: mvpp2: use device_*/fwnode_* APIs instead of of_*
  net: mvpp2: handle PHY with its fwnode
  net: mvpp2: enable ACPI support in the driver

 drivers/base/property.c               |  52 +++--
 drivers/net/ethernet/marvell/mvmdio.c |  42 +++-
 drivers/net/ethernet/marvell/mvpp2.c  | 246 ++++++++++++--------
 drivers/net/phy/mdio_bus.c            | 218 +++++++++++++++++
 include/linux/mdio.h                  |   3 +
 include/linux/property.h              |   3 +
 6 files changed, 454 insertions(+), 110 deletions(-)

-- 
2.7.4
