From: jmkrzyszt@gmail.com (Janusz Krzysztofik)
Date: Tue,  7 Aug 2018 00:29:13 +0200
Subject: [RFC PATCH v2 07/12] mtd: rawnand: ams-delta: Set port direction once
 per transfer
In-Reply-To: <20180806222918.12644-1-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
Message-ID: <20180806222918.12644-8-jmkrzyszt@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In its current shape, the driver sets data port direction before each
byte read/write operation, even during multi-byte transfers.  Since
performance of the driver is completely not acceptable on Amstrad Delta
after it has been converted to GPIO bitbang, try to improve things a
bit by setting the port direction only on first byte of each transfer.

Resulting performance on Amstrad Delta is still far from acceptable.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 58 ++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 78996ddf82e0..d02c48c013e8 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -69,6 +69,30 @@ static const struct mtd_partition partition_info[] = {
 	  .size		=  3 * SZ_256K },
 };
 
+static void ams_delta_write_commit(struct ams_delta_nand *priv)
+{
+	gpiod_set_value(priv->gpiod_nwe, 0);
+	ndelay(40);
+	gpiod_set_value(priv->gpiod_nwe, 1);
+}
+
+static void ams_delta_write_next_byte(struct mtd_info *mtd, u_char byte)
+{
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	struct gpio_descs *data_gpiods = priv->data_gpiods;
+	unsigned long bits = byte;
+	int i, value_array[data_gpiods->ndescs];
+
+	for (i = 0; i < data_gpiods->ndescs; i++)
+		value_array[i] = test_bit(i, &bits);
+
+	gpiod_set_raw_array_value(data_gpiods->ndescs, data_gpiods->desc,
+				  value_array);
+
+	ams_delta_write_commit(priv);
+}
+
 static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
@@ -81,12 +105,10 @@ static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
 		gpiod_direction_output_raw(data_gpiods->desc[i],
 					   test_bit(i, &bits));
 
-	gpiod_set_value(priv->gpiod_nwe, 0);
-	ndelay(40);
-	gpiod_set_value(priv->gpiod_nwe, 1);
+	ams_delta_write_commit(priv);
 }
 
-static u_char ams_delta_read_byte(struct mtd_info *mtd)
+static u_char ams_delta_read_next_byte(struct mtd_info *mtd)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
 	struct ams_delta_nand *priv = nand_get_controller_data(this);
@@ -94,9 +116,6 @@ static u_char ams_delta_read_byte(struct mtd_info *mtd)
 	unsigned long bits = 0;
 	int i, value_array[data_gpiods->ndescs];
 
-	for (i = 0; i < data_gpiods->ndescs; i++)
-		gpiod_direction_input(data_gpiods->desc[i]);
-
 	gpiod_set_value(priv->gpiod_nre, 0);
 	ndelay(40);
 
@@ -112,21 +131,38 @@ static u_char ams_delta_read_byte(struct mtd_info *mtd)
 	return bits;
 }
 
+static u_char ams_delta_read_byte(struct mtd_info *mtd)
+{
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	struct gpio_descs *data_gpiods = priv->data_gpiods;
+	int i;
+
+	for (i = 0; i < data_gpiods->ndescs; i++)
+		gpiod_direction_input(data_gpiods->desc[i]);
+
+	return ams_delta_read_next_byte(mtd);
+}
+
 static void ams_delta_write_buf(struct mtd_info *mtd, const u_char *buf,
 				int len)
 {
 	int i;
 
-	for (i=0; i<len; i++)
-		ams_delta_write_byte(mtd, buf[i]);
+	if (len > 0)
+		ams_delta_write_byte(mtd, buf[0]);
+	for (i = 1; i < len; i++)
+		ams_delta_write_next_byte(mtd, buf[i]);
 }
 
 static void ams_delta_read_buf(struct mtd_info *mtd, u_char *buf, int len)
 {
 	int i;
 
-	for (i=0; i<len; i++)
-		buf[i] = ams_delta_read_byte(mtd);
+	if (len > 0)
+		buf[0] = ams_delta_read_byte(mtd);
+	for (i = 1; i < len; i++)
+		buf[i] = ams_delta_read_next_byte(mtd);
 }
 
 /*
-- 
2.16.4
