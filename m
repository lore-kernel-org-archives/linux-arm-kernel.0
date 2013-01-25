From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 22:44:10 +0000
Subject: [PATCH 11/19] regmap: avoid undefined return from regmap_read_debugfs
In-Reply-To: <1359153858-31992-1-git-send-email-arnd@arndb.de>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359153858-31992-1-git-send-email-arnd@arndb.de>
Message-ID: <1359153858-31992-12-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gcc warns about the case where regmap_read_debugfs tries
to walk an empty map->debugfs_off_cache list, which results
in uninitialized variable getting returned.

Setting this variable to 0 first avoids the warning and
the potentially undefined value.

Without this patch, building mxs_defconfig results in:

drivers/base/regmap/regmap-debugfs.c: In function 'regmap_read_debugfs':
drivers/base/regmap/regmap-debugfs.c:147:9: : warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/regmap/regmap-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 46a213a..31cc656 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -80,7 +80,7 @@ static unsigned int regmap_debugfs_get_dump_start(struct regmap *map,
 {
 	struct regmap_debugfs_off_cache *c = NULL;
 	loff_t p = 0;
-	unsigned int i, ret;
+	unsigned int i, ret = 0;
 
 	/*
 	 * If we don't have a cache build one so we don't have to do a
-- 
1.8.0
