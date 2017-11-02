From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed,  1 Nov 2017 18:04:03 -0700
Subject: [PATCH 07/12] hwrng: bcm2835-rng: Manage an optional clock
In-Reply-To: <20171102010408.27736-1-f.fainelli@gmail.com>
References: <20171102010408.27736-1-f.fainelli@gmail.com>
Message-ID: <20171102010408.27736-8-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the last steps before bcm63xx-rng can be eliminated is to manage
a clock during hwrng::init and hwrng::cleanup, so fetch it in the probe
function, and manage it during these two steps when valid.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/char/hw_random/bcm2835-rng.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/char/hw_random/bcm2835-rng.c b/drivers/char/hw_random/bcm2835-rng.c
index ed20e0b6b7ae..35928efb52e7 100644
--- a/drivers/char/hw_random/bcm2835-rng.c
+++ b/drivers/char/hw_random/bcm2835-rng.c
@@ -15,6 +15,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
+#include <linux/clk.h>
 
 #define RNG_CTRL	0x0
 #define RNG_STATUS	0x4
@@ -33,6 +34,7 @@ struct bcm2835_rng_priv {
 	struct hwrng rng;
 	void __iomem *base;
 	bool mask_interrupts;
+	struct clk *clk;
 };
 
 static inline struct bcm2835_rng_priv *to_rng_priv(struct hwrng *rng)
@@ -67,6 +69,11 @@ static int bcm2835_rng_init(struct hwrng *rng)
 {
 	struct bcm2835_rng_priv *priv = to_rng_priv(rng);
 	u32 val;
+	int ret;
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
 
 	if (priv->mask_interrupts) {
 		/* mask the interrupt */
@@ -88,6 +95,8 @@ static void bcm2835_rng_cleanup(struct hwrng *rng)
 
 	/* disable rng hardware */
 	__raw_writel(0, priv->base + RNG_CTRL);
+
+	clk_disable_unprepare(priv->clk);
 }
 
 struct bcm2835_rng_of_data {
@@ -130,6 +139,11 @@ static int bcm2835_rng_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 	}
 
+	/* Clock is optional on most platforms */
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk))
+		priv->clk = NULL;
+
 	priv->rng.name = "bcm2835-rng";
 	priv->rng.init = bcm2835_rng_init;
 	priv->rng.read = bcm2835_rng_read;
-- 
2.9.3
