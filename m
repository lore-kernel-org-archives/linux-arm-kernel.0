From: b32955@freescale.com (Huang Shijie)
Date: Tue, 29 Jan 2013 09:23:38 +0800
Subject: [PATCH v2] mtd: gpmi: add sanity check for the ECC
In-Reply-To: <1359093848-22301-2-git-send-email-b32955@freescale.com>
References: <1359093848-22301-2-git-send-email-b32955@freescale.com>
Message-ID: <1359422618-7185-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We do the check based on the following two facts:

[1] The mx23/mx28 can only support 20-bits ECC, while the mx6
    can supports 40-bits ECC.

[2] The mx23/mx28 can only support the GF13, while the mx6
    can supports GF13 and GF14.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
v1 --> v2:
     [1] add the Golois Field check.
     [2] change the comments.

---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |   28 ++++++++++++++++++++++++++--
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |    4 ++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 2521678..717881a 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -94,6 +94,25 @@ static inline int get_ecc_strength(struct gpmi_nand_data *this)
 	return round_down(ecc_strength, 2);
 }
 
+static inline bool gpmi_check_ecc(struct gpmi_nand_data *this)
+{
+	struct bch_geometry *geo = &this->bch_geometry;
+
+	/* Do the sanity check. */
+	if (GPMI_IS_MX23(this) || GPMI_IS_MX28(this)) {
+		/* The mx23/mx28 only support the GF13. */
+		if (geo->gf_len == 14)
+			return false;
+
+		if (geo->ecc_strength > MXS_ECC_STRENGTH_MAX)
+			return false;
+	} else if (GPMI_IS_MX6Q(this)) {
+		if (geo->ecc_strength > MX6_ECC_STRENGTH_MAX)
+			return false;
+	}
+	return true;
+}
+
 int common_nfc_set_geometry(struct gpmi_nand_data *this)
 {
 	struct bch_geometry *geo = &this->bch_geometry;
@@ -123,8 +142,13 @@ int common_nfc_set_geometry(struct gpmi_nand_data *this)
 
 	/* We use the same ECC strength for all chunks. */
 	geo->ecc_strength = get_ecc_strength(this);
-	if (!geo->ecc_strength) {
-		pr_err("wrong ECC strength.\n");
+	if (!gpmi_check_ecc(this)) {
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
