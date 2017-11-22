From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 22 Nov 2017 00:30:51 -0500
Subject: [PATCH 06/30] edd: deprecate pci_get_bus_and_slot()
In-Reply-To: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1511328675-21981-7-git-send-email-okaya@codeaurora.org>
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
 drivers/firmware/edd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
index e229576..60a8f13 100644
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -669,10 +669,10 @@ static void edd_release(struct kobject * kobj)
 	struct edd_info *info = edd_dev_get_info(edev);
 
 	if (edd_dev_is_type(edev, "PCI") || edd_dev_is_type(edev, "XPRS")) {
-		return pci_get_bus_and_slot(info->params.interface_path.pci.bus,
-				     PCI_DEVFN(info->params.interface_path.pci.slot,
-					       info->params.interface_path.pci.
-					       function));
+		return pci_get_domain_bus_and_slot(0,
+				info->params.interface_path.pci.bus,
+				PCI_DEVFN(info->params.interface_path.pci.slot,
+				info->params.interface_path.pci.function));
 	}
 	return NULL;
 }
-- 
1.9.1
