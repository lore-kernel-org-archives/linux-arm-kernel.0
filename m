From: gospo@broadcom.com (Andy Gospodarek)
Date: Thu,  8 Dec 2016 16:30:18 -0500
Subject: [PATCH pci/host-iproc] PCI: iproc: Allow more than slot 0 on PAXC
Message-ID: <1481232618-10614-1-git-send-email-gospo@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The iproc host driver limits the number of slots that are available on
PAXC devices.  Enforcing this limit prevents VFs from being created
beyond the first port.  After this change it is possible to create VFs
associated with all four devices.

The first four devices below are the PFs and the next four are the newly
created VFs:

0008:01:00.0 Ethernet controller: Broadcom Limited Device 16cd
0008:01:00.1 Ethernet controller: Broadcom Limited Device 16cd
0008:01:00.2 Ethernet controller: Broadcom Limited Device 16cd
0008:01:00.3 Ethernet controller: Broadcom Limited Device 16cd
0008:01:00.4 Ethernet controller: Broadcom Limited BCM57304 NetXtreme-C Ethernet Virtual Function
0008:01:01.0 Ethernet controller: Broadcom Limited BCM57304 NetXtreme-C Ethernet Virtual Function
0008:01:01.4 Ethernet controller: Broadcom Limited BCM57304 NetXtreme-C Ethernet Virtual Function
0008:01:02.0 Ethernet controller: Broadcom Limited BCM57304 NetXtreme-C Ethernet Virtual Function

Based on the git history around 923c6bb1f641 ("PCI: iproc: Allow multiple
devices except on PAXC") and 943ebae781f5 ("PCI: iproc: Add PAXC interface
support") I expect there may be an unmentioned or unknown-to-me reason why this
code exists.  I certainly cannot create and use VFs without some kind of change
around this space, so I would like to see the current limitation simply removed.

Fixes: 923c6bb1f641 ("PCI: iproc: Allow multiple devices except on PAXC")
Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
---
 drivers/pci/host/pcie-iproc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 3ebc025..9311826 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -477,14 +477,6 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
 			return (pcie->base + offset);
 	}
 
-	/*
-	 * PAXC is connected to an internally emulated EP within the SoC.  It
-	 * allows only one device.
-	 */
-	if (pcie->ep_is_internal)
-		if (slot > 0)
-			return NULL;
-
 	/* EP device access */
 	val = (busno << CFG_ADDR_BUS_NUM_SHIFT) |
 		(slot << CFG_ADDR_DEV_NUM_SHIFT) |
