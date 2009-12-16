From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 16 Dec 2009 20:00:01 +0100
Subject: [PATCH 20/20] mx3/kzm_arm11_01: define and use board specific
	IO_ADDRESS macro
In-Reply-To: <1260990002-24168-19-git-send-email-u.kleine-koenig@pengutronix.de>
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
	<1260990002-24168-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-16-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-17-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-18-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-19-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1260990002-24168-20-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/mach-kzm_arm11_01.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-kzm_arm11_01.c b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
index 849631e..f29304f 100644
--- a/arch/arm/mach-mx3/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
@@ -46,13 +46,19 @@
 
 #include "devices.h"
 
+#define KZM_ARM11_IO_ADDRESS(x)						\
+	(void __force __iomem *) (					\
+	IMX_IO_ADDRESS(x, MX31_CS4) ?:					\
+	IMX_IO_ADDRESS(x, MX31_CS5) ?:					\
+	0xdeadbeef)
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
@@ -102,9 +108,9 @@ static int __init kzm_init_ext_uart(void)
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
