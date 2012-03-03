From: shijie8@gmail.com (Huang Shijie)
Date: Sat,  3 Mar 2012 15:40:32 -0500
Subject: [PATCH] mtd/gpmi : move the __mxs_setl()/__mxs_clrl() to gpmi-lib.c
Message-ID: <1330807232-5616-1-git-send-email-shijie8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We will meet the compiler error in mx6q, since there is no mxs.h header anymore.
So move these two helper functions to gpmi-lib.c.

Signed-off-by: Huang Shijie <shijie8@gmail.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
index 5e3c505..9a208cb 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
@@ -21,7 +21,6 @@
 #include <linux/mtd/gpmi-nand.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
-#include <mach/mxs.h>
 
 #include "gpmi-nand.h"
 #include "gpmi-regs.h"
@@ -37,6 +36,19 @@ struct timing_threshod timing_default_threshold = {
 	.max_dll_delay_in_ns         = 16,
 };
 
+#define MXS_SET_ADDR		0x4
+#define MXS_CLR_ADDR		0x8
+
+static inline void __mxs_setl(u32 mask, void __iomem *reg)
+{
+	writel(mask, reg + MXS_SET_ADDR);
+}
+
+static inline void __mxs_clrl(u32 mask, void __iomem *reg)
+{
+	writel(mask, reg + MXS_CLR_ADDR);
+}
+
 /*
  * Clear the bit and poll it cleared.  This is usually called with
  * a reset address and mask being either SFTRST(bit 31) or CLKGATE
-- 
1.7.4
