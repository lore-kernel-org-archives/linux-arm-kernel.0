From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Mon, 23 May 2016 18:14:08 +0530
Subject: [PATCH] hwrng: stm32 - fix build warning
Message-ID: <1464007448-25395-1-git-send-email-sudipm.mukherjee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have been getting build warning about:
drivers/char/hw_random/stm32-rng.c: In function 'stm32_rng_read':
drivers/char/hw_random/stm32-rng.c:82:19: warning: 'sr' may be used
					uninitialized in this function

On checking the code it turns out that sr can never be used
uninitialized as sr is getting initialized in the while loop and while
loop will always execute as the minimum value of max can be 32.
So just initialize sr to 0 while declaring it to silence the compiler.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

build log at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/132180906

 drivers/char/hw_random/stm32-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index 92a8106..0533370 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -52,7 +52,7 @@ static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
 	struct stm32_rng_private *priv =
 	    container_of(rng, struct stm32_rng_private, rng);
-	u32 sr;
+	u32 sr = 0;
 	int retval = 0;
 
 	pm_runtime_get_sync((struct device *) priv->rng.priv);
-- 
1.9.1
