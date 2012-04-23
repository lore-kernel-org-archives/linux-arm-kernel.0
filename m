From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 23 Apr 2012 17:05:30 +0100
Subject: [PATCH 04/12] mmc: omap_hsmmc: release correct resource
In-Reply-To: <20120423160409.GE24299@n2100.arm.linux.org.uk>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
Message-ID: <E1SMLla-0002WE-QO@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

res can be one of several resources, as this variable is re-used several
times during probe.  This can cause the wrong resource parameters to be
passed to release_mem_region().

Get the original memory resource before calling release_mem_region().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/omap_hsmmc.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 5c2b1c1..ac26f81a 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2030,7 +2030,9 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 err_alloc:
 	omap_hsmmc_gpio_free(pdata);
 err:
-	release_mem_region(res->start, resource_size(res));
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res)
+		release_mem_region(res->start, resource_size(res));
 	return ret;
 }
 
-- 
1.7.4.4
