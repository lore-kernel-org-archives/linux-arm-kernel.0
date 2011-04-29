From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 29 Apr 2011 14:59:21 +1200
Subject: [PATCH v3 12/23] at91: Make UART devices common
In-Reply-To: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
References: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1304045972-19319-13-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the individual UART, including debug UART, code for each at91
variiant with a single implementation in devices.c

The original code used the interrupt numbers for the UARTs as unique
identifiers. Because the interrupt numbers differ between the AT91
variants we introduce a new enum for the UART ids. The AT91_UARTx
names are already used by the early UART code as the base address of
the UART, so we cannot use those names. Instead we introduce
AT91_UART_DBGU and AT91_UART_USx.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/at572d940hf_devices.c  |  267 +++--------------
 arch/arm/mach-at91/at91cap9_devices.c     |  285 ++++---------------
 arch/arm/mach-at91/at91rm9200_devices.c   |  358 +++++------------------
 arch/arm/mach-at91/at91sam9260_devices.c  |  449 ++++++-----------------------
 arch/arm/mach-at91/at91sam9261_devices.c  |  273 ++++--------------
 arch/arm/mach-at91/at91sam9263_devices.c  |  286 ++++---------------
 arch/arm/mach-at91/at91sam9g45_devices.c  |  348 +++++------------------
 arch/arm/mach-at91/at91sam9rl_devices.c   |  360 +++++------------------
 arch/arm/mach-at91/board-1arm.c           |    4 +-
 arch/arm/mach-at91/board-afeb-9260v1.c    |    4 +-
 arch/arm/mach-at91/board-at572d940hf_ek.c |    6 +-
 arch/arm/mach-at91/board-carmeva.c        |    2 +-
 arch/arm/mach-at91/board-cpu9krea.c       |   12 +-
 arch/arm/mach-at91/board-cpuat91.c        |    8 +-
 arch/arm/mach-at91/board-eb9200.c         |    4 +-
 arch/arm/mach-at91/board-ecbat91.c        |    2 +-
 arch/arm/mach-at91/board-foxg20.c         |   12 +-
 arch/arm/mach-at91/board-gsia18s.c        |   10 +-
 arch/arm/mach-at91/board-kafa.c           |    2 +-
 arch/arm/mach-at91/board-kb9202.c         |    6 +-
 arch/arm/mach-at91/board-neocore926.c     |    2 +-
 arch/arm/mach-at91/board-pcontrol-g20.c   |    6 +-
 arch/arm/mach-at91/board-picotux200.c     |    2 +-
 arch/arm/mach-at91/board-qil-a9260.c      |    6 +-
 arch/arm/mach-at91/board-rm9200dk.c       |    2 +-
 arch/arm/mach-at91/board-rm9200ek.c       |    2 +-
 arch/arm/mach-at91/board-sam9-l9260.c     |    4 +-
 arch/arm/mach-at91/board-sam9260ek.c      |    4 +-
 arch/arm/mach-at91/board-sam9263ek.c      |    2 +-
 arch/arm/mach-at91/board-sam9g20ek.c      |    4 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c   |    2 +-
 arch/arm/mach-at91/board-sam9rlek.c       |    2 +-
 arch/arm/mach-at91/board-snapper9260.c    |    6 +-
 arch/arm/mach-at91/board-stamp9g20.c      |   12 +-
 arch/arm/mach-at91/board-yl-9200.c        |    6 +-
 arch/arm/mach-at91/devices.c              |  300 +++++++++++++++++++
 arch/arm/mach-at91/devices.h              |   17 ++
 arch/arm/mach-at91/include/mach/board.h   |   10 +
 38 files changed, 919 insertions(+), 2168 deletions(-)

diff --git a/arch/arm/mach-at91/at572d940hf_devices.c b/arch/arm/mach-at91/at572d940hf_devices.c
index 9220201..9910fc8 100644
--- a/arch/arm/mach-at91/at572d940hf_devices.c
+++ b/arch/arm/mach-at91/at572d940hf_devices.c
@@ -195,238 +195,61 @@ static struct at91_dev_table_rtt device_rtt __initdata = {
  *  UART
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_SERIAL_ATMEL)
-static struct resource dbgu_resources[] = {
-	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
-		.flags	= IORESOURCE_MEM,
+static struct at91_dev_table_uart device_dbgu __initdata = {
+	.mmio_base	= AT91_VA_BASE_SYS + AT91_DBGU,
+	.irq		= AT91_ID_SYS,
+	.clock_asc	= "mck",
+	.uart_data	= {
+		.use_dma_tx	= 0,
+		.use_dma_rx	= 0,
+		.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
 	},
-	[1] = {
-		.start	= AT91_ID_SYS,
-		.end	= AT91_ID_SYS,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data dbgu_data = {
-	.use_dma_tx	= 0,
-	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
-};
-
-static u64 dbgu_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at572d940hf_dbgu_device = {
-	.name		= "atmel_usart",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &dbgu_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &dbgu_data,
-	},
-	.resource	= dbgu_resources,
-	.num_resources	= ARRAY_SIZE(dbgu_resources),
-};
-
-static inline void configure_dbgu_pins(void)
-{
-	at91_set_A_periph(AT91_PIN_PC31, 1);		/* DTXD */
-	at91_set_A_periph(AT91_PIN_PC30, 0);		/* DRXD */
-}
-
-static struct resource uart0_resources[] = {
-	[0] = {
-		.start	= AT572D940HF_BASE_US0,
-		.end	= AT572D940HF_BASE_US0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT572D940HF_ID_US0,
-		.end	= AT572D940HF_ID_US0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart0_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
+	.tx_pin		= {AT91_PIN_PC31, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PC30, AT91_PIN_PERIPH_A, 0, 0, 0},
 };
 
-static u64 uart0_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at572d940hf_uart0_device = {
-	.name		= "atmel_usart",
-	.id		= 1,
-	.dev		= {
-				.dma_mask		= &uart0_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart0_data,
+static struct at91_dev_table_uart device_uart0 __initdata = {
+	.mmio_base	= AT572D940HF_BASE_US0,
+	.irq		= AT572D940HF_ID_US0,
+	.clock_asc	= "usart0_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
 	},
-	.resource	= uart0_resources,
-	.num_resources	= ARRAY_SIZE(uart0_resources),
+	.tx_pin		= {AT91_PIN_PA8,  AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PA7,  AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PA10, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PA9,  AT91_PIN_PERIPH_A, 0, 0, 0},
 };
 
-static inline void configure_usart0_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PA8, 1);		/* TXD0 */
-	at91_set_A_periph(AT91_PIN_PA7, 0);		/* RXD0 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_A_periph(AT91_PIN_PA10, 0);	/* RTS0 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_A_periph(AT91_PIN_PA9, 0);	/* CTS0 */
-}
-
-static struct resource uart1_resources[] = {
-	[0] = {
-		.start	= AT572D940HF_BASE_US1,
-		.end	= AT572D940HF_BASE_US1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT572D940HF_ID_US1,
-		.end	= AT572D940HF_ID_US1,
-		.flags	= IORESOURCE_IRQ,
+static struct at91_dev_table_uart device_uart1 __initdata = {
+	.mmio_base	= AT572D940HF_BASE_US1,
+	.irq		= AT572D940HF_ID_US1,
+	.clock_asc	= "usart1_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
 	},
+	.tx_pin		= {AT91_PIN_PC10, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PC9,  AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PA12, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PA11, AT91_PIN_PERIPH_A, 0, 0, 0},
 };
 
-static struct atmel_uart_data uart1_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart1_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at572d940hf_uart1_device = {
-	.name		= "atmel_usart",
-	.id		= 2,
-	.dev		= {
-				.dma_mask		= &uart1_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart1_data,
+static struct at91_dev_table_uart device_uart2 __initdata = {
+	.mmio_base	= AT572D940HF_BASE_US2,
+	.irq		= AT572D940HF_ID_US2,
+	.clock_asc	= "usart2_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
 	},
-	.resource	= uart1_resources,
-	.num_resources	= ARRAY_SIZE(uart1_resources),
+	.tx_pin		= {AT91_PIN_PC15, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PC14,  AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PA17, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PA16, AT91_PIN_PERIPH_A, 0, 0, 0},
 };
 
-static inline void configure_usart1_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PC10, 1);		/* TXD1 */
-	at91_set_A_periph(AT91_PIN_PC9 , 0);		/* RXD1 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_A_periph(AT91_PIN_PC12, 0);	/* RTS1 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_A_periph(AT91_PIN_PC11, 0);	/* CTS1 */
-}
-
-static struct resource uart2_resources[] = {
-	[0] = {
-		.start	= AT572D940HF_BASE_US2,
-		.end	= AT572D940HF_BASE_US2 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT572D940HF_ID_US2,
-		.end	= AT572D940HF_ID_US2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart2_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart2_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at572d940hf_uart2_device = {
-	.name		= "atmel_usart",
-	.id		= 3,
-	.dev		= {
-				.dma_mask		= &uart2_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart2_data,
-	},
-	.resource	= uart2_resources,
-	.num_resources	= ARRAY_SIZE(uart2_resources),
-};
-
-static inline void configure_usart2_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PC15, 1);		/* TXD2 */
-	at91_set_A_periph(AT91_PIN_PC14, 0);		/* RXD2 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_A_periph(AT91_PIN_PC17, 0);	/* RTS2 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_A_periph(AT91_PIN_PC16, 0);	/* CTS2 */
-}
-
-static struct platform_device *__initdata at91_uarts[ATMEL_MAX_UART];	/* the UARTs to use */
-struct platform_device *atmel_default_console_device;	/* the serial console device */
-
-void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
-{
-	struct platform_device *pdev;
-
-	switch (id) {
-		case 0:		/* DBGU */
-			pdev = &at572d940hf_dbgu_device;
-			configure_dbgu_pins();
-			at91_clock_associate("mck", &pdev->dev, "usart");
-			break;
-		case AT572D940HF_ID_US0:
-			pdev = &at572d940hf_uart0_device;
-			configure_usart0_pins(pins);
-			at91_clock_associate("usart0_clk", &pdev->dev, "usart");
-			break;
-		case AT572D940HF_ID_US1:
-			pdev = &at572d940hf_uart1_device;
-			configure_usart1_pins(pins);
-			at91_clock_associate("usart1_clk", &pdev->dev, "usart");
-			break;
-		case AT572D940HF_ID_US2:
-			pdev = &at572d940hf_uart2_device;
-			configure_usart2_pins(pins);
-			at91_clock_associate("usart2_clk", &pdev->dev, "usart");
-			break;
-		default:
-			return;
-	}
-	pdev->id = portnr;		/* update to mapped ID */
-
-	if (portnr < ATMEL_MAX_UART)
-		at91_uarts[portnr] = pdev;
-}
-
-void __init at91_set_serial_console(unsigned portnr)
-{
-	if (portnr < ATMEL_MAX_UART)
-		atmel_default_console_device = at91_uarts[portnr];
-}
-
-void __init at91_add_device_serial(void)
-{
-	int i;
-
-	for (i = 0; i < ATMEL_MAX_UART; i++) {
-		if (at91_uarts[i])
-			platform_device_register(at91_uarts[i]);
-	}
-
-	if (!atmel_default_console_device)
-		printk(KERN_INFO "AT91: No default serial console defined.\n");
-}
-
-#else
-void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins) {}
-void __init at91_set_serial_console(unsigned portnr) {}
-void __init at91_add_device_serial(void) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  mAgic
  * -------------------------------------------------------------------- */
@@ -512,6 +335,10 @@ static struct at91_device_table at572d940hf_device_table __initdata = {
 	.spi[1]		= &device_spi1,
 	.tcb[0]		= &device_tcb,
 	.rtt[0]		= &device_rtt,
+	.dbgu		= &device_dbgu,
+	.uart[0]	= &device_uart0,
+	.uart[1]	= &device_uart1,
+	.uart[2]	= &device_uart2,
 };
 
 void __init at572d940hf_init_devices(void)
diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index dce861c..754a562 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -609,236 +609,61 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
  *  UART
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_SERIAL_ATMEL)
-static struct resource dbgu_resources[] = {
-	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91_ID_SYS,
-		.end	= AT91_ID_SYS,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data dbgu_data = {
-	.use_dma_tx	= 0,
-	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
-};
-
-static u64 dbgu_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91cap9_dbgu_device = {
-	.name		= "atmel_usart",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &dbgu_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &dbgu_data,
-	},
-	.resource	= dbgu_resources,
-	.num_resources	= ARRAY_SIZE(dbgu_resources),
-};
-
-static inline void configure_dbgu_pins(void)
-{
-	at91_set_A_periph(AT91_PIN_PC30, 0);		/* DRXD */
-	at91_set_A_periph(AT91_PIN_PC31, 1);		/* DTXD */
-}
-
-static struct resource uart0_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_US0,
-		.end	= AT91CAP9_BASE_US0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_US0,
-		.end	= AT91CAP9_ID_US0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart0_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
+static struct at91_dev_table_uart device_dbgu __initdata = {
+	.mmio_base	= AT91_VA_BASE_SYS + AT91_DBGU,
+	.irq		= AT91_ID_SYS,
+	.clock_asc	= "mck",
+	.uart_data	= {
+		.use_dma_tx	= 0,
+		.use_dma_rx	= 0,
+		.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
+	},
+	.tx_pin		= {AT91_PIN_PC31, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PC30, AT91_PIN_PERIPH_A, 0, 0, 0},
+};
+
+static struct at91_dev_table_uart device_uart0 __initdata = {
+	.mmio_base	= AT91CAP9_BASE_US0,
+	.irq		= AT91CAP9_ID_US0,
+	.clock_asc	= "usart0_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
+	},
+	.tx_pin		= {AT91_PIN_PA22, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PA23, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PA24, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PA25, AT91_PIN_PERIPH_A, 0, 0, 0},
+};
+
+static struct at91_dev_table_uart device_uart1 __initdata = {
+	.mmio_base	= AT91CAP9_BASE_US1,
+	.irq		= AT91CAP9_ID_US1,
+	.clock_asc	= "usart1_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
+	},
+	.tx_pin		= {AT91_PIN_PD0, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PD1, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PD7, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PD8, AT91_PIN_PERIPH_A, 0, 0, 0},
+};
+
+static struct at91_dev_table_uart device_uart2 __initdata = {
+	.mmio_base	= AT91CAP9_BASE_US2,
+	.irq		= AT91CAP9_ID_US2,
+	.clock_asc	= "usart2_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
+	},
+	.tx_pin		= {AT91_PIN_PD2, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PD3, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PD5, AT91_PIN_PERIPH_B, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PD6, AT91_PIN_PERIPH_B, 0, 0, 0},
 };
 
-static u64 uart0_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91cap9_uart0_device = {
-	.name		= "atmel_usart",
-	.id		= 1,
-	.dev		= {
-				.dma_mask		= &uart0_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart0_data,
-	},
-	.resource	= uart0_resources,
-	.num_resources	= ARRAY_SIZE(uart0_resources),
-};
-
-static inline void configure_usart0_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PA22, 1);		/* TXD0 */
-	at91_set_A_periph(AT91_PIN_PA23, 0);		/* RXD0 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_A_periph(AT91_PIN_PA24, 0);	/* RTS0 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_A_periph(AT91_PIN_PA25, 0);	/* CTS0 */
-}
-
-static struct resource uart1_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_US1,
-		.end	= AT91CAP9_BASE_US1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_US1,
-		.end	= AT91CAP9_ID_US1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart1_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart1_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91cap9_uart1_device = {
-	.name		= "atmel_usart",
-	.id		= 2,
-	.dev		= {
-				.dma_mask		= &uart1_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart1_data,
-	},
-	.resource	= uart1_resources,
-	.num_resources	= ARRAY_SIZE(uart1_resources),
-};
-
-static inline void configure_usart1_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PD0, 1);		/* TXD1 */
-	at91_set_A_periph(AT91_PIN_PD1, 0);		/* RXD1 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_B_periph(AT91_PIN_PD7, 0);	/* RTS1 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_B_periph(AT91_PIN_PD8, 0);	/* CTS1 */
-}
-
-static struct resource uart2_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_US2,
-		.end	= AT91CAP9_BASE_US2 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_US2,
-		.end	= AT91CAP9_ID_US2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart2_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart2_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91cap9_uart2_device = {
-	.name		= "atmel_usart",
-	.id		= 3,
-	.dev		= {
-				.dma_mask		= &uart2_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart2_data,
-	},
-	.resource	= uart2_resources,
-	.num_resources	= ARRAY_SIZE(uart2_resources),
-};
-
-static inline void configure_usart2_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PD2, 1);		/* TXD2 */
-	at91_set_A_periph(AT91_PIN_PD3, 0);		/* RXD2 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_B_periph(AT91_PIN_PD5, 0);	/* RTS2 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_B_periph(AT91_PIN_PD6, 0);	/* CTS2 */
-}
-
-static struct platform_device *__initdata at91_uarts[ATMEL_MAX_UART];	/* the UARTs to use */
-struct platform_device *atmel_default_console_device;	/* the serial console device */
-
-void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
-{
-	struct platform_device *pdev;
-
-	switch (id) {
-		case 0:		/* DBGU */
-			pdev = &at91cap9_dbgu_device;
-			configure_dbgu_pins();
-			at91_clock_associate("mck", &pdev->dev, "usart");
-			break;
-		case AT91CAP9_ID_US0:
-			pdev = &at91cap9_uart0_device;
-			configure_usart0_pins(pins);
-			at91_clock_associate("usart0_clk", &pdev->dev, "usart");
-			break;
-		case AT91CAP9_ID_US1:
-			pdev = &at91cap9_uart1_device;
-			configure_usart1_pins(pins);
-			at91_clock_associate("usart1_clk", &pdev->dev, "usart");
-			break;
-		case AT91CAP9_ID_US2:
-			pdev = &at91cap9_uart2_device;
-			configure_usart2_pins(pins);
-			at91_clock_associate("usart2_clk", &pdev->dev, "usart");
-			break;
-		default:
-			return;
-	}
-	pdev->id = portnr;		/* update to mapped ID */
-
-	if (portnr < ATMEL_MAX_UART)
-		at91_uarts[portnr] = pdev;
-}
-
-void __init at91_set_serial_console(unsigned portnr)
-{
-	if (portnr < ATMEL_MAX_UART)
-		atmel_default_console_device = at91_uarts[portnr];
-}
-
-void __init at91_add_device_serial(void)
-{
-	int i;
-
-	for (i = 0; i < ATMEL_MAX_UART; i++) {
-		if (at91_uarts[i])
-			platform_device_register(at91_uarts[i]);
-	}
-
-	if (!atmel_default_console_device)
-		printk(KERN_INFO "AT91: No default serial console defined.\n");
-}
-#else
-void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins) {}
-void __init at91_set_serial_console(unsigned portnr) {}
-void __init at91_add_device_serial(void) {}
-#endif
-
 static struct at91_device_table at91cap9_device_table __initdata = {
 	.ethernet	= &device_eth,
 	.usbh_ohci	= &device_usbh_ohci,
@@ -850,6 +675,10 @@ static struct at91_device_table at91cap9_device_table __initdata = {
 	.spi[1]		= &device_spi1,
 	.tcb[0]		= &device_tcb,
 	.rtt[0]		= &device_rtt,
+	.dbgu		= &device_dbgu,
+	.uart[0]	= &device_uart0,
+	.uart[1]	= &device_uart1,
+	.uart[2]	= &device_uart2,
 };
 
 void __init at91cap9_init_devices(void)
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 6cec253..3a783f4 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -472,299 +472,84 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
  *  UART
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_SERIAL_ATMEL)
-static struct resource dbgu_resources[] = {
-	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91_ID_SYS,
-		.end	= AT91_ID_SYS,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data dbgu_data = {
-	.use_dma_tx	= 0,
-	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
-};
-
-static u64 dbgu_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91rm9200_dbgu_device = {
-	.name		= "atmel_usart",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &dbgu_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &dbgu_data,
+static struct at91_dev_table_uart device_dbgu __initdata = {
+	.mmio_base	= AT91_VA_BASE_SYS + AT91_DBGU,
+	.irq		= AT91_ID_SYS,
+	.clock_asc	= "mck",
+	.uart_data	= {
+		.use_dma_tx	= 0,
+		.use_dma_rx	= 0,
+		.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
 	},
-	.resource	= dbgu_resources,
-	.num_resources	= ARRAY_SIZE(dbgu_resources),
+	.tx_pin		= {AT91_PIN_PC31, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PC30, AT91_PIN_PERIPH_A, 0, 0, 0},
 };
 
-static inline void configure_dbgu_pins(void)
-{
-	at91_set_A_periph(AT91_PIN_PA30, 0);		/* DRXD */
-	at91_set_A_periph(AT91_PIN_PA31, 1);		/* DTXD */
-}
-
-static struct resource uart0_resources[] = {
-	[0] = {
-		.start	= AT91RM9200_BASE_US0,
-		.end	= AT91RM9200_BASE_US0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91RM9200_ID_US0,
-		.end	= AT91RM9200_ID_US0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart0_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart0_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91rm9200_uart0_device = {
-	.name		= "atmel_usart",
-	.id		= 1,
-	.dev		= {
-				.dma_mask		= &uart0_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart0_data,
+static struct at91_dev_table_uart device_uart0 __initdata = {
+	.mmio_base	= AT91RM9200_BASE_US0,
+	.irq		= AT91RM9200_ID_US0,
+	.clock_asc	= "usart0_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
 	},
-	.resource	= uart0_resources,
-	.num_resources	= ARRAY_SIZE(uart0_resources),
-};
-
-static inline void configure_usart0_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PA17, 1);		/* TXD0 */
-	at91_set_A_periph(AT91_PIN_PA18, 0);		/* RXD0 */
-
-	if (pins & ATMEL_UART_CTS)
-		at91_set_A_periph(AT91_PIN_PA20, 0);	/* CTS0 */
-
-	if (pins & ATMEL_UART_RTS) {
-		/*
-		 * AT91RM9200 Errata #39 - RTS0 is not internally connected to PA21.
-		 *  We need to drive the pin manually.  Default is off (RTS is active low).
-		 */
-		at91_set_gpio_output(AT91_PIN_PA21, 1);
-	}
-}
-
-static struct resource uart1_resources[] = {
-	[0] = {
-		.start	= AT91RM9200_BASE_US1,
-		.end	= AT91RM9200_BASE_US1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91RM9200_ID_US1,
-		.end	= AT91RM9200_ID_US1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart1_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart1_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91rm9200_uart1_device = {
-	.name		= "atmel_usart",
-	.id		= 2,
-	.dev		= {
-				.dma_mask		= &uart1_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart1_data,
-	},
-	.resource	= uart1_resources,
-	.num_resources	= ARRAY_SIZE(uart1_resources),
-};
-
-static inline void configure_usart1_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PB20, 1);		/* TXD1 */
-	at91_set_A_periph(AT91_PIN_PB21, 0);		/* RXD1 */
-
-	if (pins & ATMEL_UART_RI)
-		at91_set_A_periph(AT91_PIN_PB18, 0);	/* RI1 */
-	if (pins & ATMEL_UART_DTR)
-		at91_set_A_periph(AT91_PIN_PB19, 0);	/* DTR1 */
-	if (pins & ATMEL_UART_DCD)
-		at91_set_A_periph(AT91_PIN_PB23, 0);	/* DCD1 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_A_periph(AT91_PIN_PB24, 0);	/* CTS1 */
-	if (pins & ATMEL_UART_DSR)
-		at91_set_A_periph(AT91_PIN_PB25, 0);	/* DSR1 */
-	if (pins & ATMEL_UART_RTS)
-		at91_set_A_periph(AT91_PIN_PB26, 0);	/* RTS1 */
-}
-
-static struct resource uart2_resources[] = {
-	[0] = {
-		.start	= AT91RM9200_BASE_US2,
-		.end	= AT91RM9200_BASE_US2 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91RM9200_ID_US2,
-		.end	= AT91RM9200_ID_US2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart2_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart2_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91rm9200_uart2_device = {
-	.name		= "atmel_usart",
-	.id		= 3,
-	.dev		= {
-				.dma_mask		= &uart2_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart2_data,
-	},
-	.resource	= uart2_resources,
-	.num_resources	= ARRAY_SIZE(uart2_resources),
-};
-
-static inline void configure_usart2_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PA22, 0);		/* RXD2 */
-	at91_set_A_periph(AT91_PIN_PA23, 1);		/* TXD2 */
-
-	if (pins & ATMEL_UART_CTS)
-		at91_set_B_periph(AT91_PIN_PA30, 0);	/* CTS2 */
-	if (pins & ATMEL_UART_RTS)
-		at91_set_B_periph(AT91_PIN_PA31, 0);	/* RTS2 */
-}
-
-static struct resource uart3_resources[] = {
-	[0] = {
-		.start	= AT91RM9200_BASE_US3,
-		.end	= AT91RM9200_BASE_US3 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
+	.tx_pin		= {AT91_PIN_PA17, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PA18, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PA20, AT91_PIN_PERIPH_A, 0, 0, 0},
+	/*
+	 * AT91RM9200 Errata #39 - RTS0 is not internally connected to PA21.
+	 * We need to drive the pin manually.  Default is off (RTS is active
+	 * low).
+	 */	
+	.cts_pin	= {AT91_PIN_PA21, AT91_PIN_PERIPH_A, 1, 0, 0},
+};
+
+static struct at91_dev_table_uart device_uart1 __initdata = {
+	.mmio_base	= AT91RM9200_BASE_US1,
+	.irq		= AT91RM9200_ID_US1,
+	.clock_asc	= "usart1_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
 	},
-	[1] = {
-		.start	= AT91RM9200_ID_US3,
-		.end	= AT91RM9200_ID_US3,
-		.flags	= IORESOURCE_IRQ,
+	.tx_pin		= {AT91_PIN_PA20, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PA21, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PB26, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PA24, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.ri_pin		= {AT91_PIN_PB18, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.dtr_pin	= {AT91_PIN_PB19, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.dcd_pin	= {AT91_PIN_PB23, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.dsr_pin	= {AT91_PIN_PB25, AT91_PIN_PERIPH_A, 0, 0, 0},
+};
+
+static struct at91_dev_table_uart device_uart2 __initdata = {
+	.mmio_base	= AT91RM9200_BASE_US2,
+	.irq		= AT91RM9200_ID_US2,
+	.clock_asc	= "usart2_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
 	},
-};
-
-static struct atmel_uart_data uart3_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart3_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91rm9200_uart3_device = {
-	.name		= "atmel_usart",
-	.id		= 4,
-	.dev		= {
-				.dma_mask		= &uart3_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart3_data,
+	.tx_pin		= {AT91_PIN_PA23, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PA22, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PB31, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PA30, AT91_PIN_PERIPH_A, 0, 0, 0},
+};
+
+static struct at91_dev_table_uart device_uart3 __initdata = {
+	.mmio_base	= AT91RM9200_BASE_US3,
+	.irq		= AT91RM9200_ID_US3,
+	.clock_asc	= "usart3_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
 	},
-	.resource	= uart3_resources,
-	.num_resources	= ARRAY_SIZE(uart3_resources),
+	.tx_pin		= {AT91_PIN_PA5, AT91_PIN_PERIPH_B, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PA6, AT91_PIN_PERIPH_B, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PB1, AT91_PIN_PERIPH_B, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PB0, AT91_PIN_PERIPH_B, 0, 0, 0},
 };
 
-static inline void configure_usart3_pins(unsigned pins)
-{
-	at91_set_B_periph(AT91_PIN_PA5, 1);		/* TXD3 */
-	at91_set_B_periph(AT91_PIN_PA6, 0);		/* RXD3 */
-
-	if (pins & ATMEL_UART_CTS)
-		at91_set_B_periph(AT91_PIN_PB1, 0);	/* CTS3 */
-	if (pins & ATMEL_UART_RTS)
-		at91_set_B_periph(AT91_PIN_PB0, 0);	/* RTS3 */
-}
-
-static struct platform_device *__initdata at91_uarts[ATMEL_MAX_UART];	/* the UARTs to use */
-struct platform_device *atmel_default_console_device;	/* the serial console device */
-
-void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
-{
-	struct platform_device *pdev;
-
-	switch (id) {
-		case 0:		/* DBGU */
-			pdev = &at91rm9200_dbgu_device;
-			configure_dbgu_pins();
-			at91_clock_associate("mck", &pdev->dev, "usart");
-			break;
-		case AT91RM9200_ID_US0:
-			pdev = &at91rm9200_uart0_device;
-			configure_usart0_pins(pins);
-			at91_clock_associate("usart0_clk", &pdev->dev, "usart");
-			break;
-		case AT91RM9200_ID_US1:
-			pdev = &at91rm9200_uart1_device;
-			configure_usart1_pins(pins);
-			at91_clock_associate("usart1_clk", &pdev->dev, "usart");
-			break;
-		case AT91RM9200_ID_US2:
-			pdev = &at91rm9200_uart2_device;
-			configure_usart2_pins(pins);
-			at91_clock_associate("usart2_clk", &pdev->dev, "usart");
-			break;
-		case AT91RM9200_ID_US3:
-			pdev = &at91rm9200_uart3_device;
-			configure_usart3_pins(pins);
-			at91_clock_associate("usart3_clk", &pdev->dev, "usart");
-			break;
-		default:
-			return;
-	}
-	pdev->id = portnr;		/* update to mapped ID */
-
-	if (portnr < ATMEL_MAX_UART)
-		at91_uarts[portnr] = pdev;
-}
-
-void __init at91_set_serial_console(unsigned portnr)
-{
-	if (portnr < ATMEL_MAX_UART)
-		atmel_default_console_device = at91_uarts[portnr];
-}
-
-void __init at91_add_device_serial(void)
-{
-	int i;
-
-	for (i = 0; i < ATMEL_MAX_UART; i++) {
-		if (at91_uarts[i])
-			platform_device_register(at91_uarts[i]);
-	}
-
-	if (!atmel_default_console_device)
-		printk(KERN_INFO "AT91: No default serial console defined.\n");
-}
-#else
-void __init __deprecated at91_init_serial(struct at91_uart_config *config) {}
-void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins) {}
-void __init at91_set_serial_console(unsigned portnr) {}
-void __init at91_add_device_serial(void) {}
-#endif
-
 static struct at91_device_table at91rm9200_device_table __initdata = {
 	.ethernet	= &device_eth,
 	.usbh_ohci	= &device_usbh_ohci,
@@ -775,6 +560,11 @@ static struct at91_device_table at91rm9200_device_table __initdata = {
 	.spi[0]		= &device_spi,
 	.tcb[0]		= &device_tcb0,
 	.tcb[1]		= &device_tcb1,
+	.dbgu		= &device_dbgu,
+	.uart[0]	= &device_uart0,
+	.uart[1]	= &device_uart1,
+	.uart[2]	= &device_uart2,
+	.uart[3]	= &device_uart3,
 };
 
 void __init at91rm9200_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 8f1f866..0759be2 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -278,378 +278,104 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 /* --------------------------------------------------------------------
  *  UART
  * -------------------------------------------------------------------- */
-#if defined(CONFIG_SERIAL_ATMEL)
-static struct resource dbgu_resources[] = {
-	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91_ID_SYS,
-		.end	= AT91_ID_SYS,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data dbgu_data = {
-	.use_dma_tx	= 0,
-	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
-};
 
-static u64 dbgu_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9260_dbgu_device = {
-	.name		= "atmel_usart",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &dbgu_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &dbgu_data,
+static struct at91_dev_table_uart device_dbgu __initdata = {
+	.mmio_base	= AT91_VA_BASE_SYS + AT91_DBGU,
+	.irq		= AT91_ID_SYS,
+	.clock_asc	= "mck",
+	.uart_data	= {
+		.use_dma_tx	= 0,
+		.use_dma_rx	= 0,
+		.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
 	},
-	.resource	= dbgu_resources,
-	.num_resources	= ARRAY_SIZE(dbgu_resources),
+	.tx_pin		= {AT91_PIN_PB15, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PB14, AT91_PIN_PERIPH_A, 0, 0, 0},
 };
 
-static inline void configure_dbgu_pins(void)
-{
-	at91_set_A_periph(AT91_PIN_PB14, 0);		/* DRXD */
-	at91_set_A_periph(AT91_PIN_PB15, 1);		/* DTXD */
-}
-
-static struct resource uart0_resources[] = {
-	[0] = {
-		.start	= AT91SAM9260_BASE_US0,
-		.end	= AT91SAM9260_BASE_US0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
+static struct at91_dev_table_uart device_uart0 __initdata = {
+	.mmio_base	= AT91SAM9260_BASE_US0,
+	.irq		= AT91SAM9260_ID_US0,
+	.clock_asc	= "usart0_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
 	},
-	[1] = {
-		.start	= AT91SAM9260_ID_US0,
-		.end	= AT91SAM9260_ID_US0,
-		.flags	= IORESOURCE_IRQ,
+	.tx_pin		= {AT91_PIN_PB4,  AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PB5,  AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PB26, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PB27, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.dtr_pin	= {AT91_PIN_PB24, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.dsr_pin	= {AT91_PIN_PB22, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.dcd_pin	= {AT91_PIN_PB23, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.ri_pin		= {AT91_PIN_PB25, AT91_PIN_PERIPH_A, 0, 0, 0},
+};
+
+static struct at91_dev_table_uart device_uart1 __initdata = {
+	.mmio_base	= AT91SAM9260_BASE_US1,
+	.irq		= AT91SAM9260_ID_US1,
+	.clock_asc	= "usart1_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
 	},
-};
-
-static struct atmel_uart_data uart0_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart0_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9260_uart0_device = {
-	.name		= "atmel_usart",
-	.id		= 1,
-	.dev		= {
-				.dma_mask		= &uart0_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart0_data,
+	.tx_pin		= {AT91_PIN_PB6,  AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PB7,  AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PB28, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PB29, AT91_PIN_PERIPH_A, 0, 0, 0},
+};
+
+static struct at91_dev_table_uart device_uart2 __initdata = {
+	.mmio_base	= AT91SAM9260_BASE_US2,
+	.irq		= AT91SAM9260_ID_US2,
+	.clock_asc	= "usart2_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
 	},
-	.resource	= uart0_resources,
-	.num_resources	= ARRAY_SIZE(uart0_resources),
-};
-
-static inline void configure_usart0_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PB4, 1);		/* TXD0 */
-	at91_set_A_periph(AT91_PIN_PB5, 0);		/* RXD0 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_A_periph(AT91_PIN_PB26, 0);	/* RTS0 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_A_periph(AT91_PIN_PB27, 0);	/* CTS0 */
-	if (pins & ATMEL_UART_DTR)
-		at91_set_A_periph(AT91_PIN_PB24, 0);	/* DTR0 */
-	if (pins & ATMEL_UART_DSR)
-		at91_set_A_periph(AT91_PIN_PB22, 0);	/* DSR0 */
-	if (pins & ATMEL_UART_DCD)
-		at91_set_A_periph(AT91_PIN_PB23, 0);	/* DCD0 */
-	if (pins & ATMEL_UART_RI)
-		at91_set_A_periph(AT91_PIN_PB25, 0);	/* RI0 */
-}
-
-static struct resource uart1_resources[] = {
-	[0] = {
-		.start	= AT91SAM9260_BASE_US1,
-		.end	= AT91SAM9260_BASE_US1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
+	.tx_pin		= {AT91_PIN_PB8, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PB9, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PA4, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PA5, AT91_PIN_PERIPH_A, 0, 0, 0},
+};
+
+static struct at91_dev_table_uart device_uart3 __initdata = {
+	.mmio_base	= AT91SAM9260_BASE_US3,
+	.irq		= AT91SAM9260_ID_US3,
+	.clock_asc	= "usart3_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
 	},
-	[1] = {
-		.start	= AT91SAM9260_ID_US1,
-		.end	= AT91SAM9260_ID_US1,
-		.flags	= IORESOURCE_IRQ,
+	.tx_pin		= {AT91_PIN_PB10, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PB11, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PC8,  AT91_PIN_PERIPH_B, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PC10, AT91_PIN_PERIPH_B, 0, 0, 0},
+};
+
+static struct at91_dev_table_uart device_uart4 __initdata = {
+	.mmio_base	= AT91SAM9260_BASE_US4,
+	.irq		= AT91SAM9260_ID_US4,
+	.clock_asc	= "usart4_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
 	},
+	.tx_pin		= {AT91_PIN_PA31, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PA30, AT91_PIN_PERIPH_A, 0, 0, 0},
 };
 
-static struct atmel_uart_data uart1_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart1_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9260_uart1_device = {
-	.name		= "atmel_usart",
-	.id		= 2,
-	.dev		= {
-				.dma_mask		= &uart1_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart1_data,
-	},
-	.resource	= uart1_resources,
-	.num_resources	= ARRAY_SIZE(uart1_resources),
-};
-
-static inline void configure_usart1_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PB6, 1);		/* TXD1 */
-	at91_set_A_periph(AT91_PIN_PB7, 0);		/* RXD1 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_A_periph(AT91_PIN_PB28, 0);	/* RTS1 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_A_periph(AT91_PIN_PB29, 0);	/* CTS1 */
-}
-
-static struct resource uart2_resources[] = {
-	[0] = {
-		.start	= AT91SAM9260_BASE_US2,
-		.end	= AT91SAM9260_BASE_US2 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9260_ID_US2,
-		.end	= AT91SAM9260_ID_US2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart2_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart2_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9260_uart2_device = {
-	.name		= "atmel_usart",
-	.id		= 3,
-	.dev		= {
-				.dma_mask		= &uart2_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart2_data,
+static struct at91_dev_table_uart device_uart5 __initdata = {
+	.mmio_base	= AT91SAM9260_BASE_US5,
+	.irq		= AT91SAM9260_ID_US5,
+	.clock_asc	= "usart5_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
 	},
-	.resource	= uart2_resources,
-	.num_resources	= ARRAY_SIZE(uart2_resources),
+	.tx_pin		= {AT91_PIN_PB12, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PB13, AT91_PIN_PERIPH_A, 0, 0, 0},
 };
 
-static inline void configure_usart2_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PB8, 1);		/* TXD2 */
-	at91_set_A_periph(AT91_PIN_PB9, 0);		/* RXD2 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_A_periph(AT91_PIN_PA4, 0);	/* RTS2 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_A_periph(AT91_PIN_PA5, 0);	/* CTS2 */
-}
-
-static struct resource uart3_resources[] = {
-	[0] = {
-		.start	= AT91SAM9260_BASE_US3,
-		.end	= AT91SAM9260_BASE_US3 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9260_ID_US3,
-		.end	= AT91SAM9260_ID_US3,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart3_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart3_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9260_uart3_device = {
-	.name		= "atmel_usart",
-	.id		= 4,
-	.dev		= {
-				.dma_mask		= &uart3_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart3_data,
-	},
-	.resource	= uart3_resources,
-	.num_resources	= ARRAY_SIZE(uart3_resources),
-};
-
-static inline void configure_usart3_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PB10, 1);		/* TXD3 */
-	at91_set_A_periph(AT91_PIN_PB11, 0);		/* RXD3 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_B_periph(AT91_PIN_PC8, 0);	/* RTS3 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_B_periph(AT91_PIN_PC10, 0);	/* CTS3 */
-}
-
-static struct resource uart4_resources[] = {
-	[0] = {
-		.start	= AT91SAM9260_BASE_US4,
-		.end	= AT91SAM9260_BASE_US4 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9260_ID_US4,
-		.end	= AT91SAM9260_ID_US4,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart4_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart4_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9260_uart4_device = {
-	.name		= "atmel_usart",
-	.id		= 5,
-	.dev		= {
-				.dma_mask		= &uart4_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart4_data,
-	},
-	.resource	= uart4_resources,
-	.num_resources	= ARRAY_SIZE(uart4_resources),
-};
-
-static inline void configure_usart4_pins(void)
-{
-	at91_set_B_periph(AT91_PIN_PA31, 1);		/* TXD4 */
-	at91_set_B_periph(AT91_PIN_PA30, 0);		/* RXD4 */
-}
-
-static struct resource uart5_resources[] = {
-	[0] = {
-		.start	= AT91SAM9260_BASE_US5,
-		.end	= AT91SAM9260_BASE_US5 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9260_ID_US5,
-		.end	= AT91SAM9260_ID_US5,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart5_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart5_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9260_uart5_device = {
-	.name		= "atmel_usart",
-	.id		= 6,
-	.dev		= {
-				.dma_mask		= &uart5_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart5_data,
-	},
-	.resource	= uart5_resources,
-	.num_resources	= ARRAY_SIZE(uart5_resources),
-};
-
-static inline void configure_usart5_pins(void)
-{
-	at91_set_A_periph(AT91_PIN_PB12, 1);		/* TXD5 */
-	at91_set_A_periph(AT91_PIN_PB13, 0);		/* RXD5 */
-}
-
-static struct platform_device *__initdata at91_uarts[ATMEL_MAX_UART];	/* the UARTs to use */
-struct platform_device *atmel_default_console_device;	/* the serial console device */
-
-void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
-{
-	struct platform_device *pdev;
-
-	switch (id) {
-		case 0:		/* DBGU */
-			pdev = &at91sam9260_dbgu_device;
-			configure_dbgu_pins();
-			at91_clock_associate("mck", &pdev->dev, "usart");
-			break;
-		case AT91SAM9260_ID_US0:
-			pdev = &at91sam9260_uart0_device;
-			configure_usart0_pins(pins);
-			at91_clock_associate("usart0_clk", &pdev->dev, "usart");
-			break;
-		case AT91SAM9260_ID_US1:
-			pdev = &at91sam9260_uart1_device;
-			configure_usart1_pins(pins);
-			at91_clock_associate("usart1_clk", &pdev->dev, "usart");
-			break;
-		case AT91SAM9260_ID_US2:
-			pdev = &at91sam9260_uart2_device;
-			configure_usart2_pins(pins);
-			at91_clock_associate("usart2_clk", &pdev->dev, "usart");
-			break;
-		case AT91SAM9260_ID_US3:
-			pdev = &at91sam9260_uart3_device;
-			configure_usart3_pins(pins);
-			at91_clock_associate("usart3_clk", &pdev->dev, "usart");
-			break;
-		case AT91SAM9260_ID_US4:
-			pdev = &at91sam9260_uart4_device;
-			configure_usart4_pins();
-			at91_clock_associate("usart4_clk", &pdev->dev, "usart");
-			break;
-		case AT91SAM9260_ID_US5:
-			pdev = &at91sam9260_uart5_device;
-			configure_usart5_pins();
-			at91_clock_associate("usart5_clk", &pdev->dev, "usart");
-			break;
-		default:
-			return;
-	}
-	pdev->id = portnr;		/* update to mapped ID */
-
-	if (portnr < ATMEL_MAX_UART)
-		at91_uarts[portnr] = pdev;
-}
-
-void __init at91_set_serial_console(unsigned portnr)
-{
-	if (portnr < ATMEL_MAX_UART)
-		atmel_default_console_device = at91_uarts[portnr];
-}
-
-void __init at91_add_device_serial(void)
-{
-	int i;
-
-	for (i = 0; i < ATMEL_MAX_UART; i++) {
-		if (at91_uarts[i])
-			platform_device_register(at91_uarts[i]);
-	}
-
-	if (!atmel_default_console_device)
-		printk(KERN_INFO "AT91: No default serial console defined.\n");
-}
-#else
-void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins) {}
-void __init at91_set_serial_console(unsigned portnr) {}
-void __init at91_add_device_serial(void) {}
-#endif
-
 /* --------------------------------------------------------------------
  *  CF/IDE
  * -------------------------------------------------------------------- */
@@ -779,6 +505,13 @@ static struct at91_device_table at91sam9260_device_table __initdata = {
 	.tcb[0]		= &device_tcb0,
 	.tcb[1]		= &device_tcb1,
 	.rtt[0]		= &device_rtt,
+	.dbgu		= &device_dbgu,
+	.uart[0]	= &device_uart0,
+	.uart[1]	= &device_uart1,
+	.uart[2]	= &device_uart2,
+	.uart[3]	= &device_uart3,
+	.uart[4]	= &device_uart4,
+	.uart[5]	= &device_uart5,
 };
 
 void __init at91sam9260_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index bc9f0c7..9e48f36 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -425,236 +425,61 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
  *  UART
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_SERIAL_ATMEL)
-static struct resource dbgu_resources[] = {
-	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91_ID_SYS,
-		.end	= AT91_ID_SYS,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data dbgu_data = {
-	.use_dma_tx	= 0,
-	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
-};
-
-static u64 dbgu_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9261_dbgu_device = {
-	.name		= "atmel_usart",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &dbgu_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &dbgu_data,
-	},
-	.resource	= dbgu_resources,
-	.num_resources	= ARRAY_SIZE(dbgu_resources),
-};
-
-static inline void configure_dbgu_pins(void)
-{
-	at91_set_A_periph(AT91_PIN_PA9, 0);		/* DRXD */
-	at91_set_A_periph(AT91_PIN_PA10, 1);		/* DTXD */
-}
-
-static struct resource uart0_resources[] = {
-	[0] = {
-		.start	= AT91SAM9261_BASE_US0,
-		.end	= AT91SAM9261_BASE_US0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9261_ID_US0,
-		.end	= AT91SAM9261_ID_US0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart0_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart0_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9261_uart0_device = {
-	.name		= "atmel_usart",
-	.id		= 1,
-	.dev		= {
-				.dma_mask		= &uart0_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart0_data,
-	},
-	.resource	= uart0_resources,
-	.num_resources	= ARRAY_SIZE(uart0_resources),
-};
-
-static inline void configure_usart0_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PC8, 1);		/* TXD0 */
-	at91_set_A_periph(AT91_PIN_PC9, 0);		/* RXD0 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_A_periph(AT91_PIN_PC10, 0);	/* RTS0 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_A_periph(AT91_PIN_PC11, 0);	/* CTS0 */
-}
-
-static struct resource uart1_resources[] = {
-	[0] = {
-		.start	= AT91SAM9261_BASE_US1,
-		.end	= AT91SAM9261_BASE_US1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9261_ID_US1,
-		.end	= AT91SAM9261_ID_US1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart1_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart1_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9261_uart1_device = {
-	.name		= "atmel_usart",
-	.id		= 2,
-	.dev		= {
-				.dma_mask		= &uart1_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart1_data,
+static struct at91_dev_table_uart device_dbgu __initdata = {
+	.mmio_base	= AT91_VA_BASE_SYS + AT91_DBGU,
+	.irq		= AT91_ID_SYS,
+	.clock_asc	= "mck",
+	.uart_data	= {
+		.use_dma_tx	= 0,
+		.use_dma_rx	= 0,
+		.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
 	},
-	.resource	= uart1_resources,
-	.num_resources	= ARRAY_SIZE(uart1_resources),
+	.tx_pin		= {AT91_PIN_PA10, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PA9,  AT91_PIN_PERIPH_A, 0, 0, 0},
 };
 
-static inline void configure_usart1_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PC12, 1);		/* TXD1 */
-	at91_set_A_periph(AT91_PIN_PC13, 0);		/* RXD1 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_B_periph(AT91_PIN_PA12, 0);	/* RTS1 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_B_periph(AT91_PIN_PA13, 0);	/* CTS1 */
-}
-
-static struct resource uart2_resources[] = {
-	[0] = {
-		.start	= AT91SAM9261_BASE_US2,
-		.end	= AT91SAM9261_BASE_US2 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
+static struct at91_dev_table_uart device_uart0 __initdata = {
+	.mmio_base	= AT91SAM9261_BASE_US0,
+	.irq		= AT91SAM9261_ID_US0,
+	.clock_asc	= "usart0_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
 	},
-	[1] = {
-		.start	= AT91SAM9261_ID_US2,
-		.end	= AT91SAM9261_ID_US2,
-		.flags	= IORESOURCE_IRQ,
+	.tx_pin		= {AT91_PIN_PC8,  AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PC9,  AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PC10, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PC11, AT91_PIN_PERIPH_A, 0, 0, 0},
+};
+
+static struct at91_dev_table_uart device_uart1 __initdata = {
+	.mmio_base	= AT91SAM9261_BASE_US1,
+	.irq		= AT91SAM9261_ID_US1,
+	.clock_asc	= "usart1_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
 	},
-};
-
-static struct atmel_uart_data uart2_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart2_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9261_uart2_device = {
-	.name		= "atmel_usart",
-	.id		= 3,
-	.dev		= {
-				.dma_mask		= &uart2_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart2_data,
+	.tx_pin		= {AT91_PIN_PC12, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PC13, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PA12, AT91_PIN_PERIPH_B, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PA13, AT91_PIN_PERIPH_B, 0, 0, 0},
+};
+
+static struct at91_dev_table_uart device_uart2 __initdata = {
+	.mmio_base	= AT91SAM9261_BASE_US2,
+	.irq		= AT91SAM9261_ID_US2,
+	.clock_asc	= "usart2_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
 	},
-	.resource	= uart2_resources,
-	.num_resources	= ARRAY_SIZE(uart2_resources),
+	.tx_pin		= {AT91_PIN_PC14, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PC15, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PA15, AT91_PIN_PERIPH_B, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PA16, AT91_PIN_PERIPH_B, 0, 0, 0},
 };
 
-static inline void configure_usart2_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PC15, 0);		/* RXD2 */
-	at91_set_A_periph(AT91_PIN_PC14, 1);		/* TXD2 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_B_periph(AT91_PIN_PA15, 0);	/* RTS2*/
-	if (pins & ATMEL_UART_CTS)
-		at91_set_B_periph(AT91_PIN_PA16, 0);	/* CTS2 */
-}
-
-static struct platform_device *__initdata at91_uarts[ATMEL_MAX_UART];	/* the UARTs to use */
-struct platform_device *atmel_default_console_device;	/* the serial console device */
-
-void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
-{
-	struct platform_device *pdev;
-
-	switch (id) {
-		case 0:		/* DBGU */
-			pdev = &at91sam9261_dbgu_device;
-			configure_dbgu_pins();
-			at91_clock_associate("mck", &pdev->dev, "usart");
-			break;
-		case AT91SAM9261_ID_US0:
-			pdev = &at91sam9261_uart0_device;
-			configure_usart0_pins(pins);
-			at91_clock_associate("usart0_clk", &pdev->dev, "usart");
-			break;
-		case AT91SAM9261_ID_US1:
-			pdev = &at91sam9261_uart1_device;
-			configure_usart1_pins(pins);
-			at91_clock_associate("usart1_clk", &pdev->dev, "usart");
-			break;
-		case AT91SAM9261_ID_US2:
-			pdev = &at91sam9261_uart2_device;
-			configure_usart2_pins(pins);
-			at91_clock_associate("usart2_clk", &pdev->dev, "usart");
-			break;
-		default:
-			return;
-	}
-	pdev->id = portnr;		/* update to mapped ID */
-
-	if (portnr < ATMEL_MAX_UART)
-		at91_uarts[portnr] = pdev;
-}
-
-void __init at91_set_serial_console(unsigned portnr)
-{
-	if (portnr < ATMEL_MAX_UART)
-		atmel_default_console_device = at91_uarts[portnr];
-}
-
-void __init at91_add_device_serial(void)
-{
-	int i;
-
-	for (i = 0; i < ATMEL_MAX_UART; i++) {
-		if (at91_uarts[i])
-			platform_device_register(at91_uarts[i]);
-	}
-
-	if (!atmel_default_console_device)
-		printk(KERN_INFO "AT91: No default serial console defined.\n");
-}
-#else
-void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins) {}
-void __init at91_set_serial_console(unsigned portnr) {}
-void __init at91_add_device_serial(void) {}
-#endif
-
 static struct at91_device_table at91sam9261_device_table __initdata = {
 	.usbh_ohci	= &device_usbh_ohci,
 	.udc		= &device_udc,
@@ -665,6 +490,10 @@ static struct at91_device_table at91sam9261_device_table __initdata = {
 	.spi[1]		= &device_spi1,
 	.tcb[0]		= &device_tcb,
 	.rtt[0]		= &device_rtt,
+	.dbgu		= &device_dbgu,
+	.uart[0]	= &device_uart0,
+	.uart[1]	= &device_uart1,
+	.uart[2]	= &device_uart2,
 };
 
 void __init at91sam9261_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 109e230..1bc3da2 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -715,237 +715,61 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
  *  UART
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_SERIAL_ATMEL)
-
-static struct resource dbgu_resources[] = {
-	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91_ID_SYS,
-		.end	= AT91_ID_SYS,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data dbgu_data = {
-	.use_dma_tx	= 0,
-	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
-};
-
-static u64 dbgu_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9263_dbgu_device = {
-	.name		= "atmel_usart",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &dbgu_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &dbgu_data,
-	},
-	.resource	= dbgu_resources,
-	.num_resources	= ARRAY_SIZE(dbgu_resources),
-};
-
-static inline void configure_dbgu_pins(void)
-{
-	at91_set_A_periph(AT91_PIN_PC30, 0);		/* DRXD */
-	at91_set_A_periph(AT91_PIN_PC31, 1);		/* DTXD */
-}
-
-static struct resource uart0_resources[] = {
-	[0] = {
-		.start	= AT91SAM9263_BASE_US0,
-		.end	= AT91SAM9263_BASE_US0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9263_ID_US0,
-		.end	= AT91SAM9263_ID_US0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart0_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart0_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9263_uart0_device = {
-	.name		= "atmel_usart",
-	.id		= 1,
-	.dev		= {
-				.dma_mask		= &uart0_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart0_data,
-	},
-	.resource	= uart0_resources,
-	.num_resources	= ARRAY_SIZE(uart0_resources),
-};
-
-static inline void configure_usart0_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PA26, 1);		/* TXD0 */
-	at91_set_A_periph(AT91_PIN_PA27, 0);		/* RXD0 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_A_periph(AT91_PIN_PA28, 0);	/* RTS0 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_A_periph(AT91_PIN_PA29, 0);	/* CTS0 */
-}
-
-static struct resource uart1_resources[] = {
-	[0] = {
-		.start	= AT91SAM9263_BASE_US1,
-		.end	= AT91SAM9263_BASE_US1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9263_ID_US1,
-		.end	= AT91SAM9263_ID_US1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart1_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
+static struct at91_dev_table_uart device_dbgu __initdata = {
+	.mmio_base	= AT91_VA_BASE_SYS + AT91_DBGU,
+	.irq		= AT91_ID_SYS,
+	.clock_asc	= "mck",
+	.uart_data	= {
+		.use_dma_tx	= 0,
+		.use_dma_rx	= 0,
+		.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
+	},
+	.tx_pin		= {AT91_PIN_PC31, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PC30, AT91_PIN_PERIPH_A, 0, 0, 0},
+};
+
+static struct at91_dev_table_uart device_uart0 __initdata = {
+	.mmio_base	= AT91SAM9263_BASE_US0,
+	.irq		= AT91SAM9263_ID_US0,
+	.clock_asc	= "usart0_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
+	},
+	.tx_pin		= {AT91_PIN_PA26, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PA27, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PA28, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PA29, AT91_PIN_PERIPH_A, 0, 0, 0},
+};
+
+static struct at91_dev_table_uart device_uart1 __initdata = {
+	.mmio_base	= AT91SAM9263_BASE_US1,
+	.irq		= AT91SAM9263_ID_US1,
+	.clock_asc	= "usart1_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
+	},
+	.tx_pin		= {AT91_PIN_PD0, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PD1, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PD7, AT91_PIN_PERIPH_B, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PD8, AT91_PIN_PERIPH_B, 0, 0, 0},
+};
+
+static struct at91_dev_table_uart device_uart2 __initdata = {
+	.mmio_base	= AT91SAM9263_BASE_US2,
+	.irq		= AT91SAM9263_ID_US2,
+	.clock_asc	= "usart2_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
+	},
+	.tx_pin		= {AT91_PIN_PD2, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PD3, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PD5, AT91_PIN_PERIPH_B, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PD6, AT91_PIN_PERIPH_B, 0, 0, 0},
 };
 
-static u64 uart1_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9263_uart1_device = {
-	.name		= "atmel_usart",
-	.id		= 2,
-	.dev		= {
-				.dma_mask		= &uart1_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart1_data,
-	},
-	.resource	= uart1_resources,
-	.num_resources	= ARRAY_SIZE(uart1_resources),
-};
-
-static inline void configure_usart1_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PD0, 1);		/* TXD1 */
-	at91_set_A_periph(AT91_PIN_PD1, 0);		/* RXD1 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_B_periph(AT91_PIN_PD7, 0);	/* RTS1 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_B_periph(AT91_PIN_PD8, 0);	/* CTS1 */
-}
-
-static struct resource uart2_resources[] = {
-	[0] = {
-		.start	= AT91SAM9263_BASE_US2,
-		.end	= AT91SAM9263_BASE_US2 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9263_ID_US2,
-		.end	= AT91SAM9263_ID_US2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart2_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart2_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9263_uart2_device = {
-	.name		= "atmel_usart",
-	.id		= 3,
-	.dev		= {
-				.dma_mask		= &uart2_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart2_data,
-	},
-	.resource	= uart2_resources,
-	.num_resources	= ARRAY_SIZE(uart2_resources),
-};
-
-static inline void configure_usart2_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PD2, 1);		/* TXD2 */
-	at91_set_A_periph(AT91_PIN_PD3, 0);		/* RXD2 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_B_periph(AT91_PIN_PD5, 0);	/* RTS2 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_B_periph(AT91_PIN_PD6, 0);	/* CTS2 */
-}
-
-static struct platform_device *__initdata at91_uarts[ATMEL_MAX_UART];	/* the UARTs to use */
-struct platform_device *atmel_default_console_device;	/* the serial console device */
-
-void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
-{
-	struct platform_device *pdev;
-
-	switch (id) {
-		case 0:		/* DBGU */
-			pdev = &at91sam9263_dbgu_device;
-			configure_dbgu_pins();
-			at91_clock_associate("mck", &pdev->dev, "usart");
-			break;
-		case AT91SAM9263_ID_US0:
-			pdev = &at91sam9263_uart0_device;
-			configure_usart0_pins(pins);
-			at91_clock_associate("usart0_clk", &pdev->dev, "usart");
-			break;
-		case AT91SAM9263_ID_US1:
-			pdev = &at91sam9263_uart1_device;
-			configure_usart1_pins(pins);
-			at91_clock_associate("usart1_clk", &pdev->dev, "usart");
-			break;
-		case AT91SAM9263_ID_US2:
-			pdev = &at91sam9263_uart2_device;
-			configure_usart2_pins(pins);
-			at91_clock_associate("usart2_clk", &pdev->dev, "usart");
-			break;
-		default:
-			return;
-	}
-	pdev->id = portnr;		/* update to mapped ID */
-
-	if (portnr < ATMEL_MAX_UART)
-		at91_uarts[portnr] = pdev;
-}
-
-void __init at91_set_serial_console(unsigned portnr)
-{
-	if (portnr < ATMEL_MAX_UART)
-		atmel_default_console_device = at91_uarts[portnr];
-}
-
-void __init at91_add_device_serial(void)
-{
-	int i;
-
-	for (i = 0; i < ATMEL_MAX_UART; i++) {
-		if (at91_uarts[i])
-			platform_device_register(at91_uarts[i]);
-	}
-
-	if (!atmel_default_console_device)
-		printk(KERN_INFO "AT91: No default serial console defined.\n");
-}
-#else
-void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins) {}
-void __init at91_set_serial_console(unsigned portnr) {}
-void __init at91_add_device_serial(void) {}
-#endif
-
 static struct at91_device_table at91sam9263_device_table __initdata = {
 	.ethernet	= &device_eth,
 	.usbh_ohci	= &device_usbh_ohci,
@@ -959,6 +783,10 @@ static struct at91_device_table at91sam9263_device_table __initdata = {
 	.tcb[0]		= &device_tcb,
 	.rtt[0]		= &device_rtt0,
 	.rtt[1]		= &device_rtt1,
+	.dbgu		= &device_dbgu,
+	.uart[0]	= &device_uart0,
+	.uart[1]	= &device_uart1,
+	.uart[2]	= &device_uart2,
 };
 
 void __init at91sam9263_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 96631f3..be9435b 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -748,284 +748,75 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
  *  UART
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_SERIAL_ATMEL)
-static struct resource dbgu_resources[] = {
-	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91_ID_SYS,
-		.end	= AT91_ID_SYS,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data dbgu_data = {
-	.use_dma_tx	= 0,
-	.use_dma_rx	= 0,
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
-};
-
-static u64 dbgu_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9g45_dbgu_device = {
-	.name		= "atmel_usart",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &dbgu_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &dbgu_data,
-	},
-	.resource	= dbgu_resources,
-	.num_resources	= ARRAY_SIZE(dbgu_resources),
-};
-
-static inline void configure_dbgu_pins(void)
-{
-	at91_set_A_periph(AT91_PIN_PB12, 0);		/* DRXD */
-	at91_set_A_periph(AT91_PIN_PB13, 1);		/* DTXD */
-}
-
-static struct resource uart0_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_BASE_US0,
-		.end	= AT91SAM9G45_BASE_US0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_ID_US0,
-		.end	= AT91SAM9G45_ID_US0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart0_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart0_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9g45_uart0_device = {
-	.name		= "atmel_usart",
-	.id		= 1,
-	.dev		= {
-				.dma_mask		= &uart0_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart0_data,
-	},
-	.resource	= uart0_resources,
-	.num_resources	= ARRAY_SIZE(uart0_resources),
-};
-
-static inline void configure_usart0_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PB19, 1);		/* TXD0 */
-	at91_set_A_periph(AT91_PIN_PB18, 0);		/* RXD0 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_B_periph(AT91_PIN_PB17, 0);	/* RTS0 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_B_periph(AT91_PIN_PB15, 0);	/* CTS0 */
-}
-
-static struct resource uart1_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_BASE_US1,
-		.end	= AT91SAM9G45_BASE_US1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_ID_US1,
-		.end	= AT91SAM9G45_ID_US1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart1_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart1_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9g45_uart1_device = {
-	.name		= "atmel_usart",
-	.id		= 2,
-	.dev		= {
-				.dma_mask		= &uart1_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart1_data,
-	},
-	.resource	= uart1_resources,
-	.num_resources	= ARRAY_SIZE(uart1_resources),
-};
-
-static inline void configure_usart1_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PB4, 1);		/* TXD1 */
-	at91_set_A_periph(AT91_PIN_PB5, 0);		/* RXD1 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_A_periph(AT91_PIN_PD16, 0);	/* RTS1 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_A_periph(AT91_PIN_PD17, 0);	/* CTS1 */
-}
-
-static struct resource uart2_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_BASE_US2,
-		.end	= AT91SAM9G45_BASE_US2 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_ID_US2,
-		.end	= AT91SAM9G45_ID_US2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart2_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart2_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9g45_uart2_device = {
-	.name		= "atmel_usart",
-	.id		= 3,
-	.dev		= {
-				.dma_mask		= &uart2_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart2_data,
-	},
-	.resource	= uart2_resources,
-	.num_resources	= ARRAY_SIZE(uart2_resources),
+static struct at91_dev_table_uart device_dbgu __initdata = {
+	.mmio_base	= AT91_VA_BASE_SYS + AT91_DBGU,
+	.irq		= AT91_ID_SYS,
+	.clock_asc	= "mck",
+	.uart_data	= {
+		.use_dma_tx	= 0,
+		.use_dma_rx	= 0,
+		.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
+	},
+	.tx_pin		= {AT91_PIN_PB13, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PB12, AT91_PIN_PERIPH_A, 0, 0, 0},
+};
+
+static struct at91_dev_table_uart device_uart0 __initdata = {
+	.mmio_base	= AT91SAM9G45_BASE_US0,
+	.irq		= AT91SAM9G45_ID_US0,
+	.clock_asc	= "usart0_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
+	},
+	.tx_pin		= {AT91_PIN_PA19, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PA18, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PB17, AT91_PIN_PERIPH_B, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PB15, AT91_PIN_PERIPH_B, 0, 0, 0},
+};
+
+static struct at91_dev_table_uart device_uart1 __initdata = {
+	.mmio_base	= AT91SAM9G45_BASE_US1,
+	.irq		= AT91SAM9G45_ID_US1,
+	.clock_asc	= "usart1_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
+	},
+	.tx_pin		= {AT91_PIN_PB4,  AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PB5,  AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PD16, AT91_PIN_PERIPH_B, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PD17, AT91_PIN_PERIPH_B, 0, 0, 0},
+};
+
+static struct at91_dev_table_uart device_uart2 __initdata = {
+	.mmio_base	= AT91SAM9G45_BASE_US2,
+	.irq		= AT91SAM9G45_ID_US2,
+	.clock_asc	= "usart2_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
+	},
+	.tx_pin		= {AT91_PIN_PB6,  AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PB7,  AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PC9,  AT91_PIN_PERIPH_B, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PC11, AT91_PIN_PERIPH_B, 0, 0, 0},
+};
+
+static struct at91_dev_table_uart device_uart3 __initdata = {
+	.mmio_base	= AT91SAM9G45_BASE_US3,
+	.irq		= AT91SAM9G45_ID_US3,
+	.clock_asc	= "usart3_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
+	},
+	.tx_pin		= {AT91_PIN_PB8,  AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PB9,  AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PA23, AT91_PIN_PERIPH_B, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PA24, AT91_PIN_PERIPH_B, 0, 0, 0},
 };
 
-static inline void configure_usart2_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PB6, 1);		/* TXD2 */
-	at91_set_A_periph(AT91_PIN_PB7, 0);		/* RXD2 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_B_periph(AT91_PIN_PC9, 0);	/* RTS2 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_B_periph(AT91_PIN_PC11, 0);	/* CTS2 */
-}
-
-static struct resource uart3_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_BASE_US3,
-		.end	= AT91SAM9G45_BASE_US3 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_ID_US3,
-		.end	= AT91SAM9G45_ID_US3,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart3_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart3_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9g45_uart3_device = {
-	.name		= "atmel_usart",
-	.id		= 4,
-	.dev		= {
-				.dma_mask		= &uart3_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart3_data,
-	},
-	.resource	= uart3_resources,
-	.num_resources	= ARRAY_SIZE(uart3_resources),
-};
-
-static inline void configure_usart3_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PB8, 1);		/* TXD3 */
-	at91_set_A_periph(AT91_PIN_PB9, 0);		/* RXD3 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_B_periph(AT91_PIN_PA23, 0);	/* RTS3 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_B_periph(AT91_PIN_PA24, 0);	/* CTS3 */
-}
-
-static struct platform_device *__initdata at91_uarts[ATMEL_MAX_UART];	/* the UARTs to use */
-struct platform_device *atmel_default_console_device;	/* the serial console device */
-
-void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
-{
-	struct platform_device *pdev;
-
-	switch (id) {
-		case 0:		/* DBGU */
-			pdev = &at91sam9g45_dbgu_device;
-			configure_dbgu_pins();
-			at91_clock_associate("mck", &pdev->dev, "usart");
-			break;
-		case AT91SAM9G45_ID_US0:
-			pdev = &at91sam9g45_uart0_device;
-			configure_usart0_pins(pins);
-			at91_clock_associate("usart0_clk", &pdev->dev, "usart");
-			break;
-		case AT91SAM9G45_ID_US1:
-			pdev = &at91sam9g45_uart1_device;
-			configure_usart1_pins(pins);
-			at91_clock_associate("usart1_clk", &pdev->dev, "usart");
-			break;
-		case AT91SAM9G45_ID_US2:
-			pdev = &at91sam9g45_uart2_device;
-			configure_usart2_pins(pins);
-			at91_clock_associate("usart2_clk", &pdev->dev, "usart");
-			break;
-		case AT91SAM9G45_ID_US3:
-			pdev = &at91sam9g45_uart3_device;
-			configure_usart3_pins(pins);
-			at91_clock_associate("usart3_clk", &pdev->dev, "usart");
-			break;
-		default:
-			return;
-	}
-	pdev->id = portnr;		/* update to mapped ID */
-
-	if (portnr < ATMEL_MAX_UART)
-		at91_uarts[portnr] = pdev;
-}
-
-void __init at91_set_serial_console(unsigned portnr)
-{
-	if (portnr < ATMEL_MAX_UART)
-		atmel_default_console_device = at91_uarts[portnr];
-}
-
-void __init at91_add_device_serial(void)
-{
-	int i;
-
-	for (i = 0; i < ATMEL_MAX_UART; i++) {
-		if (at91_uarts[i])
-			platform_device_register(at91_uarts[i]);
-	}
-
-	if (!atmel_default_console_device)
-		printk(KERN_INFO "AT91: No default serial console defined.\n");
-}
-#else
-void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins) {}
-void __init at91_set_serial_console(unsigned portnr) {}
-void __init at91_add_device_serial(void) {}
-#endif
-
 static struct at91_device_table at91sam9g45_device_table __initdata = {
 	.ethernet	= &device_eth,
 	.usbh_ohci	= &device_usb_ohci,
@@ -1040,6 +831,11 @@ static struct at91_device_table at91sam9g45_device_table __initdata = {
 	.tcb[0]		= &device_tcb0,
 	.tcb[1]		= &device_tcb1,
 	.rtt[0]		= &device_rtt,
+	.dbgu		= &device_dbgu,
+	.uart[0]	= &device_uart0,
+	.uart[1]	= &device_uart1,
+	.uart[2]	= &device_uart2,
+	.uart[3]	= &device_uart3,
 };
 
 void __init at91sam9g45_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index fa11eac..8f43d23 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -626,292 +626,79 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
  *  UART
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_SERIAL_ATMEL)
-static struct resource dbgu_resources[] = {
-	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91_ID_SYS,
-		.end	= AT91_ID_SYS,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data dbgu_data = {
-	.use_dma_tx	= 0,
-	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
-};
-
-static u64 dbgu_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9rl_dbgu_device = {
-	.name		= "atmel_usart",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &dbgu_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &dbgu_data,
-	},
-	.resource	= dbgu_resources,
-	.num_resources	= ARRAY_SIZE(dbgu_resources),
+static struct at91_dev_table_uart device_dbgu __initdata = {
+	.mmio_base	= AT91_VA_BASE_SYS + AT91_DBGU,
+	.irq		= AT91_ID_SYS,
+	.clock_asc	= "mck",
+	.uart_data	= {
+		.use_dma_tx	= 0,
+		.use_dma_rx	= 0,
+		.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
+	},
+	.tx_pin		= {AT91_PIN_PA22, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PA21, AT91_PIN_PERIPH_A, 0, 0, 0},
+};
+
+static struct at91_dev_table_uart device_uart0 __initdata = {
+	.mmio_base	= AT91SAM9RL_BASE_US0,
+	.irq		= AT91SAM9RL_ID_US0,
+	.clock_asc	= "usart0_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
+	},
+	.tx_pin		= {AT91_PIN_PA6,  AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PA7,  AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PA9,  AT91_PIN_PERIPH_A, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PA10, AT91_PIN_PERIPH_A, 0, 0, 0},	
+	.dsr_pin	= {AT91_PIN_PD14, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.dtr_pin	= {AT91_PIN_PD15, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.dcd_pin	= {AT91_PIN_PD16, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.ri_pin		= {AT91_PIN_PD17, AT91_PIN_PERIPH_A, 0, 0, 0},
+};
+
+static struct at91_dev_table_uart device_uart1 __initdata = {
+	.mmio_base	= AT91SAM9RL_BASE_US1,
+	.irq		= AT91SAM9RL_ID_US1,
+	.clock_asc	= "usart1_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
+	},
+	.tx_pin		= {AT91_PIN_PA11, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PA12, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PA18, AT91_PIN_PERIPH_B, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PA19, AT91_PIN_PERIPH_B, 0, 0, 0},	
+};
+
+static struct at91_dev_table_uart device_uart2 __initdata = {
+	.mmio_base	= AT91SAM9RL_BASE_US2,
+	.irq		= AT91SAM9RL_ID_US2,
+	.clock_asc	= "usart2_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
+	},
+	.tx_pin		= {AT91_PIN_PA13, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PA14, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PA29, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PA30, AT91_PIN_PERIPH_A, 0, 0, 0},	
+};
+
+static struct at91_dev_table_uart device_uart3 __initdata = {
+	.mmio_base	= AT91SAM9RL_BASE_US3,
+	.irq		= AT91SAM9RL_ID_US3,
+	.clock_asc	= "usart3_clk",
+	.uart_data	= {
+		.use_dma_tx	= 1,
+		.use_dma_rx	= 1,
+	},
+	.tx_pin		= {AT91_PIN_PB0, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rx_pin		= {AT91_PIN_PB1, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.rts_pin	= {AT91_PIN_PD4, AT91_PIN_PERIPH_B, 0, 0, 0},
+	.cts_pin	= {AT91_PIN_PD3, AT91_PIN_PERIPH_B, 0, 0, 0},	
 };
 
-static inline void configure_dbgu_pins(void)
-{
-	at91_set_A_periph(AT91_PIN_PA21, 0);		/* DRXD */
-	at91_set_A_periph(AT91_PIN_PA22, 1);		/* DTXD */
-}
-
-static struct resource uart0_resources[] = {
-	[0] = {
-		.start	= AT91SAM9RL_BASE_US0,
-		.end	= AT91SAM9RL_BASE_US0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9RL_ID_US0,
-		.end	= AT91SAM9RL_ID_US0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart0_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart0_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9rl_uart0_device = {
-	.name		= "atmel_usart",
-	.id		= 1,
-	.dev		= {
-				.dma_mask		= &uart0_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart0_data,
-	},
-	.resource	= uart0_resources,
-	.num_resources	= ARRAY_SIZE(uart0_resources),
-};
-
-static inline void configure_usart0_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PA6, 1);		/* TXD0 */
-	at91_set_A_periph(AT91_PIN_PA7, 0);		/* RXD0 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_A_periph(AT91_PIN_PA9, 0);	/* RTS0 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_A_periph(AT91_PIN_PA10, 0);	/* CTS0 */
-	if (pins & ATMEL_UART_DSR)
-		at91_set_A_periph(AT91_PIN_PD14, 0);	/* DSR0 */
-	if (pins & ATMEL_UART_DTR)
-		at91_set_A_periph(AT91_PIN_PD15, 0);	/* DTR0 */
-	if (pins & ATMEL_UART_DCD)
-		at91_set_A_periph(AT91_PIN_PD16, 0);	/* DCD0 */
-	if (pins & ATMEL_UART_RI)
-		at91_set_A_periph(AT91_PIN_PD17, 0);	/* RI0 */
-}
-
-static struct resource uart1_resources[] = {
-	[0] = {
-		.start	= AT91SAM9RL_BASE_US1,
-		.end	= AT91SAM9RL_BASE_US1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9RL_ID_US1,
-		.end	= AT91SAM9RL_ID_US1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart1_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart1_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9rl_uart1_device = {
-	.name		= "atmel_usart",
-	.id		= 2,
-	.dev		= {
-				.dma_mask		= &uart1_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart1_data,
-	},
-	.resource	= uart1_resources,
-	.num_resources	= ARRAY_SIZE(uart1_resources),
-};
-
-static inline void configure_usart1_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PA11, 1);		/* TXD1 */
-	at91_set_A_periph(AT91_PIN_PA12, 0);		/* RXD1 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_B_periph(AT91_PIN_PA18, 0);	/* RTS1 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_B_periph(AT91_PIN_PA19, 0);	/* CTS1 */
-}
-
-static struct resource uart2_resources[] = {
-	[0] = {
-		.start	= AT91SAM9RL_BASE_US2,
-		.end	= AT91SAM9RL_BASE_US2 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9RL_ID_US2,
-		.end	= AT91SAM9RL_ID_US2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart2_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart2_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9rl_uart2_device = {
-	.name		= "atmel_usart",
-	.id		= 3,
-	.dev		= {
-				.dma_mask		= &uart2_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart2_data,
-	},
-	.resource	= uart2_resources,
-	.num_resources	= ARRAY_SIZE(uart2_resources),
-};
-
-static inline void configure_usart2_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PA13, 1);		/* TXD2 */
-	at91_set_A_periph(AT91_PIN_PA14, 0);		/* RXD2 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_A_periph(AT91_PIN_PA29, 0);	/* RTS2 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_A_periph(AT91_PIN_PA30, 0);	/* CTS2 */
-}
-
-static struct resource uart3_resources[] = {
-	[0] = {
-		.start	= AT91SAM9RL_BASE_US3,
-		.end	= AT91SAM9RL_BASE_US3 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9RL_ID_US3,
-		.end	= AT91SAM9RL_ID_US3,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart3_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart3_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91sam9rl_uart3_device = {
-	.name		= "atmel_usart",
-	.id		= 4,
-	.dev		= {
-				.dma_mask		= &uart3_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart3_data,
-	},
-	.resource	= uart3_resources,
-	.num_resources	= ARRAY_SIZE(uart3_resources),
-};
-
-static inline void configure_usart3_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PB0, 1);		/* TXD3 */
-	at91_set_A_periph(AT91_PIN_PB1, 0);		/* RXD3 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_B_periph(AT91_PIN_PD4, 0);	/* RTS3 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_B_periph(AT91_PIN_PD3, 0);	/* CTS3 */
-}
-
-static struct platform_device *__initdata at91_uarts[ATMEL_MAX_UART];	/* the UARTs to use */
-struct platform_device *atmel_default_console_device;	/* the serial console device */
-
-void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
-{
-	struct platform_device *pdev;
-
-	switch (id) {
-		case 0:		/* DBGU */
-			pdev = &at91sam9rl_dbgu_device;
-			configure_dbgu_pins();
-			at91_clock_associate("mck", &pdev->dev, "usart");
-			break;
-		case AT91SAM9RL_ID_US0:
-			pdev = &at91sam9rl_uart0_device;
-			configure_usart0_pins(pins);
-			at91_clock_associate("usart0_clk", &pdev->dev, "usart");
-			break;
-		case AT91SAM9RL_ID_US1:
-			pdev = &at91sam9rl_uart1_device;
-			configure_usart1_pins(pins);
-			at91_clock_associate("usart1_clk", &pdev->dev, "usart");
-			break;
-		case AT91SAM9RL_ID_US2:
-			pdev = &at91sam9rl_uart2_device;
-			configure_usart2_pins(pins);
-			at91_clock_associate("usart2_clk", &pdev->dev, "usart");
-			break;
-		case AT91SAM9RL_ID_US3:
-			pdev = &at91sam9rl_uart3_device;
-			configure_usart3_pins(pins);
-			at91_clock_associate("usart3_clk", &pdev->dev, "usart");
-			break;
-		default:
-			return;
-	}
-	pdev->id = portnr;		/* update to mapped ID */
-
-	if (portnr < ATMEL_MAX_UART)
-		at91_uarts[portnr] = pdev;
-}
-
-void __init at91_set_serial_console(unsigned portnr)
-{
-	if (portnr < ATMEL_MAX_UART)
-		atmel_default_console_device = at91_uarts[portnr];
-}
-
-void __init at91_add_device_serial(void)
-{
-	int i;
-
-	for (i = 0; i < ATMEL_MAX_UART; i++) {
-		if (at91_uarts[i])
-			platform_device_register(at91_uarts[i]);
-	}
-
-	if (!atmel_default_console_device)
-		printk(KERN_INFO "AT91: No default serial console defined.\n");
-}
-#else
-void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins) {}
-void __init at91_set_serial_console(unsigned portnr) {}
-void __init at91_add_device_serial(void) {}
-#endif
-
 static struct at91_device_table at91sam9rl_device_table __initdata = {
 	.mmc[0]		= &device_mmc,
 	.nand		= &device_nand,
@@ -919,6 +706,11 @@ static struct at91_device_table at91sam9rl_device_table __initdata = {
 	.spi[0]		= &device_spi,
 	.tcb[0]		= &device_tcb,
 	.rtt[0]		= &device_rtt,
+	.dbgu		= &device_dbgu,
+	.uart[0]	= &device_uart0,
+	.uart[1]	= &device_uart1,
+	.uart[2]	= &device_uart2,
+	.uart[3]	= &device_uart3,
 };
 
 void __init at91sam9rl_init_devices(void)
diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
index 244e8bb..9a4ff1b 100644
--- a/arch/arm/mach-at91/board-1arm.c
+++ b/arch/arm/mach-at91/board-1arm.c
@@ -48,10 +48,10 @@ static void __init onearm_map_io(void)
 	at91_register_uart(0, 0, 0);
 
 	/* USART0 on ttyS1 (Rx, Tx, CTS, RTS) */
-	at91_register_uart(AT91RM9200_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS);
+	at91_register_uart(AT91_UART_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS);
 
 	/* USART1 on ttyS2 (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
-	at91_register_uart(AT91RM9200_ID_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS
+	at91_register_uart(AT91_UART_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS
 			   | ATMEL_UART_DTR | ATMEL_UART_DSR | ATMEL_UART_DCD
 			   | ATMEL_UART_RI);
 
diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index c64b7d6..9c7073a 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -57,13 +57,13 @@ static void __init afeb9260_map_io(void)
 	at91_register_uart(0, 0, 0);
 
 	/* USART0 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
-	at91_register_uart(AT91SAM9260_ID_US0, 1,
+	at91_register_uart(AT91_UART_US0, 1,
 			     ATMEL_UART_CTS | ATMEL_UART_RTS
 			   | ATMEL_UART_DTR | ATMEL_UART_DSR
 			   | ATMEL_UART_DCD | ATMEL_UART_RI);
 
 	/* USART1 on ttyS2. (Rx, Tx, RTS, CTS) */
-	at91_register_uart(AT91SAM9260_ID_US1, 2,
+	at91_register_uart(AT91_UART_US1, 2,
 			ATMEL_UART_CTS | ATMEL_UART_RTS);
 
 	/* set serial console to ttyS0 (ie, DBGU) */
diff --git a/arch/arm/mach-at91/board-at572d940hf_ek.c b/arch/arm/mach-at91/board-at572d940hf_ek.c
index edbbce4..8955133 100644
--- a/arch/arm/mach-at91/board-at572d940hf_ek.c
+++ b/arch/arm/mach-at91/board-at572d940hf_ek.c
@@ -55,13 +55,13 @@ static void __init eb_map_io(void)
 	at91_register_uart(0, 0, 0);
 
 	/* USART0 on ttyS1. (Rx & Tx only) */
-	at91_register_uart(AT572D940HF_ID_US0, 1, 0);
+	at91_register_uart(AT91_UART_US0, 1, 0);
 
 	/* USART1 on ttyS2. (Rx & Tx only) */
-	at91_register_uart(AT572D940HF_ID_US1, 2, 0);
+	at91_register_uart(AT91_UART_US1, 2, 0);
 
 	/* USART2 on ttyS3. (Tx & Rx only */
-	at91_register_uart(AT572D940HF_ID_US2, 3, 0);
+	at91_register_uart(AT91_UART_US2, 3, 0);
 
 	/* set serial console to ttyS0 (ie, DBGU) */
 	at91_set_serial_console(0);
diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
index b9033cb..a1afc1b 100644
--- a/arch/arm/mach-at91/board-carmeva.c
+++ b/arch/arm/mach-at91/board-carmeva.c
@@ -49,7 +49,7 @@ static void __init carmeva_map_io(void)
 	at91_register_uart(0, 0, 0);
 
 	/* USART1 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
-	at91_register_uart(AT91RM9200_ID_US1, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
+	at91_register_uart(AT91_UART_US1, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
 			   | ATMEL_UART_DTR | ATMEL_UART_DSR | ATMEL_UART_DCD
 			   | ATMEL_UART_RI);
 
diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index 9a88ca0..99f74b0 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -56,26 +56,26 @@ static void __init cpu9krea_map_io(void)
 	at91_register_uart(0, 0, 0);
 
 	/* USART0 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
-	at91_register_uart(AT91SAM9260_ID_US0, 1, ATMEL_UART_CTS |
+	at91_register_uart(AT91_UART_US0, 1, ATMEL_UART_CTS |
 		ATMEL_UART_RTS | ATMEL_UART_DTR | ATMEL_UART_DSR |
 		ATMEL_UART_DCD | ATMEL_UART_RI);
 
 	/* USART1 on ttyS2. (Rx, Tx, RTS, CTS) */
-	at91_register_uart(AT91SAM9260_ID_US1, 2, ATMEL_UART_CTS |
+	at91_register_uart(AT91_UART_US1, 2, ATMEL_UART_CTS |
 		ATMEL_UART_RTS);
 
 	/* USART2 on ttyS3. (Rx, Tx, RTS, CTS) */
-	at91_register_uart(AT91SAM9260_ID_US2, 3, ATMEL_UART_CTS |
+	at91_register_uart(AT91_UART_US2, 3, ATMEL_UART_CTS |
 		ATMEL_UART_RTS);
 
 	/* USART3 on ttyS4. (Rx, Tx) */
-	at91_register_uart(AT91SAM9260_ID_US3, 4, 0);
+	at91_register_uart(AT91_UART_US3, 4, 0);
 
 	/* USART4 on ttyS5. (Rx, Tx) */
-	at91_register_uart(AT91SAM9260_ID_US4, 5, 0);
+	at91_register_uart(AT91_UART_US4, 5, 0);
 
 	/* USART5 on ttyS6. (Rx, Tx) */
-	at91_register_uart(AT91SAM9260_ID_US5, 6, 0);
+	at91_register_uart(AT91_UART_US5, 6, 0);
 
 	/* set serial console to ttyS0 (ie, DBGU) */
 	at91_set_serial_console(0);
diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
index fbdd54b..689aef6 100644
--- a/arch/arm/mach-at91/board-cpuat91.c
+++ b/arch/arm/mach-at91/board-cpuat91.c
@@ -59,19 +59,19 @@ static void __init cpuat91_map_io(void)
 	at91_register_uart(0, 0, 0);
 
 	/* USART0 on ttyS1. (Rx, Tx, CTS, RTS) */
-	at91_register_uart(AT91RM9200_ID_US0, 1, ATMEL_UART_CTS |
+	at91_register_uart(AT91_UART_US0, 1, ATMEL_UART_CTS |
 		ATMEL_UART_RTS);
 
 	/* USART1 on ttyS2. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
-	at91_register_uart(AT91RM9200_ID_US1, 2, ATMEL_UART_CTS |
+	at91_register_uart(AT91_UART_US1, 2, ATMEL_UART_CTS |
 		ATMEL_UART_RTS | ATMEL_UART_DTR | ATMEL_UART_DSR |
 		ATMEL_UART_DCD | ATMEL_UART_RI);
 
 	/* USART2 on ttyS3 (Rx, Tx) */
-	at91_register_uart(AT91RM9200_ID_US2, 3, 0);
+	at91_register_uart(AT91_UART_US2, 3, 0);
 
 	/* USART3 on ttyS4 (Rx, Tx, CTS, RTS) */
-	at91_register_uart(AT91RM9200_ID_US3, 4, ATMEL_UART_CTS |
+	at91_register_uart(AT91_UART_US3, 4, ATMEL_UART_CTS |
 		ATMEL_UART_RTS);
 
 	/* set serial console to ttyS0 (ie, DBGU) */
diff --git a/arch/arm/mach-at91/board-eb9200.c b/arch/arm/mach-at91/board-eb9200.c
index eed4d6c..9d7dba2 100644
--- a/arch/arm/mach-at91/board-eb9200.c
+++ b/arch/arm/mach-at91/board-eb9200.c
@@ -49,12 +49,12 @@ static void __init eb9200_map_io(void)
 	at91_register_uart(0, 0, 0);
 
 	/* USART1 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
-	at91_register_uart(AT91RM9200_ID_US1, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
+	at91_register_uart(AT91_UART_US1, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
 			| ATMEL_UART_DTR | ATMEL_UART_DSR | ATMEL_UART_DCD
 			| ATMEL_UART_RI);
 
 	/* USART2 on ttyS2. (Rx, Tx) - IRDA */
-	at91_register_uart(AT91RM9200_ID_US2, 2, 0);
+	at91_register_uart(AT91_UART_US2, 2, 0);
 
 	/* set serial console to ttyS0 (ie, DBGU) */
 	at91_set_serial_console(0);
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index b730b01..4f0c76c 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -54,7 +54,7 @@ static void __init ecb_at91map_io(void)
 	at91_register_uart(0, 0, 0);
 
 	/* USART0 on ttyS1. (Rx & Tx only) */
-	at91_register_uart(AT91RM9200_ID_US0, 1, 0);
+	at91_register_uart(AT91_UART_US0, 1, 0);
 
 	/* set serial console to ttyS0 (ie, DBGU) */
 	at91_set_serial_console(0);
diff --git a/arch/arm/mach-at91/board-foxg20.c b/arch/arm/mach-at91/board-foxg20.c
index 79c54fc..fb3cfdd 100644
--- a/arch/arm/mach-at91/board-foxg20.c
+++ b/arch/arm/mach-at91/board-foxg20.c
@@ -66,7 +66,7 @@ static void __init foxg20_map_io(void)
 	at91_register_uart(0, 0, 0);
 
 	/* USART0 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
-	at91_register_uart(AT91SAM9260_ID_US0, 1,
+	at91_register_uart(AT91_UART_US0, 1,
 				ATMEL_UART_CTS
 				| ATMEL_UART_RTS
 				| ATMEL_UART_DTR
@@ -75,23 +75,23 @@ static void __init foxg20_map_io(void)
 				| ATMEL_UART_RI);
 
 	/* USART1 on ttyS2. (Rx, Tx, RTS, CTS) */
-	at91_register_uart(AT91SAM9260_ID_US1, 2,
+	at91_register_uart(AT91_UART_US1, 2,
 		ATMEL_UART_CTS
 		| ATMEL_UART_RTS);
 
 	/* USART2 on ttyS3. (Rx & Tx only) */
-	at91_register_uart(AT91SAM9260_ID_US2, 3, 0);
+	at91_register_uart(AT91_UART_US2, 3, 0);
 
 	/* USART3 on ttyS4. (Rx, Tx, RTS, CTS) */
-	at91_register_uart(AT91SAM9260_ID_US3, 4,
+	at91_register_uart(AT91_UART_US3, 4,
 		ATMEL_UART_CTS
 		| ATMEL_UART_RTS);
 
 	/* USART4 on ttyS5. (Rx & Tx only) */
-	at91_register_uart(AT91SAM9260_ID_US4, 5, 0);
+	at91_register_uart(AT91_UART_US4, 5, 0);
 
 	/* USART5 on ttyS6. (Rx & Tx only) */
-	at91_register_uart(AT91SAM9260_ID_US5, 6, 0);
+	at91_register_uart(AT91_UART_US5, 6, 0);
 
 	/* set serial console to ttyS0 (ie, DBGU) */
 	at91_set_serial_console(0);
diff --git a/arch/arm/mach-at91/board-gsia18s.c b/arch/arm/mach-at91/board-gsia18s.c
index e32833d..06d9be7 100644
--- a/arch/arm/mach-at91/board-gsia18s.c
+++ b/arch/arm/mach-at91/board-gsia18s.c
@@ -46,7 +46,7 @@ static void __init gsia18s_map_io(void)
 	 * USART0 on ttyS1 (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI).
 	 * Used for Internal Analog Modem.
 	 */
-	at91_register_uart(AT91SAM9260_ID_US0, 1,
+	at91_register_uart(AT91_UART_US0, 1,
 				ATMEL_UART_CTS | ATMEL_UART_RTS |
 				ATMEL_UART_DTR | ATMEL_UART_DSR |
 				ATMEL_UART_DCD | ATMEL_UART_RI);
@@ -54,25 +54,25 @@ static void __init gsia18s_map_io(void)
 	 * USART1 on ttyS2 (Rx, Tx, CTS, RTS).
 	 * Used for GPS or WiFi or Data stream.
 	 */
-	at91_register_uart(AT91SAM9260_ID_US1, 2,
+	at91_register_uart(AT91_UART_US1, 2,
 				ATMEL_UART_CTS | ATMEL_UART_RTS);
 	/*
 	 * USART2 on ttyS3 (Rx, Tx, CTS, RTS).
 	 * Used for External Modem.
 	 */
-	at91_register_uart(AT91SAM9260_ID_US2, 3,
+	at91_register_uart(AT91_UART_US2, 3,
 				ATMEL_UART_CTS | ATMEL_UART_RTS);
 	/*
 	 * USART3 on ttyS4 (Rx, Tx, RTS).
 	 * Used for RS-485.
 	 */
-	at91_register_uart(AT91SAM9260_ID_US3, 4, ATMEL_UART_RTS);
+	at91_register_uart(AT91_UART_US3, 4, ATMEL_UART_RTS);
 
 	/*
 	 * USART4 on ttyS5 (Rx, Tx).
 	 * Used for TRX433 Radio Module.
 	 */
-	at91_register_uart(AT91SAM9260_ID_US4, 5, 0);
+	at91_register_uart(AT91_UART_US4, 5, 0);
 }
 
 static void __init init_irq(void)
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
index 1edff1b..ddab49b 100644
--- a/arch/arm/mach-at91/board-kafa.c
+++ b/arch/arm/mach-at91/board-kafa.c
@@ -51,7 +51,7 @@ static void __init kafa_map_io(void)
 	at91_register_uart(0, 0, 0);
 
 	/* USART0 on ttyS1 (Rx, Tx, CTS, RTS) */
-	at91_register_uart(AT91RM9200_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS);
+	at91_register_uart(AT91_UART_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS);
 
 	/* set serial console to ttyS0 (ie, DBGU) */
 	at91_set_serial_console(0);
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index 682e9f4..22a421b 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -54,13 +54,13 @@ static void __init kb9202_map_io(void)
 	at91_register_uart(0, 0, 0);
 
 	/* USART0 on ttyS1 (Rx & Tx only) */
-	at91_register_uart(AT91RM9200_ID_US0, 1, 0);
+	at91_register_uart(AT91_UART_US0, 1, 0);
 
 	/* USART1 on ttyS2 (Rx & Tx only) - IRDA (optional) */
-	at91_register_uart(AT91RM9200_ID_US1, 2, 0);
+	at91_register_uart(AT91_UART_US1, 2, 0);
 
 	/* USART3 on ttyS3 (Rx, Tx, CTS, RTS) - RS485 (optional) */
-	at91_register_uart(AT91RM9200_ID_US3, 3, ATMEL_UART_CTS | ATMEL_UART_RTS);
+	at91_register_uart(AT91_UART_US3, 3, ATMEL_UART_CTS | ATMEL_UART_RTS);
 
 	/* set serial console to ttyS0 (ie, DBGU) */
 	at91_set_serial_console(0);
diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index f2c79fb..a76c43e 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -60,7 +60,7 @@ static void __init neocore926_map_io(void)
 	at91_register_uart(0, 0, 0);
 
 	/* USART0 on ttyS1. (Rx, Tx, RTS, CTS) */
-	at91_register_uart(AT91SAM9263_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS);
+	at91_register_uart(AT91_UART_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS);
 
 	/* set serial console to ttyS0 (ie, DBGU) */
 	at91_set_serial_console(0);
diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
index ad9cc28..777c35c 100644
--- a/arch/arm/mach-at91/board-pcontrol-g20.c
+++ b/arch/arm/mach-at91/board-pcontrol-g20.c
@@ -42,15 +42,15 @@ static void __init pcontrol_g20_map_io(void)
 	stamp9g20_map_io();
 
 	/* USART0 on ttyS1. (Rx, Tx, CTS, RTS) piggyback  A2 */
-	at91_register_uart(AT91SAM9260_ID_US0, 1, ATMEL_UART_CTS
+	at91_register_uart(AT91_UART_US0, 1, ATMEL_UART_CTS
 						| ATMEL_UART_RTS);
 
 	/* USART1 on ttyS2. (Rx, Tx, CTS, RTS) isolated RS485  X5 */
-	at91_register_uart(AT91SAM9260_ID_US1, 2, ATMEL_UART_CTS
+	at91_register_uart(AT91_UART_US1, 2, ATMEL_UART_CTS
 						| ATMEL_UART_RTS);
 
 	/* USART2 on ttyS3. (Rx, Tx)  9bit-Bus  Multidrop-mode  X4 */
-	at91_register_uart(AT91SAM9260_ID_US4, 3, 0);
+	at91_register_uart(AT91_UART_US4, 3, 0);
 }
 
 
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index 2b0958b..3c88f0b 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -52,7 +52,7 @@ static void __init picotux200_map_io(void)
 	at91_register_uart(0, 0, 0);
 
 	/* USART1 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
-	at91_register_uart(AT91RM9200_ID_US1, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
+	at91_register_uart(AT91_UART_US1, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
 			  | ATMEL_UART_DTR | ATMEL_UART_DSR | ATMEL_UART_DCD
 			  | ATMEL_UART_RI);
 
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index c00b292..1cbc7ef 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -57,15 +57,15 @@ static void __init ek_map_io(void)
 	at91_register_uart(0, 0, 0);
 
 	/* USART0 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
-	at91_register_uart(AT91SAM9260_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
+	at91_register_uart(AT91_UART_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
 			   | ATMEL_UART_DTR | ATMEL_UART_DSR | ATMEL_UART_DCD
 			   | ATMEL_UART_RI);
 
 	/* USART1 on ttyS2. (Rx, Tx, CTS, RTS) */
-	at91_register_uart(AT91SAM9260_ID_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS);
+	at91_register_uart(AT91_UART_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS);
 
 	/* USART2 on ttyS3. (Rx, Tx, CTS, RTS) */
-	at91_register_uart(AT91SAM9260_ID_US2, 3, ATMEL_UART_CTS | ATMEL_UART_RTS);
+	at91_register_uart(AT91_UART_US2, 3, ATMEL_UART_CTS | ATMEL_UART_RTS);
 
 	/* set serial console to ttyS1 (ie, USART0) */
 	at91_set_serial_console(1);
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index 746b6ea..192440d 100644
--- a/arch/arm/mach-at91/board-rm9200dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -57,7 +57,7 @@ static void __init dk_map_io(void)
 	at91_register_uart(0, 0, 0);
 
 	/* USART1 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
-	at91_register_uart(AT91RM9200_ID_US1, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
+	at91_register_uart(AT91_UART_US1, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
 			   | ATMEL_UART_DTR | ATMEL_UART_DSR | ATMEL_UART_DCD
 			   | ATMEL_UART_RI);
 
diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index 5e1dca0..0d91eb7 100644
--- a/arch/arm/mach-at91/board-rm9200ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -57,7 +57,7 @@ static void __init ek_map_io(void)
 	at91_register_uart(0, 0, 0);
 
 	/* USART1 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
-	at91_register_uart(AT91RM9200_ID_US1, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
+	at91_register_uart(AT91_UART_US1, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
 			   | ATMEL_UART_DTR | ATMEL_UART_DSR | ATMEL_UART_DCD
 			   | ATMEL_UART_RI);
 
diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
index bc62008..c6119f1 100644
--- a/arch/arm/mach-at91/board-sam9-l9260.c
+++ b/arch/arm/mach-at91/board-sam9-l9260.c
@@ -56,12 +56,12 @@ static void __init ek_map_io(void)
 	at91_register_uart(0, 0, 0);
 
 	/* USART0 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
-	at91_register_uart(AT91SAM9260_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
+	at91_register_uart(AT91_UART_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
 			   | ATMEL_UART_DTR | ATMEL_UART_DSR | ATMEL_UART_DCD
 			   | ATMEL_UART_RI);
 
 	/* USART1 on ttyS2. (Rx, Tx, CTS, RTS) */
-	at91_register_uart(AT91SAM9260_ID_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS);
+	at91_register_uart(AT91_UART_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS);
 
 	/* set serial console to ttyS0 (ie, DBGU) */
 	at91_set_serial_console(0);
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index c8c53ac..2bfac4e 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -58,12 +58,12 @@ static void __init ek_map_io(void)
 	at91_register_uart(0, 0, 0);
 
 	/* USART0 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
-	at91_register_uart(AT91SAM9260_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
+	at91_register_uart(AT91_UART_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
 			   | ATMEL_UART_DTR | ATMEL_UART_DSR | ATMEL_UART_DCD
 			   | ATMEL_UART_RI);
 
 	/* USART1 on ttyS2. (Rx, Tx, RTS, CTS) */
-	at91_register_uart(AT91SAM9260_ID_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS);
+	at91_register_uart(AT91_UART_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS);
 
 	/* set serial console to ttyS0 (ie, DBGU) */
 	at91_set_serial_console(0);
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index 5e1aac1..994db00 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -61,7 +61,7 @@ static void __init ek_map_io(void)
 	at91_register_uart(0, 0, 0);
 
 	/* USART0 on ttyS1. (Rx, Tx, RTS, CTS) */
-	at91_register_uart(AT91SAM9263_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS);
+	at91_register_uart(AT91_UART_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS);
 
 	/* set serial console to ttyS0 (ie, DBGU) */
 	at91_set_serial_console(0);
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 3dd5013..cc43eae 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -69,12 +69,12 @@ static void __init ek_map_io(void)
 	at91_register_uart(0, 0, 0);
 
 	/* USART0 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
-	at91_register_uart(AT91SAM9260_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
+	at91_register_uart(AT91_UART_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
 			   | ATMEL_UART_DTR | ATMEL_UART_DSR | ATMEL_UART_DCD
 			   | ATMEL_UART_RI);
 
 	/* USART1 on ttyS2. (Rx, Tx, RTS, CTS) */
-	at91_register_uart(AT91SAM9260_ID_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS);
+	at91_register_uart(AT91_UART_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS);
 
 	/* set serial console to ttyS0 (ie, DBGU) */
 	at91_set_serial_console(0);
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index 6c999db..85b8519 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -56,7 +56,7 @@ static void __init ek_map_io(void)
 
 	/* USART0 not connected on the -EK board */
 	/* USART1 on ttyS2. (Rx, Tx, RTS, CTS) */
-	at91_register_uart(AT91SAM9G45_ID_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS);
+	at91_register_uart(AT91_UART_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS);
 
 	/* set serial console to ttyS0 (ie, DBGU) */
 	at91_set_serial_console(0);
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index 475b485..9c7a971 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -47,7 +47,7 @@ static void __init ek_map_io(void)
 	at91_register_uart(0, 0, 0);
 
 	/* USART0 on ttyS1. (Rx, Tx, CTS, RTS) */
-	at91_register_uart(AT91SAM9RL_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS);
+	at91_register_uart(AT91_UART_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS);
 
 	/* set serial console to ttyS0 (ie, DBGU) */
 	at91_set_serial_console(0);
diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
index e93a11b..4c90ee3 100644
--- a/arch/arm/mach-at91/board-snapper9260.c
+++ b/arch/arm/mach-at91/board-snapper9260.c
@@ -48,11 +48,11 @@ static void __init snapper9260_map_io(void)
 	at91_register_uart(0, 0, 0);
 	at91_set_serial_console(0);
 
-	at91_register_uart(AT91SAM9260_ID_US0, 1,
+	at91_register_uart(AT91_UART_US0, 1,
 			   ATMEL_UART_CTS | ATMEL_UART_RTS);
-	at91_register_uart(AT91SAM9260_ID_US1, 2,
+	at91_register_uart(AT91_UART_US1, 2,
 			   ATMEL_UART_CTS | ATMEL_UART_RTS);
-	at91_register_uart(AT91SAM9260_ID_US2, 3, 0);
+	at91_register_uart(AT91_UART_US2, 3, 0);
 }
 
 static void __init snapper9260_init_irq(void)
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index 9b7f333..915128a 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -49,7 +49,7 @@ static void __init stamp9g20evb_map_io(void)
 	stamp9g20_map_io();
 
 	/* USART0 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
-	at91_register_uart(AT91SAM9260_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
+	at91_register_uart(AT91_UART_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
 						| ATMEL_UART_DTR | ATMEL_UART_DSR
 						| ATMEL_UART_DCD | ATMEL_UART_RI);
 }
@@ -59,21 +59,21 @@ static void __init portuxg20_map_io(void)
 	stamp9g20_map_io();
 
 	/* USART0 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
-	at91_register_uart(AT91SAM9260_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
+	at91_register_uart(AT91_UART_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
 						| ATMEL_UART_DTR | ATMEL_UART_DSR
 						| ATMEL_UART_DCD | ATMEL_UART_RI);
 
 	/* USART1 on ttyS2. (Rx, Tx, CTS, RTS) */
-	at91_register_uart(AT91SAM9260_ID_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS);
+	at91_register_uart(AT91_UART_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS);
 
 	/* USART2 on ttyS3. (Rx, Tx, CTS, RTS) */
-	at91_register_uart(AT91SAM9260_ID_US2, 3, ATMEL_UART_CTS | ATMEL_UART_RTS);
+	at91_register_uart(AT91_UART_US2, 3, ATMEL_UART_CTS | ATMEL_UART_RTS);
 
 	/* USART4 on ttyS5. (Rx, Tx only) */
-	at91_register_uart(AT91SAM9260_ID_US4, 5, 0);
+	at91_register_uart(AT91_UART_US4, 5, 0);
 
 	/* USART5 on ttyS6. (Rx, Tx only) */
-	at91_register_uart(AT91SAM9260_ID_US5, 6, 0);
+	at91_register_uart(AT91_UART_US5, 6, 0);
 }
 
 static void __init init_irq(void)
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index ef80db1..3939065 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -61,15 +61,15 @@ static void __init yl9200_map_io(void)
 	at91_register_uart(0, 0, 0);
 
 	/* USART1 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
-	at91_register_uart(AT91RM9200_ID_US1, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
+	at91_register_uart(AT91_UART_US1, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
 			| ATMEL_UART_DTR | ATMEL_UART_DSR | ATMEL_UART_DCD
 			| ATMEL_UART_RI);
 
 	/* USART0 on ttyS2. (Rx & Tx only to JP3) */
-	at91_register_uart(AT91RM9200_ID_US0, 2, 0);
+	at91_register_uart(AT91_UART_US0, 2, 0);
 
 	/* USART3 on ttyS3. (Rx, Tx, RTS - RS485 interface) */
-	at91_register_uart(AT91RM9200_ID_US3, 3, ATMEL_UART_RTS);
+	at91_register_uart(AT91_UART_US3, 3, ATMEL_UART_RTS);
 
 	/* set serial console to ttyS0 (ie, DBGU) */
 	at91_set_serial_console(0);
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index 760ed81..b759187 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c
@@ -23,6 +23,7 @@
 #include <mach/board.h>
 
 #include "devices.h"
+#include "generic.h"
 
 static struct at91_device_table *devices __initdata;
 
@@ -1000,6 +1001,305 @@ void __init at91_init_devices(struct at91_device_table *device_table)
 	devices = device_table;
 }
 
+/* --------------------------------------------------------------------
+ *  UART
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_SERIAL_ATMEL)
+static struct resource dbgu_resources[] = {
+	[0] = {
+		.end	= SZ_512,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct atmel_uart_data dbgu_data;
+static u64 dbgu_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device at91_dbgu_device = {
+	.name		= "atmel_usart",
+	.id		= 0,
+	.dev		= {
+				.dma_mask		= &dbgu_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+				.platform_data		= &dbgu_data,
+	},
+	.resource	= dbgu_resources,
+	.num_resources	= ARRAY_SIZE(dbgu_resources),
+};
+
+static struct resource uart0_resources[] = {
+	[0] = {
+		.end	= SZ_16K,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct atmel_uart_data uart0_data;
+static u64 uart0_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device at91_uart0_device = {
+	.name		= "atmel_usart",
+	.id		= 1,
+	.dev		= {
+				.dma_mask		= &uart0_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+				.platform_data		= &uart0_data,
+	},
+	.resource	= uart0_resources,
+	.num_resources	= ARRAY_SIZE(uart0_resources),
+};
+
+static struct resource uart1_resources[] = {
+	[0] = {
+		.end	= SZ_16K,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct atmel_uart_data uart1_data;
+static u64 uart1_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device at91_uart1_device = {
+	.name		= "atmel_usart",
+	.id		= 2,
+	.dev		= {
+				.dma_mask		= &uart1_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+				.platform_data		= &uart1_data,
+	},
+	.resource	= uart1_resources,
+	.num_resources	= ARRAY_SIZE(uart1_resources),
+};
+
+static struct resource uart2_resources[] = {
+	[0] = {
+		.end	= SZ_16K,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct atmel_uart_data uart2_data;
+static u64 uart2_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device at91_uart2_device = {
+	.name		= "atmel_usart",
+	.id		= 3,
+	.dev		= {
+				.dma_mask		= &uart2_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+				.platform_data		= &uart2_data,
+	},
+	.resource	= uart2_resources,
+	.num_resources	= ARRAY_SIZE(uart2_resources),
+};
+
+static struct resource uart3_resources[] = {
+	[0] = {
+		.end	= SZ_16K,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct atmel_uart_data uart3_data;
+static u64 uart3_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device at91_uart3_device = {
+	.name		= "atmel_usart",
+	.id		= 4,
+	.dev		= {
+				.dma_mask		= &uart3_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+				.platform_data		= &uart3_data,
+	},
+	.resource	= uart3_resources,
+	.num_resources	= ARRAY_SIZE(uart3_resources),
+};
+
+static struct resource uart4_resources[] = {
+	[0] = {
+		.end	= SZ_16K,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct atmel_uart_data uart4_data;
+static u64 uart4_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device at91_uart4_device = {
+	.name		= "atmel_usart",
+	.id		= 5,
+	.dev		= {
+				.dma_mask		= &uart4_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+				.platform_data		= &uart4_data,
+	},
+	.resource	= uart4_resources,
+	.num_resources	= ARRAY_SIZE(uart4_resources),
+};
+
+static struct resource uart5_resources[] = {
+	[0] = {
+		.end	= SZ_16K,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct atmel_uart_data uart5_data;
+static u64 uart5_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device at91_uart5_device = {
+	.name		= "atmel_usart",
+	.id		= 6,
+	.dev		= {
+				.dma_mask		= &uart5_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+				.platform_data		= &uart5_data,
+	},
+	.resource	= uart5_resources,
+	.num_resources	= ARRAY_SIZE(uart5_resources),
+};
+
+/* the UARTs to use */
+static struct platform_device *__initdata at91_uarts[ATMEL_MAX_UART];
+/* the serial console device */
+struct platform_device *atmel_default_console_device;
+
+static void __init configure_uart(struct atmel_uart_data *uart_data,
+				  struct resource *uart_res,
+				  struct at91_dev_table_uart *uart,
+				  unsigned pins)
+{
+	init_resource_mem(&uart_res[0], uart->mmio_base);
+	init_resource_irq(&uart_res[1], uart->irq);
+	memcpy(uart_data, &uart->uart_data, sizeof(struct atmel_uart_data));
+
+	at91_config_pins(&uart->tx_pin, 1);
+	at91_config_pins(&uart->rx_pin, 1);
+	
+	if (pins & ATMEL_UART_RTS)
+		at91_config_pins(&uart->rts_pin, 1);
+	if (pins & ATMEL_UART_CTS)
+		at91_config_pins(&uart->cts_pin, 1);
+	if (pins & ATMEL_UART_RI)
+		at91_config_pins(&uart->ri_pin, 1);
+	if (pins & ATMEL_UART_DTR)
+		at91_config_pins(&uart->dtr_pin, 1);
+	if (pins & ATMEL_UART_DCD)
+		at91_config_pins(&uart->dcd_pin, 1);
+	if (pins & ATMEL_UART_DSR)
+		at91_config_pins(&uart->dsr_pin, 1);
+}
+
+void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
+{
+	struct platform_device *pdev;
+	struct at91_dev_table_uart *uart;
+	struct atmel_uart_data *uart_data;
+	struct resource *uart_res;
+	
+	BUG_ON(id < 0 || id > ARRAY_SIZE(devices->uart));
+	if (id == 0)
+		uart = devices->dbgu;
+	else
+		uart = devices->uart[id - 1];
+	BUG_ON(!uart);
+	
+	switch (id) {
+	case AT91_UART_DBGU:
+		pdev 	  = &at91_dbgu_device;
+		uart_data = &dbgu_data;
+		uart_res  = dbgu_resources;
+		break;
+	case AT91_UART_US0:
+		pdev 	  = &at91_uart0_device;
+		uart_data = &uart0_data;
+		uart_res  = uart0_resources;
+		break;
+	case AT91_UART_US1:
+		pdev 	  = &at91_uart1_device;
+		uart_data = &uart1_data;
+		uart_res  = uart1_resources;
+		break;
+	case AT91_UART_US2:
+		pdev 	  = &at91_uart2_device;
+		uart_data = &uart2_data;
+		uart_res  = uart2_resources;
+		break;
+	case AT91_UART_US3:
+		pdev 	  = &at91_uart3_device;
+		uart_data = &uart3_data;
+		uart_res  = uart3_resources;
+		break;
+	case AT91_UART_US4:
+		pdev 	  = &at91_uart4_device;
+		uart_data = &uart4_data;
+		uart_res  = uart4_resources;
+		break;
+	case AT91_UART_US5:
+		pdev 	  = &at91_uart5_device;
+		uart_data = &uart5_data;
+		uart_res  = uart5_resources;
+		break;
+	default:
+		return;
+	}
+	
+	configure_uart(uart_data, uart_res, uart, pins);
+	if (uart->clock_asc)
+		at91_clock_associate(uart->clock_asc, &pdev->dev, "usart");
+	pdev->id = portnr;		/* update to mapped ID */
+	
+	if (portnr < ATMEL_MAX_UART)
+		at91_uarts[portnr] = pdev;
+}
+
+void __init at91_set_serial_console(unsigned portnr)
+{
+	if (portnr < ATMEL_MAX_UART)
+		atmel_default_console_device = at91_uarts[portnr];
+}
+
+void __init at91_add_device_serial(void)
+{
+	int i;
+
+	for (i = 0; i < ATMEL_MAX_UART; i++) {
+		if (at91_uarts[i])
+			platform_device_register(at91_uarts[i]);
+	}
+
+	if (!atmel_default_console_device)
+		printk(KERN_INFO "AT91: No default serial console defined.\n");
+}
+
+#else
+void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins) {}
+void __init at91_set_serial_console(unsigned portnr) {}
+void __init at91_add_device_serial(void) {}
+#endif
+
 static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_tc();
diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
index d7855ec..c535f58 100644
--- a/arch/arm/mach-at91/devices.h
+++ b/arch/arm/mach-at91/devices.h
@@ -107,6 +107,21 @@ struct at91_dev_table_rtt {
 	unsigned		mmio_base;
 };
 
+struct at91_dev_table_uart {
+	unsigned		mmio_base;
+	int			irq;
+	struct atmel_uart_data	uart_data;
+	const char		*clock_asc;
+	struct at91_pin_config	tx_pin;
+	struct at91_pin_config	rx_pin;
+	struct at91_pin_config	rts_pin;
+	struct at91_pin_config	cts_pin;
+	struct at91_pin_config	ri_pin;
+	struct at91_pin_config	dtr_pin;
+	struct at91_pin_config	dcd_pin;
+	struct at91_pin_config	dsr_pin;
+};
+
 struct at91_device_table {
 	struct at91_dev_table_ethernet		*ethernet;
 	struct at91_dev_table_usb_ohci		*usbh_ohci;
@@ -118,6 +133,8 @@ struct at91_device_table {
 	struct at91_dev_table_spi		*spi[2];
 	struct at91_dev_table_tcb		*tcb[2];
 	struct at91_dev_table_rtt		*rtt[2];
+	struct at91_dev_table_uart		*dbgu;
+	struct at91_dev_table_uart		*uart[6];
 };
 
 extern void __init at91_init_devices(struct at91_device_table *device_table);
diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index 94232a4..25a6127 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -122,6 +122,16 @@ extern void __init at91_add_device_i2c(short i2c_id, struct i2c_board_info *devi
 extern void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices);
 
  /* Serial */
+enum {
+	AT91_UART_DBGU = 0,
+	AT91_UART_US0,
+	AT91_UART_US1,
+	AT91_UART_US2,
+	AT91_UART_US3,
+	AT91_UART_US4,
+	AT91_UART_US5,
+};
+
 #define ATMEL_UART_CTS	0x01
 #define ATMEL_UART_RTS	0x02
 #define ATMEL_UART_DSR	0x04
-- 
1.7.0.4
