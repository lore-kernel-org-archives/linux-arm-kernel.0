From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Fri, 31 Aug 2012 11:21:19 +0200
Subject: [PATCH 3/8] i2c: at91: use an id table for SoC dependent parameters
In-Reply-To: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
References: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1346404884-18451-4-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Use the id_table to store configuration structures which are depending on
SoC.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/mach-at91/at91rm9200.c          |  2 +-
 arch/arm/mach-at91/at91rm9200_devices.c  | 11 +----
 arch/arm/mach-at91/at91sam9260.c         |  3 +-
 arch/arm/mach-at91/at91sam9260_devices.c |  8 ++-
 arch/arm/mach-at91/at91sam9261.c         |  3 +-
 arch/arm/mach-at91/at91sam9261_devices.c | 17 +++----
 arch/arm/mach-at91/at91sam9263.c         |  2 +-
 arch/arm/mach-at91/at91sam9263_devices.c |  2 +-
 arch/arm/mach-at91/at91sam9g45.c         |  4 +-
 arch/arm/mach-at91/at91sam9g45_devices.c |  4 +-
 arch/arm/mach-at91/at91sam9rl.c          |  4 +-
 arch/arm/mach-at91/at91sam9rl_devices.c  |  2 +-
 drivers/i2c/busses/i2c-at91.c            | 85 +++++++++++++++++++++++++-------
 13 files changed, 95 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index f2112f9..0bc91e5 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -187,7 +187,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.2", &ssc2_clk),
-	CLKDEV_CON_DEV_ID(NULL, "at91_i2c", &twi_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91rm9200_i2c", &twi_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 71e7387..cddfe02 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -494,18 +494,9 @@ static struct resource twi_resources[] = {
 	},
 };
 
-static const struct platform_device_id twi_ip_type = {
-	/*
-	 * driver_data is 1 for RM9200 compatible ip, see enum twi_ip_id in
-	 * drivers/i2c/busses/i2c-at91.c
-	 */
-	.driver_data	= 1,
-};
-
 static struct platform_device at91rm9200_twi_device = {
-	.name		= "at91_i2c",
+	.name		= "at91rm9200_i2c",
 	.id		= -1,
-	.id_entry	= &twi_ip_type,
 	.resource	= twi_resources,
 	.num_resources	= ARRAY_SIZE(twi_resources),
 };
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 57c79ee..5f86e71 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -211,7 +211,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t1_clk", "atmel_tcb.1", &tc4_clk),
 	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.1", &tc5_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc_clk),
-	CLKDEV_CON_DEV_ID(NULL, "at91_i2c", &twi_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91sam9260_i2c", &twi_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91sam9g20_i2c", &twi_clk),
 	/* more usart lookup table for DT entries */
 	CLKDEV_CON_DEV_ID("usart", "fffff200.serial", &mck),
 	CLKDEV_CON_DEV_ID("usart", "fffb0000.serial", &usart0_clk),
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 7b9c2ba..ed02171 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -503,7 +503,6 @@ static struct resource twi_resources[] = {
 };
 
 static struct platform_device at91sam9260_twi_device = {
-	.name		= "at91_i2c",
 	.id		= -1,
 	.resource	= twi_resources,
 	.num_resources	= ARRAY_SIZE(twi_resources),
@@ -511,6 +510,13 @@ static struct platform_device at91sam9260_twi_device = {
 
 void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices)
 {
+	/* IP version is not the same on 9260 and g20 */
+	if (cpu_is_at91sam9g20()) {
+		at91sam9260_twi_device.name = "at91sam9g20_i2c";
+	} else {
+		at91sam9260_twi_device.name = "at91sam9260_i2c";
+	}
+
 	/* pins used for TWI interface */
 	at91_set_A_periph(AT91_PIN_PA23, 0);		/* TWD */
 	at91_set_multi_drive(AT91_PIN_PA23, 1);
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 71ca1e0..0ccf63c 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -178,7 +178,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.2", &ssc2_clk),
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &hck0),
-	CLKDEV_CON_DEV_ID(NULL, "at91_i2c", &twi_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91sam9261_i2c", &twi_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91sam9g10_i2c", &twi_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
 	CLKDEV_CON_ID("pioB", &pioB_clk),
 	CLKDEV_CON_ID("pioC", &pioC_clk),
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index d830724..c94495d 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -316,24 +316,21 @@ static struct resource twi_resources[] = {
 	},
 };
 
-static const struct platform_device_id twi_ip_type = {
-	/*
-	 * driver_data is 2 for SAM9261 compatible ip, see enum twi_ip_id in
-	 * drivers/i2c/busses/i2c-at91.c
-	 */
-	.driver_data	= 2,
-};
-
 static struct platform_device at91sam9261_twi_device = {
-	.name		= "at91_i2c",
 	.id		= -1,
-	.id_entry	= &twi_ip_type,
 	.resource	= twi_resources,
 	.num_resources	= ARRAY_SIZE(twi_resources),
 };
 
 void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices)
 {
+	/* IP version is not the same on 9261 and g10 */
+	if (cpu_is_at91sam9g10()) {
+		at91sam9261_twi_device.name = "at91sam9g10_i2c";
+	} else {
+		at91sam9261_twi_device.name = "at91sam9261_i2c";
+	}
+
 	/* pins used for TWI interface */
 	at91_set_A_periph(AT91_PIN_PA7, 0);		/* TWD */
 	at91_set_multi_drive(AT91_PIN_PA7, 1);
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 2a08305..a4d760c 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -193,7 +193,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.0", &spi0_clk),
 	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.1", &spi1_clk),
 	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tcb_clk),
-	CLKDEV_CON_DEV_ID(NULL, "at91_i2c", &twi_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91sam9260_i2c", &twi_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index eb6bbf8..7cff86c 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -574,7 +574,7 @@ static struct resource twi_resources[] = {
 };
 
 static struct platform_device at91sam9263_twi_device = {
-	.name		= "at91_i2c",
+	.name		= "at91sam9260_i2c",
 	.id		= -1,
 	.resource	= twi_resources,
 	.num_resources	= ARRAY_SIZE(twi_resources),
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index ddf3d37..15e62b9 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -237,8 +237,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.1", &spi1_clk),
 	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tcb0_clk),
 	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.1", &tcb0_clk),
-	CLKDEV_CON_DEV_ID(NULL, "at91_i2c.0", &twi0_clk),
-	CLKDEV_CON_DEV_ID(NULL, "at91_i2c.1", &twi1_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91sam9g10_i2c.0", &twi0_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91sam9g10_i2c.1", &twi1_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
 	CLKDEV_CON_DEV_ID(NULL, "atmel-trng", &trng_clk),
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index f001305..a61c7ec 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -653,7 +653,7 @@ static struct resource twi0_resources[] = {
 };
 
 static struct platform_device at91sam9g45_twi0_device = {
-	.name		= "at91_i2c",
+	.name		= "at91sam9g10_i2c",
 	.id		= 0,
 	.resource	= twi0_resources,
 	.num_resources	= ARRAY_SIZE(twi0_resources),
@@ -673,7 +673,7 @@ static struct resource twi1_resources[] = {
 };
 
 static struct platform_device at91sam9g45_twi1_device = {
-	.name		= "at91_i2c",
+	.name		= "at91sam9g10_i2c",
 	.id		= 1,
 	.resource	= twi1_resources,
 	.num_resources	= ARRAY_SIZE(twi1_resources),
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index bf79c1f..d708dfa 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -186,8 +186,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.0", &tc2_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
-	CLKDEV_CON_DEV_ID(NULL, "at91_i2c.0", &twi0_clk),
-	CLKDEV_CON_DEV_ID(NULL, "at91_i2c.1", &twi1_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91sam9g20_i2c.0", &twi0_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91sam9g20_i2c.1", &twi1_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
 	CLKDEV_CON_ID("pioB", &pioB_clk),
 	CLKDEV_CON_ID("pioC", &pioC_clk),
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index f09fff9..2df7411 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -346,7 +346,7 @@ static struct resource twi_resources[] = {
 };
 
 static struct platform_device at91sam9rl_twi_device = {
-	.name		= "at91_i2c",
+	.name		= "at91sam9g20_i2c",
 	.id		= -1,
 	.resource	= twi_resources,
 	.num_resources	= ARRAY_SIZE(twi_resources),
diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 08aaee7..bcf9a5c 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -61,10 +61,10 @@
 #define	AT91_TWI_RHR		0x0030	/* Receive Holding Register */
 #define	AT91_TWI_THR		0x0034	/* Transmit Holding Register */
 
-enum twi_ip_id {
-	DEFAULT		= 0, /* default ip, no known limitations */
-	RM9200		= 1,
-	SAM9261		= 2,
+struct at91_twi_pdata {
+	unsigned	clk_max_div;
+	unsigned	clk_offset;
+	bool		has_unre_flag;
 };
 
 struct at91_twi_dev {
@@ -78,8 +78,8 @@ struct at91_twi_dev {
 	int			irq;
 	unsigned		transfer_status;
 	struct i2c_adapter	adapter;
-	enum twi_ip_id		ip_id;
 	unsigned		twi_cwgr_reg;
+	struct at91_twi_pdata	*pdata;
 };
 
 static unsigned at91_twi_read(struct at91_twi_dev *dev, unsigned reg)
@@ -114,16 +114,9 @@ static void at91_init_twi_bus(struct at91_twi_dev *dev)
 static void __devinit at91_calc_twi_clock(struct at91_twi_dev *dev, int twi_clk)
 {
 	int ckdiv, cdiv, div;
-	int offset = 4;
-	int max_ckdiv = 7;
-
-	if (dev->ip_id == RM9200) {
-		offset = 3;
-		max_ckdiv = 5;
-	} else if (dev->ip_id == SAM9261) {
-		offset = 4;
-		max_ckdiv = 5;
-	}
+	struct at91_twi_pdata *pdata = dev->pdata;
+	int offset = pdata->clk_offset;
+	int max_ckdiv = pdata->clk_max_div;
 
 	div = max(0, (int)DIV_ROUND_UP(clk_get_rate(dev->clk),
 				       2 * twi_clk) - offset);
@@ -209,6 +202,7 @@ static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
 static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 {
 	int ret;
+	bool has_unre_flag = dev->pdata->has_unre_flag;
 
 	dev_dbg(dev->dev, "transfer: %s %d bytes.\n",
 		(dev->msg->flags & I2C_M_RD) ? "read" : "write", dev->buf_len);
@@ -250,7 +244,7 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 		dev_err(dev->dev, "overrun while reading\n");
 		return -EIO;
 	}
-	if (dev->transfer_status & AT91_TWI_UNRE && dev->ip_id == RM9200) {
+	if (has_unre_flag && dev->transfer_status & AT91_TWI_UNRE) {
 		dev_err(dev->dev, "underrun while writing\n");
 		return -EIO;
 	}
@@ -323,6 +317,57 @@ static struct i2c_algorithm at91_twi_algorithm = {
 	.functionality	= at91_twi_func,
 };
 
+static struct at91_twi_pdata at91rm9200_config = {
+	.clk_max_div = 5,
+	.clk_offset = 3,
+	.has_unre_flag = true,
+};
+
+static struct at91_twi_pdata at91sam9261_config = {
+	.clk_max_div = 5,
+	.clk_offset = 4,
+	.has_unre_flag = false,
+};
+
+static struct at91_twi_pdata at91sam9260_config = {
+	.clk_max_div = 7,
+	.clk_offset = 4,
+	.has_unre_flag = false,
+};
+
+static struct at91_twi_pdata at91sam9g20_config = {
+	.clk_max_div = 7,
+	.clk_offset = 4,
+	.has_unre_flag = false,
+};
+
+static struct at91_twi_pdata at91sam9g10_config = {
+	.clk_max_div = 7,
+	.clk_offset = 4,
+	.has_unre_flag = false,
+};
+
+static const struct platform_device_id at91_twi_devtypes[] = {
+	{
+		.name = "at91rm9200_i2c",
+		.driver_data = (unsigned long) &at91rm9200_config,
+	}, {
+		.name = "at91sam9261_i2c",
+		.driver_data = (unsigned long) &at91sam9261_config,
+	}, {
+		.name = "at91sam9260_i2c",
+		.driver_data = (unsigned long) &at91sam9260_config,
+	}, {
+		.name = "at91sam9g20_i2c",
+		.driver_data = (unsigned long) &at91sam9g20_config,
+	}, {
+		.name = "at91sam9g10_i2c",
+		.driver_data = (unsigned long) &at91sam9g10_config,
+	}, {
+		/* sentinel */
+	}
+};
+
 static int __devinit at91_twi_probe(struct platform_device *pdev)
 {
 	struct at91_twi_dev *dev;
@@ -339,6 +384,10 @@ static int __devinit at91_twi_probe(struct platform_device *pdev)
 	if (!mem)
 		return -ENODEV;
 
+	dev->pdata = at91_twi_get_driver_data(pdev);
+	if (!dev->pdata)
+		return -ENODEV;
+
 	dev->base = devm_request_and_ioremap(&pdev->dev, mem);
 	if (!dev->base)
 		return -EBUSY;
@@ -354,9 +403,6 @@ static int __devinit at91_twi_probe(struct platform_device *pdev)
 		return rc;
 	}
 
-	if (pdev->id_entry)
-		dev->ip_id = pdev->id_entry->driver_data;
-
 	platform_set_drvdata(pdev, dev);
 
 	dev->clk = devm_clk_get(dev->dev, NULL);
@@ -432,6 +478,7 @@ static const struct dev_pm_ops at91_twi_pm = {
 static struct platform_driver at91_twi_driver = {
 	.probe		= at91_twi_probe,
 	.remove		= __devexit_p(at91_twi_remove),
+	.id_table	= at91_twi_devtypes,
 	.driver		= {
 		.name	= "at91_i2c",
 		.owner	= THIS_MODULE,
-- 
1.7.11.3
