From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 23 Oct 2014 16:23:06 +0100
Subject: [PATCH RFC 1/2] drivers: pci: fix window allocation order wrt
 bus_range filtering
Message-ID: <1414077787-20633-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The number of windows allocated for the host bridge depends on the
bus resource. Instead of first allocating the windows and then
limit the bus resource, this patch reshuffles the code so that if any
limitation is applied to the bus resource it is taken into account in
the windows allocation.

Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/pci/host/pci-host-generic.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 3d2076f..1e1a80f 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -276,17 +276,17 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
 		return err;
 	}
 
-	pci->cfg.win = devm_kcalloc(dev, resource_size(&pci->cfg.bus_range),
-				    sizeof(*pci->cfg.win), GFP_KERNEL);
-	if (!pci->cfg.win)
-		return -ENOMEM;
-
 	/* Limit the bus-range to fit within reg */
 	bus_max = pci->cfg.bus_range.start +
 		  (resource_size(&pci->cfg.res) >> pci->cfg.ops->bus_shift) - 1;
 	pci->cfg.bus_range.end = min_t(resource_size_t, pci->cfg.bus_range.end,
 				       bus_max);
 
+	pci->cfg.win = devm_kcalloc(dev, resource_size(&pci->cfg.bus_range),
+				    sizeof(*pci->cfg.win), GFP_KERNEL);
+	if (!pci->cfg.win)
+		return -ENOMEM;
+
 	/* Map our Configuration Space windows */
 	if (!devm_request_mem_region(dev, pci->cfg.res.start,
 				     resource_size(&pci->cfg.res),
-- 
2.1.2
