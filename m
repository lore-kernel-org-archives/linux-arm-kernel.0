From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue,  7 Nov 2017 16:44:38 -0800
Subject: [PATCH v2 01/12] hwrng: bcm2835-rng: Obtain base register via resource
In-Reply-To: <20171108004449.32730-1-f.fainelli@gmail.com>
References: <20171108004449.32730-1-f.fainelli@gmail.com>
Message-ID: <20171108004449.32730-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for consolidating bcm63xx-rng into bcm2835-rng, make sure
that we obtain the base register via platform_get_resource() since we
need to support the non-DT enabled MIPS-based BCM63xx DSL SoCs.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/char/hw_random/bcm2835-rng.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/char/hw_random/bcm2835-rng.c b/drivers/char/hw_random/bcm2835-rng.c
index 574211a49549..a818418a7e4c 100644
--- a/drivers/char/hw_random/bcm2835-rng.c
+++ b/drivers/char/hw_random/bcm2835-rng.c
@@ -81,21 +81,23 @@ static int bcm2835_rng_probe(struct platform_device *pdev)
 	void (*rng_setup)(void __iomem *base);
 	const struct of_device_id *rng_id;
 	void __iomem *rng_base;
+	struct resource *r;
 	int err;
 
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
 	/* map peripheral */
-	rng_base = of_iomap(np, 0);
-	if (!rng_base) {
+	rng_base = devm_ioremap_resource(dev, r);
+	if (IS_ERR(rng_base)) {
 		dev_err(dev, "failed to remap rng regs");
-		return -ENODEV;
+		return PTR_ERR(rng_base);
 	}
 	bcm2835_rng_ops.priv = (unsigned long)rng_base;
 
 	rng_id = of_match_node(bcm2835_rng_of_match, np);
-	if (!rng_id) {
-		iounmap(rng_base);
+	if (!rng_id)
 		return -EINVAL;
-	}
+
 	/* Check for rng init function, execute it */
 	rng_setup = rng_id->data;
 	if (rng_setup)
@@ -107,10 +109,9 @@ static int bcm2835_rng_probe(struct platform_device *pdev)
 
 	/* register driver */
 	err = hwrng_register(&bcm2835_rng_ops);
-	if (err) {
+	if (err)
 		dev_err(dev, "hwrng registration failed\n");
-		iounmap(rng_base);
-	} else
+	else
 		dev_info(dev, "hwrng registered\n");
 
 	return err;
@@ -125,7 +126,6 @@ static int bcm2835_rng_remove(struct platform_device *pdev)
 
 	/* unregister driver */
 	hwrng_unregister(&bcm2835_rng_ops);
-	iounmap(rng_base);
 
 	return 0;
 }
-- 
2.9.3
