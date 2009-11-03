From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Tue,  3 Nov 2009 18:09:47 +0100
Subject: [PATCH 2/6] mx31moboard: serial port fix
In-Reply-To: <1257268191-19075-2-git-send-email-valentin.longchamp@epfl.ch>
References: <1257268191-19075-1-git-send-email-valentin.longchamp@epfl.ch>
	<1257268191-19075-2-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <1257268191-19075-3-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get rid of CTS/RTS lines on uart0 on our platform.
This is the port we use as main kernel console. We do not
want it to be blocking because of CTS/RTS signals, not allowing
the system to boot or print messages.

However we often use it with a bluetooth module needing CTS/RTS
lines as backup login in case of trouble. To be able to use it,
we assert CTS low so that the module can always send chars.

Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 arch/arm/mach-mx3/mx31moboard.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31moboard.c b/arch/arm/mach-mx3/mx31moboard.c
index 9243de5..ff74fab 100644
--- a/arch/arm/mach-mx3/mx31moboard.c
+++ b/arch/arm/mach-mx3/mx31moboard.c
@@ -45,8 +45,8 @@
 
 static unsigned int moboard_pins[] = {
 	/* UART0 */
-	MX31_PIN_CTS1__CTS1, MX31_PIN_RTS1__RTS1,
 	MX31_PIN_TXD1__TXD1, MX31_PIN_RXD1__RXD1,
+	MX31_PIN_CTS1__GPIO2_7,
 	/* UART4 */
 	MX31_PIN_PC_RST__CTS5, MX31_PIN_PC_VS2__RTS5,
 	MX31_PIN_PC_BVD2__TXD5, MX31_PIN_PC_BVD1__RXD5,
@@ -101,7 +101,18 @@ static struct platform_device mx31moboard_flash = {
 	.num_resources = 1,
 };
 
-static struct imxuart_platform_data uart_pdata = {
+static int moboard_uart0_init(struct platform_device *pdev)
+{
+	gpio_request(IOMUX_TO_GPIO(MX31_PIN_CTS1), "uart0-cts-hack");
+	gpio_direction_output(IOMUX_TO_GPIO(MX31_PIN_CTS1), 0);
+	return 0;
+}
+
+static struct imxuart_platform_data uart0_pdata = {
+	.init = moboard_uart0_init,
+};
+
+static struct imxuart_platform_data uart4_pdata = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
@@ -284,8 +295,9 @@ static void __init mxc_board_init(void)
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
-	mxc_register_device(&mxc_uart_device0, &uart_pdata);
-	mxc_register_device(&mxc_uart_device4, &uart_pdata);
+	mxc_register_device(&mxc_uart_device0, &uart0_pdata);
+
+	mxc_register_device(&mxc_uart_device4, &uart4_pdata);
 
 	mx31moboard_init_sel_gpios();
 
-- 
1.6.3.3
