From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 19 Oct 2010 17:07:28 +0200
Subject: [PATCH] ARM: pxa: Add Balloon3 NAND ready check
Message-ID: <1287500848-21528-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/balloon3.c              |    8 ++++++--
 arch/arm/mach-pxa/include/mach/balloon3.h |    2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 235d957..6128f52 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -614,9 +614,13 @@ static void balloon3_nand_select_chip(struct mtd_info *mtd, int chip)
 		BALLOON3_NAND_CONTROL_REG);
 }
 
+static int balloon3_nand_dev_ready(struct mtd_info *mtd)
+{
+	return __raw_readl(BALLOON3_NAND_STAT_REG) & BALLOON3_NAND_STAT_RNB;
+}
+
 static int balloon3_nand_probe(struct platform_device *pdev)
 {
-	void __iomem *temp_map;
 	uint16_t ver;
 	int ret;
 
@@ -686,7 +690,7 @@ struct platform_nand_data balloon3_nand_pdata = {
 	},
 	.ctrl = {
 		.hwcontrol	= 0,
-		.dev_ready	= 0,
+		.dev_ready	= balloon3_nand_dev_ready,
 		.select_chip	= balloon3_nand_select_chip,
 		.cmd_ctrl	= balloon3_nand_cmd_ctl,
 		.probe		= balloon3_nand_probe,
diff --git a/arch/arm/mach-pxa/include/mach/balloon3.h b/arch/arm/mach-pxa/include/mach/balloon3.h
index f6c81ea..7074e76 100644
--- a/arch/arm/mach-pxa/include/mach/balloon3.h
+++ b/arch/arm/mach-pxa/include/mach/balloon3.h
@@ -37,7 +37,7 @@ enum balloon3_features {
 #define	BALLOON3_NAND_BASE		(PXA_CS4_PHYS + 0x00e00000)
 #define	BALLOON3_NAND_IO_REG		(BALLOON3_FPGA_VIRT + 0x00e00000)
 #define	BALLOON3_NAND_CONTROL2_REG	(BALLOON3_FPGA_VIRT + 0x00e00010)
-#define	BALLOON3_NAND_STAT_REG		(BALLOON3_FPGA_VIRT + 0x00e00010)
+#define	BALLOON3_NAND_STAT_REG		(BALLOON3_FPGA_VIRT + 0x00e00014)
 #define	BALLOON3_NAND_CONTROL_REG	(BALLOON3_FPGA_VIRT + 0x00e00014)
 
 /* fpga/cpld interrupt control register */
-- 
1.7.1
