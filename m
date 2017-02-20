From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 20 Feb 2017 22:12:28 +0100
Subject: [RESEND PATCH 2/3] mtd: nand: atmel: Add ->setup_data_interface()
 hooks
In-Reply-To: <1487625149-7234-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1487625149-7234-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1487625149-7234-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND controller IP can adapt the NAND controller timings dynamically.
Implement the ->setup_data_interface() hook to support this feature.

Note that it's not supported on at91rm9200 because this SoC has a
completely different SMC block, which is not supported yet.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/atmel/nand-controller.c | 333 ++++++++++++++++++++++++++++++-
 1 file changed, 328 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/atmel/nand-controller.c b/drivers/mtd/nand/atmel/nand-controller.c
index 4207c0d37826..ae46ef711d67 100644
--- a/drivers/mtd/nand/atmel/nand-controller.c
+++ b/drivers/mtd/nand/atmel/nand-controller.c
@@ -57,6 +57,7 @@
 #include <linux/interrupt.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/atmel-matrix.h>
+#include <linux/mfd/syscon/atmel-smc.h>
 #include <linux/module.h>
 #include <linux/mtd/nand.h>
 #include <linux/of_address.h>
@@ -147,6 +148,8 @@ struct atmel_nand_cs {
 		void __iomem *virt;
 		dma_addr_t dma;
 	} io;
+
+	struct atmel_smc_cs_conf smcconf;
 };
 
 struct atmel_nand {
@@ -190,6 +193,8 @@ struct atmel_nand_controller_ops {
 	void (*nand_init)(struct atmel_nand_controller *nc,
 			  struct atmel_nand *nand);
 	int (*ecc_init)(struct atmel_nand *nand);
+	int (*setup_data_interface)(struct atmel_nand *nand, int csline,
+				    const struct nand_data_interface *conf);
 };
 
 struct atmel_nand_controller_caps {
@@ -1144,6 +1149,293 @@ static int atmel_hsmc_nand_ecc_init(struct atmel_nand *nand)
 	return 0;
 }
 
+static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
+					const struct nand_data_interface *conf,
+					struct atmel_smc_cs_conf *smcconf)
+{
+	u32 ncycles, totalcycles, timeps, mckperiodps;
+	struct atmel_nand_controller *nc;
+	int ret;
+
+	nc = to_nand_controller(nand->base.controller);
+
+	/* DDR interface not supported. */
+	if (conf->type != NAND_SDR_IFACE)
+		return -ENOTSUPP;
+
+	/*
+	 * tRC < 30ns implies EDO mode. This controller does not support this
+	 * mode.
+	 */
+	if (conf->timings.sdr.tRC_min < 30)
+		return -ENOTSUPP;
+
+	atmel_smc_cs_conf_init(smcconf);
+
+	mckperiodps = NSEC_PER_SEC / clk_get_rate(nc->mck);
+	mckperiodps *= 1000;
+
+	/*
+	 * Set write pulse timing. This one is easy to extract:
+	 *
+	 * NWE_PULSE = tWP
+	 */
+	ncycles = DIV_ROUND_UP(conf->timings.sdr.tWP_min, mckperiodps);
+	totalcycles = ncycles;
+	ret = atmel_smc_cs_conf_set_pulse(smcconf, ATMEL_SMC_NWE_SHIFT,
+					  ncycles);
+	if (ret)
+		return ret;
+
+	/*
+	 * The write setup timing depends on the operation done on the NAND.
+	 * All operations goes through the same data bus, but the operation
+	 * type depends on the address we are writing to (ALE/CLE address
+	 * lines).
+	 * Since we have no way to differentiate the different operations at
+	 * the SMC level, we must consider the worst case (the biggest setup
+	 * time among all operation types):
+	 *
+	 * NWE_SETUP = max(tCLS, tCS, tALS, tDS) - NWE_PULSE
+	 */
+	timeps = max3(conf->timings.sdr.tCLS_min, conf->timings.sdr.tCS_min,
+		      conf->timings.sdr.tALS_min);
+	timeps = max(timeps, conf->timings.sdr.tDS_min);
+	ncycles = DIV_ROUND_UP(timeps, mckperiodps);
+	ncycles = ncycles > totalcycles ? ncycles - totalcycles : 0;
+	totalcycles += ncycles;
+	ret = atmel_smc_cs_conf_set_setup(smcconf, ATMEL_SMC_NWE_SHIFT,
+					  ncycles);
+	if (ret)
+		return ret;
+
+	/*
+	 * As for the write setup timing, the write hold timing depends on the
+	 * operation done on the NAND:
+	 *
+	 * NWE_HOLD = max(tCLH, tCH, tALH, tDH, tWH)
+	 */
+	timeps = max3(conf->timings.sdr.tCLH_min, conf->timings.sdr.tCH_min,
+		      conf->timings.sdr.tALH_min);
+	timeps = max3(timeps, conf->timings.sdr.tDH_min,
+		      conf->timings.sdr.tWH_min);
+	ncycles = DIV_ROUND_UP(timeps, mckperiodps);
+	totalcycles += ncycles;
+
+	/*
+	 * The write cycle timing is directly matching tWC, but is also
+	 * dependent on the other timings on the setup and hold timings we
+	 * calculated earlier, which gives:
+	 *
+	 * NWE_CYCLE = max(tWC, NWE_SETUP + NWE_PULSE + NWE_HOLD)
+	 */
+	ncycles = DIV_ROUND_UP(conf->timings.sdr.tWC_min, mckperiodps);
+	ncycles = max(totalcycles, ncycles);
+	ret = atmel_smc_cs_conf_set_cycle(smcconf, ATMEL_SMC_NWE_SHIFT,
+					  ncycles);
+	if (ret)
+		return ret;
+
+	/*
+	 * We don't want the CS line to be toggled between each byte/word
+	 * transfer to the NAND. The only way to guarantee that is to have the
+	 * NCS_{WR,RD}_{SETUP,HOLD} timings set to 0, which in turn means:
+	 *
+	 * NCS_WR_PULSE = NWE_CYCLE
+	 */
+	ret = atmel_smc_cs_conf_set_pulse(smcconf, ATMEL_SMC_NCS_WR_SHIFT,
+					  ncycles);
+	if (ret)
+		return ret;
+
+	/*
+	 * As for the write setup timing, the read hold timing depends on the
+	 * operation done on the NAND:
+	 *
+	 * NRD_HOLD = max(tREH, tRHOH)
+	 */
+	timeps = max(conf->timings.sdr.tREH_min, conf->timings.sdr.tRHOH_min);
+	ncycles = DIV_ROUND_UP(timeps, mckperiodps);
+	totalcycles = ncycles;
+
+	/*
+	 * TDF = tRHZ - NRD_HOLD
+	 */
+	ncycles = DIV_ROUND_UP(conf->timings.sdr.tRHZ_max, mckperiodps);
+	ncycles -= totalcycles;
+
+	/*
+	 * In ONFI 4.0 specs, tRHZ has been increased to support EDO NANDs and
+	 * we might end up with a config that does not fit in the TDF field.
+	 * Just take the max value in this case and hope that the NAND is more
+	 * tolerant than advertised.
+	 */
+	if (ncycles > ATMEL_SMC_MODE_TDF_MAX)
+		ncycles = ATMEL_SMC_MODE_TDF_MAX;
+
+	smcconf->mode |= ATMEL_SMC_MODE_TDF(ncycles) |
+			 ATMEL_SMC_MODE_TDFMODE_OPTIMIZED;
+
+	/*
+	 * Read pulse timing directly matches tRP:
+	 *
+	 * NRD_PULSE = tRP
+	 */
+	ncycles = DIV_ROUND_UP(conf->timings.sdr.tRP_min, mckperiodps);
+	totalcycles += ncycles;
+	ret = atmel_smc_cs_conf_set_pulse(smcconf, ATMEL_SMC_NRD_SHIFT,
+					  ncycles);
+	if (ret)
+		return ret;
+
+	/*
+	 * The write cycle timing is directly matching tWC, but is also
+	 * dependent on the setup and hold timings we calculated earlier,
+	 * which gives:
+	 *
+	 * NRD_CYCLE = max(tRC, NRD_PULSE + NRD_HOLD)
+	 *
+	 * NRD_SETUP is always 0.
+	 */
+	ncycles = DIV_ROUND_UP(conf->timings.sdr.tRC_min, mckperiodps);
+	ncycles = max(totalcycles, ncycles);
+	ret = atmel_smc_cs_conf_set_cycle(smcconf, ATMEL_SMC_NRD_SHIFT,
+					  ncycles);
+	if (ret)
+		return ret;
+
+	/*
+	 * We don't want the CS line to be toggled between each byte/word
+	 * transfer from the NAND. The only way to guarantee that is to have
+	 * the NCS_{WR,RD}_{SETUP,HOLD} timings set to 0, which in turn means:
+	 *
+	 * NCS_RD_PULSE = NRD_CYCLE
+	 */
+	ret = atmel_smc_cs_conf_set_pulse(smcconf, ATMEL_SMC_NCS_RD_SHIFT,
+					  ncycles);
+	if (ret)
+		return ret;
+
+	/* Txxx timings are directly matching tXXX ones. */
+	ncycles = DIV_ROUND_UP(conf->timings.sdr.tCLR_min, mckperiodps);
+	ret = atmel_smc_cs_conf_set_timing(smcconf,
+					   ATMEL_HSMC_TIMINGS_TCLR_SHIFT,
+					   ncycles);
+	if (ret)
+		return ret;
+
+	ncycles = DIV_ROUND_UP(conf->timings.sdr.tADL_min, mckperiodps);
+	ret = atmel_smc_cs_conf_set_timing(smcconf,
+					   ATMEL_HSMC_TIMINGS_TADL_SHIFT,
+					   ncycles);
+	if (ret)
+		return ret;
+
+	ncycles = DIV_ROUND_UP(conf->timings.sdr.tAR_min, mckperiodps);
+	ret = atmel_smc_cs_conf_set_timing(smcconf,
+					   ATMEL_HSMC_TIMINGS_TAR_SHIFT,
+					   ncycles);
+	if (ret)
+		return ret;
+
+	ncycles = DIV_ROUND_UP(conf->timings.sdr.tRR_min, mckperiodps);
+	ret = atmel_smc_cs_conf_set_timing(smcconf,
+					   ATMEL_HSMC_TIMINGS_TRR_SHIFT,
+					   ncycles);
+	if (ret)
+		return ret;
+
+	ncycles = DIV_ROUND_UP(conf->timings.sdr.tWB_max, mckperiodps);
+	ret = atmel_smc_cs_conf_set_timing(smcconf,
+					   ATMEL_HSMC_TIMINGS_TWB_SHIFT,
+					   ncycles);
+	if (ret)
+		return ret;
+
+	/* Attach the CS line to the NFC logic. */
+	smcconf->timings |= ATMEL_HSMC_TIMINGS_NFSEL;
+
+	/* Set the appropriate data bus width. */
+	if (nand->base.options & NAND_BUSWIDTH_16)
+		smcconf->mode |= ATMEL_SMC_MODE_DBW_16;
+
+	/* Operate in NRD/NWE READ/WRITEMODE. */
+	smcconf->mode |= ATMEL_SMC_MODE_READMODE_NRD |
+			 ATMEL_SMC_MODE_WRITEMODE_NWE;
+
+	return 0;
+}
+
+static int atmel_smc_nand_setup_data_interface(struct atmel_nand *nand,
+					int csline,
+					const struct nand_data_interface *conf)
+{
+	struct atmel_nand_controller *nc;
+	struct atmel_smc_cs_conf smcconf;
+	struct atmel_nand_cs *cs;
+	int ret;
+
+	nc = to_nand_controller(nand->base.controller);
+
+	ret = atmel_smc_nand_prepare_smcconf(nand, conf, &smcconf);
+	if (ret)
+		return ret;
+
+	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
+		return 0;
+
+	cs = &nand->cs[csline];
+	cs->smcconf = smcconf;
+	atmel_smc_cs_conf_apply(nc->smc, cs->id, &cs->smcconf);
+
+	return 0;
+}
+
+static int atmel_hsmc_nand_setup_data_interface(struct atmel_nand *nand,
+					int csline,
+					const struct nand_data_interface *conf)
+{
+	struct atmel_nand_controller *nc;
+	struct atmel_smc_cs_conf smcconf;
+	struct atmel_nand_cs *cs;
+	int ret;
+
+	nc = to_nand_controller(nand->base.controller);
+
+	ret = atmel_smc_nand_prepare_smcconf(nand, conf, &smcconf);
+	if (ret)
+		return ret;
+
+	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
+		return 0;
+
+	cs = &nand->cs[csline];
+	cs->smcconf = smcconf;
+
+	if (cs->rb.type == ATMEL_NAND_NATIVE_RB)
+		cs->smcconf.timings |= ATMEL_HSMC_TIMINGS_RBNSEL(cs->rb.id);
+
+	atmel_hsmc_cs_conf_apply(nc->smc, cs->id, &cs->smcconf);
+
+	return 0;
+}
+
+static int atmel_nand_setup_data_interface(struct mtd_info *mtd, int csline,
+					const struct nand_data_interface *conf)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct atmel_nand *nand = to_atmel_nand(chip);
+	struct atmel_nand_controller *nc;
+
+	nc = to_nand_controller(nand->base.controller);
+
+	if (csline >= nand->numcs ||
+	    (csline < 0 && csline != NAND_DATA_IFACE_CHECK_ONLY))
+		return -EINVAL;
+
+	return nc->caps->ops->setup_data_interface(nand, csline, conf);
+}
+
 static void atmel_nand_init(struct atmel_nand_controller *nc,
 			    struct atmel_nand *nand)
 {
@@ -1161,6 +1453,9 @@ static void atmel_nand_init(struct atmel_nand_controller *nc,
 	chip->write_buf = atmel_nand_write_buf;
 	chip->select_chip = atmel_nand_select_chip;
 
+	if (nc->mck && nc->caps->ops->setup_data_interface)
+		chip->setup_data_interface = atmel_nand_setup_data_interface;
+
 	/* Some NANDs require a longer delay than the default one (20us). */
 	chip->chip_delay = 40;
 
@@ -1735,6 +2030,12 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
 	if (nc->caps->legacy_of_bindings || !nc->dev->of_node)
 		return 0;
 
+	nc->mck = of_clk_get(dev->parent->of_node, 0);
+	if (IS_ERR(nc->mck)) {
+		dev_err(dev, "Failed to retrieve MCK clk\n");
+		return PTR_ERR(nc->mck);
+	}
+
 	np = of_parse_phandle(dev->parent->of_node, "atmel,smc", 0);
 	if (!np) {
 		dev_err(dev, "Missing or invalid atmel,smc property\n");
@@ -2045,6 +2346,7 @@ const struct atmel_nand_controller_ops atmel_hsmc_nc_ops = {
 	.remove = atmel_hsmc_nand_controller_remove,
 	.ecc_init = atmel_hsmc_nand_ecc_init,
 	.nand_init = atmel_hsmc_nand_init,
+	.setup_data_interface = atmel_hsmc_nand_setup_data_interface,
 };
 
 static const struct atmel_nand_controller_caps atmel_sama5_nc_caps = {
@@ -2099,7 +2401,14 @@ atmel_smc_nand_controller_remove(struct atmel_nand_controller *nc)
 	return 0;
 }
 
-const struct atmel_nand_controller_ops atmel_smc_nc_ops = {
+/*
+ * The SMC reg layout of at91rm9200 is completely different which prevents us
+ * from re-using atmel_smc_nand_setup_data_interface() for the
+ * ->setup_data_interface() hook.
+ * At this point, there's no support for the at91rm9200 SMC IP, so we leave
+ * ->setup_data_interface() unassigned.
+ */
+const struct atmel_nand_controller_ops at91rm9200_nc_ops = {
 	.probe = atmel_smc_nand_controller_probe,
 	.remove = atmel_smc_nand_controller_remove,
 	.ecc_init = atmel_nand_ecc_init,
@@ -2109,6 +2418,20 @@ const struct atmel_nand_controller_ops atmel_smc_nc_ops = {
 static const struct atmel_nand_controller_caps atmel_rm9200_nc_caps = {
 	.ale_offs = 1 << 21,
 	.cle_offs = 1 << 22,
+	.ops = &at91rm9200_nc_ops,
+};
+
+const struct atmel_nand_controller_ops atmel_smc_nc_ops = {
+	.probe = atmel_smc_nand_controller_probe,
+	.remove = atmel_smc_nand_controller_remove,
+	.ecc_init = atmel_nand_ecc_init,
+	.nand_init = atmel_smc_nand_init,
+	.setup_data_interface = atmel_smc_nand_setup_data_interface,
+};
+
+static const struct atmel_nand_controller_caps atmel_sam9260_nc_caps = {
+	.ale_offs = 1 << 21,
+	.cle_offs = 1 << 22,
 	.ops = &atmel_smc_nc_ops,
 };
 
@@ -2129,14 +2452,14 @@ static const struct atmel_nand_controller_caps atmel_sam9g45_nc_caps = {
 static const struct atmel_nand_controller_caps atmel_rm9200_nand_caps = {
 	.ale_offs = 1 << 21,
 	.cle_offs = 1 << 22,
-	.ops = &atmel_smc_nc_ops,
+	.ops = &at91rm9200_nc_ops,
 	.legacy_of_bindings = true,
 };
 
 static const struct atmel_nand_controller_caps atmel_sam9261_nand_caps = {
 	.ale_offs = 1 << 22,
 	.cle_offs = 1 << 21,
-	.ops = &atmel_smc_nc_ops,
+	.ops = &at91rm9200_nc_ops,
 	.legacy_of_bindings = true,
 };
 
@@ -2144,7 +2467,7 @@ static const struct atmel_nand_controller_caps atmel_sam9g45_nand_caps = {
 	.has_dma = true,
 	.ale_offs = 1 << 21,
 	.cle_offs = 1 << 22,
-	.ops = &atmel_smc_nc_ops,
+	.ops = &at91rm9200_nc_ops,
 	.legacy_of_bindings = true,
 };
 
@@ -2155,7 +2478,7 @@ static const struct of_device_id atmel_nand_controller_of_ids[] = {
 	},
 	{
 		.compatible = "atmel,at91sam9260-nand-controller",
-		.data = &atmel_rm9200_nc_caps,
+		.data = &atmel_sam9260_nc_caps,
 	},
 	{
 		.compatible = "atmel,at91sam9261-nand-controller",
-- 
2.7.4
