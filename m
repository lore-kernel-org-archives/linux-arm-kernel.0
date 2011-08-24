From: jason.hui@linaro.org (Jason Liu)
Date: Wed, 24 Aug 2011 18:53:01 +0800
Subject: [PATCH] mtd: check parts pointer before using it
Message-ID: <1314183181-4197-1-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code has the check for parts but it called after kmemdup,
kmemdup(parts, sizeof(*parts) * nr_parts,...)
if (!parts)
	return -ENOMEM

In fact, we need check parts before safely using it.

Signed-off-by: Jason Liu <jason.hui@linaro.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>

---
This patch is based on git://git.infradead.org/users/dedekind/l2-mtd-2.6.git
---
 drivers/mtd/mtdcore.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 09bdbac..ce59ff5 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -465,12 +465,10 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char **types,
 	struct mtd_partition *real_parts;
 
 	err = parse_mtd_partitions(mtd, types, &real_parts, parser_data);
-	if (err <= 0 && nr_parts) {
+	if (err <= 0 && nr_parts && !parts) {
 		real_parts = kmemdup(parts, sizeof(*parts) * nr_parts,
 				     GFP_KERNEL);
 		err = nr_parts;
-		if (!parts)
-			err = -ENOMEM;
 	}
 
 	if (err > 0) {
-- 
1.7.4.1
