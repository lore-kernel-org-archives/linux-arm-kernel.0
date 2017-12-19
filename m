From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 19 Dec 2017 00:37:42 -0500
Subject: [PATCH V4 06/26] edd: deprecate pci_get_bus_and_slot()
In-Reply-To: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1513661883-28662-7-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

Domain number is not available in struct edd_info. Hard-coding the domain
number as 0.

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
