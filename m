From: colin.king@canonical.com (Colin King)
Date: Fri, 12 Jan 2018 16:30:48 +0000
Subject: [PATCH][next] hwrng: exynos: check for -ve error return from
 readl_poll_timeout
Message-ID: <20180112163048.26960-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Currently, the return from readl_poll_timeout is being assigned to
a u32 and this is being checked for a -ve return which is always
false since a u32 cannot be less than zero.  Fix this by changing
val to an int so that error returns can be correctly detected.

Detected by CoverityScan, CID#1463776 ("Logically dead code")

Fixes: 6cd225cc5d8a ("hwrng: exynos - add Samsung Exynos True RNG driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/char/hw_random/exynos-trng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/exynos-trng.c b/drivers/char/hw_random/exynos-trng.c
index 34d6f51ecbee..f4643e3ec346 100644
--- a/drivers/char/hw_random/exynos-trng.c
+++ b/drivers/char/hw_random/exynos-trng.c
@@ -55,7 +55,7 @@ static int exynos_trng_do_read(struct hwrng *rng, void *data, size_t max,
 			       bool wait)
 {
 	struct exynos_trng_dev *trng;
-	u32 val;
+	int val;
 
 	max = min_t(size_t, max, (EXYNOS_TRNG_FIFO_LEN * 4));
 
-- 
2.15.1
