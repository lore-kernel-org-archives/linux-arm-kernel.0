From: stigge@antcom.de (Roland Stigge)
Date: Sat, 25 Feb 2012 16:35:17 +0100
Subject: [PATCH v2 5/6] ARM: LPC32xx: serial.c: HW bug workaround
In-Reply-To: <1330184118-10270-1-git-send-email-stigge@antcom.de>
References: <1330184118-10270-1-git-send-email-stigge@antcom.de>
Message-ID: <1330184118-10270-6-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a HW bug by flushing RX FIFOs of the UARTs on init.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 arch/arm/mach-lpc32xx/serial.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/serial.c
+++ linux-2.6/arch/arm/mach-lpc32xx/serial.c
@@ -88,6 +88,7 @@ struct uartinit {
 	char *uart_ck_name;
 	u32 ck_mode_mask;
 	void __iomem *pdiv_clk_reg;
+	resource_size_t mapbase;
 };
 
 static struct uartinit uartinit_data[] __initdata = {
@@ -97,6 +98,7 @@ static struct uartinit uartinit_data[] _
 		.ck_mode_mask =
 			LPC32XX_UART_CLKMODE_LOAD(LPC32XX_UART_CLKMODE_ON, 5),
 		.pdiv_clk_reg = LPC32XX_CLKPWR_UART5_CLK_CTRL,
+		.mapbase = LPC32XX_UART5_BASE,
 	},
 #endif
 #ifdef CONFIG_ARCH_LPC32XX_UART3_SELECT
@@ -105,6 +107,7 @@ static struct uartinit uartinit_data[] _
 		.ck_mode_mask =
 			LPC32XX_UART_CLKMODE_LOAD(LPC32XX_UART_CLKMODE_ON, 3),
 		.pdiv_clk_reg = LPC32XX_CLKPWR_UART3_CLK_CTRL,
+		.mapbase = LPC32XX_UART3_BASE,
 	},
 #endif
 #ifdef CONFIG_ARCH_LPC32XX_UART4_SELECT
@@ -113,6 +116,7 @@ static struct uartinit uartinit_data[] _
 		.ck_mode_mask =
 			LPC32XX_UART_CLKMODE_LOAD(LPC32XX_UART_CLKMODE_ON, 4),
 		.pdiv_clk_reg = LPC32XX_CLKPWR_UART4_CLK_CTRL,
+		.mapbase = LPC32XX_UART4_BASE,
 	},
 #endif
 #ifdef CONFIG_ARCH_LPC32XX_UART6_SELECT
@@ -121,6 +125,7 @@ static struct uartinit uartinit_data[] _
 		.ck_mode_mask =
 			LPC32XX_UART_CLKMODE_LOAD(LPC32XX_UART_CLKMODE_ON, 6),
 		.pdiv_clk_reg = LPC32XX_CLKPWR_UART6_CLK_CTRL,
+		.mapbase = LPC32XX_UART6_BASE,
 	},
 #endif
 };
@@ -165,6 +170,19 @@ void __init lpc32xx_serial_init(void)
 
 		/* pre-UART clock divider set to 1 */
 		__raw_writel(0x0101, uartinit_data[i].pdiv_clk_reg);
+
+		/*
+		 * Force a flush of the RX FIFOs to work around a
+		 * HW bug
+		 */
+		puart = uartinit_data[i].mapbase;
+		__raw_writel(0xC1, LPC32XX_UART_IIR_FCR(puart));
+		__raw_writel(0x00, LPC32XX_UART_DLL_FIFO(puart));
+		j = LPC32XX_SUART_FIFO_SIZE;
+		while (j--)
+			tmp = __raw_readl(
+				LPC32XX_UART_DLL_FIFO(puart));
+		__raw_writel(0, LPC32XX_UART_IIR_FCR(puart));
 	}
 
 	/* This needs to be done after all UART clocks are setup */
