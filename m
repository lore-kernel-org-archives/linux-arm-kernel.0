From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 22 Jun 2016 08:58:58 -0500
Subject: [PATCHv5 7/8] EDAC, altera: Add Arria10 Ethernet EDAC support
In-Reply-To: <1466603939-7526-1-git-send-email-tthayer@opensource.altera.com>
References: <1466603939-7526-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1466603939-7526-8-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add Altera Arria10 Ethernet FIFO memory EDAC support. Update
to support a common compatibility string for all Ethernet
FIFOs in the DT.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2  Remove (void *) cast from altr_edac_device_of_match[]
    Addition of panic flag to ethernet private data.
v3  Use common compatiblity string.
    Simplify socfpga_init_ethernet_ecc().
v4  Make private data static.
    Rename Ethernet private data to more generic name.
    Remove panic field initialization.
    Rename EN mask field to ALTR_A10_COMMON_ECC_EN_CTL
v5  No change
---
 drivers/edac/Kconfig       |    7 +++++++
 drivers/edac/altera_edac.c |   37 +++++++++++++++++++++++++++++++++++--
 drivers/edac/altera_edac.h |    3 +++
 3 files changed, 45 insertions(+), 2 deletions(-)

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
index 6091b76..2398d07 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1258,6 +1258,33 @@ static const struct edac_device_prv_data a10_l2ecc_data = {
 
 #endif	/* CONFIG_EDAC_ALTERA_L2C */
 
+/********************* Ethernet Device Functions ********************/
+
+#ifdef CONFIG_EDAC_ALTERA_ETHERNET
+
+static const struct edac_device_prv_data a10_enetecc_data = {
+	.setup = altr_check_ecc_deps,
+	.ce_clear_mask = ALTR_A10_ECC_SERRPENA,
+	.ue_clear_mask = ALTR_A10_ECC_DERRPENA,
+	.dbgfs_name = "altr_trigger",
+	.ecc_enable_mask = ALTR_A10_COMMON_ECC_EN_CTL,
+	.ecc_en_ofst = ALTR_A10_ECC_CTRL_OFST,
+	.ce_set_mask = ALTR_A10_ECC_TSERRA,
+	.ue_set_mask = ALTR_A10_ECC_TDERRA,
+	.set_err_ofst = ALTR_A10_ECC_INTTEST_OFST,
+	.ecc_irq_handler = altr_edac_a10_ecc_irq,
+	.inject_fops = &altr_edac_a10_device_inject_fops,
+};
+
+static int __init socfpga_init_ethernet_ecc(void)
+{
+	return altr_init_a10_ecc_device_type("altr,socfpga-eth-mac-ecc");
+}
+
+early_initcall(socfpga_init_ethernet_ecc);
+
+#endif	/* CONFIG_EDAC_ALTERA_ETHERNET */
+
 /********************* Arria10 EDAC Device Functions *************************/
 static const struct of_device_id altr_edac_a10_device_of_match[] = {
 #ifdef CONFIG_EDAC_ALTERA_L2C
@@ -1267,6 +1294,10 @@ static const struct of_device_id altr_edac_a10_device_of_match[] = {
 	{ .compatible = "altr,socfpga-a10-ocram-ecc",
 	  .data = &a10_ocramecc_data },
 #endif
+#ifdef CONFIG_EDAC_ALTERA_ETHERNET
+	{ .compatible = "altr,socfpga-eth-mac-ecc",
+	  .data = &a10_enetecc_data },
+#endif
 	{},
 };
 MODULE_DEVICE_TABLE(of, altr_edac_a10_device_of_match);
@@ -1555,8 +1586,10 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 			continue;
 		if (of_device_is_compatible(child, "altr,socfpga-a10-l2-ecc"))
 			altr_edac_a10_device_add(edac, child);
-		else if (of_device_is_compatible(child,
-						 "altr,socfpga-a10-ocram-ecc"))
+		else if ((of_device_is_compatible(child,
+					"altr,socfpga-a10-ocram-ecc")) ||
+			 (of_device_is_compatible(child,
+					"altr,socfpga-eth-mac-ecc")))
 			altr_edac_a10_device_add(edac, child);
 		else if (of_device_is_compatible(child,
 						 "altr,sdram-edac-a10"))
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index aa7c690..687d8e7 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -285,6 +285,9 @@ struct altr_sdram_mc_data {
 /* Arria 10 OCRAM ECC Management Group Defines */
 #define ALTR_A10_OCRAM_ECC_EN_CTL       (BIT(1) | BIT(0))
 
+/* Arria 10 Ethernet ECC Management Group Defines */
+#define ALTR_A10_COMMON_ECC_EN_CTL      BIT(0)
+
 /* A10 ECC Controller memory initialization timeout */
 #define ALTR_A10_ECC_INIT_WATCHDOG_10US      10000
 
-- 
1.7.9.5
