From: siccegge@cs.fau.de (Christoph Egger)
Date: Wed, 30 Jun 2010 15:55:22 +0000
Subject: [PATCH] Removing dead OMAP_IR
Message-ID: <mailman.62.1278317711.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP_IR doesn't exist in Kconfig, therefore removing all references
for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
[tony at atomide.com: updated for new mux code]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index ee46974..2efa427 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -292,15 +292,6 @@ static struct platform_device h2_kp_device = {
 
 #define H2_IRDA_FIRSEL_GPIO_PIN	17
 
-#if defined(CONFIG_OMAP_IR) || defined(CONFIG_OMAP_IR_MODULE)
-static int h2_transceiver_mode(struct device *dev, int state)
-{
-	/* SIR when low, else MIR/FIR when HIGH */
-	gpio_set_value(H2_IRDA_FIRSEL_GPIO_PIN, !(state & IR_SIRMODE));
-	return 0;
-}
-#endif
-
 static struct omap_irda_config h2_irda_data = {
 	.transceiver_cap	= IR_SIRMODE | IR_MIRMODE | IR_FIRMODE,
 	.rx_channel		= OMAP_DMA_UART3_RX,
@@ -450,15 +441,6 @@ static void __init h2_init(void)
 	omap_cfg_reg(E19_1610_KBR4);
 	omap_cfg_reg(N19_1610_KBR5);
 
-	/* Irda */
-#if defined(CONFIG_OMAP_IR) || defined(CONFIG_OMAP_IR_MODULE)
-	omap_writel(omap_readl(FUNC_MUX_CTRL_A) | 7, FUNC_MUX_CTRL_A);
-	if (gpio_request(H2_IRDA_FIRSEL_GPIO_PIN, "IRDA mode") < 0)
-		BUG();
-	gpio_direction_output(H2_IRDA_FIRSEL_GPIO_PIN, 0);
-	h2_irda_data.transceiver_mode = h2_transceiver_mode;
-#endif
-
 	platform_add_devices(h2_devices, ARRAY_SIZE(h2_devices));
 	omap_board_config = h2_config;
 	omap_board_config_size = ARRAY_SIZE(h2_config);
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 2d9ff0f..9044dcf 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -356,10 +356,6 @@ static void __init omap_h4_init(void)
 	 * You have to mux them off in device drivers later on
 	 * if not needed.
 	 */
-#if defined(CONFIG_OMAP_IR) || defined(CONFIG_OMAP_IR_MODULE)
-	omap_mux_init_signal("uart3_tx_irtx.uart3_tx_irtx", 0);
-	omap_mux_init_signal("uart3_rx_irrx.uart3_rx_irrx", 0);
-#endif
 
 #if defined(CONFIG_KEYBOARD_OMAP) || defined(CONFIG_KEYBOARD_OMAP_MODULE)
 	omap_mux_init_gpio(88, OMAP_PULL_ENA | OMAP_PULL_UP);

--6TrnltStXW4iwmi0--
