From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 28 Jun 2013 14:35:52 -0700
Subject: [PATCH] i2c: iop3xxx: fix build failure after waitqueue changes
Message-ID: <1372455352-26260-1-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There has long been a syntax problem in iop3xx_i2c_wait_event() which
has been somehow hidden by the macros in <linux/wait.h>.  After some
recent cleanup/rework of the wait_event_* helpers, the bug has come
out from hiding and now results in build failure:

/work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c: In function 'iop3xx_i2c_wait_event':
/work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:143: error: expected ')' before ';' token
/work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:157: error: expected ')' before ';' token
/work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:213: error: expected ')' before ';' token
/work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:291: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
/work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:551: error: expected ')' before ';' token
/work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:565: error: expected ')' before ';' token
/work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:764: error: expected ')' before ';' token
/work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:778: error: expected ')' b

Fix by removing stray ';'

Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
Discovered in new build failure of iop32xx_defconfig with next-20130628

 drivers/i2c/busses/i2c-iop3xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
index bc99333..dd24aa0 100644
--- a/drivers/i2c/busses/i2c-iop3xx.c
+++ b/drivers/i2c/busses/i2c-iop3xx.c
@@ -176,7 +176,7 @@ iop3xx_i2c_wait_event(struct i2c_algo_iop3xx_data *iop3xx_adap,
 		interrupted = wait_event_interruptible_timeout (
 			iop3xx_adap->waitq,
 			(done = compare( sr = iop3xx_i2c_get_srstat(iop3xx_adap) ,flags )),
-			1 * HZ;
+			1 * HZ
 			);
 		if ((rc = iop3xx_i2c_error(sr)) < 0) {
 			*status = sr;
-- 
1.8.3
