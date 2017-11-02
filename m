From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed,  1 Nov 2017 18:04:02 -0700
Subject: [PATCH 06/12] hwrng: bcm2835-rng: Rework interrupt masking
In-Reply-To: <20171102010408.27736-1-f.fainelli@gmail.com>
References: <20171102010408.27736-1-f.fainelli@gmail.com>
Message-ID: <20171102010408.27736-7-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The interrupt masking done for Northstart Plus and Northstar (BCM5301X)
is moved from being a function pointer mapped to of_device_id::data into
a proper part of the hwrng::init callback. While at it, we also make the
of_data be a proper structure indicating the platform specifics, since
the day we need to add a second type of platform information, we would
have to do that anyway.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/char/hw_random/bcm2835-rng.c | 39 +++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/char/hw_random/bcm2835-rng.c b/drivers/char/hw_random/bcm2835-rng.c
index 67b9bd3be28d..ed20e0b6b7ae 100644
--- a/drivers/char/hw_random/bcm2835-rng.c
+++ b/drivers/char/hw_random/bcm2835-rng.c
@@ -32,18 +32,9 @@
 struct bcm2835_rng_priv {
 	struct hwrng rng;
 	void __iomem *base;
+	bool mask_interrupts;
 };
 
-static void __init nsp_rng_init(void __iomem *base)
-{
-	u32 val;
-
-	/* mask the interrupt */
-	val = readl(base + RNG_INT_MASK);
-	val |= RNG_INT_OFF;
-	writel(val, base + RNG_INT_MASK);
-}
-
 static inline struct bcm2835_rng_priv *to_rng_priv(struct hwrng *rng)
 {
 	return container_of(rng, struct bcm2835_rng_priv, rng);
@@ -75,6 +66,14 @@ static int bcm2835_rng_read(struct hwrng *rng, void *buf, size_t max,
 static int bcm2835_rng_init(struct hwrng *rng)
 {
 	struct bcm2835_rng_priv *priv = to_rng_priv(rng);
+	u32 val;
+
+	if (priv->mask_interrupts) {
+		/* mask the interrupt */
+		val = readl(priv->base + RNG_INT_MASK);
+		val |= RNG_INT_OFF;
+		writel(val, priv->base + RNG_INT_MASK);
+	}
 
 	/* set warm-up count & enable */
 	__raw_writel(RNG_WARMUP_COUNT, priv->base + RNG_STATUS);
@@ -91,18 +90,26 @@ static void bcm2835_rng_cleanup(struct hwrng *rng)
 	__raw_writel(0, priv->base + RNG_CTRL);
 }
 
+struct bcm2835_rng_of_data {
+	bool mask_interrupts;
+};
+
+static const struct bcm2835_rng_of_data nsp_rng_of_data = {
+	.mask_interrupts = true,
+};
+
 static const struct of_device_id bcm2835_rng_of_match[] = {
 	{ .compatible = "brcm,bcm2835-rng"},
-	{ .compatible = "brcm,bcm-nsp-rng", .data = nsp_rng_init},
-	{ .compatible = "brcm,bcm5301x-rng", .data = nsp_rng_init},
+	{ .compatible = "brcm,bcm-nsp-rng", .data = &nsp_rng_of_data },
+	{ .compatible = "brcm,bcm5301x-rng", .data = &nsp_rng_of_data },
 	{},
 };
 
 static int bcm2835_rng_probe(struct platform_device *pdev)
 {
+	const struct bcm2835_rng_of_data *of_data;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	void (*rng_setup)(void __iomem *base);
 	const struct of_device_id *rng_id;
 	struct bcm2835_rng_priv *priv;
 	struct resource *r;
@@ -133,9 +140,9 @@ static int bcm2835_rng_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	/* Check for rng init function, execute it */
-	rng_setup = rng_id->data;
-	if (rng_setup)
-		rng_setup(priv->base);
+	of_data = rng_id->data;
+	if (of_data)
+		priv->mask_interrupts = of_data->mask_interrupts;
 
 	/* register driver */
 	err = devm_hwrng_register(dev, &priv->rng);
-- 
2.9.3
