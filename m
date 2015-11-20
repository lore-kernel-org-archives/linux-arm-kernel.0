From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Nov 2015 17:38:28 +0100
Subject: [PATCH] scsi: use sector_div instead of do_div
Message-ID: <24882658.08y4bWL6tn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

do_div is the wrong way to divide a sector_t, as it is less
efficient when sector_t is 32-bit wide. With the upcoming
do_div optimizations, the kernel starts warning about this:

drivers/scsi/scsi_debug.c: In function 'dif_store':
include/asm-generic/div64.h:207:28: warning: comparison of distinct pointer types lacks a cast

This changes the code to use sector_div instead, which always
produces optimal code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Found on the ARM randconfig build today, after I merged Nico's patches
for linux-next

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index dfcc45bb03b1..ec622ba9864a 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -678,7 +678,7 @@ static void *fake_store(unsigned long long lba)
 
 static struct sd_dif_tuple *dif_store(sector_t sector)
 {
-	sector = do_div(sector, sdebug_store_sectors);
+	sector = sector_div(sector, sdebug_store_sectors);
 
 	return dif_storep + sector;
 }
@@ -2780,7 +2780,7 @@ static unsigned long lba_to_map_index(sector_t lba)
 		lba += scsi_debug_unmap_granularity -
 			scsi_debug_unmap_alignment;
 	}
-	do_div(lba, scsi_debug_unmap_granularity);
+	sector_div(lba, scsi_debug_unmap_granularity);
 
 	return lba;
 }
