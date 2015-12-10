From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:21 +0100
Subject: [PATCH v4 37/58] mtd: nand: r852: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-38-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct nand_chip now embeds an mtd device. Make use of this mtd instance.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/r852.c | 34 +++++++++++++++-------------------
 drivers/mtd/nand/r852.h |  1 -
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/nand/r852.c b/drivers/mtd/nand/r852.c
index ca05b20..1ac8ef2 100644
--- a/drivers/mtd/nand/r852.c
+++ b/drivers/mtd/nand/r852.c
@@ -634,25 +634,22 @@ static void r852_update_media_status(struct r852_device *dev)
  */
 static int r852_register_nand_device(struct r852_device *dev)
 {
-	dev->mtd = kzalloc(sizeof(struct mtd_info), GFP_KERNEL);
-
-	if (!dev->mtd)
-		goto error1;
+	struct mtd_info *mtd = nand_to_mtd(dev->chip);
 
 	WARN_ON(dev->card_registred);
 
-	dev->mtd->priv = dev->chip;
-	dev->mtd->dev.parent = &dev->pci_dev->dev;
+	mtd->priv = dev->chip;
+	mtd->dev.parent = &dev->pci_dev->dev;
 
 	if (dev->readonly)
 		dev->chip->options |= NAND_ROM;
 
 	r852_engine_enable(dev);
 
-	if (sm_register_device(dev->mtd, dev->sm))
-		goto error2;
+	if (sm_register_device(mtd, dev->sm))
+		goto error1;
 
-	if (device_create_file(&dev->mtd->dev, &dev_attr_media_type)) {
+	if (device_create_file(&mtd->dev, &dev_attr_media_type)) {
 		message("can't create media type sysfs attribute");
 		goto error3;
 	}
@@ -660,9 +657,7 @@ static int r852_register_nand_device(struct r852_device *dev)
 	dev->card_registred = 1;
 	return 0;
 error3:
-	nand_release(dev->mtd);
-error2:
-	kfree(dev->mtd);
+	nand_release(mtd);
 error1:
 	/* Force card redetect */
 	dev->card_detected = 0;
@@ -675,15 +670,15 @@ error1:
 
 static void r852_unregister_nand_device(struct r852_device *dev)
 {
+	struct mtd_info *mtd = nand_to_mtd(dev->chip);
+
 	if (!dev->card_registred)
 		return;
 
-	device_remove_file(&dev->mtd->dev, &dev_attr_media_type);
-	nand_release(dev->mtd);
+	device_remove_file(&mtd->dev, &dev_attr_media_type);
+	nand_release(mtd);
 	r852_engine_disable(dev);
 	dev->card_registred = 0;
-	kfree(dev->mtd);
-	dev->mtd = NULL;
 }
 
 /* Card state updater */
@@ -1031,6 +1026,7 @@ static int r852_suspend(struct device *device)
 static int r852_resume(struct device *device)
 {
 	struct r852_device *dev = pci_get_drvdata(to_pci_dev(device));
+	struct mtd_info *mtd = nand_to_mtd(dev->chip);
 
 	r852_disable_irqs(dev);
 	r852_card_update_present(dev);
@@ -1050,9 +1046,9 @@ static int r852_resume(struct device *device)
 	/* Otherwise, initialize the card */
 	if (dev->card_registred) {
 		r852_engine_enable(dev);
-		dev->chip->select_chip(dev->mtd, 0);
-		dev->chip->cmdfunc(dev->mtd, NAND_CMD_RESET, -1, -1);
-		dev->chip->select_chip(dev->mtd, -1);
+		dev->chip->select_chip(mtd, 0);
+		dev->chip->cmdfunc(mtd, NAND_CMD_RESET, -1, -1);
+		dev->chip->select_chip(mtd, -1);
 	}
 
 	/* Program card detection IRQ */
diff --git a/drivers/mtd/nand/r852.h b/drivers/mtd/nand/r852.h
index e6a21d9..d042ddb 100644
--- a/drivers/mtd/nand/r852.h
+++ b/drivers/mtd/nand/r852.h
@@ -108,7 +108,6 @@
 
 struct r852_device {
 	void __iomem *mmio;		/* mmio */
-	struct mtd_info *mtd;		/* mtd backpointer */
 	struct nand_chip *chip;		/* nand chip backpointer */
 	struct pci_dev *pci_dev;	/* pci backpointer */
 
-- 
2.1.4
