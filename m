From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 22:44:08 +0000
Subject: [PATCH 09/19] mfd/twl4030: don't warn about uninitialized return code
In-Reply-To: <1359153858-31992-1-git-send-email-arnd@arndb.de>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359153858-31992-1-git-send-email-arnd@arndb.de>
Message-ID: <1359153858-31992-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the twl4030_write_script function gets called with
a zero length argument, its return value does not
get set. We know that all scripts have a nonzero
length, but returning an error in case they ever
do is probably appropriate.

Without this patch, building omap2plus_defconfig results in:

drivers/mfd/twl4030-power.c: In function 'load_twl4030_script':
drivers/mfd/twl4030-power.c:414:5: error: 'err' may be used uninitialized in this function

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Kristo, Tero" <t-kristo@ti.com>
---
 drivers/mfd/twl4030-power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 4dae241..dd362c1 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -159,7 +159,7 @@ out:
 static int twl4030_write_script(u8 address, struct twl4030_ins *script,
 				       int len)
 {
-	int err;
+	int err = -EINVAL;
 
 	for (; len; len--, address++, script++) {
 		if (len == 1) {
-- 
1.8.0
