From: b32955@freescale.com (Huang Shijie)
Date: Wed, 25 Dec 2013 13:50:27 +0800
Subject: [PATCH v4 5/7] mtd: spi-nor: add a helper to find the spi_device_id
In-Reply-To: <1387950629-27448-1-git-send-email-b32955@freescale.com>
References: <1387950629-27448-1-git-send-email-b32955@freescale.com>
Message-ID: <1387950629-27448-6-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the spi_nor_match_id() to find the proper spi_device_id
in the spi_nor_ids table.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/spi-nor/spi-nor.c |   12 ++++++++++++
 include/linux/mtd/spi-nor.h   |   12 ++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index de7b8d1..2254ca4 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1075,6 +1075,18 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
 	return 0;
 }
 
+const struct spi_device_id *spi_nor_match_id(char *name)
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
 MODULE_AUTHOR("Huang Shijie <shijie8@gmail.com>");
 MODULE_AUTHOR("Mike Lavender");
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 06bd096..d3c3abf 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -179,4 +179,16 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
 			enum read_mode mode);
 extern const struct spi_device_id spi_nor_ids[];
 
+/**
+ * spi_nor_match_id() - find the spi_device_id by the name
+ * @name:	the name of the spi_device_id
+ *
+ * The drivers use this function to find the spi_device_id
+ * specified by the @name.
+ *
+ * Return: returns the right spi_device_id pointer on success,
+ *         and returns NULL on failure.
+ */
+const struct spi_device_id *spi_nor_match_id(char *name);
+
 #endif
-- 
1.7.2.rc3
