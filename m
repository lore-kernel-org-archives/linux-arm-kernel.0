From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 27 May 2011 19:04:03 -0700
Subject: [PATCH] ARM: SAMSUNG: serial: Fix on handling of one clock source for
	UART
Message-ID: <1306548243-2526-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boojin Kim <boojin.kim@samsung.com>

This patch fixes the way of comparison for handling of two or more
clock sources for UART.

For example, if just only one clock source is defined even though
there are two clock sources for UART, the serial driver does not
set proper clock up. Of course, it is problem.

So this patch changes the condition of comparison to avoid useless
setup clock and adds a flag 'NO_NEED_CHECK_CLKSRC' which means
selection of source clock is not required.

In addition, since the Exynos4210 has only one clock source for UART
this patch adds the flag into its common_init_uarts().

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/init.c                     |    1 +
 arch/arm/plat-samsung/include/plat/regs-serial.h |    2 ++
 drivers/tty/serial/s5pv210.c                     |    4 ++--
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos4/init.c b/arch/arm/mach-exynos4/init.c
index cf91f50..a8a83e3 100644
--- a/arch/arm/mach-exynos4/init.c
+++ b/arch/arm/mach-exynos4/init.c
@@ -35,6 +35,7 @@ void __init exynos4_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 			tcfg->clocks = exynos4_serial_clocks;
 			tcfg->clocks_size = ARRAY_SIZE(exynos4_serial_clocks);
 		}
+		tcfg->flags |= NO_NEED_CHECK_CLKSRC;
 	}
 
 	s3c24xx_init_uartdevs("s5pv210-uart", s5p_uart_resources, cfg, no);
diff --git a/arch/arm/plat-samsung/include/plat/regs-serial.h b/arch/arm/plat-samsung/include/plat/regs-serial.h
index 788837e..d2ef07f 100644
--- a/arch/arm/plat-samsung/include/plat/regs-serial.h
+++ b/arch/arm/plat-samsung/include/plat/regs-serial.h
@@ -224,6 +224,8 @@
 #define S5PV210_UFSTAT_RXMASK	(255<<0)
 #define S5PV210_UFSTAT_RXSHIFT	(0)
 
+#define NO_NEED_CHECK_CLKSRC	1
+
 #ifndef __ASSEMBLY__
 
 /* struct s3c24xx_uart_clksrc
diff --git a/drivers/tty/serial/s5pv210.c b/drivers/tty/serial/s5pv210.c
index 6ebccd7..453e5b7 100644
--- a/drivers/tty/serial/s5pv210.c
+++ b/drivers/tty/serial/s5pv210.c
@@ -31,7 +31,7 @@ static int s5pv210_serial_setsource(struct uart_port *port,
 	struct s3c2410_uartcfg *cfg = port->dev->platform_data;
 	unsigned long ucon = rd_regl(port, S3C2410_UCON);
 
-	if ((cfg->clocks_size) == 1)
+	if (cfg->flags & NO_NEED_CHECK_CLKSRC)
 		return 0;
 
 	if (strcmp(clk->name, "pclk") == 0)
@@ -56,7 +56,7 @@ static int s5pv210_serial_getsource(struct uart_port *port,
 
 	clk->divisor = 1;
 
-	if ((cfg->clocks_size) == 1)
+	if (cfg->flags & NO_NEED_CHECK_CLKSRC)
 		return 0;
 
 	switch (ucon & S5PV210_UCON_CLKMASK) {
-- 
1.7.4.4
