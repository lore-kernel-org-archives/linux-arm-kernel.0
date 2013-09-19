From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 20 Sep 2013 00:42:06 +0100
Subject: [PATCH 49/51] ARM: 7796/1: scsi: Use dma_max_pfn(dev) helper for
 bounce_limit calculations
In-Reply-To: <20130919212235.GD12758@n2100.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
Message-ID: <E1VMnrK-0002Dw-Vk@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

DMA bounce limit is the maximum direct DMA'able memory beyond which
bounce buffers has to be used to perform dma operations. SCSI driver
relies on dma_mask but its calculation is based on max_*pfn which
don't have uniform meaning across architectures. So make use of
dma_max_pfn() which is expected to return the DMAable maximum pfn
value across architectures.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/scsi/scsi_lib.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index d1549b7..7bd7f0d 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1684,7 +1684,7 @@ u64 scsi_calculate_bounce_limit(struct Scsi_Host *shost)
 
 	host_dev = scsi_get_device(shost);
 	if (host_dev && host_dev->dma_mask)
-		bounce_limit = *host_dev->dma_mask;
+		bounce_limit = dma_max_pfn(host_dev) << PAGE_SHIFT;
 
 	return bounce_limit;
 }
-- 
1.7.4.4
