From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Fri, 29 Jun 2018 11:22:28 +0200
Subject: [PATCH 0/3] PCI: emulated PCI bridge common logic
Message-ID: <20180629092231.32207-1-thomas.petazzoni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The pci-mvebu driver already contains some logic to emulate a root
port PCI bridge. It turns out that we have a similar need for the
pci-aardvark driver. Instead of duplicating the same logic in two
drivers, this patch series starts by adding a small common
infrastructure that helps emulate a root port PCI bridge, converts
pci-mvebu to use it, and finally extends pci-aardvark to use it as
well.

Thanks to this, Marvell Armada 3720 based systems, which use the
Aarkvark PCI controller, will have better PCI support, by having a
root port PCI bridge exposed.

The emulated PCI bridge common logic is a proposal, I very much
welcome comments and suggestions. Also, if you feel that adding a
common logic for only two drivers is too early, I'm fine with
duplicating a bit of code betwen pci-mvebu and pci-aardvark.

Best regards,

Thomas

Thomas Petazzoni (2):
  PCI: Introduce PCI software bridge common logic
  PCI: mvebu: Convert to PCI software bridge

Zachary Zhang (1):
  PCI: aardvark: Implement emulated root PCI bridge

 drivers/pci/Kconfig                   |   3 +
 drivers/pci/Makefile                  |   1 +
 drivers/pci/controller/Kconfig        |   2 +
 drivers/pci/controller/pci-aardvark.c | 119 ++++++++++-
 drivers/pci/controller/pci-mvebu.c    | 370 ++++++++++------------------------
 drivers/pci/pci-sw-bridge.c           | 149 ++++++++++++++
 include/linux/pci-sw-bridge.h         | 125 ++++++++++++
 7 files changed, 497 insertions(+), 272 deletions(-)
 create mode 100644 drivers/pci/pci-sw-bridge.c
 create mode 100644 include/linux/pci-sw-bridge.h

-- 
2.14.4
