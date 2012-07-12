From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 12 Jul 2012 11:57:48 +0200
Subject: [PATCH 2/7] MFD: mc13xxx workaround SPI hardware bug on i.Mx
In-Reply-To: <1342087073-3892-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1342087073-3892-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1342087073-3892-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe R?tornaz <philippe.retornaz@epfl.ch>

The MC13xxx PMIC is mainly used on i.Mx SoC. On thoses SoC the SPI
hardware will deassert CS line as soon as the SPI FIFO is empty.
The MC13xxx hardware is very sensitive to CS line change as it
corrupts the transfert if CS is deasserted in the middle of a register
read or write.
It is not possible to use the CS line as a GPIO on some SoC, so we
need to workaround this by implementing a single SPI transfer to
access the PMIC.

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Marc Reilly <marc@cpdesign.com.au>
Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Origin: next-20120712, commit:e4ecf6ea84d68aea5a9785e89f52672e1e126998
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mfd/mc13xxx-spi.c |   65 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
index 5d1969f..03df422 100644
--- a/drivers/mfd/mc13xxx-spi.c
+++ b/drivers/mfd/mc13xxx-spi.c
@@ -54,6 +54,67 @@ static struct regmap_config mc13xxx_regmap_spi_config = {
 	.max_register = MC13XXX_NUMREGS,
 
 	.cache_type = REGCACHE_NONE,
+	.use_single_rw = 1,
+};
+
+static int mc13xxx_spi_read(void *context, const void *reg, size_t reg_size,
+				void *val, size_t val_size)
+{
+	unsigned char w[4] = { *((unsigned char *) reg), 0, 0, 0};
+	unsigned char r[4];
+	unsigned char *p = val;
+	struct device *dev = context;
+	struct spi_device *spi = to_spi_device(dev);
+	struct spi_transfer t = {
+		.tx_buf = w,
+		.rx_buf = r,
+		.len = 4,
+	};
+
+	struct spi_message m;
+	int ret;
+
+	if (val_size != 3 || reg_size != 1)
+		return -ENOTSUPP;
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+	ret = spi_sync(spi, &m);
+
+	memcpy(p, &r[1], 3);
+
+	return ret;
+}
+
+static int mc13xxx_spi_write(void *context, const void *data, size_t count)
+{
+	struct device *dev = context;
+	struct spi_device *spi = to_spi_device(dev);
+
+	if (count != 4)
+		return -ENOTSUPP;
+
+	return spi_write(spi, data, count);
+}
+
+/*
+ * We cannot use regmap-spi generic bus implementation here.
+ * The MC13783 chip will get corrupted if CS signal is deasserted
+ * and on i.Mx31 SoC (the target SoC for MC13783 PMIC) the SPI controller
+ * has the following errata (DSPhl22960):
+ * "The CSPI negates SS when the FIFO becomes empty with
+ * SSCTL= 0. Software cannot guarantee that the FIFO will not
+ * drain because of higher priority interrupts and the
+ * non-realtime characteristics of the operating system. As a
+ * result, the SS will negate before all of the data has been
+ * transferred to/from the peripheral."
+ * We workaround this by accessing the SPI controller with a
+ * single transfert.
+ */
+
+static struct regmap_bus regmap_mc13xxx_bus = {
+	.write = mc13xxx_spi_write,
+	.read = mc13xxx_spi_read,
 };
 
 static int mc13xxx_spi_probe(struct spi_device *spi)
@@ -78,7 +139,9 @@ static int mc13xxx_spi_probe(struct spi_device *spi)
 	mc13xxx->dev = &spi->dev;
 	mutex_init(&mc13xxx->lock);
 
-	mc13xxx->regmap = regmap_init_spi(spi, &mc13xxx_regmap_spi_config);
+	mc13xxx->regmap = regmap_init(&spi->dev, &regmap_mc13xxx_bus, &spi->dev,
+					&mc13xxx_regmap_spi_config);
+
 	if (IS_ERR(mc13xxx->regmap)) {
 		ret = PTR_ERR(mc13xxx->regmap);
 		dev_err(mc13xxx->dev, "Failed to initialize register map: %d\n",
-- 
1.7.10.4
