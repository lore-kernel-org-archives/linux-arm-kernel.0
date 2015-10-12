From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 12 Oct 2015 18:00:54 +0200
Subject: [PATCH v3.1 1/7] mmc: core: move ocr-bit to voltage translation into
 separate function
In-Reply-To: <1444654110-32293-2-git-send-email-heiko@sntech.de>
References: <1444654110-32293-1-git-send-email-heiko@sntech.de>
 <1444654110-32293-2-git-send-email-heiko@sntech.de>
Message-ID: <3818140.syp6fUkzM7@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We will shortly need the calculation of an ocr-bit to the actual
voltage in a second place too, so move it from mmc_regulator_set_ocr
to a common function mmc_ocrbitnum_to_vdd to make that possible.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
changes since v3:
- move mmc_ocrbitnum_to_vdd under the CONFIG_REGULATOR ifdef
  Both the current as well as the new user in the followup patch are
  limited to CONFIG_REGULATOR, so limit this new function as well.

I saw the mistake after Doug thankfully pointed out the CONFIG_REGULATOR issue.

 drivers/mmc/core/core.c | 51 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0520064..d3ffc49 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1339,6 +1339,40 @@ struct device_node *mmc_of_find_child_device(struct mmc_host *host,
 #ifdef CONFIG_REGULATOR
 
 /**
+ * mmc_ocrbitnum_to_vdd - Convert a OCR bit number to its voltage
+ * @vdd_bit:	OCR bit number
+ * @min_uV:	minimum voltage value (mV)
+ * @max_uV:	maximum voltage value (mV)
+ *
+ * This function returns the voltage range according to the provided OCR
+ * bit number. If conversion is not possible a negative errno value returned.
+ */
+static int mmc_ocrbitnum_to_vdd(int vdd_bit, int *min_uV, int *max_uV)
+{
+	int		tmp;
+
+	if (!vdd_bit)
+		return -EINVAL;
+
+	/*
+	 * REVISIT mmc_vddrange_to_ocrmask() may have set some
+	 * bits this regulator doesn't quite support ... don't
+	 * be too picky, most cards and regulators are OK with
+	 * a 0.1V range goof (it's a small error percentage).
+	 */
+	tmp = vdd_bit - ilog2(MMC_VDD_165_195);
+	if (tmp == 0) {
+		*min_uV = 1650 * 1000;
+		*max_uV = 1950 * 1000;
+	} else {
+		*min_uV = 1900 * 1000 + tmp * 100 * 1000;
+		*max_uV = *min_uV + 100 * 1000;
+	}
+
+	return 0;
+}
+
+/**
  * mmc_regulator_get_ocrmask - return mask of supported voltages
  * @supply: regulator to use
  *
@@ -1401,22 +1435,7 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 	int			min_uV, max_uV;
 
 	if (vdd_bit) {
-		int		tmp;
-
-		/*
-		 * REVISIT mmc_vddrange_to_ocrmask() may have set some
-		 * bits this regulator doesn't quite support ... don't
-		 * be too picky, most cards and regulators are OK with
-		 * a 0.1V range goof (it's a small error percentage).
-		 */
-		tmp = vdd_bit - ilog2(MMC_VDD_165_195);
-		if (tmp == 0) {
-			min_uV = 1650 * 1000;
-			max_uV = 1950 * 1000;
-		} else {
-			min_uV = 1900 * 1000 + tmp * 100 * 1000;
-			max_uV = min_uV + 100 * 1000;
-		}
+		mmc_ocrbitnum_to_vdd(vdd_bit, &min_uV, &max_uV);
 
 		result = regulator_set_voltage(supply, min_uV, max_uV);
 		if (result == 0 && !mmc->regulator_enabled) {
-- 
2.6.1
