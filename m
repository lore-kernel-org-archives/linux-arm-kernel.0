From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Wed, 20 Nov 2013 18:24:58 +0200
Subject: [PATCH 2/3] mtd: nand: davinci: don't set timings if AEMIF is used
In-Reply-To: <1384964699-15134-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1384964699-15134-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1384964699-15134-3-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The problem that the set timings code contains the call of Davinci
platform function davinci_aemif_setup_timing() which is not
accessible if kernel is built for Keystone only.

The Keysone platform is going to use TI AEMIF driver.
If TI AEMIF is used we don't need to set timings and bus width.
It is done by AEMIF driver (drivers/memory/ti-aemfi.c).

The timings code has to be removed together with Davinci aemif
platform code (aemif.c), once Davinci will be converted to DT and use
ti-aemif.c driver.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 drivers/mtd/nand/davinci_nand.c |   48 +++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index 8459720..e904364 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -605,6 +605,7 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
 	int				ret;
 	uint32_t			val;
 	nand_ecc_modes_t		ecc_mode;
+	bool aemif = IS_ENABLED(CONFIG_TI_AEMIF);
 
 	pdata = nand_davinci_get_pdata(pdev);
 	if (IS_ERR(pdata))
@@ -741,25 +742,38 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
 	}
 
 	/*
-	 * Setup Async configuration register in case we did not boot from
-	 * NAND and so bootloader did not bother to set it up.
+	 * TODO:
+	 * This is temp solution to support Davinci platform and it has to be
+	 * removed once Davinci will be updated to use ti-aemif.c driver.
 	 */
-	val = davinci_nand_readl(info, A1CR_OFFSET + info->core_chipsel * 4);
-
-	/* Extended Wait is not valid and Select Strobe mode is not used */
-	val &= ~(ACR_ASIZE_MASK | ACR_EW_MASK | ACR_SS_MASK);
-	if (info->chip.options & NAND_BUSWIDTH_16)
-		val |= 0x1;
-
-	davinci_nand_writel(info, A1CR_OFFSET + info->core_chipsel * 4, val);
+	if (!aemif) {
+		/*
+		 * Setup Async configuration register in case we did not boot
+		 * from NAND and so bootloader did not bother to set it up.
+		 */
+		val = davinci_nand_readl(info, A1CR_OFFSET +
+					 info->core_chipsel * 4);
 
-	ret = 0;
-	if (info->timing)
-		ret = davinci_aemif_setup_timing(info->timing, info->base,
-							info->core_chipsel);
-	if (ret < 0) {
-		dev_dbg(&pdev->dev, "NAND timing values setup fail\n");
-		goto err;
+		/*
+		 * Extended Wait is not valid and Select Strobe mode is not
+		 * used
+		 */
+		val &= ~(ACR_ASIZE_MASK | ACR_EW_MASK | ACR_SS_MASK);
+		if (info->chip.options & NAND_BUSWIDTH_16)
+			val |= 0x1;
+
+		davinci_nand_writel(info, A1CR_OFFSET +
+				    info->core_chipsel * 4, val);
+
+		ret = 0;
+		if (info->timing)
+			ret = davinci_aemif_setup_timing(info->timing,
+							 info->base,
+							 info->core_chipsel);
+		if (ret < 0) {
+			dev_dbg(&pdev->dev, "NAND timing values setup fail\n");
+			goto err;
+		}
 	}
 
 	spin_lock_irq(&davinci_nand_lock);
-- 
1.7.9.5
