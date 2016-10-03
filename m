From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon,  3 Oct 2016 01:37:00 -0400
Subject: [PATCH V3 2/2] PCI: handle CRS returned by device after FLR
In-Reply-To: <1475473021-14251-1-git-send-email-okaya@codeaurora.org>
References: <1475473021-14251-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1475473021-14251-3-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An endpoint is allowed to issue CRS following an FLR request to indicate
that it is not ready to accept new requests. Changing the polling mechanism
in FLR wait function to go read the vendor ID instead of the command/status
register. A CRS indication will only be given if the address to be read is
vendor ID.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c8749b9..7580b00 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3725,7 +3725,8 @@ static void pci_flr_wait(struct pci_dev *dev)
 
 	do {
 		msleep(100);
-		pci_read_config_dword(dev, PCI_COMMAND, &id);
+		pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &id,
+					   60 * 1000);
 	} while (i++ < 10 && id == ~0);
 
 	if (id == ~0)
-- 
1.9.1
