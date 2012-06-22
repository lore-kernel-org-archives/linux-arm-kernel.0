From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 22 Jun 2012 19:18:02 +0530
Subject: [PATCH 03/11] hwrng: omap: add clk_prepare and clk_unprepare
In-Reply-To: <1340372890-10091-1-git-send-email-rnayak@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
Message-ID: <1340372890-10091-4-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
and clk_unprepare() for the rng interface clock as part of the drivers
probe() and remove() routines.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Deepak Saxena <dsaxena@plexity.net>
Cc: Matt Mackall <mpm@selenic.com>
---
 drivers/char/hw_random/omap-rng.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index 1412565..500604a 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -110,7 +110,7 @@ static int __devinit omap_rng_probe(struct platform_device *pdev)
 			ret = PTR_ERR(rng_ick);
 			return ret;
 		} else
-			clk_enable(rng_ick);
+			clk_prepare_enable(rng_ick);
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -138,7 +138,7 @@ err_register:
 	rng_base = NULL;
 err_ioremap:
 	if (cpu_is_omap24xx()) {
-		clk_disable(rng_ick);
+		clk_disable_unprepare(rng_ick);
 		clk_put(rng_ick);
 	}
 	return ret;
@@ -151,7 +151,7 @@ static int __exit omap_rng_remove(struct platform_device *pdev)
 	omap_rng_write_reg(RNG_MASK_REG, 0x0);
 
 	if (cpu_is_omap24xx()) {
-		clk_disable(rng_ick);
+		clk_disable_unprepare(rng_ick);
 		clk_put(rng_ick);
 	}
 
-- 
1.7.1
