From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Feb 2011 15:46:03 +0000
Subject: [PATCH 1/3] amba: make probe() functions take const id tables
Message-ID: <20110219154603.GJ29493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make Primecell driver probe functions take a const pointer to their
ID tables.  Drivers should never modify their ID tables in their
probe handler.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/etm.c                |    4 ++--
 drivers/char/hw_random/nomadik-rng.c |    2 +-
 drivers/dma/amba-pl08x.c             |    2 +-
 drivers/dma/pl330.c                  |    2 +-
 drivers/gpio/pl061.c                 |    2 +-
 drivers/input/serio/ambakmi.c        |    3 ++-
 drivers/mmc/host/mmci.c              |    3 ++-
 drivers/rtc/rtc-pl030.c              |    2 +-
 drivers/rtc/rtc-pl031.c              |    2 +-
 drivers/spi/amba-pl022.c             |    2 +-
 drivers/tty/serial/amba-pl010.c      |    2 +-
 drivers/tty/serial/amba-pl011.c      |    2 +-
 drivers/video/amba-clcd.c            |    2 +-
 drivers/watchdog/sp805_wdt.c         |    2 +-
 include/linux/amba/bus.h             |    2 +-
 sound/arm/aaci.c                     |    3 ++-
 16 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index 11db628..052b509 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -338,7 +338,7 @@ static struct miscdevice etb_miscdev = {
 	.fops = &etb_fops,
 };
 
-static int __init etb_probe(struct amba_device *dev, struct amba_id *id)
+static int __init etb_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct tracectx *t = &tracer;
 	int ret = 0;
@@ -530,7 +530,7 @@ static ssize_t trace_mode_store(struct kobject *kobj,
 static struct kobj_attribute trace_mode_attr =
 	__ATTR(trace_mode, 0644, trace_mode_show, trace_mode_store);
 
-static int __init etm_probe(struct amba_device *dev, struct amba_id *id)
+static int __init etm_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct tracectx *t = &tracer;
 	int ret = 0;
diff --git a/drivers/char/hw_random/nomadik-rng.c b/drivers/char/hw_random/nomadik-rng.c
index a348c7e..dd1d143 100644
--- a/drivers/char/hw_random/nomadik-rng.c
+++ b/drivers/char/hw_random/nomadik-rng.c
@@ -39,7 +39,7 @@ static struct hwrng nmk_rng = {
 	.read		= nmk_rng_read,
 };
 
-static int nmk_rng_probe(struct amba_device *dev, struct amba_id *id)
+static int nmk_rng_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	void __iomem *base;
 	int ret;
diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 07bca49..e6d7228 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1845,7 +1845,7 @@ static inline void init_pl08x_debugfs(struct pl08x_driver_data *pl08x)
 }
 #endif
 
-static int pl08x_probe(struct amba_device *adev, struct amba_id *id)
+static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct pl08x_driver_data *pl08x;
 	const struct vendor_data *vd = id->data;
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 7c50f6d..6abe1ec 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -657,7 +657,7 @@ static irqreturn_t pl330_irq_handler(int irq, void *data)
 }
 
 static int __devinit
-pl330_probe(struct amba_device *adev, struct amba_id *id)
+pl330_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct dma_pl330_platdata *pdat;
 	struct dma_pl330_dmac *pdmac;
diff --git a/drivers/gpio/pl061.c b/drivers/gpio/pl061.c
index 2975d22..838ddbd 100644
--- a/drivers/gpio/pl061.c
+++ b/drivers/gpio/pl061.c
@@ -232,7 +232,7 @@ static void pl061_irq_handler(unsigned irq, struct irq_desc *desc)
 	desc->irq_data.chip->irq_unmask(&desc->irq_data);
 }
 
-static int pl061_probe(struct amba_device *dev, struct amba_id *id)
+static int pl061_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct pl061_platform_data *pdata;
 	struct pl061_gpio *chip;
diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
index 92563a6..12abc50 100644
--- a/drivers/input/serio/ambakmi.c
+++ b/drivers/input/serio/ambakmi.c
@@ -107,7 +107,8 @@ static void amba_kmi_close(struct serio *io)
 	clk_disable(kmi->clk);
 }
 
-static int __devinit amba_kmi_probe(struct amba_device *dev, struct amba_id *id)
+static int __devinit amba_kmi_probe(struct amba_device *dev,
+	const struct amba_id *id)
 {
 	struct amba_kmi_port *kmi;
 	struct serio *io;
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 8a29c9f..5bbb87d 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -965,7 +965,8 @@ static const struct mmc_host_ops mmci_ops = {
 	.get_cd		= mmci_get_cd,
 };
 
-static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
+static int __devinit mmci_probe(struct amba_device *dev,
+	const struct amba_id *id)
 {
 	struct mmci_platform_data *plat = dev->dev.platform_data;
 	struct variant_data *variant = id->data;
diff --git a/drivers/rtc/rtc-pl030.c b/drivers/rtc/rtc-pl030.c
index bbdb2f0..baff724 100644
--- a/drivers/rtc/rtc-pl030.c
+++ b/drivers/rtc/rtc-pl030.c
@@ -103,7 +103,7 @@ static const struct rtc_class_ops pl030_ops = {
 	.set_alarm	= pl030_set_alarm,
 };
 
-static int pl030_probe(struct amba_device *dev, struct amba_id *id)
+static int pl030_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct pl030_rtc *rtc;
 	int ret;
diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index b7a6690..6568f4b 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -358,7 +358,7 @@ static int pl031_remove(struct amba_device *adev)
 	return 0;
 }
 
-static int pl031_probe(struct amba_device *adev, struct amba_id *id)
+static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	int ret;
 	struct pl031_local *ldata;
diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index 71a1219..95e58c7 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -2021,7 +2021,7 @@ static void pl022_cleanup(struct spi_device *spi)
 
 
 static int __devinit
-pl022_probe(struct amba_device *adev, struct amba_id *id)
+pl022_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct device *dev = &adev->dev;
 	struct pl022_ssp_controller *platform_info = adev->dev.platform_data;
diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 2904aa0..d742dd2 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -676,7 +676,7 @@ static struct uart_driver amba_reg = {
 	.cons			= AMBA_CONSOLE,
 };
 
-static int pl010_probe(struct amba_device *dev, struct amba_id *id)
+static int pl010_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct uart_amba_port *uap;
 	void __iomem *base;
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index e76d7d0..0dae46f 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1349,7 +1349,7 @@ static struct uart_driver amba_reg = {
 	.cons			= AMBA_CONSOLE,
 };
 
-static int pl011_probe(struct amba_device *dev, struct amba_id *id)
+static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct uart_amba_port *uap;
 	struct vendor_data *vendor = id->data;
diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index 8bd3706..5fc983c 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -534,7 +534,7 @@ static int clcdfb_register(struct clcd_fb *fb)
 	return ret;
 }
 
-static int clcdfb_probe(struct amba_device *dev, struct amba_id *id)
+static int clcdfb_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct clcd_board *board = dev->dev.platform_data;
 	struct clcd_fb *fb;
diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 9127eda..0a0efe7 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -278,7 +278,7 @@ static struct miscdevice sp805_wdt_miscdev = {
 };
 
 static int __devinit
-sp805_wdt_probe(struct amba_device *adev, struct amba_id *id)
+sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	int ret = 0;
 
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index a0ccf28..07b6374 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -43,7 +43,7 @@ struct amba_id {
 
 struct amba_driver {
 	struct device_driver	drv;
-	int			(*probe)(struct amba_device *, struct amba_id *);
+	int			(*probe)(struct amba_device *, const struct amba_id *);
 	int			(*remove)(struct amba_device *);
 	void			(*shutdown)(struct amba_device *);
 	int			(*suspend)(struct amba_device *, pm_message_t);
diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index af5a152..d0cead3 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -984,7 +984,8 @@ static unsigned int __devinit aaci_size_fifo(struct aaci *aaci)
 	return i;
 }
 
-static int __devinit aaci_probe(struct amba_device *dev, struct amba_id *id)
+static int __devinit aaci_probe(struct amba_device *dev,
+	const struct amba_id *id)
 {
 	struct aaci *aaci;
 	int ret, i;
