From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 20 Jun 2011 16:32:27 +0530
Subject: [PATCH 1/6] serial: samsung: Keep a copy of platform data in driver's
	private data
In-Reply-To: <1308567752-13451-1-git-send-email-thomas.abraham@linaro.org>
References: <1308567752-13451-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1308567752-13451-2-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver depends on pdev->dev.platform_data to retrive information
about the platform data even after the initialization. To add device
tree support, this has to be changed in way that the platform data
is avialable from driver's private data. This patch adds support
for keeping a copy of the plaform data in s3c24xx_uart_info and using
it when needed after the initialization.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/tty/serial/s5pv210.c |   12 ++++++++++--
 drivers/tty/serial/samsung.c |   24 ++++++++++++++++++++----
 drivers/tty/serial/samsung.h |    4 +++-
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/s5pv210.c b/drivers/tty/serial/s5pv210.c
index d6b2423..3b2021a 100644
--- a/drivers/tty/serial/s5pv210.c
+++ b/drivers/tty/serial/s5pv210.c
@@ -27,9 +27,13 @@
 static int s5pv210_serial_setsource(struct uart_port *port,
 					struct s3c24xx_uart_clksrc *clk)
 {
-	struct s3c2410_uartcfg *cfg = port->dev->platform_data;
+	struct s3c24xx_uart_port *ourport;
+	struct s3c2410_uartcfg *cfg;
 	unsigned long ucon = rd_regl(port, S3C2410_UCON);
 
+	ourport = container_of(port, struct s3c24xx_uart_port, port);
+	cfg = &ourport->info->cfg;
+
 	if ((cfg->clocks_size) == 1)
 		return 0;
 
@@ -50,9 +54,13 @@ static int s5pv210_serial_setsource(struct uart_port *port,
 static int s5pv210_serial_getsource(struct uart_port *port,
 					struct s3c24xx_uart_clksrc *clk)
 {
-	struct s3c2410_uartcfg *cfg = port->dev->platform_data;
+	struct s3c24xx_uart_port *ourport;
+	struct s3c2410_uartcfg *cfg;
 	u32 ucon = rd_regl(port, S3C2410_UCON);
 
+	ourport = container_of(port, struct s3c24xx_uart_port, port);
+	cfg = &ourport->info->cfg;
+
 	clk->divisor = 1;
 
 	if ((cfg->clocks_size) == 1)
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 7ead421..77d900f 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -42,6 +42,7 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
+#include <linux/slab.h>
 
 #include <asm/irq.h>
 
@@ -169,10 +170,13 @@ static inline struct s3c24xx_uart_info *s3c24xx_port_to_info(struct uart_port *p
 
 static inline struct s3c2410_uartcfg *s3c24xx_port_to_cfg(struct uart_port *port)
 {
+	struct s3c24xx_uart_port *ourport;
+
 	if (port->dev == NULL)
 		return NULL;
 
-	return (struct s3c2410_uartcfg *)port->dev->platform_data;
+	ourport = container_of(port, struct s3c24xx_uart_port, port);
+	return &ourport->info->cfg;
 }
 
 static int s3c24xx_serial_rx_fifocnt(struct s3c24xx_uart_port *ourport,
@@ -1053,7 +1057,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 				    struct platform_device *platdev)
 {
 	struct uart_port *port = &ourport->port;
-	struct s3c2410_uartcfg *cfg;
+	struct s3c2410_uartcfg *cfg = platdev->dev.platform_data;
 	struct resource *res;
 	int ret;
 
@@ -1062,14 +1066,24 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 	if (platdev == NULL)
 		return -ENODEV;
 
-	cfg = s3c24xx_dev_to_cfg(&platdev->dev);
-
 	if (port->mapbase != 0)
 		return 0;
 
+	if (cfg) {
+		memcpy((void *)&info->cfg, cfg, sizeof(struct s3c2410_uartcfg));
+		info->cfg.clocks = kzalloc(sizeof(struct s3c24xx_uart_clksrc) *
+					cfg->clocks_size, GFP_KERNEL);
+		if (!info->cfg.clocks)
+			return -ENOMEM;
+		memcpy(info->cfg.clocks, cfg->clocks,
+			sizeof(struct s3c24xx_uart_clksrc) * cfg->clocks_size);
+	}
+
+	cfg = &info->cfg;
 	if (cfg->hwport > CONFIG_SERIAL_SAMSUNG_UARTS) {
 		printk(KERN_ERR "%s: port %d bigger than %d\n", __func__,
 		       cfg->hwport, CONFIG_SERIAL_SAMSUNG_UARTS);
+		kfree(info->cfg.clocks);
 		return -ERANGE;
 	}
 
@@ -1181,11 +1195,13 @@ EXPORT_SYMBOL_GPL(s3c24xx_serial_probe);
 int __devexit s3c24xx_serial_remove(struct platform_device *dev)
 {
 	struct uart_port *port = s3c24xx_dev_to_port(&dev->dev);
+	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
 
 	if (port) {
 		s3c24xx_serial_cpufreq_deregister(to_ourport(port));
 		device_remove_file(&dev->dev, &dev_attr_clock_source);
 		uart_remove_one_port(&s3c24xx_uart_drv, port);
+		kfree(info->cfg.clocks);
 	}
 
 	return 0;
diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index a69d9a5..4f2f6f5 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -24,6 +24,9 @@ struct s3c24xx_uart_info {
 
 	unsigned int		has_divslot:1;
 
+	/* copy of platform data */
+	struct s3c2410_uartcfg	cfg;
+
 	/* clock source control */
 
 	int (*get_clksrc)(struct uart_port *, struct s3c24xx_uart_clksrc *clk);
@@ -56,7 +59,6 @@ struct s3c24xx_uart_port {
 /* conversion functions */
 
 #define s3c24xx_dev_to_port(__dev) (struct uart_port *)dev_get_drvdata(__dev)
-#define s3c24xx_dev_to_cfg(__dev) (struct s3c2410_uartcfg *)((__dev)->platform_data)
 
 /* register access controls */
 
-- 
1.6.6.rc2
