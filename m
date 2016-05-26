From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 26 May 2016 11:34:57 +0200
Subject: [PATCH] hwrng: stm32: fix maybe uninitialized variable warning
Message-ID: <1464255297-21090-1-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following warning:
drivers/char/hw_random/stm32-rng.c: In function 'stm32_rng_read':
drivers/char/hw_random/stm32-rng.c:82:19: warning: 'sr' may be used
                                        uninitialized in this function

Reported-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 drivers/char/hw_random/stm32-rng.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index 92a810648bd0..63d84e6f1891 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -69,8 +69,12 @@ static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 		}
 
 		/* If error detected or data not ready... */
-		if (sr != RNG_SR_DRDY)
+		if (sr != RNG_SR_DRDY) {
+			if (WARN_ONCE(sr & (RNG_SR_SEIS | RNG_SR_CEIS),
+					"bad RNG status - %x\n", sr))
+				writel_relaxed(0, priv->base + RNG_SR);
 			break;
+		}
 
 		*(u32 *)data = readl_relaxed(priv->base + RNG_DR);
 
@@ -79,10 +83,6 @@ static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 		max -= sizeof(u32);
 	}
 
-	if (WARN_ONCE(sr & (RNG_SR_SEIS | RNG_SR_CEIS),
-		      "bad RNG status - %x\n", sr))
-		writel_relaxed(0, priv->base + RNG_SR);
-
 	pm_runtime_mark_last_busy((struct device *) priv->rng.priv);
 	pm_runtime_put_sync_autosuspend((struct device *) priv->rng.priv);
 
-- 
1.9.1
