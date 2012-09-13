From: b32955@freescale.com (Huang Shijie)
Date: Thu, 13 Sep 2012 14:57:56 +0800
Subject: [PATCH v2 5/9] mtd: gpmi: add a new field for HW_GPMI_CTRL1
In-Reply-To: <1347519480-31106-1-git-send-email-b32955@freescale.com>
References: <1347519480-31106-1-git-send-email-b32955@freescale.com>
Message-ID: <1347519480-31106-6-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add the WRN_DLY_SEL field for HW_GPMI_CTRL1.
This field is used as delay for gpmi write strobe.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c  |    6 ++++++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |    2 ++
 drivers/mtd/nand/gpmi-nand/gpmi-regs.h |    9 +++++++++
 3 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
index 41e905d..2d1f77c 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
@@ -731,6 +731,7 @@ return_results:
 	hw->use_half_periods        = dll_use_half_periods;
 	hw->sample_delay_factor     = sample_delay_factor;
 	hw->device_busy_timeout     = GPMI_DEFAULT_BUSY_TIMEOUT;
+	hw->wrn_dly_sel             = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS;
 
 	/* Return success. */
 	return 0;
@@ -769,6 +770,11 @@ void gpmi_begin(struct gpmi_nand_data *this)
 
 	/* [3] The following code is to set the HW_GPMI_CTRL1. */
 
+	/* Set the WRN_DLY_SEL */
+	writel(BM_GPMI_CTRL1_WRN_DLY_SEL, gpmi_regs + HW_GPMI_CTRL1_CLR);
+	writel(BF_GPMI_CTRL1_WRN_DLY_SEL(hw.wrn_dly_sel),
+					gpmi_regs + HW_GPMI_CTRL1_SET);
+
 	/* DLL_ENABLE must be set to 0 when setting RDN_DELAY or HALF_PERIOD. */
 	writel(BM_GPMI_CTRL1_DLL_ENABLE, gpmi_regs + HW_GPMI_CTRL1_CLR);
 
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
index c814bdd..5c11e76 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
@@ -195,6 +195,7 @@ struct gpmi_nand_data {
  * @use_half_periods:          Indicates the clock is running slowly, so the
  *                             NFC DLL should use half-periods.
  * @sample_delay_factor:       The sample delay factor.
+ * @wrn_dly_sel:               The delay on the GPMI write strobe.
  */
 struct gpmi_nfc_hardware_timing {
 	/* for HW_GPMI_TIMING0 */
@@ -209,6 +210,7 @@ struct gpmi_nfc_hardware_timing {
 	/* for HW_GPMI_CTRL1 */
 	bool     use_half_periods;
 	uint8_t  sample_delay_factor;
+	uint8_t  wrn_dly_sel;
 };
 
 /**
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-regs.h b/drivers/mtd/nand/gpmi-nand/gpmi-regs.h
index 8994e20..53397cc 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-regs.h
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-regs.h
@@ -108,6 +108,15 @@
 #define HW_GPMI_CTRL1_CLR				0x00000068
 #define HW_GPMI_CTRL1_TOG				0x0000006c
 
+#define BP_GPMI_CTRL1_WRN_DLY_SEL			22
+#define BM_GPMI_CTRL1_WRN_DLY_SEL	(0x3 << BP_GPMI_CTRL1_WRN_DLY_SEL)
+#define BF_GPMI_CTRL1_WRN_DLY_SEL(v)  \
+	(((v) << BP_GPMI_CTRL1_WRN_DLY_SEL) & BM_GPMI_CTRL1_WRN_DLY_SEL)
+#define BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS		0x0
+#define BV_GPMI_CTRL1_WRN_DLY_SEL_6_TO_10NS		0x1
+#define BV_GPMI_CTRL1_WRN_DLY_SEL_7_TO_12NS		0x2
+#define BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY		0x3
+
 #define BM_GPMI_CTRL1_BCH_MODE				(1 << 18)
 
 #define BP_GPMI_CTRL1_DLL_ENABLE			17
-- 
1.7.0.4
