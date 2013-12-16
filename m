From: b32955@freescale.com (Huang Shijie)
Date: Mon, 16 Dec 2013 16:58:48 +0800
Subject: [PATCH v3 5/7] mtd: spi-nor: add a helper to find the spi_device_id
In-Reply-To: <1387184330-14448-1-git-send-email-b32955@freescale.com>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com>
Message-ID: <1387184330-14448-6-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the spi_nor_match_id() to find the proper spi_device_id
in the spi_nor_ids table.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/spi-nor/spi-nor.c |   12 ++++++++++++
 include/linux/mtd/spi-nor.h   |    1 +
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index eb72bce..268d019 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1081,6 +1081,18 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
 	return 0;
 }
 
+const struct spi_device_id * spi_nor_match_id(char *name)
+{
+	const struct spi_device_id *id = spi_nor_ids;
+
+	while (id->name[0]) {
+		if (!strcmp(name, id->name))
+			return id;
+		id++;
+	}
+	return NULL;
+}
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Freescale Semiconductor Inc.");
 MODULE_DESCRIPTION("framework for SPI NOR nor");
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index a0c2a8b..7ed66d1 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -162,5 +162,6 @@ struct spi_nor {
 int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
 			enum read_mode mode);
 extern const struct spi_device_id spi_nor_ids[];
+const struct spi_device_id * spi_nor_match_id(char *name);
 
 #endif
-- 
1.7.2.rc3
