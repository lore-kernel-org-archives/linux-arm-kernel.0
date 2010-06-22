From: leiwen@marvell.com (Lei Wen)
Date: Tue, 22 Jun 2010 22:32:54 +0800
Subject: [PATCH 19/29] pxa3xx_nand: update ns2cycle calculation method
Message-ID: <mailman.135.1280296992.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the original method change from plus 1 to minus 1,
this way make the default timing like tCS become 0 after calculation,
although we set the timing as 0xa...

Change the method to no plus and minus, and make the result
closer to what the timing specified in the NAND chip spec.

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 45c9660..50f653b 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -279,7 +279,7 @@ static const char *mtd_names[] = {"pxa3xx_nand-0",
"pxa3xx_nand-1", NULL};
 #define NDTR1_tAR(c)	(min((c), 15) << 0)

 /* convert nano-seconds to nand flash controller clock cycles */
-#define ns2cycle(ns, clk)	(int)(((ns) * (clk / 1000000) / 1000) - 1)
+#define ns2cycle(ns, clk)	(int)((ns) * (clk / 1000000) / 1000)

 static void pxa3xx_nand_set_timing(struct pxa3xx_nand_info *info,
 				   const struct pxa3xx_nand_timing *t)
-- 
1.7.0.4
