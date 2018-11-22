From: tiny.windzz@gmail.com (Yangtao Li)
Date: Thu, 22 Nov 2018 08:07:36 -0500
Subject: [PATCH] soc: ti: Change to use DEFINE_SHOW_ATTRIBUTE macro
Message-ID: <20181122130736.24703-1-tiny.windzz@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/soc/ti/knav_dma.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index e05ab16d9a9e..2a66f36b9fd6 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -355,7 +355,7 @@ static void dma_debug_show_devices(struct seq_file *s,
 	}
 }
 
-static int dma_debug_show(struct seq_file *s, void *v)
+static int knav_dma_debug_show(struct seq_file *s, void *v)
 {
 	struct knav_dma_device *dma;
 
@@ -370,17 +370,7 @@ static int dma_debug_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int knav_dma_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, dma_debug_show, NULL);
-}
-
-static const struct file_operations knav_dma_debug_ops = {
-	.open		= knav_dma_debug_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(knav_dma_debug);
 
 static int of_channel_match_helper(struct device_node *np, const char *name,
 					const char **dma_instance)
@@ -778,7 +768,7 @@ static int knav_dma_probe(struct platform_device *pdev)
 	}
 
 	debugfs_create_file("knav_dma", S_IFREG | S_IRUGO, NULL, NULL,
-			    &knav_dma_debug_ops);
+			    &knav_dma_debug_fops);
 
 	device_ready = true;
 	return ret;
-- 
2.17.0
