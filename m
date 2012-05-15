From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 15 May 2012 22:47:35 +0800
Subject: [PATCH v7 2/3] MTD: add dt parameters for PMECC
In-Reply-To: <1337093256-19117-1-git-send-email-josh.wu@atmel.com>
References: <1337093256-19117-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1337093256-19117-3-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hong Xu <hong.xu@atmel.com>
Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 .../devicetree/bindings/mtd/atmel-nand.txt         |    7 +++++++
 drivers/mtd/nand/atmel_nand.c                      |   20 ++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
index a200695..895d72b 100644
--- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
@@ -16,6 +16,12 @@ Optional properties:
 - nand-ecc-mode : String, operation mode of the NAND ecc mode, soft by default.
   Supported values are: "none", "soft", "hw", "hw_syndrome", "hw_oob_first",
   "soft_bch".
+- atmel,has-pmecc : boolean to enable Programmable Multibit ECC hardware.
+  Only supported by at91sam9x5 or later sam9 product.
+- atmel,pmecc-cap : error correct capability for Programmable Multibit ECC
+  Controller. Supported values are: 2, 4, 8, 12, 24.
+- atmel,sector-size : sector size for ECC computation. Supported values are:
+  512, 1024.
 - nand-bus-width : 8 or 16 bus width if not present 8
 - nand-on-flash-bbt: boolean to enable on flash bbt option if not present false
 
diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 52ca295..937b080 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -88,6 +88,10 @@ struct atmel_nand_host {
 
 	struct completion	comp;
 	struct dma_chan		*dma_chan;
+
+	bool			has_pmecc;
+	u8			correction_cap;
+	u16			sector_size;
 };
 
 static int cpu_has_dma(void)
@@ -508,6 +512,22 @@ static int __devinit atmel_of_init_port(struct atmel_nand_host *host,
 	board->enable_pin = of_get_gpio(np, 1);
 	board->det_pin = of_get_gpio(np, 2);
 
+	host->has_pmecc = of_property_read_bool(np, "atmel,has-pmecc");
+
+	if ((board->ecc_mode == NAND_ECC_HW) && host->has_pmecc) {
+		if (of_property_read_u32(np, "atmel,pmecc-cap", &val) != 0) {
+			dev_err(host->dev, "Cannot decide PMECC Capability\n");
+			return -EINVAL;
+		}
+		host->correction_cap = (u8)val;
+
+		if (of_property_read_u32(np, "atmel,sector-size", &val) != 0) {
+			dev_err(host->dev, "Cannot decide PMECC Sector Size\n");
+			return -EINVAL;
+		}
+		host->sector_size = (u16)val;
+	}
+
 	return 0;
 }
 #else
-- 
1.7.10
