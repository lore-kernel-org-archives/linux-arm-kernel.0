From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Sun,  1 Mar 2015 08:20:32 -0500
Subject: [PATCH] i2c: wmt: use msecs_to_jiffies for time conversions
Message-ID: <1425216032-8163-1-git-send-email-hofrat@osadl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is only an API consolidation and should make things more readable
it replaces var * HZ / 1000 by msecs_to_jiffies(var).

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Converting milliseconds to jiffies by "val * HZ / 1000" is technically
not wrong but msecs_to_jiffies(val) is the cleaner solution and handles
all corner cases correctly. This is a minor API cleanup only.

Note that the alignment is not exactly with the opening braces but rather
with the last tab-stop that will not result in going over 80 char.

Patch was compile-tested only for vt8500_v6_v7_defconfig 
(implies CONFIG_I2C_WMT=y)

Patch is against 4.0-rc1 (localversion-next is -next-20150227)

 drivers/i2c/busses/i2c-wmt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-wmt.c b/drivers/i2c/busses/i2c-wmt.c
index 82ea349..26e49e6 100644
--- a/drivers/i2c/busses/i2c-wmt.c
+++ b/drivers/i2c/busses/i2c-wmt.c
@@ -177,7 +177,7 @@ static int wmt_i2c_write(struct i2c_adapter *adap, struct i2c_msg *pmsg,
 
 	while (xfer_len < pmsg->len) {
 		wait_result = wait_for_completion_timeout(&i2c_dev->complete,
-							  500 * HZ / 1000);
+							msecs_to_jiffies(500));
 
 		if (wait_result == 0)
 			return -ETIMEDOUT;
@@ -266,7 +266,7 @@ static int wmt_i2c_read(struct i2c_adapter *adap, struct i2c_msg *pmsg,
 
 	while (xfer_len < pmsg->len) {
 		wait_result = wait_for_completion_timeout(&i2c_dev->complete,
-							  500 * HZ / 1000);
+							msecs_to_jiffies(500));
 
 		if (!wait_result)
 			return -ETIMEDOUT;
-- 
1.7.10.4
