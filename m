From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed,  2 Feb 2011 07:27:07 +0100
Subject: [to be tested] [PATCH] at91: switch to CLKDEV_LOOKUP
Message-ID: <1296628027-1932-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

with this first commit we do not change the clock naming convention so
does not need to switch the AVR32 yet

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/Kconfig                         |    1 +
 arch/arm/mach-at91/at572d940hf.c         |   84 ++++++++++++++++---------
 arch/arm/mach-at91/at91cap9.c            |   76 +++++++++++++----------
 arch/arm/mach-at91/at91rm9200.c          |   66 ++++++++++++--------
 arch/arm/mach-at91/at91sam9260.c         |   66 ++++++++++++--------
 arch/arm/mach-at91/at91sam9261.c         |   68 +++++++++++++--------
 arch/arm/mach-at91/at91sam9263.c         |   68 ++++++++++++--------
 arch/arm/mach-at91/at91sam9g45.c         |   99 +++++++++++++++--------------
 arch/arm/mach-at91/at91sam9rl.c          |   62 +++++++++++--------
 arch/arm/mach-at91/clock.c               |   60 ++++--------------
 arch/arm/mach-at91/clock.h               |    7 +-
 arch/arm/mach-at91/generic.h             |   12 +++-
 arch/arm/mach-at91/include/mach/clkdev.h |    7 ++
 13 files changed, 383 insertions(+), 293 deletions(-)
 create mode 100644 arch/arm/mach-at91/include/mach/clkdev.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5cff165..3d88948 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -278,6 +278,7 @@ config ARCH_AT91
 	bool "Atmel AT91"
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_CLK
+	select CLKDEV_LOOKUP
 	help
 	  This enables support for systems based on the Atmel AT91RM9200,
 	  AT91SAM9 and AT91CAP9 processors.
diff --git a/arch/arm/mach-at91/at572d940hf.c b/arch/arm/mach-at91/at572d940hf.c
index a6b9c68..1cd9e0d 100644
--- a/arch/arm/mach-at91/at572d940hf.c
+++ b/arch/arm/mach-at91/at572d940hf.c
@@ -56,122 +56,98 @@ static struct map_desc at572d940hf_io_desc[] __initdata = {
  * The peripheral clocks.
  */
 static struct clk pioA_clk = {
-	.name		= "pioA_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_PIOA,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk pioB_clk = {
-	.name		= "pioB_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_PIOB,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk pioC_clk = {
-	.name		= "pioC_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_PIOC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk macb_clk = {
-	.name		= "macb_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_EMAC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart0_clk = {
-	.name		= "usart0_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_US0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart1_clk = {
-	.name		= "usart1_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_US1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart2_clk = {
-	.name		= "usart2_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_US2,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk mmc_clk = {
-	.name		= "mci_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_MCI,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk udc_clk = {
-	.name		= "udc_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_UDP,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk twi0_clk = {
-	.name		= "twi0_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_TWI0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk spi0_clk = {
-	.name		= "spi0_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_SPI0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk spi1_clk = {
-	.name		= "spi1_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_SPI1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ssc0_clk = {
-	.name		= "ssc0_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_SSC0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ssc1_clk = {
-	.name		= "ssc1_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_SSC1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ssc2_clk = {
-	.name		= "ssc2_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_SSC2,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tc0_clk = {
-	.name		= "tc0_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_TC0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tc1_clk = {
-	.name		= "tc1_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_TC1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tc2_clk = {
-	.name		= "tc2_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_TC2,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ohci_clk = {
-	.name		= "ohci_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_UHP,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ssc3_clk = {
-	.name		= "ssc3_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_SSC3,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk twi1_clk = {
-	.name		= "twi1_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_TWI1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk can0_clk = {
-	.name		= "can0_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_CAN0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk can1_clk = {
-	.name		= "can1_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_CAN1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk mAgicV_clk = {
-	.name		= "mAgicV_clk",
 	.pmc_mask	= 1 << AT572D940HF_ID_MSIRQ0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
@@ -205,56 +181,91 @@ static struct clk *periph_clocks[] __initdata = {
 	/* irq0 .. irq2 */
 };
 
+static struct clk_lookup periph_clocks_lookups[] = {
+	CLKDEV_CON_ID("pioA_clk", &pioA_clk),
+	CLKDEV_CON_ID("pioB_clk", &pioB_clk),
+	CLKDEV_CON_ID("pioC_clk", &pioC_clk),
+	CLKDEV_CON_ID("macb_clk", &macb_clk),
+	CLKDEV_CON_ID("usart0_clk", &usart0_clk),
+	CLKDEV_CON_ID("usart1_clk", &usart1_clk),
+	CLKDEV_CON_ID("usart2_clk", &usart2_clk),
+	CLKDEV_CON_ID("mci_clk", &mmc_clk),
+	CLKDEV_CON_ID("udc_clk", &udc_clk),
+	CLKDEV_CON_ID("twi0_clk", &twi0_clk),
+	CLKDEV_CON_ID("spi0_clk", &spi0_clk),
+	CLKDEV_CON_ID("spi1_clk", &spi1_clk),
+	CLKDEV_CON_ID("ssc0_clk", &ssc0_clk),
+	CLKDEV_CON_ID("ssc1_clk", &ssc1_clk),
+	CLKDEV_CON_ID("ssc2_clk", &ssc2_clk),
+	CLKDEV_CON_ID("tc0_clk", &tc0_clk),
+	CLKDEV_CON_ID("tc1_clk", &tc1_clk),
+	CLKDEV_CON_ID("tc2_clk", &tc2_clk),
+	CLKDEV_CON_ID("ohci_clk", &ohci_clk),
+	CLKDEV_CON_ID("ssc3_clk", &ssc3_clk),
+	CLKDEV_CON_ID("twi1_clk", &twi1_clk),
+	CLKDEV_CON_ID("can0_clk", &can0_clk),
+	CLKDEV_CON_ID("can1_clk", &can1_clk),
+	CLKDEV_CON_ID("mAgicV_clk", &mAgicV_clk),
+};
+
 /*
  * The five programmable clocks.
  * You must configure pin multiplexing to bring these signals out.
  */
 static struct clk pck0 = {
-	.name		= "pck0",
 	.pmc_mask	= AT91_PMC_PCK0,
 	.type		= CLK_TYPE_PROGRAMMABLE,
 	.id		= 0,
 };
 static struct clk pck1 = {
-	.name		= "pck1",
 	.pmc_mask	= AT91_PMC_PCK1,
 	.type		= CLK_TYPE_PROGRAMMABLE,
 	.id		= 1,
 };
 static struct clk pck2 = {
-	.name		= "pck2",
 	.pmc_mask	= AT91_PMC_PCK2,
 	.type		= CLK_TYPE_PROGRAMMABLE,
 	.id		= 2,
 };
 static struct clk pck3 = {
-	.name		= "pck3",
 	.pmc_mask	= AT91_PMC_PCK3,
 	.type		= CLK_TYPE_PROGRAMMABLE,
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
-	.name		= "mAgicV_mem_clk",
 	.pmc_mask	= AT91_PMC_PCK4,
 	.type		= CLK_TYPE_PROGRAMMABLE,
 	.id		= 4,
 };
 
+static struct clk_lookup mAgicV_mem_clk_lookup =
+	CLKDEV_CON_ID("mAgicV_mem_clk", &mAgicV_mem_clk);
+
 /* HClocks */
 static struct clk hck0 = {
-	.name		= "hck0",
 	.pmc_mask	= AT91_PMC_HCK0,
 	.type		= CLK_TYPE_SYSTEM,
 	.id		= 0,
 };
 static struct clk hck1 = {
-	.name		= "hck1",
 	.pmc_mask	= AT91_PMC_HCK1,
 	.type		= CLK_TYPE_SYSTEM,
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
@@ -262,14 +273,25 @@ static void __init at572d940hf_register_clocks(void)
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
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index 7337617..af21ccd 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -50,142 +50,114 @@ static struct map_desc at91cap9_io_desc[] __initdata = {
  * The peripheral clocks.
  */
 static struct clk pioABCD_clk = {
-	.name		= "pioABCD_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_PIOABCD,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk mpb0_clk = {
-	.name		= "mpb0_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_MPB0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk mpb1_clk = {
-	.name		= "mpb1_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_MPB1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk mpb2_clk = {
-	.name		= "mpb2_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_MPB2,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk mpb3_clk = {
-	.name		= "mpb3_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_MPB3,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk mpb4_clk = {
-	.name		= "mpb4_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_MPB4,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart0_clk = {
-	.name		= "usart0_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_US0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart1_clk = {
-	.name		= "usart1_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_US1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart2_clk = {
-	.name		= "usart2_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_US2,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk mmc0_clk = {
-	.name		= "mci0_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_MCI0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk mmc1_clk = {
-	.name		= "mci1_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_MCI1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk can_clk = {
-	.name		= "can_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_CAN,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk twi_clk = {
-	.name		= "twi_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_TWI,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk spi0_clk = {
-	.name		= "spi0_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_SPI0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk spi1_clk = {
-	.name		= "spi1_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_SPI1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ssc0_clk = {
-	.name		= "ssc0_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_SSC0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ssc1_clk = {
-	.name		= "ssc1_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_SSC1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ac97_clk = {
-	.name		= "ac97_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_AC97C,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tcb_clk = {
-	.name		= "tcb_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_TCB,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk pwm_clk = {
-	.name		= "pwm_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_PWMC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk macb_clk = {
-	.name		= "macb_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_EMAC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk aestdes_clk = {
-	.name		= "aestdes_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_AESTDES,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk adc_clk = {
-	.name		= "adc_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_ADC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk isi_clk = {
-	.name		= "isi_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_ISI,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk lcdc_clk = {
-	.name		= "lcdc_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_LCDC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk dma_clk = {
-	.name		= "dma_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_DMA,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk udphs_clk = {
-	.name		= "udphs_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_UDPHS,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ohci_clk = {
-	.name		= "ohci_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_UHP,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
@@ -222,35 +194,69 @@ static struct clk *periph_clocks[] __initdata = {
 	// irq0 .. irq1
 };
 
+static struct clk_lookup periph_clocks_lookups[] = {
+	CLKDEV_CON_ID("pioABCD_clk", &pioABCD_clk),
+	CLKDEV_CON_ID("mpb0_clk", &mpb0_clk),
+	CLKDEV_CON_ID("mpb1_clk", &mpb1_clk),
+	CLKDEV_CON_ID("mpb2_clk", &mpb2_clk),
+	CLKDEV_CON_ID("mpb3_clk", &mpb3_clk),
+	CLKDEV_CON_ID("mpb4_clk", &mpb4_clk),
+	CLKDEV_CON_ID("usart0_clk", &usart0_clk),
+	CLKDEV_CON_ID("usart1_clk", &usart1_clk),
+	CLKDEV_CON_ID("usart2_clk", &usart2_clk),
+	CLKDEV_CON_ID("mci0_clk", &mmc0_clk),
+	CLKDEV_CON_ID("mci1_clk", &mmc1_clk),
+	CLKDEV_CON_ID("can_clk", &can_clk),
+	CLKDEV_CON_ID("twi_clk", &twi_clk),
+	CLKDEV_CON_ID("spi0_clk", &spi0_clk),
+	CLKDEV_CON_ID("spi1_clk", &spi1_clk),
+	CLKDEV_CON_ID("ssc0_clk", &ssc0_clk),
+	CLKDEV_CON_ID("ssc1_clk", &ssc1_clk),
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
+};
+
 /*
  * The four programmable clocks.
  * You must configure pin multiplexing to bring these signals out.
  */
 static struct clk pck0 = {
-	.name		= "pck0",
 	.pmc_mask	= AT91_PMC_PCK0,
 	.type		= CLK_TYPE_PROGRAMMABLE,
 	.id		= 0,
 };
 static struct clk pck1 = {
-	.name		= "pck1",
 	.pmc_mask	= AT91_PMC_PCK1,
 	.type		= CLK_TYPE_PROGRAMMABLE,
 	.id		= 1,
 };
 static struct clk pck2 = {
-	.name		= "pck2",
 	.pmc_mask	= AT91_PMC_PCK2,
 	.type		= CLK_TYPE_PROGRAMMABLE,
 	.id		= 2,
 };
 static struct clk pck3 = {
-	.name		= "pck3",
 	.pmc_mask	= AT91_PMC_PCK3,
 	.type		= CLK_TYPE_PROGRAMMABLE,
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
@@ -258,10 +264,16 @@ static void __init at91cap9_register_clocks(void)
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
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 2e9ecad..bd1e056 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -49,117 +49,94 @@ static struct map_desc at91rm9200_io_desc[] __initdata = {
  * The peripheral clocks.
  */
 static struct clk udc_clk = {
-	.name		= "udc_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_UDP,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ohci_clk = {
-	.name		= "ohci_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_UHP,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ether_clk = {
-	.name		= "ether_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_EMAC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk mmc_clk = {
-	.name		= "mci_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_MCI,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk twi_clk = {
-	.name		= "twi_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_TWI,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart0_clk = {
-	.name		= "usart0_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_US0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart1_clk = {
-	.name		= "usart1_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_US1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart2_clk = {
-	.name		= "usart2_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_US2,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart3_clk = {
-	.name		= "usart3_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_US3,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk spi_clk = {
-	.name		= "spi_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_SPI,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk pioA_clk = {
-	.name		= "pioA_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_PIOA,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk pioB_clk = {
-	.name		= "pioB_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_PIOB,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk pioC_clk = {
-	.name		= "pioC_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_PIOC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk pioD_clk = {
-	.name		= "pioD_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_PIOD,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ssc0_clk = {
-	.name		= "ssc0_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_SSC0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ssc1_clk = {
-	.name		= "ssc1_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_SSC1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ssc2_clk = {
-	.name		= "ssc2_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_SSC2,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tc0_clk = {
-	.name		= "tc0_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_TC0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tc1_clk = {
-	.name		= "tc1_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_TC1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tc2_clk = {
-	.name		= "tc2_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_TC2,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tc3_clk = {
-	.name		= "tc3_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_TC3,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tc4_clk = {
-	.name		= "tc4_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_TC4,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tc5_clk = {
-	.name		= "tc5_clk",
 	.pmc_mask	= 1 << AT91RM9200_ID_TC5,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
@@ -191,35 +168,64 @@ static struct clk *periph_clocks[] __initdata = {
 	// irq0 .. irq6
 };
 
+static struct clk_lookup periph_clocks_lookups[] = {
+	CLKDEV_CON_ID("udc_clk", &udc_clk),
+	CLKDEV_CON_ID("ohci_clk", &ohci_clk),
+	CLKDEV_CON_ID("ether_clk", &ether_clk),
+	CLKDEV_CON_ID("mci_clk", &mmc_clk),
+	CLKDEV_CON_ID("twi_clk", &twi_clk),
+	CLKDEV_CON_ID("usart0_clk", &usart0_clk),
+	CLKDEV_CON_ID("usart1_clk", &usart1_clk),
+	CLKDEV_CON_ID("usart2_clk", &usart2_clk),
+	CLKDEV_CON_ID("usart3_clk", &usart3_clk),
+	CLKDEV_CON_ID("spi_clk", &spi_clk),
+	CLKDEV_CON_ID("pioA_clk", &pioA_clk),
+	CLKDEV_CON_ID("pioB_clk", &pioB_clk),
+	CLKDEV_CON_ID("pioC_clk", &pioC_clk),
+	CLKDEV_CON_ID("pioD_clk", &pioD_clk),
+	CLKDEV_CON_ID("ssc0_clk", &ssc0_clk),
+	CLKDEV_CON_ID("ssc1_clk", &ssc1_clk),
+	CLKDEV_CON_ID("ssc2_clk", &ssc2_clk),
+	CLKDEV_CON_ID("tc0_clk", &tc0_clk),
+	CLKDEV_CON_ID("tc1_clk", &tc1_clk),
+	CLKDEV_CON_ID("tc2_clk", &tc2_clk),
+	CLKDEV_CON_ID("tc3_clk", &tc3_clk),
+	CLKDEV_CON_ID("tc4_clk", &tc4_clk),
+	CLKDEV_CON_ID("tc5_clk", &tc5_clk),
+};
+
 /*
  * The four programmable clocks.
  * You must configure pin multiplexing to bring these signals out.
  */
 static struct clk pck0 = {
-	.name		= "pck0",
 	.pmc_mask	= AT91_PMC_PCK0,
 	.type		= CLK_TYPE_PROGRAMMABLE,
 	.id		= 0,
 };
 static struct clk pck1 = {
-	.name		= "pck1",
 	.pmc_mask	= AT91_PMC_PCK1,
 	.type		= CLK_TYPE_PROGRAMMABLE,
 	.id		= 1,
 };
 static struct clk pck2 = {
-	.name		= "pck2",
 	.pmc_mask	= AT91_PMC_PCK2,
 	.type		= CLK_TYPE_PROGRAMMABLE,
 	.id		= 2,
 };
 static struct clk pck3 = {
-	.name		= "pck3",
 	.pmc_mask	= AT91_PMC_PCK3,
 	.type		= CLK_TYPE_PROGRAMMABLE,
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
@@ -227,10 +233,16 @@ static void __init at91rm9200_register_clocks(void)
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
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 195208b..447879e 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -77,127 +77,102 @@ static struct map_desc at91sam9xe_sram_desc[] __initdata = {
  * The peripheral clocks.
  */
 static struct clk pioA_clk = {
-	.name		= "pioA_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_PIOA,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk pioB_clk = {
-	.name		= "pioB_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_PIOB,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk pioC_clk = {
-	.name		= "pioC_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_PIOC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk adc_clk = {
-	.name		= "adc_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_ADC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart0_clk = {
-	.name		= "usart0_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_US0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart1_clk = {
-	.name		= "usart1_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_US1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart2_clk = {
-	.name		= "usart2_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_US2,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk mmc_clk = {
-	.name		= "mci_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_MCI,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk udc_clk = {
-	.name		= "udc_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_UDP,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk twi_clk = {
-	.name		= "twi_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_TWI,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk spi0_clk = {
-	.name		= "spi0_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_SPI0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk spi1_clk = {
-	.name		= "spi1_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_SPI1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ssc_clk = {
-	.name		= "ssc_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_SSC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tc0_clk = {
-	.name		= "tc0_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_TC0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tc1_clk = {
-	.name		= "tc1_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_TC1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tc2_clk = {
-	.name		= "tc2_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_TC2,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ohci_clk = {
-	.name		= "ohci_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_UHP,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk macb_clk = {
-	.name		= "macb_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_EMAC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk isi_clk = {
-	.name		= "isi_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_ISI,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart3_clk = {
-	.name		= "usart3_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_US3,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart4_clk = {
-	.name		= "usart4_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_US4,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart5_clk = {
-	.name		= "usart5_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_US5,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tc3_clk = {
-	.name		= "tc3_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_TC3,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tc4_clk = {
-	.name		= "tc4_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_TC4,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tc5_clk = {
-	.name		= "tc5_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_TC5,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
@@ -231,23 +206,54 @@ static struct clk *periph_clocks[] __initdata = {
 	// irq0 .. irq2
 };
 
+static struct clk_lookup periph_clocks_lookups[] = {
+	CLKDEV_CON_ID("pioA_clk", &pioA_clk),
+	CLKDEV_CON_ID("pioB_clk", &pioB_clk),
+	CLKDEV_CON_ID("pioC_clk", &pioC_clk),
+	CLKDEV_CON_ID("adc_clk", &adc_clk),
+	CLKDEV_CON_ID("usart0_clk", &usart0_clk),
+	CLKDEV_CON_ID("usart1_clk", &usart1_clk),
+	CLKDEV_CON_ID("usart2_clk", &usart2_clk),
+	CLKDEV_CON_ID("mci_clk", &mmc_clk),
+	CLKDEV_CON_ID("udc_clk", &udc_clk),
+	CLKDEV_CON_ID("twi_clk", &twi_clk),
+	CLKDEV_CON_ID("spi0_clk", &spi0_clk),
+	CLKDEV_CON_ID("spi1_clk", &spi1_clk),
+	CLKDEV_CON_ID("ssc_clk", &ssc_clk),
+	CLKDEV_CON_ID("tc0_clk", &tc0_clk),
+	CLKDEV_CON_ID("tc1_clk", &tc1_clk),
+	CLKDEV_CON_ID("tc2_clk", &tc2_clk),
+	CLKDEV_CON_ID("ohci_clk", &ohci_clk),
+	CLKDEV_CON_ID("macb_clk", &macb_clk),
+	CLKDEV_CON_ID("isi_clk", &isi_clk),
+	CLKDEV_CON_ID("usart3_clk", &usart3_clk),
+	CLKDEV_CON_ID("usart4_clk", &usart4_clk),
+	CLKDEV_CON_ID("usart5_clk", &usart5_clk),
+	CLKDEV_CON_ID("tc3_clk", &tc3_clk),
+	CLKDEV_CON_ID("tc4_clk", &tc4_clk),
+	CLKDEV_CON_ID("tc5_clk", &tc5_clk),
+};
+
 /*
  * The two programmable clocks.
  * You must configure pin multiplexing to bring these signals out.
  */
 static struct clk pck0 = {
-	.name		= "pck0",
 	.pmc_mask	= AT91_PMC_PCK0,
 	.type		= CLK_TYPE_PROGRAMMABLE,
 	.id		= 0,
 };
 static struct clk pck1 = {
-	.name		= "pck1",
 	.pmc_mask	= AT91_PMC_PCK1,
 	.type		= CLK_TYPE_PROGRAMMABLE,
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
@@ -255,8 +261,14 @@ static void __init at91sam9260_register_clocks(void)
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
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index fcad886..10f4462 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -60,97 +60,78 @@ static struct map_desc at91sam9g10_sram_desc[] __initdata = {
  * The peripheral clocks.
  */
 static struct clk pioA_clk = {
-	.name		= "pioA_clk",
 	.pmc_mask	= 1 << AT91SAM9261_ID_PIOA,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk pioB_clk = {
-	.name		= "pioB_clk",
 	.pmc_mask	= 1 << AT91SAM9261_ID_PIOB,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk pioC_clk = {
-	.name		= "pioC_clk",
 	.pmc_mask	= 1 << AT91SAM9261_ID_PIOC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart0_clk = {
-	.name		= "usart0_clk",
 	.pmc_mask	= 1 << AT91SAM9261_ID_US0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart1_clk = {
-	.name		= "usart1_clk",
 	.pmc_mask	= 1 << AT91SAM9261_ID_US1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart2_clk = {
-	.name		= "usart2_clk",
 	.pmc_mask	= 1 << AT91SAM9261_ID_US2,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk mmc_clk = {
-	.name		= "mci_clk",
 	.pmc_mask	= 1 << AT91SAM9261_ID_MCI,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk udc_clk = {
-	.name		= "udc_clk",
 	.pmc_mask	= 1 << AT91SAM9261_ID_UDP,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk twi_clk = {
-	.name		= "twi_clk",
 	.pmc_mask	= 1 << AT91SAM9261_ID_TWI,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk spi0_clk = {
-	.name		= "spi0_clk",
 	.pmc_mask	= 1 << AT91SAM9261_ID_SPI0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk spi1_clk = {
-	.name		= "spi1_clk",
 	.pmc_mask	= 1 << AT91SAM9261_ID_SPI1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ssc0_clk = {
-	.name		= "ssc0_clk",
 	.pmc_mask	= 1 << AT91SAM9261_ID_SSC0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ssc1_clk = {
-	.name		= "ssc1_clk",
 	.pmc_mask	= 1 << AT91SAM9261_ID_SSC1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ssc2_clk = {
-	.name		= "ssc2_clk",
 	.pmc_mask	= 1 << AT91SAM9261_ID_SSC2,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tc0_clk = {
-	.name		= "tc0_clk",
 	.pmc_mask	= 1 << AT91SAM9261_ID_TC0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tc1_clk = {
-	.name		= "tc1_clk",
 	.pmc_mask	= 1 << AT91SAM9261_ID_TC1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tc2_clk = {
-	.name		= "tc2_clk",
 	.pmc_mask	= 1 << AT91SAM9261_ID_TC2,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ohci_clk = {
-	.name		= "ohci_clk",
 	.pmc_mask	= 1 << AT91SAM9261_ID_UHP,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk lcdc_clk = {
-	.name		= "lcdc_clk",
 	.pmc_mask	= 1 << AT91SAM9261_ID_LCDC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
@@ -178,49 +159,77 @@ static struct clk *periph_clocks[] __initdata = {
 	// irq0 .. irq2
 };
 
+static struct clk_lookup periph_clocks_lookups[] = {
+	CLKDEV_CON_ID("pioA_clk", &pioA_clk),
+	CLKDEV_CON_ID("pioB_clk", &pioB_clk),
+	CLKDEV_CON_ID("pioC_clk", &pioC_clk),
+	CLKDEV_CON_ID("usart0_clk", &usart0_clk),
+	CLKDEV_CON_ID("usart1_clk", &usart1_clk),
+	CLKDEV_CON_ID("usart2_clk", &usart2_clk),
+	CLKDEV_CON_ID("mci_clk", &mmc_clk),
+	CLKDEV_CON_ID("udc_clk", &udc_clk),
+	CLKDEV_CON_ID("twi_clk", &twi_clk),
+	CLKDEV_CON_ID("spi0_clk", &spi0_clk),
+	CLKDEV_CON_ID("spi1_clk", &spi1_clk),
+	CLKDEV_CON_ID("ssc0_clk", &ssc0_clk),
+	CLKDEV_CON_ID("ssc1_clk", &ssc1_clk),
+	CLKDEV_CON_ID("ssc2_clk", &ssc2_clk),
+	CLKDEV_CON_ID("tc0_clk", &tc0_clk),
+	CLKDEV_CON_ID("tc1_clk", &tc1_clk),
+	CLKDEV_CON_ID("tc2_clk", &tc2_clk),
+	CLKDEV_CON_ID("ohci_clk", &ohci_clk),
+	CLKDEV_CON_ID("lcdc_clk", &lcdc_clk),
+};
+
 /*
  * The four programmable clocks.
  * You must configure pin multiplexing to bring these signals out.
  */
 static struct clk pck0 = {
-	.name		= "pck0",
 	.pmc_mask	= AT91_PMC_PCK0,
 	.type		= CLK_TYPE_PROGRAMMABLE,
 	.id		= 0,
 };
 static struct clk pck1 = {
-	.name		= "pck1",
 	.pmc_mask	= AT91_PMC_PCK1,
 	.type		= CLK_TYPE_PROGRAMMABLE,
 	.id		= 1,
 };
 static struct clk pck2 = {
-	.name		= "pck2",
 	.pmc_mask	= AT91_PMC_PCK2,
 	.type		= CLK_TYPE_PROGRAMMABLE,
 	.id		= 2,
 };
 static struct clk pck3 = {
-	.name		= "pck3",
 	.pmc_mask	= AT91_PMC_PCK3,
 	.type		= CLK_TYPE_PROGRAMMABLE,
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
-	.name		= "hck0",
 	.pmc_mask	= AT91_PMC_HCK0,
 	.type		= CLK_TYPE_SYSTEM,
 	.id		= 0,
 };
 static struct clk hck1 = {
-	.name		= "hck1",
 	.pmc_mask	= AT91_PMC_HCK1,
 	.type		= CLK_TYPE_SYSTEM,
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
@@ -228,13 +237,22 @@ static void __init at91sam9261_register_clocks(void)
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
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 249f900..20deb56 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -51,122 +51,98 @@ static struct map_desc at91sam9263_io_desc[] __initdata = {
  * The peripheral clocks.
  */
 static struct clk pioA_clk = {
-	.name		= "pioA_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_PIOA,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk pioB_clk = {
-	.name		= "pioB_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_PIOB,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk pioCDE_clk = {
-	.name		= "pioCDE_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_PIOCDE,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart0_clk = {
-	.name		= "usart0_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_US0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart1_clk = {
-	.name		= "usart1_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_US1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart2_clk = {
-	.name		= "usart2_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_US2,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk mmc0_clk = {
-	.name		= "mci0_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_MCI0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk mmc1_clk = {
-	.name		= "mci1_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_MCI1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk can_clk = {
-	.name		= "can_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_CAN,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk twi_clk = {
-	.name		= "twi_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_TWI,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk spi0_clk = {
-	.name		= "spi0_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_SPI0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk spi1_clk = {
-	.name		= "spi1_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_SPI1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ssc0_clk = {
-	.name		= "ssc0_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_SSC0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ssc1_clk = {
-	.name		= "ssc1_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_SSC1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ac97_clk = {
-	.name		= "ac97_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_AC97C,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tcb_clk = {
-	.name		= "tcb_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_TCB,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk pwm_clk = {
-	.name		= "pwm_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_PWMC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk macb_clk = {
-	.name		= "macb_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_EMAC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk dma_clk = {
-	.name		= "dma_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_DMA,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk twodge_clk = {
-	.name		= "2dge_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_2DGE,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk udc_clk = {
-	.name		= "udc_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_UDP,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk isi_clk = {
-	.name		= "isi_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_ISI,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk lcdc_clk = {
-	.name		= "lcdc_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_LCDC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ohci_clk = {
-	.name		= "ohci_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_UHP,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
@@ -199,35 +175,65 @@ static struct clk *periph_clocks[] __initdata = {
 	// irq0 .. irq1
 };
 
+static struct clk_lookup periph_clocks_lookups[] = {
+	CLKDEV_CON_ID("pioA_clk", &pioA_clk),
+	CLKDEV_CON_ID("pioB_clk", &pioB_clk),
+	CLKDEV_CON_ID("pioCDE_clk", &pioCDE_clk),
+	CLKDEV_CON_ID("usart0_clk", &usart0_clk),
+	CLKDEV_CON_ID("usart1_clk", &usart1_clk),
+	CLKDEV_CON_ID("usart2_clk", &usart2_clk),
+	CLKDEV_CON_ID("mci0_clk", &mmc0_clk),
+	CLKDEV_CON_ID("mci1_clk", &mmc1_clk),
+	CLKDEV_CON_ID("can_clk", &can_clk),
+	CLKDEV_CON_ID("twi_clk", &twi_clk),
+	CLKDEV_CON_ID("spi0_clk", &spi0_clk),
+	CLKDEV_CON_ID("spi1_clk", &spi1_clk),
+	CLKDEV_CON_ID("ssc0_clk", &ssc0_clk),
+	CLKDEV_CON_ID("ssc1_clk", &ssc1_clk),
+	CLKDEV_CON_ID("ac97_clk", &ac97_clk),
+	CLKDEV_CON_ID("tcb_clk", &tcb_clk),
+	CLKDEV_CON_ID("pwm_clk", &pwm_clk),
+	CLKDEV_CON_ID("macb_clk", &macb_clk),
+	CLKDEV_CON_ID("dma_clk", &dma_clk),
+	CLKDEV_CON_ID("2dge_clk", &twodge_clk),
+	CLKDEV_CON_ID("udc_clkk", &udc_clk),
+	CLKDEV_CON_ID("isi_clk", &isi_clk),
+	CLKDEV_CON_ID("lcdc_clk", &lcdc_clk),
+	CLKDEV_CON_ID("ohci_clk", &ohci_clk),
+};
+
 /*
  * The four programmable clocks.
  * You must configure pin multiplexing to bring these signals out.
  */
 static struct clk pck0 = {
-	.name		= "pck0",
 	.pmc_mask	= AT91_PMC_PCK0,
 	.type		= CLK_TYPE_PROGRAMMABLE,
 	.id		= 0,
 };
 static struct clk pck1 = {
-	.name		= "pck1",
 	.pmc_mask	= AT91_PMC_PCK1,
 	.type		= CLK_TYPE_PROGRAMMABLE,
 	.id		= 1,
 };
 static struct clk pck2 = {
-	.name		= "pck2",
 	.pmc_mask	= AT91_PMC_PCK2,
 	.type		= CLK_TYPE_PROGRAMMABLE,
 	.id		= 2,
 };
 static struct clk pck3 = {
-	.name		= "pck3",
 	.pmc_mask	= AT91_PMC_PCK3,
 	.type		= CLK_TYPE_PROGRAMMABLE,
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
@@ -235,10 +241,16 @@ static void __init at91sam9263_register_clocks(void)
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
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index c67b47f..1f6a83d 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -47,159 +47,116 @@ static struct map_desc at91sam9g45_io_desc[] __initdata = {
  * The peripheral clocks.
  */
 static struct clk pioA_clk = {
-	.name		= "pioA_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_PIOA,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk pioB_clk = {
-	.name		= "pioB_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_PIOB,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk pioC_clk = {
-	.name		= "pioC_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_PIOC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk pioDE_clk = {
-	.name		= "pioDE_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_PIODE,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart0_clk = {
-	.name		= "usart0_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_US0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart1_clk = {
-	.name		= "usart1_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_US1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart2_clk = {
-	.name		= "usart2_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_US2,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart3_clk = {
-	.name		= "usart3_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_US3,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk mmc0_clk = {
-	.name		= "mci0_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_MCI0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk twi0_clk = {
-	.name		= "twi0_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_TWI0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk twi1_clk = {
-	.name		= "twi1_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_TWI1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk spi0_clk = {
-	.name		= "spi0_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_SPI0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk spi1_clk = {
-	.name		= "spi1_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_SPI1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ssc0_clk = {
-	.name		= "ssc0_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_SSC0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ssc1_clk = {
-	.name		= "ssc1_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_SSC1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tcb0_clk = {
-	.name		= "tcb0_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_TCB,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk pwm_clk = {
-	.name		= "pwm_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_PWMC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tsc_clk = {
-	.name		= "tsc_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_TSC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk dma_clk = {
-	.name		= "dma_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_DMA,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk uhphs_clk = {
-	.name		= "uhphs_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_UHPHS,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk lcdc_clk = {
-	.name		= "lcdc_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_LCDC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ac97_clk = {
-	.name		= "ac97_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_AC97C,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk macb_clk = {
-	.name		= "macb_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_EMAC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk isi_clk = {
-	.name		= "isi_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_ISI,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk udphs_clk = {
-	.name		= "udphs_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_UDPHS,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk mmc1_clk = {
-	.name		= "mci1_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_MCI1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 
 /* Video decoder clock - Only for sam9m10/sam9m11 */
 static struct clk vdec_clk = {
-	.name		= "vdec_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_VDEC,
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
@@ -228,27 +185,65 @@ static struct clk *periph_clocks[] __initdata = {
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
+	CLKDEV_CON_ID("usart0_clk", &usart0_clk),
+	CLKDEV_CON_ID("usart1_clk", &usart1_clk),
+	CLKDEV_CON_ID("usart2_clk", &usart2_clk),
+	CLKDEV_CON_ID("usart3_clk", &usart3_clk),
+	CLKDEV_CON_ID("mci0_clk", &mmc0_clk),
+	CLKDEV_CON_ID("twi0_clk", &twi0_clk),
+	CLKDEV_CON_ID("twi1_clk", &twi1_clk),
+	CLKDEV_CON_ID("spi0_clk", &spi0_clk),
+	CLKDEV_CON_ID("spi1_clk", &spi1_clk),
+	CLKDEV_CON_ID("ssc0_clk", &ssc0_clk),
+	CLKDEV_CON_ID("ssc1_clk", &ssc1_clk),
+	CLKDEV_CON_ID("tcb0_clk", &tcb0_clk),
+	CLKDEV_CON_ID("pwm_clk", &pwm_clk),
+	CLKDEV_CON_ID("tsc_clk", &tsc_clk),
+	CLKDEV_CON_ID("dma_clk", &dma_clk),
+	CLKDEV_CON_ID("uhphs_clk", &uhphs_clk),
+	CLKDEV_CON_ID("lcdc_clk", &lcdc_clk),
+	CLKDEV_CON_ID("ac97_clk", &ac97_clk),
+	CLKDEV_CON_ID("macb_clk", &macb_clk),
+	CLKDEV_CON_ID("isi_clk", &isi_clk),
+	CLKDEV_CON_ID("udphs_clk", &udphs_clk),
+	CLKDEV_CON_ID("mci1_clk", &mmc1_clk),
+	/* One additional fake clock for ohci */
+	CLKDEV_CON_ID("ohci_clk", &uhphs_clk),
+	/* One additional fake clock for second TC block */
+	CLKDEV_CON_ID("tcb1_clk", &tcb0_clk),
+};
+
+/* Video decoder clock - Only for sam9m10/sam9m11 */
+static struct clk_lookup vdec_clk_lookup =
+	CLKDEV_CON_ID("vdec_clk", &vdec_clk);
+
 /*
  * The two programmable clocks.
  * You must configure pin multiplexing to bring these signals out.
  */
 static struct clk pck0 = {
-	.name		= "pck0",
 	.pmc_mask	= AT91_PMC_PCK0,
 	.type		= CLK_TYPE_PROGRAMMABLE,
 	.id		= 0,
 };
 static struct clk pck1 = {
-	.name		= "pck1",
 	.pmc_mask	= AT91_PMC_PCK1,
 	.type		= CLK_TYPE_PROGRAMMABLE,
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
@@ -256,11 +251,19 @@ static void __init at91sam9g45_register_clocks(void)
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
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 6a9d24e..da9fea5 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -48,117 +48,94 @@ static struct map_desc at91sam9rl_sram_desc[] __initdata = {
  * The peripheral clocks.
  */
 static struct clk pioA_clk = {
-	.name		= "pioA_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_PIOA,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk pioB_clk = {
-	.name		= "pioB_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_PIOB,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk pioC_clk = {
-	.name		= "pioC_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_PIOC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk pioD_clk = {
-	.name		= "pioD_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_PIOD,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart0_clk = {
-	.name		= "usart0_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_US0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart1_clk = {
-	.name		= "usart1_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_US1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart2_clk = {
-	.name		= "usart2_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_US2,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk usart3_clk = {
-	.name		= "usart3_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_US3,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk mmc_clk = {
-	.name		= "mci_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_MCI,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk twi0_clk = {
-	.name		= "twi0_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_TWI0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk twi1_clk = {
-	.name		= "twi1_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_TWI1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk spi_clk = {
-	.name		= "spi_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_SPI,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ssc0_clk = {
-	.name		= "ssc0_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_SSC0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ssc1_clk = {
-	.name		= "ssc1_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_SSC1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tc0_clk = {
-	.name		= "tc0_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_TC0,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tc1_clk = {
-	.name		= "tc1_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_TC1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tc2_clk = {
-	.name		= "tc2_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_TC2,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk pwm_clk = {
-	.name		= "pwm_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_PWMC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk tsc_clk = {
-	.name		= "tsc_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_TSC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk dma_clk = {
-	.name		= "dma_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_DMA,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk udphs_clk = {
-	.name		= "udphs_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_UDPHS,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk lcdc_clk = {
-	.name		= "lcdc_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_LCDC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk ac97_clk = {
-	.name		= "ac97_clk",
 	.pmc_mask	= 1 << AT91SAM9RL_ID_AC97C,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
@@ -190,23 +167,52 @@ static struct clk *periph_clocks[] __initdata = {
 	// irq0
 };
 
+static struct clk_lookup periph_clocks_lookups[] = {
+	CLKDEV_CON_ID("pioA_clk", &pioA_clk),
+	CLKDEV_CON_ID("pioB_clk", &pioB_clk),
+	CLKDEV_CON_ID("pioC_clk", &pioC_clk),
+	CLKDEV_CON_ID("pioD_clk", &pioD_clk),
+	CLKDEV_CON_ID("usart0_clk", &usart0_clk),
+	CLKDEV_CON_ID("usart1_clk", &usart1_clk),
+	CLKDEV_CON_ID("usart2_clk", &usart2_clk),
+	CLKDEV_CON_ID("usart3_clk", &usart3_clk),
+	CLKDEV_CON_ID("mci_clk", &mmc_clk),
+	CLKDEV_CON_ID("twi0_clk", &twi0_clk),
+	CLKDEV_CON_ID("twi1_clk", &twi1_clk),
+	CLKDEV_CON_ID("spi_clk", &spi_clk),
+	CLKDEV_CON_ID("ssc0_clk", &ssc0_clk),
+	CLKDEV_CON_ID("ssc1_clk", &ssc1_clk),
+	CLKDEV_CON_ID("tc0_clk", &tc0_clk),
+	CLKDEV_CON_ID("tc1_clk", &tc1_clk),
+	CLKDEV_CON_ID("tc2_clk", &tc2_clk),
+	CLKDEV_CON_ID("pwm_clk", &pwm_clk),
+	CLKDEV_CON_ID("tsc_clk", &tsc_clk),
+	CLKDEV_CON_ID("dma_clk", &dma_clk),
+	CLKDEV_CON_ID("udphs_clk", &udphs_clk),
+	CLKDEV_CON_ID("lcdc_clk", &lcdc_clk),
+	CLKDEV_CON_ID("ac97_clk", &ac97_clk),
+};
+
 /*
  * The two programmable clocks.
  * You must configure pin multiplexing to bring these signals out.
  */
 static struct clk pck0 = {
-	.name		= "pck0",
 	.pmc_mask	= AT91_PMC_PCK0,
 	.type		= CLK_TYPE_PROGRAMMABLE,
 	.id		= 0,
 };
 static struct clk pck1 = {
-	.name		= "pck1",
 	.pmc_mask	= AT91_PMC_PCK1,
 	.type		= CLK_TYPE_PROGRAMMABLE,
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
@@ -214,8 +220,14 @@ static void __init at91sam9rl_register_clocks(void)
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
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index 9113da6..9beabae 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -80,20 +80,17 @@ static u32 at91_pllb_usb_init;
  * both PLLs are turned off to run in "slow clock mode" (system suspend).
  */
 static struct clk clk32k = {
-	.name		= "clk32k",
 	.rate_hz	= AT91_SLOW_CLOCK,
 	.users		= 1,		/* always on */
 	.id		= 0,
 	.type		= CLK_TYPE_PRIMARY,
 };
 static struct clk main_clk = {
-	.name		= "main",
 	.pmc_mask	= AT91_PMC_MOSCS,	/* in PMC_SR */
 	.id		= 1,
 	.type		= CLK_TYPE_PRIMARY,
 };
 static struct clk plla = {
-	.name		= "plla",
 	.parent		= &main_clk,
 	.pmc_mask	= AT91_PMC_LOCKA,	/* in PMC_SR */
 	.id		= 2,
@@ -119,7 +116,6 @@ static void pllb_mode(struct clk *clk, int is_on)
 }
 
 static struct clk pllb = {
-	.name		= "pllb",
 	.parent		= &main_clk,
 	.pmc_mask	= AT91_PMC_LOCKB,	/* in PMC_SR */
 	.mode		= pllb_mode,
@@ -159,19 +155,16 @@ static void pmc_uckr_mode(struct clk *clk, int is_on)
 
 /* USB function clocks (PLLB must be 48 MHz) */
 static struct clk udpck = {
-	.name		= "udpck",
 	.parent		= &pllb,
 	.mode		= pmc_sys_mode,
 };
 static struct clk utmi_clk = {
-	.name		= "utmi_clk",
 	.parent		= &main_clk,
 	.pmc_mask	= AT91_PMC_UPLLEN,	/* in CKGR_UCKR */
 	.mode		= pmc_uckr_mode,
 	.type		= CLK_TYPE_PLL,
 };
 static struct clk uhpck = {
-	.name		= "uhpck",
 	/*.parent		= ... we choose parent@runtime */
 	.mode		= pmc_sys_mode,
 };
@@ -183,7 +176,6 @@ static struct clk uhpck = {
  * (e.g baud rate generation).  It's sourced from one of the primary clocks.
  */
 static struct clk mck = {
-	.name		= "mck",
 	.pmc_mask	= AT91_PMC_MCKRDY,	/* in PMC_SR */
 };
 
@@ -215,43 +207,6 @@ static struct clk __init *at91_css_to_clk(unsigned long css)
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
@@ -662,6 +617,17 @@ static void __init at91_upll_usbfs_clock_init(unsigned long main_clock)
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
@@ -771,6 +737,8 @@ int __init at91_clock_init(unsigned long main_clock)
 	/* MCK and CPU clock are "always on" */
 	clk_enable(&mck);
 
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
 	printk("Clocks: CPU %u MHz, master %u MHz, main %u.%03u MHz\n",
 		freq / 1000000, (unsigned) mck.rate_hz / 1000000,
 		(unsigned) main_clock / 1000000,
@@ -798,7 +766,7 @@ static int __init at91_clock_reset(void)
 		if (clk->mode == pmc_sys_mode)
 			scdr |= clk->pmc_mask;
 
-		pr_debug("Clocks: disable unused %s\n", clk->name);
+		pr_debug("Clocks: disable unused 0x%p\n", clk);
 	}
 
 	at91_sys_write(AT91_PMC_PCDR, pcdr);
diff --git a/arch/arm/mach-at91/clock.h b/arch/arm/mach-at91/clock.h
index 6cf4b78..916d662 100644
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
@@ -15,9 +17,6 @@
 
 struct clk {
 	struct list_head node;
-	const char	*name;		/* unique clock name */
-	const char	*function;	/* function of the clock */
-	struct device	*dev;		/* device associated with function */
 	unsigned long	rate_hz;
 	struct clk	*parent;
 	u32		pmc_mask;
@@ -29,3 +28,5 @@ struct clk {
 
 
 extern int __init clk_register(struct clk *clk);
+
+#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 0c66deb..c617a18 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -8,6 +8,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/clkdev.h>
+
  /* Processors */
 extern void __init at91rm9200_initialize(unsigned long main_clock, unsigned short banks);
 extern void __init at91sam9260_initialize(unsigned long main_clock);
@@ -40,7 +42,15 @@ extern struct sys_timer at91x40_timer;
  /* Clocks */
 extern int __init at91_clock_init(unsigned long main_clock);
 struct device;
-extern void __init at91_clock_associate(const char *id, struct device *dev, const char *func);
+
+/*
+ * Associate a particular clock with a function (eg, "uart") and device.
+ * The drivers can then request the same 'function' with several different
+ * devices and not care about which clock name to use.
+ */static int inline at91_clock_associate(char *dev_id, struct device *dev, const char *con_id)
+{
+	return clk_add_alias(con_id, NULL, dev_id, dev);
+}
 
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
1.7.2.3
