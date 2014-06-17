From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 17 Jun 2014 21:36:35 +0200
Subject: [PATCH] regmap: Add Kconfig option for debugfs register writes
Message-ID: <1403033795-9122-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To enable writing of registers through the regmap debugfs interface, it
was necessary to alter the regmap-debugfs.c source code. This is not
really practical.

As this is a powerful tool for debugging, this patch creates an expert
kconfig option for this function. This makes it easier to enable
register writing in the kernel.

This patch also fixes the file mode when the regmap debugfs write code is
compiled.

Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/base/regmap/Kconfig          | 14 ++++++++++++++
 drivers/base/regmap/regmap-debugfs.c | 16 ++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 4251570610c9..ce86600dbe75 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -23,3 +23,17 @@ config REGMAP_MMIO
 
 config REGMAP_IRQ
 	bool
+
+config REGMAP_ALLOW_WRITE_DEBUGFS
+	default n
+	depends on DEBUG_FS
+	depends on EXPERT
+	depends on REGMAP
+	bool "Regmap, allow direct register writes through debugfs"
+	help
+	  This option enables regmap debugfs write support. If this is enabled,
+	  you can directly write registers using the registers file in the
+	  regmap debugfs.
+
+	  This is potentially dangerous. Do not enable this option unless you
+	  know what you are doing.
diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 45d812c0ea77..12906f2bdf00 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -261,13 +261,10 @@ static ssize_t regmap_map_read_file(struct file *file, char __user *user_buf,
 				   count, ppos);
 }
 
-#undef REGMAP_ALLOW_WRITE_DEBUGFS
-#ifdef REGMAP_ALLOW_WRITE_DEBUGFS
+#if IS_ENABLED(CONFIG_REGMAP_ALLOW_WRITE_DEBUGFS)
 /*
  * This can be dangerous especially when we have clients such as
- * PMICs, therefore don't provide any real compile time configuration option
- * for this feature, people who want to use this will need to modify
- * the source code directly.
+ * PMICs, therefore this function can only be selected in expert kconfig mode.
  */
 static ssize_t regmap_map_write_file(struct file *file,
 				     const char __user *user_buf,
@@ -512,7 +509,14 @@ void regmap_debugfs_init(struct regmap *map, const char *name)
 			    map, &regmap_reg_ranges_fops);
 
 	if (map->max_register || regmap_readable(map, 0)) {
-		debugfs_create_file("registers", 0400, map->debugfs,
+		unsigned int registers_mode;
+
+		if (IS_ENABLED(CONFIG_REGMAP_ALLOW_WRITE_DEBUGFS))
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
