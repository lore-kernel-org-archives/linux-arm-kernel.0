From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 26 Jan 2013 11:45:35 +0000
Subject: [PATCH 11/19] regmap: regmap: avoid spurious warning in
 regmap_read_debugfs
In-Reply-To: <20130126100744.GD23505@n2100.arm.linux.org.uk>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <20130126100326.GK30594@opensource.wolfsonmicro.com>
 <20130126100744.GD23505@n2100.arm.linux.org.uk>
Message-ID: <201301261145.36158.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King <rmk+kernel@arm.linux.org.uk>

Gcc warns about the case where regmap_read_debugfs tries to walk an
empty map->debugfs_off_cache list, which would results in uninitialized
variable getting returned, if we hadn't checked the same condition
just before that.

After an originally suggested inferior patch from Arnd Bergmann,
this is the solution that Russell King came up with, sidestepping
the problem by merging the error case for an empty list with the
normal path.

Without this patch, building mxs_defconfig results in:

drivers/base/regmap/regmap-debugfs.c: In function 'regmap_read_debugfs':
drivers/base/regmap/regmap-debugfs.c:147:9: : warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]

Reported-by: Vincent Stehle <v-stehle@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 41b65f6..ef35c25 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -128,10 +128,8 @@ static unsigned int regmap_debugfs_get_dump_start(struct regmap *map,
 	 * allocate and we should never be in this code if there are
 	 * no registers at all.
 	 */
-	if (list_empty(&map->debugfs_off_cache)) {
-		WARN_ON(list_empty(&map->debugfs_off_cache));
-		return base;
-	}
+	WARN_ON(list_empty(&map->debugfs_off_cache));
+	ret = base;
 
 	/* Find the relevant block */
 	list_for_each_entry(c, &map->debugfs_off_cache, list) {
