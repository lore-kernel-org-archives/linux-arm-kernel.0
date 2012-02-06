From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon,  6 Feb 2012 11:35:12 +0100
Subject: [PATCH 5/6 V2] atmel/nand: add DT support
In-Reply-To: <1327727444-23908-1-git-send-email-plagnioj@jcrosoft.com>
References: <1327727444-23908-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1328524512-18159-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use a local copy of board informatin and fill with DT data

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-mtd at lists.infradead.org
---
V2:
	comment from Grant
	rebase over rc3

Best Regards,
J.
 .../devicetree/bindings/mtd/atmel-nand.txt         |   41 ++++++++
 drivers/mtd/nand/atmel_nand.c                      |  105 ++++++++++++++++----
 2 files changed, 126 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/atmel-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
new file mode 100644
index 0000000..a910ab9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
@@ -0,0 +1,41 @@
+Atmel NAND flash
+
+Required properties:
+- compatible : "atmel,at91rm9200-nand".
+- reg : should specify localbus address and size used for the chip,
+	and if availlable the ECC.
+- atmel,nand-addr-offset : offset for the address latch.
+- atmel,nand-cmd-offset : offset for the command latch.
+- #address-cells, #size-cells : Must be present if the device has sub-nodes
+  representing partitions.
+
+- gpios : specifies the gpio pins to control the NAND device. detect is an
+  optional gpio and may be set to 0 if not present.
+
+Optional properties:
+- nand-ecc-mode : String, operation mode of the NAND ecc mode, soft by default.
+  Supported values are: "none", "soft", "hw", "hw_syndrome", "hw_oob_first",
+  "soft_bch".
+- nand-bus-width : 8 or 16 bus width if not present 8
+- nand-on-flash-bbt: boolean to enable on flash bbt option if not present false
+
+Examples:
+nand0: nand at 40000000,0 {
+	compatible = "atmel,at91rm9200-nand";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	reg = <0x40000000 0x10000000
+	       0xffffe800 0x200
+	      >;
+	atmel,nand-addr-offset = <21>;
+	atmel,nand-cmd-offset = <22>;
+	nand-on-flash-bbt = <1>;
+	nand-ecc-mode = "soft";
+	gpios = <&pioC 13 0
+		 &pioC 14 0
+		 0
+		>;
+	partition at 0 {
+		...
+	};
+};
diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 045d174..7f91ed2 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -27,6 +27,10 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/of_mtd.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
@@ -83,7 +87,7 @@ struct atmel_nand_host {
 	struct mtd_info		mtd;
 	void __iomem		*io_base;
 	dma_addr_t		io_phys;
-	struct atmel_nand_data	*board;
+	struct atmel_nand_data	board;
 	struct device		*dev;
 	void __iomem		*ecc;
 
@@ -101,8 +105,8 @@ static int cpu_has_dma(void)
  */
 static void atmel_nand_enable(struct atmel_nand_host *host)
 {
-	if (gpio_is_valid(host->board->enable_pin))
-		gpio_set_value(host->board->enable_pin, 0);
+	if (gpio_is_valid(host->board.enable_pin))
+		gpio_set_value(host->board.enable_pin, 0);
 }
 
 /*
@@ -110,8 +114,8 @@ static void atmel_nand_enable(struct atmel_nand_host *host)
  */
 static void atmel_nand_disable(struct atmel_nand_host *host)
 {
-	if (gpio_is_valid(host->board->enable_pin))
-		gpio_set_value(host->board->enable_pin, 1);
+	if (gpio_is_valid(host->board.enable_pin))
+		gpio_set_value(host->board.enable_pin, 1);
 }
 
 /*
@@ -132,9 +136,9 @@ static void atmel_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl
 		return;
 
 	if (ctrl & NAND_CLE)
-		writeb(cmd, host->io_base + (1 << host->board->cle));
+		writeb(cmd, host->io_base + (1 << host->board.cle));
 	else
-		writeb(cmd, host->io_base + (1 << host->board->ale));
+		writeb(cmd, host->io_base + (1 << host->board.ale));
 }
 
 /*
@@ -145,8 +149,8 @@ static int atmel_nand_device_ready(struct mtd_info *mtd)
 	struct nand_chip *nand_chip = mtd->priv;
 	struct atmel_nand_host *host = nand_chip->priv;
 
-	return gpio_get_value(host->board->rdy_pin) ^
-                !!host->board->rdy_pin_active_low;
+	return gpio_get_value(host->board.rdy_pin) ^
+                !!host->board.rdy_pin_active_low;
 }
 
 /*
@@ -261,7 +265,7 @@ static void atmel_read_buf(struct mtd_info *mtd, u8 *buf, int len)
 		if (atmel_nand_dma_op(mtd, buf, len, 1) == 0)
 			return;
 
-	if (host->board->bus_width_16)
+	if (host->board.bus_width_16)
 		atmel_read_buf16(mtd, buf, len);
 	else
 		atmel_read_buf8(mtd, buf, len);
@@ -277,7 +281,7 @@ static void atmel_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
 		if (atmel_nand_dma_op(mtd, (void *)buf, len, 0) == 0)
 			return;
 
-	if (host->board->bus_width_16)
+	if (host->board.bus_width_16)
 		atmel_write_buf16(mtd, buf, len);
 	else
 		atmel_write_buf8(mtd, buf, len);
@@ -469,6 +473,48 @@ static void atmel_nand_hwctl(struct mtd_info *mtd, int mode)
 	}
 }
 
+static int __devinit atmel_of_init_port(struct atmel_nand_host *host,
+					 struct device_node *np)
+{
+	u32 val;
+	int ecc_mode;
+	struct atmel_nand_data *board = &host->board;
+	enum of_gpio_flags flags;
+
+	if (of_property_read_u32(np, "atmel,nand-addr-offset", &val) == 0) {
+		if (val >= 32) {
+			dev_err(host->dev, "invalid addr-offset %u\n", val);
+			return -EINVAL;
+		}
+		board->ale = val;
+	}
+
+	if (of_property_read_u32(np, "atmel,nand-cmd-offset", &val) == 0) {
+		if (val >= 32) {
+			dev_err(host->dev, "invalid cmd-offset %u\n", val);
+			return -EINVAL;
+		}
+		board->cle = val;
+	}
+
+	ecc_mode = of_get_nand_ecc_mode(np);
+
+	board->ecc_mode = ecc_mode < 0 ? NAND_ECC_SOFT : ecc_mode;
+
+	board->on_flash_bbt = of_get_nand_on_flash_bbt(np);
+
+	if (of_get_nand_bus_width(np) == 16)
+		board->bus_width_16 = 1;
+
+	board->rdy_pin = of_get_gpio_flags(np, 0, &flags);
+	board->rdy_pin_active_low = (flags == OF_GPIO_ACTIVE_LOW);
+
+	board->enable_pin = of_get_gpio(np, 1);
+	board->det_pin = of_get_gpio(np, 2);
+
+	return 0;
+}
+
 /*
  * Probe for the NAND device.
  */
@@ -479,6 +525,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	struct nand_chip *nand_chip;
 	struct resource *regs;
 	struct resource *mem;
+	struct mtd_part_parser_data ppdata = {};
 	int res;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -505,8 +552,15 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 
 	mtd = &host->mtd;
 	nand_chip = &host->nand_chip;
-	host->board = pdev->dev.platform_data;
 	host->dev = &pdev->dev;
+	if (pdev->dev.of_node) {
+		res = atmel_of_init_port(host, pdev->dev.of_node);
+		if (res)
+			goto err_nand_ioremap;
+	} else {
+		memcpy(&host->board, pdev->dev.platform_data,
+		       sizeof(struct atmel_nand_data));
+	}
 
 	nand_chip->priv = host;		/* link the private data structures */
 	mtd->priv = nand_chip;
@@ -517,10 +571,10 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	nand_chip->IO_ADDR_W = host->io_base;
 	nand_chip->cmd_ctrl = atmel_nand_cmd_ctrl;
 
-	if (gpio_is_valid(host->board->rdy_pin))
+	if (gpio_is_valid(host->board.rdy_pin))
 		nand_chip->dev_ready = atmel_nand_device_ready;
 
-	nand_chip->ecc.mode = host->board->ecc_mode;
+	nand_chip->ecc.mode = host->board.ecc_mode;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	if (!regs && nand_chip->ecc.mode == NAND_ECC_HW) {
@@ -545,7 +599,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 
 	nand_chip->chip_delay = 20;		/* 20us command delay time */
 
-	if (host->board->bus_width_16)	/* 16-bit bus width */
+	if (host->board.bus_width_16)	/* 16-bit bus width */
 		nand_chip->options |= NAND_BUSWIDTH_16;
 
 	nand_chip->read_buf = atmel_read_buf;
@@ -554,15 +608,15 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, host);
 	atmel_nand_enable(host);
 
-	if (gpio_is_valid(host->board->det_pin)) {
-		if (gpio_get_value(host->board->det_pin)) {
+	if (gpio_is_valid(host->board.det_pin)) {
+		if (gpio_get_value(host->board.det_pin)) {
 			printk(KERN_INFO "No SmartMedia card inserted.\n");
 			res = -ENXIO;
 			goto err_no_card;
 		}
 	}
 
-	if (host->board->on_flash_bbt || on_flash_bbt) {
+	if (host->board.on_flash_bbt || on_flash_bbt) {
 		printk(KERN_INFO "atmel_nand: Use On Flash BBT\n");
 		nand_chip->bbt_options |= NAND_BBT_USE_FLASH;
 	}
@@ -637,8 +691,9 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	}
 
 	mtd->name = "atmel_nand";
-	res = mtd_device_parse_register(mtd, NULL, 0,
-			host->board->parts, host->board->num_parts);
+	ppdata.of_node = pdev->dev.of_node;
+	res = mtd_device_parse_register(mtd, NULL, &ppdata,
+			host->board.parts, host->board.num_parts);
 	if (!res)
 		return res;
 
@@ -682,11 +737,21 @@ static int __exit atmel_nand_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id atmel_nand_dt_ids[] = {
+	{ .compatible = "atmel,at91rm9200-nand" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, atmel_nand_dt_ids);
+#endif
+
 static struct platform_driver atmel_nand_driver = {
 	.remove		= __exit_p(atmel_nand_remove),
 	.driver		= {
 		.name	= "atmel_nand",
 		.owner	= THIS_MODULE,
+		.of_match_table	= of_match_ptr(atmel_nand_dt_ids),
 	},
 };
 
-- 
1.7.7
