From: B56489@freescale.com (Yunhui Cui)
Date: Thu, 14 Apr 2016 11:50:55 +0800
Subject: [PATCH 9/9] mtd: fsl-quadspi: add multi flash chip R/W on ls2080a
In-Reply-To: <1460605855-6689-1-git-send-email-B56489@freescale.com>
References: <1460605855-6689-1-git-send-email-B56489@freescale.com>
Message-ID: <1460605855-6689-10-git-send-email-B56489@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yunhui Cui <yunhui.cui@nxp.com>

There is a hardware feature that qspi_amba_base is added
internally by SOC design on ls2080a. so memmap_phy need not
be added in driver. If memmap_phy is added, the flash A1
addr space is [0, memmap_phy] which far more than flash size.
The AMBA memory will be divided into four parts and assign to
every chipselect. Every channel will has two valid chipselects.

Signed-off-by: Yunhui Cui <yunhui.cui@nxp.com>
---
 drivers/mtd/spi-nor/fsl-quadspi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index d9f3e50..cab2829 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -728,11 +728,17 @@ static void fsl_qspi_set_map_addr(struct fsl_qspi *q)
 {
 	int nor_size = q->nor_size;
 	void __iomem *base = q->iobase;
+	u32 mem_base;
 
-	qspi_writel(q, nor_size + q->memmap_phy, base + QUADSPI_SFA1AD);
-	qspi_writel(q, nor_size * 2 + q->memmap_phy, base + QUADSPI_SFA2AD);
-	qspi_writel(q, nor_size * 3 + q->memmap_phy, base + QUADSPI_SFB1AD);
-	qspi_writel(q, nor_size * 4 + q->memmap_phy, base + QUADSPI_SFB2AD);
+	if (has_added_amba_base_internal(q))
+		mem_base = 0x0;
+	else
+		mem_base = q->memmap_phy;
+
+	qspi_writel(q, nor_size + mem_base, base + QUADSPI_SFA1AD);
+	qspi_writel(q, nor_size * 2 + mem_base, base + QUADSPI_SFA2AD);
+	qspi_writel(q, nor_size * 3 + mem_base, base + QUADSPI_SFB1AD);
+	qspi_writel(q, nor_size * 4 + mem_base, base + QUADSPI_SFB2AD);
 }
 
 /*
-- 
2.1.0.27.g96db324
