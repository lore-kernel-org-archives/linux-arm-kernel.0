From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Mon, 22 Sep 2014 10:51:07 +0100
Subject: [PATCH 0/3] Add PCI domain support to R-Car drivers
Message-ID: <1411379470-20639-1-git-send-email-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Renesas R-Car devices (r8a7790 and r8a7791) use two PCI controller drivers,
one for an external PCIe slot, the other for an internal PCI bridge to USB
controllers.

However, they currently do not work at the same time as they use the same PCI
domain and use the same root bus number. We can't use different root bus numbers
due to the way root bus numbers are assigned in pcibios_init_hw() in
arch/arm/kernel/bios32.c.

Since the two PCI controllers are completely independent, I think it makes sense
to use different PCI domains for them.

I've marked the third patch as RFC as I am not sure of the impact of enabling
PCI domains for all ARM devices. In the march to 'one kernel to rule them all',
I steered clear of mach specific changes.

These patches require the following patch from Liviu Dudau:
  [PATCH v11 07/10] OF: Introduce helper function for getting PCI domain_nr
Based on comments on this patch from Jason Gunthorpe, there is still the issue
that the domain numbers may change depending on the ordering at probe time.
However, this can be fixed later on by adding the entries in the DT files.


Phil Edworthy (3):
  PCI: rcar-pcie: Add call to get domain nr
  PCI: rcar-internal-pci: Add call to get domain nr
  ARM: Enable PCI domains

 arch/arm/Kconfig                 | 2 +-
 drivers/pci/host/pci-rcar-gen2.c | 6 ++++++
 drivers/pci/host/pcie-rcar.c     | 9 ++++++---
 3 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.1.0
