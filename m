From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Jan 2010 17:17:26 +0100
Subject: [PATCH 19/25] mx3/kzm_arm11_01: define and use board specific
	IO_ADDRESS macro
In-Reply-To: <1262967452-24353-18-git-send-email-u.kleine-koenig@pengutronix.de>
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
	<1262967452-24353-18-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1262967452-24353-19-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-mx3/mach-kzm_arm11_01.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-kzm_arm11_01.c b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
index 2850b0b..2484ddd 100644
--- a/arch/arm/mach-mx3/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
@@ -46,13 +46,18 @@
 
 #include "devices.h"
 
+#define KZM_ARM11_IO_ADDRESS(x) (					\
+	IMX_IO_ADDRESS(x, MX31_CS4) ?:					\
+	IMX_IO_ADDRESS(x, MX31_CS5) ?:					\
+	MX31_IO_ADDRESS(x))
+
 #if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
 /*
  * KZM-ARM11-01 has an external UART on FPGA
  */
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
-		.membase	= IO_ADDRESS(KZM_ARM11_16550),
+		.membase	= KZM_ARM11_IO_ADDRESS(KZM_ARM11_16550),
 		.mapbase	= KZM_ARM11_16550,
 		.irq		= IOMUX_TO_IRQ(MX31_PIN_GPIO1_1),
 		.irqflags	= IRQ_TYPE_EDGE_RISING,
@@ -102,9 +107,9 @@ static int __init kzm_init_ext_uart(void)
 	/*
 	 * Unmask UART interrupt
 	 */
-	tmp = __raw_readb(IO_ADDRESS(KZM_ARM11_CTL1));
+	tmp = __raw_readb(KZM_ARM11_IO_ADDRESS(KZM_ARM11_CTL1));
 	tmp |= 0x2;
-	__raw_writeb(tmp, IO_ADDRESS(KZM_ARM11_CTL1));
+	__raw_writeb(tmp, KZM_ARM11_IO_ADDRESS(KZM_ARM11_CTL1));
 
 	return platform_device_register(&serial_device);
 }
-- 
1.6.5.2
