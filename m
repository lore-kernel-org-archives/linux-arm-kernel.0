From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Nov 2009 21:35:06 +0100
Subject: [PATCH 23/25] imx/mx31lite: use new nand device registration
In-Reply-To: <1258403708-10287-22-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091116203406.GA6546@pengutronix.de>
	<1258403708-10287-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-16-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-17-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-18-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-19-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-20-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-21-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-22-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1258403708-10287-23-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/mx31lite.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31lite.c b/arch/arm/mach-mx3/mx31lite.c
index a8d57de..6884e59 100644
--- a/arch/arm/mach-mx3/mx31lite.c
+++ b/arch/arm/mach-mx3/mx31lite.c
@@ -38,7 +38,6 @@
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/irqs.h>
-#include <mach/mxc_nand.h>
 #include "devices.h"
 
 /*
@@ -59,11 +58,6 @@ static struct imxuart_platform_data uart_pdata = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-static struct mxc_nand_platform_data mx31lite_nand_board_info = {
-	.width = 1,
-	.hw_ecc = 1,
-};
-
 static struct smsc911x_platform_config smsc911x_config = {
 	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
 	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
@@ -123,13 +117,17 @@ void __init mx31lite_map_io(void)
  */
 static void __init mxc_board_init(void)
 {
+	struct mxc_nand_platform_data mxc_nand_pdata = {
+		.width = 1,
+		.hw_ecc = 1,
+	};
 	int ret;
 
 	mxc_iomux_setup_multiple_pins(mx31lite_pins, ARRAY_SIZE(mx31lite_pins),
 				      "mx31lite");
 
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
-	mxc_register_device(&mxc_nand_device, &mx31lite_nand_board_info);
+	imx31_add_mxc_nand(&mxc_nand_pdata);
 
 	/* SMSC9117 IRQ pin */
 	ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_SFS6), "sms9117-irq");
-- 
1.6.5.2
