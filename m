From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 27 Nov 2014 16:35:16 +0900
Subject: [PATCH 19/19] serial: samsung: Add the support for Exynos5433 SoC
In-Reply-To: <1417073716-22997-1-git-send-email-cw00.choi@samsung.com>
References: <1417073716-22997-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1417073716-22997-20-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds new s3c24xx_serial_drv_data structure for Exynos5433 SoC
because Exynos5433 has different fifo size from existing Exynos4 SoC.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial at vger.kernel.org
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
Acked-by: Geunsik Lim <geunsik.lim@samsung.com>
---
 drivers/tty/serial/samsung.c | 56 ++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 2338ad8..6f1fb9a 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1766,32 +1766,43 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 #endif
 
 #if defined(CONFIG_ARCH_EXYNOS)
+#define EXYNOS_COMMON_SERIAL_DRV_DATA				\
+	.info = &(struct s3c24xx_uart_info) {			\
+		.name		= "Samsung Exynos UART",	\
+		.type		= PORT_S3C6400,			\
+		.has_divslot	= 1,				\
+		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,	\
+		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,	\
+		.rx_fifofull	= S5PV210_UFSTAT_RXFULL,	\
+		.tx_fifofull	= S5PV210_UFSTAT_TXFULL,	\
+		.tx_fifomask	= S5PV210_UFSTAT_TXMASK,	\
+		.tx_fifoshift	= S5PV210_UFSTAT_TXSHIFT,	\
+		.def_clk_sel	= S3C2410_UCON_CLKSEL0,		\
+		.num_clks	= 1,				\
+		.clksel_mask	= 0,				\
+		.clksel_shift	= 0,				\
+	},							\
+	.def_cfg = &(struct s3c2410_uartcfg) {			\
+		.ucon		= S5PV210_UCON_DEFAULT,		\
+		.ufcon		= S5PV210_UFCON_DEFAULT,	\
+		.has_fracval	= 1,				\
+	}							\
+
 static struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
-	.info = &(struct s3c24xx_uart_info) {
-		.name		= "Samsung Exynos4 UART",
-		.type		= PORT_S3C6400,
-		.has_divslot	= 1,
-		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,
-		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,
-		.rx_fifofull	= S5PV210_UFSTAT_RXFULL,
-		.tx_fifofull	= S5PV210_UFSTAT_TXFULL,
-		.tx_fifomask	= S5PV210_UFSTAT_TXMASK,
-		.tx_fifoshift	= S5PV210_UFSTAT_TXSHIFT,
-		.def_clk_sel	= S3C2410_UCON_CLKSEL0,
-		.num_clks	= 1,
-		.clksel_mask	= 0,
-		.clksel_shift	= 0,
-	},
-	.def_cfg = &(struct s3c2410_uartcfg) {
-		.ucon		= S5PV210_UCON_DEFAULT,
-		.ufcon		= S5PV210_UFCON_DEFAULT,
-		.has_fracval	= 1,
-	},
+	EXYNOS_COMMON_SERIAL_DRV_DATA,
 	.fifosize = { 256, 64, 16, 16 },
 };
+
+static struct s3c24xx_serial_drv_data exynos5433_serial_drv_data = {
+	EXYNOS_COMMON_SERIAL_DRV_DATA,
+	.fifosize = { 64, 256, 16, 256 },
+};
+
 #define EXYNOS4210_SERIAL_DRV_DATA ((kernel_ulong_t)&exynos4210_serial_drv_data)
+#define EXYNOS5433_SERIAL_DRV_DATA ((kernel_ulong_t)&exynos5433_serial_drv_data)
 #else
 #define EXYNOS4210_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#define EXYNOS5433_SERIAL_DRV_DATA (kernel_ulong_t)NULL
 #endif
 
 static struct platform_device_id s3c24xx_serial_driver_ids[] = {
@@ -1813,6 +1824,9 @@ static struct platform_device_id s3c24xx_serial_driver_ids[] = {
 	}, {
 		.name		= "exynos4210-uart",
 		.driver_data	= EXYNOS4210_SERIAL_DRV_DATA,
+	}, {
+		.name		= "exynos5433-uart",
+		.driver_data	= EXYNOS5433_SERIAL_DRV_DATA,
 	},
 	{ },
 };
@@ -1832,6 +1846,8 @@ static const struct of_device_id s3c24xx_uart_dt_match[] = {
 		.data = (void *)S5PV210_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,exynos4210-uart",
 		.data = (void *)EXYNOS4210_SERIAL_DRV_DATA },
+	{ .compatible = "samsung,exynos5433-uart",
+		.data = (void *)EXYNOS5433_SERIAL_DRV_DATA },
 	{},
 };
 MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
-- 
1.8.5.5
