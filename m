From: bp@alien8.de (Borislav Petkov)
Date: Tue, 22 Sep 2015 18:37:04 +0200
Subject: [PATCH 4/5] EDAC, i5100: Convert to debugfs wrappers
In-Reply-To: <1442939825-13455-1-git-send-email-bp@alien8.de>
References: <20150922163405.GC3437@pd.tnic>
 <1442939825-13455-1-git-send-email-bp@alien8.de>
Message-ID: <1442939825-13455-4-git-send-email-bp@alien8.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Borislav Petkov <bp@suse.de>

This driver creates its debugfs hierarchy under the toplevel debugfs dir
- see i5100_init() - so make it use edac_debugfs_create_dir_at( , NULL)
because we're not breaking userspace. Oh well.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/i5100_edac.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
index e9f8a393915a..40917775dca1 100644
--- a/drivers/edac/i5100_edac.c
+++ b/drivers/edac/i5100_edac.c
@@ -30,6 +30,7 @@
 #include <linux/debugfs.h>
 
 #include "edac_core.h"
+#include "edac_module.h"
 
 /* register addresses */
 
@@ -966,25 +967,25 @@ static int i5100_setup_debugfs(struct mem_ctl_info *mci)
 	if (!i5100_debugfs)
 		return -ENODEV;
 
-	priv->debugfs = debugfs_create_dir(mci->bus->name, i5100_debugfs);
+	priv->debugfs = edac_debugfs_create_dir_at(mci->bus->name, i5100_debugfs);
 
 	if (!priv->debugfs)
 		return -ENOMEM;
 
-	debugfs_create_x8("inject_channel", S_IRUGO | S_IWUSR, priv->debugfs,
-			&priv->inject_channel);
-	debugfs_create_x8("inject_hlinesel", S_IRUGO | S_IWUSR, priv->debugfs,
-			&priv->inject_hlinesel);
-	debugfs_create_x8("inject_deviceptr1", S_IRUGO | S_IWUSR, priv->debugfs,
-			&priv->inject_deviceptr1);
-	debugfs_create_x8("inject_deviceptr2", S_IRUGO | S_IWUSR, priv->debugfs,
-			&priv->inject_deviceptr2);
-	debugfs_create_x16("inject_eccmask1", S_IRUGO | S_IWUSR, priv->debugfs,
-			&priv->inject_eccmask1);
-	debugfs_create_x16("inject_eccmask2", S_IRUGO | S_IWUSR, priv->debugfs,
-			&priv->inject_eccmask2);
-	debugfs_create_file("inject_enable", S_IWUSR, priv->debugfs,
-			&mci->dev, &i5100_inject_enable_fops);
+	edac_debugfs_create_x8("inject_channel", S_IRUGO | S_IWUSR, priv->debugfs,
+				&priv->inject_channel);
+	edac_debugfs_create_x8("inject_hlinesel", S_IRUGO | S_IWUSR, priv->debugfs,
+				&priv->inject_hlinesel);
+	edac_debugfs_create_x8("inject_deviceptr1", S_IRUGO | S_IWUSR, priv->debugfs,
+				&priv->inject_deviceptr1);
+	edac_debugfs_create_x8("inject_deviceptr2", S_IRUGO | S_IWUSR, priv->debugfs,
+				&priv->inject_deviceptr2);
+	edac_debugfs_create_x16("inject_eccmask1", S_IRUGO | S_IWUSR, priv->debugfs,
+				&priv->inject_eccmask1);
+	edac_debugfs_create_x16("inject_eccmask2", S_IRUGO | S_IWUSR, priv->debugfs,
+				&priv->inject_eccmask2);
+	edac_debugfs_create_file("inject_enable", S_IWUSR, priv->debugfs,
+				&mci->dev, &i5100_inject_enable_fops);
 
 	return 0;
 
@@ -1189,7 +1190,7 @@ static void i5100_remove_one(struct pci_dev *pdev)
 
 	priv = mci->pvt_info;
 
-	debugfs_remove_recursive(priv->debugfs);
+	edac_debugfs_remove_recursive(priv->debugfs);
 
 	priv->scrub_enable = 0;
 	cancel_delayed_work_sync(&(priv->i5100_scrubbing));
@@ -1223,7 +1224,7 @@ static int __init i5100_init(void)
 {
 	int pci_rc;
 
-	i5100_debugfs = debugfs_create_dir("i5100_edac", NULL);
+	i5100_debugfs = edac_debugfs_create_dir_at("i5100_edac", NULL);
 
 	pci_rc = pci_register_driver(&i5100_driver);
 	return (pci_rc < 0) ? pci_rc : 0;
@@ -1231,7 +1232,7 @@ static int __init i5100_init(void)
 
 static void __exit i5100_exit(void)
 {
-	debugfs_remove(i5100_debugfs);
+	edac_debugfs_remove(i5100_debugfs);
 
 	pci_unregister_driver(&i5100_driver);
 }
-- 
2.3.5
