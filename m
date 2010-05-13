From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Thu, 13 May 2010 18:09:16 +0530
Subject: [PATCH v2 1/2] nomadik hwrng: Add clock support
Message-ID: <1273754356-23523-1-git-send-email-srinidhi.kasagar@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the clock support to the Nomadik RNG driver

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Linus walleij <linus.walleij@stericsson.com>
Acked-by: Alessandro Rubini <rubini@unipv.it>
---
 arch/arm/mach-nomadik/clock.c        |    1 +
 drivers/char/hw_random/nomadik-rng.c |   17 +++++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-nomadik/clock.c b/arch/arm/mach-nomadik/clock.c
index 60f5bee..2c471fc 100644
--- a/arch/arm/mach-nomadik/clock.c
+++ b/arch/arm/mach-nomadik/clock.c
@@ -56,6 +56,7 @@ static struct clk_lookup lookups[] = {
 	CLK(&clk_default, "gpio.1"),
 	CLK(&clk_default, "gpio.2"),
 	CLK(&clk_default, "gpio.3"),
+	CLK(&clk_default, "rng"),
 };
 
 static int __init clk_init(void)
diff --git a/drivers/char/hw_random/nomadik-rng.c b/drivers/char/hw_random/nomadik-rng.c
index a8b4c40..a348c7e 100644
--- a/drivers/char/hw_random/nomadik-rng.c
+++ b/drivers/char/hw_random/nomadik-rng.c
@@ -15,6 +15,10 @@
 #include <linux/amba/bus.h>
 #include <linux/hw_random.h>
 #include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+
+static struct clk *rng_clk;
 
 static int nmk_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
@@ -40,6 +44,15 @@ static int nmk_rng_probe(struct amba_device *dev, struct amba_id *id)
 	void __iomem *base;
 	int ret;
 
+	rng_clk = clk_get(&dev->dev, NULL);
+	if (IS_ERR(rng_clk)) {
+		dev_err(&dev->dev, "could not get rng clock\n");
+		ret = PTR_ERR(rng_clk);
+		return ret;
+	}
+
+	clk_enable(rng_clk);
+
 	ret = amba_request_regions(dev, dev->dev.init_name);
 	if (ret)
 		return ret;
@@ -57,6 +70,8 @@ out_unmap:
 	iounmap(base);
 out_release:
 	amba_release_regions(dev);
+	clk_disable(rng_clk);
+	clk_put(rng_clk);
 	return ret;
 }
 
@@ -66,6 +81,8 @@ static int nmk_rng_remove(struct amba_device *dev)
 	hwrng_unregister(&nmk_rng);
 	iounmap(base);
 	amba_release_regions(dev);
+	clk_disable(rng_clk);
+	clk_put(rng_clk);
 	return 0;
 }
 
-- 
1.6.3.3
