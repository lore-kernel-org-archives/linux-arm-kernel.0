From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 20 Sep 2012 09:21:48 +0200
Subject: [PATCH v2 0/2] ARM: pci: Prepare for Tegra PCIe controller driver
Message-ID: <1348125710-28726-1-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

These are two patches I've been carrying in a larger series that
converts the Tegra PCIe controller driver to a proper platform driver.
Since the complete series didn't get much feedback, I've begun to post
smaller subsets in an effort to get them merged more easily.

The first patch in this series removes the __init annotations from the
pci_common_init() function (and pcibios_init_hw() and pcibios_swizzle()
because they are called from the former) to make sure that they stay
around after the init stage. This is required because the Tegra driver
depends on regulators that become available only very late during boot
and uses deferred probing to handle this situation. It turned out that
this postpones the PCI bus initialization until after init, thus this
patch.

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
 arch/arm/kernel/bios32.c        | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
1.7.12
