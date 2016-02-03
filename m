From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Wed, 3 Feb 2016 14:26:52 +0100
Subject: [PATCH v3 07/14] mtd: spi-nor: fix support of Spansion memories
In-Reply-To: <cover.1454505161.git.cyrille.pitchen@atmel.com>
References: <cover.1454505161.git.cyrille.pitchen@atmel.com>
Message-ID: <d7107bc2337e353c553cb88119d6f8d47575dc43.1454505161.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is only a transitional one. It concludes the series of patches
to select op codes and protocols by manufacturer.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 53 ++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 6785e699106d..f9dd1fd3f53c 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1439,10 +1439,35 @@ static int micron_set_single_mode(struct spi_nor *nor)
 	return 0;
 }
 
-static int set_quad_mode(struct spi_nor *nor, const struct flash_info *info)
+static int spansion_set_quad_mode(struct spi_nor *nor)
 {
 	int status;
 
+	status = spansion_quad_enable(nor);
+	if (status) {
+		dev_err(nor->dev, "Spansion quad-read not enabled\n");
+		return -EINVAL;
+	}
+	nor->read_proto = SNOR_PROTO_1_1_4;
+	nor->read_opcode = SPINOR_OP_READ_1_1_4;
+	return 0;
+}
+
+static int spansion_set_dual_mode(struct spi_nor *nor)
+{
+	nor->read_proto = SNOR_PROTO_1_1_2;
+	nor->read_opcode = SPINOR_OP_READ_1_1_2;
+	return 0;
+}
+
+static int spansion_set_single_mode(struct spi_nor *nor)
+{
+	nor->read_proto = SNOR_PROTO_1_1_1;
+	return 0;
+}
+
+static int set_quad_mode(struct spi_nor *nor, const struct flash_info *info)
+{
 	switch (JEDEC_MFR(info)) {
 	case SNOR_MFR_MACRONIX:
 		return macronix_set_quad_mode(nor);
@@ -1454,20 +1479,13 @@ static int set_quad_mode(struct spi_nor *nor, const struct flash_info *info)
 		return micron_set_quad_mode(nor);
 
 	case SNOR_MFR_SPANSION:
-		status = spansion_quad_enable(nor);
-		if (status) {
-			dev_err(nor->dev, "Spansion quad-read not enabled\n");
-			return -EINVAL;
-		}
-		nor->read_proto = SNOR_PROTO_1_1_4;
-		break;
+		return spansion_set_quad_mode(nor);
 
 	default:
-		return -EINVAL;
+		break;
 	}
 
-	nor->read_opcode = SPINOR_OP_READ_1_1_4;
-	return 0;
+	return -EINVAL;
 }
 
 static int set_dual_mode(struct spi_nor *nor, const struct flash_info *info)
@@ -1482,13 +1500,14 @@ static int set_dual_mode(struct spi_nor *nor, const struct flash_info *info)
 	case SNOR_MFR_MICRON:
 		return micron_set_dual_mode(nor);
 
+	case SNOR_MFR_SPANSION:
+		return spansion_set_dual_mode(nor);
+
 	default:
-		nor->read_proto = SNOR_PROTO_1_1_2;
 		break;
 	}
 
-	nor->read_opcode = SPINOR_OP_READ_1_1_2;
-	return 0;
+	return -EINVAL;
 }
 
 static int set_single_mode(struct spi_nor *nor, const struct flash_info *info)
@@ -1503,12 +1522,14 @@ static int set_single_mode(struct spi_nor *nor, const struct flash_info *info)
 	case SNOR_MFR_MICRON:
 		return micron_set_single_mode(nor);
 
+	case SNOR_MFR_SPANSION:
+		return spansion_set_single_mode(nor);
+
 	default:
-		nor->read_proto = SNOR_PROTO_1_1_1;
 		break;
 	}
 
-	return 0;
+	return -EINVAL;
 }
 
 static int spi_nor_check(struct spi_nor *nor)
-- 
1.8.2.2
