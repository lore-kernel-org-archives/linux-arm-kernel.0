From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 29 Apr 2017 10:52:35 +0200
Subject: [PATCH v2 2/3] mtd: nand: fsmc: add support for SDR timings
In-Reply-To: <1493455956-18362-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1493455956-18362-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1493455956-18362-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until now, the fsmc_nand driver was either using controller timings
specified in the Device Tree (through FSMC specific DT properties) or
alternatively default/fallback timings.

This commit implements support to use the timings advertised by the NAND
chip itself, by implementing the ->setup_data_interface() hook. To
preserve backward compatibility, if timings are specified in the Device
Tree, we use the timings from the Device Tree (and don't implement
->setup_data_interface).

Many thanks to Boris Brezillon for coming up with the logic to convert
the NAND chip timings into the timings expected by the FSMC controller.

Also, since the timings are now not only coming from the DT, the message
warning that default timings will be used is removed.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/mtd/nand/fsmc_nand.c | 94 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 89 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index 43108dd..442e4df 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -346,6 +346,88 @@ static void fsmc_nand_setup(struct fsmc_nand_data *host,
 			FSMC_NAND_REG(regs, bank, ATTRIB));
 }
 
+static int fsmc_calc_timings(struct fsmc_nand_data *host,
+			     const struct nand_sdr_timings *sdrt,
+			     struct fsmc_nand_timings *tims)
+{
+	unsigned long hclk = clk_get_rate(host->clk);
+	unsigned long hclkn = NSEC_PER_SEC / hclk;
+	uint32_t thiz, thold, twait, tset;
+
+	if (sdrt->tRC_min < 30000)
+		return -EOPNOTSUPP;
+
+	tims->tar = DIV_ROUND_UP(sdrt->tAR_min / 1000, hclkn) - 1;
+	if (tims->tar > FSMC_TAR_MASK)
+		tims->tar = FSMC_TAR_MASK;
+	tims->tclr = DIV_ROUND_UP(sdrt->tCLR_min / 1000, hclkn) - 1;
+	if (tims->tclr > FSMC_TCLR_MASK)
+		tims->tclr = FSMC_TCLR_MASK;
+
+	thiz = sdrt->tCS_min - sdrt->tWP_min;
+	tims->thiz = DIV_ROUND_UP(thiz / 1000, hclkn);
+
+	thold = sdrt->tDH_min;
+	if (thold < sdrt->tCH_min)
+		thold = sdrt->tCH_min;
+	if (thold < sdrt->tCLH_min)
+		thold = sdrt->tCLH_min;
+	if (thold < sdrt->tWH_min)
+		thold = sdrt->tWH_min;
+	if (thold < sdrt->tALH_min)
+		thold = sdrt->tALH_min;
+	if (thold < sdrt->tREH_min)
+		thold = sdrt->tREH_min;
+	tims->thold = DIV_ROUND_UP(thold / 1000, hclkn);
+	if (tims->thold == 0)
+		tims->thold = 1;
+	else if (tims->thold > FSMC_THOLD_MASK)
+		tims->thold = FSMC_THOLD_MASK;
+
+	twait = max(sdrt->tRP_min, sdrt->tWP_min);
+	tims->twait = DIV_ROUND_UP(twait / 1000, hclkn) - 1;
+	if (tims->twait == 0)
+		tims->twait = 1;
+	else if (tims->twait > FSMC_TWAIT_MASK)
+		tims->twait = FSMC_TWAIT_MASK;
+
+	tset = max(sdrt->tCS_min - sdrt->tWP_min,
+		   sdrt->tCEA_max - sdrt->tREA_max);
+	tims->tset = DIV_ROUND_UP(tset / 1000, hclkn) - 1;
+	if (tims->tset == 0)
+		tims->tset = 1;
+	else if (tims->tset > FSMC_TSET_MASK)
+		tims->tset = FSMC_TSET_MASK;
+
+	return 0;
+}
+
+static int fsmc_setup_data_interface(struct mtd_info *mtd,
+				     const struct nand_data_interface *conf,
+				     bool check_only)
+{
+	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct fsmc_nand_data *host = nand_get_controller_data(nand);
+	struct fsmc_nand_timings tims;
+	const struct nand_sdr_timings *sdrt;
+	int ret;
+
+	sdrt = nand_get_sdr_timings(conf);
+	if (IS_ERR(sdrt))
+		return PTR_ERR(sdrt);
+
+	ret = fsmc_calc_timings(host, sdrt, &tims);
+	if (ret)
+		return ret;
+
+	if (check_only)
+		return 0;
+
+	fsmc_nand_setup(host, &tims);
+
+	return 0;
+}
+
 /*
  * fsmc_enable_hwecc - Enables Hardware ECC through FSMC registers
  */
@@ -798,10 +880,8 @@ static int fsmc_nand_probe_config_dt(struct platform_device *pdev,
 		return -ENOMEM;
 	ret = of_property_read_u8_array(np, "timings", (u8 *)host->dev_timings,
 						sizeof(*host->dev_timings));
-	if (ret) {
-		dev_info(&pdev->dev, "No timings in dts specified, using default timings!\n");
+	if (ret)
 		host->dev_timings = NULL;
-	}
 
 	/* Set default NAND bank to 0 */
 	host->bank = 0;
@@ -935,7 +1015,10 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 		break;
 	}
 
-	fsmc_nand_setup(host, host->dev_timings);
+	if (host->dev_timings)
+		fsmc_nand_setup(host, host->dev_timings);
+	else
+		nand->setup_data_interface = fsmc_setup_data_interface;
 
 	if (AMBA_REV_BITS(host->pid) >= 8) {
 		nand->ecc.read_page = fsmc_read_page_hwecc;
@@ -1073,7 +1156,8 @@ static int fsmc_nand_resume(struct device *dev)
 	struct fsmc_nand_data *host = dev_get_drvdata(dev);
 	if (host) {
 		clk_prepare_enable(host->clk);
-		fsmc_nand_setup(host, host->dev_timings);
+		if (host->dev_timings)
+			fsmc_nand_setup(host, host->dev_timings);
 	}
 	return 0;
 }
-- 
2.7.4
