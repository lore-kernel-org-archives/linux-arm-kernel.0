From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Dec 2015 23:26:06 +0100
Subject: [PATCH 11/23] mtd: add mtd_eccpos(),
 mtd_oobfree() and mtd_eccbytes() helper functions
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449527178-5930-12-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to make the ecclayout definition completely dynamic we need to
rework the way these different ECC layouts are defined and iterated.

Create the mtd_eccpos(), mtd_oobfree() and mtd_eccbytes() helpers to hide
ecclayout definition internals to their users.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/mtd/mtd.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 9cf13c4..25e3d0f 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -253,6 +253,38 @@ struct mtd_info {
 	int usecount;
 };
 
+static inline int mtd_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	if (!mtd->ecclayout)
+		return -ENOTSUPP;
+
+	if (eccbyte >= mtd->ecclayout->eccbytes)
+		return -ERANGE;
+
+	return mtd->ecclayout->eccpos[eccbyte];
+}
+
+static inline int mtd_oobfree(struct mtd_info *mtd, int section,
+			      struct nand_oobfree *oobfree)
+{
+	memset(oobfree, 0, sizeof(*oobfree));
+
+	if (!mtd->ecclayout)
+		return -ENOTSUPP;
+
+	if (section >= MTD_MAX_OOBFREE_ENTRIES_LARGE)
+		return -ERANGE;
+
+	*oobfree = mtd->ecclayout->oobfree[section];
+
+	return 0;
+}
+
+static inline int mtd_eccbytes(struct mtd_info *mtd)
+{
+	return mtd->ecclayout ? mtd->ecclayout->eccbytes : 0;
+}
+
 static inline void mtd_set_of_node(struct mtd_info *mtd,
 				   struct device_node *np)
 {
-- 
2.1.4
