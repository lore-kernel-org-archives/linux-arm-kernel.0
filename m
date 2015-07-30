From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 30 Jul 2015 15:50:21 +0200
Subject: [RFC PATCH 2/6] mtd: part: pass OF node to the MTD partition layer
In-Reply-To: <1438264225-23796-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1438264225-23796-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1438264225-23796-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass the OF node attached an MTD partition so that specific MTD device
implementations can extract extra information from the DT definition.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/mtdpart.c          | 2 ++
 drivers/mtd/ofpart.c           | 1 +
 include/linux/mtd/partitions.h | 3 ++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 9a45230..c2e5920 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -362,6 +362,8 @@ static struct mtd_part *allocate_partition(struct mtd_info *master,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	slave->mtd.dev.of_node = part->of_node;
+
 	/* set up the MTD object for this partition */
 	slave->mtd.type = master->type;
 	slave->mtd.flags = master->flags & ~part->mask_flags;
diff --git a/drivers/mtd/ofpart.c b/drivers/mtd/ofpart.c
index aa26c32..8a06cfb 100644
--- a/drivers/mtd/ofpart.c
+++ b/drivers/mtd/ofpart.c
@@ -73,6 +73,7 @@ static int parse_ofpart_partitions(struct mtd_info *master,
 			continue;
 		}
 
+		(*pparts)[i].of_node = pp;
 		a_cells = of_n_addr_cells(pp);
 		s_cells = of_n_size_cells(pp);
 		(*pparts)[i].offset = of_read_number(reg, a_cells);
diff --git a/include/linux/mtd/partitions.h b/include/linux/mtd/partitions.h
index 6a35e6d..e4ff8a3 100644
--- a/include/linux/mtd/partitions.h
+++ b/include/linux/mtd/partitions.h
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 
 
+
 /*
  * Partition definition structure:
  *
@@ -42,6 +43,7 @@ struct mtd_partition {
 	uint64_t offset;		/* offset within the master MTD space */
 	uint32_t mask_flags;		/* master MTD flags to mask out for this partition */
 	struct nand_ecclayout *ecclayout;	/* out of band layout for this partition (NAND only) */
+	struct device_node *of_node;	/* OF node attached to this partition (optional) */
 };
 
 #define MTDPART_OFS_RETAIN	(-3)
@@ -63,7 +65,6 @@ struct mtd_part_parser_data {
 	struct device_node *of_node;
 };
 
-
 /*
  * Functions dealing with the various ways of partitioning the space
  */
-- 
1.9.1
