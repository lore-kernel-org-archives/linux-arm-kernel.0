From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:57 +0200
Subject: [PATCH 61/61] ARM: mx3: complement uart init routine with an exit
	routine
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-62-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

moboard_uart0_init requests a gpio.   Without an exit function that
frees that gpio again binding the uart a second time doesn't work.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/mach-mx31moboard.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index 95633bb..67776bc 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -125,13 +125,25 @@ static struct platform_device mx31moboard_flash = {
 
 static int moboard_uart0_init(struct platform_device *pdev)
 {
-	gpio_request(IOMUX_TO_GPIO(MX31_PIN_CTS1), "uart0-cts-hack");
-	gpio_direction_output(IOMUX_TO_GPIO(MX31_PIN_CTS1), 0);
-	return 0;
+	int ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_CTS1), "uart0-cts-hack");
+	if (ret)
+		return ret;
+
+	ret = gpio_direction_output(IOMUX_TO_GPIO(MX31_PIN_CTS1), 0);
+	if (ret)
+		gpio_free(IOMUX_TO_GPIO(MX31_PIN_CTS1));
+
+	return ret;
+}
+
+static void moboard_uart0_exit(struct platform_device *pdev)
+{
+	gpio_free(IOMUX_TO_GPIO(MX31_PIN_CTS1));
 }
 
 static const struct imxuart_platform_data uart0_pdata __initconst = {
 	.init = moboard_uart0_init,
+	.exit = moboard_uart0_exit,
 };
 
 static const struct imxuart_platform_data uart4_pdata __initconst = {
-- 
1.7.1
