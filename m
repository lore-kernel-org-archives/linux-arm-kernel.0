From: jmkrzyszt@gmail.com (Janusz Krzysztofik)
Date: Tue, 14 Aug 2018 00:34:47 +0200
Subject: [PATCH v3 6/7] mtd: rawnand: ams-delta: Simplify pointer resolution
 on read/write
In-Reply-To: <20180813223448.21316-1-jmkrzyszt@gmail.com>
References: <20180806222918.12644-1-jmkrzyszt@gmail.com>
 <20180813223448.21316-1-jmkrzyszt@gmail.com>
Message-ID: <20180813223448.21316-7-jmkrzyszt@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify data read/write sub-functions by making them accept private
structure pointer instead of resolving it again from mtd_info.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 5f9180fe4f8b..59fc417e8fa9 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -73,10 +73,9 @@ static const struct mtd_partition partition_info[] = {
 	  .size		=  3 * SZ_256K },
 };
 
-static void ams_delta_write_next_byte(struct mtd_info *mtd, u_char byte)
+static void ams_delta_write_next_byte(struct ams_delta_nand *priv, u_char byte)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
-	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	struct nand_chip *this = &priv->nand_chip;
 
 	writew(byte, this->IO_ADDR_W);
 
@@ -85,10 +84,8 @@ static void ams_delta_write_next_byte(struct mtd_info *mtd, u_char byte)
 	gpiod_set_value(priv->gpiod_nwe, 1);
 }
 
-static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
+static void ams_delta_write_byte(struct ams_delta_nand *priv, u_char byte)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
-	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	void __iomem *io_base = priv->io_base;
 
 	if (priv->data_in) {
@@ -96,13 +93,12 @@ static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
 		priv->data_in = false;
 	}
 
-	ams_delta_write_next_byte(mtd, byte);
+	ams_delta_write_next_byte(priv, byte);
 }
 
-static u_char ams_delta_read_next_byte(struct mtd_info *mtd)
+static u_char ams_delta_read_next_byte(struct ams_delta_nand *priv)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
-	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	struct nand_chip *this = &priv->nand_chip;
 	u_char res;
 
 	gpiod_set_value(priv->gpiod_nre, 0);
@@ -126,30 +122,34 @@ static u_char ams_delta_read_byte(struct mtd_info *mtd)
 		priv->data_in = true;
 	}
 
-	return ams_delta_read_next_byte(mtd);
+	return ams_delta_read_next_byte(priv);
 }
 
 static void ams_delta_write_buf(struct mtd_info *mtd, const u_char *buf,
 				int len)
 {
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	int i = 0;
 
 	if (len > 0)
-		ams_delta_write_byte(mtd, buf[i++]);
+		ams_delta_write_byte(priv, buf[i++]);
 
 	while (i < len)
-		ams_delta_write_next_byte(mtd, buf[i++]);
+		ams_delta_write_next_byte(priv, buf[i++]);
 }
 
 static void ams_delta_read_buf(struct mtd_info *mtd, u_char *buf, int len)
 {
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	int i = 0;
 
 	if (len > 0)
 		buf[i++] = ams_delta_read_byte(mtd);
 
 	while (i < len)
-		buf[i++] = ams_delta_read_next_byte(mtd);
+		buf[i++] = ams_delta_read_next_byte(priv);
 }
 
 /*
@@ -173,7 +173,7 @@ static void ams_delta_hwcontrol(struct mtd_info *mtd, int cmd,
 	}
 
 	if (cmd != NAND_CMD_NONE)
-		ams_delta_write_byte(mtd, cmd);
+		ams_delta_write_byte(priv, cmd);
 }
 
 static int ams_delta_nand_ready(struct mtd_info *mtd)
-- 
2.16.4
