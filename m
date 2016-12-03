From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 3 Dec 2016 18:00:52 +0100
Subject: [PATCH 1/2] ARM: mmp: Check return values from ioremap() and
 kstrdup() in sram_probe()
In-Reply-To: <b687577b-e664-6aa1-a85c-438e96216171@users.sourceforge.net>
References: <b687577b-e664-6aa1-a85c-438e96216171@users.sourceforge.net>
Message-ID: <e593f626-3bbd-177a-0774-33536064965e@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Dec 2016 17:26:32 +0100

Two return values were not checked before their further use so far.
This issue was detected by using the Coccinelle software.

* Add a bit of exception handling.

* Adjust tump targets.

Fixes: 3c7241bd36e2a618fe20c91f6c69cc20f2d981f2 ("ARM: mmp: add sram allocator")

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-mmp/sram.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mmp/sram.c b/arch/arm/mach-mmp/sram.c
index bf5e64906e65..0fbfc2a42ab3 100644
--- a/arch/arm/mach-mmp/sram.c
+++ b/arch/arm/mach-mmp/sram.c
@@ -88,14 +88,24 @@ static int sram_probe(struct platform_device *pdev)
 	info->sram_phys   = (phys_addr_t)res->start;
 	info->sram_size   = resource_size(res);
 	info->sram_virt   = ioremap(info->sram_phys, info->sram_size);
+	if (!info->sram_virt) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	info->pool_name	  = kstrdup(pdata->pool_name, GFP_KERNEL);
+	if (!info->pool_name) {
+		ret = -ENOMEM;
+		goto unmap_io;
+	}
+
 	info->granularity = pdata->granularity;
 
 	info->gpool = gen_pool_create(ilog2(info->granularity), -1);
 	if (!info->gpool) {
 		dev_err(&pdev->dev, "create pool failed\n");
 		ret = -ENOMEM;
-		goto create_pool_err;
+		goto free_name;
 	}
 
 	ret = gen_pool_add_virt(info->gpool, (unsigned long)info->sram_virt,
@@ -117,9 +127,10 @@ static int sram_probe(struct platform_device *pdev)
 
 add_chunk_err:
 	gen_pool_destroy(info->gpool);
-create_pool_err:
-	iounmap(info->sram_virt);
+free_name:
 	kfree(info->pool_name);
+unmap_io:
+	iounmap(info->sram_virt);
 out:
 	kfree(info);
 	return ret;
-- 
2.11.0
