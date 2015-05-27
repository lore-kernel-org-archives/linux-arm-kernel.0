From: rric@kernel.org (Robert Richter)
Date: Wed, 27 May 2015 10:01:30 +0200
Subject: [PATCH v3 0/3] AHCI: Add generic MSI-X interrupt support to SATA PCI
 driver
Message-ID: <1432713693-4282-1-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

This patch set adds generic support for MSI-X interrupts to the SATA
PCI driver.

The first 2 patches rework the code, one splits msi and intx code into
separate functions, the other changes interrupt initialization to
store the irq number in the ahci data structure (struct
ahci_host_priv). Both changes are needed to implement MSI-X support in
the last 3rd patch.

v3:
 * store irq number in struct ahci_host_priv
 * change initialization order from msix-msi-intx to msi-msix-intx
 * improve comments in ahci_init_msix()
 * improve error message in ahci_init_msix()
 * do not enable MSI-X if MSI is actively disabled for the device

v2:
 * determine irq vector from pci_dev->msi_list


Robert Richter (3):
  ahci: Move interrupt enablement code to separate functions
  ahci: Store irq number in struct ahci_host_priv
  AHCI: Add generic MSI-X interrupt support to SATA PCI driver

 drivers/ata/acard-ahci.c       |   4 +-
 drivers/ata/ahci.c             | 138 ++++++++++++++++++++++++++++++++++++-----
 drivers/ata/ahci.h             |   4 +-
 drivers/ata/libahci.c          |  25 +++-----
 drivers/ata/libahci_platform.c |   4 +-
 drivers/ata/sata_highbank.c    |   3 +-
 6 files changed, 143 insertions(+), 35 deletions(-)

-- 
2.1.1
