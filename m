From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:50:55 +0200
Subject: [PATCH 19/40] spi/imx: convert driver to use platform ids
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-19-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This has the advantage not to need to much cpu_is_... macros.  Still more
when imx51 support is added which has two different spi interfaces which
would introduce additional checks on the device id.

With this setup it's not possible for the compiler anymore to detect the
unused functions, so four additional kconfig symbols are introduced to
ifdef out the unneeded functions in the callback array and all these
functions are marked with __maybe_unused to suppress the corresponding
gcc warnings.

Comparing the driver footprint with and without the patch for a mx27
kernel yields:

add/remove: 2/0 grow/shrink: 2/0 up/down: 280/0 (280)
function                                     old     new   delta
spi_imx_devtype                                -     192    +192
spi_imx_probe                                980    1032     +52
spi_imx_devtype_data                           -      32     +32
spi_imx_setupxfer                            276     280      +4

Later when the platform code is updated to use the platform ids, the
autodetection can be removed which will make the driver a bit smaller
again.  (~60 Bytes in my test.)

Acked-by: Jason Wang <jason77.wang@gmail.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/Kconfig   |   12 ++++
 drivers/spi/spi_imx.c |  173 +++++++++++++++++++++++++++++++++++++------------
 2 files changed, 143 insertions(+), 42 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 30aea6d..4e9d77b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -143,6 +143,18 @@ config SPI_GPIO
 	  GPIO operations, you should be able to leverage that for better
 	  speed with a custom version of this driver; see the source code.
 
+config SPI_IMX_VER_IMX1
+	def_bool y if SOC_IMX1
+
+config SPI_IMX_VER_0_0
+	def_bool y if SOC_IMX21 || SOC_IMX27
+
+config SPI_IMX_VER_0_4
+	def_bool y if ARCH_MX31
+
+config SPI_IMX_VER_0_7
+	def_bool y if ARCH_MX25 || ARCH_MX35
+
 config SPI_IMX
 	tristate "Freescale i.MX SPI controllers"
 	depends on ARCH_MXC
diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index 7972e90..20cdee3 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -59,6 +59,24 @@ struct spi_imx_config {
 	int cs;
 };
 
+enum spi_imx_devtype {
+	SPI_IMX_VER_IMX1,
+	SPI_IMX_VER_0_0,
+	SPI_IMX_VER_0_4,
+	SPI_IMX_VER_0_5,
+	SPI_IMX_VER_0_7,
+	SPI_IMX_VER_AUTODETECT,
+};
+
+struct spi_imx_data;
+
+struct spi_imx_devtype_data {
+	void (*intctrl)(struct spi_imx_data *, int);
+	int (*config)(struct spi_imx_data *, struct spi_imx_config *);
+	void (*trigger)(struct spi_imx_data *);
+	int (*rx_available)(struct spi_imx_data *);
+};
+
 struct spi_imx_data {
 	struct spi_bitbang bitbang;
 
@@ -76,11 +94,7 @@ struct spi_imx_data {
 	const void *tx_buf;
 	unsigned int txfifo; /* number of words pushed in tx FIFO */
 
-	/* SoC specific functions */
-	void (*intctrl)(struct spi_imx_data *, int);
-	int (*config)(struct spi_imx_data *, struct spi_imx_config *);
-	void (*trigger)(struct spi_imx_data *);
-	int (*rx_available)(struct spi_imx_data *);
+	struct spi_imx_devtype_data devtype_data;
 };
 
 #define MXC_SPI_BUF_RX(type)						\
@@ -178,7 +192,7 @@ static unsigned int spi_imx_clkdiv_2(unsigned int fin,
  * the i.MX35 has a slightly different register layout for bits
  * we do not use here.
  */
-static void mx31_intctrl(struct spi_imx_data *spi_imx, int enable)
+static void __maybe_unused mx31_intctrl(struct spi_imx_data *spi_imx, int enable)
 {
 	unsigned int val = 0;
 
@@ -190,7 +204,7 @@ static void mx31_intctrl(struct spi_imx_data *spi_imx, int enable)
 	writel(val, spi_imx->base + MXC_CSPIINT);
 }
 
-static void mx31_trigger(struct spi_imx_data *spi_imx)
+static void __maybe_unused mx31_trigger(struct spi_imx_data *spi_imx)
 {
 	unsigned int reg;
 
@@ -199,7 +213,7 @@ static void mx31_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
-static int mx31_config(struct spi_imx_data *spi_imx,
+static int __maybe_unused mx31_config(struct spi_imx_data *spi_imx,
 		struct spi_imx_config *config)
 {
 	unsigned int reg = MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_MASTER;
@@ -232,7 +246,7 @@ static int mx31_config(struct spi_imx_data *spi_imx,
 	return 0;
 }
 
-static int mx31_rx_available(struct spi_imx_data *spi_imx)
+static int __maybe_unused mx31_rx_available(struct spi_imx_data *spi_imx)
 {
 	return readl(spi_imx->base + MX31_CSPISTATUS) & MX31_STATUS_RR;
 }
@@ -250,7 +264,7 @@ static int mx31_rx_available(struct spi_imx_data *spi_imx)
 #define MX27_CSPICTRL_DR_SHIFT	14
 #define MX27_CSPICTRL_CS_SHIFT	19
 
-static void mx27_intctrl(struct spi_imx_data *spi_imx, int enable)
+static void __maybe_unused mx27_intctrl(struct spi_imx_data *spi_imx, int enable)
 {
 	unsigned int val = 0;
 
@@ -262,7 +276,7 @@ static void mx27_intctrl(struct spi_imx_data *spi_imx, int enable)
 	writel(val, spi_imx->base + MXC_CSPIINT);
 }
 
-static void mx27_trigger(struct spi_imx_data *spi_imx)
+static void __maybe_unused mx27_trigger(struct spi_imx_data *spi_imx)
 {
 	unsigned int reg;
 
@@ -271,7 +285,7 @@ static void mx27_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
-static int mx27_config(struct spi_imx_data *spi_imx,
+static int __maybe_unused mx27_config(struct spi_imx_data *spi_imx,
 		struct spi_imx_config *config)
 {
 	unsigned int reg = MX27_CSPICTRL_ENABLE | MX27_CSPICTRL_MASTER;
@@ -294,7 +308,7 @@ static int mx27_config(struct spi_imx_data *spi_imx,
 	return 0;
 }
 
-static int mx27_rx_available(struct spi_imx_data *spi_imx)
+static int __maybe_unused mx27_rx_available(struct spi_imx_data *spi_imx)
 {
 	return readl(spi_imx->base + MXC_CSPIINT) & MX27_INTREG_RR;
 }
@@ -310,7 +324,7 @@ static int mx27_rx_available(struct spi_imx_data *spi_imx)
 #define MX1_CSPICTRL_MASTER	(1 << 10)
 #define MX1_CSPICTRL_DR_SHIFT	13
 
-static void mx1_intctrl(struct spi_imx_data *spi_imx, int enable)
+static void __maybe_unused mx1_intctrl(struct spi_imx_data *spi_imx, int enable)
 {
 	unsigned int val = 0;
 
@@ -322,7 +336,7 @@ static void mx1_intctrl(struct spi_imx_data *spi_imx, int enable)
 	writel(val, spi_imx->base + MXC_CSPIINT);
 }
 
-static void mx1_trigger(struct spi_imx_data *spi_imx)
+static void __maybe_unused mx1_trigger(struct spi_imx_data *spi_imx)
 {
 	unsigned int reg;
 
@@ -331,7 +345,7 @@ static void mx1_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
-static int mx1_config(struct spi_imx_data *spi_imx,
+static int __maybe_unused mx1_config(struct spi_imx_data *spi_imx,
 		struct spi_imx_config *config)
 {
 	unsigned int reg = MX1_CSPICTRL_ENABLE | MX1_CSPICTRL_MASTER;
@@ -350,11 +364,50 @@ static int mx1_config(struct spi_imx_data *spi_imx,
 	return 0;
 }
 
-static int mx1_rx_available(struct spi_imx_data *spi_imx)
+static int __maybe_unused mx1_rx_available(struct spi_imx_data *spi_imx)
 {
 	return readl(spi_imx->base + MXC_CSPIINT) & MX1_INTREG_RR;
 }
 
+/*
+ * These version numbers are taken from the Freescale driver.  Unfortunately it
+ * doesn't support i.MX1, so this entry doesn't match the scheme. :-(
+ */
+static struct spi_imx_devtype_data spi_imx_devtype_data[] __devinitdata = {
+#ifdef CONFIG_SPI_IMX_VER_IMX1
+	[SPI_IMX_VER_IMX1] = {
+		.intctrl = mx1_intctrl,
+		.config = mx1_config,
+		.trigger = mx1_trigger,
+		.rx_available = mx1_rx_available,
+	},
+#endif
+#ifdef CONFIG_SPI_IMX_VER_0_0
+	[SPI_IMX_VER_0_0] = {
+		.intctrl = mx27_intctrl,
+		.config = mx27_config,
+		.trigger = mx27_trigger,
+		.rx_available = mx27_rx_available,
+	},
+#endif
+#ifdef CONFIG_SPI_IMX_VER_0_4
+	[SPI_IMX_VER_0_4] = {
+		.intctrl = mx31_intctrl,
+		.config = mx31_config,
+		.trigger = mx31_trigger,
+		.rx_available = mx31_rx_available,
+	},
+#endif
+#ifdef CONFIG_SPI_IMX_VER_0_7
+	[SPI_IMX_VER_0_7] = {
+		.intctrl = mx31_intctrl,
+		.config = mx31_config,
+		.trigger = mx31_trigger,
+		.rx_available = mx31_rx_available,
+	},
+#endif
+};
+
 static void spi_imx_chipselect(struct spi_device *spi, int is_active)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
@@ -377,14 +430,14 @@ static void spi_imx_push(struct spi_imx_data *spi_imx)
 		spi_imx->txfifo++;
 	}
 
-	spi_imx->trigger(spi_imx);
+	spi_imx->devtype_data.trigger(spi_imx);
 }
 
 static irqreturn_t spi_imx_isr(int irq, void *dev_id)
 {
 	struct spi_imx_data *spi_imx = dev_id;
 
-	while (spi_imx->rx_available(spi_imx)) {
+	while (spi_imx->devtype_data.rx_available(spi_imx)) {
 		spi_imx->rx(spi_imx);
 		spi_imx->txfifo--;
 	}
@@ -398,11 +451,12 @@ static irqreturn_t spi_imx_isr(int irq, void *dev_id)
 		/* No data left to push, but still waiting for rx data,
 		 * enable receive data available interrupt.
 		 */
-		spi_imx->intctrl(spi_imx, MXC_INT_RR);
+		spi_imx->devtype_data.intctrl(
+				spi_imx, MXC_INT_RR);
 		return IRQ_HANDLED;
 	}
 
-	spi_imx->intctrl(spi_imx, 0);
+	spi_imx->devtype_data.intctrl(spi_imx, 0);
 	complete(&spi_imx->xfer_done);
 
 	return IRQ_HANDLED;
@@ -439,7 +493,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	} else
 		BUG();
 
-	spi_imx->config(spi_imx, &config);
+	spi_imx->devtype_data.config(spi_imx, &config);
 
 	return 0;
 }
@@ -458,7 +512,7 @@ static int spi_imx_transfer(struct spi_device *spi,
 
 	spi_imx_push(spi_imx);
 
-	spi_imx->intctrl(spi_imx, MXC_INT_TE);
+	spi_imx->devtype_data.intctrl(spi_imx, MXC_INT_TE);
 
 	wait_for_completion(&spi_imx->xfer_done);
 
@@ -485,6 +539,33 @@ static void spi_imx_cleanup(struct spi_device *spi)
 {
 }
 
+static struct platform_device_id spi_imx_devtype[] = {
+	{
+		.name = DRIVER_NAME,
+		.driver_data = SPI_IMX_VER_AUTODETECT,
+	}, {
+		.name = "imx1-cspi",
+		.driver_data = SPI_IMX_VER_IMX1,
+	}, {
+		.name = "imx21-cspi",
+		.driver_data = SPI_IMX_VER_0_0,
+	}, {
+		.name = "imx25-cspi",
+		.driver_data = SPI_IMX_VER_0_7,
+	}, {
+		.name = "imx27-cspi",
+		.driver_data = SPI_IMX_VER_0_0,
+	}, {
+		.name = "imx31-cspi",
+		.driver_data = SPI_IMX_VER_0_4,
+	}, {
+		.name = "imx35-cspi",
+		.driver_data = SPI_IMX_VER_0_7,
+	}, {
+		/* sentinel */
+	}
+};
+
 static int __devinit spi_imx_probe(struct platform_device *pdev)
 {
 	struct spi_imx_master *mxc_platform_info;
@@ -536,6 +617,31 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 
 	init_completion(&spi_imx->xfer_done);
 
+	if (pdev->id_entry->driver_data == SPI_IMX_VER_AUTODETECT) {
+		if (cpu_is_mx25() || cpu_is_mx35())
+			spi_imx->devtype_data =
+				spi_imx_devtype_data[SPI_IMX_VER_0_7];
+		else if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35())
+			spi_imx->devtype_data =
+				spi_imx_devtype_data[SPI_IMX_VER_0_4];
+		else if (cpu_is_mx27() || cpu_is_mx21())
+			spi_imx->devtype_data =
+				spi_imx_devtype_data[SPI_IMX_VER_0_0];
+		else if (cpu_is_mx1())
+			spi_imx->devtype_data =
+				spi_imx_devtype_data[SPI_IMX_VER_IMX1];
+		else
+			BUG();
+	} else
+		spi_imx->devtype_data =
+			spi_imx_devtype_data[pdev->id_entry->driver_data];
+
+	if (!spi_imx->devtype_data.intctrl) {
+		dev_err(&pdev->dev, "no support for this device compiled in\n");
+		ret = -ENODEV;
+		goto out_gpio_free;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "can't get platform resource\n");
@@ -567,24 +673,6 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 		goto out_iounmap;
 	}
 
-	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35()) {
-		spi_imx->intctrl = mx31_intctrl;
-		spi_imx->config = mx31_config;
-		spi_imx->trigger = mx31_trigger;
-		spi_imx->rx_available = mx31_rx_available;
-	} else  if (cpu_is_mx27() || cpu_is_mx21()) {
-		spi_imx->intctrl = mx27_intctrl;
-		spi_imx->config = mx27_config;
-		spi_imx->trigger = mx27_trigger;
-		spi_imx->rx_available = mx27_rx_available;
-	} else if (cpu_is_mx1()) {
-		spi_imx->intctrl = mx1_intctrl;
-		spi_imx->config = mx1_config;
-		spi_imx->trigger = mx1_trigger;
-		spi_imx->rx_available = mx1_rx_available;
-	} else
-		BUG();
-
 	spi_imx->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(spi_imx->clk)) {
 		dev_err(&pdev->dev, "unable to get clock\n");
@@ -603,7 +691,7 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 		while (readl(spi_imx->base + MX3_CSPISTAT) & MX3_CSPISTAT_RR)
 			readl(spi_imx->base + MXC_CSPIRXDATA);
 
-	spi_imx->intctrl(spi_imx, 0);
+	spi_imx->devtype_data.intctrl(spi_imx, 0);
 
 	ret = spi_bitbang_start(&spi_imx->bitbang);
 	if (ret) {
@@ -668,6 +756,7 @@ static struct platform_driver spi_imx_driver = {
 		   .name = DRIVER_NAME,
 		   .owner = THIS_MODULE,
 		   },
+	.id_table = spi_imx_devtype,
 	.probe = spi_imx_probe,
 	.remove = __devexit_p(spi_imx_remove),
 };
-- 
1.7.2.3
