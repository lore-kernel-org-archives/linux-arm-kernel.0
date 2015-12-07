From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Dec 2015 23:26:10 +0100
Subject: [PATCH 15/23] mtd: create an mtd_ooblayout_ops struct to ease ECC
 layout definition
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449527178-5930-16-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ECC layout definitions are currently exposed using the nand_ecclayout
struct which embeds oobfree and eccpos arrays with predefined size.
This approach was acceptable when the NAND were providing relatively small
OOB regions, but MLC and TLC now provide OOB regions of several hundreds
of bytes, which implies a non negigible size penalty for everybody even
those who only need to support legacy NANDs.

Create an mtd_ooblayout_ops interface providing the same functionality
(expose the ECC and OOBFREE layout) without the need for this huge
structure.

The mtd->ecclayout is now deprecated and should be replaced by the
equivalent mtd_ooblayout_ops. In the meantime we provide a wrapper around
the ->ecclayout field to ease migration to this new model.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/mtdchar.c   |  4 ++--
 drivers/mtd/mtdconcat.c |  2 +-
 drivers/mtd/mtdcore.c   | 44 ++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/mtdpart.c   | 22 +++++++++++++++++++-
 include/linux/mtd/mtd.h | 53 +++++++++++++++++++++++++++++++++----------------
 5 files changed, 104 insertions(+), 21 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 66d0898..c03b678 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -862,7 +862,7 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 	{
 		struct nand_oobinfo oi;
 
-		if (!mtd->ecclayout)
+		if (!mtd->ooblayout)
 			return -EOPNOTSUPP;
 
 		ret = get_oobinfo(mtd, &oi);
@@ -956,7 +956,7 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 	{
 		struct nand_ecclayout_user *usrlay;
 
-		if (!mtd->ecclayout)
+		if (!mtd->ooblayout)
 			return -EOPNOTSUPP;
 
 		usrlay = kmalloc(sizeof(*usrlay), GFP_KERNEL);
diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index 481565e..d573606 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -777,7 +777,7 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
 
 	}
 
-	mtd_set_ecclayout(&concat->mtd, subdev[0]->ecclayout);
+	mtd_set_ooblayout(&concat->mtd, subdev[0]->ooblayout);
 
 	concat->num_subdev = num_devs;
 	concat->mtd.name = name;
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 62f83b0..d87f3621 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -833,6 +833,50 @@ void __put_mtd_device(struct mtd_info *mtd)
 }
 EXPORT_SYMBOL_GPL(__put_mtd_device);
 
+static int nand_ecclayout_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	struct nand_ecclayout *layout = mtd->ecclayout;
+
+	if (!layout)
+		return -ENOTSUPP;
+
+	if (eccbyte >= layout->eccbytes)
+		return -ERANGE;
+
+	return layout->eccpos[eccbyte];
+}
+
+static int nand_ecclayout_oobfree(struct mtd_info *mtd, int section,
+				  struct nand_oobfree *oobfree)
+{
+	struct nand_ecclayout *layout = mtd->ecclayout;
+
+	if (!layout)
+		return -ENOTSUPP;
+
+	if (section >= MTD_MAX_OOBFREE_ENTRIES_LARGE)
+		return -ERANGE;
+
+	*oobfree = layout->oobfree[section];
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops nand_ecclayout_ops = {
+	.eccpos = nand_ecclayout_eccpos,
+	.oobfree = nand_ecclayout_oobfree,
+};
+
+void mtd_set_ecclayout(struct mtd_info *mtd, struct nand_ecclayout *ecclayout)
+{
+	if (!mtd || !ecclayout)
+		return;
+
+	mtd->ecclayout = ecclayout;
+	mtd_set_ooblayout(mtd, &nand_ecclayout_ops);
+}
+EXPORT_SYMBOL_GPL(mtd_set_ecclayout);
+
 /*
  * Erase is an asynchronous operation.  Device drivers are supposed
  * to call instr->callback() whenever the operation completes, even
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 244faa8..2b5c8ca 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -320,6 +320,26 @@ static int part_block_markbad(struct mtd_info *mtd, loff_t ofs)
 	return res;
 }
 
+static int part_ooblayout_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	struct mtd_part *part = mtd_to_part(mtd);
+
+	return mtd_eccpos(part->master, eccbyte);
+}
+
+static int part_ooblayout_oobfree(struct mtd_info *mtd, int section,
+				  struct nand_oobfree *oobfree)
+{
+	struct mtd_part *part = mtd_to_part(mtd);
+
+	return mtd_oobfree(part->master, section, oobfree);
+}
+
+static const struct mtd_ooblayout_ops part_ooblayout_ops = {
+	.eccpos = part_ooblayout_eccpos,
+	.oobfree = part_ooblayout_oobfree,
+};
+
 static inline void free_partition(struct mtd_part *p)
 {
 	kfree(p->mtd.name);
@@ -536,7 +556,7 @@ static struct mtd_part *allocate_partition(struct mtd_info *master,
 			part->name);
 	}
 
-	mtd_set_ecclayout(&slave->mtd, master->ecclayout);
+	mtd_set_ooblayout(&slave->mtd, &part_ooblayout_ops);
 	slave->mtd.ecc_step_size = master->ecc_step_size;
 	slave->mtd.ecc_strength = master->ecc_strength;
 	slave->mtd.bitflip_threshold = master->bitflip_threshold;
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 80e32fa..9c3699b 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -101,6 +101,9 @@ struct mtd_oob_ops {
  * similar, smaller struct nand_ecclayout_user (in mtd-abi.h) that is retained
  * for export to user-space via the ECCGETLAYOUT ioctl.
  * nand_ecclayout should be expandable in the future simply by the above macros.
+ *
+ * This structure is now deprecated, you should use struct nand_ecclayout_ops
+ * to describe your OOB layout.
  */
 struct nand_ecclayout {
 	__u32 eccbytes;
@@ -108,6 +111,20 @@ struct nand_ecclayout {
 	struct nand_oobfree oobfree[MTD_MAX_OOBFREE_ENTRIES_LARGE];
 };
 
+/**
+ * struct mtd_ooblayout_ops - NAND OOB layout operations.
+ *
+ * @eccpos: function returning the position of an ECC byte. Should return
+ *	    -ERANGE if %eccbyte exceed the number of ECC bytes.
+ * @oobfree: function returning an oobfree section. Should return -ERANGE
+ *	     if %section exceed the total number of oobfree sections.
+ */
+struct mtd_ooblayout_ops {
+	int (*eccpos)(struct mtd_info *mtd, int eccbyte);
+	int (*oobfree)(struct mtd_info *mtd, int section,
+		       struct nand_oobfree *oobfree);
+};
+
 struct module;	/* only needed for owner field in mtd_info */
 
 struct mtd_info {
@@ -166,9 +183,12 @@ struct mtd_info {
 	const char *name;
 	int index;
 
-	/* ECC layout structure pointer - read only! */
+	/* [Deprecated] ECC layout structure pointer - read only! */
 	struct nand_ecclayout *ecclayout;
 
+	/* OOB layout description */
+	const struct mtd_ooblayout_ops *ooblayout;
+
 	/* the ecc step size. */
 	unsigned int ecc_step_size;
 
@@ -253,21 +273,20 @@ struct mtd_info {
 	int usecount;
 };
 
-static inline void mtd_set_ecclayout(struct mtd_info *mtd,
-				     struct nand_ecclayout *ecclayout)
+static inline void mtd_set_ooblayout(struct mtd_info *mtd,
+				     const struct mtd_ooblayout_ops *ooblayout)
 {
-	mtd->ecclayout = ecclayout;
+	mtd->ooblayout = ooblayout;
 }
 
+void mtd_set_ecclayout(struct mtd_info *mtd, struct nand_ecclayout *ecclayout);
+
 static inline int mtd_eccpos(struct mtd_info *mtd, int eccbyte)
 {
-	if (!mtd->ecclayout)
+	if (!mtd->ooblayout || !mtd->ooblayout->eccpos)
 		return -ENOTSUPP;
 
-	if (eccbyte >= mtd->ecclayout->eccbytes)
-		return -ERANGE;
-
-	return mtd->ecclayout->eccpos[eccbyte];
+	return mtd->ooblayout->eccpos(mtd, eccbyte);
 }
 
 static inline int mtd_oobfree(struct mtd_info *mtd, int section,
@@ -275,20 +294,20 @@ static inline int mtd_oobfree(struct mtd_info *mtd, int section,
 {
 	memset(oobfree, 0, sizeof(*oobfree));
 
-	if (!mtd->ecclayout)
+	if (!mtd->ooblayout || !mtd->ooblayout->oobfree)
 		return -ENOTSUPP;
 
-	if (section >= MTD_MAX_OOBFREE_ENTRIES_LARGE)
-		return -ERANGE;
-
-	*oobfree = mtd->ecclayout->oobfree[section];
-
-	return 0;
+	return mtd->ooblayout->oobfree(mtd, section, oobfree);
 }
 
 static inline int mtd_eccbytes(struct mtd_info *mtd)
 {
-	return mtd->ecclayout ? mtd->ecclayout->eccbytes : 0;
+	int eccbytes;
+
+	for (eccbytes = 0; mtd_eccpos(mtd, eccbytes) >= 0; eccbytes++)
+		;
+
+	return eccbytes;
 }
 
 static inline void mtd_set_of_node(struct mtd_info *mtd,
-- 
2.1.4
