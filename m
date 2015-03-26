From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 26 Mar 2015 18:08:53 +0000
Subject: [PATCH] dma: at_xdmac: use __le32 for dma addresses
Message-ID: <1427393333-14473-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The at_xdmac uses a lli structure with a mix of dma_addr_t and __le32
in it. As Russell King pointed out, dma_addr_t could be a non 32-bit
size depending on the kernel configuration. Change all references of
this to __le32 to better match the hardware representation.

Note, this does nothing to fix the discussion of dma vs physical
addresses also brought up during these discussions.

This patch depends on the __le32 descriptor updates posted
previously.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Russell King <linux@arm.linux.org.uk>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Vinod Koul <vinod.koul@intel.com>
CC: linux-arm-kernel at lists.infradead.org
CC: dmaengine at vger.kernel.org
---
 drivers/dma/at_xdmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 65a37be..d9dd71c 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -231,10 +231,10 @@ struct at_xdmac {
 
 /* Linked List Descriptor */
 struct at_xdmac_lld {
-	dma_addr_t	mbr_nda;	/* Next Descriptor Member */
+	__le32		mbr_nda;	/* Next Descriptor Member */
 	__le32		mbr_ubc;	/* Microblock Control Member */
-	dma_addr_t	mbr_sa;		/* Source Address Member */
-	dma_addr_t	mbr_da;		/* Destination Address Member */
+	__le32		mbr_sa;		/* Source Address Member */
+	__le32		mbr_da;		/* Destination Address Member */
 	__le32		mbr_cfg;	/* Configuration Register */
 };
 
-- 
2.1.4
