From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 23 Apr 2010 10:43:42 +0200
Subject: [PATCH] pxa32xx_nand: add support for partition table parsing
Message-ID: <mailman.316.1272057985.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pxa32xx_nand driver doesn't support partition tables from the
command line. This patch adds support for it.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/mtd/nand/pxa3xx_nand.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 5d55152..e02fa4f 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1320,6 +1320,17 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
 		goto fail_free_irq;
 	}
 
+	if (mtd_has_cmdlinepart()) {
+		static const char *probes[] = { "cmdlinepart", NULL };
+		struct mtd_partition *parts;
+		int nr_parts;
+
+		nr_parts = parse_mtd_partitions(mtd, probes, &parts, 0);
+
+		if (nr_parts)
+			return add_mtd_partitions(mtd, parts, nr_parts);
+	}
+
 	return add_mtd_partitions(mtd, pdata->parts, pdata->nr_parts);
 
 fail_free_irq:
-- 
1.7.0.4
