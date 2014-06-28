From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 28 Jun 2014 15:23:11 +0200
Subject: [PATCH] regmap: Fix debugfs-file 'registers' mode
Message-ID: <1403961791-15376-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The macro "REGMAP_ALLOW_WRITE_DEBUGFS" can be used to enable write
support on the registers file in the debugfs. The mode of the file is
fixed to 0400 so it is not possible to write the file ever.

This patch fixes the mode by setting it to the correct value depending
on the macro.

Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Hi,

as the kconfig option will probably not be merged, I extracted the mode fix of
my previous patch.

Regards,

Markus

 drivers/base/regmap/regmap-debugfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 45d812c0ea77..f45a0a0e0371 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -512,7 +512,14 @@ void regmap_debugfs_init(struct regmap *map, const char *name)
 			    map, &regmap_reg_ranges_fops);
 
 	if (map->max_register || regmap_readable(map, 0)) {
-		debugfs_create_file("registers", 0400, map->debugfs,
+		unsigned int registers_mode;
+
+		if (IS_ENABLED(REGMAP_ALLOW_WRITE_DEBUGFS))
+			registers_mode = 0600;
+		else
+			registers_mode = 0400;
+
+		debugfs_create_file("registers", registers_mode, map->debugfs,
 				    map, &regmap_map_fops);
 		debugfs_create_file("access", 0400, map->debugfs,
 				    map, &regmap_access_fops);
-- 
2.0.0
