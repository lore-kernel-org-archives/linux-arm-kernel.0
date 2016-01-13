From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 13 Jan 2016 12:39:18 -0800
Subject: [PATCH] logfs: clarify MTD dependency
In-Reply-To: <5776957.XLg438VUOx@wuerfel>
References: <5776957.XLg438VUOx@wuerfel>
Message-ID: <20160113123918.544497b48bf4c03591c75747@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Jan 2016 14:25:55 +0100 Arnd Bergmann <arnd@arndb.de> wrote:

> After a change to the way that composite modules work, we get
> a logfs build error:
> 
> fs/built-in.o: In function `logfs_mount':
> :(.text+0x139d34): undefined reference to `logfs_get_sb_mtd'
> fs/built-in.o: In function `logfs_get_sb_bdev':
> :(.text+0x13aa08): undefined reference to `logfs_get_sb_mtd'
> 
> This patch avoids the error by changing the dependencies of
> logfs in a way that we can no longer configure logfs as built-in
> when the MTD core is a loadable module, while leaving the
> dependency to require at least one of MTD or BLOCK to be
> enabled.
> 
> Another patch tried to work around the problem, but accidentally
> dropped the dependency on 'BLOCK || MTD', allowing the file
> system to be built if neither is selected.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: cf4f21938e13 ("kbuild: Allow to specify composite modules with modname-m")
> Fixes: e6be296f680c ("logfs: fix logfs build errors and dependencies")

Randy's "logfs: fix logfs build errors and dependencies" is an
only-in-mm thing.  So it would make sense to combine the two patches
into a single one and to give that an appropriate changelog.

How does this look? (Primary author was chosen randomly)


From: Arnd Bergmann <arnd@arndb.de>
Subject: logfs: fix logfs build errors and dependencies

Fix build errors that happen when CONFIG_LOGFS=y and CONFIG_MTD=m:

fs/built-in.o: In function `logfs_mount':
super.c:(.text+0x92a6f): undefined reference to `logfs_get_sb_mtd'
fs/built-in.o: In function `logfs_get_sb_bdev':
(.text+0x93530): undefined reference to `logfs_get_sb_mtd'

This patch avoids the error by changing the dependencies of
logfs in a way that we can no longer configure logfs as built-in
when the MTD core is a loadable module, while leaving the
dependency to require at least one of MTD or BLOCK to be
enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michal Marek <mmarek@suse.cz>
Cc: Peter Chen <peter.chen@freescale.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Joern Engel <joern@logfs.org>
Cc: Prasad Joshi <prasadjoshi.linux@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/logfs/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/logfs/Kconfig~logfs-fix-logfs-build-errors-and-dependencies fs/logfs/Kconfig
--- a/fs/logfs/Kconfig~logfs-fix-logfs-build-errors-and-dependencies
+++ a/fs/logfs/Kconfig
@@ -1,6 +1,6 @@
 config LOGFS
 	tristate "LogFS file system"
-	depends on (MTD || BLOCK)
+	depends on MTD || (!MTD && BLOCK)
 	select ZLIB_INFLATE
 	select ZLIB_DEFLATE
 	select CRC32
_
