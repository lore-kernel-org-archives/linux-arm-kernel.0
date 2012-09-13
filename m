From: b32955@freescale.com (Huang Shijie)
Date: Thu, 13 Sep 2012 14:57:53 +0800
Subject: [PATCH v2 2/9] mtd: add helpers to get the supportted ONFI timing mode
In-Reply-To: <1347519480-31106-1-git-send-email-b32955@freescale.com>
References: <1347519480-31106-1-git-send-email-b32955@freescale.com>
Message-ID: <1347519480-31106-3-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add onfi_get_async_timing_mode() to get the supportted asynchronous
timing mode.

add onfi_get_sync_timing_mode() to get the supportted synchronous
timing mode.

Also add the neccessary macros : the timing modes.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 include/linux/mtd/nand.h |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 537f59c..7a7b246 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -231,6 +231,15 @@ typedef enum {
 /* Keep gcc happy */
 struct nand_chip;
 
+/* ONFI timing mode, used in both asynchronous and synchronous mode */
+#define ONFI_TIMING_MODE_0		(1 << 0)
+#define ONFI_TIMING_MODE_1		(1 << 1)
+#define ONFI_TIMING_MODE_2		(1 << 2)
+#define ONFI_TIMING_MODE_3		(1 << 3)
+#define ONFI_TIMING_MODE_4		(1 << 4)
+#define ONFI_TIMING_MODE_5		(1 << 5)
+#define ONFI_TIMING_MODE_UNKNOWN	(1 << 6)
+
 /* ONFI feature address */
 #define ONFI_FEATURE_ADDR_TIMING_MODE	0x1
 
@@ -682,4 +691,20 @@ struct platform_nand_chip *get_platform_nandchip(struct mtd_info *mtd)
 	return chip->priv;
 }
 
+/* return the supported asynchronous timing mode. */
+static inline int onfi_get_async_timing_mode(struct nand_chip *chip)
+{
+	if (!chip->onfi_version)
+		return ONFI_TIMING_MODE_UNKNOWN;
+	return le16_to_cpu(chip->onfi_params.async_timing_mode);
+}
+
+/* return the supported synchronous timing mode. */
+static inline int onfi_get_sync_timing_mode(struct nand_chip *chip)
+{
+	if (!chip->onfi_version)
+		return ONFI_TIMING_MODE_UNKNOWN;
+	return le16_to_cpu(chip->onfi_params.src_sync_timing_mode);
+}
+
 #endif /* __LINUX_MTD_NAND_H */
-- 
1.7.0.4
