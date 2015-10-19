From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 19 Oct 2015 13:37:40 +0900
Subject: [PATCH 2/4] hwrng: exynos - Add timeout for waiting on init done
In-Reply-To: <1445229462-32395-1-git-send-email-k.kozlowski@samsung.com>
References: <1445229462-32395-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1445229462-32395-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver may hang waiting indefinitely for PRNG to finish its
initialization stage. Instead of stalling return -ETIMEDOUT error.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/char/hw_random/exynos-rng.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/exynos-rng.c b/drivers/char/hw_random/exynos-rng.c
index dc4701fd814f..dfaaaafb8ddd 100644
--- a/drivers/char/hw_random/exynos-rng.c
+++ b/drivers/char/hw_random/exynos-rng.c
@@ -81,14 +81,17 @@ static int exynos_read(struct hwrng *rng, void *buf,
 	struct exynos_rng *exynos_rng = container_of(rng,
 						struct exynos_rng, rng);
 	u32 *data = buf;
+	int retry = 100;
 
 	pm_runtime_get_sync(exynos_rng->dev);
 
 	exynos_rng_writel(exynos_rng, PRNG_START, 0);
 
 	while (!(exynos_rng_readl(exynos_rng,
-			EXYNOS_PRNG_STATUS_OFFSET) & PRNG_DONE))
+			EXYNOS_PRNG_STATUS_OFFSET) & PRNG_DONE) && --retry)
 		cpu_relax();
+	if (!retry)
+		return -ETIMEDOUT;
 
 	exynos_rng_writel(exynos_rng, PRNG_DONE, EXYNOS_PRNG_STATUS_OFFSET);
 
-- 
1.9.1
