From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed,  1 Nov 2017 18:04:05 -0700
Subject: [PATCH 09/12] hwrng: bcm2835-rng: Add Broadcom MIPS I/O accessors
In-Reply-To: <20171102010408.27736-1-f.fainelli@gmail.com>
References: <20171102010408.27736-1-f.fainelli@gmail.com>
Message-ID: <20171102010408.27736-10-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Broadcom MIPS HW is always strapped to match the system-wide endian such
that all I/O access to this RNG block is done with the native CPU
endian, account for that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/char/hw_random/bcm2835-rng.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/bcm2835-rng.c b/drivers/char/hw_random/bcm2835-rng.c
index 500275d55044..650e0033c273 100644
--- a/drivers/char/hw_random/bcm2835-rng.c
+++ b/drivers/char/hw_random/bcm2835-rng.c
@@ -44,13 +44,22 @@ static inline struct bcm2835_rng_priv *to_rng_priv(struct hwrng *rng)
 
 static inline u32 rng_readl(struct bcm2835_rng_priv *priv, u32 offset)
 {
-	return readl(priv->base + offset);
+	/* MIPS chips strapped for BE will automagically configure the
+	 * peripheral registers for CPU-native byte order.
+	 */
+	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
+		return __raw_readl(priv->base + offset);
+	else
+		return readl(priv->base + offset);
 }
 
 static inline void rng_writel(struct bcm2835_rng_priv *priv, u32 val,
 			      u32 offset)
 {
-	writel(val, priv->base + offset);
+	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
+		__raw_writel(val, priv->base + offset);
+	else
+		writel(val, priv->base + offset);
 }
 
 static int bcm2835_rng_read(struct hwrng *rng, void *buf, size_t max,
-- 
2.9.3
