From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Jan 2010 17:17:25 +0100
Subject: [PATCH 18/25] imx35: define and use MX35_IO_ADDRESS
In-Reply-To: <1262967452-24353-17-git-send-email-u.kleine-koenig@pengutronix.de>
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
	<1262967452-24353-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-16-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-17-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1262967452-24353-18-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: J?rgen Beisert <j.beisert@pengutronix.de>
Cc: Rabin Vincent <rabin@rab.in>
Cc: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 arch/arm/mach-mx3/clock-imx35.c       |    5 +++--
 arch/arm/plat-mxc/include/mach/mx35.h |    7 +++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index e65e862..07d630e 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -28,7 +28,7 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 
-#define CCM_BASE	IO_ADDRESS(MX35_CCM_BASE_ADDR)
+#define CCM_BASE	MX35_IO_ADDRESS(MX35_CCM_BASE_ADDR)
 
 #define CCM_CCMR        0x00
 #define CCM_PDR0        0x04
@@ -504,7 +504,8 @@ int __init mx35_clocks_init()
 	__raw_writel((3 << 26) | ll, CCM_BASE + CCM_CGR2);
 	__raw_writel(0, CCM_BASE + CCM_CGR3);
 
-	mxc_timer_init(&gpt_clk, IO_ADDRESS(MX35_GPT1_BASE_ADDR), MX35_INT_GPT);
+	mxc_timer_init(&gpt_clk,
+			MX35_IO_ADDRESS(MX35_GPT1_BASE_ADDR), MX35_INT_GPT);
 
 	return 0;
 }
diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
index af871bc..0e453b3 100644
--- a/arch/arm/plat-mxc/include/mach/mx35.h
+++ b/arch/arm/plat-mxc/include/mach/mx35.h
@@ -104,6 +104,13 @@
 #define MX35_NFC_BASE_ADDR		0xbb000000
 #define MX35_PCMCIA_MEM_BASE_ADDR	0xbc000000
 
+#define MX35_IO_ADDRESS(x) (						\
+	IMX_IO_ADDRESS(x, MX35_AIPS1) ?:				\
+	IMX_IO_ADDRESS(x, MX35_AIPS2) ?:				\
+	IMX_IO_ADDRESS(x, MX35_AVIC) ?:					\
+	IMX_IO_ADDRESS(x, MX35_X_MEMC) ?:				\
+	IMX_IO_ADDRESS(x, MX35_SPBA0))
+
 /*
  * Interrupt numbers
  */
-- 
1.6.5.2
