From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 16 Jul 2010 17:58:34 +0900
Subject: [PATCH v2 8/8] ARM: S5PV310: Add serial port support
In-Reply-To: <1279270714-15146-1-git-send-email-kgene.kim@samsung.com>
References: <1279270714-15146-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1279270714-15146-9-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

This patch adds UART serial port support for S5PV310.
In the case of that serial device has just one clock source, driver can not
control clock source. So add check function in get_clksrc and set_clksrc.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Acked-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/serial/Kconfig   |    4 ++--
 drivers/serial/s5pv210.c |    8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 8b23165..aa22010 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -544,8 +544,8 @@ config SERIAL_S3C6400
 
 config SERIAL_S5PV210
 	tristate "Samsung S5PV210 Serial port support"
-	depends on SERIAL_SAMSUNG && (CPU_S5PV210 || CPU_S5P6442)
-	select SERIAL_SAMSUNG_UARTS_4 if CPU_S5PV210
+	depends on SERIAL_SAMSUNG && (CPU_S5PV210 || CPU_S5P6442 || CPU_S5PV310)
+	select SERIAL_SAMSUNG_UARTS_4 if (CPU_S5PV210 || CPU_S5PV310)
 	default y
 	help
 	  Serial port support for Samsung's S5P Family of SoC's
diff --git a/drivers/serial/s5pv210.c b/drivers/serial/s5pv210.c
index 4a789e5..6ebccd7 100644
--- a/drivers/serial/s5pv210.c
+++ b/drivers/serial/s5pv210.c
@@ -28,8 +28,12 @@
 static int s5pv210_serial_setsource(struct uart_port *port,
 					struct s3c24xx_uart_clksrc *clk)
 {
+	struct s3c2410_uartcfg *cfg = port->dev->platform_data;
 	unsigned long ucon = rd_regl(port, S3C2410_UCON);
 
+	if ((cfg->clocks_size) == 1)
+		return 0;
+
 	if (strcmp(clk->name, "pclk") == 0)
 		ucon &= ~S5PV210_UCON_CLKMASK;
 	else if (strcmp(clk->name, "uclk1") == 0)
@@ -47,10 +51,14 @@ static int s5pv210_serial_setsource(struct uart_port *port,
 static int s5pv210_serial_getsource(struct uart_port *port,
 					struct s3c24xx_uart_clksrc *clk)
 {
+	struct s3c2410_uartcfg *cfg = port->dev->platform_data;
 	u32 ucon = rd_regl(port, S3C2410_UCON);
 
 	clk->divisor = 1;
 
+	if ((cfg->clocks_size) == 1)
+		return 0;
+
 	switch (ucon & S5PV210_UCON_CLKMASK) {
 	case S5PV210_UCON_PCLK:
 		clk->name = "pclk";
-- 
1.6.2.5
