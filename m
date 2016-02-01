From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Feb 2016 17:42:02 +0100
Subject: [PATCH] infiniband: cxgb4: use %pR format string for printing
 resources
Message-ID: <2278867.O0SM8nbQp0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cxgb4 prints an MMIO resource using the "0x%x" and "%p" format
strings on the length and start, respective, but that
triggers a compiler warning when using a 64-bit resource_size_t
on a 32-bit architecture:

drivers/infiniband/hw/cxgb4/device.c: In function 'c4iw_rdev_open':
drivers/infiniband/hw/cxgb4/device.c:807:7: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
       (void *)pci_resource_start(rdev->lldi.pdev, 2),

This changes the format string to use %pR instead, which pretty-prints
the resource, avoids the warning and is shorter.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This is an old warning I see rarely on ARM randconfig builds.

diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
index 8024ea4417b8..ebd60a20f148 100644
--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -801,10 +801,9 @@ static int c4iw_rdev_open(struct c4iw_rdev *rdev)
 	     rdev->lldi.vr->qp.size,
 	     rdev->lldi.vr->cq.start,
 	     rdev->lldi.vr->cq.size);
-	PDBG("udb len 0x%x udb base %p db_reg %p gts_reg %p "
+	PDBG("udb %pR db_reg %p gts_reg %p "
 	     "qpmask 0x%x cqmask 0x%x\n",
-	     (unsigned)pci_resource_len(rdev->lldi.pdev, 2),
-	     (void *)pci_resource_start(rdev->lldi.pdev, 2),
+		&rdev->lldi.pdev->resource[2],
 	     rdev->lldi.db_reg, rdev->lldi.gts_reg,
 	     rdev->qpmask, rdev->cqmask);
 
