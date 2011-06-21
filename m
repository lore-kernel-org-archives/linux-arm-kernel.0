From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 21 Jun 2011 14:49:36 -0300
Subject: [PATCH 2/3] ARM: mach-imx/scb9328: Make the UART gpio setup simpler
In-Reply-To: <1308678577-25277-1-git-send-email-fabio.estevam@freescale.com>
References: <1308678577-25277-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1308678577-25277-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Place the UART gpio initialization inside the scb9328_init function as it is done on
other i.MX boards.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-scb9328.c |   17 +++--------------
 1 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-imx/mach-scb9328.c b/arch/arm/mach-imx/mach-scb9328.c
index 8280526..d1b31ca 100644
--- a/arch/arm/mach-imx/mach-scb9328.c
+++ b/arch/arm/mach-imx/mach-scb9328.c
@@ -101,21 +101,7 @@ static const int mxc_uart1_pins[] = {
 	PC12_PF_UART1_RXD,
 };
 
-static int uart1_mxc_init(struct platform_device *pdev)
-{
-	return mxc_gpio_setup_multiple_pins(mxc_uart1_pins,
-			ARRAY_SIZE(mxc_uart1_pins), "UART1");
-}
-
-static void uart1_mxc_exit(struct platform_device *pdev)
-{
-	mxc_gpio_release_multiple_pins(mxc_uart1_pins,
-			ARRAY_SIZE(mxc_uart1_pins));
-}
-
 static const struct imxuart_platform_data uart_pdata __initconst = {
-	.init = uart1_mxc_init,
-	.exit = uart1_mxc_exit,
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
@@ -130,6 +116,9 @@ static struct platform_device *devices[] __initdata = {
 static void __init scb9328_init(void)
 {
 	imx1_soc_init();
+
+	mxc_gpio_setup_multiple_pins(mxc_uart1_pins,
+			ARRAY_SIZE(mxc_uart1_pins), "UART1");
 
 	imx1_add_imx_uart0(&uart_pdata);
 
-- 
1.6.0.4
