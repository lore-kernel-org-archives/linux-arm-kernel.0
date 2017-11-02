From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed,  1 Nov 2017 18:04:04 -0700
Subject: [PATCH 08/12] hwrng: bcm2835-rng: Abstract I/O accessors
In-Reply-To: <20171102010408.27736-1-f.fainelli@gmail.com>
References: <20171102010408.27736-1-f.fainelli@gmail.com>
Message-ID: <20171102010408.27736-9-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for allowing BCM63xx to use this driver, we abstract I/O
accessors such that we can easily change those later on.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/char/hw_random/bcm2835-rng.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/char/hw_random/bcm2835-rng.c b/drivers/char/hw_random/bcm2835-rng.c
index 35928efb52e7..500275d55044 100644
--- a/drivers/char/hw_random/bcm2835-rng.c
+++ b/drivers/char/hw_random/bcm2835-rng.c
@@ -42,6 +42,17 @@ static inline struct bcm2835_rng_priv *to_rng_priv(struct hwrng *rng)
 	return container_of(rng, struct bcm2835_rng_priv, rng);
 }
 
+static inline u32 rng_readl(struct bcm2835_rng_priv *priv, u32 offset)
+{
+	return readl(priv->base + offset);
+}
+
+static inline void rng_writel(struct bcm2835_rng_priv *priv, u32 val,
+			      u32 offset)
+{
+	writel(val, priv->base + offset);
+}
+
 static int bcm2835_rng_read(struct hwrng *rng, void *buf, size_t max,
 			       bool wait)
 {
@@ -49,18 +60,18 @@ static int bcm2835_rng_read(struct hwrng *rng, void *buf, size_t max,
 	u32 max_words = max / sizeof(u32);
 	u32 num_words, count;
 
-	while ((__raw_readl(priv->base + RNG_STATUS) >> 24) == 0) {
+	while ((rng_readl(priv, RNG_STATUS) >> 24) == 0) {
 		if (!wait)
 			return 0;
 		cpu_relax();
 	}
 
-	num_words = readl(priv->base + RNG_STATUS) >> 24;
+	num_words = rng_readl(priv, RNG_STATUS) >> 24;
 	if (num_words > max_words)
 		num_words = max_words;
 
 	for (count = 0; count < num_words; count++)
-		((u32 *)buf)[count] = readl(priv->base + RNG_DATA);
+		((u32 *)buf)[count] = rng_readl(priv, RNG_DATA);
 
 	return num_words * sizeof(u32);
 }
@@ -77,14 +88,14 @@ static int bcm2835_rng_init(struct hwrng *rng)
 
 	if (priv->mask_interrupts) {
 		/* mask the interrupt */
-		val = readl(priv->base + RNG_INT_MASK);
+		val = rng_readl(priv, RNG_INT_MASK);
 		val |= RNG_INT_OFF;
-		writel(val, priv->base + RNG_INT_MASK);
+		rng_writel(priv, val, RNG_INT_MASK);
 	}
 
 	/* set warm-up count & enable */
-	__raw_writel(RNG_WARMUP_COUNT, priv->base + RNG_STATUS);
-	__raw_writel(RNG_RBGEN, priv->base + RNG_CTRL);
+	rng_writel(priv, RNG_WARMUP_COUNT, RNG_STATUS);
+	rng_writel(priv, RNG_RBGEN, RNG_CTRL);
 
 	return 0;
 }
@@ -94,7 +105,7 @@ static void bcm2835_rng_cleanup(struct hwrng *rng)
 	struct bcm2835_rng_priv *priv = to_rng_priv(rng);
 
 	/* disable rng hardware */
-	__raw_writel(0, priv->base + RNG_CTRL);
+	rng_writel(priv, 0, RNG_CTRL);
 
 	clk_disable_unprepare(priv->clk);
 }
-- 
2.9.3
