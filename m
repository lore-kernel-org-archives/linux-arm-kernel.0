From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Thu, 14 Jul 2016 11:06:45 -0500
Subject: [PATCH 07/10] EDAC, altera: Add Arria10 USB EDAC support
In-Reply-To: <1468512408-5156-1-git-send-email-tthayer@opensource.altera.com>
References: <1468512408-5156-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1468512408-5156-8-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add Altera Arria10 USB FIFO memory EDAC support.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 drivers/edac/Kconfig       |    7 +++++++
 drivers/edac/altera_edac.c |   34 +++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index d1fd57a..1966068 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -412,6 +412,13 @@ config EDAC_ALTERA_DMA
 	  Support for error detection and correction on the
 	  Altera DMA FIFO Memory for Altera SoCs.
 
+config EDAC_ALTERA_USB
+	bool "Altera USB FIFO ECC"
+	depends on EDAC_ALTERA=y && USB_DWC2
+	help
+	  Support for error detection and correction on the
+	  Altera USB FIFO Memory for Altera SoCs.
+
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
 	depends on EDAC_MM_EDAC && ARCH_ZYNQ
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 6e4afbc..439d6cb 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1339,6 +1339,33 @@ early_initcall(socfpga_init_dma_ecc);
 
 #endif	/* CONFIG_EDAC_ALTERA_DMA */
 
+/********************** USB Device Functions **********************/
+
+#ifdef CONFIG_EDAC_ALTERA_USB
+
+static const struct edac_device_prv_data a10_usbecc_data = {
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
+static int __init socfpga_init_usb_ecc(void)
+{
+	return altr_init_a10_ecc_device_type("altr,socfpga-usb-ecc");
+}
+
+early_initcall(socfpga_init_usb_ecc);
+
+#endif	/* CONFIG_EDAC_ALTERA_USB */
+
 /********************* Arria10 EDAC Device Functions *************************/
 static const struct of_device_id altr_edac_a10_device_of_match[] = {
 #ifdef CONFIG_EDAC_ALTERA_L2C
@@ -1358,6 +1385,9 @@ static const struct of_device_id altr_edac_a10_device_of_match[] = {
 #ifdef CONFIG_EDAC_ALTERA_DMA
 	{ .compatible = "altr,socfpga-dma-ecc", .data = &a10_dmaecc_data },
 #endif
+#ifdef CONFIG_EDAC_ALTERA_USB
+	{ .compatible = "altr,socfpga-usb-ecc", .data = &a10_usbecc_data },
+#endif
 	{},
 };
 MODULE_DEVICE_TABLE(of, altr_edac_a10_device_of_match);
@@ -1653,7 +1683,9 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 			 (of_device_is_compatible(child,
 						  "altr,socfpga-nand-ecc")) ||
 			 (of_device_is_compatible(child,
-						  "altr,socfpga-dma-ecc")))
+						  "altr,socfpga-dma-ecc")) ||
+			 (of_device_is_compatible(child,
+						  "altr,socfpga-usb-ecc")))
 			altr_edac_a10_device_add(edac, child);
 		else if (of_device_is_compatible(child,
 						 "altr,sdram-edac-a10"))
-- 
1.7.9.5
