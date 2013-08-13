From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 13 Aug 2013 13:12:23 +0200
Subject: [RFC 0/3] ARM: Allow PCI host drivers to be unloaded
Message-ID: <1376392346-14127-1-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a set of experimental patches that allow ARM PCI host drivers to
be unloaded. The first two patches enhance the ARM core PCI code with
functions to tear down fixed PCI I/O mappings and unregister a PCI host
bridge. The third patch uses the new functionality to allow the Tegra
PCIe driver to unbind from a device.

I'm sending this as an RFC because, while I've been able to successfully
unbind and rebind the Tegra PCIe driver and verifying that a NIC
connected via PCIe still works after each new probe, I haven't fully
investigated yet whether there may be memory leaks due to missing
cleanup.

Thierry

Thierry Reding (3):
  ARM: Allow unmapping of fixed PCI I/O mappings
  ARM: Introduce pci_common_exit()
  PCI: tegra: Support driver unbinding

 arch/arm/include/asm/io.h       |  1 +
 arch/arm/include/asm/mach/pci.h |  6 ++++++
 arch/arm/kernel/bios32.c        | 29 ++++++++++++++++++++++++++---
 arch/arm/mm/ioremap.c           |  6 ++++++
 drivers/pci/host/pci-tegra.c    | 37 ++++++++++++++++++++++++++++++++++++-
 5 files changed, 75 insertions(+), 4 deletions(-)

-- 
1.8.3.4
