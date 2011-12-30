From: b32955@freescale.com (Huang Shijie)
Date: Fri, 30 Dec 2011 16:27:26 +0800
Subject: [PATCH v2] MTD/GPMI bugfix : reset the BCH module when it is not MX23
Message-ID: <1325233646-3343-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In MX28, if we do not reset the BCH module. The BCH module may
becomes unstable when the board reboots for several thousands times.
This bug has been catched in customer's production.

The patch adds some comments, and fixes it now.

Also change gpmi_reset_block() to static.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
index de4db76..1573e99 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
@@ -69,7 +69,8 @@ static int clear_poll_bit(void __iomem *addr, u32 mask)
  *  [1] enable the module.
  *  [2] reset the module.
  *
- * In most of the cases, it's ok. But there is a hardware bug in the BCH block.
+ * In most of the cases, it's ok.
+ * But in MX23, there is a hardware bug in the BCH block.
  * If you try to soft reset the BCH block, it becomes unusable until
  * the next hard reset. This case occurs in the NAND boot mode. When the board
  * boots by NAND, the ROM of the chip will initialize the BCH blocks itself.
@@ -78,8 +79,10 @@ static int clear_poll_bit(void __iomem *addr, u32 mask)
  *
  * To avoid this bug, just add a new parameter `just_enable` for
  * the mxs_reset_block(), and rewrite it here.
+ *
+ * The bug has been fixed in the following chips, such as MX28.
  */
-int gpmi_reset_block(void __iomem *reset_addr, bool just_enable)
+static int gpmi_reset_block(void __iomem *reset_addr, bool just_enable)
 {
 	int ret;
 	int timeout = 0x400;
@@ -206,7 +209,8 @@ int bch_set_geometry(struct gpmi_nand_data *this)
 	if (ret)
 		goto err_out;
 
-	ret = gpmi_reset_block(r->bch_regs, true);
+	/* The bug only exits in mx23, the following chips fix it. */
+	ret = gpmi_reset_block(r->bch_regs, GPMI_IS_MX23(this));
 	if (ret)
 		goto err_out;
 
-- 
1.7.0.4
