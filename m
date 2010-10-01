From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:45 -0700
Subject: [PATCH 21/47] nand: davinci: add support for timing configuration
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-22-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

This patch modifies the DaVinci NAND driver to use the
new AEMIF timing setup API to configure the NAND access
timings.

Earlier, AEMIF configuration was being done as a special
case for DM644x board, but now more boards emerge which have
capability to boot for other media (SPI flash, NOR flash) and
have the kernel access NAND flash. This means that kernel cannot
always  depend on the bootloader to setup the NAND.

Also, on platforms such as da850/omap-l138, the aemif input
frequency changes as cpu frequency changes; necessiating
re-calculation of timimg values as part of cpufreq transtitions.
This patch forms the basis for adding that support.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
---
 arch/arm/mach-davinci/include/mach/nand.h |    3 +
 drivers/mtd/nand/davinci_nand.c           |   60 ++++++++++------------------
 2 files changed, 25 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/nand.h b/arch/arm/mach-davinci/include/mach/nand.h
index b5893f0..0251510 100644
--- a/arch/arm/mach-davinci/include/mach/nand.h
+++ b/arch/arm/mach-davinci/include/mach/nand.h
@@ -80,6 +80,9 @@ struct davinci_nand_pdata {		/* platform_data */
 	/* Main and mirror bbt descriptor overrides */
 	struct nand_bbt_descr	*bbt_td;
 	struct nand_bbt_descr	*bbt_md;
+
+	/* Access timings */
+	struct davinci_aemif_timing	*timing;
 };
 
 #endif	/* __ARCH_ARM_DAVINCI_NAND_H */
diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index 8e2d56c..8beb0d0 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -75,6 +75,8 @@ struct davinci_nand_info {
 	uint32_t		mask_cle;
 
 	uint32_t		core_chipsel;
+
+	struct davinci_aemif_timing	*timing;
 };
 
 static DEFINE_SPINLOCK(davinci_nand_lock);
@@ -479,36 +481,6 @@ static int nand_davinci_dev_ready(struct mtd_info *mtd)
 	return davinci_nand_readl(info, NANDFSR_OFFSET) & BIT(0);
 }
 
-static void __init nand_dm6446evm_flash_init(struct davinci_nand_info *info)
-{
-	uint32_t regval, a1cr;
-
-	/*
-	 * NAND FLASH timings @ PLL1 == 459 MHz
-	 *  - AEMIF.CLK freq   = PLL1/6 = 459/6 = 76.5 MHz
-	 *  - AEMIF.CLK period = 1/76.5 MHz = 13.1 ns
-	 */
-	regval = 0
-		| (0 << 31)           /* selectStrobe */
-		| (0 << 30)           /* extWait (never with NAND) */
-		| (1 << 26)           /* writeSetup      10 ns */
-		| (3 << 20)           /* writeStrobe     40 ns */
-		| (1 << 17)           /* writeHold       10 ns */
-		| (0 << 13)           /* readSetup       10 ns */
-		| (3 << 7)            /* readStrobe      60 ns */
-		| (0 << 4)            /* readHold        10 ns */
-		| (3 << 2)            /* turnAround      ?? ns */
-		| (0 << 0)            /* asyncSize       8-bit bus */
-		;
-	a1cr = davinci_nand_readl(info, A1CR_OFFSET);
-	if (a1cr != regval) {
-		dev_dbg(info->dev, "Warning: NAND config: Set A1CR " \
-		       "reg to 0x%08x, was 0x%08x, should be done by " \
-		       "bootloader.\n", regval, a1cr);
-		davinci_nand_writel(info, A1CR_OFFSET, regval);
-	}
-}
-
 /*----------------------------------------------------------------------*/
 
 /* An ECC layout for using 4-bit ECC with small-page flash, storing
@@ -612,6 +584,7 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
 	info->chip.options	= pdata->options;
 	info->chip.bbt_td	= pdata->bbt_td;
 	info->chip.bbt_md	= pdata->bbt_md;
+	info->timing		= pdata->timing;
 
 	info->ioaddr		= (uint32_t __force) vaddr;
 
@@ -689,15 +662,25 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
 		goto err_clk_enable;
 	}
 
-	/* EMIF timings should normally be set by the boot loader,
-	 * especially after boot-from-NAND.  The *only* reason to
-	 * have this special casing for the DM6446 EVM is to work
-	 * with boot-from-NOR ... with CS0 manually re-jumpered
-	 * (after startup) so it addresses the NAND flash, not NOR.
-	 * Even for dev boards, that's unusually rude...
+	/*
+	 * Setup Async configuration register in case we did not boot from
+	 * NAND and so bootloader did not bother to set it up.
 	 */
-	if (machine_is_davinci_evm())
-		nand_dm6446evm_flash_init(info);
+	val = davinci_nand_readl(info, A1CR_OFFSET + info->core_chipsel * 4);
+
+	/* Extended Wait is not valid and Select Strobe mode is not used */
+	val &= ~(ACR_ASIZE_MASK | ACR_EW_MASK | ACR_SS_MASK);
+	if (info->chip.options & NAND_BUSWIDTH_16)
+		val |= 0x1;
+
+	davinci_nand_writel(info, A1CR_OFFSET + info->core_chipsel * 4, val);
+
+	ret = davinci_aemif_setup_timing(info->timing, info->base,
+							info->core_chipsel);
+	if (ret < 0) {
+		dev_dbg(&pdev->dev, "NAND timing values setup fail\n");
+		goto err_timing;
+	}
 
 	spin_lock_irq(&davinci_nand_lock);
 
@@ -810,6 +793,7 @@ syndrome_done:
 	return 0;
 
 err_scan:
+err_timing:
 	clk_disable(info->clk);
 
 err_clk_enable:
-- 
1.7.2.1
