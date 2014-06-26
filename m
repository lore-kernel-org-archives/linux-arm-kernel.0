From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 Jun 2014 15:44:52 +0200
Subject: [PATCH] [SCSI] hpsa: fix non-x86 builds
Message-ID: <6003317.KPlAy1USkq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 28e134464734 "[SCSI] hpsa: enable unit attention reporting"
turns on unit attention notifications, but got the change wrong for
all architectures other than x86, which now store an uninitialized
value into the device register.

Gcc helpfully warns about this:

../drivers/scsi/hpsa.c: In function 'hpsa_set_driver_support_bits':
../drivers/scsi/hpsa.c:6373:17: warning: 'driver_support' is used uninitialized in this function [-Wuninitialized]
  driver_support |= ENABLE_UNIT_ATTN;
                 ^

This moves the #ifdef so only the prefetch-enable is conditional
on x86, not also reading the initial register contents. 


Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 28e134464734 "[SCSI] hpsa: enable unit attention reporting"
Cc: Stephen M. Cameron <scameron@beardog.cce.hp.com>
Cc: stable at vger.kernel.org # v3.14+

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 31184b3..d0e487c 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -6365,9 +6365,9 @@ static inline void hpsa_set_driver_support_bits(struct ctlr_info *h)
 {
 	u32 driver_support;
 
-#ifdef CONFIG_X86
-	/* Need to enable prefetch in the SCSI core for 6400 in x86 */
 	driver_support = readl(&(h->cfgtable->driver_support));
+	/* Need to enable prefetch in the SCSI core for 6400 in x86 */
+#ifdef CONFIG_X86
 	driver_support |= ENABLE_SCSI_PREFETCH;
 #endif
 	driver_support |= ENABLE_UNIT_ATTN;
