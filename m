From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue,  3 May 2011 12:03:28 +1200
Subject: [PATCH V4 14/23] at91: Make SSC device common
In-Reply-To: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
References: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1304381017-17912-15-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the individual SSC code for each at91 variant with a single
implementation in devices.c

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/at91cap9_devices.c    |  142 ++++------------------
 arch/arm/mach-at91/at91rm9200_devices.c  |  199 ++++++------------------------
 arch/arm/mach-at91/at91sam9260_devices.c |   85 ++-----------
 arch/arm/mach-at91/at91sam9261_devices.c |  199 ++++++------------------------
 arch/arm/mach-at91/at91sam9263_devices.c |  146 ++++------------------
 arch/arm/mach-at91/at91sam9g45_devices.c |  146 ++++------------------
 arch/arm/mach-at91/at91sam9rl_devices.c  |  142 ++++------------------
 arch/arm/mach-at91/board-afeb-9260v1.c   |    2 +-
 arch/arm/mach-at91/board-sam9260ek.c     |    2 +-
 arch/arm/mach-at91/board-sam9261ek.c     |    2 +-
 arch/arm/mach-at91/board-sam9g20ek.c     |    2 +-
 arch/arm/mach-at91/board-snapper9260.c   |    4 +-
 arch/arm/mach-at91/devices.c             |   90 ++++++++++++++
 arch/arm/mach-at91/devices.h             |   14 ++
 14 files changed, 294 insertions(+), 881 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index 30889ec..0a2272b 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -444,128 +444,32 @@ void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data) {}
  *  SSC -- Synchronous Serial Controller
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_ATMEL_SSC) || defined(CONFIG_ATMEL_SSC_MODULE)
-static u64 ssc0_dmamask = DMA_BIT_MASK(32);
-
-static struct resource ssc0_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_SSC0,
-		.end	= AT91CAP9_BASE_SSC0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_SSC0,
-		.end	= AT91CAP9_ID_SSC0,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_dev_table_ssc device_ssc0 __initdata = {
+	.mmio_base	= AT91CAP9_BASE_SSC0,
+	.irq		= AT91CAP9_ID_SSC0,
+	.clock_asc	= "ssc0_clk",
+	.clock_name	= "ssc",
+	.tf_pin		= {AT91_PIN_PB0, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.tk_pin		= {AT91_PIN_PB1, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.td_pin		= {AT91_PIN_PB2, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rd_pin		= {AT91_PIN_PB3, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rk_pin		= {AT91_PIN_PB4, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rf_pin		= {AT91_PIN_PB5, AT91_PIN_PERIPH_A, 1, 0, 0},
 };
 
-static struct platform_device at91cap9_ssc0_device = {
-	.name	= "ssc",
-	.id	= 0,
-	.dev	= {
-		.dma_mask		= &ssc0_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= ssc0_resources,
-	.num_resources	= ARRAY_SIZE(ssc0_resources),
+static struct at91_dev_table_ssc device_ssc1 __initdata = {
+	.mmio_base	= AT91CAP9_BASE_SSC1,
+	.irq		= AT91CAP9_ID_SSC1,
+	.clock_asc	= "ssc0_clk",
+	.clock_name	= "ssc",
+	.tf_pin		= {AT91_PIN_PB6,  AT91_PIN_PERIPH_A, 1, 0, 0},
+	.tk_pin		= {AT91_PIN_PB7,  AT91_PIN_PERIPH_A, 1, 0, 0},
+	.td_pin		= {AT91_PIN_PB8,  AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rd_pin		= {AT91_PIN_PB9,  AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rk_pin		= {AT91_PIN_PB10, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rf_pin		= {AT91_PIN_PB11, AT91_PIN_PERIPH_A, 1, 0, 0},
 };
 
-static inline void configure_ssc0_pins(unsigned pins)
-{
-	if (pins & ATMEL_SSC_TF)
-		at91_set_A_periph(AT91_PIN_PB0, 1);
-	if (pins & ATMEL_SSC_TK)
-		at91_set_A_periph(AT91_PIN_PB1, 1);
-	if (pins & ATMEL_SSC_TD)
-		at91_set_A_periph(AT91_PIN_PB2, 1);
-	if (pins & ATMEL_SSC_RD)
-		at91_set_A_periph(AT91_PIN_PB3, 1);
-	if (pins & ATMEL_SSC_RK)
-		at91_set_A_periph(AT91_PIN_PB4, 1);
-	if (pins & ATMEL_SSC_RF)
-		at91_set_A_periph(AT91_PIN_PB5, 1);
-}
-
-static u64 ssc1_dmamask = DMA_BIT_MASK(32);
-
-static struct resource ssc1_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_SSC1,
-		.end	= AT91CAP9_BASE_SSC1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_SSC1,
-		.end	= AT91CAP9_ID_SSC1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91cap9_ssc1_device = {
-	.name	= "ssc",
-	.id	= 1,
-	.dev	= {
-		.dma_mask		= &ssc1_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= ssc1_resources,
-	.num_resources	= ARRAY_SIZE(ssc1_resources),
-};
-
-static inline void configure_ssc1_pins(unsigned pins)
-{
-	if (pins & ATMEL_SSC_TF)
-		at91_set_A_periph(AT91_PIN_PB6, 1);
-	if (pins & ATMEL_SSC_TK)
-		at91_set_A_periph(AT91_PIN_PB7, 1);
-	if (pins & ATMEL_SSC_TD)
-		at91_set_A_periph(AT91_PIN_PB8, 1);
-	if (pins & ATMEL_SSC_RD)
-		at91_set_A_periph(AT91_PIN_PB9, 1);
-	if (pins & ATMEL_SSC_RK)
-		at91_set_A_periph(AT91_PIN_PB10, 1);
-	if (pins & ATMEL_SSC_RF)
-		at91_set_A_periph(AT91_PIN_PB11, 1);
-}
-
-/*
- * SSC controllers are accessed through library code, instead of any
- * kind of all-singing/all-dancing driver.  For example one could be
- * used by a particular I2S audio codec's driver, while another one
- * on the same system might be used by a custom data capture driver.
- */
-void __init at91_add_device_ssc(unsigned id, unsigned pins)
-{
-	struct platform_device *pdev;
-
-	/*
-	 * NOTE: caller is responsible for passing information matching
-	 * "pins" to whatever will be using each particular controller.
-	 */
-	switch (id) {
-	case AT91CAP9_ID_SSC0:
-		pdev = &at91cap9_ssc0_device;
-		configure_ssc0_pins(pins);
-		at91_clock_associate("ssc0_clk", &pdev->dev, "ssc");
-		break;
-	case AT91CAP9_ID_SSC1:
-		pdev = &at91cap9_ssc1_device;
-		configure_ssc1_pins(pins);
-		at91_clock_associate("ssc1_clk", &pdev->dev, "ssc");
-		break;
-	default:
-		return;
-	}
-
-	platform_device_register(pdev);
-}
-
-#else
-void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  UART
  * -------------------------------------------------------------------- */
@@ -641,6 +545,8 @@ static struct at91_device_table at91cap9_device_table __initdata = {
 	.uart[1]	= &device_uart1,
 	.uart[2]	= &device_uart2,
 	.pwm		= &device_pwm,
+	.ssc[0]		= &device_ssc0,
+	.ssc[1]		= &device_ssc1,
 };
 
 void __init at91cap9_init_devices(void)
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 3a783f4..9f678de 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -299,175 +299,45 @@ static void __init at91_add_device_rtc(void) {}
  *  SSC -- Synchronous Serial Controller
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_ATMEL_SSC) || defined(CONFIG_ATMEL_SSC_MODULE)
-static u64 ssc0_dmamask = DMA_BIT_MASK(32);
-
-static struct resource ssc0_resources[] = {
-	[0] = {
-		.start	= AT91RM9200_BASE_SSC0,
-		.end	= AT91RM9200_BASE_SSC0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91RM9200_ID_SSC0,
-		.end	= AT91RM9200_ID_SSC0,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_dev_table_ssc device_ssc0 __initdata = {
+	.mmio_base	= AT91RM9200_BASE_SSC0,
+	.irq		= AT91RM9200_ID_SSC0,
+	.clock_asc	= "ssc0_clk",
+	.clock_name	= "ssc",
+	.tf_pin		= {AT91_PIN_PB0, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.tk_pin		= {AT91_PIN_PB1, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.td_pin		= {AT91_PIN_PB2, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rd_pin		= {AT91_PIN_PB3, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rk_pin		= {AT91_PIN_PB4, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rf_pin		= {AT91_PIN_PB5, AT91_PIN_PERIPH_A, 1, 0, 0},
 };
 
-static struct platform_device at91rm9200_ssc0_device = {
-	.name	= "ssc",
-	.id	= 0,
-	.dev	= {
-		.dma_mask		= &ssc0_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= ssc0_resources,
-	.num_resources	= ARRAY_SIZE(ssc0_resources),
+static struct at91_dev_table_ssc device_ssc1 __initdata = {
+	.mmio_base	= AT91RM9200_BASE_SSC1,
+	.irq		= AT91RM9200_ID_SSC1,
+	.clock_asc	= "ssc2_clk",
+	.clock_name	= "ssc",
+	.tf_pin		= {AT91_PIN_PB6,  AT91_PIN_PERIPH_A, 1, 0, 0},
+	.tk_pin		= {AT91_PIN_PB7,  AT91_PIN_PERIPH_A, 1, 0, 0},
+	.td_pin		= {AT91_PIN_PB8,  AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rd_pin		= {AT91_PIN_PB9,  AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rk_pin		= {AT91_PIN_PB10, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rf_pin		= {AT91_PIN_PB11, AT91_PIN_PERIPH_A, 1, 0, 0},
 };
 
-static inline void configure_ssc0_pins(unsigned pins)
-{
-	if (pins & ATMEL_SSC_TF)
-		at91_set_A_periph(AT91_PIN_PB0, 1);
-	if (pins & ATMEL_SSC_TK)
-		at91_set_A_periph(AT91_PIN_PB1, 1);
-	if (pins & ATMEL_SSC_TD)
-		at91_set_A_periph(AT91_PIN_PB2, 1);
-	if (pins & ATMEL_SSC_RD)
-		at91_set_A_periph(AT91_PIN_PB3, 1);
-	if (pins & ATMEL_SSC_RK)
-		at91_set_A_periph(AT91_PIN_PB4, 1);
-	if (pins & ATMEL_SSC_RF)
-		at91_set_A_periph(AT91_PIN_PB5, 1);
-}
-
-static u64 ssc1_dmamask = DMA_BIT_MASK(32);
-
-static struct resource ssc1_resources[] = {
-	[0] = {
-		.start	= AT91RM9200_BASE_SSC1,
-		.end	= AT91RM9200_BASE_SSC1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91RM9200_ID_SSC1,
-		.end	= AT91RM9200_ID_SSC1,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_dev_table_ssc device_ssc2 __initdata = {
+	.mmio_base	= AT91RM9200_BASE_SSC2,
+	.irq		= AT91RM9200_ID_SSC2,
+	.clock_asc	= "ssc2_clk",
+	.clock_name	= "ssc",
+	.tf_pin		= {AT91_PIN_PB12, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.tk_pin		= {AT91_PIN_PB13, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.td_pin		= {AT91_PIN_PB14, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rd_pin		= {AT91_PIN_PB15, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rk_pin		= {AT91_PIN_PB16, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rf_pin		= {AT91_PIN_PB17, AT91_PIN_PERIPH_A, 1, 0, 0},
 };
 
-static struct platform_device at91rm9200_ssc1_device = {
-	.name	= "ssc",
-	.id	= 1,
-	.dev	= {
-		.dma_mask		= &ssc1_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= ssc1_resources,
-	.num_resources	= ARRAY_SIZE(ssc1_resources),
-};
-
-static inline void configure_ssc1_pins(unsigned pins)
-{
-	if (pins & ATMEL_SSC_TF)
-		at91_set_A_periph(AT91_PIN_PB6, 1);
-	if (pins & ATMEL_SSC_TK)
-		at91_set_A_periph(AT91_PIN_PB7, 1);
-	if (pins & ATMEL_SSC_TD)
-		at91_set_A_periph(AT91_PIN_PB8, 1);
-	if (pins & ATMEL_SSC_RD)
-		at91_set_A_periph(AT91_PIN_PB9, 1);
-	if (pins & ATMEL_SSC_RK)
-		at91_set_A_periph(AT91_PIN_PB10, 1);
-	if (pins & ATMEL_SSC_RF)
-		at91_set_A_periph(AT91_PIN_PB11, 1);
-}
-
-static u64 ssc2_dmamask = DMA_BIT_MASK(32);
-
-static struct resource ssc2_resources[] = {
-	[0] = {
-		.start	= AT91RM9200_BASE_SSC2,
-		.end	= AT91RM9200_BASE_SSC2 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91RM9200_ID_SSC2,
-		.end	= AT91RM9200_ID_SSC2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91rm9200_ssc2_device = {
-	.name	= "ssc",
-	.id	= 2,
-	.dev	= {
-		.dma_mask		= &ssc2_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= ssc2_resources,
-	.num_resources	= ARRAY_SIZE(ssc2_resources),
-};
-
-static inline void configure_ssc2_pins(unsigned pins)
-{
-	if (pins & ATMEL_SSC_TF)
-		at91_set_A_periph(AT91_PIN_PB12, 1);
-	if (pins & ATMEL_SSC_TK)
-		at91_set_A_periph(AT91_PIN_PB13, 1);
-	if (pins & ATMEL_SSC_TD)
-		at91_set_A_periph(AT91_PIN_PB14, 1);
-	if (pins & ATMEL_SSC_RD)
-		at91_set_A_periph(AT91_PIN_PB15, 1);
-	if (pins & ATMEL_SSC_RK)
-		at91_set_A_periph(AT91_PIN_PB16, 1);
-	if (pins & ATMEL_SSC_RF)
-		at91_set_A_periph(AT91_PIN_PB17, 1);
-}
-
-/*
- * SSC controllers are accessed through library code, instead of any
- * kind of all-singing/all-dancing driver.  For example one could be
- * used by a particular I2S audio codec's driver, while another one
- * on the same system might be used by a custom data capture driver.
- */
-void __init at91_add_device_ssc(unsigned id, unsigned pins)
-{
-	struct platform_device *pdev;
-
-	/*
-	 * NOTE: caller is responsible for passing information matching
-	 * "pins" to whatever will be using each particular controller.
-	 */
-	switch (id) {
-	case AT91RM9200_ID_SSC0:
-		pdev = &at91rm9200_ssc0_device;
-		configure_ssc0_pins(pins);
-		at91_clock_associate("ssc0_clk", &pdev->dev, "ssc");
-		break;
-	case AT91RM9200_ID_SSC1:
-		pdev = &at91rm9200_ssc1_device;
-		configure_ssc1_pins(pins);
-		at91_clock_associate("ssc1_clk", &pdev->dev, "ssc");
-		break;
-	case AT91RM9200_ID_SSC2:
-		pdev = &at91rm9200_ssc2_device;
-		configure_ssc2_pins(pins);
-		at91_clock_associate("ssc2_clk", &pdev->dev, "ssc");
-		break;
-	default:
-		return;
-	}
-
-	platform_device_register(pdev);
-}
-
-#else
-void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  UART
  * -------------------------------------------------------------------- */
@@ -565,6 +435,9 @@ static struct at91_device_table at91rm9200_device_table __initdata = {
 	.uart[1]	= &device_uart1,
 	.uart[2]	= &device_uart2,
 	.uart[3]	= &device_uart3,
+	.ssc[0]		= &device_ssc0,
+	.ssc[1]		= &device_ssc1,
+	.ssc[2]		= &device_ssc2,
 };
 
 void __init at91rm9200_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 0759be2..891e8bf 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -200,81 +200,19 @@ static struct at91_dev_table_rtt device_rtt __initdata = {
  *  SSC -- Synchronous Serial Controller
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_ATMEL_SSC) || defined(CONFIG_ATMEL_SSC_MODULE)
-static u64 ssc_dmamask = DMA_BIT_MASK(32);
-
-static struct resource ssc_resources[] = {
-	[0] = {
-		.start	= AT91SAM9260_BASE_SSC,
-		.end	= AT91SAM9260_BASE_SSC + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9260_ID_SSC,
-		.end	= AT91SAM9260_ID_SSC,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9260_ssc_device = {
-	.name	= "ssc",
-	.id	= 0,
-	.dev	= {
-		.dma_mask		= &ssc_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= ssc_resources,
-	.num_resources	= ARRAY_SIZE(ssc_resources),
+static struct at91_dev_table_ssc device_ssc __initdata = {
+	.mmio_base	= AT91SAM9260_BASE_SSC,
+	.irq		= AT91SAM9260_ID_SSC,
+	.clock_asc	= "ssc_clk",
+	.clock_name	= "pclk",
+	.tf_pin		= {AT91_PIN_PB17, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.tk_pin		= {AT91_PIN_PB16, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.td_pin		= {AT91_PIN_PB18, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rd_pin		= {AT91_PIN_PB19, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rk_pin		= {AT91_PIN_PB20, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rf_pin		= {AT91_PIN_PB21, AT91_PIN_PERIPH_A, 1, 0, 0},
 };
 
-static inline void configure_ssc_pins(unsigned pins)
-{
-	if (pins & ATMEL_SSC_TF)
-		at91_set_A_periph(AT91_PIN_PB17, 1);
-	if (pins & ATMEL_SSC_TK)
-		at91_set_A_periph(AT91_PIN_PB16, 1);
-	if (pins & ATMEL_SSC_TD)
-		at91_set_A_periph(AT91_PIN_PB18, 1);
-	if (pins & ATMEL_SSC_RD)
-		at91_set_A_periph(AT91_PIN_PB19, 1);
-	if (pins & ATMEL_SSC_RK)
-		at91_set_A_periph(AT91_PIN_PB20, 1);
-	if (pins & ATMEL_SSC_RF)
-		at91_set_A_periph(AT91_PIN_PB21, 1);
-}
-
-/*
- * SSC controllers are accessed through library code, instead of any
- * kind of all-singing/all-dancing driver.  For example one could be
- * used by a particular I2S audio codec's driver, while another one
- * on the same system might be used by a custom data capture driver.
- */
-void __init at91_add_device_ssc(unsigned id, unsigned pins)
-{
-	struct platform_device *pdev;
-
-	/*
-	 * NOTE: caller is responsible for passing information matching
-	 * "pins" to whatever will be using each particular controller.
-	 */
-	switch (id) {
-	case AT91SAM9260_ID_SSC:
-		pdev = &at91sam9260_ssc_device;
-		configure_ssc_pins(pins);
-		at91_clock_associate("ssc_clk", &pdev->dev, "pclk");
-		break;
-	default:
-		return;
-	}
-
-	platform_device_register(pdev);
-}
-
-#else
-void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  UART
  * -------------------------------------------------------------------- */
@@ -512,6 +450,7 @@ static struct at91_device_table at91sam9260_device_table __initdata = {
 	.uart[3]	= &device_uart3,
 	.uart[4]	= &device_uart4,
 	.uart[5]	= &device_uart5,
+	.ssc[0]		= &device_ssc,
 };
 
 void __init at91sam9260_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 9e48f36..edb25f1 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -252,175 +252,45 @@ static struct at91_dev_table_rtt device_rtt __initdata = {
  *  SSC -- Synchronous Serial Controller
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_ATMEL_SSC) || defined(CONFIG_ATMEL_SSC_MODULE)
-static u64 ssc0_dmamask = DMA_BIT_MASK(32);
-
-static struct resource ssc0_resources[] = {
-	[0] = {
-		.start	= AT91SAM9261_BASE_SSC0,
-		.end	= AT91SAM9261_BASE_SSC0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9261_ID_SSC0,
-		.end	= AT91SAM9261_ID_SSC0,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_dev_table_ssc device_ssc0 __initdata = {
+	.mmio_base	= AT91SAM9261_BASE_SSC0,
+	.irq		= AT91SAM9261_ID_SSC0,
+	.clock_asc	= "ssc0_clk",
+	.clock_name	= "pclk",
+	.tf_pin		= {AT91_PIN_PB21, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.tk_pin		= {AT91_PIN_PB22, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.td_pin		= {AT91_PIN_PB23, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rd_pin		= {AT91_PIN_PB24, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rk_pin		= {AT91_PIN_PB25, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rf_pin		= {AT91_PIN_PB26, AT91_PIN_PERIPH_A, 1, 0, 0},
 };
 
-static struct platform_device at91sam9261_ssc0_device = {
-	.name	= "ssc",
-	.id	= 0,
-	.dev	= {
-		.dma_mask		= &ssc0_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= ssc0_resources,
-	.num_resources	= ARRAY_SIZE(ssc0_resources),
-};
-
-static inline void configure_ssc0_pins(unsigned pins)
-{
-	if (pins & ATMEL_SSC_TF)
-		at91_set_A_periph(AT91_PIN_PB21, 1);
-	if (pins & ATMEL_SSC_TK)
-		at91_set_A_periph(AT91_PIN_PB22, 1);
-	if (pins & ATMEL_SSC_TD)
-		at91_set_A_periph(AT91_PIN_PB23, 1);
-	if (pins & ATMEL_SSC_RD)
-		at91_set_A_periph(AT91_PIN_PB24, 1);
-	if (pins & ATMEL_SSC_RK)
-		at91_set_A_periph(AT91_PIN_PB25, 1);
-	if (pins & ATMEL_SSC_RF)
-		at91_set_A_periph(AT91_PIN_PB26, 1);
-}
-
-static u64 ssc1_dmamask = DMA_BIT_MASK(32);
-
-static struct resource ssc1_resources[] = {
-	[0] = {
-		.start	= AT91SAM9261_BASE_SSC1,
-		.end	= AT91SAM9261_BASE_SSC1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9261_ID_SSC1,
-		.end	= AT91SAM9261_ID_SSC1,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_dev_table_ssc device_ssc1 __initdata = {
+	.mmio_base	= AT91SAM9261_BASE_SSC1,
+	.irq		= AT91SAM9261_ID_SSC1,
+	.clock_asc	= "ssc1_clk",
+	.clock_name	= "pclk",
+	.tf_pin		= {AT91_PIN_PA17, AT91_PIN_PERIPH_B, 1, 0, 0},
+	.tk_pin		= {AT91_PIN_PA18, AT91_PIN_PERIPH_B, 1, 0, 0},
+	.td_pin		= {AT91_PIN_PA19, AT91_PIN_PERIPH_B, 1, 0, 0},
+	.rd_pin		= {AT91_PIN_PA20, AT91_PIN_PERIPH_B, 1, 0, 0},
+	.rk_pin		= {AT91_PIN_PA21, AT91_PIN_PERIPH_B, 1, 0, 0},
+	.rf_pin		= {AT91_PIN_PA22, AT91_PIN_PERIPH_B, 1, 0, 0},
 };
 
-static struct platform_device at91sam9261_ssc1_device = {
-	.name	= "ssc",
-	.id	= 1,
-	.dev	= {
-		.dma_mask		= &ssc1_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= ssc1_resources,
-	.num_resources	= ARRAY_SIZE(ssc1_resources),
+static struct at91_dev_table_ssc device_ssc2 __initdata = {
+	.mmio_base	= AT91SAM9261_BASE_SSC2,
+	.irq		= AT91SAM9261_ID_SSC2,
+	.clock_asc	= "ssc2_clk",
+	.clock_name	= "pclk",
+	.tf_pin		= {AT91_PIN_PC25, AT91_PIN_PERIPH_B, 1, 0, 0},
+	.tk_pin		= {AT91_PIN_PC26, AT91_PIN_PERIPH_B, 1, 0, 0},
+	.td_pin		= {AT91_PIN_PC27, AT91_PIN_PERIPH_B, 1, 0, 0},
+	.rd_pin		= {AT91_PIN_PC28, AT91_PIN_PERIPH_B, 1, 0, 0},
+	.rk_pin		= {AT91_PIN_PC29, AT91_PIN_PERIPH_B, 1, 0, 0},
+	.rf_pin		= {AT91_PIN_PC30, AT91_PIN_PERIPH_B, 1, 0, 0},
 };
 
-static inline void configure_ssc1_pins(unsigned pins)
-{
-	if (pins & ATMEL_SSC_TF)
-		at91_set_B_periph(AT91_PIN_PA17, 1);
-	if (pins & ATMEL_SSC_TK)
-		at91_set_B_periph(AT91_PIN_PA18, 1);
-	if (pins & ATMEL_SSC_TD)
-		at91_set_B_periph(AT91_PIN_PA19, 1);
-	if (pins & ATMEL_SSC_RD)
-		at91_set_B_periph(AT91_PIN_PA20, 1);
-	if (pins & ATMEL_SSC_RK)
-		at91_set_B_periph(AT91_PIN_PA21, 1);
-	if (pins & ATMEL_SSC_RF)
-		at91_set_B_periph(AT91_PIN_PA22, 1);
-}
-
-static u64 ssc2_dmamask = DMA_BIT_MASK(32);
-
-static struct resource ssc2_resources[] = {
-	[0] = {
-		.start	= AT91SAM9261_BASE_SSC2,
-		.end	= AT91SAM9261_BASE_SSC2 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9261_ID_SSC2,
-		.end	= AT91SAM9261_ID_SSC2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9261_ssc2_device = {
-	.name	= "ssc",
-	.id	= 2,
-	.dev	= {
-		.dma_mask		= &ssc2_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= ssc2_resources,
-	.num_resources	= ARRAY_SIZE(ssc2_resources),
-};
-
-static inline void configure_ssc2_pins(unsigned pins)
-{
-	if (pins & ATMEL_SSC_TF)
-		at91_set_B_periph(AT91_PIN_PC25, 1);
-	if (pins & ATMEL_SSC_TK)
-		at91_set_B_periph(AT91_PIN_PC26, 1);
-	if (pins & ATMEL_SSC_TD)
-		at91_set_B_periph(AT91_PIN_PC27, 1);
-	if (pins & ATMEL_SSC_RD)
-		at91_set_B_periph(AT91_PIN_PC28, 1);
-	if (pins & ATMEL_SSC_RK)
-		at91_set_B_periph(AT91_PIN_PC29, 1);
-	if (pins & ATMEL_SSC_RF)
-		at91_set_B_periph(AT91_PIN_PC30, 1);
-}
-
-/*
- * SSC controllers are accessed through library code, instead of any
- * kind of all-singing/all-dancing driver.  For example one could be
- * used by a particular I2S audio codec's driver, while another one
- * on the same system might be used by a custom data capture driver.
- */
-void __init at91_add_device_ssc(unsigned id, unsigned pins)
-{
-	struct platform_device *pdev;
-
-	/*
-	 * NOTE: caller is responsible for passing information matching
-	 * "pins" to whatever will be using each particular controller.
-	 */
-	switch (id) {
-	case AT91SAM9261_ID_SSC0:
-		pdev = &at91sam9261_ssc0_device;
-		configure_ssc0_pins(pins);
-		at91_clock_associate("ssc0_clk", &pdev->dev, "pclk");
-		break;
-	case AT91SAM9261_ID_SSC1:
-		pdev = &at91sam9261_ssc1_device;
-		configure_ssc1_pins(pins);
-		at91_clock_associate("ssc1_clk", &pdev->dev, "pclk");
-		break;
-	case AT91SAM9261_ID_SSC2:
-		pdev = &at91sam9261_ssc2_device;
-		configure_ssc2_pins(pins);
-		at91_clock_associate("ssc2_clk", &pdev->dev, "pclk");
-		break;
-	default:
-		return;
-	}
-
-	platform_device_register(pdev);
-}
-
-#else
-void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  UART
  * -------------------------------------------------------------------- */
@@ -494,6 +364,9 @@ static struct at91_device_table at91sam9261_device_table __initdata = {
 	.uart[0]	= &device_uart0,
 	.uart[1]	= &device_uart1,
 	.uart[2]	= &device_uart2,
+	.ssc[0]		= &device_ssc0,
+	.ssc[1]		= &device_ssc1,
+	.ssc[2]		= &device_ssc2,
 };
 
 void __init at91sam9261_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index ff490bc..cfac78b 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -551,128 +551,32 @@ static struct at91_dev_table_pwm device_pwm __initdata = {
  *  SSC -- Synchronous Serial Controller
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_ATMEL_SSC) || defined(CONFIG_ATMEL_SSC_MODULE)
-static u64 ssc0_dmamask = DMA_BIT_MASK(32);
-
-static struct resource ssc0_resources[] = {
-	[0] = {
-		.start	= AT91SAM9263_BASE_SSC0,
-		.end	= AT91SAM9263_BASE_SSC0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9263_ID_SSC0,
-		.end	= AT91SAM9263_ID_SSC0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9263_ssc0_device = {
-	.name	= "ssc",
-	.id	= 0,
-	.dev	= {
-		.dma_mask		= &ssc0_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= ssc0_resources,
-	.num_resources	= ARRAY_SIZE(ssc0_resources),
-};
-
-static inline void configure_ssc0_pins(unsigned pins)
-{
-	if (pins & ATMEL_SSC_TF)
-		at91_set_B_periph(AT91_PIN_PB0, 1);
-	if (pins & ATMEL_SSC_TK)
-		at91_set_B_periph(AT91_PIN_PB1, 1);
-	if (pins & ATMEL_SSC_TD)
-		at91_set_B_periph(AT91_PIN_PB2, 1);
-	if (pins & ATMEL_SSC_RD)
-		at91_set_B_periph(AT91_PIN_PB3, 1);
-	if (pins & ATMEL_SSC_RK)
-		at91_set_B_periph(AT91_PIN_PB4, 1);
-	if (pins & ATMEL_SSC_RF)
-		at91_set_B_periph(AT91_PIN_PB5, 1);
-}
-
-static u64 ssc1_dmamask = DMA_BIT_MASK(32);
-
-static struct resource ssc1_resources[] = {
-	[0] = {
-		.start	= AT91SAM9263_BASE_SSC1,
-		.end	= AT91SAM9263_BASE_SSC1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9263_ID_SSC1,
-		.end	= AT91SAM9263_ID_SSC1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9263_ssc1_device = {
-	.name	= "ssc",
-	.id	= 1,
-	.dev	= {
-		.dma_mask		= &ssc1_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= ssc1_resources,
-	.num_resources	= ARRAY_SIZE(ssc1_resources),
+static struct at91_dev_table_ssc device_ssc0 __initdata = {
+	.mmio_base	= AT91SAM9263_BASE_SSC0,
+	.irq		= AT91SAM9263_ID_SSC0,
+	.clock_asc	= "ssc0_clk",
+	.clock_name	= "pclk",
+	.tf_pin		= {AT91_PIN_PB0, AT91_PIN_PERIPH_B, 1, 0, 0},
+	.tk_pin		= {AT91_PIN_PB1, AT91_PIN_PERIPH_B, 1, 0, 0},
+	.td_pin		= {AT91_PIN_PB2, AT91_PIN_PERIPH_B, 1, 0, 0},
+	.rd_pin		= {AT91_PIN_PB3, AT91_PIN_PERIPH_B, 1, 0, 0},
+	.rk_pin		= {AT91_PIN_PB4, AT91_PIN_PERIPH_B, 1, 0, 0},
+	.rf_pin		= {AT91_PIN_PB5, AT91_PIN_PERIPH_B, 1, 0, 0},
+};
+
+static struct at91_dev_table_ssc device_ssc1 __initdata = {
+	.mmio_base	= AT91SAM9263_BASE_SSC1,
+	.irq		= AT91SAM9263_ID_SSC1,
+	.clock_asc	= "ssc1_clk",
+	.clock_name	= "pclk",
+	.tf_pin		= {AT91_PIN_PB6,  AT91_PIN_PERIPH_A, 1, 0, 0},
+	.tk_pin		= {AT91_PIN_PB7,  AT91_PIN_PERIPH_A, 1, 0, 0},
+	.td_pin		= {AT91_PIN_PB8,  AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rd_pin		= {AT91_PIN_PB9,  AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rk_pin		= {AT91_PIN_PB10, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rf_pin		= {AT91_PIN_PB11, AT91_PIN_PERIPH_A, 1, 0, 0},
 };
 
-static inline void configure_ssc1_pins(unsigned pins)
-{
-	if (pins & ATMEL_SSC_TF)
-		at91_set_A_periph(AT91_PIN_PB6, 1);
-	if (pins & ATMEL_SSC_TK)
-		at91_set_A_periph(AT91_PIN_PB7, 1);
-	if (pins & ATMEL_SSC_TD)
-		at91_set_A_periph(AT91_PIN_PB8, 1);
-	if (pins & ATMEL_SSC_RD)
-		at91_set_A_periph(AT91_PIN_PB9, 1);
-	if (pins & ATMEL_SSC_RK)
-		at91_set_A_periph(AT91_PIN_PB10, 1);
-	if (pins & ATMEL_SSC_RF)
-		at91_set_A_periph(AT91_PIN_PB11, 1);
-}
-
-/*
- * SSC controllers are accessed through library code, instead of any
- * kind of all-singing/all-dancing driver.  For example one could be
- * used by a particular I2S audio codec's driver, while another one
- * on the same system might be used by a custom data capture driver.
- */
-void __init at91_add_device_ssc(unsigned id, unsigned pins)
-{
-	struct platform_device *pdev;
-
-	/*
-	 * NOTE: caller is responsible for passing information matching
-	 * "pins" to whatever will be using each particular controller.
-	 */
-	switch (id) {
-	case AT91SAM9263_ID_SSC0:
-		pdev = &at91sam9263_ssc0_device;
-		configure_ssc0_pins(pins);
-		at91_clock_associate("ssc0_clk", &pdev->dev, "pclk");
-		break;
-	case AT91SAM9263_ID_SSC1:
-		pdev = &at91sam9263_ssc1_device;
-		configure_ssc1_pins(pins);
-		at91_clock_associate("ssc1_clk", &pdev->dev, "pclk");
-		break;
-	default:
-		return;
-	}
-
-	platform_device_register(pdev);
-}
-
-#else
-void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  UART
  * -------------------------------------------------------------------- */
@@ -750,6 +654,8 @@ static struct at91_device_table at91sam9263_device_table __initdata = {
 	.uart[1]	= &device_uart1,
 	.uart[2]	= &device_uart2,
 	.pwm		= &device_pwm,
+	.ssc[0]		= &device_ssc0,
+	.ssc[1]		= &device_ssc1,
 };
 
 void __init at91sam9263_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 17eb984..8ad9c12 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -584,128 +584,32 @@ static struct at91_dev_table_pwm device_pwm __initdata = {
  *  SSC -- Synchronous Serial Controller
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_ATMEL_SSC) || defined(CONFIG_ATMEL_SSC_MODULE)
-static u64 ssc0_dmamask = DMA_BIT_MASK(32);
-
-static struct resource ssc0_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_BASE_SSC0,
-		.end	= AT91SAM9G45_BASE_SSC0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_ID_SSC0,
-		.end	= AT91SAM9G45_ID_SSC0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9g45_ssc0_device = {
-	.name	= "ssc",
-	.id	= 0,
-	.dev	= {
-		.dma_mask		= &ssc0_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= ssc0_resources,
-	.num_resources	= ARRAY_SIZE(ssc0_resources),
-};
-
-static inline void configure_ssc0_pins(unsigned pins)
-{
-	if (pins & ATMEL_SSC_TF)
-		at91_set_A_periph(AT91_PIN_PD1, 1);
-	if (pins & ATMEL_SSC_TK)
-		at91_set_A_periph(AT91_PIN_PD0, 1);
-	if (pins & ATMEL_SSC_TD)
-		at91_set_A_periph(AT91_PIN_PD2, 1);
-	if (pins & ATMEL_SSC_RD)
-		at91_set_A_periph(AT91_PIN_PD3, 1);
-	if (pins & ATMEL_SSC_RK)
-		at91_set_A_periph(AT91_PIN_PD4, 1);
-	if (pins & ATMEL_SSC_RF)
-		at91_set_A_periph(AT91_PIN_PD5, 1);
-}
-
-static u64 ssc1_dmamask = DMA_BIT_MASK(32);
-
-static struct resource ssc1_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_BASE_SSC1,
-		.end	= AT91SAM9G45_BASE_SSC1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_ID_SSC1,
-		.end	= AT91SAM9G45_ID_SSC1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9g45_ssc1_device = {
-	.name	= "ssc",
-	.id	= 1,
-	.dev	= {
-		.dma_mask		= &ssc1_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= ssc1_resources,
-	.num_resources	= ARRAY_SIZE(ssc1_resources),
+static struct at91_dev_table_ssc device_ssc0 __initdata = {
+	.mmio_base	= AT91SAM9G45_BASE_SSC0,
+	.irq		= AT91SAM9G45_ID_SSC0,
+	.clock_asc	= "ssc0_clk",
+	.clock_name	= "pclk",
+	.tf_pin		= {AT91_PIN_PD1, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.tk_pin		= {AT91_PIN_PD0, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.td_pin		= {AT91_PIN_PD2, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rd_pin		= {AT91_PIN_PD3, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rk_pin		= {AT91_PIN_PD4, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rf_pin		= {AT91_PIN_PD5, AT91_PIN_PERIPH_A, 1, 0, 0},
+};
+
+static struct at91_dev_table_ssc device_ssc1 __initdata = {
+	.mmio_base	= AT91SAM9G45_BASE_SSC1,
+	.irq		= AT91SAM9G45_ID_SSC1,
+	.clock_asc	= "ssc1_clk",
+	.clock_name	= "pclk",
+	.tf_pin		= {AT91_PIN_PD14, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.tk_pin		= {AT91_PIN_PD12, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.td_pin		= {AT91_PIN_PD10, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rd_pin		= {AT91_PIN_PD11, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rk_pin		= {AT91_PIN_PD13, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rf_pin		= {AT91_PIN_PD15, AT91_PIN_PERIPH_A, 1, 0, 0},
 };
 
-static inline void configure_ssc1_pins(unsigned pins)
-{
-	if (pins & ATMEL_SSC_TF)
-		at91_set_A_periph(AT91_PIN_PD14, 1);
-	if (pins & ATMEL_SSC_TK)
-		at91_set_A_periph(AT91_PIN_PD12, 1);
-	if (pins & ATMEL_SSC_TD)
-		at91_set_A_periph(AT91_PIN_PD10, 1);
-	if (pins & ATMEL_SSC_RD)
-		at91_set_A_periph(AT91_PIN_PD11, 1);
-	if (pins & ATMEL_SSC_RK)
-		at91_set_A_periph(AT91_PIN_PD13, 1);
-	if (pins & ATMEL_SSC_RF)
-		at91_set_A_periph(AT91_PIN_PD15, 1);
-}
-
-/*
- * SSC controllers are accessed through library code, instead of any
- * kind of all-singing/all-dancing driver.  For example one could be
- * used by a particular I2S audio codec's driver, while another one
- * on the same system might be used by a custom data capture driver.
- */
-void __init at91_add_device_ssc(unsigned id, unsigned pins)
-{
-	struct platform_device *pdev;
-
-	/*
-	 * NOTE: caller is responsible for passing information matching
-	 * "pins" to whatever will be using each particular controller.
-	 */
-	switch (id) {
-	case AT91SAM9G45_ID_SSC0:
-		pdev = &at91sam9g45_ssc0_device;
-		configure_ssc0_pins(pins);
-		at91_clock_associate("ssc0_clk", &pdev->dev, "pclk");
-		break;
-	case AT91SAM9G45_ID_SSC1:
-		pdev = &at91sam9g45_ssc1_device;
-		configure_ssc1_pins(pins);
-		at91_clock_associate("ssc1_clk", &pdev->dev, "pclk");
-		break;
-	default:
-		return;
-	}
-
-	platform_device_register(pdev);
-}
-
-#else
-void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  UART
  * -------------------------------------------------------------------- */
@@ -799,6 +703,8 @@ static struct at91_device_table at91sam9g45_device_table __initdata = {
 	.uart[2]	= &device_uart2,
 	.uart[3]	= &device_uart3,
 	.pwm		= &device_pwm,
+	.ssc[0]		= &device_ssc0,
+	.ssc[1]		= &device_ssc1,
 };
 
 void __init at91sam9g45_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 76aa9b6..20f516d 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -462,128 +462,32 @@ static struct at91_dev_table_pwm device_pwm __initdata = {
  *  SSC -- Synchronous Serial Controller
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_ATMEL_SSC) || defined(CONFIG_ATMEL_SSC_MODULE)
-static u64 ssc0_dmamask = DMA_BIT_MASK(32);
-
-static struct resource ssc0_resources[] = {
-	[0] = {
-		.start	= AT91SAM9RL_BASE_SSC0,
-		.end	= AT91SAM9RL_BASE_SSC0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9RL_ID_SSC0,
-		.end	= AT91SAM9RL_ID_SSC0,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_dev_table_ssc device_ssc0 __initdata = {
+	.mmio_base	= AT91SAM9RL_BASE_SSC0,
+	.irq		= AT91SAM9RL_ID_SSC0,
+	.clock_asc	= "ssc0_clk",
+	.clock_name	= "pclk",
+	.tf_pin		= {AT91_PIN_PC0,  AT91_PIN_PERIPH_A, 1, 0, 0},
+	.tk_pin		= {AT91_PIN_PC1,  AT91_PIN_PERIPH_A, 1, 0, 0},
+	.td_pin		= {AT91_PIN_PA15, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rd_pin		= {AT91_PIN_PA16, AT91_PIN_PERIPH_A, 1, 0, 0},
+	.rk_pin		= {AT91_PIN_PA10, AT91_PIN_PERIPH_B, 1, 0, 0},
+	.rf_pin		= {AT91_PIN_PA22, AT91_PIN_PERIPH_B, 1, 0, 0},
 };
 
-static struct platform_device at91sam9rl_ssc0_device = {
-	.name	= "ssc",
-	.id	= 0,
-	.dev	= {
-		.dma_mask		= &ssc0_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= ssc0_resources,
-	.num_resources	= ARRAY_SIZE(ssc0_resources),
+static struct at91_dev_table_ssc device_ssc1 __initdata = {
+	.mmio_base	= AT91SAM9RL_BASE_SSC1,
+	.irq		= AT91SAM9RL_ID_SSC1,
+	.clock_asc	= "ssc1_clk",
+	.clock_name	= "pclk",
+	.tf_pin		= {AT91_PIN_PA29, AT91_PIN_PERIPH_B, 1, 0, 0},
+	.tk_pin		= {AT91_PIN_PA30, AT91_PIN_PERIPH_B, 1, 0, 0},
+	.td_pin		= {AT91_PIN_PA13, AT91_PIN_PERIPH_B, 1, 0, 0},
+	.rd_pin		= {AT91_PIN_PA14, AT91_PIN_PERIPH_B, 1, 0, 0},
+	.rk_pin		= {AT91_PIN_PA9,  AT91_PIN_PERIPH_B, 1, 0, 0},
+	.rf_pin		= {AT91_PIN_PA8,  AT91_PIN_PERIPH_B, 1, 0, 0},
 };
 
-static inline void configure_ssc0_pins(unsigned pins)
-{
-	if (pins & ATMEL_SSC_TF)
-		at91_set_A_periph(AT91_PIN_PC0, 1);
-	if (pins & ATMEL_SSC_TK)
-		at91_set_A_periph(AT91_PIN_PC1, 1);
-	if (pins & ATMEL_SSC_TD)
-		at91_set_A_periph(AT91_PIN_PA15, 1);
-	if (pins & ATMEL_SSC_RD)
-		at91_set_A_periph(AT91_PIN_PA16, 1);
-	if (pins & ATMEL_SSC_RK)
-		at91_set_B_periph(AT91_PIN_PA10, 1);
-	if (pins & ATMEL_SSC_RF)
-		at91_set_B_periph(AT91_PIN_PA22, 1);
-}
-
-static u64 ssc1_dmamask = DMA_BIT_MASK(32);
-
-static struct resource ssc1_resources[] = {
-	[0] = {
-		.start	= AT91SAM9RL_BASE_SSC1,
-		.end	= AT91SAM9RL_BASE_SSC1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9RL_ID_SSC1,
-		.end	= AT91SAM9RL_ID_SSC1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9rl_ssc1_device = {
-	.name	= "ssc",
-	.id	= 1,
-	.dev	= {
-		.dma_mask		= &ssc1_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= ssc1_resources,
-	.num_resources	= ARRAY_SIZE(ssc1_resources),
-};
-
-static inline void configure_ssc1_pins(unsigned pins)
-{
-	if (pins & ATMEL_SSC_TF)
-		at91_set_B_periph(AT91_PIN_PA29, 1);
-	if (pins & ATMEL_SSC_TK)
-		at91_set_B_periph(AT91_PIN_PA30, 1);
-	if (pins & ATMEL_SSC_TD)
-		at91_set_B_periph(AT91_PIN_PA13, 1);
-	if (pins & ATMEL_SSC_RD)
-		at91_set_B_periph(AT91_PIN_PA14, 1);
-	if (pins & ATMEL_SSC_RK)
-		at91_set_B_periph(AT91_PIN_PA9, 1);
-	if (pins & ATMEL_SSC_RF)
-		at91_set_B_periph(AT91_PIN_PA8, 1);
-}
-
-/*
- * SSC controllers are accessed through library code, instead of any
- * kind of all-singing/all-dancing driver.  For example one could be
- * used by a particular I2S audio codec's driver, while another one
- * on the same system might be used by a custom data capture driver.
- */
-void __init at91_add_device_ssc(unsigned id, unsigned pins)
-{
-	struct platform_device *pdev;
-
-	/*
-	 * NOTE: caller is responsible for passing information matching
-	 * "pins" to whatever will be using each particular controller.
-	 */
-	switch (id) {
-	case AT91SAM9RL_ID_SSC0:
-		pdev = &at91sam9rl_ssc0_device;
-		configure_ssc0_pins(pins);
-		at91_clock_associate("ssc0_clk", &pdev->dev, "pclk");
-		break;
-	case AT91SAM9RL_ID_SSC1:
-		pdev = &at91sam9rl_ssc1_device;
-		configure_ssc1_pins(pins);
-		at91_clock_associate("ssc1_clk", &pdev->dev, "pclk");
-		break;
-	default:
-		return;
-	}
-
-	platform_device_register(pdev);
-}
-
-#else
-void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  UART
  * -------------------------------------------------------------------- */
@@ -674,6 +578,8 @@ static struct at91_device_table at91sam9rl_device_table __initdata = {
 	.uart[2]	= &device_uart2,
 	.uart[3]	= &device_uart3,
 	.pwm		= &device_pwm,
+	.ssc[0]		= &device_ssc0,
+	.ssc[1]		= &device_ssc1,
 };
 
 void __init at91sam9rl_init_devices(void)
diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index 9c7073a..b285cc6 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -211,7 +211,7 @@ static void __init afeb9260_board_init(void)
 	at91_add_device_i2c(0, afeb9260_i2c_devices,
 			ARRAY_SIZE(afeb9260_i2c_devices));
 	/* Audio */
-	at91_add_device_ssc(AT91SAM9260_ID_SSC, ATMEL_SSC_TX);
+	at91_add_device_ssc(0, ATMEL_SSC_TX);
 	/* IDE */
 	at91_add_device_cf(&afeb9260_cf_data);
 }
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index 2bfac4e..d4f27f9 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -347,7 +347,7 @@ static void __init ek_board_init(void)
 	at91_add_device_i2c(0, ek_i2c_devices, ARRAY_SIZE(ek_i2c_devices));
 	/* SSC (to AT73C213) */
 	at73c213_set_clk(&at73c213_data);
-	at91_add_device_ssc(AT91SAM9260_ID_SSC, ATMEL_SSC_TX);
+	at91_add_device_ssc(0, ATMEL_SSC_TX);
 	/* LEDs */
 	at91_gpio_leds(ek_leds, ARRAY_SIZE(ek_leds));
 	/* Push Buttons */
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index 3e848ba..1139b69 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -604,7 +604,7 @@ static void __init ek_board_init(void)
 	ek_add_device_ts();
 	/* SSC (to AT73C213) */
 	at73c213_set_clk(&at73c213_data);
-	at91_add_device_ssc(AT91SAM9261_ID_SSC1, ATMEL_SSC_TX);
+	at91_add_device_ssc(1, ATMEL_SSC_TX);
 #else
 	/* MMC */
 	at91_add_device_mmc(0, &ek_mmc_data);
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index cc43eae..940f6a0 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -401,7 +401,7 @@ static void __init ek_board_init(void)
 	/* PCK0 provides MCLK to the WM8731 */
 	at91_set_B_periph(AT91_PIN_PC1, 0);
 	/* SSC (for WM8731) */
-	at91_add_device_ssc(AT91SAM9260_ID_SSC, ATMEL_SSC_TX);
+	at91_add_device_ssc(0, ATMEL_SSC_TX);
 }
 
 MACHINE_START(AT91SAM9G20EK, "Atmel AT91SAM9G20-EK")
diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
index 4c90ee3..99a1b6d 100644
--- a/arch/arm/mach-at91/board-snapper9260.c
+++ b/arch/arm/mach-at91/board-snapper9260.c
@@ -172,8 +172,8 @@ static void __init snapper9260_board_init(void)
 	at91_add_device_usbh_ohci(&snapper9260_usbh_data);
 	at91_add_device_udc(&snapper9260_udc_data);
 	at91_add_device_eth(&snapper9260_macb_data);
-	at91_add_device_ssc(AT91SAM9260_ID_SSC, (ATMEL_SSC_TF | ATMEL_SSC_TK |
-						 ATMEL_SSC_TD | ATMEL_SSC_RD));
+	at91_add_device_ssc(0, (ATMEL_SSC_TF | ATMEL_SSC_TK |
+				ATMEL_SSC_TD | ATMEL_SSC_RD));
 	snapper9260_add_device_nand();
 }
 
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index f79a98a..3671e9e 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c
@@ -975,6 +975,96 @@ void __init at91_add_device_pwm(u32 mask)
 void __init at91_add_device_pwm(u32 mask) {}
 #endif
 
+/* --------------------------------------------------------------------
+ *  SSC -- Synchronous Serial Controller
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_ATMEL_SSC) || defined(CONFIG_ATMEL_SSC_MODULE)
+static u64 ssc_dmamask[4];
+
+static struct platform_device at91_ssc_devices[] = {
+	[0] = {
+		.name	= "ssc",
+		.id	= 0,
+		.dev	= {
+			.dma_mask		= &ssc_dmamask[0],
+			.coherent_dma_mask	= DMA_BIT_MASK(32),
+		},
+	},
+	[1] = {
+		.name	= "ssc",
+		.id	= 1,
+		.dev	= {
+			.dma_mask		= &ssc_dmamask[1],
+			.coherent_dma_mask	= DMA_BIT_MASK(32),
+		},
+	},
+	[2] = {
+		.name	= "ssc",
+		.id	= 2,
+		.dev	= {
+			.dma_mask		= &ssc_dmamask[2],
+			.coherent_dma_mask	= DMA_BIT_MASK(32),
+		},
+	},
+	[3] = {
+		.name	= "ssc",
+		.id	= 3,
+		.dev	= {
+			.dma_mask		= &ssc_dmamask[3],
+			.coherent_dma_mask	= DMA_BIT_MASK(32),
+		},
+	},
+};
+
+/*
+ * SSC controllers are accessed through library code, instead of any
+ * kind of all-singing/all-dancing driver.  For example one could be
+ * used by a particular I2S audio codec's driver, while another one
+ * on the same system might be used by a custom data capture driver.
+ */
+void __init at91_add_device_ssc(unsigned id, unsigned pins)
+{
+	struct at91_dev_table_ssc *info;
+	struct platform_device *pdev;
+	struct resource *resources[2] = {{0}};
+
+	BUG_ON(id < 0 || id >= ARRAY_SIZE(devices->ssc) || !devices->ssc[id]);
+	info = devices->ssc[id];
+	BUG_ON(!info);
+
+	/*
+	 * NOTE: caller is responsible for passing information matching
+	 * "pins" to whatever will be using each particular controller.
+	 */
+	pdev = &at91_ssc_device[id];
+	ssc_dmamask[id] = DMA_BIT_MASK(32);
+
+	init_resource_mem(&resources[0], info->mmio_base, SZ_16K);
+	init_resource_irq(&resources[1], info->irq);
+	if (info->clock_asc)
+		at91_clock_associate(info->clock_asc, &pdev->dev, "pclk");
+
+	if (pins & ATMEL_SSC_TF)
+		at91_config_pins(&info->tf_pin, 1);
+	if (pins & ATMEL_SSC_TK)
+		at91_config_pins(&info->tk_pin, 1);
+	if (pins & ATMEL_SSC_TD)
+		at91_config_pins(&info->td_pin, 1);
+	if (pins & ATMEL_SSC_RD)
+		at91_config_pins(&info->rd_pin, 1);
+	if (pins & ATMEL_SSC_RK)
+		at91_config_pins(&info->rk_pin, 1);
+	if (pins & ATMEL_SSC_RF)
+		at91_config_pins(&info->rf_pin, 1);
+
+	at91_add_platform_device(pdev, resources, ARRAY_SIZE(resources),
+				 NULL, 0);
+}
+#else
+void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
+#endif
+
 static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_tc();
diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
index 52563be..177fc3d 100644
--- a/arch/arm/mach-at91/devices.h
+++ b/arch/arm/mach-at91/devices.h
@@ -128,6 +128,19 @@ struct at91_dev_table_pwm {
 	struct at91_pin_config	pwm_pins[4];
 };
 
+struct at91_dev_table_ssc {
+	unsigned		mmio_base;
+	int			irq;
+	const char		*clock_asc;
+	const char		*clock_name;
+	struct at91_pin_config	tf_pin;
+	struct at91_pin_config	tk_pin;
+	struct at91_pin_config	td_pin;
+	struct at91_pin_config	rf_pin;
+	struct at91_pin_config	rd_pin;
+	struct at91_pin_config	rk_pin;
+};
+
 struct at91_device_table {
 	struct at91_dev_table_ethernet		*ethernet;
 	struct at91_dev_table_usb_ohci		*usbh_ohci;
@@ -142,6 +155,7 @@ struct at91_device_table {
 	struct at91_dev_table_uart		*dbgu;
 	struct at91_dev_table_uart		*uart[6];
 	struct at91_dev_table_pwm		*pwm;
+	struct at91_dev_table_ssc		*ssc[4];
 };
 
 extern void __init at91_init_devices(struct at91_device_table *device_table);
-- 
1.7.0.4
