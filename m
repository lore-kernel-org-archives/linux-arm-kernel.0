From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 29 Mar 2016 09:18:02 +0200
Subject: [PULL 2/4] mtd: pxa2xx-flash: switch back from memremap to
 ioremap_cached
In-Reply-To: <1459235884-24318-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1459235884-24318-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1459235884-24318-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 06968a54790d ("mtd: pxa2xx-flash: switch from
ioremap_cache to memremap"), since NOR with memory semantics in array mode
and RAM are not necessarily the same thing, and architectures may implement
ioremap_cached() and memremap() with different memory attributes.

For this reason, ioremap_cached() has been brought back from the dead on
the ARM side, so switch this driver back to using it instead of memremap().

Cc: David Woodhouse <dwmw2@infradead.org>
Acked-by: Brian Norris <computersforpeace@gmail.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/mtd/maps/pxa2xx-flash.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/maps/pxa2xx-flash.c b/drivers/mtd/maps/pxa2xx-flash.c
index 7497090e9900..2cde28ed95c9 100644
--- a/drivers/mtd/maps/pxa2xx-flash.c
+++ b/drivers/mtd/maps/pxa2xx-flash.c
@@ -71,8 +71,8 @@ static int pxa2xx_flash_probe(struct platform_device *pdev)
 		       info->map.name);
 		return -ENOMEM;
 	}
-	info->map.cached = memremap(info->map.phys, info->map.size,
-			MEMREMAP_WB);
+	info->map.cached =
+		ioremap_cached(info->map.phys, info->map.size);
 	if (!info->map.cached)
 		printk(KERN_WARNING "Failed to ioremap cached %s\n",
 		       info->map.name);
@@ -111,7 +111,7 @@ static int pxa2xx_flash_remove(struct platform_device *dev)
 	map_destroy(info->mtd);
 	iounmap(info->map.virt);
 	if (info->map.cached)
-		memunmap(info->map.cached);
+		iounmap(info->map.cached);
 	kfree(info);
 	return 0;
 }
-- 
2.5.0
