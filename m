From: hramrach@gmail.com (Michal Suchanek)
Date: 3 Jun 2015 21:26:40 -0000
Subject: [PATCH 05/11] mtd: mtdpart: Do not fail mtd probe when parsing
 partitions fails.
In-Reply-To: <cover.1433364398.git.hramrach@gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
Message-ID: <2be0439cf72f5b7f430a937bacf430cffab91f08.1433364398.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to wrong assumption in ofpart ofpart fails on Exynos on SPI chips
with no partitions because the subnode containing controller data
confuses the ofpart parser.

Thus compiling in ofpart support automatically fails probing any SPI NOR
flash without partitions on Exynos. Compiling in a partitioning scheme
should not cause probe of otherwise valid device to fail.

Remove that failure possibility.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/mtd/mtdpart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index a79c4f7..37a2b79 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -743,7 +743,6 @@ static const char * const default_mtd_part_types[] = {
  * partitions parsed out by the first parser.
  *
  * This function may return:
- * o a negative error code in case of failure
  * o zero if no partitions were found
  * o a positive number of found partitions, in which case on exit @pparts will
  *   point to an array containing this number of &struct mtd_info objects.
@@ -773,10 +772,10 @@ int parse_mtd_partitions(struct mtd_info *master, const char *const *types,
 		if (ret > 0) {
 			printk(KERN_NOTICE "%d %s partitions found on MTD device %s\n",
 			       ret, parser->name, master->name);
-			break;
+			return ret;
 		}
 	}
-	return ret;
+	return 0;
 }
 
 int mtd_is_partition(const struct mtd_info *mtd)
-- 
2.1.4
