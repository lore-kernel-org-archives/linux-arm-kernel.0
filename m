From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat,  7 Jan 2012 11:49:28 +0100
Subject: [PATCH 1/3] ATMEL: fix nand ecc support
Message-ID: <1325933370-17475-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

so we can now choose for the board the ecc mode (ecc soft, soft bch, no ecc
and hardware)

set ecc mode in the boards to soft as currently in the driver

move platform data to a common header
include/linux/atmel_nand.h

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: linux-mtd at lists.infradead.org
---
Hi David,

	If you don't
	I'll apply this via ARM tree

Best Regards,
J.
 arch/arm/mach-at91/board-afeb-9260v1.c      |    1 +
 arch/arm/mach-at91/board-cam60.c            |    1 +
 arch/arm/mach-at91/board-cap9adk.c          |    1 +
 arch/arm/mach-at91/board-cpu9krea.c         |    1 +
 arch/arm/mach-at91/board-dt.c               |    1 +
 arch/arm/mach-at91/board-kb9202.c           |    1 +
 arch/arm/mach-at91/board-neocore926.c       |    1 +
 arch/arm/mach-at91/board-qil-a9260.c        |    1 +
 arch/arm/mach-at91/board-rm9200dk.c         |    1 +
 arch/arm/mach-at91/board-sam9-l9260.c       |    1 +
 arch/arm/mach-at91/board-sam9260ek.c        |    1 +
 arch/arm/mach-at91/board-sam9261ek.c        |    1 +
 arch/arm/mach-at91/board-sam9263ek.c        |    1 +
 arch/arm/mach-at91/board-sam9g20ek.c        |    1 +
 arch/arm/mach-at91/board-sam9m10g45ek.c     |    1 +
 arch/arm/mach-at91/board-sam9rlek.c         |    1 +
 arch/arm/mach-at91/board-snapper9260.c      |    1 +
 arch/arm/mach-at91/board-stamp9g20.c        |    1 +
 arch/arm/mach-at91/board-usb-a926x.c        |    1 +
 arch/arm/mach-at91/board-yl-9200.c          |    1 +
 arch/arm/mach-at91/include/mach/board.h     |   13 +------------
 arch/avr32/boards/atngw100/setup.c          |    1 +
 arch/avr32/boards/atstk1000/atstk1002.c     |    1 +
 arch/avr32/mach-at32ap/include/mach/board.h |   13 +------------
 drivers/mtd/nand/atmel_nand.c               |   25 ++++++-------------------
 include/linux/atmel_nand.h                  |   26 ++++++++++++++++++++++++++
 26 files changed, 56 insertions(+), 43 deletions(-)
 create mode 100644 include/linux/atmel_nand.h

diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index 3bb4069..161efba 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -138,6 +138,7 @@ static struct atmel_nand_data __initdata afeb9260_nand_data = {
 	.rdy_pin	= AT91_PIN_PC13,
 	.enable_pin	= AT91_PIN_PC14,
 	.bus_width_16	= 0,
+	.ecc_mode	= NAND_ECC_SOFT,
 	.parts		= afeb9260_nand_partition,
 	.num_parts	= ARRAY_SIZE(afeb9260_nand_partition),
 	.det_pin	= -EINVAL,
diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index 8510e9e..c6d44ee 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -140,6 +140,7 @@ static struct atmel_nand_data __initdata cam60_nand_data = {
 	.det_pin	= -EINVAL,
 	.rdy_pin	= AT91_PIN_PA9,
 	.enable_pin	= AT91_PIN_PA7,
+	.ecc_mode	= NAND_ECC_SOFT,
 	.parts		= cam60_nand_partition,
 	.num_parts	= ARRAY_SIZE(cam60_nand_partition),
 };
diff --git a/arch/arm/mach-at91/board-cap9adk.c b/arch/arm/mach-at91/board-cap9adk.c
index ac3de4f..602ea25 100644
--- a/arch/arm/mach-at91/board-cap9adk.c
+++ b/arch/arm/mach-at91/board-cap9adk.c
@@ -178,6 +178,7 @@ static struct atmel_nand_data __initdata cap9adk_nand_data = {
 	.det_pin	= -EINVAL,
 	.rdy_pin	= -EINVAL,
 	.enable_pin	= AT91_PIN_PD15,
+	.ecc_mode	= NAND_ECC_SOFT,
 	.parts		= cap9adk_nand_partitions,
 	.num_parts	= ARRAY_SIZE(cap9adk_nand_partitions),
 };
diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index 9ab3d1e..6119dd6 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -116,6 +116,7 @@ static struct atmel_nand_data __initdata cpu9krea_nand_data = {
 	.enable_pin	= AT91_PIN_PC14,
 	.bus_width_16	= 0,
 	.det_pin	= -EINVAL,
+	.ecc_mode	= NAND_ECC_SOFT,
 };
 
 #ifdef CONFIG_MACH_CPU9260
diff --git a/arch/arm/mach-at91/board-dt.c b/arch/arm/mach-at91/board-dt.c
index bb6b434..552390d 100644
--- a/arch/arm/mach-at91/board-dt.c
+++ b/arch/arm/mach-at91/board-dt.c
@@ -53,6 +53,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.det_pin	= -EINVAL,
 	.rdy_pin	= AT91_PIN_PC8,
 	.enable_pin	= AT91_PIN_PC14,
+	.ecc_mode	= NAND_ECC_SOFT,
 };
 
 static struct sam9_smc_config __initdata ek_nand_smc_config = {
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index d75a4a2..726670e 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -107,6 +107,7 @@ static struct atmel_nand_data __initdata kb9202_nand_data = {
 	.det_pin	= -EINVAL,
 	.rdy_pin	= AT91_PIN_PC29,
 	.enable_pin	= AT91_PIN_PC28,
+	.ecc_mode	= NAND_ECC_SOFT,
 	.parts		= kb9202_nand_partition,
 	.num_parts	= ARRAY_SIZE(kb9202_nand_partition),
 };
diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index 3f8617c..57d5f6a 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -190,6 +190,7 @@ static struct atmel_nand_data __initdata neocore926_nand_data = {
 	.rdy_pin		= AT91_PIN_PB19,
 	.rdy_pin_active_low	= 1,
 	.enable_pin		= AT91_PIN_PD15,
+	.ecc_mode		= NAND_ECC_SOFT,
 	.parts			= neocore926_nand_partition,
 	.num_parts		= ARRAY_SIZE(neocore926_nand_partition),
 	.det_pin		= -EINVAL,
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index e029d22..97907e4 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -138,6 +138,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.det_pin	= -EINVAL,
 	.rdy_pin	= AT91_PIN_PC13,
 	.enable_pin	= AT91_PIN_PC14,
+	.ecc_mode	= NAND_ECC_SOFT,
 	.parts		= ek_nand_partition,
 	.num_parts	= ARRAY_SIZE(ek_nand_partition),
 };
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index 782f379..851013c 100644
--- a/arch/arm/mach-at91/board-rm9200dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -149,6 +149,7 @@ static struct atmel_nand_data __initdata dk_nand_data = {
 	.det_pin	= AT91_PIN_PB1,
 	.rdy_pin	= AT91_PIN_PC2,
 	.enable_pin	= -EINVAL,
+	.ecc_mode	= NAND_ECC_SOFT,
 	.parts		= dk_nand_partition,
 	.num_parts	= ARRAY_SIZE(dk_nand_partition),
 };
diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
index 84bce58..e8b116b 100644
--- a/arch/arm/mach-at91/board-sam9-l9260.c
+++ b/arch/arm/mach-at91/board-sam9-l9260.c
@@ -139,6 +139,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.det_pin	= -EINVAL,
 	.rdy_pin	= AT91_PIN_PC13,
 	.enable_pin	= AT91_PIN_PC14,
+	.ecc_mode	= NAND_ECC_SOFT,
 	.parts		= ek_nand_partition,
 	.num_parts	= ARRAY_SIZE(ek_nand_partition),
 };
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index be8233b..3118ab1 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -181,6 +181,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.det_pin	= -EINVAL,
 	.rdy_pin	= AT91_PIN_PC13,
 	.enable_pin	= AT91_PIN_PC14,
+	.ecc_mode	= NAND_ECC_SOFT,
 	.parts		= ek_nand_partition,
 	.num_parts	= ARRAY_SIZE(ek_nand_partition),
 };
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index 4089507..60cf37b 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -187,6 +187,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.det_pin	= -EINVAL,
 	.rdy_pin	= AT91_PIN_PC15,
 	.enable_pin	= AT91_PIN_PC14,
+	.ecc_mode	= NAND_ECC_SOFT,
 	.parts		= ek_nand_partition,
 	.num_parts	= ARRAY_SIZE(ek_nand_partition),
 };
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index 29f6605..aeabf85 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -187,6 +187,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.det_pin	= -EINVAL,
 	.rdy_pin	= AT91_PIN_PA22,
 	.enable_pin	= AT91_PIN_PD15,
+	.ecc_mode	= NAND_ECC_SOFT,
 	.parts		= ek_nand_partition,
 	.num_parts	= ARRAY_SIZE(ek_nand_partition),
 };
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 843d628..419e0d5 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -166,6 +166,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.rdy_pin	= AT91_PIN_PC13,
 	.enable_pin	= AT91_PIN_PC14,
 	.det_pin	= -EINVAL,
+	.ecc_mode	= NAND_ECC_SOFT,
 	.parts		= ek_nand_partition,
 	.num_parts	= ARRAY_SIZE(ek_nand_partition),
 };
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index ea0d1b9..452ec37 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -146,6 +146,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.rdy_pin	= AT91_PIN_PC8,
 	.enable_pin	= AT91_PIN_PC14,
 	.det_pin	= -EINVAL,
+	.ecc_mode	= NAND_ECC_SOFT,
 	.parts		= ek_nand_partition,
 	.num_parts	= ARRAY_SIZE(ek_nand_partition),
 };
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index c1366d0..70a026d 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -94,6 +94,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.det_pin	= -EINVAL,
 	.rdy_pin	= AT91_PIN_PD17,
 	.enable_pin	= AT91_PIN_PB6,
+	.ecc_mode	= NAND_ECC_SOFT,
 	.parts		= ek_nand_partition,
 	.num_parts	= ARRAY_SIZE(ek_nand_partition),
 };
diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
index 4770db0..8898c1a 100644
--- a/arch/arm/mach-at91/board-snapper9260.c
+++ b/arch/arm/mach-at91/board-snapper9260.c
@@ -110,6 +110,7 @@ static struct atmel_nand_data __initdata snapper9260_nand_data = {
 	.bus_width_16	= 0,
 	.enable_pin	= -EINVAL,
 	.det_pin	= -EINVAL,
+	.ecc_mode	= NAND_ECC_SOFT,
 };
 
 static struct sam9_smc_config __initdata snapper9260_nand_smc_config = {
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index e8d3d5b..c0924d7 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -86,6 +86,7 @@ static struct atmel_nand_data __initdata nand_data = {
 	.enable_pin	= AT91_PIN_PC14,
 	.bus_width_16	= 0,
 	.det_pin	= -EINVAL,
+	.ecc_mode	= NAND_ECC_SOFT,
 };
 
 static struct sam9_smc_config __initdata nand_smc_config = {
diff --git a/arch/arm/mach-at91/board-usb-a926x.c b/arch/arm/mach-at91/board-usb-a926x.c
index 26c36fc..cc93152 100644
--- a/arch/arm/mach-at91/board-usb-a926x.c
+++ b/arch/arm/mach-at91/board-usb-a926x.c
@@ -198,6 +198,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.det_pin	= -EINVAL,
 	.rdy_pin	= AT91_PIN_PA22,
 	.enable_pin	= AT91_PIN_PD15,
+	.ecc_mode	= NAND_ECC_SOFT,
 	.parts		= ek_nand_partition,
 	.num_parts	= ARRAY_SIZE(ek_nand_partition),
 };
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index bbd553e..06cbae1 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -181,6 +181,7 @@ static struct atmel_nand_data __initdata yl9200_nand_data = {
 	.det_pin	= -EINVAL,
 	.rdy_pin	= AT91_PIN_PC14,	/* R/!B (Sheet10) */
 	.enable_pin	= AT91_PIN_PC15,	/* !CE  (Sheet10) */
+	.ecc_mode	= NAND_ECC_SOFT,
 	.parts		= yl9200_nand_partition,
 	.num_parts	= ARRAY_SIZE(yl9200_nand_partition),
 };
diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index d0b377b..f3f33bc 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -39,6 +39,7 @@
 #include <linux/usb/atmel_usba_udc.h>
 #include <linux/atmel-mci.h>
 #include <sound/atmel-ac97c.h>
+#include <linux/atmel_nand.h>
 #include <linux/serial.h>
 #include <linux/platform_data/macb.h>
 
@@ -98,18 +99,6 @@ extern void __init at91_add_device_usbh(struct at91_usbh_data *data);
 extern void __init at91_add_device_usbh_ohci(struct at91_usbh_data *data);
 extern void __init at91_add_device_usbh_ehci(struct at91_usbh_data *data);
 
- /* NAND / SmartMedia */
-struct atmel_nand_data {
-	int		enable_pin;	/* chip enable */
-	int		det_pin;	/* card detect */
-	int		rdy_pin;	/* ready/busy */
-	u8              rdy_pin_active_low;     /* rdy_pin value is inverted */
-	u8		ale;		/* address line number connected to ALE */
-	u8		cle;		/* address line number connected to CLE */
-	u8		bus_width_16;	/* buswidth is 16 bit */
-	struct mtd_partition *parts;
-	unsigned int	num_parts;
-};
 extern void __init at91_add_device_nand(struct atmel_nand_data *data);
 
  /* I2C*/
diff --git a/arch/avr32/boards/atngw100/setup.c b/arch/avr32/boards/atngw100/setup.c
index 7c756fb..afeae89 100644
--- a/arch/avr32/boards/atngw100/setup.c
+++ b/arch/avr32/boards/atngw100/setup.c
@@ -97,6 +97,7 @@ static struct atmel_nand_data atngw100mkii_nand_data __initdata = {
 	.rdy_pin	= GPIO_PIN_PB(28),
 	.enable_pin	= GPIO_PIN_PE(23),
 	.bus_width_16	= true,
+	.ecc_mode	= NAND_ECC_SOFT,
 	.parts		= nand_partitions,
 	.num_parts	= ARRAY_SIZE(nand_partitions),
 };
diff --git a/arch/avr32/boards/atstk1000/atstk1002.c b/arch/avr32/boards/atstk1000/atstk1002.c
index c56ddac..dc52633 100644
--- a/arch/avr32/boards/atstk1000/atstk1002.c
+++ b/arch/avr32/boards/atstk1000/atstk1002.c
@@ -95,6 +95,7 @@ static struct atmel_nand_data atstk1006_nand_data __initdata = {
 	.ale		= 22,
 	.rdy_pin	= GPIO_PIN_PB(30),
 	.enable_pin	= GPIO_PIN_PB(29),
+	.ecc_mode	= NAND_ECC_SOFT,
 	.parts		= nand_partitions,
 	.num_parts	= ARRAY_SIZE(num_partitions),
 };
diff --git a/arch/avr32/mach-at32ap/include/mach/board.h b/arch/avr32/mach-at32ap/include/mach/board.h
index 67b111c..e4cd3f8 100644
--- a/arch/avr32/mach-at32ap/include/mach/board.h
+++ b/arch/avr32/mach-at32ap/include/mach/board.h
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 #include <linux/serial.h>
 #include <linux/platform_data/macb.h>
+#include <linux/atmel_nand.h>
 
 #define GPIO_PIN_NONE	(-1)
 
@@ -116,18 +117,6 @@ struct platform_device *
 at32_add_device_cf(unsigned int id, unsigned int extint,
 		struct cf_platform_data *data);
 
-/* NAND / SmartMedia */
-struct atmel_nand_data {
-	int	enable_pin;	/* chip enable */
-	int	det_pin;	/* card detect */
-	int	rdy_pin;	/* ready/busy */
-	u8	rdy_pin_active_low;	/* rdy_pin value is inverted */
-	u8	ale;		/* address line number connected to ALE */
-	u8	cle;		/* address line number connected to CLE */
-	u8	bus_width_16;	/* buswidth is 16 bit */
-	struct mtd_partition *parts;
-	unsigned int	num_parts;
-};
 struct platform_device *
 at32_add_device_nand(unsigned int id, struct atmel_nand_data *data);
 
diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 4dd056e..c267113 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -34,22 +34,10 @@
 #include <linux/dmaengine.h>
 #include <linux/gpio.h>
 #include <linux/io.h>
+#include <linux/atmel_nand.h>
 
-#include <mach/board.h>
 #include <mach/cpu.h>
 
-#ifdef CONFIG_MTD_NAND_ATMEL_ECC_HW
-#define hard_ecc	1
-#else
-#define hard_ecc	0
-#endif
-
-#ifdef CONFIG_MTD_NAND_ATMEL_ECC_NONE
-#define no_ecc		1
-#else
-#define no_ecc		0
-#endif
-
 static int use_dma = 1;
 module_param(use_dma, int, 0);
 
@@ -495,23 +483,22 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	if (gpio_is_valid(host->board->rdy_pin))
 		nand_chip->dev_ready = atmel_nand_device_ready;
 
+	nand_chip->ecc.mode = host->board->ecc_mode;
+
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!regs && hard_ecc) {
+	if (!regs && nand_chip->ecc.mode == NAND_ECC_HW) {
 		printk(KERN_ERR "atmel_nand: can't get I/O resource "
 				"regs\nFalling back on software ECC\n");
+		nand_chip->ecc.mode = NAND_ECC_SOFT;
 	}
 
-	nand_chip->ecc.mode = NAND_ECC_SOFT;	/* enable ECC */
-	if (no_ecc)
-		nand_chip->ecc.mode = NAND_ECC_NONE;
-	if (hard_ecc && regs) {
+	if (nand_chip->ecc.mode == NAND_ECC_HW) {
 		host->ecc = ioremap(regs->start, resource_size(regs));
 		if (host->ecc == NULL) {
 			printk(KERN_ERR "atmel_nand: ioremap failed\n");
 			res = -EIO;
 			goto err_ecc_ioremap;
 		}
-		nand_chip->ecc.mode = NAND_ECC_HW;
 		nand_chip->ecc.calculate = atmel_nand_calculate;
 		nand_chip->ecc.correct = atmel_nand_correct;
 		nand_chip->ecc.hwctl = atmel_nand_hwctl;
diff --git a/include/linux/atmel_nand.h b/include/linux/atmel_nand.h
new file mode 100644
index 0000000..f6d4193
--- /dev/null
+++ b/include/linux/atmel_nand.h
@@ -0,0 +1,26 @@
+/*
+ * atmel_nand platform data
+ *
+ * GPL v2 Only
+ */
+
+#ifndef __ATMEL_NAND_H__
+#define __ATMEL_NAND_H__
+
+#include <linux/mtd/nand.h>
+
+ /* NAND / SmartMedia */
+struct atmel_nand_data {
+	int		enable_pin;		/* chip enable */
+	int		det_pin;		/* card detect */
+	int		rdy_pin;		/* ready/busy */
+	u8		rdy_pin_active_low;	/* rdy_pin value is inverted */
+	u8		ale;			/* address line number connected to ALE */
+	u8		cle;			/* address line number connected to CLE */
+	u8		bus_width_16;		/* buswidth is 16 bit */
+	u8		ecc_mode;		/* ecc mode */
+	struct mtd_partition *parts;
+	unsigned int	num_parts;
+};
+
+#endif /* __ATMEL_NAND_H__ */
-- 
1.7.7
