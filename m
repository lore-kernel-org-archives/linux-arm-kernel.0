From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 14 Sep 2012 23:11:16 +0200
Subject: [PATCH 0/2] ARM: pci: Prepare for Tegra PCIe controller driver
Message-ID: <1347657078-32230-1-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

These are two patches I've been carrying in a larger series that
converts the Tegra PCIe controller driver to a proper platform driver.
Since the complete series didn't get much feedback, I've begun to post
smaller subsets in an effort to get them merged more easily.

The first patch in this series converts the __init annotations for
pci_common_init() (and pcibios_init_hw() because it is called from the
former) to __devinit to make sure that they stay around after the init
stage. This is required because the Tegra driver depends on regulators
that become available only very late during boot and uses deferred
probing to handle this situation. It turned out that this postpones the
PCI bus initialization until after init, thus this patch.

The second patch is used to pass per-controller or per-host-bridge data
to the driver, such that it can be associated with the corresponding
bus. This is also required by the Tegra driver in order to pass a
driver-private structure to the PCI bus (or more precisely the
pci_sys_data structure associated with a bus). It is subsequently used
to obtain the root port private data given the corresponding PCI bus.

Thierry

Thierry Reding (2):
  ARM: pci: Keep pci_common_init() around after init
  ARM: pci: Allow passing per-controller private data

 arch/arm/include/asm/mach/pci.h | 1 +
 arch/arm/kernel/bios32.c        | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
1.7.12
