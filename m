From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 19 Dec 2017 00:37:50 -0500
Subject: [PATCH V4 14/26] pch_gbe: deprecate pci_get_bus_and_slot()
In-Reply-To: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1513661883-28662-15-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

Use the domain information from pdev while calling into
pci_get_domain_bus_and_slot() function.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 40e52ff..7cd4946 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -2594,8 +2594,10 @@ static int pch_gbe_probe(struct pci_dev *pdev,
 	if (adapter->pdata && adapter->pdata->platform_init)
 		adapter->pdata->platform_init(pdev);
 
-	adapter->ptp_pdev = pci_get_bus_and_slot(adapter->pdev->bus->number,
-					       PCI_DEVFN(12, 4));
+	adapter->ptp_pdev =
+		pci_get_domain_bus_and_slot(pci_domain_nr(adapter->pdev->bus),
+					    adapter->pdev->bus->number,
+					    PCI_DEVFN(12, 4));
 
 	netdev->netdev_ops = &pch_gbe_netdev_ops;
 	netdev->watchdog_timeo = PCH_GBE_WATCHDOG_PERIOD;
-- 
1.9.1
