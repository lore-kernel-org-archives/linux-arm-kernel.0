From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 22 Nov 2017 00:30:49 -0500
Subject: [PATCH 04/30] ata: deprecate pci_get_bus_and_slot()
In-Reply-To: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1511328675-21981-5-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
extract the domain number. Other places, use the actual domain number from
the device.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/ata/pata_ali.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index d19cd88..b297fea 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -466,7 +466,7 @@ static void ali_init_chipset(struct pci_dev *pdev)
 			tmp |= 0x01;	/* CD_ROM enable for DMA */
 		pci_write_config_byte(pdev, 0x53, tmp);
 	}
-	north = pci_get_bus_and_slot(0, PCI_DEVFN(0,0));
+	north = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
 	if (north && north->vendor == PCI_VENDOR_ID_AL && ali_isa_bridge) {
 		/* Configure the ALi bridge logic. For non ALi rely on BIOS.
 		   Set the south bridge enable bit */
-- 
1.9.1
