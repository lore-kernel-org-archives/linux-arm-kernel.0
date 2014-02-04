From: will.deacon@arm.com (Will Deacon)
Date: Tue,  4 Feb 2014 16:53:01 +0000
Subject: [PATCH 0/3] ARM: PCI: implement virtual PCI host controller
Message-ID: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This small set of patches brings PCI support to mach-virt based upon an
idealised host controller (see patch 2 for more details).

This has been tested with kvmtool, for which I have a corresponding set
of patches which you can find in my kvmtool/pci branch at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/kvmtool.git

Once the arm64 PCI patches from Liviu have stabilised, I plan to port
this host controller to work there as well.

The main issue I can see with this code is how to describe configuration
space in the device-tree. I'm following the ePAPR PCI bindings (SS == 0)
, but this adds an ugly 'case 0:' line in the pci range parser, which
also exists in mainline for the pcie-designware.c driver.

All feedback welcome,

Will


Will Deacon (3):
  ARM: bios32: use pci_enable_resource to enable PCI resources
  PCI: ARM: add support for virtual PCI host controller
  ARM: mach-virt: allow PCI support to be selected

 .../devicetree/bindings/pci/linux,pci-virt.txt     |  38 ++++
 arch/arm/kernel/bios32.c                           |  35 ++--
 arch/arm/mach-virt/Kconfig                         |   1 +
 drivers/pci/host/Kconfig                           |   7 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-virt.c                        | 200 +++++++++++++++++++++
 6 files changed, 257 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/linux,pci-virt.txt
 create mode 100644 drivers/pci/host/pci-virt.c

-- 
1.8.2.2
