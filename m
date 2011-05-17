From: Artem.Bityutskiy@nokia.com (Artem Bityutskiy)
Date: Tue, 17 May 2011 11:13:17 +0300
Subject: [PATCH] mtd: be silent when mtd partition parser cannot be found
Message-ID: <mailman.241.1305620205.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently when we register partitions in 'parse_mtd_partitions()' we accept the
list of parsers we should try. And if one of the parsers was not found we print
a message. Well, first of all this whole idea is bad - look at how many
'part_probes' and 'part_probe_types' variables we have - nearly every driver
defines one. Instead, we should just go through all registered parsers all the
time. But this needs to be worked on separately.

This patch makes life of MTD partitions' users a bit simpler and allows them to
safely request parsers which have not been registered -
'parse_mtd_partitions()' will not print a "not available" message in this
case.

Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
---
 drivers/mtd/mtdpart.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 0a47601..cd631e7 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -722,11 +722,8 @@ int parse_mtd_partitions(struct mtd_info *master, const char **types,
 		parser = get_partition_parser(*types);
 		if (!parser && !request_module("%s", *types))
 				parser = get_partition_parser(*types);
-		if (!parser) {
-			printk(KERN_NOTICE "%s partition parsing not available\n",
-			       *types);
+		if (!parser)
 			continue;
-		}
 		ret = (*parser->parse_fn)(master, pparts, origin);
 		if (ret > 0) {
 			printk(KERN_NOTICE "%d %s partitions found on MTD device %s\n",
-- 
1.7.2.3

-- 
Best Regards,
Artem Bityutskiy (?????????? ????????????????)
