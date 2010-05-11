From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Tue, 11 May 2010 12:25:44 +0530
Subject: [PATCH 1/2] nomadik hwrng: Add clock support
Message-ID: <1273560944-13243-1-git-send-email-srinidhi.kasagar@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the clock support to the Nomadik RNG driver

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/char/hw_random/nomadik-rng.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/char/hw_random/nomadik-rng.c b/drivers/char/hw_random/nomadik-rng.c
index a8b4c40..ae094c1 100644
--- a/drivers/char/hw_random/nomadik-rng.c
+++ b/drivers/char/hw_random/nomadik-rng.c
@@ -15,6 +15,10 @@
 #include <linux/amba/bus.h>
 #include <linux/hw_random.h>
 #include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+
+struct clk *rng_clk;
 
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
