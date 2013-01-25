From: b32955@freescale.com (Huang Shijie)
Date: Fri, 25 Jan 2013 14:04:08 +0800
Subject: [PATCH 2/2] mtd: gpmi: add sanity check for the ECC strength
In-Reply-To: <1359093848-22301-1-git-send-email-b32955@freescale.com>
References: <1359093848-22301-1-git-send-email-b32955@freescale.com>
Message-ID: <1359093848-22301-2-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mx23/mx28 can only support 20-bits ECC, while the mx6
can supports 40-bits ECC.

Some new nand chips may require 40-bits ECC. So we should
add the sanity check for the ECC strength. If we can not
support this nand chip, we should quit.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |   23 +++++++++++++++++++++--
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |    4 ++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 2521678..a19c42a 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -94,6 +94,20 @@ static inline int get_ecc_strength(struct gpmi_nand_data *this)
 	return round_down(ecc_strength, 2);
 }
 
+static inline bool check_ecc_strength(struct gpmi_nand_data *this,
+				int ecc_strength)
+{
+	/* Do the sanity check. */
+	if (GPMI_IS_MX23(this) || GPMI_IS_MX28(this)) {
+		if (ecc_strength > MXS_ECC_STRENGTH_MAX)
+			return false;
+	} else if (GPMI_IS_MX6Q(this)) {
+		if (ecc_strength > MX6_ECC_STRENGTH_MAX)
+			return false;
+	}
+	return true;
+}
+
 int common_nfc_set_geometry(struct gpmi_nand_data *this)
 {
 	struct bch_geometry *geo = &this->bch_geometry;
@@ -123,8 +137,13 @@ int common_nfc_set_geometry(struct gpmi_nand_data *this)
 
 	/* We use the same ECC strength for all chunks. */
 	geo->ecc_strength = get_ecc_strength(this);
-	if (!geo->ecc_strength) {
-		pr_err("wrong ECC strength.\n");
+	if (!check_ecc_strength(this, geo->ecc_strength)) {
+		dev_err(this->dev,
+			"We can not support this nand chip."
+			" Its required ecc strength(%d) is beyond our"
+			" capability(%d).\n", geo->ecc_strength,
+			(GPMI_IS_MX6Q(this) ? MX6_ECC_STRENGTH_MAX
+					: MXS_ECC_STRENGTH_MAX));
 		return -EINVAL;
 	}
 
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
index 3d93a5e..0729477 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
@@ -284,6 +284,10 @@ extern int gpmi_read_page(struct gpmi_nand_data *,
 #define STATUS_ERASED		0xff
 #define STATUS_UNCORRECTABLE	0xfe
 
+/* BCH's bit correction capability. */
+#define MXS_ECC_STRENGTH_MAX	20	/* mx23 and mx28 */
+#define MX6_ECC_STRENGTH_MAX	40
+
 /* Use the platform_id to distinguish different Archs. */
 #define IS_MX23			0x0
 #define IS_MX28			0x1
-- 
1.7.0.4
