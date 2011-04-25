From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 25 Apr 2011 20:31:16 +0200
Subject: [PATCH 06/14 v3] at91: switch to CLKDEV_LOOKUP
In-Reply-To: <20110425180847.GA12904@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
Message-ID: <1303756284-26529-6-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

we do not change the clock naming convention so does not need to switch
the AVR32 yet

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
v3:
	udpate at91x40

Best Regards,
J.
 arch/arm/Kconfig                         |    1 +
 arch/arm/mach-at91/at572d940hf.c         |   64 +++++++++++++++++++++++
 arch/arm/mach-at91/at572d940hf_devices.c |   22 ++++----
 arch/arm/mach-at91/at91cap9.c            |   58 ++++++++++++++++++++
 arch/arm/mach-at91/at91cap9_devices.c    |   28 ++++------
 arch/arm/mach-at91/at91rm9200.c          |   50 ++++++++++++++++++
 arch/arm/mach-at91/at91rm9200_devices.c  |   28 ++++------
 arch/arm/mach-at91/at91sam9260.c         |   51 ++++++++++++++++++
 arch/arm/mach-at91/at91sam9260_devices.c |   31 ++++-------
 arch/arm/mach-at91/at91sam9261.c         |   55 +++++++++++++++++++
 arch/arm/mach-at91/at91sam9261_devices.c |   26 ++++-----
 arch/arm/mach-at91/at91sam9263.c         |   54 +++++++++++++++++++
 arch/arm/mach-at91/at91sam9263_devices.c |   24 ++++----
 arch/arm/mach-at91/at91sam9g45.c         |   84 +++++++++++++++++++++++-------
 arch/arm/mach-at91/at91sam9g45_devices.c |   31 ++++-------
 arch/arm/mach-at91/at91sam9rl.c          |   51 ++++++++++++++++++
 arch/arm/mach-at91/at91sam9rl_devices.c  |   27 ++++-----
 arch/arm/mach-at91/at91x40.c             |    5 --
 arch/arm/mach-at91/clock.c               |   54 +++++--------------
 arch/arm/mach-at91/clock.h               |   19 ++++++-
 arch/arm/mach-at91/generic.h             |   12 ++++-
 arch/arm/mach-at91/include/mach/clkdev.h |    7 +++
 22 files changed, 595 insertions(+), 187 deletions(-)
 create mode 100644 arch/arm/mach-at91/include/mach/clkdev.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 377a7a5..920273d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -288,6 +288,7 @@ config ARCH_AT91
 	bool "Atmel AT91"
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_CLK
+	select CLKDEV_LOOKUP
 	help
 	  This enables support for systems based on the Atmel AT91RM9200,
 	  AT91SAM9 and AT91CAP9 processors.
diff --git a/arch/arm/mach-at91/at572d940hf.c b/arch/arm/mach-at91/at572d940hf.c
index 15ecb64..b9c48d5 100644
--- a/arch/arm/mach-at91/at572d940hf.c
+++ b/arch/arm/mach-at91/at572d940hf.c
@@ -201,6 +201,37 @@ static struct clk *periph_clocks[] __initdata = {
 	/* irq0 .. irq2 */
 };
 
+static struct clk_lookup periph_clocks_lookups[] = {
+	CLKDEV_CON_ID("pioA_clk", &pioA_clk),
+	CLKDEV_CON_ID("pioB_clk", &pioB_clk),
+	CLKDEV_CON_ID("pioC_clk", &pioC_clk),
+	CLKDEV_CON_ID("macb_clk", &macb_clk),
+	CLKDEV_CON_ID("mci_clk", &mmc_clk),
+	CLKDEV_CON_ID("udc_clk", &udc_clk),
+	CLKDEV_CON_ID("twi0_clk", &twi0_clk),
+	CLKDEV_CON_ID("ssc0_clk", &ssc0_clk),
+	CLKDEV_CON_ID("ssc1_clk", &ssc1_clk),
+	CLKDEV_CON_ID("ssc2_clk", &ssc2_clk),
+	CLKDEV_CON_ID("ohci_clk", &ohci_clk),
+	CLKDEV_CON_ID("ssc3_clk", &ssc3_clk),
+	CLKDEV_CON_ID("twi1_clk", &twi1_clk),
+	CLKDEV_CON_ID("can0_clk", &can0_clk),
+	CLKDEV_CON_ID("can1_clk", &can1_clk),
+	CLKDEV_CON_ID("mAgicV_clk", &mAgicV_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.0", &spi0_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.1", &spi1_clk),
+	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tc0_clk),
+	CLKDEV_CON_DEV_ID("t1_clk", "atmel_tcb.0", &tc1_clk),
+	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.0", &tc2_clk),
+};
+
+static struct clk_lookup usart_clocks_lookups[] = {
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.0", &mck),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.1", &usart0_clk),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.2", &usart1_clk),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.3", &usart2_clk),
+};
+
 /*
  * The five programmable clocks.
  * You must configure pin multiplexing to bring these signals out.
@@ -230,6 +261,13 @@ static struct clk pck3 = {
 	.id		= 3,
 };
 
+static struct clk_lookup program_clocks_lookups[] = {
+	CLKDEV_CON_ID("pck0", &pck0),
+	CLKDEV_CON_ID("pck1", &pck1),
+	CLKDEV_CON_ID("pck2", &pck2),
+	CLKDEV_CON_ID("pck3", &pck3),
+};
+
 static struct clk mAgicV_mem_clk = {
 	.name		= "mAgicV_mem_clk",
 	.pmc_mask	= AT91_PMC_PCK4,
@@ -237,6 +275,9 @@ static struct clk mAgicV_mem_clk = {
 	.id		= 4,
 };
 
+static struct clk_lookup mAgicV_mem_clk_lookup =
+	CLKDEV_CON_ID("mAgicV_mem_clk", &mAgicV_mem_clk);
+
 /* HClocks */
 static struct clk hck0 = {
 	.name		= "hck0",
@@ -251,6 +292,11 @@ static struct clk hck1 = {
 	.id		= 1,
 };
 
+static struct clk_lookup hc_clocks_lookups[] = {
+	CLKDEV_CON_ID("hck0", &hck0),
+	CLKDEV_CON_ID("hck1", &hck1),
+};
+
 static void __init at572d940hf_register_clocks(void)
 {
 	int i;
@@ -258,14 +304,32 @@ static void __init at572d940hf_register_clocks(void)
 	for (i = 0; i < ARRAY_SIZE(periph_clocks); i++)
 		clk_register(periph_clocks[i]);
 
+	clkdev_add_table(periph_clocks_lookups,
+			 ARRAY_SIZE(periph_clocks_lookups));
+
 	clk_register(&pck0);
 	clk_register(&pck1);
 	clk_register(&pck2);
 	clk_register(&pck3);
+
+	clkdev_add_table(program_clocks_lookups,
+			 ARRAY_SIZE(program_clocks_lookups));
+
 	clk_register(&mAgicV_mem_clk);
+	clkdev_add(&mAgicV_mem_clk_lookup);
 
 	clk_register(&hck0);
 	clk_register(&hck1);
+
+	clkdev_add_table(hc_clocks_lookups,
+			 ARRAY_SIZE(hc_clocks_lookups));
+}
+
+struct clk* __init at572d940hf_get_uart_clock(int id)
+{
+	if (id >= ARRAY_SIZE(usart_clocks_lookups))
+		return NULL;
+	return usart_clocks_lookups[id].clk;
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at572d940hf_devices.c b/arch/arm/mach-at91/at572d940hf_devices.c
index e52c8e0..84e0b07 100644
--- a/arch/arm/mach-at91/at572d940hf_devices.c
+++ b/arch/arm/mach-at91/at572d940hf_devices.c
@@ -532,7 +532,6 @@ void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
 		at91_set_A_periph(AT91_PIN_PA1, 0);	/* SPI0_MOSI */
 		at91_set_A_periph(AT91_PIN_PA2, 0);	/* SPI0_SPCK */
 
-		at91_clock_associate("spi0_clk", &at572d940hf_spi0_device.dev, "spi_clk");
 		platform_device_register(&at572d940hf_spi0_device);
 	}
 	if (enable_spi1) {
@@ -540,7 +539,6 @@ void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
 		at91_set_A_periph(AT91_PIN_PC1, 0);	/* SPI1_MOSI */
 		at91_set_A_periph(AT91_PIN_PC2, 0);	/* SPI1_SPCK */
 
-		at91_clock_associate("spi1_clk", &at572d940hf_spi1_device.dev, "spi_clk");
 		platform_device_register(&at572d940hf_spi1_device);
 	}
 }
@@ -588,9 +586,6 @@ static struct platform_device at572d940hf_tcb_device = {
 static void __init at91_add_device_tc(void)
 {
 	/* this chip has a separate clock and irq for each TC channel */
-	at91_clock_associate("tc0_clk", &at572d940hf_tcb_device.dev, "t0_clk");
-	at91_clock_associate("tc1_clk", &at572d940hf_tcb_device.dev, "t1_clk");
-	at91_clock_associate("tc2_clk", &at572d940hf_tcb_device.dev, "t2_clk");
 	platform_device_register(&at572d940hf_tcb_device);
 }
 #else
@@ -828,22 +823,18 @@ void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
 		case 0:		/* DBGU */
 			pdev = &at572d940hf_dbgu_device;
 			configure_dbgu_pins();
-			at91_clock_associate("mck", &pdev->dev, "usart");
 			break;
 		case AT572D940HF_ID_US0:
 			pdev = &at572d940hf_uart0_device;
 			configure_usart0_pins(pins);
-			at91_clock_associate("usart0_clk", &pdev->dev, "usart");
 			break;
 		case AT572D940HF_ID_US1:
 			pdev = &at572d940hf_uart1_device;
 			configure_usart1_pins(pins);
-			at91_clock_associate("usart1_clk", &pdev->dev, "usart");
 			break;
 		case AT572D940HF_ID_US2:
 			pdev = &at572d940hf_uart2_device;
 			configure_usart2_pins(pins);
-			at91_clock_associate("usart2_clk", &pdev->dev, "usart");
 			break;
 		default:
 			return;
@@ -855,10 +846,21 @@ void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
 		at91_uarts[portnr] = pdev;
 }
 
+static struct clk_lookup console_lookups = {
+	.con_id = "usart",
+};
+
 void __init at91_set_serial_console(unsigned portnr)
 {
-	if (portnr < ATMEL_MAX_UART)
+	struct atmel_uart_data *pdata;
+
+	if (portnr < ATMEL_MAX_UART) {
 		atmel_default_console_device = at91_uarts[portnr];
+
+		pdata = atmel_default_console_device->dev.platform_data;
+		console_lookups.clk = at572d940hf_get_uart_clock(pdata->num);
+		clkdev_add(&console_lookups);
+	}
 }
 
 void __init at91_add_device_serial(void)
diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index 6bf8eba..1ba614a1 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -218,6 +218,44 @@ static struct clk *periph_clocks[] __initdata = {
 	// irq0 .. irq1
 };
 
+static struct clk_lookup periph_clocks_lookups[] = {
+	CLKDEV_CON_ID("pioABCD_clk", &pioABCD_clk),
+	CLKDEV_CON_ID("mpb0_clk", &mpb0_clk),
+	CLKDEV_CON_ID("mpb1_clk", &mpb1_clk),
+	CLKDEV_CON_ID("mpb2_clk", &mpb2_clk),
+	CLKDEV_CON_ID("mpb3_clk", &mpb3_clk),
+	CLKDEV_CON_ID("mpb4_clk", &mpb4_clk),
+	CLKDEV_CON_ID("can_clk", &can_clk),
+	CLKDEV_CON_ID("twi_clk", &twi_clk),
+	CLKDEV_CON_ID("ac97_clk", &ac97_clk),
+	CLKDEV_CON_ID("tcb_clk", &tcb_clk),
+	CLKDEV_CON_ID("pwm_clk", &pwm_clk),
+	CLKDEV_CON_ID("macb_clk", &macb_clk),
+	CLKDEV_CON_ID("aestdes_clk", &aestdes_clk),
+	CLKDEV_CON_ID("adc_clk", &adc_clk),
+	CLKDEV_CON_ID("isi_clk", &isi_clk),
+	CLKDEV_CON_ID("lcdc_clk", &lcdc_clk),
+	CLKDEV_CON_ID("dma_clk", &dma_clk),
+	CLKDEV_CON_ID("udphs_clk", &udphs_clk),
+	CLKDEV_CON_ID("ohci_clk", &ohci_clk),
+	CLKDEV_CON_DEV_ID("hclk", "atmel_usba_udc.0", &utmi_clk),
+	CLKDEV_CON_DEV_ID("pclk", "atmel_usba_udc.0", &udphs_clk),
+	CLKDEV_CON_DEV_ID("mci_clk", "at91_mci.0", &mmc0_clk),
+	CLKDEV_CON_DEV_ID("mci_clk", "at91_mci.1", &mmc1_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.0", &spi0_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.1", &spi1_clk),
+	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tcb_clk),
+	CLKDEV_CON_DEV_ID("ssc", "ssc.0", &ssc0_clk),
+	CLKDEV_CON_DEV_ID("ssc", "ssc.1", &ssc1_clk),
+};
+
+static struct clk_lookup usart_clocks_lookups[] = {
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.0", &mck),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.1", &usart0_clk),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.2", &usart1_clk),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.3", &usart2_clk),
+};
+
 /*
  * The four programmable clocks.
  * You must configure pin multiplexing to bring these signals out.
@@ -247,6 +285,13 @@ static struct clk pck3 = {
 	.id		= 3,
 };
 
+static struct clk_lookup program_clocks_lookups[] = {
+	CLKDEV_CON_ID("pck0", &pck0),
+	CLKDEV_CON_ID("pck1", &pck1),
+	CLKDEV_CON_ID("pck2", &pck2),
+	CLKDEV_CON_ID("pck3", &pck3),
+};
+
 static void __init at91cap9_register_clocks(void)
 {
 	int i;
@@ -254,10 +299,23 @@ static void __init at91cap9_register_clocks(void)
 	for (i = 0; i < ARRAY_SIZE(periph_clocks); i++)
 		clk_register(periph_clocks[i]);
 
+	clkdev_add_table(periph_clocks_lookups,
+			 ARRAY_SIZE(periph_clocks_lookups));
+
 	clk_register(&pck0);
 	clk_register(&pck1);
 	clk_register(&pck2);
 	clk_register(&pck3);
+
+	clkdev_add_table(program_clocks_lookups,
+			 ARRAY_SIZE(program_clocks_lookups));
+}
+
+struct clk* __init at91cap9_get_uart_clock(int id)
+{
+	if (id >= ARRAY_SIZE(usart_clocks_lookups))
+		return NULL;
+	return usart_clocks_lookups[id].clk;
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index eae412c..0537e15 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -181,10 +181,6 @@ void __init at91_add_device_usba(struct usba_platform_data *data)
 
 	/* Pullup pin is handled internally by USB device peripheral */
 
-	/* Clocks */
-	at91_clock_associate("utmi_clk", &at91_usba_udc_device.dev, "hclk");
-	at91_clock_associate("udphs_clk", &at91_usba_udc_device.dev, "pclk");
-
 	platform_device_register(&at91_usba_udc_device);
 }
 #else
@@ -355,7 +351,6 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
 		}
 
 		mmc0_data = *data;
-		at91_clock_associate("mci0_clk", &at91cap9_mmc0_device.dev, "mci_clk");
 		platform_device_register(&at91cap9_mmc0_device);
 	} else {			/* MCI1 */
 		/* CLK */
@@ -373,7 +368,6 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
 		}
 
 		mmc1_data = *data;
-		at91_clock_associate("mci1_clk", &at91cap9_mmc1_device.dev, "mci_clk");
 		platform_device_register(&at91cap9_mmc1_device);
 	}
 }
@@ -614,7 +608,6 @@ void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
 		at91_set_B_periph(AT91_PIN_PA1, 0);	/* SPI0_MOSI */
 		at91_set_B_periph(AT91_PIN_PA2, 0);	/* SPI0_SPCK */
 
-		at91_clock_associate("spi0_clk", &at91cap9_spi0_device.dev, "spi_clk");
 		platform_device_register(&at91cap9_spi0_device);
 	}
 	if (enable_spi1) {
@@ -622,7 +615,6 @@ void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
 		at91_set_A_periph(AT91_PIN_PB13, 0);	/* SPI1_MOSI */
 		at91_set_A_periph(AT91_PIN_PB14, 0);	/* SPI1_SPCK */
 
-		at91_clock_associate("spi1_clk", &at91cap9_spi1_device.dev, "spi_clk");
 		platform_device_register(&at91cap9_spi1_device);
 	}
 }
@@ -660,7 +652,6 @@ static struct platform_device at91cap9_tcb_device = {
 static void __init at91_add_device_tc(void)
 {
 	/* this chip has one clock and irq for all three TC channels */
-	at91_clock_associate("tcb_clk", &at91cap9_tcb_device.dev, "t0_clk");
 	platform_device_register(&at91cap9_tcb_device);
 }
 #else
@@ -1001,12 +992,10 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins)
 	case AT91CAP9_ID_SSC0:
 		pdev = &at91cap9_ssc0_device;
 		configure_ssc0_pins(pins);
-		at91_clock_associate("ssc0_clk", &pdev->dev, "ssc");
 		break;
 	case AT91CAP9_ID_SSC1:
 		pdev = &at91cap9_ssc1_device;
 		configure_ssc1_pins(pins);
-		at91_clock_associate("ssc1_clk", &pdev->dev, "ssc");
 		break;
 	default:
 		return;
@@ -1205,22 +1194,18 @@ void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
 		case 0:		/* DBGU */
 			pdev = &at91cap9_dbgu_device;
 			configure_dbgu_pins();
-			at91_clock_associate("mck", &pdev->dev, "usart");
 			break;
 		case AT91CAP9_ID_US0:
 			pdev = &at91cap9_uart0_device;
 			configure_usart0_pins(pins);
-			at91_clock_associate("usart0_clk", &pdev->dev, "usart");
 			break;
 		case AT91CAP9_ID_US1:
 			pdev = &at91cap9_uart1_device;
 			configure_usart1_pins(pins);
-			at91_clock_associate("usart1_clk", &pdev->dev, "usart");
 			break;
 		case AT91CAP9_ID_US2:
 			pdev = &at91cap9_uart2_device;
 			configure_usart2_pins(pins);
-			at91_clock_associate("usart2_clk", &pdev->dev, "usart");
 			break;
 		default:
 			return;
@@ -1232,10 +1217,21 @@ void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
 		at91_uarts[portnr] = pdev;
 }
 
+static struct clk_lookup console_lookups = {
+	.con_id = "usart",
+};
+
 void __init at91_set_serial_console(unsigned portnr)
 {
-	if (portnr < ATMEL_MAX_UART)
+	struct atmel_uart_data *pdata;
+
+	if (portnr < ATMEL_MAX_UART) {
 		atmel_default_console_device = at91_uarts[portnr];
+
+		pdata = atmel_default_console_device->dev.platform_data;
+		console_lookups.clk = at91cap9_get_uart_clock(pdata->num);
+		clkdev_add(&console_lookups);
+	}
 }
 
 void __init at91_add_device_serial(void)
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index afb29b9..29a2a8a 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -188,6 +188,36 @@ static struct clk *periph_clocks[] __initdata = {
 	// irq0 .. irq6
 };
 
+static struct clk_lookup periph_clocks_lookups[] = {
+	CLKDEV_CON_ID("udc_clk", &udc_clk),
+	CLKDEV_CON_ID("ohci_clk", &ohci_clk),
+	CLKDEV_CON_ID("ether_clk", &ether_clk),
+	CLKDEV_CON_ID("mci_clk", &mmc_clk),
+	CLKDEV_CON_ID("twi_clk", &twi_clk),
+	CLKDEV_CON_ID("spi_clk", &spi_clk),
+	CLKDEV_CON_ID("pioA_clk", &pioA_clk),
+	CLKDEV_CON_ID("pioB_clk", &pioB_clk),
+	CLKDEV_CON_ID("pioC_clk", &pioC_clk),
+	CLKDEV_CON_ID("pioD_clk", &pioD_clk),
+	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tc0_clk),
+	CLKDEV_CON_DEV_ID("t1_clk", "atmel_tcb.0", &tc1_clk),
+	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.0", &tc2_clk),
+	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.1", &tc3_clk),
+	CLKDEV_CON_DEV_ID("t1_clk", "atmel_tcb.1", &tc4_clk),
+	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.1", &tc5_clk),
+	CLKDEV_CON_DEV_ID("ssc", "ssc.0", &ssc0_clk),
+	CLKDEV_CON_DEV_ID("ssc", "ssc.1", &ssc1_clk),
+	CLKDEV_CON_DEV_ID("ssc", "ssc.2", &ssc2_clk),
+};
+
+static struct clk_lookup usart_clocks_lookups[] = {
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.0", &mck),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.1", &usart0_clk),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.2", &usart1_clk),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.3", &usart2_clk),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.4", &usart3_clk),
+};
+
 /*
  * The four programmable clocks.
  * You must configure pin multiplexing to bring these signals out.
@@ -217,6 +247,13 @@ static struct clk pck3 = {
 	.id		= 3,
 };
 
+static struct clk_lookup program_clocks_lookups[] = {
+	CLKDEV_CON_ID("pck0", &pck0),
+	CLKDEV_CON_ID("pck1", &pck1),
+	CLKDEV_CON_ID("pck2", &pck2),
+	CLKDEV_CON_ID("pck3", &pck3),
+};
+
 static void __init at91rm9200_register_clocks(void)
 {
 	int i;
@@ -224,10 +261,23 @@ static void __init at91rm9200_register_clocks(void)
 	for (i = 0; i < ARRAY_SIZE(periph_clocks); i++)
 		clk_register(periph_clocks[i]);
 
+	clkdev_add_table(periph_clocks_lookups,
+			 ARRAY_SIZE(periph_clocks_lookups));
+
 	clk_register(&pck0);
 	clk_register(&pck1);
 	clk_register(&pck2);
 	clk_register(&pck3);
+
+	clkdev_add_table(program_clocks_lookups,
+			 ARRAY_SIZE(program_clocks_lookups));
+}
+
+struct clk* __init at91rm9200_get_uart_clock(int id)
+{
+	if (id >= ARRAY_SIZE(usart_clocks_lookups))
+		return NULL;
+	return usart_clocks_lookups[id].clk;
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 761559e..81ba341 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -645,14 +645,7 @@ static struct platform_device at91rm9200_tcb1_device = {
 static void __init at91_add_device_tc(void)
 {
 	/* this chip has a separate clock and irq for each TC channel */
-	at91_clock_associate("tc0_clk", &at91rm9200_tcb0_device.dev, "t0_clk");
-	at91_clock_associate("tc1_clk", &at91rm9200_tcb0_device.dev, "t1_clk");
-	at91_clock_associate("tc2_clk", &at91rm9200_tcb0_device.dev, "t2_clk");
 	platform_device_register(&at91rm9200_tcb0_device);
-
-	at91_clock_associate("tc3_clk", &at91rm9200_tcb1_device.dev, "t0_clk");
-	at91_clock_associate("tc4_clk", &at91rm9200_tcb1_device.dev, "t1_clk");
-	at91_clock_associate("tc5_clk", &at91rm9200_tcb1_device.dev, "t2_clk");
 	platform_device_register(&at91rm9200_tcb1_device);
 }
 #else
@@ -849,17 +842,14 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins)
 	case AT91RM9200_ID_SSC0:
 		pdev = &at91rm9200_ssc0_device;
 		configure_ssc0_pins(pins);
-		at91_clock_associate("ssc0_clk", &pdev->dev, "ssc");
 		break;
 	case AT91RM9200_ID_SSC1:
 		pdev = &at91rm9200_ssc1_device;
 		configure_ssc1_pins(pins);
-		at91_clock_associate("ssc1_clk", &pdev->dev, "ssc");
 		break;
 	case AT91RM9200_ID_SSC2:
 		pdev = &at91rm9200_ssc2_device;
 		configure_ssc2_pins(pins);
-		at91_clock_associate("ssc2_clk", &pdev->dev, "ssc");
 		break;
 	default:
 		return;
@@ -1115,27 +1105,22 @@ void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
 		case 0:		/* DBGU */
 			pdev = &at91rm9200_dbgu_device;
 			configure_dbgu_pins();
-			at91_clock_associate("mck", &pdev->dev, "usart");
 			break;
 		case AT91RM9200_ID_US0:
 			pdev = &at91rm9200_uart0_device;
 			configure_usart0_pins(pins);
-			at91_clock_associate("usart0_clk", &pdev->dev, "usart");
 			break;
 		case AT91RM9200_ID_US1:
 			pdev = &at91rm9200_uart1_device;
 			configure_usart1_pins(pins);
-			at91_clock_associate("usart1_clk", &pdev->dev, "usart");
 			break;
 		case AT91RM9200_ID_US2:
 			pdev = &at91rm9200_uart2_device;
 			configure_usart2_pins(pins);
-			at91_clock_associate("usart2_clk", &pdev->dev, "usart");
 			break;
 		case AT91RM9200_ID_US3:
 			pdev = &at91rm9200_uart3_device;
 			configure_usart3_pins(pins);
-			at91_clock_associate("usart3_clk", &pdev->dev, "usart");
 			break;
 		default:
 			return;
@@ -1147,10 +1132,21 @@ void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
 		at91_uarts[portnr] = pdev;
 }
 
+static struct clk_lookup console_lookups = {
+	.con_id = "usart",
+};
+
 void __init at91_set_serial_console(unsigned portnr)
 {
-	if (portnr < ATMEL_MAX_UART)
+	struct atmel_uart_data *pdata;
+
+	if (portnr < ATMEL_MAX_UART) {
 		atmel_default_console_device = at91_uarts[portnr];
+
+		pdata = atmel_default_console_device->dev.platform_data;
+		console_lookups.clk = at91rm9200_get_uart_clock(pdata->num);
+		clkdev_add(&console_lookups);
+	}
 }
 
 void __init at91_add_device_serial(void)
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 7bbdd2f..685a379 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -214,6 +214,39 @@ static struct clk *periph_clocks[] __initdata = {
 	// irq0 .. irq2
 };
 
+static struct clk_lookup periph_clocks_lookups[] = {
+	CLKDEV_CON_ID("pioA_clk", &pioA_clk),
+	CLKDEV_CON_ID("pioB_clk", &pioB_clk),
+	CLKDEV_CON_ID("pioC_clk", &pioC_clk),
+	CLKDEV_CON_ID("adc_clk", &adc_clk),
+	CLKDEV_CON_ID("mci_clk", &mmc_clk),
+	CLKDEV_CON_ID("udc_clk", &udc_clk),
+	CLKDEV_CON_ID("twi_clk", &twi_clk),
+	CLKDEV_CON_ID("ohci_clk", &ohci_clk),
+	CLKDEV_CON_ID("macb_clk", &macb_clk),
+	CLKDEV_CON_ID("isi_clk", &isi_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.0", &spi0_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.1", &spi1_clk),
+	/* this chip has a separate clock and irq for each TC channel */
+	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tc0_clk),
+	CLKDEV_CON_DEV_ID("t1_clk", "atmel_tcb.0", &tc1_clk),
+	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.0", &tc2_clk),
+	CLKDEV_CON_DEV_ID("t3_clk", "atmel_tcb.1", &tc3_clk),
+	CLKDEV_CON_DEV_ID("t4_clk", "atmel_tcb.1", &tc4_clk),
+	CLKDEV_CON_DEV_ID("t5_clk", "atmel_tcb.1", &tc5_clk),
+	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc_clk),
+};
+
+static struct clk_lookup usart_clocks_lookups[] = {
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.0", &mck),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.1", &usart0_clk),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.2", &usart1_clk),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.3", &usart2_clk),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.4", &usart3_clk),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.5", &usart4_clk),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.6", &usart5_clk),
+};
+
 /*
  * The two programmable clocks.
  * You must configure pin multiplexing to bring these signals out.
@@ -231,6 +264,11 @@ static struct clk pck1 = {
 	.id		= 1,
 };
 
+static struct clk_lookup program_clocks_lookups[] = {
+	CLKDEV_CON_ID("pck0", &pck0),
+	CLKDEV_CON_ID("pck1", &pck1),
+};
+
 static void __init at91sam9260_register_clocks(void)
 {
 	int i;
@@ -238,8 +276,21 @@ static void __init at91sam9260_register_clocks(void)
 	for (i = 0; i < ARRAY_SIZE(periph_clocks); i++)
 		clk_register(periph_clocks[i]);
 
+	clkdev_add_table(periph_clocks_lookups,
+			 ARRAY_SIZE(periph_clocks_lookups));
+
 	clk_register(&pck0);
 	clk_register(&pck1);
+
+	clkdev_add_table(program_clocks_lookups,
+			 ARRAY_SIZE(program_clocks_lookups));
+}
+
+struct clk* __init at91sam9260_get_uart_clock(int id)
+{
+	if (id >= ARRAY_SIZE(usart_clocks_lookups))
+		return NULL;
+	return usart_clocks_lookups[id].clk;
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 6f8ec8d..e323c17 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -609,7 +609,6 @@ void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
 		at91_set_A_periph(AT91_PIN_PA1, 0);	/* SPI0_MOSI */
 		at91_set_A_periph(AT91_PIN_PA2, 0);	/* SPI1_SPCK */
 
-		at91_clock_associate("spi0_clk", &at91sam9260_spi0_device.dev, "spi_clk");
 		platform_device_register(&at91sam9260_spi0_device);
 	}
 	if (enable_spi1) {
@@ -617,7 +616,6 @@ void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
 		at91_set_A_periph(AT91_PIN_PB1, 0);	/* SPI1_MOSI */
 		at91_set_A_periph(AT91_PIN_PB2, 0);	/* SPI1_SPCK */
 
-		at91_clock_associate("spi1_clk", &at91sam9260_spi1_device.dev, "spi_clk");
 		platform_device_register(&at91sam9260_spi1_device);
 	}
 }
@@ -694,15 +692,7 @@ static struct platform_device at91sam9260_tcb1_device = {
 
 static void __init at91_add_device_tc(void)
 {
-	/* this chip has a separate clock and irq for each TC channel */
-	at91_clock_associate("tc0_clk", &at91sam9260_tcb0_device.dev, "t0_clk");
-	at91_clock_associate("tc1_clk", &at91sam9260_tcb0_device.dev, "t1_clk");
-	at91_clock_associate("tc2_clk", &at91sam9260_tcb0_device.dev, "t2_clk");
 	platform_device_register(&at91sam9260_tcb0_device);
-
-	at91_clock_associate("tc3_clk", &at91sam9260_tcb1_device.dev, "t0_clk");
-	at91_clock_associate("tc4_clk", &at91sam9260_tcb1_device.dev, "t1_clk");
-	at91_clock_associate("tc5_clk", &at91sam9260_tcb1_device.dev, "t2_clk");
 	platform_device_register(&at91sam9260_tcb1_device);
 }
 #else
@@ -820,7 +810,6 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins)
 	case AT91SAM9260_ID_SSC:
 		pdev = &at91sam9260_ssc_device;
 		configure_ssc_pins(pins);
-		at91_clock_associate("ssc_clk", &pdev->dev, "pclk");
 		break;
 	default:
 		return;
@@ -1145,37 +1134,30 @@ void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
 		case 0:		/* DBGU */
 			pdev = &at91sam9260_dbgu_device;
 			configure_dbgu_pins();
-			at91_clock_associate("mck", &pdev->dev, "usart");
 			break;
 		case AT91SAM9260_ID_US0:
 			pdev = &at91sam9260_uart0_device;
 			configure_usart0_pins(pins);
-			at91_clock_associate("usart0_clk", &pdev->dev, "usart");
 			break;
 		case AT91SAM9260_ID_US1:
 			pdev = &at91sam9260_uart1_device;
 			configure_usart1_pins(pins);
-			at91_clock_associate("usart1_clk", &pdev->dev, "usart");
 			break;
 		case AT91SAM9260_ID_US2:
 			pdev = &at91sam9260_uart2_device;
 			configure_usart2_pins(pins);
-			at91_clock_associate("usart2_clk", &pdev->dev, "usart");
 			break;
 		case AT91SAM9260_ID_US3:
 			pdev = &at91sam9260_uart3_device;
 			configure_usart3_pins(pins);
-			at91_clock_associate("usart3_clk", &pdev->dev, "usart");
 			break;
 		case AT91SAM9260_ID_US4:
 			pdev = &at91sam9260_uart4_device;
 			configure_usart4_pins();
-			at91_clock_associate("usart4_clk", &pdev->dev, "usart");
 			break;
 		case AT91SAM9260_ID_US5:
 			pdev = &at91sam9260_uart5_device;
 			configure_usart5_pins();
-			at91_clock_associate("usart5_clk", &pdev->dev, "usart");
 			break;
 		default:
 			return;
@@ -1187,10 +1169,21 @@ void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
 		at91_uarts[portnr] = pdev;
 }
 
+static struct clk_lookup console_lookups = {
+	.con_id = "usart",
+};
+
 void __init at91_set_serial_console(unsigned portnr)
 {
-	if (portnr < ATMEL_MAX_UART)
+	struct atmel_uart_data *pdata;
+
+	if (portnr < ATMEL_MAX_UART) {
 		atmel_default_console_device = at91_uarts[portnr];
+
+		pdata = atmel_default_console_device->dev.platform_data;
+		console_lookups.clk = at91sam9260_get_uart_clock(pdata->num);
+		clkdev_add(&console_lookups);
+	}
 }
 
 void __init at91_add_device_serial(void)
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 768f4b7..bf28740 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -170,6 +170,33 @@ static struct clk *periph_clocks[] __initdata = {
 	// irq0 .. irq2
 };
 
+static struct clk_lookup periph_clocks_lookups[] = {
+	CLKDEV_CON_ID("pioA_clk", &pioA_clk),
+	CLKDEV_CON_ID("pioB_clk", &pioB_clk),
+	CLKDEV_CON_ID("pioC_clk", &pioC_clk),
+	CLKDEV_CON_ID("mci_clk", &mmc_clk),
+	CLKDEV_CON_ID("udc_clk", &udc_clk),
+	CLKDEV_CON_ID("twi_clk", &twi_clk),
+	CLKDEV_CON_ID("ohci_clk", &ohci_clk),
+	CLKDEV_CON_ID("lcdc_clk", &lcdc_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.0", &spi0_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.1", &spi1_clk),
+	/* this chip has a separate clock and irq for each TC channel */
+	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tc0_clk),
+	CLKDEV_CON_DEV_ID("t1_clk", "atmel_tcb.0", &tc1_clk),
+	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.0", &tc1_clk),
+	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
+	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
+	CLKDEV_CON_DEV_ID("pclk", "ssc.2", &ssc2_clk),
+};
+
+static struct clk_lookup usart_clocks_lookups[] = {
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.0", &mck),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.1", &usart0_clk),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.2", &usart1_clk),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.3", &usart2_clk),
+};
+
 /*
  * The four programmable clocks.
  * You must configure pin multiplexing to bring these signals out.
@@ -199,6 +226,13 @@ static struct clk pck3 = {
 	.id		= 3,
 };
 
+static struct clk_lookup program_clocks_lookups[] = {
+	CLKDEV_CON_ID("pck0", &pck0),
+	CLKDEV_CON_ID("pck1", &pck1),
+	CLKDEV_CON_ID("pck2", &pck2),
+	CLKDEV_CON_ID("pck3", &pck3),
+};
+
 /* HClocks */
 static struct clk hck0 = {
 	.name		= "hck0",
@@ -213,6 +247,11 @@ static struct clk hck1 = {
 	.id		= 1,
 };
 
+static struct clk_lookup hc_clocks_lookups[] = {
+	CLKDEV_CON_ID("hck0", &hck0),
+	CLKDEV_CON_ID("hck1", &hck1),
+};
+
 static void __init at91sam9261_register_clocks(void)
 {
 	int i;
@@ -220,13 +259,29 @@ static void __init at91sam9261_register_clocks(void)
 	for (i = 0; i < ARRAY_SIZE(periph_clocks); i++)
 		clk_register(periph_clocks[i]);
 
+	clkdev_add_table(periph_clocks_lookups,
+			 ARRAY_SIZE(periph_clocks_lookups));
+
 	clk_register(&pck0);
 	clk_register(&pck1);
 	clk_register(&pck2);
 	clk_register(&pck3);
 
+	clkdev_add_table(program_clocks_lookups,
+			 ARRAY_SIZE(program_clocks_lookups));
+
 	clk_register(&hck0);
 	clk_register(&hck1);
+
+	clkdev_add_table(hc_clocks_lookups,
+			 ARRAY_SIZE(hc_clocks_lookups));
+}
+
+struct clk* __init at91sam9261_get_uart_clock(int id)
+{
+	if (id >= ARRAY_SIZE(usart_clocks_lookups))
+		return NULL;
+	return usart_clocks_lookups[id].clk;
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 8792f9b..d078b16 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -426,7 +426,6 @@ void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
 		at91_set_A_periph(AT91_PIN_PA1, 0);	/* SPI0_MOSI */
 		at91_set_A_periph(AT91_PIN_PA2, 0);	/* SPI0_SPCK */
 
-		at91_clock_associate("spi0_clk", &at91sam9261_spi0_device.dev, "spi_clk");
 		platform_device_register(&at91sam9261_spi0_device);
 	}
 	if (enable_spi1) {
@@ -434,7 +433,6 @@ void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
 		at91_set_A_periph(AT91_PIN_PB31, 0);	/* SPI1_MOSI */
 		at91_set_A_periph(AT91_PIN_PB29, 0);	/* SPI1_SPCK */
 
-		at91_clock_associate("spi1_clk", &at91sam9261_spi1_device.dev, "spi_clk");
 		platform_device_register(&at91sam9261_spi1_device);
 	}
 }
@@ -581,10 +579,6 @@ static struct platform_device at91sam9261_tcb_device = {
 
 static void __init at91_add_device_tc(void)
 {
-	/* this chip has a separate clock and irq for each TC channel */
-	at91_clock_associate("tc0_clk", &at91sam9261_tcb_device.dev, "t0_clk");
-	at91_clock_associate("tc1_clk", &at91sam9261_tcb_device.dev, "t1_clk");
-	at91_clock_associate("tc2_clk", &at91sam9261_tcb_device.dev, "t2_clk");
 	platform_device_register(&at91sam9261_tcb_device);
 }
 #else
@@ -786,17 +780,14 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins)
 	case AT91SAM9261_ID_SSC0:
 		pdev = &at91sam9261_ssc0_device;
 		configure_ssc0_pins(pins);
-		at91_clock_associate("ssc0_clk", &pdev->dev, "pclk");
 		break;
 	case AT91SAM9261_ID_SSC1:
 		pdev = &at91sam9261_ssc1_device;
 		configure_ssc1_pins(pins);
-		at91_clock_associate("ssc1_clk", &pdev->dev, "pclk");
 		break;
 	case AT91SAM9261_ID_SSC2:
 		pdev = &at91sam9261_ssc2_device;
 		configure_ssc2_pins(pins);
-		at91_clock_associate("ssc2_clk", &pdev->dev, "pclk");
 		break;
 	default:
 		return;
@@ -995,22 +986,18 @@ void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
 		case 0:		/* DBGU */
 			pdev = &at91sam9261_dbgu_device;
 			configure_dbgu_pins();
-			at91_clock_associate("mck", &pdev->dev, "usart");
 			break;
 		case AT91SAM9261_ID_US0:
 			pdev = &at91sam9261_uart0_device;
 			configure_usart0_pins(pins);
-			at91_clock_associate("usart0_clk", &pdev->dev, "usart");
 			break;
 		case AT91SAM9261_ID_US1:
 			pdev = &at91sam9261_uart1_device;
 			configure_usart1_pins(pins);
-			at91_clock_associate("usart1_clk", &pdev->dev, "usart");
 			break;
 		case AT91SAM9261_ID_US2:
 			pdev = &at91sam9261_uart2_device;
 			configure_usart2_pins(pins);
-			at91_clock_associate("usart2_clk", &pdev->dev, "usart");
 			break;
 		default:
 			return;
@@ -1022,10 +1009,21 @@ void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
 		at91_uarts[portnr] = pdev;
 }
 
+static struct clk_lookup console_lookups = {
+	.con_id = "usart",
+};
+
 void __init at91_set_serial_console(unsigned portnr)
 {
-	if (portnr < ATMEL_MAX_UART)
+	struct atmel_uart_data *pdata;
+
+	if (portnr < ATMEL_MAX_UART) {
 		atmel_default_console_device = at91_uarts[portnr];
+
+		pdata = atmel_default_console_device->dev.platform_data;
+		console_lookups.clk = at91sam9261_get_uart_clock(pdata->num);
+		clkdev_add(&console_lookups);
+	}
 }
 
 void __init at91_add_device_serial(void)
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 97aae4f..763170b 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -195,6 +195,37 @@ static struct clk *periph_clocks[] __initdata = {
 	// irq0 .. irq1
 };
 
+static struct clk_lookup periph_clocks_lookups[] = {
+	CLKDEV_CON_ID("pioA_clk", &pioA_clk),
+	CLKDEV_CON_ID("pioB_clk", &pioB_clk),
+	CLKDEV_CON_ID("pioCDE_clk", &pioCDE_clk),
+	CLKDEV_CON_ID("can_clk", &can_clk),
+	CLKDEV_CON_ID("twi_clk", &twi_clk),
+	CLKDEV_CON_ID("ac97_clk", &ac97_clk),
+	CLKDEV_CON_ID("pwm_clk", &pwm_clk),
+	CLKDEV_CON_ID("macb_clk", &macb_clk),
+	CLKDEV_CON_ID("dma_clk", &dma_clk),
+	CLKDEV_CON_ID("2dge_clk", &twodge_clk),
+	CLKDEV_CON_ID("udc_clkk", &udc_clk),
+	CLKDEV_CON_ID("isi_clk", &isi_clk),
+	CLKDEV_CON_ID("lcdc_clk", &lcdc_clk),
+	CLKDEV_CON_ID("ohci_clk", &ohci_clk),
+	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
+	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
+	CLKDEV_CON_DEV_ID("mci_clk", "at91_mci.0", &mmc0_clk),
+	CLKDEV_CON_DEV_ID("mci_clk", "at91_mci.1", &mmc1_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.0", &spi0_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.1", &spi1_clk),
+	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tcb_clk),
+};
+
+static struct clk_lookup usart_clocks_lookups[] = {
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.0", &mck),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.1", &usart0_clk),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.2", &usart1_clk),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.3", &usart2_clk),
+};
+
 /*
  * The four programmable clocks.
  * You must configure pin multiplexing to bring these signals out.
@@ -224,6 +255,13 @@ static struct clk pck3 = {
 	.id		= 3,
 };
 
+static struct clk_lookup program_clocks_lookups[] = {
+	CLKDEV_CON_ID("pck0", &pck0),
+	CLKDEV_CON_ID("pck1", &pck1),
+	CLKDEV_CON_ID("pck2", &pck2),
+	CLKDEV_CON_ID("pck3", &pck3),
+};
+
 static void __init at91sam9263_register_clocks(void)
 {
 	int i;
@@ -231,10 +269,26 @@ static void __init at91sam9263_register_clocks(void)
 	for (i = 0; i < ARRAY_SIZE(periph_clocks); i++)
 		clk_register(periph_clocks[i]);
 
+	clkdev_add_table(periph_clocks_lookups,
+			 ARRAY_SIZE(periph_clocks_lookups));
+
+	clkdev_add_table(usart_clocks_lookups,
+			 ARRAY_SIZE(usart_clocks_lookups));
+
 	clk_register(&pck0);
 	clk_register(&pck1);
 	clk_register(&pck2);
 	clk_register(&pck3);
+
+	clkdev_add_table(program_clocks_lookups,
+			 ARRAY_SIZE(program_clocks_lookups));
+}
+
+struct clk* __init at91sam9263_get_uart_clock(int id)
+{
+	if (id >= ARRAY_SIZE(usart_clocks_lookups))
+		return NULL;
+	return usart_clocks_lookups[id].clk;
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 47a9f96..b84f178 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -308,7 +308,6 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
 		}
 
 		mmc0_data = *data;
-		at91_clock_associate("mci0_clk", &at91sam9263_mmc0_device.dev, "mci_clk");
 		platform_device_register(&at91sam9263_mmc0_device);
 	} else {			/* MCI1 */
 		/* CLK */
@@ -339,7 +338,6 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
 		}
 
 		mmc1_data = *data;
-		at91_clock_associate("mci1_clk", &at91sam9263_mmc1_device.dev, "mci_clk");
 		platform_device_register(&at91sam9263_mmc1_device);
 	}
 }
@@ -686,7 +684,6 @@ void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
 		at91_set_B_periph(AT91_PIN_PA1, 0);	/* SPI0_MOSI */
 		at91_set_B_periph(AT91_PIN_PA2, 0);	/* SPI0_SPCK */
 
-		at91_clock_associate("spi0_clk", &at91sam9263_spi0_device.dev, "spi_clk");
 		platform_device_register(&at91sam9263_spi0_device);
 	}
 	if (enable_spi1) {
@@ -694,7 +691,6 @@ void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
 		at91_set_A_periph(AT91_PIN_PB13, 0);	/* SPI1_MOSI */
 		at91_set_A_periph(AT91_PIN_PB14, 0);	/* SPI1_SPCK */
 
-		at91_clock_associate("spi1_clk", &at91sam9263_spi1_device.dev, "spi_clk");
 		platform_device_register(&at91sam9263_spi1_device);
 	}
 }
@@ -942,7 +938,6 @@ static struct platform_device at91sam9263_tcb_device = {
 static void __init at91_add_device_tc(void)
 {
 	/* this chip has one clock and irq for all three TC channels */
-	at91_clock_associate("tcb_clk", &at91sam9263_tcb_device.dev, "t0_clk");
 	platform_device_register(&at91sam9263_tcb_device);
 }
 #else
@@ -1171,12 +1166,10 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins)
 	case AT91SAM9263_ID_SSC0:
 		pdev = &at91sam9263_ssc0_device;
 		configure_ssc0_pins(pins);
-		at91_clock_associate("ssc0_clk", &pdev->dev, "pclk");
 		break;
 	case AT91SAM9263_ID_SSC1:
 		pdev = &at91sam9263_ssc1_device;
 		configure_ssc1_pins(pins);
-		at91_clock_associate("ssc1_clk", &pdev->dev, "pclk");
 		break;
 	default:
 		return;
@@ -1376,22 +1369,18 @@ void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
 		case 0:		/* DBGU */
 			pdev = &at91sam9263_dbgu_device;
 			configure_dbgu_pins();
-			at91_clock_associate("mck", &pdev->dev, "usart");
 			break;
 		case AT91SAM9263_ID_US0:
 			pdev = &at91sam9263_uart0_device;
 			configure_usart0_pins(pins);
-			at91_clock_associate("usart0_clk", &pdev->dev, "usart");
 			break;
 		case AT91SAM9263_ID_US1:
 			pdev = &at91sam9263_uart1_device;
 			configure_usart1_pins(pins);
-			at91_clock_associate("usart1_clk", &pdev->dev, "usart");
 			break;
 		case AT91SAM9263_ID_US2:
 			pdev = &at91sam9263_uart2_device;
 			configure_usart2_pins(pins);
-			at91_clock_associate("usart2_clk", &pdev->dev, "usart");
 			break;
 		default:
 			return;
@@ -1403,10 +1392,21 @@ void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
 		at91_uarts[portnr] = pdev;
 }
 
+static struct clk_lookup console_lookups = {
+	.con_id = "usart",
+};
+
 void __init at91_set_serial_console(unsigned portnr)
 {
-	if (portnr < ATMEL_MAX_UART)
+	struct atmel_uart_data *pdata;
+
+	if (portnr < ATMEL_MAX_UART) {
 		atmel_default_console_device = at91_uarts[portnr];
+
+		pdata = atmel_default_console_device->dev.platform_data;
+		console_lookups.clk = at91sam9263_get_uart_clock(pdata->num);
+		clkdev_add(&console_lookups);
+	}
 }
 
 void __init at91_add_device_serial(void)
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index b497614..a1561d4 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -180,22 +180,6 @@ static struct clk vdec_clk = {
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 
-/* One additional fake clock for ohci */
-static struct clk ohci_clk = {
-	.name		= "ohci_clk",
-	.pmc_mask	= 0,
-	.type		= CLK_TYPE_PERIPHERAL,
-	.parent		= &uhphs_clk,
-};
-
-/* One additional fake clock for second TC block */
-static struct clk tcb1_clk = {
-	.name		= "tcb1_clk",
-	.pmc_mask	= 0,
-	.type		= CLK_TYPE_PERIPHERAL,
-	.parent		= &tcb0_clk,
-};
-
 static struct clk *periph_clocks[] __initdata = {
 	&pioA_clk,
 	&pioB_clk,
@@ -224,10 +208,52 @@ static struct clk *periph_clocks[] __initdata = {
 	&udphs_clk,
 	&mmc1_clk,
 	// irq0
-	&ohci_clk,
-	&tcb1_clk,
 };
 
+static struct clk_lookup periph_clocks_lookups[] = {
+	CLKDEV_CON_ID("pioA_clk", &pioA_clk),
+	CLKDEV_CON_ID("pioB_clk", &pioB_clk),
+	CLKDEV_CON_ID("pioC_clk", &pioC_clk),
+	CLKDEV_CON_ID("pioDE_clk", &pioDE_clk),
+	CLKDEV_CON_ID("twi0_clk", &twi0_clk),
+	CLKDEV_CON_ID("twi1_clk", &twi1_clk),
+	CLKDEV_CON_ID("pwm_clk", &pwm_clk),
+	CLKDEV_CON_ID("tsc_clk", &tsc_clk),
+	CLKDEV_CON_ID("dma_clk", &dma_clk),
+	CLKDEV_CON_ID("uhphs_clk", &uhphs_clk),
+	CLKDEV_CON_ID("lcdc_clk", &lcdc_clk),
+	CLKDEV_CON_ID("ac97_clk", &ac97_clk),
+	CLKDEV_CON_ID("macb_clk", &macb_clk),
+	CLKDEV_CON_ID("isi_clk", &isi_clk),
+	CLKDEV_CON_ID("udphs_clk", &udphs_clk),
+	/* One additional fake clock for ohci */
+	CLKDEV_CON_ID("ohci_clk", &uhphs_clk),
+	CLKDEV_CON_DEV_ID("ehci_clk", "atmel-ehci.0", &uhphs_clk),
+	CLKDEV_CON_DEV_ID("hclk", "atmel_usba_udc.0", &utmi_clk),
+	CLKDEV_CON_DEV_ID("pclk", "atmel_usba_udc.0", &udphs_clk),
+	CLKDEV_CON_DEV_ID("mci_clk", "at91_mci.0", &mmc0_clk),
+	CLKDEV_CON_DEV_ID("mci_clk", "at91_mci.1", &mmc1_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.0", &spi0_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.1", &spi1_clk),
+	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tcb0_clk),
+	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.1", &tcb0_clk),
+	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
+	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
+};
+
+static struct clk_lookup usart_clocks_lookups[] = {
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.0", &mck),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.1", &usart0_clk),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.2", &usart1_clk),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.3", &usart2_clk),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.4", &usart3_clk),
+};
+
+
+/* Video decoder clock - Only for sam9m10/sam9m11 */
+static struct clk_lookup vdec_clk_lookup =
+	CLKDEV_CON_ID("vdec_clk", &vdec_clk);
+
 /*
  * The two programmable clocks.
  * You must configure pin multiplexing to bring these signals out.
@@ -245,6 +271,11 @@ static struct clk pck1 = {
 	.id		= 1,
 };
 
+static struct clk_lookup program_clocks_lookups[] = {
+	CLKDEV_CON_ID("pck0", &pck0),
+	CLKDEV_CON_ID("pck1", &pck1),
+};
+
 static void __init at91sam9g45_register_clocks(void)
 {
 	int i;
@@ -252,11 +283,26 @@ static void __init at91sam9g45_register_clocks(void)
 	for (i = 0; i < ARRAY_SIZE(periph_clocks); i++)
 		clk_register(periph_clocks[i]);
 
-	if (cpu_is_at91sam9m10() || cpu_is_at91sam9m11())
+	clkdev_add_table(periph_clocks_lookups,
+			 ARRAY_SIZE(periph_clocks_lookups));
+
+	if (cpu_is_at91sam9m10() || cpu_is_at91sam9m11()) {
 		clk_register(&vdec_clk);
+		clkdev_add(&vdec_clk_lookup);
+	}
 
 	clk_register(&pck0);
 	clk_register(&pck1);
+
+	clkdev_add_table(program_clocks_lookups,
+			 ARRAY_SIZE(program_clocks_lookups));
+}
+
+struct clk* __init at91sam9g45_get_uart_clock(int id)
+{
+	if (id >= ARRAY_SIZE(usart_clocks_lookups))
+		return NULL;
+	return usart_clocks_lookups[id].clk;
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 6c1a2fe..f9ac1da 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -180,7 +180,6 @@ void __init at91_add_device_usbh_ehci(struct at91_usbh_data *data)
 	}
 
 	usbh_ehci_data = *data;
-	at91_clock_associate("uhphs_clk", &at91_usbh_ehci_device.dev, "ehci_clk");
 	platform_device_register(&at91_usbh_ehci_device);
 }
 #else
@@ -266,10 +265,6 @@ void __init at91_add_device_usba(struct usba_platform_data *data)
 
 	/* Pullup pin is handled internally by USB device peripheral */
 
-	/* Clocks */
-	at91_clock_associate("utmi_clk", &at91_usba_udc_device.dev, "hclk");
-	at91_clock_associate("udphs_clk", &at91_usba_udc_device.dev, "pclk");
-
 	platform_device_register(&at91_usba_udc_device);
 }
 #else
@@ -478,7 +473,6 @@ void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data)
 		}
 
 		mmc0_data = *data;
-		at91_clock_associate("mci0_clk", &at91sam9g45_mmc0_device.dev, "mci_clk");
 		platform_device_register(&at91sam9g45_mmc0_device);
 
 	} else {			/* MCI1 */
@@ -504,7 +498,6 @@ void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data)
 		}
 
 		mmc1_data = *data;
-		at91_clock_associate("mci1_clk", &at91sam9g45_mmc1_device.dev, "mci_clk");
 		platform_device_register(&at91sam9g45_mmc1_device);
 
 	}
@@ -801,7 +794,6 @@ void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
 		at91_set_A_periph(AT91_PIN_PB1, 0);	/* SPI0_MOSI */
 		at91_set_A_periph(AT91_PIN_PB2, 0);	/* SPI0_SPCK */
 
-		at91_clock_associate("spi0_clk", &at91sam9g45_spi0_device.dev, "spi_clk");
 		platform_device_register(&at91sam9g45_spi0_device);
 	}
 	if (enable_spi1) {
@@ -809,7 +801,6 @@ void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
 		at91_set_A_periph(AT91_PIN_PB15, 0);	/* SPI1_MOSI */
 		at91_set_A_periph(AT91_PIN_PB16, 0);	/* SPI1_SPCK */
 
-		at91_clock_associate("spi1_clk", &at91sam9g45_spi1_device.dev, "spi_clk");
 		platform_device_register(&at91sam9g45_spi1_device);
 	}
 }
@@ -1000,9 +991,7 @@ static struct platform_device at91sam9g45_tcb1_device = {
 static void __init at91_add_device_tc(void)
 {
 	/* this chip has one clock and irq for all six TC channels */
-	at91_clock_associate("tcb0_clk", &at91sam9g45_tcb0_device.dev, "t0_clk");
 	platform_device_register(&at91sam9g45_tcb0_device);
-	at91_clock_associate("tcb1_clk", &at91sam9g45_tcb1_device.dev, "t0_clk");
 	platform_device_register(&at91sam9g45_tcb1_device);
 }
 #else
@@ -1286,12 +1275,10 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins)
 	case AT91SAM9G45_ID_SSC0:
 		pdev = &at91sam9g45_ssc0_device;
 		configure_ssc0_pins(pins);
-		at91_clock_associate("ssc0_clk", &pdev->dev, "pclk");
 		break;
 	case AT91SAM9G45_ID_SSC1:
 		pdev = &at91sam9g45_ssc1_device;
 		configure_ssc1_pins(pins);
-		at91_clock_associate("ssc1_clk", &pdev->dev, "pclk");
 		break;
 	default:
 		return;
@@ -1533,27 +1520,22 @@ void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
 		case 0:		/* DBGU */
 			pdev = &at91sam9g45_dbgu_device;
 			configure_dbgu_pins();
-			at91_clock_associate("mck", &pdev->dev, "usart");
 			break;
 		case AT91SAM9G45_ID_US0:
 			pdev = &at91sam9g45_uart0_device;
 			configure_usart0_pins(pins);
-			at91_clock_associate("usart0_clk", &pdev->dev, "usart");
 			break;
 		case AT91SAM9G45_ID_US1:
 			pdev = &at91sam9g45_uart1_device;
 			configure_usart1_pins(pins);
-			at91_clock_associate("usart1_clk", &pdev->dev, "usart");
 			break;
 		case AT91SAM9G45_ID_US2:
 			pdev = &at91sam9g45_uart2_device;
 			configure_usart2_pins(pins);
-			at91_clock_associate("usart2_clk", &pdev->dev, "usart");
 			break;
 		case AT91SAM9G45_ID_US3:
 			pdev = &at91sam9g45_uart3_device;
 			configure_usart3_pins(pins);
-			at91_clock_associate("usart3_clk", &pdev->dev, "usart");
 			break;
 		default:
 			return;
@@ -1565,10 +1547,21 @@ void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
 		at91_uarts[portnr] = pdev;
 }
 
+static struct clk_lookup console_lookups = {
+	.con_id = "usart",
+};
+
 void __init at91_set_serial_console(unsigned portnr)
 {
-	if (portnr < ATMEL_MAX_UART)
+	struct atmel_uart_data *pdata;
+
+	if (portnr < ATMEL_MAX_UART) {
 		atmel_default_console_device = at91_uarts[portnr];
+
+		pdata = atmel_default_console_device->dev.platform_data;
+		console_lookups.clk = at91sam9g45_get_uart_clock(pdata->num);
+		clkdev_add(&console_lookups);
+	}
 }
 
 void __init at91_add_device_serial(void)
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 19e2e5a..80acd8f 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -183,6 +183,39 @@ static struct clk *periph_clocks[] __initdata = {
 	// irq0
 };
 
+static struct clk_lookup periph_clocks_lookups[] = {
+	CLKDEV_CON_ID("pioA_clk", &pioA_clk),
+	CLKDEV_CON_ID("pioB_clk", &pioB_clk),
+	CLKDEV_CON_ID("pioC_clk", &pioC_clk),
+	CLKDEV_CON_ID("pioD_clk", &pioD_clk),
+	CLKDEV_CON_ID("mci_clk", &mmc_clk),
+	CLKDEV_CON_ID("twi0_clk", &twi0_clk),
+	CLKDEV_CON_ID("twi1_clk", &twi1_clk),
+	CLKDEV_CON_ID("spi_clk", &spi_clk),
+	CLKDEV_CON_ID("pwm_clk", &pwm_clk),
+	CLKDEV_CON_ID("tsc_clk", &tsc_clk),
+	CLKDEV_CON_ID("dma_clk", &dma_clk),
+	CLKDEV_CON_ID("udphs_clk", &udphs_clk),
+	CLKDEV_CON_ID("lcdc_clk", &lcdc_clk),
+	CLKDEV_CON_ID("ac97_clk", &ac97_clk),
+	CLKDEV_CON_DEV_ID("hclk", "atmel_usba_udc.0", &utmi_clk),
+	CLKDEV_CON_DEV_ID("pclk", "atmel_usba_udc.0", &udphs_clk),
+	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tc0_clk),
+	CLKDEV_CON_DEV_ID("t1_clk", "atmel_tcb.0", &tc1_clk),
+	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.0", &tc2_clk),
+	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
+	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
+};
+
+static struct clk_lookup usart_clocks_lookups[] = {
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.0", &mck),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.1", &usart0_clk),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.2", &usart1_clk),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.3", &usart2_clk),
+	CLKDEV_CON_DEV_ID("usart", "atmel_usart.4", &usart3_clk),
+};
+
+
 /*
  * The two programmable clocks.
  * You must configure pin multiplexing to bring these signals out.
@@ -200,6 +233,11 @@ static struct clk pck1 = {
 	.id		= 1,
 };
 
+static struct clk_lookup program_clocks_lookups[] = {
+	CLKDEV_CON_ID("pck0", &pck0),
+	CLKDEV_CON_ID("pck1", &pck1),
+};
+
 static void __init at91sam9rl_register_clocks(void)
 {
 	int i;
@@ -207,8 +245,21 @@ static void __init at91sam9rl_register_clocks(void)
 	for (i = 0; i < ARRAY_SIZE(periph_clocks); i++)
 		clk_register(periph_clocks[i]);
 
+	clkdev_add_table(periph_clocks_lookups,
+			 ARRAY_SIZE(periph_clocks_lookups));
+
 	clk_register(&pck0);
 	clk_register(&pck1);
+
+	clkdev_add_table(program_clocks_lookups,
+			 ARRAY_SIZE(program_clocks_lookups));
+}
+
+struct clk* __init at91sam9rl_get_uart_clock(int id)
+{
+	if (id >= ARRAY_SIZE(usart_clocks_lookups))
+		return NULL;
+	return usart_clocks_lookups[id].clk;
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 2d8d519..e4dc0e9 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -155,10 +155,6 @@ void __init at91_add_device_usba(struct usba_platform_data *data)
 
 	/* Pullup pin is handled internally by USB device peripheral */
 
-	/* Clocks */
-	at91_clock_associate("utmi_clk", &at91_usba_udc_device.dev, "hclk");
-	at91_clock_associate("udphs_clk", &at91_usba_udc_device.dev, "pclk");
-
 	platform_device_register(&at91_usba_udc_device);
 }
 #else
@@ -606,9 +602,6 @@ static struct platform_device at91sam9rl_tcb_device = {
 static void __init at91_add_device_tc(void)
 {
 	/* this chip has a separate clock and irq for each TC channel */
-	at91_clock_associate("tc0_clk", &at91sam9rl_tcb_device.dev, "t0_clk");
-	at91_clock_associate("tc1_clk", &at91sam9rl_tcb_device.dev, "t1_clk");
-	at91_clock_associate("tc2_clk", &at91sam9rl_tcb_device.dev, "t2_clk");
 	platform_device_register(&at91sam9rl_tcb_device);
 }
 #else
@@ -892,12 +885,10 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins)
 	case AT91SAM9RL_ID_SSC0:
 		pdev = &at91sam9rl_ssc0_device;
 		configure_ssc0_pins(pins);
-		at91_clock_associate("ssc0_clk", &pdev->dev, "pclk");
 		break;
 	case AT91SAM9RL_ID_SSC1:
 		pdev = &at91sam9rl_ssc1_device;
 		configure_ssc1_pins(pins);
-		at91_clock_associate("ssc1_clk", &pdev->dev, "pclk");
 		break;
 	default:
 		return;
@@ -1147,27 +1138,22 @@ void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
 		case 0:		/* DBGU */
 			pdev = &at91sam9rl_dbgu_device;
 			configure_dbgu_pins();
-			at91_clock_associate("mck", &pdev->dev, "usart");
 			break;
 		case AT91SAM9RL_ID_US0:
 			pdev = &at91sam9rl_uart0_device;
 			configure_usart0_pins(pins);
-			at91_clock_associate("usart0_clk", &pdev->dev, "usart");
 			break;
 		case AT91SAM9RL_ID_US1:
 			pdev = &at91sam9rl_uart1_device;
 			configure_usart1_pins(pins);
-			at91_clock_associate("usart1_clk", &pdev->dev, "usart");
 			break;
 		case AT91SAM9RL_ID_US2:
 			pdev = &at91sam9rl_uart2_device;
 			configure_usart2_pins(pins);
-			at91_clock_associate("usart2_clk", &pdev->dev, "usart");
 			break;
 		case AT91SAM9RL_ID_US3:
 			pdev = &at91sam9rl_uart3_device;
 			configure_usart3_pins(pins);
-			at91_clock_associate("usart3_clk", &pdev->dev, "usart");
 			break;
 		default:
 			return;
@@ -1179,10 +1165,21 @@ void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
 		at91_uarts[portnr] = pdev;
 }
 
+static struct clk_lookup console_lookups = {
+	.con_id = "usart",
+};
+
 void __init at91_set_serial_console(unsigned portnr)
 {
-	if (portnr < ATMEL_MAX_UART)
+	struct atmel_uart_data *pdata;
+
+	if (portnr < ATMEL_MAX_UART) {
 		atmel_default_console_device = at91_uarts[portnr];
+
+		pdata = atmel_default_console_device->dev.platform_data;
+		console_lookups.clk = at91sam9rl_get_uart_clock(pdata->num);
+		clkdev_add(&console_lookups);
+	}
 }
 
 void __init at91_add_device_serial(void)
diff --git a/arch/arm/mach-at91/at91x40.c b/arch/arm/mach-at91/at91x40.c
index ad3ec85..56ba3bd 100644
--- a/arch/arm/mach-at91/at91x40.c
+++ b/arch/arm/mach-at91/at91x40.c
@@ -37,11 +37,6 @@ unsigned long clk_get_rate(struct clk *clk)
 	return AT91X40_MASTER_CLOCK;
 }
 
-struct clk *clk_get(struct device *dev, const char *id)
-{
-	return NULL;
-}
-
 void __init at91x40_initialize(unsigned long main_clock)
 {
 	at91_extern_irq = (1 << AT91X40_ID_IRQ0) | (1 << AT91X40_ID_IRQ1)
diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index 9113da6..2f2f8a6 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -163,7 +163,7 @@ static struct clk udpck = {
 	.parent		= &pllb,
 	.mode		= pmc_sys_mode,
 };
-static struct clk utmi_clk = {
+struct clk utmi_clk = {
 	.name		= "utmi_clk",
 	.parent		= &main_clk,
 	.pmc_mask	= AT91_PMC_UPLLEN,	/* in CKGR_UCKR */
@@ -182,7 +182,7 @@ static struct clk uhpck = {
  * memory, interfaces to on-chip peripherals, the AIC, and sometimes more
  * (e.g baud rate generation).  It's sourced from one of the primary clocks.
  */
-static struct clk mck = {
+struct clk mck = {
 	.name		= "mck",
 	.pmc_mask	= AT91_PMC_MCKRDY,	/* in PMC_SR */
 };
@@ -215,43 +215,6 @@ static struct clk __init *at91_css_to_clk(unsigned long css)
 	return NULL;
 }
 
-/*
- * Associate a particular clock with a function (eg, "uart") and device.
- * The drivers can then request the same 'function' with several different
- * devices and not care about which clock name to use.
- */
-void __init at91_clock_associate(const char *id, struct device *dev, const char *func)
-{
-	struct clk *clk = clk_get(NULL, id);
-
-	if (!dev || !clk || !IS_ERR(clk_get(dev, func)))
-		return;
-
-	clk->function = func;
-	clk->dev = dev;
-}
-
-/* clocks cannot be de-registered no refcounting necessary */
-struct clk *clk_get(struct device *dev, const char *id)
-{
-	struct clk *clk;
-
-	list_for_each_entry(clk, &clocks, node) {
-		if (strcmp(id, clk->name) == 0)
-			return clk;
-		if (clk->function && (dev == clk->dev) && strcmp(id, clk->function) == 0)
-			return clk;
-	}
-
-	return ERR_PTR(-ENOENT);
-}
-EXPORT_SYMBOL(clk_get);
-
-void clk_put(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_put);
-
 static void __clk_enable(struct clk *clk)
 {
 	if (clk->parent)
@@ -662,6 +625,17 @@ static void __init at91_upll_usbfs_clock_init(unsigned long main_clock)
 	uhpck.rate_hz /= 1 + ((at91_sys_read(AT91_PMC_USB) & AT91_PMC_OHCIUSBDIV) >> 8);
 }
 
+static struct clk_lookup lookups[] = {
+	CLKDEV_CON_ID("clk32k", &clk32k),
+	CLKDEV_CON_ID("main", &main_clk),
+	CLKDEV_CON_ID("plla", &plla),
+	CLKDEV_CON_ID("mck", &mck),
+	CLKDEV_CON_ID("pllb", &pllb),
+	CLKDEV_CON_ID("udpck", &udpck),
+	CLKDEV_CON_ID("utmi_clk", &utmi_clk),
+	CLKDEV_CON_ID("uhpck", &uhpck),
+};
+
 int __init at91_clock_init(unsigned long main_clock)
 {
 	unsigned tmp, freq, mckr;
@@ -771,6 +745,8 @@ int __init at91_clock_init(unsigned long main_clock)
 	/* MCK and CPU clock are "always on" */
 	clk_enable(&mck);
 
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
 	printk("Clocks: CPU %u MHz, master %u MHz, main %u.%03u MHz\n",
 		freq / 1000000, (unsigned) mck.rate_hz / 1000000,
 		(unsigned) main_clock / 1000000,
diff --git a/arch/arm/mach-at91/clock.h b/arch/arm/mach-at91/clock.h
index 6cf4b78..f0d8776 100644
--- a/arch/arm/mach-at91/clock.h
+++ b/arch/arm/mach-at91/clock.h
@@ -6,6 +6,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/clkdev.h>
+
 #define CLK_TYPE_PRIMARY	0x1
 #define CLK_TYPE_PLL		0x2
 #define CLK_TYPE_PROGRAMMABLE	0x4
@@ -16,8 +18,6 @@
 struct clk {
 	struct list_head node;
 	const char	*name;		/* unique clock name */
-	const char	*function;	/* function of the clock */
-	struct device	*dev;		/* device associated with function */
 	unsigned long	rate_hz;
 	struct clk	*parent;
 	u32		pmc_mask;
@@ -29,3 +29,18 @@ struct clk {
 
 
 extern int __init clk_register(struct clk *clk);
+extern struct clk mck;
+extern struct clk utmi_clk;
+
+#define CLKDEV_CON_ID(_id, _clk)			\
+	{						\
+		.con_id = _id,				\
+		.clk = _clk,				\
+	}
+
+#define CLKDEV_CON_DEV_ID(_con_id, _dev_id, _clk)	\
+	{						\
+		.con_id = _con_id,			\
+		.dev_id = _dev_id,			\
+		.clk = _clk,				\
+	}
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 3b5ff68..a039726 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -8,6 +8,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/clkdev.h>
+
  /* Processors */
 extern void __init at91rm9200_set_type(int type);
 extern void __init at91_initialize(unsigned long main_clock);
@@ -26,8 +28,16 @@ extern struct sys_timer at91x40_timer;
 
  /* Clocks */
 extern int __init at91_clock_init(unsigned long main_clock);
+extern struct clk* __init at91rm9200_get_uart_clock(int id);
+extern struct clk* __init at91sam9260_get_uart_clock(int id);
+extern struct clk* __init at91sam9261_get_uart_clock(int id);
+extern struct clk* __init at91sam9263_get_uart_clock(int id);
+extern struct clk* __init at91sam9rl_get_uart_clock(int id);
+extern struct clk* __init at91sam9g45_get_uart_clock(int id);
+extern struct clk* __init at91x40_get_uart_clock(int id);
+extern struct clk* __init at91cap9_get_uart_clock(int id);
+extern struct clk* __init at572d940hf_get_uart_clock(int id);
 struct device;
-extern void __init at91_clock_associate(const char *id, struct device *dev, const char *func);
 
  /* Power Management */
 extern void at91_irq_suspend(void);
diff --git a/arch/arm/mach-at91/include/mach/clkdev.h b/arch/arm/mach-at91/include/mach/clkdev.h
new file mode 100644
index 0000000..04b37a8
--- /dev/null
+++ b/arch/arm/mach-at91/include/mach/clkdev.h
@@ -0,0 +1,7 @@
+#ifndef __ASM_MACH_CLKDEV_H
+#define __ASM_MACH_CLKDEV_H
+
+#define __clk_get(clk) ({ 1; })
+#define __clk_put(clk) do { } while (0)
+
+#endif
-- 
1.7.4.1
