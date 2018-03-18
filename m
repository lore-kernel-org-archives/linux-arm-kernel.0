From: arushisinghal19971997@gmail.com (Arushi Singhal)
Date: Sun, 18 Mar 2018 22:03:15 +0530
Subject: [PATCH v2 1/2] mtd: maps: Remove print after allocation failure
Message-ID: <1521390796-13715-1-git-send-email-arushisinghal19971997@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The prints after [k|v][m|z|c]alloc() functions are not needed, because
in case of failure, allocator will print their internal error prints
anyway.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
changes in v2
* done changes in all the other files.

 drivers/mtd/maps/amd76xrom.c  | 6 ++----
 drivers/mtd/maps/ck804xrom.c  | 4 +---
 drivers/mtd/maps/esb2rom.c    | 4 +---
 drivers/mtd/maps/ichxrom.c    | 6 ++----
 drivers/mtd/maps/sun_uflash.c | 4 +---
 drivers/mtd/maps/vmu-flash.c  | 3 ---
 6 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/maps/amd76xrom.c b/drivers/mtd/maps/amd76xrom.c
index 26de0a1..406a8d3 100644
--- a/drivers/mtd/maps/amd76xrom.c
+++ b/drivers/mtd/maps/amd76xrom.c
@@ -188,10 +188,8 @@ static int amd76xrom_init_one(struct pci_dev *pdev,
 
 		if (!map) {
 			map = kmalloc(sizeof(*map), GFP_KERNEL);
-		}
-		if (!map) {
-			printk(KERN_ERR MOD_NAME ": kmalloc failed");
-			goto out;
+			if (!map)
+				goto out;
 		}
 		memset(map, 0, sizeof(*map));
 		INIT_LIST_HEAD(&map->list);
diff --git a/drivers/mtd/maps/ck804xrom.c b/drivers/mtd/maps/ck804xrom.c
index 584962e..2529d1b 100644
--- a/drivers/mtd/maps/ck804xrom.c
+++ b/drivers/mtd/maps/ck804xrom.c
@@ -219,10 +219,8 @@ static int __init ck804xrom_init_one(struct pci_dev *pdev,
 		if (!map)
 			map = kmalloc(sizeof(*map), GFP_KERNEL);
 
-		if (!map) {
-			printk(KERN_ERR MOD_NAME ": kmalloc failed");
+		if (!map)
 			goto out;
-		}
 		memset(map, 0, sizeof(*map));
 		INIT_LIST_HEAD(&map->list);
 		map->map.name = map->map_name;
diff --git a/drivers/mtd/maps/esb2rom.c b/drivers/mtd/maps/esb2rom.c
index da9f6d7..e50f1a4 100644
--- a/drivers/mtd/maps/esb2rom.c
+++ b/drivers/mtd/maps/esb2rom.c
@@ -278,10 +278,8 @@ static int __init esb2rom_init_one(struct pci_dev *pdev,
 
 		if (!map)
 			map = kmalloc(sizeof(*map), GFP_KERNEL);
-		if (!map) {
-			printk(KERN_ERR MOD_NAME ": kmalloc failed");
+		if (!map)
 			goto out;
-		}
 		memset(map, 0, sizeof(*map));
 		INIT_LIST_HEAD(&map->list);
 		map->map.name = map->map_name;
diff --git a/drivers/mtd/maps/ichxrom.c b/drivers/mtd/maps/ichxrom.c
index 1888c5b..cacef9d 100644
--- a/drivers/mtd/maps/ichxrom.c
+++ b/drivers/mtd/maps/ichxrom.c
@@ -212,10 +212,8 @@ static int __init ichxrom_init_one(struct pci_dev *pdev,
 
 		if (!map) {
 			map = kmalloc(sizeof(*map), GFP_KERNEL);
-		}
-		if (!map) {
-			printk(KERN_ERR MOD_NAME ": kmalloc failed");
-			goto out;
+			if (!map)
+				goto out;
 		}
 		memset(map, 0, sizeof(*map));
 		INIT_LIST_HEAD(&map->list);
diff --git a/drivers/mtd/maps/sun_uflash.c b/drivers/mtd/maps/sun_uflash.c
index 1e73bba..80a253c 100644
--- a/drivers/mtd/maps/sun_uflash.c
+++ b/drivers/mtd/maps/sun_uflash.c
@@ -62,10 +62,8 @@ int uflash_devinit(struct platform_device *op, struct device_node *dp)
 	}
 
 	up = kzalloc(sizeof(struct uflash_dev), GFP_KERNEL);
-	if (!up) {
-		printk(KERN_ERR PFX "Cannot allocate struct uflash_dev\n");
+	if (!up)
 		return -ENOMEM;
-	}
 
 	/* copy defaults and tweak parameters */
 	memcpy(&up->map, &uflash_map_templ, sizeof(uflash_map_templ));
diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index 6b223cf..a76a5ff 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -130,9 +130,6 @@ static int maple_vmu_read_block(unsigned int num, unsigned char *buf,
 	if (!pcache->buffer) {
 		pcache->buffer = kmalloc(card->blocklen, GFP_KERNEL);
 		if (!pcache->buffer) {
-			dev_err(&mdev->dev, "VMU at (%d, %d) - read fails due"
-				" to lack of memory\n", mdev->port,
-				mdev->unit);
 			error = -ENOMEM;
 			goto outB;
 		}
-- 
2.7.4
