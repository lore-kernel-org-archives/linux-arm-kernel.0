From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Nov 2015 14:54:53 +0100
Subject: [PATCH] logfs: clarify MTD dependency
Message-ID: <9365895.IkncCfXjo6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After a change to the way that composite modules work, we get
a logfs build error:

fs/built-in.o: In function `logfs_mount':
:(.text+0x139d34): undefined reference to `logfs_get_sb_mtd'
fs/built-in.o: In function `logfs_get_sb_bdev':
:(.text+0x13aa08): undefined reference to `logfs_get_sb_mtd'

This patch avoids the error by changing the dependencies of
logfs in a way that we can no longer configure logfs as built-in
when the MTD core is a loadable module, while leaving the
dependency to require at least one of MTD or BLOCK to be
enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: cf4f21938e13 ("kbuild: Allow to specify composite modules with modname-m")
---
Found on today's linux-next. The commit that broke it is currently
in the kbuild for-next tree, so please apply my fix on top, or fold
it into the original patch.

diff --git a/fs/logfs/Kconfig b/fs/logfs/Kconfig
index 09ed066c0221..2b4503163930 100644
--- a/fs/logfs/Kconfig
+++ b/fs/logfs/Kconfig
@@ -1,6 +1,6 @@
 config LOGFS
 	tristate "LogFS file system"
-	depends on (MTD || BLOCK)
+	depends on MTD || (!MTD && BLOCK)
 	select ZLIB_INFLATE
 	select ZLIB_DEFLATE
 	select CRC32
