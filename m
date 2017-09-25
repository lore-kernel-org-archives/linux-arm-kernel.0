From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Mon, 25 Sep 2017 16:53:51 +0200
Subject: [PATCH 2/3] mtd: nand: pxa3xx: enable NAND controller if the SoC
 needs it
In-Reply-To: <20170925145352.13145-1-miquel.raynal@free-electrons.com>
References: <20170925145352.13145-1-miquel.raynal@free-electrons.com>
Message-ID: <20170925145352.13145-3-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell recent SoCs like A7k/A8k do not boot with NAND flash
controller activated by default. Enabling the controller is a matter of
writing in a system controller register that may also be used for other
NAND related choices.

This change is needed to stay bootloader independent.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 85cff68643e0..90b9a9ccbe60 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -30,6 +30,8 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_data/mtd-nand-pxa3xx.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #define	CHIP_DELAY_TIMEOUT	msecs_to_jiffies(200)
 #define NAND_STOP_DELAY		msecs_to_jiffies(40)
@@ -45,6 +47,10 @@
  */
 #define INIT_BUFFER_SIZE	2048
 
+/* System control register and bit to enable NAND on some SoCs */
+#define GENCONF_SOC_DEVICE_MUX	0x208
+#define GENCONF_SOC_DEVICE_MUX_NFC_EN BIT(0)
+
 /* registers and bit definitions */
 #define NDCR		(0x00) /* Control register */
 #define NDTR0CS0	(0x04) /* Timing Parameter 0 for CS0 */
@@ -174,6 +180,7 @@ enum {
 enum pxa3xx_nand_variant {
 	PXA3XX_NAND_VARIANT_PXA,
 	PXA3XX_NAND_VARIANT_ARMADA370,
+	PXA3XX_NAND_VARIANT_ARMADA_8K,
 };
 
 struct pxa3xx_nand_host {
@@ -425,6 +432,10 @@ static const struct of_device_id pxa3xx_nand_dt_ids[] = {
 		.compatible = "marvell,armada370-nand",
 		.data       = (void *)PXA3XX_NAND_VARIANT_ARMADA370,
 	},
+	{
+		.compatible = "marvell,armada-8k-nand",
+		.data       = (void *)PXA3XX_NAND_VARIANT_ARMADA_8K,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, pxa3xx_nand_dt_ids);
@@ -825,7 +836,8 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 		info->retcode = ERR_UNCORERR;
 	if (status & NDSR_CORERR) {
 		info->retcode = ERR_CORERR;
-		if (info->variant == PXA3XX_NAND_VARIANT_ARMADA370 &&
+		if ((info->variant == PXA3XX_NAND_VARIANT_ARMADA370 ||
+		     info->variant == PXA3XX_NAND_VARIANT_ARMADA_8K) &&
 		    info->ecc_bch)
 			info->ecc_err_cnt = NDSR_ERR_CNT(status);
 		else
@@ -888,7 +900,8 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 		nand_writel(info, NDCB0, info->ndcb2);
 
 		/* NDCB3 register is available in NFCv2 (Armada 370/XP SoC) */
-		if (info->variant == PXA3XX_NAND_VARIANT_ARMADA370)
+		if (info->variant == PXA3XX_NAND_VARIANT_ARMADA370 ||
+		    info->variant == PXA3XX_NAND_VARIANT_ARMADA_8K)
 			nand_writel(info, NDCB0, info->ndcb3);
 	}
 
@@ -1671,7 +1684,8 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 		chip->options |= NAND_BUSWIDTH_16;
 
 	/* Device detection must be done with ECC disabled */
-	if (info->variant == PXA3XX_NAND_VARIANT_ARMADA370)
+	if (info->variant == PXA3XX_NAND_VARIANT_ARMADA370 ||
+	    info->variant == PXA3XX_NAND_VARIANT_ARMADA_8K)
 		nand_writel(info, NDECCCTRL, 0x0);
 
 	if (pdata->flash_bbt)
@@ -1709,7 +1723,8 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	 * (aka splitted) command handling,
 	 */
 	if (mtd->writesize > PAGE_CHUNK_SIZE) {
-		if (info->variant == PXA3XX_NAND_VARIANT_ARMADA370) {
+		if (info->variant == PXA3XX_NAND_VARIANT_ARMADA370 ||
+		    info->variant == PXA3XX_NAND_VARIANT_ARMADA_8K) {
 			chip->cmdfunc = nand_cmdfunc_extended;
 		} else {
 			dev_err(&info->pdev->dev,
@@ -1928,6 +1943,24 @@ static int pxa3xx_nand_probe_dt(struct platform_device *pdev)
 	if (!of_id)
 		return 0;
 
+	/*
+	 * Some SoCs like A7k/A8k need to enable manually the NAND
+	 * controller to avoid being bootloader dependent. This is done
+	 * through the use of a single bit in the System Functions registers.
+	 */
+	if (pxa3xx_nand_get_variant(pdev) == PXA3XX_NAND_VARIANT_ARMADA_8K) {
+		struct regmap *sysctrl_base = syscon_regmap_lookup_by_phandle(
+			pdev->dev.of_node, "marvell,system-controller");
+		u32 reg;
+
+		if (IS_ERR(sysctrl_base))
+			return PTR_ERR(sysctrl_base);
+
+		regmap_read(sysctrl_base, GENCONF_SOC_DEVICE_MUX, &reg);
+		reg |= GENCONF_SOC_DEVICE_MUX_NFC_EN;
+		regmap_write(sysctrl_base, GENCONF_SOC_DEVICE_MUX, reg);
+	}
+
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
-- 
2.11.0
