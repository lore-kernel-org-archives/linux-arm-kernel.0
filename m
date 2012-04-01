From: shijie8@gmail.com (Huang Shijie)
Date: Sat, 31 Mar 2012 22:36:57 -0400
Subject: [PATCH] mtd/gpmi : do not include the mxs.h
Message-ID: <1333247817-18472-1-git-send-email-shijie8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxs.h does not exit in the mx6q.
So rewrite the __mxs_clrl()/__mxs_setl() and remove the mxs.h.

Signed-off-by: Huang Shijie <shijie8@gmail.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
index 85e6071..649d459 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
@@ -21,7 +21,6 @@
 #include <linux/mtd/gpmi-nand.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
-#include <mach/mxs.h>
 
 #include "gpmi-nand.h"
 #include "gpmi-regs.h"
@@ -37,6 +36,8 @@ struct timing_threshod timing_default_threshold = {
 	.max_dll_delay_in_ns         = 16,
 };
 
+#define MXS_SET_ADDR		0x4
+#define MXS_CLR_ADDR		0x8
 /*
  * Clear the bit and poll it cleared.  This is usually called with
  * a reset address and mask being either SFTRST(bit 31) or CLKGATE
@@ -47,7 +48,7 @@ static int clear_poll_bit(void __iomem *addr, u32 mask)
 	int timeout = 0x400;
 
 	/* clear the bit */
-	__mxs_clrl(mask, addr);
+	writel(mask, addr + MXS_CLR_ADDR);
 
 	/*
 	 * SFTRST needs 3 GPMI clocks to settle, the reference manual
@@ -92,11 +93,11 @@ static int gpmi_reset_block(void __iomem *reset_addr, bool just_enable)
 		goto error;
 
 	/* clear CLKGATE */
-	__mxs_clrl(MODULE_CLKGATE, reset_addr);
+	writel(MODULE_CLKGATE, reset_addr + MXS_CLR_ADDR);
 
 	if (!just_enable) {
 		/* set SFTRST to reset the block */
-		__mxs_setl(MODULE_SFTRST, reset_addr);
+		writel(MODULE_SFTRST, reset_addr + MXS_SET_ADDR);
 		udelay(1);
 
 		/* poll CLKGATE becoming set */
-- 
1.7.4.4
