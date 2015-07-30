From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 30 Jul 2015 15:50:20 +0200
Subject: [RFC PATCH 1/6] mtd: allow device-specific partition handling
In-Reply-To: <1438264225-23796-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1438264225-23796-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1438264225-23796-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, only the mtdpart implementation is allowed to expose MTD device
partitions, but some devices might need specific handling for special
partitions.
This is particularly true for systems where the NAND device is used as a
boot media. On such systems, the ROM code only support a subset of ECC
modes, and this subset may not match the chip requirements. In this
particular case we only have two options:
- force the whole chip to use one of the ECC mode supported by the ROM code
- allow for per-partition ECC setting
The first solution should be avoided if the ECC setting used by the ROM
code are weaker than the NAND requirements, hence

Add a generic way to overload the default partition handling so that
MTD drivers (or sub-frameworks) can implement their own methods.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/mtdpart.c   | 24 ++++++++++++++++--------
 include/linux/mtd/mtd.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 3dc479f..9a45230 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -38,14 +38,6 @@
 static LIST_HEAD(mtd_partitions);
 static DEFINE_MUTEX(mtd_partitions_mutex);
 
-/* Our partition node structure */
-struct mtd_part {
-	struct mtd_info mtd;
-	struct mtd_info *master;
-	uint64_t offset;
-	struct list_head list;
-};
-
 /*
  * Given a pointer to the MTD object in the mtd_part structure, we can retrieve
  * the pointer to that structure with this macro.
@@ -319,6 +311,9 @@ static int part_block_markbad(struct mtd_info *mtd, loff_t ofs)
 
 static inline void free_partition(struct mtd_part *p)
 {
+	if (p->master->part_ops && p->master->part_ops->remove)
+		p->master->part_ops->remove(p);
+
 	kfree(p->mtd.name);
 	kfree(p);
 }
@@ -551,6 +546,19 @@ static struct mtd_part *allocate_partition(struct mtd_info *master,
 		}
 	}
 
+	if (master->part_ops && master->part_ops->add) {
+		int ret;
+
+		ret = master->part_ops->add(slave);
+		if (ret) {
+			pr_err("error %d while creating partitions for \"%s\"\n",
+			       ret, master->name);
+			kfree(name);
+			kfree(slave);
+			return ERR_PTR(ret);
+		}
+	}
+
 out_register:
 	return slave;
 }
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index f17fa75..17f8688 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -111,6 +111,8 @@ struct nand_ecclayout {
 
 struct module;	/* only needed for owner field in mtd_info */
 
+struct mtd_part_ops;
+
 struct mtd_info {
 	u_char type;
 	uint32_t flags;
@@ -235,6 +237,8 @@ struct mtd_info {
 	int (*_get_device) (struct mtd_info *mtd);
 	void (*_put_device) (struct mtd_info *mtd);
 
+	const struct mtd_part_ops *part_ops;
+
 	/* Backing device capabilities for this device
 	 * - provides mmap capabilities
 	 */
@@ -254,6 +258,47 @@ struct mtd_info {
 	int usecount;
 };
 
+/**
+ * struct mtd_part - MTD partition structure
+ * @mtd:	MTD partition device
+ * @master:	MTD master device
+ * @offset:	start offset
+ * @list:	list node
+ */
+struct mtd_part {
+	struct mtd_info mtd;
+	struct mtd_info *master;
+	uint64_t offset;
+	struct list_head list;
+};
+
+static inline struct mtd_part *mtd_to_part(struct mtd_info *mtd)
+{
+	return container_of(mtd, struct mtd_part, mtd);
+}
+
+static inline void *mtd_part_get_priv(struct mtd_part *part)
+{
+	return part->mtd.priv;
+}
+
+static inline void mtd_part_set_priv(struct mtd_part *part, void *priv)
+{
+	part->mtd.priv = priv;
+}
+
+/**
+ * struct mtd_part_ops - MTD partition operations
+ * @add: add a new MTD partition and instantiate the associated data.
+ *	 You should overload the MTD callbacks if you want a specific
+ *	 behavior.
+ * @remove: remove an existing MTD partition
+ */
+struct mtd_part_ops {
+	int (*add)(struct mtd_part *part);
+	void (*remove)(struct mtd_part *part);
+};
+
 int mtd_erase(struct mtd_info *mtd, struct erase_info *instr);
 int mtd_point(struct mtd_info *mtd, loff_t from, size_t len, size_t *retlen,
 	      void **virt, resource_size_t *phys);
-- 
1.9.1
