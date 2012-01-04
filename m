From: b32955@freescale.com (Huang Shijie)
Date: Wed, 4 Jan 2012 11:18:46 +0800
Subject: [PATCH v4] MTD/GPMI bugfix : reset the BCH module when it is not MX23
Message-ID: <1325647126-4281-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In MX28, if we do not reset the BCH module. The BCH module may
becomes unstable when the board reboots for several thousands times.
This bug has been catched in customer's production.

The patch adds some comments(some from Wolfram Sang), and fixes it now.

Also change gpmi_reset_block() to static.

Signed-off-by: Huang Shijie <b32955@freescale.com>
Acked-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
index de4db76..7523691 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
@@ -69,17 +69,19 @@ static int clear_poll_bit(void __iomem *addr, u32 mask)
  *  [1] enable the module.
  *  [2] reset the module.
  *
- * In most of the cases, it's ok. But there is a hardware bug in the BCH block.
+ * In most of the cases, it's ok.
+ * But in MX23, there is a hardware bug in the BCH block(see 2847 from errata).
  * If you try to soft reset the BCH block, it becomes unusable until
  * the next hard reset. This case occurs in the NAND boot mode. When the board
  * boots by NAND, the ROM of the chip will initialize the BCH blocks itself.
  * So If the driver tries to reset the BCH again, the BCH will not work anymore.
- * You will see a DMA timeout in this case.
+ * You will see a DMA timeout in this case. The bug has been fixed
+ * in the following chips, such as MX28.
  *
  * To avoid this bug, just add a new parameter `just_enable` for
  * the mxs_reset_block(), and rewrite it here.
  */
-int gpmi_reset_block(void __iomem *reset_addr, bool just_enable)
+static int gpmi_reset_block(void __iomem *reset_addr, bool just_enable)
 {
 	int ret;
 	int timeout = 0x400;
@@ -206,7 +208,15 @@ int bch_set_geometry(struct gpmi_nand_data *this)
 	if (ret)
 		goto err_out;
 
-	ret = gpmi_reset_block(r->bch_regs, true);
+	/*
+	* Due to Errata #2847 of the MX23, the BCH cannot be soft reset on this
+	* chip, otherwise it will lock up. So we skip resetting BCH on the MX23.
+	* On the other hand, the MX28 needs the reset, because one case has been
+	* seen where the BCH produced ECC errors constantly after 10000
+	* consecutive reboots. The latter case has not been seen on the MX23 yet,
+	* still we don't know if it could happen there as well.
+	*/
+	ret = gpmi_reset_block(r->bch_regs, GPMI_IS_MX23(this));
 	if (ret)
 		goto err_out;
 
-- 
1.7.0.4
