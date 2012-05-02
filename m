From: computersforpeace@gmail.com (Brian Norris)
Date: Tue,  1 May 2012 17:12:55 -0700
Subject: [PATCH 3/3] mtd: nand: kill NAND_NO_AUTOINCR option
In-Reply-To: <1335917575-14953-1-git-send-email-computersforpeace@gmail.com>
References: <1335917575-14953-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1335917575-14953-3-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No drivers use auto-increment NAND, so kill the NO_AUTOINCR option entirely.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 Documentation/DocBook/mtdnand.tmpl    |    2 --
 arch/arm/mach-ep93xx/snappercl15.c    |    1 -
 arch/arm/mach-ixp4xx/ixdp425-setup.c  |    1 -
 arch/arm/mach-nomadik/board-nhk8815.c |    2 +-
 arch/mips/rb532/devices.c             |    1 -
 drivers/mtd/nand/au1550nd.c           |    2 --
 drivers/mtd/nand/cafe_nand.c          |    2 +-
 drivers/mtd/nand/cs553x_nand.c        |    1 -
 drivers/mtd/nand/docg4.c              |    3 +--
 drivers/mtd/nand/fsl_elbc_nand.c      |    2 +-
 drivers/mtd/nand/fsl_ifc_nand.c       |    2 +-
 drivers/mtd/nand/h1910.c              |    1 -
 drivers/mtd/nand/mpc5121_nfc.c        |    1 -
 drivers/mtd/nand/nand_base.c          |    8 +-------
 drivers/mtd/nand/nand_ids.c           |    6 ++----
 drivers/mtd/nand/pasemi_nand.c        |    1 -
 drivers/mtd/nand/pxa3xx_nand.c        |    1 -
 drivers/mtd/nand/sh_flctl.c           |    2 --
 drivers/mtd/nand/sm_common.c          |    9 ++++-----
 include/linux/mtd/nand.h              |    5 +----
 20 files changed, 13 insertions(+), 40 deletions(-)

diff --git a/Documentation/DocBook/mtdnand.tmpl b/Documentation/DocBook/mtdnand.tmpl
index 0c674be..e0aedb7 100644
--- a/Documentation/DocBook/mtdnand.tmpl
+++ b/Documentation/DocBook/mtdnand.tmpl
@@ -1119,8 +1119,6 @@ in this page</entry>
 		These constants are defined in nand.h. They are ored together to describe
 		the chip functionality.
      		<programlisting>
-/* Chip can not auto increment pages */
-#define NAND_NO_AUTOINCR	0x00000001
 /* Buswitdh is 16 bit */
 #define NAND_BUSWIDTH_16	0x00000002
 /* Device supports partial programming without padding */
diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index 5df9092..376b8f5 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -100,7 +100,6 @@ static struct platform_nand_data snappercl15_nand_data = {
 		.nr_chips		= 1,
 		.partitions		= snappercl15_nand_parts,
 		.nr_partitions		= ARRAY_SIZE(snappercl15_nand_parts),
-		.options		= NAND_NO_AUTOINCR,
 		.chip_delay		= 25,
 	},
 	.ctrl = {
diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index fccfc73..108a9d3 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -98,7 +98,6 @@ static struct platform_nand_data ixdp425_flash_nand_data = {
 	.chip = {
 		.nr_chips		= 1,
 		.chip_delay		= 30,
-		.options		= NAND_NO_AUTOINCR,
 		.partitions	 	= ixdp425_partitions,
 		.nr_partitions	 	= ARRAY_SIZE(ixdp425_partitions),
 	},
diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index 58cacaf..2e8d3e1 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -111,7 +111,7 @@ static struct nomadik_nand_platform_data nhk8815_nand_data = {
 	.parts		= nhk8815_partitions,
 	.nparts		= ARRAY_SIZE(nhk8815_partitions),
 	.options	= NAND_COPYBACK | NAND_CACHEPRG | NAND_NO_PADDING \
-			| NAND_NO_READRDY | NAND_NO_AUTOINCR,
+			| NAND_NO_READRDY,
 	.init		= nhk8815_nand_init,
 };
 
diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index a969eb8..08c4f8e 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -292,7 +292,6 @@ static void __init rb532_nand_setup(void)
 	rb532_nand_data.chip.nr_partitions = ARRAY_SIZE(rb532_partition_info);
 	rb532_nand_data.chip.partitions = rb532_partition_info;
 	rb532_nand_data.chip.chip_delay = NAND_CHIP_DELAY;
-	rb532_nand_data.chip.options = NAND_NO_AUTOINCR;
 }
 
 
diff --git a/drivers/mtd/nand/au1550nd.c b/drivers/mtd/nand/au1550nd.c
index 73abbc3..9f609d2 100644
--- a/drivers/mtd/nand/au1550nd.c
+++ b/drivers/mtd/nand/au1550nd.c
@@ -508,8 +508,6 @@ static int __devinit au1550nd_probe(struct platform_device *pdev)
 	this->chip_delay = 30;
 	this->ecc.mode = NAND_ECC_SOFT;
 
-	this->options = NAND_NO_AUTOINCR;
-
 	if (pd->devwidth)
 		this->options |= NAND_BUSWIDTH_16;
 
diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index 886ff3a..75fb77b 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -687,7 +687,7 @@ static int __devinit cafe_nand_probe(struct pci_dev *pdev,
 
 	/* Enable the following for a flash based bad block table */
 	cafe->nand.bbt_options = NAND_BBT_USE_FLASH;
-	cafe->nand.options = NAND_NO_AUTOINCR | NAND_OWN_BUFFERS;
+	cafe->nand.options = NAND_OWN_BUFFERS;
 
 	if (skipbbt) {
 		cafe->nand.options |= NAND_SKIP_BBTSCAN;
diff --git a/drivers/mtd/nand/cs553x_nand.c b/drivers/mtd/nand/cs553x_nand.c
index 821c34c..adb6c3e 100644
--- a/drivers/mtd/nand/cs553x_nand.c
+++ b/drivers/mtd/nand/cs553x_nand.c
@@ -240,7 +240,6 @@ static int __init cs553x_init_one(int cs, int mmio, unsigned long adr)
 
 	/* Enable the following for a flash based bad block table */
 	this->bbt_options = NAND_BBT_USE_FLASH;
-	this->options = NAND_NO_AUTOINCR;
 
 	/* Scan to find existence of the device */
 	if (nand_scan(new_mtd, 1)) {
diff --git a/drivers/mtd/nand/docg4.c b/drivers/mtd/nand/docg4.c
index 8e7da01..1540de2 100644
--- a/drivers/mtd/nand/docg4.c
+++ b/drivers/mtd/nand/docg4.c
@@ -1193,8 +1193,7 @@ static void __init init_mtd_structs(struct mtd_info *mtd)
 	nand->ecc.prepad = 8;
 	nand->ecc.bytes	= 8;
 	nand->ecc.strength = DOCG4_T;
-	nand->options =
-		NAND_BUSWIDTH_16 | NAND_NO_SUBPAGE_WRITE | NAND_NO_AUTOINCR;
+	nand->options = NAND_BUSWIDTH_16 | NAND_NO_SUBPAGE_WRITE;
 	nand->IO_ADDR_R = nand->IO_ADDR_W = doc->virtadr + DOC_IOSPACE_DATA;
 	nand->controller = &nand->hwcontrol;
 	spin_lock_init(&nand->controller->lock);
diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 8638b5e..4d99587 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -807,7 +807,7 @@ static int fsl_elbc_chip_init(struct fsl_elbc_mtd *priv)
 	chip->bbt_md = &bbt_mirror_descr;
 
 	/* set up nand options */
-	chip->options = NAND_NO_READRDY | NAND_NO_AUTOINCR;
+	chip->options = NAND_NO_READRDY;
 	chip->bbt_options = NAND_BBT_USE_FLASH;
 
 	chip->controller = &elbc_fcm_ctrl->controller;
diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index 0adde96..dffd2fa 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -806,7 +806,7 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 	out_be32(&ifc->ifc_nand.ncfgr, 0x0);
 
 	/* set up nand options */
-	chip->options = NAND_NO_READRDY | NAND_NO_AUTOINCR;
+	chip->options = NAND_NO_READRDY;
 	chip->bbt_options = NAND_BBT_USE_FLASH;
 
 
diff --git a/drivers/mtd/nand/h1910.c b/drivers/mtd/nand/h1910.c
index 11e4878..85e55a5 100644
--- a/drivers/mtd/nand/h1910.c
+++ b/drivers/mtd/nand/h1910.c
@@ -124,7 +124,6 @@ static int __init h1910_init(void)
 	/* 15 us command delay time */
 	this->chip_delay = 50;
 	this->ecc.mode = NAND_ECC_SOFT;
-	this->options = NAND_NO_AUTOINCR;
 
 	/* Scan to find existence of the device */
 	if (nand_scan(h1910_nand_mtd, 1)) {
diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nfc.c
index c240cf1..c259c24 100644
--- a/drivers/mtd/nand/mpc5121_nfc.c
+++ b/drivers/mtd/nand/mpc5121_nfc.c
@@ -734,7 +734,6 @@ static int __devinit mpc5121_nfc_probe(struct platform_device *op)
 	chip->write_buf = mpc5121_nfc_write_buf;
 	chip->verify_buf = mpc5121_nfc_verify_buf;
 	chip->select_chip = mpc5121_nfc_select_chip;
-	chip->options = NAND_NO_AUTOINCR;
 	chip->bbt_options = NAND_BBT_USE_FLASH;
 	chip->ecc.mode = NAND_ECC_SOFT;
 
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 6246b0f..5ec4d2c 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -2895,8 +2895,7 @@ static int nand_flash_detect_onfi(struct mtd_info *mtd, struct nand_chip *chip,
 		*busw = NAND_BUSWIDTH_16;
 
 	chip->options &= ~NAND_CHIPOPTIONS_MSK;
-	chip->options |= (NAND_NO_READRDY |
-			NAND_NO_AUTOINCR) & NAND_CHIPOPTIONS_MSK;
+	chip->options |= NAND_NO_READRDY & NAND_CHIPOPTIONS_MSK;
 
 	pr_info("ONFI flash detected\n");
 	return 1;
@@ -3073,11 +3072,6 @@ static struct nand_flash_dev *nand_get_flash_type(struct mtd_info *mtd,
 		chip->options &= ~NAND_SAMSUNG_LP_OPTIONS;
 ident_done:
 
-	/*
-	 * Set chip as a default. Board drivers can override it, if necessary.
-	 */
-	chip->options |= NAND_NO_AUTOINCR;
-
 	/* Try to identify manufacturer */
 	for (maf_idx = 0; nand_manuf_ids[maf_idx].id != 0x0; maf_idx++) {
 		if (nand_manuf_ids[maf_idx].id == *maf_id)
diff --git a/drivers/mtd/nand/nand_ids.c b/drivers/mtd/nand/nand_ids.c
index af4fe8c..621b70b 100644
--- a/drivers/mtd/nand/nand_ids.c
+++ b/drivers/mtd/nand/nand_ids.c
@@ -70,7 +70,7 @@ struct nand_flash_dev nand_flash_ids[] = {
 	 * These are the new chips with large page size. The pagesize and the
 	 * erasesize is determined from the extended id bytes
 	 */
-#define LP_OPTIONS (NAND_SAMSUNG_LP_OPTIONS | NAND_NO_READRDY | NAND_NO_AUTOINCR)
+#define LP_OPTIONS (NAND_SAMSUNG_LP_OPTIONS | NAND_NO_READRDY)
 #define LP_OPTIONS16 (LP_OPTIONS | NAND_BUSWIDTH_16)
 
 	/* 512 Megabit */
@@ -157,9 +157,7 @@ struct nand_flash_dev nand_flash_ids[] = {
 	 * writes possible, but not implemented now
 	 */
 	{"AND 128MiB 3,3V 8-bit",	0x01, 2048, 128, 0x4000,
-	 NAND_IS_AND | NAND_NO_AUTOINCR |NAND_NO_READRDY | NAND_4PAGE_ARRAY |
-	 BBT_AUTO_REFRESH
-	},
+	 NAND_IS_AND | NAND_NO_READRDY | NAND_4PAGE_ARRAY | BBT_AUTO_REFRESH},
 
 	{NULL,}
 };
diff --git a/drivers/mtd/nand/pasemi_nand.c b/drivers/mtd/nand/pasemi_nand.c
index 974dbf8..1440e51 100644
--- a/drivers/mtd/nand/pasemi_nand.c
+++ b/drivers/mtd/nand/pasemi_nand.c
@@ -155,7 +155,6 @@ static int __devinit pasemi_nand_probe(struct platform_device *ofdev)
 	chip->ecc.mode = NAND_ECC_SOFT;
 
 	/* Enable the following for a flash based bad block table */
-	chip->options = NAND_NO_AUTOINCR;
 	chip->bbt_options = NAND_BBT_USE_FLASH;
 
 	/* Scan to find existence of the device */
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index def50ca..36a32a0 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1004,7 +1004,6 @@ KEEP_CONFIG:
 	chip->ecc.size = host->page_size;
 	chip->ecc.strength = 1;
 
-	chip->options = NAND_NO_AUTOINCR;
 	chip->options |= NAND_NO_READRDY;
 	if (host->reg_ndcr & NDCR_DWIDTH_M)
 		chip->options |= NAND_BUSWIDTH_16;
diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 4ea3e20..3f0788f 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -881,8 +881,6 @@ static int __devinit flctl_probe(struct platform_device *pdev)
 	flctl->hwecc = pdata->has_hwecc;
 	flctl->holden = pdata->use_holden;
 
-	nand->options = NAND_NO_AUTOINCR;
-
 	/* Set address of hardware control function */
 	/* 20 us command delay time */
 	nand->chip_delay = 20;
diff --git a/drivers/mtd/nand/sm_common.c b/drivers/mtd/nand/sm_common.c
index 774c3c2..082bcdc 100644
--- a/drivers/mtd/nand/sm_common.c
+++ b/drivers/mtd/nand/sm_common.c
@@ -94,17 +94,16 @@ static struct nand_flash_dev nand_smartmedia_flash_ids[] = {
 	{NULL,}
 };
 
-#define XD_TYPEM       (NAND_NO_AUTOINCR | NAND_BROKEN_XD)
 static struct nand_flash_dev nand_xd_flash_ids[] = {
 
 	{"xD 16MiB 3,3V",    0x73, 512, 16, 0x4000, 0},
 	{"xD 32MiB 3,3V",    0x75, 512, 32, 0x4000, 0},
 	{"xD 64MiB 3,3V",    0x76, 512, 64, 0x4000, 0},
 	{"xD 128MiB 3,3V",   0x79, 512, 128, 0x4000, 0},
-	{"xD 256MiB 3,3V",   0x71, 512, 256, 0x4000, XD_TYPEM},
-	{"xD 512MiB 3,3V",   0xdc, 512, 512, 0x4000, XD_TYPEM},
-	{"xD 1GiB 3,3V",     0xd3, 512, 1024, 0x4000, XD_TYPEM},
-	{"xD 2GiB 3,3V",     0xd5, 512, 2048, 0x4000, XD_TYPEM},
+	{"xD 256MiB 3,3V",   0x71, 512, 256, 0x4000, NAND_BROKEN_XD},
+	{"xD 512MiB 3,3V",   0xdc, 512, 512, 0x4000, NAND_BROKEN_XD},
+	{"xD 1GiB 3,3V",     0xd3, 512, 1024, 0x4000, NAND_BROKEN_XD},
+	{"xD 2GiB 3,3V",     0xd5, 512, 2048, 0x4000, NAND_BROKEN_XD},
 	{NULL,}
 };
 
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 2829e8b..2abe758 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -161,8 +161,6 @@ typedef enum {
  * Option constants for bizarre disfunctionality and real
  * features.
  */
-/* Chip can not auto increment pages */
-#define NAND_NO_AUTOINCR	0x00000001
 /* Buswidth is 16 bit */
 #define NAND_BUSWIDTH_16	0x00000002
 /* Device supports partial programming without padding */
@@ -207,7 +205,6 @@ typedef enum {
 	(NAND_NO_PADDING | NAND_CACHEPRG | NAND_COPYBACK)
 
 /* Macros to identify the above */
-#define NAND_CANAUTOINCR(chip) (!(chip->options & NAND_NO_AUTOINCR))
 #define NAND_MUST_PAD(chip) (!(chip->options & NAND_NO_PADDING))
 #define NAND_HAS_CACHEPROG(chip) ((chip->options & NAND_CACHEPRG))
 #define NAND_HAS_COPYBACK(chip) ((chip->options & NAND_COPYBACK))
@@ -216,7 +213,7 @@ typedef enum {
 					&& (chip->page_shift > 9))
 
 /* Mask to zero out the chip options, which come from the id table */
-#define NAND_CHIPOPTIONS_MSK	(0x0000ffff & ~NAND_NO_AUTOINCR)
+#define NAND_CHIPOPTIONS_MSK	0x0000ffff
 
 /* Non chip related options */
 /* This option skips the bbt scan during initialization. */
-- 
1.7.5.4.2.g519b1
