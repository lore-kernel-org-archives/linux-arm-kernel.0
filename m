From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 31 May 2011 16:31:22 -0700
Subject: [PATCH 3/8] mtd: nand: consolidate redundant flash-based BBT
 flags
In-Reply-To: <1306884687-1824-1-git-send-email-computersforpeace@gmail.com>
References: <1306884687-1824-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1306884687-1824-4-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch works with the following three flags from two headers (nand.h
and bbm.h):
  (1) NAND_USE_FLASH_BBT (nand.h)
  (2) NAND_USE_FLASH_BBT_NO_OOB (nand.h)
  (3) NAND_BBT_NO_OOB (bbm.h)

These flags are all related and interdependent, yet they were in
different headers. Flag (2) is simply the combination of (1) and (3) and
can be eliminated.

This patch accomplishes the following:
  * eliminate NAND_USE_FLASH_BBT_NO_OOB (i.e., flag (2))
  * move NAND_USE_FLASH_BBT (i.e., flag (1)) to bbm.h

It's important to note that because (1) and (3) are now both found in
bbm.h, they should NOT be used in the "nand_chip.options" field.

I removed a small section from the mtdnand DocBook because it referes to
NAND_USE_FLASH_BBT in nand.h, which has been moved to bbm.h.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 Documentation/DocBook/mtdnand.tmpl             |    5 +----
 arch/arm/mach-davinci/board-da830-evm.c        |    2 +-
 arch/arm/mach-davinci/board-da850-evm.c        |    2 +-
 arch/arm/mach-davinci/board-dm355-evm.c        |    2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c    |    2 +-
 arch/arm/mach-davinci/board-dm365-evm.c        |    2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c       |    2 +-
 arch/arm/mach-davinci/board-mityomapl138.c     |    3 ++-
 arch/arm/mach-davinci/board-neuros-osd2.c      |    2 +-
 arch/arm/mach-davinci/board-tnetv107x-evm.c    |    2 +-
 arch/arm/mach-davinci/include/mach/nand.h      |    4 +++-
 arch/arm/mach-orion5x/ts78xx-setup.c           |    2 +-
 arch/cris/arch-v32/drivers/mach-a3/nandflash.c |    2 +-
 arch/cris/arch-v32/drivers/mach-fs/nandflash.c |    2 +-
 drivers/mtd/nand/atmel_nand.c                  |    2 +-
 drivers/mtd/nand/autcpu12.c                    |    4 ++--
 drivers/mtd/nand/bcm_umi_nand.c                |    2 +-
 drivers/mtd/nand/cafe_nand.c                   |    3 ++-
 drivers/mtd/nand/cs553x_nand.c                 |    3 ++-
 drivers/mtd/nand/davinci_nand.c                |    4 +++-
 drivers/mtd/nand/denali.c                      |    3 ++-
 drivers/mtd/nand/diskonchip.c                  |    2 +-
 drivers/mtd/nand/fsl_elbc_nand.c               |    4 ++--
 drivers/mtd/nand/mpc5121_nfc.c                 |    3 ++-
 drivers/mtd/nand/mxc_nand.c                    |    2 +-
 drivers/mtd/nand/nand_base.c                   |    2 +-
 drivers/mtd/nand/nand_bbt.c                    |   20 ++++++++++----------
 drivers/mtd/nand/nandsim.c                     |    4 ++--
 drivers/mtd/nand/pasemi_nand.c                 |    3 ++-
 drivers/mtd/nand/s3c2410.c                     |    6 ++++--
 include/linux/mtd/bbm.h                        |    9 +++++++--
 include/linux/mtd/nand.h                       |   10 ----------
 32 files changed, 62 insertions(+), 58 deletions(-)

diff --git a/Documentation/DocBook/mtdnand.tmpl b/Documentation/DocBook/mtdnand.tmpl
index 17910e2..05cc83e 100644
--- a/Documentation/DocBook/mtdnand.tmpl
+++ b/Documentation/DocBook/mtdnand.tmpl
@@ -572,7 +572,7 @@ static void board_select_chip (struct mtd_info *mtd, int chip)
 			</para>
 			<para>
 				The simplest way to activate the FLASH based bad block table support 
-				is to set the option NAND_USE_FLASH_BBT in the option field of
+				is to set the option NAND_USE_FLASH_BBT in the bbt_option field of
 				the nand chip structure before calling nand_scan(). For AG-AND
 				chips is this done by default.
 				This activates the default FLASH based bad block table functionality 
@@ -1158,9 +1158,6 @@ in this page</entry>
 		These constants are defined in nand.h. They are ored together to describe
 		the functionality.
      		<programlisting>
-/* Use a flash based bad block table. This option is parsed by the
- * default bad block table function (nand_default_bbt). */
-#define NAND_USE_FLASH_BBT	0x00010000
 /* The hw ecc generator provides a syndrome instead a ecc value on read 
  * This can only work if we have the ecc bytes directly behind the 
  * data bytes. Applies for DOC and AG-AND Renesas HW Reed Solomon generators */
diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 8bc3701..788adc8 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -377,7 +377,7 @@ static struct davinci_nand_pdata da830_evm_nand_pdata = {
 	.nr_parts	= ARRAY_SIZE(da830_evm_nand_partitions),
 	.ecc_mode	= NAND_ECC_HW,
 	.ecc_bits	= 4,
-	.options	= NAND_USE_FLASH_BBT,
+	.bbt_options	= NAND_USE_FLASH_BBT,
 	.bbt_td		= &da830_evm_nand_bbt_main_descr,
 	.bbt_md		= &da830_evm_nand_bbt_mirror_descr,
 	.timing         = &da830_evm_nandflash_timing,
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index a7b41bf..8bfad01 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -225,7 +225,7 @@ static struct davinci_nand_pdata da850_evm_nandflash_data = {
 	.nr_parts	= ARRAY_SIZE(da850_evm_nandflash_partition),
 	.ecc_mode	= NAND_ECC_HW,
 	.ecc_bits	= 4,
-	.options	= NAND_USE_FLASH_BBT,
+	.bbt_options	= NAND_USE_FLASH_BBT,
 	.timing		= &da850_evm_nandflash_timing,
 };
 
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 6e7cad1..d857b70 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -77,7 +77,7 @@ static struct davinci_nand_pdata davinci_nand_data = {
 	.parts			= davinci_nand_partitions,
 	.nr_parts		= ARRAY_SIZE(davinci_nand_partitions),
 	.ecc_mode		= NAND_ECC_HW,
-	.options		= NAND_USE_FLASH_BBT,
+	.bbt_options		= NAND_USE_FLASH_BBT,
 	.ecc_bits		= 4,
 };
 
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index 543f991..b24dfd0 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -74,7 +74,7 @@ static struct davinci_nand_pdata davinci_nand_data = {
 	.parts			= davinci_nand_partitions,
 	.nr_parts		= ARRAY_SIZE(davinci_nand_partitions),
 	.ecc_mode		= NAND_ECC_HW_SYNDROME,
-	.options		= NAND_USE_FLASH_BBT,
+	.bbt_options		= NAND_USE_FLASH_BBT,
 };
 
 static struct resource davinci_nand_resources[] = {
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index c67f684..9a74857 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -139,7 +139,7 @@ static struct davinci_nand_pdata davinci_nand_data = {
 	.parts			= davinci_nand_partitions,
 	.nr_parts		= ARRAY_SIZE(davinci_nand_partitions),
 	.ecc_mode		= NAND_ECC_HW,
-	.options		= NAND_USE_FLASH_BBT,
+	.bbt_options		= NAND_USE_FLASH_BBT,
 	.ecc_bits		= 4,
 };
 
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 556bbd4..012750f 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -150,7 +150,7 @@ static struct davinci_nand_pdata davinci_evm_nandflash_data = {
 	.parts		= davinci_evm_nandflash_partition,
 	.nr_parts	= ARRAY_SIZE(davinci_evm_nandflash_partition),
 	.ecc_mode	= NAND_ECC_HW,
-	.options	= NAND_USE_FLASH_BBT,
+	.bbt_options	= NAND_USE_FLASH_BBT,
 	.timing		= &davinci_evm_nandflash_timing,
 };
 
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 606a6f2..ba52254 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -395,7 +395,8 @@ static struct davinci_nand_pdata mityomapl138_nandflash_data = {
 	.parts		= mityomapl138_nandflash_partition,
 	.nr_parts	= ARRAY_SIZE(mityomapl138_nandflash_partition),
 	.ecc_mode	= NAND_ECC_HW,
-	.options	= NAND_USE_FLASH_BBT | NAND_BUSWIDTH_16,
+	.bbt_options	= NAND_USE_FLASH_BBT,
+	.options	= NAND_BUSWIDTH_16,
 	.ecc_bits	= 1, /* 4 bit mode is not supported with 16 bit NAND */
 };
 
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 3e7be2d..89bf0b5 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -87,7 +87,7 @@ static struct davinci_nand_pdata davinci_ntosd2_nandflash_data = {
 	.parts		= davinci_ntosd2_nandflash_partition,
 	.nr_parts	= ARRAY_SIZE(davinci_ntosd2_nandflash_partition),
 	.ecc_mode	= NAND_ECC_HW,
-	.options	= NAND_USE_FLASH_BBT,
+	.bbt_options	= NAND_USE_FLASH_BBT,
 };
 
 static struct resource davinci_ntosd2_nandflash_resource[] = {
diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index 1a656e8..f98896c 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -144,7 +144,7 @@ static struct davinci_nand_pdata nand_config = {
 	.parts		= nand_partitions,
 	.nr_parts	= ARRAY_SIZE(nand_partitions),
 	.ecc_mode	= NAND_ECC_HW,
-	.options	= NAND_USE_FLASH_BBT,
+	.bbt_options	= NAND_USE_FLASH_BBT,
 	.ecc_bits	= 1,
 };
 
diff --git a/arch/arm/mach-davinci/include/mach/nand.h b/arch/arm/mach-davinci/include/mach/nand.h
index 0251510..2c506f9 100644
--- a/arch/arm/mach-davinci/include/mach/nand.h
+++ b/arch/arm/mach-davinci/include/mach/nand.h
@@ -74,8 +74,10 @@ struct davinci_nand_pdata {		/* platform_data */
 	nand_ecc_modes_t	ecc_mode;
 	u8			ecc_bits;
 
-	/* e.g. NAND_BUSWIDTH_16 or NAND_USE_FLASH_BBT */
+	/* e.g. NAND_BUSWIDTH_16 */
 	unsigned		options;
+	/* e.g. NAND_USE_FLASH_BBT */
+	unsigned		bbt_options;
 
 	/* Main and mirror bbt descriptor overrides */
 	struct nand_bbt_descr	*bbt_td;
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index 6b7b541..e5ca57c 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -275,7 +275,7 @@ static struct platform_nand_data ts78xx_ts_nand_data = {
 		.partitions		= ts78xx_ts_nand_parts,
 		.nr_partitions		= ARRAY_SIZE(ts78xx_ts_nand_parts),
 		.chip_delay		= 15,
-		.options		= NAND_USE_FLASH_BBT,
+		.bbt_options		= NAND_USE_FLASH_BBT,
 	},
 	.ctrl	= {
 		/*
diff --git a/arch/cris/arch-v32/drivers/mach-a3/nandflash.c b/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
index f58f2c1..fdd11c1 100644
--- a/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
+++ b/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
@@ -163,7 +163,7 @@ struct mtd_info *__init crisv32_nand_flash_probe(void)
 	this->ecc.mode = NAND_ECC_SOFT;
 
 	/* Enable the following for a flash based bad block table */
-	/* this->options = NAND_USE_FLASH_BBT; */
+	/* this->bbt_options = NAND_USE_FLASH_BBT; */
 
 	/* Scan to find existence of the device */
 	if (nand_scan(crisv32_mtd, 1)) {
diff --git a/arch/cris/arch-v32/drivers/mach-fs/nandflash.c b/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
index d5b0cc9..3368177 100644
--- a/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
+++ b/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
@@ -154,7 +154,7 @@ struct mtd_info *__init crisv32_nand_flash_probe(void)
 	this->ecc.mode = NAND_ECC_SOFT;
 
 	/* Enable the following for a flash based bad block table */
-	/* this->options = NAND_USE_FLASH_BBT; */
+	/* this->bbt_options = NAND_USE_FLASH_BBT; */
 
 	/* Scan to find existence of the device */
 	if (nand_scan(crisv32_mtd, 1)) {
diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index b300705..4afdc83 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -582,7 +582,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 
 	if (on_flash_bbt) {
 		printk(KERN_INFO "atmel_nand: Use On Flash BBT\n");
-		nand_chip->options |= NAND_USE_FLASH_BBT;
+		nand_chip->bbt_options |= NAND_USE_FLASH_BBT;
 	}
 
 	if (!cpu_has_dma())
diff --git a/drivers/mtd/nand/autcpu12.c b/drivers/mtd/nand/autcpu12.c
index eddc9a2..adf934d 100644
--- a/drivers/mtd/nand/autcpu12.c
+++ b/drivers/mtd/nand/autcpu12.c
@@ -172,9 +172,9 @@ static int __init autcpu12_init(void)
 
 	/* Enable the following for a flash based bad block table */
 	/*
-	   this->options = NAND_USE_FLASH_BBT;
+	   this->bbt_options = NAND_USE_FLASH_BBT;
 	 */
-	this->options = NAND_USE_FLASH_BBT;
+	this->bbt_options = NAND_USE_FLASH_BBT;
 
 	/* Scan to find existence of the device */
 	if (nand_scan(autcpu12_mtd, 1)) {
diff --git a/drivers/mtd/nand/bcm_umi_nand.c b/drivers/mtd/nand/bcm_umi_nand.c
index 9ec2807..8ae9ad9 100644
--- a/drivers/mtd/nand/bcm_umi_nand.c
+++ b/drivers/mtd/nand/bcm_umi_nand.c
@@ -474,7 +474,7 @@ static int __devinit bcm_umi_nand_probe(struct platform_device *pdev)
 
 #if NAND_ECC_BCH
 	if (board_mtd->writesize > 512) {
-		if (this->options & NAND_USE_FLASH_BBT)
+		if (this->bbt_options & NAND_USE_FLASH_BBT)
 			largepage_bbt.options = NAND_BBT_SCAN2NDPAGE;
 		this->badblock_pattern = &largepage_bbt;
 	}
diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index 87ebb4e..7dd7d84 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -686,7 +686,8 @@ static int __devinit cafe_nand_probe(struct pci_dev *pdev,
 	cafe->nand.chip_delay = 0;
 
 	/* Enable the following for a flash based bad block table */
-	cafe->nand.options = NAND_USE_FLASH_BBT | NAND_NO_AUTOINCR | NAND_OWN_BUFFERS;
+	cafe->nand.bbt_options = NAND_USE_FLASH_BBT;
+	cafe->nand.options = NAND_NO_AUTOINCR | NAND_OWN_BUFFERS;
 
 	if (skipbbt) {
 		cafe->nand.options |= NAND_SKIP_BBTSCAN;
diff --git a/drivers/mtd/nand/cs553x_nand.c b/drivers/mtd/nand/cs553x_nand.c
index f59ad1f..05adedd 100644
--- a/drivers/mtd/nand/cs553x_nand.c
+++ b/drivers/mtd/nand/cs553x_nand.c
@@ -239,7 +239,8 @@ static int __init cs553x_init_one(int cs, int mmio, unsigned long adr)
 	this->ecc.correct  = nand_correct_data;
 
 	/* Enable the following for a flash based bad block table */
-	this->options = NAND_USE_FLASH_BBT | NAND_NO_AUTOINCR;
+	this->bbt_options = NAND_USE_FLASH_BBT;
+	this->options = NAND_NO_AUTOINCR;
 
 	/* Scan to find existence of the device */
 	if (nand_scan(new_mtd, 1)) {
diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index 1f34951..69f7019 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -581,7 +581,9 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
 	info->chip.chip_delay	= 0;
 	info->chip.select_chip	= nand_davinci_select_chip;
 
-	/* options such as NAND_USE_FLASH_BBT or 16-bit widths */
+	/* options such as NAND_USE_FLASH_BBT */
+	info->chip.bbt_options	= pdata->bbt_options;
+	/* options such as 16-bit widths */
 	info->chip.options	= pdata->options;
 	info->chip.bbt_td	= pdata->bbt_td;
 	info->chip.bbt_md	= pdata->bbt_md;
diff --git a/drivers/mtd/nand/denali.c b/drivers/mtd/nand/denali.c
index d527621..dbb6fba 100644
--- a/drivers/mtd/nand/denali.c
+++ b/drivers/mtd/nand/denali.c
@@ -1577,7 +1577,8 @@ static int denali_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	denali->nand.bbt_md = &bbt_mirror_descr;
 
 	/* skip the scan for now until we have OOB read and write support */
-	denali->nand.options |= NAND_USE_FLASH_BBT | NAND_SKIP_BBTSCAN;
+	denali->nand.bbt_options |= NAND_USE_FLASH_BBT;
+	denali->nand.options |= NAND_SKIP_BBTSCAN;
 	denali->nand.ecc.mode = NAND_ECC_HW_SYNDROME;
 
 	/* Denali Controller only support 15bit and 8bit ECC in MRST,
diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
index 7837728..f70bc73 100644
--- a/drivers/mtd/nand/diskonchip.c
+++ b/drivers/mtd/nand/diskonchip.c
@@ -1652,7 +1652,7 @@ static int __init doc_probe(unsigned long physadr)
 	nand->ecc.mode		= NAND_ECC_HW_SYNDROME;
 	nand->ecc.size		= 512;
 	nand->ecc.bytes		= 6;
-	nand->options		= NAND_USE_FLASH_BBT;
+	nand->bbt_options	= NAND_USE_FLASH_BBT;
 
 	doc->physadr		= physadr;
 	doc->virtadr		= virtadr;
diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 0bb254c..a06b59c 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -791,8 +791,8 @@ static int fsl_elbc_chip_init(struct fsl_elbc_mtd *priv)
 	chip->bbt_md = &bbt_mirror_descr;
 
 	/* set up nand options */
-	chip->options = NAND_NO_READRDY | NAND_NO_AUTOINCR |
-			NAND_USE_FLASH_BBT;
+	chip->options = NAND_NO_READRDY | NAND_NO_AUTOINCR;
+	chip->bbt_options = NAND_USE_FLASH_BBT;
 
 	chip->controller = &elbc_fcm_ctrl->controller;
 	chip->priv = priv;
diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nfc.c
index 2f7c930..d611542 100644
--- a/drivers/mtd/nand/mpc5121_nfc.c
+++ b/drivers/mtd/nand/mpc5121_nfc.c
@@ -735,7 +735,8 @@ static int __devinit mpc5121_nfc_probe(struct platform_device *op)
 	chip->write_buf = mpc5121_nfc_write_buf;
 	chip->verify_buf = mpc5121_nfc_verify_buf;
 	chip->select_chip = mpc5121_nfc_select_chip;
-	chip->options = NAND_NO_AUTOINCR | NAND_USE_FLASH_BBT;
+	chip->options = NAND_NO_AUTOINCR;
+	chip->bbt_options = NAND_USE_FLASH_BBT;
 	chip->ecc.mode = NAND_ECC_SOFT;
 
 	/* Support external chip-select logic on ADS5121 board */
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 90df34c..ed68fde 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -1179,7 +1179,7 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 		this->bbt_td = &bbt_main_descr;
 		this->bbt_md = &bbt_mirror_descr;
 		/* update flash based bbt */
-		this->options |= NAND_USE_FLASH_BBT;
+		this->bbt_options |= NAND_USE_FLASH_BBT;
 	}
 
 	init_completion(&host->op_completion);
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 8dc2576..221a76a 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -405,7 +405,7 @@ static int nand_default_block_markbad(struct mtd_info *mtd, loff_t ofs)
 		chip->bbt[block >> 2] |= 0x01 << ((block & 0x03) << 1);
 
 	/* Do we have a flash based bad block table ? */
-	if (chip->options & NAND_USE_FLASH_BBT)
+	if (chip->bbt_options & NAND_USE_FLASH_BBT)
 		ret = nand_update_bbt(mtd, ofs);
 	else {
 		nand_get_device(chip, mtd, FL_WRITING);
diff --git a/drivers/mtd/nand/nand_bbt.c b/drivers/mtd/nand/nand_bbt.c
index 5df01d8..66f93e2 100644
--- a/drivers/mtd/nand/nand_bbt.c
+++ b/drivers/mtd/nand/nand_bbt.c
@@ -36,9 +36,9 @@
  * The table is marked in the OOB area with an ident pattern and a version
  * number which indicates which of both tables is more up to date. If the NAND
  * controller needs the complete OOB area for the ECC information then the
- * option NAND_USE_FLASH_BBT_NO_OOB should be used: it moves the ident pattern
- * and the version byte into the data area and the OOB area will remain
- * untouched.
+ * option NAND_BBT_NO_OOB should be used (along with NAND_USE_FLASH_BBT, of
+ * course): it moves the ident pattern and the version byte into the data area
+ * and the OOB area will remain untouched.
  *
  * The table uses 2 bits per block
  * 11b:		block is good
@@ -1082,16 +1082,16 @@ static void verify_bbt_descr(struct mtd_info *mtd, struct nand_bbt_descr *bd)
 	pattern_len = bd->len;
 	bits = bd->options & NAND_BBT_NRBITS_MSK;
 
-	BUG_ON((this->options & NAND_USE_FLASH_BBT_NO_OOB) &&
-			!(this->options & NAND_USE_FLASH_BBT));
+	BUG_ON((this->bbt_options & NAND_BBT_NO_OOB) &&
+			!(this->bbt_options & NAND_USE_FLASH_BBT));
 	BUG_ON(!bits);
 
 	if (bd->options & NAND_BBT_VERSION)
 		pattern_len++;
 
 	if (bd->options & NAND_BBT_NO_OOB) {
-		BUG_ON(!(this->options & NAND_USE_FLASH_BBT));
-		BUG_ON(!(this->options & NAND_USE_FLASH_BBT_NO_OOB));
+		BUG_ON(!(this->bbt_options & NAND_USE_FLASH_BBT));
+		BUG_ON(!(this->bbt_options & NAND_BBT_NO_OOB));
 		BUG_ON(bd->offs);
 		if (bd->options & NAND_BBT_VERSION)
 			BUG_ON(bd->veroffs != bd->len);
@@ -1357,15 +1357,15 @@ int nand_default_bbt(struct mtd_info *mtd)
 			this->bbt_td = &bbt_main_descr;
 			this->bbt_md = &bbt_mirror_descr;
 		}
-		this->options |= NAND_USE_FLASH_BBT;
+		this->bbt_options |= NAND_USE_FLASH_BBT;
 		return nand_scan_bbt(mtd, &agand_flashbased);
 	}
 
 	/* Is a flash based bad block table requested ? */
-	if (this->options & NAND_USE_FLASH_BBT) {
+	if (this->bbt_options & NAND_USE_FLASH_BBT) {
 		/* Use the default pattern descriptors */
 		if (!this->bbt_td) {
-			if (this->options & NAND_USE_FLASH_BBT_NO_OOB) {
+			if (this->bbt_options & NAND_BBT_NO_OOB) {
 				this->bbt_td = &bbt_main_no_bbt_descr;
 				this->bbt_md = &bbt_mirror_no_bbt_descr;
 			} else {
diff --git a/drivers/mtd/nand/nandsim.c b/drivers/mtd/nand/nandsim.c
index 357e8c5..1856c42 100644
--- a/drivers/mtd/nand/nandsim.c
+++ b/drivers/mtd/nand/nandsim.c
@@ -2273,9 +2273,9 @@ static int __init ns_init_module(void)
 
 	switch (bbt) {
 	case 2:
-		 chip->options |= NAND_USE_FLASH_BBT_NO_OOB;
+		 chip->bbt_options |= NAND_BBT_NO_OOB;
 	case 1:
-		 chip->options |= NAND_USE_FLASH_BBT;
+		 chip->bbt_options |= NAND_USE_FLASH_BBT;
 	case 0:
 		break;
 	default:
diff --git a/drivers/mtd/nand/pasemi_nand.c b/drivers/mtd/nand/pasemi_nand.c
index b1aa41b..1c17f09 100644
--- a/drivers/mtd/nand/pasemi_nand.c
+++ b/drivers/mtd/nand/pasemi_nand.c
@@ -155,7 +155,8 @@ static int __devinit pasemi_nand_probe(struct platform_device *ofdev)
 	chip->ecc.mode = NAND_ECC_SOFT;
 
 	/* Enable the following for a flash based bad block table */
-	chip->options = NAND_USE_FLASH_BBT | NAND_NO_AUTOINCR;
+	chip->options = NAND_NO_AUTOINCR;
+	chip->bbt_options = NAND_USE_FLASH_BBT;
 
 	/* Scan to find existence of the device */
 	if (nand_scan(pasemi_nand_mtd, 1)) {
diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index 4405468..370516c 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -880,8 +880,10 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 	/* If you use u-boot BBT creation code, specifying this flag will
 	 * let the kernel fish out the BBT from the NAND, and also skip the
 	 * full NAND scan that can take 1/2s or so. Little things... */
-	if (set->flash_bbt)
-		chip->options |= NAND_USE_FLASH_BBT | NAND_SKIP_BBTSCAN;
+	if (set->flash_bbt) {
+		chip->bbt_options |= NAND_USE_FLASH_BBT;
+		chip->options |= NAND_SKIP_BBTSCAN;
+	}
 }
 
 /**
diff --git a/include/linux/mtd/bbm.h b/include/linux/mtd/bbm.h
index 08ffa21..7929514 100644
--- a/include/linux/mtd/bbm.h
+++ b/include/linux/mtd/bbm.h
@@ -100,8 +100,13 @@ struct nand_bbt_descr {
 #define NAND_BBT_SCANLASTPAGE	0x00008000
 /* The nand_bbt_descr was created dynamicaly and must be freed */
 #define NAND_BBT_DYNAMICSTRUCT 0x00200000
-/* The bad block table does not OOB for marker */
-#define NAND_BBT_NO_OOB		0x00400000
+/*
+ * Use a flash based bad block table. By default, OOB identifier is saved in
+ * OOB area. This option is passed to the default bad block table function.
+ */
+#define NAND_USE_FLASH_BBT	0x00040000
+/* Do not store flash based bad block table in OOB area; store it in-band */
+#define NAND_BBT_NO_OOB		0x00080000
 
 /* The maximum number of blocks to scan for a bbt */
 #define NAND_BBT_SCAN_MAXBLOCKS	4
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 42f70e2..f68e8cb 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -219,11 +219,6 @@ typedef enum {
 #define NAND_CHIPOPTIONS_MSK	(0x0000ffff & ~NAND_NO_AUTOINCR)
 
 /* Non chip related options */
-/*
- * Use a flash based bad block table. OOB identifier is saved in OOB area.
- * This option is passed to the default bad block table function.
- */
-#define NAND_USE_FLASH_BBT	0x00010000
 /* This option skips the bbt scan during initialization. */
 #define NAND_SKIP_BBTSCAN	0x00020000
 /*
@@ -233,11 +228,6 @@ typedef enum {
 #define NAND_OWN_BUFFERS	0x00040000
 /* Chip may not exist, so silence any errors in scan */
 #define NAND_SCAN_SILENT_NODEV	0x00080000
-/*
- * If passed additionally to NAND_USE_FLASH_BBT then BBT code will not touch
- * the OOB area.
- */
-#define NAND_USE_FLASH_BBT_NO_OOB	0x00800000
 /* Create an empty BBT with no vendor information if the BBT is available */
 #define NAND_CREATE_EMPTY_BBT		0x01000000
 
-- 
1.7.0.4
