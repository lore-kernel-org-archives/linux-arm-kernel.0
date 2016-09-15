From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 15 Sep 2016 10:32:53 +0200
Subject: [PATCH 9/9] mtd: nand: mxc: Add timing setup for v2 controllers
In-Reply-To: <1473928373-8680-1-git-send-email-s.hauer@pengutronix.de>
References: <1473928373-8680-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1473928373-8680-10-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far we relied on reset default or the bootloader to configure a
suitable clk rate for the Nand controller. This works but we can
optimize the timing for better performance. This sets the clk rate for
v2 controllers (i.MX25/35) based on the timing mode read from the ONFI
parameter page. This may also enable the symmetric mode (aks EDO mode)
if necessary which reads one word per clock cycle.
Tested on an i.MX25 with a Micron MT29F4G08ABBDAHC attached.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c | 84 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 1db8299..0d34d72 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -152,6 +152,9 @@ struct mxc_nand_devtype_data {
 	void (*select_chip)(struct mtd_info *mtd, int chip);
 	int (*correct_data)(struct mtd_info *mtd, u_char *dat,
 			u_char *read_ecc, u_char *calc_ecc);
+	int (*setup_data_interface)(struct mtd_info *mtd,
+			const struct nand_data_interface *conf,
+			bool check_only);
 
 	/*
 	 * On i.MX21 the CONFIG2:INT bit cannot be read if interrupts are masked
@@ -1012,6 +1015,82 @@ static void preset_v1(struct mtd_info *mtd)
 	writew(0x4, NFC_V1_V2_WRPROT);
 }
 
+static int mxc_nand_v2_setup_data_interface(struct mtd_info *mtd,
+					    const struct nand_data_interface *conf,
+					    bool check_only)
+{
+	struct nand_chip *nand_chip = mtd_to_nand(mtd);
+	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
+	int tRC_min_ns, tRC_ps, ret;
+	unsigned long rate, rate_round;
+	const struct nand_sdr_timings *timings;
+	uint16_t config1;
+
+	timings = nand_get_sdr_timings(conf);
+	if (IS_ERR(timings))
+		return -ENOTSUPP;
+
+	config1 = readw(NFC_V1_V2_CONFIG1);
+
+	tRC_min_ns = timings->tRC_min / 1000;
+	rate = 1000000000 / tRC_min_ns;
+
+	/*
+	 * For tRC < 30ns we have to use EDO mode. In this case the controller
+	 * does one access per clock cycle. Otherwise the controller does one
+	 * access in two clock cycles, thus we have to double the rate to the
+	 * controller.
+	 */
+	if (tRC_min_ns < 30) {
+		rate_round = clk_round_rate(host->clk, rate);
+		config1 |= NFC_V2_CONFIG1_ONE_CYCLE;
+		tRC_ps = 1000000000 / (rate_round / 1000);
+	} else {
+		rate *= 2;
+		rate_round = clk_round_rate(host->clk, rate);
+		config1 &= ~NFC_V2_CONFIG1_ONE_CYCLE;
+		tRC_ps = 1000000000 / (rate_round / 1000 / 2);
+	}
+
+	/*
+	 * The timing values compared against are from the i.MX25 Automotive
+	 * datasheet, Table 50. NFC Timing Parameters
+	 */
+	if (timings->tCLS_min > tRC_ps - 1000 ||
+	    timings->tCLH_min > tRC_ps - 2000 ||
+	    timings->tCS_min > tRC_ps - 1000 ||
+	    timings->tCH_min > tRC_ps - 2000 ||
+	    timings->tWP_min > tRC_ps - 1500 ||
+	    timings->tALS_min > tRC_ps ||
+	    timings->tALH_min > tRC_ps - 3000 ||
+	    timings->tDS_min > tRC_ps ||
+	    timings->tDH_min > tRC_ps - 5000 ||
+	    timings->tWC_min > 2 * tRC_ps ||
+	    timings->tWH_min > tRC_ps - 2500 ||
+	    timings->tRR_min > 6 * tRC_ps ||
+	    timings->tRP_min > 3 * tRC_ps / 2 ||
+	    timings->tRC_min > 2 * tRC_ps ||
+	    timings->tREH_min > (tRC_ps / 2) - 2500) {
+		dev_dbg(host->dev, "Timing out of bounds\n");
+		return -EINVAL;
+	}
+
+	if (check_only)
+		return 0;
+
+	ret = clk_set_rate(host->clk, rate);
+	if (ret)
+		return ret;
+
+	writew(config1, NFC_V1_V2_CONFIG1);
+
+	dev_dbg(host->dev, "Setting rate to %ldHz, %s mode\n", rate_round,
+		config1 & NFC_V2_CONFIG1_ONE_CYCLE ? "One cycle (EDO)" :
+		"normal");
+
+	return 0;
+}
+
 static void preset_v2(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
@@ -1276,8 +1355,6 @@ static int mxc_nand_onfi_get_features(struct mtd_info *mtd, struct nand_chip *ch
 	      & ONFI_OPT_CMD_SET_GET_FEATURES))
 		return -EINVAL;
 
-	*(uint32_t *)host->main_area0 = 0xdeadbeef;
-
 	host->devtype_data->send_cmd(host, NAND_CMD_GET_FEATURES, false);
 	mxc_do_addr_cycle(mtd, addr, -1);
 	host->devtype_data->send_page(mtd, NFC_OUTPUT);
@@ -1378,6 +1455,7 @@ static const struct mxc_nand_devtype_data imx25_nand_devtype_data = {
 	.ooblayout = &mxc_v2_ooblayout_ops,
 	.select_chip = mxc_nand_select_chip_v2,
 	.correct_data = mxc_nand_correct_data_v2_v3,
+	.setup_data_interface = mxc_nand_v2_setup_data_interface,
 	.irqpending_quirk = 0,
 	.needs_ip = 0,
 	.regs_offset = 0x1e00,
@@ -1586,6 +1664,8 @@ static int mxcnd_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
+	this->setup_data_interface = host->devtype_data->setup_data_interface;
+
 	if (host->devtype_data->needs_ip) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		host->regs_ip = devm_ioremap_resource(&pdev->dev, res);
-- 
2.8.1
