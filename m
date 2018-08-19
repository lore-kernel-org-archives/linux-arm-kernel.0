From: angelo@sysam.it (Angelo Dureghello)
Date: Sun, 19 Aug 2018 19:27:15 +0200
Subject: [PATCH v10 3/4] dmaengine: fsl-edma: fix macros
In-Reply-To: <20180819172716.32304-1-angelo@sysam.it>
References: <20180819172716.32304-1-angelo@sysam.it>
Message-ID: <20180819172716.32304-3-angelo@sysam.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes macros to use BIT() and GENMASK(), removing
also some unneeded.

Signed-off-by: Angelo Dureghello <angelo@sysam.it>
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
---
Changes for v9:
- this patch (3/4) has just been added.

Changes for v10:
- none
---
 drivers/dma/fsl-edma-common.h | 50 +++++++++++++++--------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index b2ee89ea895a..a6f5b99ee95f 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -18,34 +18,28 @@
 #define EDMA_CR_ECX		BIT(16)
 #define EDMA_CR_CX		BIT(17)
 
-#define EDMA_SEEI_SEEI(x)	((x) & 0x1F)
-#define EDMA_CEEI_CEEI(x)	((x) & 0x1F)
-#define EDMA_CINT_CINT(x)	((x) & 0x1F)
-#define EDMA_CERR_CERR(x)	((x) & 0x1F)
-
-#define EDMA_TCD_ATTR_DSIZE(x)		(((x) & 0x0007))
-#define EDMA_TCD_ATTR_DMOD(x)		(((x) & 0x001F) << 3)
-#define EDMA_TCD_ATTR_SSIZE(x)		(((x) & 0x0007) << 8)
-#define EDMA_TCD_ATTR_SMOD(x)		(((x) & 0x001F) << 11)
-#define EDMA_TCD_ATTR_SSIZE_8BIT	(0x0000)
-#define EDMA_TCD_ATTR_SSIZE_16BIT	(0x0100)
-#define EDMA_TCD_ATTR_SSIZE_32BIT	(0x0200)
-#define EDMA_TCD_ATTR_SSIZE_64BIT	(0x0300)
-#define EDMA_TCD_ATTR_SSIZE_32BYTE	(0x0500)
-#define EDMA_TCD_ATTR_DSIZE_8BIT	(0x0000)
-#define EDMA_TCD_ATTR_DSIZE_16BIT	(0x0001)
-#define EDMA_TCD_ATTR_DSIZE_32BIT	(0x0002)
-#define EDMA_TCD_ATTR_DSIZE_64BIT	(0x0003)
-#define EDMA_TCD_ATTR_DSIZE_32BYTE	(0x0005)
-
-#define EDMA_TCD_SOFF_SOFF(x)		(x)
-#define EDMA_TCD_NBYTES_NBYTES(x)	(x)
-#define EDMA_TCD_SLAST_SLAST(x)		(x)
-#define EDMA_TCD_DADDR_DADDR(x)		(x)
-#define EDMA_TCD_CITER_CITER(x)		((x) & 0x7FFF)
-#define EDMA_TCD_DOFF_DOFF(x)		(x)
-#define EDMA_TCD_DLAST_SGA_DLAST_SGA(x)	(x)
-#define EDMA_TCD_BITER_BITER(x)		((x) & 0x7FFF)
+#define EDMA_SEEI_SEEI(x)	((x) & GENMASK(4, 0))
+#define EDMA_CEEI_CEEI(x)	((x) & GENMASK(4, 0))
+#define EDMA_CINT_CINT(x)	((x) & GENMASK(4, 0))
+#define EDMA_CERR_CERR(x)	((x) & GENMASK(4, 0))
+
+#define EDMA_TCD_ATTR_DSIZE(x)		(((x) & GENMASK(2, 0)))
+#define EDMA_TCD_ATTR_DMOD(x)		(((x) & GENMASK(4, 0)) << 3)
+#define EDMA_TCD_ATTR_SSIZE(x)		(((x) & GENMASK(2, 0)) << 8)
+#define EDMA_TCD_ATTR_SMOD(x)		(((x) & GENMASK(4, 0)) << 11)
+#define EDMA_TCD_ATTR_DSIZE_8BIT	0
+#define EDMA_TCD_ATTR_DSIZE_16BIT	BIT(0)
+#define EDMA_TCD_ATTR_DSIZE_32BIT	BIT(1)
+#define EDMA_TCD_ATTR_DSIZE_64BIT	(BIT(0) | BIT(1))
+#define EDMA_TCD_ATTR_DSIZE_32BYTE	(BIT(3) | BIT(0))
+#define EDMA_TCD_ATTR_SSIZE_8BIT	0
+#define EDMA_TCD_ATTR_SSIZE_16BIT	(EDMA_TCD_ATTR_DSIZE_16BIT << 8)
+#define EDMA_TCD_ATTR_SSIZE_32BIT	(EDMA_TCD_ATTR_DSIZE_32BIT << 8)
+#define EDMA_TCD_ATTR_SSIZE_64BIT	(EDMA_TCD_ATTR_DSIZE_64BIT << 8)
+#define EDMA_TCD_ATTR_SSIZE_32BYTE	(EDMA_TCD_ATTR_DSIZE_32BYTE << 8)
+
+#define EDMA_TCD_CITER_CITER(x)		((x) & GENMASK(14, 0))
+#define EDMA_TCD_BITER_BITER(x)		((x) & GENMASK(14, 0))
 
 #define EDMA_TCD_CSR_START		BIT(0)
 #define EDMA_TCD_CSR_INT_MAJOR		BIT(1)
-- 
2.18.0
