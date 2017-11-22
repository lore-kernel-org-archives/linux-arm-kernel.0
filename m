From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 22 Nov 2017 00:30:59 -0500
Subject: [PATCH 14/30] powerpc/powermac: deprecate pci_get_bus_and_slot()
In-Reply-To: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1511328675-21981-15-git-send-email-okaya@codeaurora.org>
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
 drivers/macintosh/via-pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index c4c2b3b..3e8b3b6 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -1799,7 +1799,7 @@ static int powerbook_sleep_grackle(void)
 	struct adb_request req;
 	struct pci_dev *grackle;
 
-	grackle = pci_get_bus_and_slot(0, 0);
+	grackle = pci_get_domain_bus_and_slot(0, 0, 0);
 	if (!grackle)
 		return -ENODEV;
 
-- 
1.9.1
