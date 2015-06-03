From: hramrach@gmail.com (Michal Suchanek)
Date: 3 Jun 2015 21:26:40 -0000
Subject: [PATCH 04/11] mtd: ofpart: do not fail probe when no partitions exist
In-Reply-To: <cover.1433364398.git.hramrach@gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
Message-ID: <36e315552c849a4d22ac0fcff7958f6ffcafb160.1433364398.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Exynos it is necessary to set SPI controller parameters that apply to
a SPI slave in a DT subnode of the slave device. The ofpart code returns
an error when there are subnodes of the SPI flash but no partitions are
found. Change this condition to a warning so that flash without
partitions can be accessed on Exynos.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/mtd/ofpart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/ofpart.c b/drivers/mtd/ofpart.c
index aa26c32..a29d29f 100644
--- a/drivers/mtd/ofpart.c
+++ b/drivers/mtd/ofpart.c
@@ -94,10 +94,10 @@ static int parse_ofpart_partitions(struct mtd_info *master,
 
 	if (!i) {
 		of_node_put(pp);
-		pr_err("No valid partition found on %s\n", node->full_name);
+		pr_warn("No valid partition found on %s\n", node->full_name);
 		kfree(*pparts);
 		*pparts = NULL;
-		return -EINVAL;
+		return 0;
 	}
 
 	return nr_parts;
-- 
2.1.4
