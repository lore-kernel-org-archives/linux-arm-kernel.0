From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Tue, 12 Apr 2016 17:13:00 -0500
Subject: [PATCH 5/6] EDAC, altera: Add Arria10 Ethernet EDAC support
In-Reply-To: <1460499181-23080-1-git-send-email-tthayer@opensource.altera.com>
References: <1460499181-23080-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1460499181-23080-6-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add Altera Arria10 Ethernet FIFO memory EDAC support.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 drivers/edac/Kconfig       |    7 ++
 drivers/edac/altera_edac.c |  153 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/edac/altera_edac.h |   14 ++++
 3 files changed, 174 insertions(+)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 6ca7474..d0c1dab 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -391,6 +391,13 @@ config EDAC_ALTERA_OCRAM
 	  Support for error detection and correction on the
 	  Altera On-Chip RAM Memory for Altera SoCs.
 
+config EDAC_ALTERA_ETHERNET
+	bool "Altera Ethernet FIFO ECC"
+	depends on EDAC_ALTERA=y
+	help
+	  Support for error detection and correction on the
+	  Altera Ethernet FIFO Memory for Altera SoCs.
+
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
 	depends on EDAC_MM_EDAC && ARCH_ZYNQ
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 0955ab0..43b6f36 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -553,6 +553,12 @@ const struct edac_device_prv_data ocramecc_data;
 const struct edac_device_prv_data l2ecc_data;
 const struct edac_device_prv_data a10_ocramecc_data;
 const struct edac_device_prv_data a10_l2ecc_data;
+const struct edac_device_prv_data a10_enet0rxecc_data;
+const struct edac_device_prv_data a10_enet0txecc_data;
+const struct edac_device_prv_data a10_enet1rxecc_data;
+const struct edac_device_prv_data a10_enet1txecc_data;
+const struct edac_device_prv_data a10_enet2rxecc_data;
+const struct edac_device_prv_data a10_enet2txecc_data;
 
 static irqreturn_t altr_edac_device_handler(int irq, void *dev_id)
 {
@@ -716,6 +722,20 @@ static const struct of_device_id altr_edac_device_of_match[] = {
 	{ .compatible = "altr,socfpga-a10-ocram-ecc",
 	  .data = (void *)&a10_ocramecc_data },
 #endif
+#ifdef CONFIG_EDAC_ALTERA_ETHERNET
+	{ .compatible = "altr,socfpga-a10-emac0-rx-ecc",
+	  .data = (void *)&a10_enet0rxecc_data },
+	{ .compatible = "altr,socfpga-a10-emac0-tx-ecc",
+	  .data = (void *)&a10_enet0txecc_data },
+	{ .compatible = "altr,socfpga-a10-emac1-rx-ecc",
+	  .data = (void *)&a10_enet1rxecc_data },
+	{ .compatible = "altr,socfpga-a10-emac1-tx-ecc",
+	  .data = (void *)&a10_enet1txecc_data },
+	{ .compatible = "altr,socfpga-a10-emac2-rx-ecc",
+	  .data = (void *)&a10_enet2rxecc_data },
+	{ .compatible = "altr,socfpga-a10-emac2-tx-ecc",
+	  .data = (void *)&a10_enet2txecc_data },
+#endif
 	{},
 };
 MODULE_DEVICE_TABLE(of, altr_edac_device_of_match);
@@ -1033,6 +1053,126 @@ const struct edac_device_prv_data a10_l2ecc_data = {
 
 #endif	/* CONFIG_EDAC_ALTERA_L2C */
 
+/********************* Ethernet Device Functions ********************/
+
+#ifdef CONFIG_EDAC_ALTERA_ETHERNET
+
+const struct edac_device_prv_data a10_enet0rxecc_data = {
+	.setup = altr_check_ecc_deps,
+	.ce_clear_mask = ALTR_A10_ECC_SERRPENA,
+	.ue_clear_mask = ALTR_A10_ECC_DERRPENA,
+	.irq_status_mask = A10_SYSMGR_ECC_INTSTAT_EMAC0RX,
+	.dbgfs_name = "altr_emac0rx_trigger",
+	.ecc_enable_mask = ALTR_A10_ETHERNET_ECC_EN_CTL,
+	.ecc_en_ofst = ALTR_A10_ECC_CTRL_OFST,
+	.ce_set_mask = ALTR_A10_ECC_TSERRA,
+	.ue_set_mask = ALTR_A10_ECC_TDERRA,
+	.set_err_ofst = ALTR_A10_ECC_INTTEST_OFST,
+	.ecc_irq_handler = altr_edac_a10_ecc_irq,
+	.inject_fops = &altr_edac_a10_device_inject_fops,
+};
+
+const struct edac_device_prv_data a10_enet0txecc_data = {
+	.setup = altr_check_ecc_deps,
+	.ce_clear_mask = ALTR_A10_ECC_SERRPENA,
+	.ue_clear_mask = ALTR_A10_ECC_DERRPENA,
+	.irq_status_mask = A10_SYSMGR_ECC_INTSTAT_EMAC0TX,
+	.dbgfs_name = "altr_emac0tx_trigger",
+	.ecc_enable_mask = ALTR_A10_ETHERNET_ECC_EN_CTL,
+	.ecc_en_ofst = ALTR_A10_ECC_CTRL_OFST,
+	.ce_set_mask = ALTR_A10_ECC_TSERRA,
+	.ue_set_mask = ALTR_A10_ECC_TDERRA,
+	.set_err_ofst = ALTR_A10_ECC_INTTEST_OFST,
+	.ecc_irq_handler = altr_edac_a10_ecc_irq,
+	.inject_fops = &altr_edac_a10_device_inject_fops,
+};
+
+const struct edac_device_prv_data a10_enet1rxecc_data = {
+	.setup = altr_check_ecc_deps,
+	.ce_clear_mask = ALTR_A10_ECC_SERRPENA,
+	.ue_clear_mask = ALTR_A10_ECC_DERRPENA,
+	.irq_status_mask = A10_SYSMGR_ECC_INTSTAT_EMAC1RX,
+	.dbgfs_name = "altr_emac1rx_trigger",
+	.ecc_enable_mask = ALTR_A10_ETHERNET_ECC_EN_CTL,
+	.ecc_en_ofst = ALTR_A10_ECC_CTRL_OFST,
+	.ce_set_mask = ALTR_A10_ECC_TSERRA,
+	.ue_set_mask = ALTR_A10_ECC_TDERRA,
+	.set_err_ofst = ALTR_A10_ECC_INTTEST_OFST,
+	.ecc_irq_handler = altr_edac_a10_ecc_irq,
+	.inject_fops = &altr_edac_a10_device_inject_fops,
+};
+
+const struct edac_device_prv_data a10_enet1txecc_data = {
+	.setup = altr_check_ecc_deps,
+	.ce_clear_mask = ALTR_A10_ECC_SERRPENA,
+	.ue_clear_mask = ALTR_A10_ECC_DERRPENA,
+	.irq_status_mask = A10_SYSMGR_ECC_INTSTAT_EMAC1TX,
+	.dbgfs_name = "altr_emac1tx_trigger",
+	.ecc_enable_mask = ALTR_A10_ETHERNET_ECC_EN_CTL,
+	.ecc_en_ofst = ALTR_A10_ECC_CTRL_OFST,
+	.ce_set_mask = ALTR_A10_ECC_TSERRA,
+	.ue_set_mask = ALTR_A10_ECC_TDERRA,
+	.set_err_ofst = ALTR_A10_ECC_INTTEST_OFST,
+	.ecc_irq_handler = altr_edac_a10_ecc_irq,
+	.inject_fops = &altr_edac_a10_device_inject_fops,
+};
+
+const struct edac_device_prv_data a10_enet2rxecc_data = {
+	.setup = altr_check_ecc_deps,
+	.ce_clear_mask = ALTR_A10_ECC_SERRPENA,
+	.ue_clear_mask = ALTR_A10_ECC_DERRPENA,
+	.irq_status_mask = A10_SYSMGR_ECC_INTSTAT_EMAC2RX,
+	.dbgfs_name = "altr_emac2rx_trigger",
+	.ecc_enable_mask = ALTR_A10_ETHERNET_ECC_EN_CTL,
+	.ecc_en_ofst = ALTR_A10_ECC_CTRL_OFST,
+	.ce_set_mask = ALTR_A10_ECC_TSERRA,
+	.ue_set_mask = ALTR_A10_ECC_TDERRA,
+	.set_err_ofst = ALTR_A10_ECC_INTTEST_OFST,
+	.ecc_irq_handler = altr_edac_a10_ecc_irq,
+	.inject_fops = &altr_edac_a10_device_inject_fops,
+};
+
+const struct edac_device_prv_data a10_enet2txecc_data = {
+	.setup = altr_check_ecc_deps,
+	.ce_clear_mask = ALTR_A10_ECC_SERRPENA,
+	.ue_clear_mask = ALTR_A10_ECC_DERRPENA,
+	.irq_status_mask = A10_SYSMGR_ECC_INTSTAT_EMAC2TX,
+	.dbgfs_name = "altr_emac2tx_trigger",
+	.ecc_enable_mask = ALTR_A10_ETHERNET_ECC_EN_CTL,
+	.ecc_en_ofst = ALTR_A10_ECC_CTRL_OFST,
+	.ce_set_mask = ALTR_A10_ECC_TSERRA,
+	.ue_set_mask = ALTR_A10_ECC_TDERRA,
+	.set_err_ofst = ALTR_A10_ECC_INTTEST_OFST,
+	.ecc_irq_handler = altr_edac_a10_ecc_irq,
+	.inject_fops = &altr_edac_a10_device_inject_fops,
+};
+
+static const struct a10_ecc_init_vars a10_enet_ecc_init[] = {
+	{"altr,socfpga-a10-emac0-rx-ecc", A10_SYSMGR_ECC_INTSTAT_EMAC0RX},
+	{"altr,socfpga-a10-emac0-tx-ecc", A10_SYSMGR_ECC_INTSTAT_EMAC0TX},
+	{"altr,socfpga-a10-emac1-rx-ecc", A10_SYSMGR_ECC_INTSTAT_EMAC1RX},
+	{"altr,socfpga-a10-emac1-tx-ecc", A10_SYSMGR_ECC_INTSTAT_EMAC1TX},
+	{"altr,socfpga-a10-emac2-rx-ecc", A10_SYSMGR_ECC_INTSTAT_EMAC2RX},
+	{"altr,socfpga-a10-emac2-tx-ecc", A10_SYSMGR_ECC_INTSTAT_EMAC2TX},
+};
+
+static int __init socfpga_init_ethernet_ecc(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(a10_enet_ecc_init); i++) {
+		altr_init_a10_ecc_block(a10_enet_ecc_init[i].ecc_str,
+					a10_enet_ecc_init[i].irq_mask,
+					ALTR_A10_ETHERNET_ECC_EN_CTL, 0);
+	}
+
+	return 0;
+}
+
+early_initcall(socfpga_init_ethernet_ecc);
+
+#endif	/* CONFIG_EDAC_ALTERA_ETHERNET */
+
 /********************* Arria10 EDAC Device Functions *************************/
 
 /*
@@ -1411,6 +1551,19 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 		else if (of_device_is_compatible(child,
 						 "altr,socfpga-a10-ocram-ecc"))
 			altr_edac_a10_device_add(edac, child);
+		else if ((of_device_is_compatible(child,
+					"altr,socfpga-a10-emac0-rx-ecc")) ||
+			 (of_device_is_compatible(child,
+					"altr,socfpga-a10-emac0-tx-ecc")) ||
+			 (of_device_is_compatible(child,
+					"altr,socfpga-a10-emac1-rx-ecc")) ||
+			 (of_device_is_compatible(child,
+					"altr,socfpga-a10-emac1-tx-ecc")) ||
+			 (of_device_is_compatible(child,
+					"altr,socfpga-a10-emac2-rx-ecc")) ||
+			 (of_device_is_compatible(child,
+					"altr,socfpga-a10-emac2-tx-ecc")))
+			altr_edac_a10_device_add(edac, child);
 	}
 
 	return 0;
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 7e66015..d2275b4 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -255,6 +255,12 @@ struct altr_sdram_mc_data {
 #define A10_SYSMGR_ECC_INTSTAT_DERR_OFST  0xA0
 #define A10_SYSMGR_ECC_INTSTAT_L2         BIT(0)
 #define A10_SYSMGR_ECC_INTSTAT_OCRAM      BIT(1)
+#define A10_SYSMGR_ECC_INTSTAT_EMAC0RX    BIT(4)
+#define A10_SYSMGR_ECC_INTSTAT_EMAC0TX    BIT(5)
+#define A10_SYSMGR_ECC_INTSTAT_EMAC1RX    BIT(6)
+#define A10_SYSMGR_ECC_INTSTAT_EMAC1TX    BIT(7)
+#define A10_SYSMGR_ECC_INTSTAT_EMAC2RX    BIT(8)
+#define A10_SYSMGR_ECC_INTSTAT_EMAC2TX    BIT(9)
 
 #define A10_SYSGMR_MPU_CLEAR_L2_ECC_OFST  0xA8
 #define A10_SYSGMR_MPU_CLEAR_L2_ECC_SB    BIT(15)
@@ -280,6 +286,9 @@ struct altr_sdram_mc_data {
 /* Arria 10 OCRAM ECC Management Group Defines */
 #define ALTR_A10_OCRAM_ECC_EN_CTL       (BIT(1) | BIT(0))
 
+/* Arria 10 Ethernet ECC Management Group Defines */
+#define ALTR_A10_ETHERNET_ECC_EN_CTL    BIT(0)
+
 /* A10 ECC Controller memory initialization timeout */
 #define ALTR_A10_ECC_INIT_WATCHDOG_10US      10000
 
@@ -326,4 +335,9 @@ struct altr_arria10_edac {
 	struct list_head	a10_ecc_devices;
 };
 
+struct a10_ecc_init_vars {
+	u8 ecc_str[32];
+	u32 irq_mask;
+};
+
 #endif	/* #ifndef _ALTERA_EDAC_H */
-- 
1.7.9.5
