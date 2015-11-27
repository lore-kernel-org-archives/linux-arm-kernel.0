From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Nov 2015 14:49:49 +0100
Subject: [PATCH] null_blk: use sector_div instead of do_div
Message-ID: <3768541.ja0r6f0Odi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dividing a sector_t number should be done using sector_div rather
than do_div to optimize the 32-bit sector_t case, and with
the latest do_div optimizations, we now get a compile-time
warning for this:

arch/arm/include/asm/div64.h:32:95: note: expected 'uint64_t * {aka long long unsigned int *}' but argument is of type 'sector_t * {aka long unsigned int *}'
drivers/block/null_blk.c:521:81: warning: comparison of distinct pointer types lacks a cast

This changes the newly added code to use sector_div.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b2b7e00148a2 ("null_blk: register as a LightNVM device")
---
Found on ARM randconfig builds with today's linux-next

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 5c8ba5484d86..d0eeecd294de 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -510,17 +510,17 @@ static int null_lnvm_id(struct request_queue *q, struct nvm_id *id)
 	id->ppaf.ch_offset = 56;
 	id->ppaf.ch_len = 8;
 
-	do_div(size, bs); /* convert size to pages */
-	do_div(size, 256); /* concert size to pgs pr blk */
+	sector_div(size, bs); /* convert size to pages */
+	sector_div(size, 256); /* concert size to pgs pr blk */
 	grp = &id->groups[0];
 	grp->mtype = 0;
 	grp->fmtype = 0;
 	grp->num_ch = 1;
 	grp->num_pg = 256;
 	blksize = size;
-	do_div(size, (1 << 16));
+	sector_div(size, (1 << 16));
 	grp->num_lun = size + 1;
-	do_div(blksize, grp->num_lun);
+	sector_div(blksize, grp->num_lun);
 	grp->num_blk = blksize;
 	grp->num_pln = 1;
 
