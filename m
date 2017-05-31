From: gakula@caviumnetworks.com (Geetha sowjanya)
Date: Wed, 31 May 2017 17:03:32 +0530
Subject: [PATCH] PCI/PM: Set D3 power state only if the end device supports it.
Message-ID: <1496230412-19028-1-git-send-email-gakula@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pci driver doesn't check if the device supports D3hot/D3cold power states 
while setting these power states. The device that doesn't support these 
states will fail when a driver like vfio try to do D0->D3 power transition.

This patch adds a check that allows to set D3 power state only
for the supported devices.

Signed-off-by: Geetha sowjanya <gakula@caviumnetworks.com>
---
 drivers/pci/pci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 563901c..cadd046 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -661,7 +661,8 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 
 	/* check if this device supports the desired state */
 	if ((state == PCI_D1 && !dev->d1_support)
-	   || (state == PCI_D2 && !dev->d2_support))
+	   || (state == PCI_D2 && !dev->d2_support)
+	   || (state == PCI_D3hot && !pci_pme_capable(dev, state)))
 		return -EIO;
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
-- 
1.7.1
