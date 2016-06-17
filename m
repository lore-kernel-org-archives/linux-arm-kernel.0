From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jun 2016 17:37:12 +0200
Subject: [PATCH] ata: fix "ering" sysfs time printing
Message-ID: <20160617153739.429055-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sysfs file for the libata error handling has multiple issues
in the way it prints time stamps:

 * it prints a 9-digit nanosecond value using a %06lu format string,
   which drops some leading zeroes
 * it converts a 64-bit jiffes value to a timespec using
   jiffies_to_timespec(), which takes a 'long' argument, so the
   result is wrong after a jiffies overflow (49 days).
 * we try to avoid using timespec because that generally overflows
   in 2038, although this particular usage is ok.

This replaces the jiffies_to_timespec call with an open-coded
implementation that gets it right.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ata/libata-transport.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index e2d94972962d..7ef16c085058 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -495,12 +495,13 @@ struct ata_show_ering_arg {
 static int ata_show_ering(struct ata_ering_entry *ent, void *void_arg)
 {
 	struct ata_show_ering_arg* arg = void_arg;
-	struct timespec time;
+	u64 seconds;
+	u32 rem;
 
-	jiffies_to_timespec(ent->timestamp,&time);
+	seconds = div_u64_rem(ent->timestamp, HZ, &rem);
 	arg->written += sprintf(arg->buf + arg->written,
-			       "[%5lu.%06lu]",
-			       time.tv_sec, time.tv_nsec);
+			        "[%5llu.%09lu]", seconds,
+				rem * NSEC_PER_SEC / HZ);
 	arg->written += get_ata_err_names(ent->err_mask,
 					  arg->buf + arg->written);
 	return 0;
-- 
2.9.0
