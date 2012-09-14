From: jean.pihet@newoldbits.com (jean.pihet at newoldbits.com)
Date: Fri, 14 Sep 2012 12:14:54 +0200
Subject: [PATCH] ARM: OMAP: SmartReflex: fix error path in init function
Message-ID: <1347617694-367-1-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean Pihet <j-pihet@ti.com>

Fix the error handling path in omap_sr_probe to correctly
de-allocate resources in case of problems.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 drivers/power/avs/smartreflex.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
index 734493d..a802f4c 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -911,7 +911,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	if (!sr_info->base) {
 		dev_err(&pdev->dev, "%s: ioremap fail\n", __func__);
 		ret = -ENOMEM;
-		goto err_release_region;
+		goto err_free_name;
 	}
 
 	if (irq)
@@ -949,7 +949,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory\n",
 			__func__);
 		ret = PTR_ERR(sr_info->dbg_dir);
-		goto err_free_name;
+		goto err_debugfs;
 	}
 
 	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUSR,
@@ -993,11 +993,11 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 
 err_debugfs:
 	debugfs_remove_recursive(sr_info->dbg_dir);
-err_free_name:
-	kfree(sr_info->name);
 err_iounmap:
 	list_del(&sr_info->node);
 	iounmap(sr_info->base);
+err_free_name:
+	kfree(sr_info->name);
 err_release_region:
 	release_mem_region(mem->start, resource_size(mem));
 err_free_devinfo:
-- 
1.7.7.6
