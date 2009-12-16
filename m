From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 16 Dec 2009 19:59:56 +0100
Subject: [PATCH 15/20] imx21: define and use MX21_IO_ADDRESS
In-Reply-To: <1260990002-24168-14-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091216185046.GA16984@pengutronix.de>
	<1260990002-24168-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-14-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1260990002-24168-15-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx2/clock_imx21.c       |    4 ++--
 arch/arm/plat-mxc/include/mach/mx21.h |    7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx2/clock_imx21.c b/arch/arm/mach-mx2/clock_imx21.c
index a6e12ce..43fba79 100644
--- a/arch/arm/mach-mx2/clock_imx21.c
+++ b/arch/arm/mach-mx2/clock_imx21.c
@@ -28,7 +28,7 @@
 #include <asm/clkdev.h>
 #include <asm/div64.h>
 
-#define IO_ADDR_CCM(off)	(IO_ADDRESS(IMX21_CCM_BASE_ADDR) + (off))
+#define IO_ADDR_CCM(off)	(MX21_IO_ADDRESS(IMX21_CCM_BASE_ADDR) + (off))
 
 /* Register offsets */
 #define CCM_CSCR		IO_ADDR_CCM(0x0)
@@ -1235,7 +1235,7 @@ int __init mx21_clocks_init(unsigned long lref, unsigned long href)
 	clk_enable(&uart_clk[0]);
 #endif
 
-	mxc_timer_init(&gpt_clk[0], IO_ADDRESS(MX21_GPT1_BASE_ADDR),
+	mxc_timer_init(&gpt_clk[0], MX21_IO_ADDRESS(MX21_GPT1_BASE_ADDR),
 			MX21_INT_GPT1);
 	return 0;
 }
diff --git a/arch/arm/plat-mxc/include/mach/mx21.h b/arch/arm/plat-mxc/include/mach/mx21.h
index bb297d8..c7a6b84 100644
--- a/arch/arm/plat-mxc/include/mach/mx21.h
+++ b/arch/arm/plat-mxc/include/mach/mx21.h
@@ -92,6 +92,13 @@
 
 #define MX21_IRAM_BASE_ADDR		0xffffe800	/* internal ram */
 
+#define MX21_IO_ADDRESS(x)						\
+	(void __force __iomem *) (					\
+	IMX_IO_ADDRESS(x, MX21_AIPI) ?:					\
+	IMX_IO_ADDRESS(x, MX21_SAHB1) ?:				\
+	IMX_IO_ADDRESS(x, MX21_X_MEMC) ?:				\
+	0xdeadbeef)
+
 /* fixed interrupt numbers */
 #define MX21_INT_CSPI3		6
 #define MX21_INT_GPIO		8
-- 
1.6.5.2
