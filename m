From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Jan 2010 17:17:22 +0100
Subject: [PATCH 15/25] imx27: define and use MX27_IO_ADDRESS
In-Reply-To: <1262967452-24353-14-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100108161551.GA19007@pengutronix.de>
	<1262967452-24353-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-14-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1262967452-24353-15-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Rabin Vincent <rabin@rab.in>
Cc: Javier Martin <javier.martin@vista-silicon.com>
Cc: Valentin Longchamp <valentin.longchamp@epfl.ch>
Cc: Holger Schurig <hs4233@mail.mn-solutions.de>
---
 arch/arm/mach-mx2/clock_imx27.c       |    4 ++--
 arch/arm/mach-mx2/cpu_imx27.c         |    3 ++-
 arch/arm/plat-mxc/include/mach/mx27.h |    5 +++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx2/clock_imx27.c b/arch/arm/mach-mx2/clock_imx27.c
index 6db9856..bb9f603 100644
--- a/arch/arm/mach-mx2/clock_imx27.c
+++ b/arch/arm/mach-mx2/clock_imx27.c
@@ -29,7 +29,7 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 
-#define IO_ADDR_CCM(off)	(IO_ADDRESS(MX27_CCM_BASE_ADDR) + (off))
+#define IO_ADDR_CCM(off)	(MX27_IO_ADDRESS(MX27_CCM_BASE_ADDR) + (off))
 
 /* Register offsets */
 #define CCM_CSCR		IO_ADDR_CCM(0x0)
@@ -757,7 +757,7 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_enable(&uart1_clk);
 #endif
 
-	mxc_timer_init(&gpt1_clk, IO_ADDRESS(MX27_GPT1_BASE_ADDR),
+	mxc_timer_init(&gpt1_clk, MX27_IO_ADDRESS(MX27_GPT1_BASE_ADDR),
 			MX27_INT_GPT1);
 
 	return 0;
diff --git a/arch/arm/mach-mx2/cpu_imx27.c b/arch/arm/mach-mx2/cpu_imx27.c
index 8c50c5e..d8d3b2d 100644
--- a/arch/arm/mach-mx2/cpu_imx27.c
+++ b/arch/arm/mach-mx2/cpu_imx27.c
@@ -39,7 +39,8 @@ static void query_silicon_parameter(void)
 	 * the silicon revision very early we read it here to
 	 * avoid any further hooks
 	*/
-	val = __raw_readl(IO_ADDRESS(MX27_SYSCTRL_BASE_ADDR) + SYS_CHIP_ID);
+	val = __raw_readl(MX27_IO_ADDRESS(MX27_SYSCTRL_BASE_ADDR
+				+ SYS_CHIP_ID));
 
 	cpu_silicon_rev = (int)(val >> 28);
 	cpu_partnumber = (int)((val >> 12) & 0xFFFF);
diff --git a/arch/arm/plat-mxc/include/mach/mx27.h b/arch/arm/plat-mxc/include/mach/mx27.h
index e2ae19f..cd292ff 100644
--- a/arch/arm/plat-mxc/include/mach/mx27.h
+++ b/arch/arm/plat-mxc/include/mach/mx27.h
@@ -114,6 +114,11 @@
 /* IRAM */
 #define MX27_IRAM_BASE_ADDR		0xffff4c00	/* internal ram */
 
+#define MX27_IO_ADDRESS(x) (						\
+	IMX_IO_ADDRESS(x, MX27_AIPI) ?:					\
+	IMX_IO_ADDRESS(x, MX27_SAHB1) ?:				\
+	IMX_IO_ADDRESS(x, MX27_X_MEMC))
+
 /* fixed interrupt numbers */
 #define MX27_INT_I2C2		1
 #define MX27_INT_GPT6		2
-- 
1.6.5.2
