From: vipin.kumar@st.com (Vipin Kumar)
Date: Tue, 9 Oct 2012 16:14:45 +0530
Subject: [PATCH 03/11] fsmc/nand: Support multiple banks connected to
 controller
In-Reply-To: <cover.1349778820.git.vipin.kumar@st.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
Message-ID: <9748ce2483f539fb32279b8ea9df065cfdbe8ab1.1349778820.git.vipin.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support up to max_banks number of banks in fsmc driver.

Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
---
 .../devicetree/bindings/mtd/fsmc-nand.txt          |  2 ++
 arch/arm/boot/dts/spear300.dtsi                    |  1 +
 arch/arm/boot/dts/spear310.dtsi                    |  1 +
 arch/arm/boot/dts/spear320.dtsi                    |  1 +
 arch/arm/boot/dts/spear600.dtsi                    |  1 +
 arch/arm/mach-u300/core.c                          |  1 +
 drivers/mtd/nand/fsmc_nand.c                       | 26 +++++++++++++++-------
 include/linux/mtd/fsmc.h                           |  2 +-
 8 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/fsmc-nand.txt b/Documentation/devicetree/bindings/mtd/fsmc-nand.txt
index e2c663b..29d1a2f 100644
--- a/Documentation/devicetree/bindings/mtd/fsmc-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/fsmc-nand.txt
@@ -6,6 +6,7 @@ Required properties:
 - reg-names: Should contain the reg names "fsmc_regs" and "nand_data"
 - st,ale-off : Chip specific offset to ALE
 - st,cle-off : Chip specific offset to CLE
+- maxbanks: Number of banks supported by SoC
 
 Optional properties:
 - bank-width : Width (in bytes) of the device.  If not present, the width
@@ -23,6 +24,7 @@ Example:
 		reg-names = "fsmc_regs", "nand_data";
 		st,ale-off = <0x20000>;
 		st,cle-off = <0x10000>;
+		maxbanks = <1>;
 
 		bank-width = <1>;
 		nand-skip-bbtscan;
diff --git a/arch/arm/boot/dts/spear300.dtsi b/arch/arm/boot/dts/spear300.dtsi
index ed3627c..19e2328 100644
--- a/arch/arm/boot/dts/spear300.dtsi
+++ b/arch/arm/boot/dts/spear300.dtsi
@@ -42,6 +42,7 @@
 			reg-names = "fsmc_regs", "nand_data";
 			st,ale-off = <0x20000>;
 			st,cle-off = <0x10000>;
+			maxbanks = <1>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/spear310.dtsi b/arch/arm/boot/dts/spear310.dtsi
index 62fc4fb..0272afb3 100644
--- a/arch/arm/boot/dts/spear310.dtsi
+++ b/arch/arm/boot/dts/spear310.dtsi
@@ -36,6 +36,7 @@
 			reg-names = "fsmc_regs", "nand_data";
 			st,ale-off = <0x10000>;
 			st,cle-off = <0x20000>;
+			maxbanks = <1>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/spear320.dtsi b/arch/arm/boot/dts/spear320.dtsi
index 1f49d69..69fe50d 100644
--- a/arch/arm/boot/dts/spear320.dtsi
+++ b/arch/arm/boot/dts/spear320.dtsi
@@ -42,6 +42,7 @@
 			reg-names = "fsmc_regs", "nand_data";
 			st,ale-off = <0x20000>;
 			st,cle-off = <0x10000>;
+			maxbanks = <1>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi
index a3c36e4..6ed57c8 100644
--- a/arch/arm/boot/dts/spear600.dtsi
+++ b/arch/arm/boot/dts/spear600.dtsi
@@ -71,6 +71,7 @@
 			reg-names = "fsmc_regs", "nand_data";
 			st,ale-off = <0x20000>;
 			st,cle-off = <0x10000>;
+			maxbanks = <1>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 03acf18..5ea9f71 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -1546,6 +1546,7 @@ static struct fsmc_nand_platform_data nand_platform_data = {
 	.width = FSMC_NAND_BW8,
 	.ale_off = PLAT_NAND_ALE,
 	.cle_off = PLAT_NAND_CLE,
+	.max_banks = 1,
 };
 
 static struct platform_device nand_device = {
diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index bd89580..fc6a044 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -298,6 +298,7 @@ static struct fsmc_eccplace fsmc_ecc4_sp_place = {
  *			- Word access (CPU)
  *			- None (Use driver default ie bus width specific
  *			  CPU access)
+ * @max_banks:		Maximum number of banks supported
  * @select_chip:	Select a particular bank
  *
  * @data_pa:		NAND Physical port for Data
@@ -325,6 +326,7 @@ struct fsmc_nand_data {
 	struct mtd_partition	*partitions;
 	unsigned int		nr_partitions;
 	enum access_mode	mode;
+	uint32_t		max_banks;
 	void			(*select_chip)(uint32_t bank, uint32_t busw);
 
 	/* Virtual/Physical addresses for CPU/DMA access */
@@ -343,6 +345,7 @@ static void fsmc_select_chip(struct mtd_info *mtd, int chipnr)
 
 	host = container_of(mtd, struct fsmc_nand_data, mtd);
 
+	host->bank = chipnr;
 	switch (chipnr) {
 	case -1:
 		chip->cmd_ctrl(mtd, NAND_CMD_NONE, 0 | NAND_CTRL_CHANGE);
@@ -889,6 +892,7 @@ static int __devinit fsmc_nand_probe_config_dt(struct platform_device *pdev,
 	of_property_read_u32(np, "st,cle-off", &pdata->cle_off);
 	if (of_get_property(np, "nand-skip-bbtscan", NULL))
 		pdata->options = NAND_SKIP_BBTSCAN;
+	of_property_read_u32(np, "maxbanks", &pdata->max_banks);
 
 	return 0;
 }
@@ -915,7 +919,7 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	struct resource *res;
 	dma_cap_mask_t mask;
 	int ret = 0;
-	u32 pid;
+	u32 pid, bank;
 	int i;
 
 	if (np) {
@@ -1023,13 +1027,13 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 		 AMBA_PART_BITS(pid), AMBA_MANF_BITS(pid),
 		 AMBA_REV_BITS(pid), AMBA_CONFIG_BITS(pid));
 
-	host->bank = pdata->bank;
 	host->select_chip = pdata->select_bank;
 	host->partitions = pdata->partitions;
 	host->nr_partitions = pdata->nr_partitions;
 	host->dev = &pdev->dev;
 	host->dev_timings = pdata->nand_timings;
 	host->mode = pdata->mode;
+	host->max_banks = pdata->max_banks;
 
 	if (host->mode == USE_DMA_ACCESS)
 		init_completion(&host->dma_access_complete);
@@ -1083,9 +1087,10 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 		break;
 	}
 
-	fsmc_nand_setup(host->regs_va, host->bank,
-			nand->options & NAND_BUSWIDTH_16,
-			host->dev_timings);
+	for (bank = 0; bank < host->max_banks; bank++)
+		fsmc_nand_setup(host->regs_va, bank,
+				nand->options & NAND_BUSWIDTH_16,
+				host->dev_timings);
 
 	if (AMBA_REV_BITS(host->pid) >= 8) {
 		nand->ecc.read_page = fsmc_read_page_hwecc;
@@ -1230,11 +1235,16 @@ static int fsmc_nand_suspend(struct device *dev)
 static int fsmc_nand_resume(struct device *dev)
 {
 	struct fsmc_nand_data *host = dev_get_drvdata(dev);
+	uint32_t bank;
+
 	if (host) {
 		clk_prepare_enable(host->clk);
-		fsmc_nand_setup(host->regs_va, host->bank,
-				host->nand.options & NAND_BUSWIDTH_16,
-				host->dev_timings);
+
+		for (bank = 0; bank < host->max_banks; bank++)
+			fsmc_nand_setup(host->regs_va, bank,
+					host->nand.options & NAND_BUSWIDTH_16,
+					host->dev_timings);
+
 	}
 	return 0;
 }
diff --git a/include/linux/mtd/fsmc.h b/include/linux/mtd/fsmc.h
index b200292..f0ab734 100644
--- a/include/linux/mtd/fsmc.h
+++ b/include/linux/mtd/fsmc.h
@@ -153,7 +153,7 @@ struct fsmc_nand_platform_data {
 	unsigned int		nr_partitions;
 	unsigned int		options;
 	unsigned int		width;
-	unsigned int		bank;
+	unsigned int		max_banks;
 
 	/* CLE, ALE offsets */
 	unsigned int		cle_off;
-- 
1.7.11.4
