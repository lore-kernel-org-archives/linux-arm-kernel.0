From: hramrach@gmail.com (Michal Suchanek)
Date: 3 Jun 2015 21:26:40 -0000
Subject: [PATCH 03/11] mtd: add debug prints to mtdpart partition parser.
In-Reply-To: <cover.1433364398.git.hramrach@gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
Message-ID: <81397d21d4919bed3593938ad3864d8023aff982.1433364398.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The probe of a mtd device can fail when a partition parser returns
error. The failure due to partition parsing can be quite mysterious when
multiple partitioning schemes are comiled in and any of them can fail
the probe.

Add debug prints which show what parsers were tried and what they
returned.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/mtd/mtdpart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index cafdb88..a79c4f7 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -759,12 +759,16 @@ int parse_mtd_partitions(struct mtd_info *master, const char *const *types,
 		types = default_mtd_part_types;
 
 	for ( ; ret <= 0 && *types; types++) {
+		pr_debug("Parsing partitions %s on %s", *types, master->name);
 		parser = get_partition_parser(*types);
 		if (!parser && !request_module("%s", *types))
 			parser = get_partition_parser(*types);
+		pr_debug("%s got parser %s", master->name,
+			 parser ? parser->name : NULL);
 		if (!parser)
 			continue;
 		ret = (*parser->parse_fn)(master, pparts, data);
+		pr_debug("%s parser %s: %i", master->name, parser->name, ret);
 		put_partition_parser(parser);
 		if (ret > 0) {
 			printk(KERN_NOTICE "%d %s partitions found on MTD device %s\n",
-- 
2.1.4
