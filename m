From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Thu,  5 Jul 2018 12:27:33 +0200
Subject: [PATCH 8/8] mtd: rawnand: plat_nand: Kill pdata->ctrl.{hwcontrol,
 read_byte}()
In-Reply-To: <20180705102733.29673-1-boris.brezillon@bootlin.com>
References: <20180705102733.29673-1-boris.brezillon@bootlin.com>
Message-ID: <20180705102733.29673-9-boris.brezillon@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

None of the board files are overloading those hooks, so let's drop them
from struct platform_nand_ctrl.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 arch/arm/mach-pxa/balloon3.c     | 1 -
 arch/arm/mach-pxa/em-x270.c      | 1 -
 drivers/mtd/nand/raw/plat_nand.c | 2 --
 include/linux/mtd/rawnand.h      | 4 ----
 4 files changed, 8 deletions(-)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index f4f8f23bda8c..af46d2182533 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -688,7 +688,6 @@ struct platform_nand_data balloon3_nand_pdata = {
 		.chip_delay	= 50,
 	},
 	.ctrl = {
-		.hwcontrol	= 0,
 		.dev_ready	= balloon3_nand_dev_ready,
 		.select_chip	= balloon3_nand_select_chip,
 		.cmd_ctrl	= balloon3_nand_cmd_ctl,
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 49022ad338e9..29be04c6cc48 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -346,7 +346,6 @@ struct platform_nand_data em_x270_nand_platdata = {
 		.chip_delay = 20,
 	},
 	.ctrl = {
-		.hwcontrol = 0,
 		.dev_ready = em_x270_nand_device_ready,
 		.select_chip = 0,
 		.cmd_ctrl = em_x270_nand_cmd_ctl,
diff --git a/drivers/mtd/nand/raw/plat_nand.c b/drivers/mtd/nand/raw/plat_nand.c
index 925a1323604d..222626df4b96 100644
--- a/drivers/mtd/nand/raw/plat_nand.c
+++ b/drivers/mtd/nand/raw/plat_nand.c
@@ -67,12 +67,10 @@ static int plat_nand_probe(struct platform_device *pdev)
 	data->chip.select_chip = pdata->ctrl.select_chip;
 	data->chip.write_buf = pdata->ctrl.write_buf;
 	data->chip.read_buf = pdata->ctrl.read_buf;
-	data->chip.read_byte = pdata->ctrl.read_byte;
 	data->chip.chip_delay = pdata->chip.chip_delay;
 	data->chip.options |= pdata->chip.options;
 	data->chip.bbt_options |= pdata->chip.bbt_options;
 
-	data->chip.ecc.hwctl = pdata->ctrl.hwcontrol;
 	data->chip.ecc.mode = NAND_ECC_SOFT;
 	data->chip.ecc.algo = NAND_ECC_HAMMING;
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 5848e01459b0..e383c7f32574 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1573,14 +1573,12 @@ struct platform_device;
  * struct platform_nand_ctrl - controller level device structure
  * @probe:		platform specific function to probe/setup hardware
  * @remove:		platform specific function to remove/teardown hardware
- * @hwcontrol:		platform specific hardware control structure
  * @dev_ready:		platform specific function to read ready/busy pin
  * @select_chip:	platform specific chip select function
  * @cmd_ctrl:		platform specific function for controlling
  *			ALE/CLE/nCE. Also used to write command and address
  * @write_buf:		platform specific function for write buffer
  * @read_buf:		platform specific function for read buffer
- * @read_byte:		platform specific function to read one byte from chip
  * @priv:		private data to transport driver specific settings
  *
  * All fields are optional and depend on the hardware driver requirements
@@ -1588,13 +1586,11 @@ struct platform_device;
 struct platform_nand_ctrl {
 	int (*probe)(struct platform_device *pdev);
 	void (*remove)(struct platform_device *pdev);
-	void (*hwcontrol)(struct mtd_info *mtd, int cmd);
 	int (*dev_ready)(struct mtd_info *mtd);
 	void (*select_chip)(struct mtd_info *mtd, int chip);
 	void (*cmd_ctrl)(struct mtd_info *mtd, int dat, unsigned int ctrl);
 	void (*write_buf)(struct mtd_info *mtd, const uint8_t *buf, int len);
 	void (*read_buf)(struct mtd_info *mtd, uint8_t *buf, int len);
-	unsigned char (*read_byte)(struct mtd_info *mtd);
 	void *priv;
 };
 
-- 
2.14.1
