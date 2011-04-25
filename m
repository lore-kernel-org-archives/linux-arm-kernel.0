From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 25 Apr 2011 20:31:17 +0200
Subject: [PATCH 07/14] at91: switch gpio to early platfrom device
In-Reply-To: <20110425180847.GA12904@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
Message-ID: <1303756284-26529-7-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
need patch
clkdev: add support to lookup for early platform device

Best Regards,
J.
 arch/arm/mach-at91/at572d940hf.c |   30 ++++++------
 arch/arm/mach-at91/at91cap9.c    |   34 +++++++-------
 arch/arm/mach-at91/at91rm9200.c  |   43 +++++++++--------
 arch/arm/mach-at91/at91sam9260.c |   30 ++++++------
 arch/arm/mach-at91/at91sam9261.c |   30 ++++++------
 arch/arm/mach-at91/at91sam9263.c |   42 ++++++++---------
 arch/arm/mach-at91/at91sam9g45.c |   43 ++++++++---------
 arch/arm/mach-at91/at91sam9rl.c  |   37 +++++++--------
 arch/arm/mach-at91/clock.h       |    6 ++
 arch/arm/mach-at91/devices.c     |   15 ++++++
 arch/arm/mach-at91/devices.h     |   55 +++++++++++++++++++++
 arch/arm/mach-at91/generic.h     |    6 --
 arch/arm/mach-at91/gpio.c        |   78 +++++++++++++++++++-----------
 arch/arm/mach-at91/soc.c         |   97 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/soc.h         |    4 ++
 15 files changed, 365 insertions(+), 185 deletions(-)
 create mode 100644 arch/arm/mach-at91/devices.c
 create mode 100644 arch/arm/mach-at91/devices.h

diff --git a/arch/arm/mach-at91/at572d940hf.c b/arch/arm/mach-at91/at572d940hf.c
index b9c48d5..b788861 100644
--- a/arch/arm/mach-at91/at572d940hf.c
+++ b/arch/arm/mach-at91/at572d940hf.c
@@ -202,9 +202,9 @@ static struct clk *periph_clocks[] __initdata = {
 };
 
 static struct clk_lookup periph_clocks_lookups[] = {
-	CLKDEV_CON_ID("pioA_clk", &pioA_clk),
-	CLKDEV_CON_ID("pioB_clk", &pioB_clk),
-	CLKDEV_CON_ID("pioC_clk", &pioC_clk),
+	CLKDEV_DEV_ID("at91_gpio.0", &pioA_clk),
+	CLKDEV_DEV_ID("at91_gpio.1", &pioB_clk),
+	CLKDEV_DEV_ID("at91_gpio.2", &pioC_clk),
 	CLKDEV_CON_ID("macb_clk", &macb_clk),
 	CLKDEV_CON_ID("mci_clk", &mmc_clk),
 	CLKDEV_CON_ID("udc_clk", &udc_clk),
@@ -336,19 +336,16 @@ struct clk* __init at572d940hf_get_uart_clock(int id)
  *  GPIO
  * -------------------------------------------------------------------- */
 
-static struct at91_gpio_bank at572d940hf_gpio[] = {
+static struct at91_dev_resource at572d940hf_pios[] __initdata = {
 	{
-		.id		= AT572D940HF_ID_PIOA,
-		.offset		= AT91_PIOA,
-		.clock		= &pioA_clk,
+		.mmio_base	= AT91_PIOA,
+		.irq		= AT572D940HF_ID_PIOA,
 	}, {
-		.id		= AT572D940HF_ID_PIOB,
-		.offset		= AT91_PIOB,
-		.clock		= &pioB_clk,
+		.mmio_base	= AT91_PIOB,
+		.irq		= AT572D940HF_ID_PIOB,
 	}, {
-		.id		= AT572D940HF_ID_PIOC,
-		.offset		= AT91_PIOC,
-		.clock		= &pioC_clk,
+		.mmio_base	= AT91_PIOC,
+		.irq		= AT572D940HF_ID_PIOC,
 	}
 };
 
@@ -376,9 +373,6 @@ static void __init at572d940hf_initialize(unsigned long main_clock)
 
 	/* Register the processor-specific clocks */
 	at572d940hf_register_clocks();
-
-	/* Register GPIO subsystem */
-	at91_gpio_init(at572d940hf_gpio, 3);
 }
 
 /* --------------------------------------------------------------------
@@ -427,4 +421,8 @@ struct at91_soc __initdata at572d940hf_soc = {
 	.name = "at572d940hf",
 	.default_irq_priority = at572d940hf_default_irq_priority,
 	.init = at572d940hf_initialize,
+	.gpio = {
+		.resource = at572d940hf_pios,
+		.num_resources = ARRAY_SIZE(at572d940hf_pios),
+	},
 };
diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index 1ba614a1..f60ec74 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -219,7 +219,10 @@ static struct clk *periph_clocks[] __initdata = {
 };
 
 static struct clk_lookup periph_clocks_lookups[] = {
-	CLKDEV_CON_ID("pioABCD_clk", &pioABCD_clk),
+	CLKDEV_DEV_ID("at91_gpio.0", &pioABCD_clk),
+	CLKDEV_DEV_ID("at91_gpio.1", &pioABCD_clk),
+	CLKDEV_DEV_ID("at91_gpio.2", &pioABCD_clk),
+	CLKDEV_DEV_ID("at91_gpio.3", &pioABCD_clk),
 	CLKDEV_CON_ID("mpb0_clk", &mpb0_clk),
 	CLKDEV_CON_ID("mpb1_clk", &mpb1_clk),
 	CLKDEV_CON_ID("mpb2_clk", &mpb2_clk),
@@ -322,23 +325,19 @@ struct clk* __init at91cap9_get_uart_clock(int id)
  *  GPIO
  * -------------------------------------------------------------------- */
 
-static struct at91_gpio_bank at91cap9_gpio[] = {
+static struct at91_dev_resource at91cap9_pios[] __initdata = {
 	{
-		.id		= AT91CAP9_ID_PIOABCD,
-		.offset		= AT91_PIOA,
-		.clock		= &pioABCD_clk,
+		.mmio_base	= AT91_PIOA,
+		.irq		= AT91CAP9_ID_PIOABCD,
 	}, {
-		.id		= AT91CAP9_ID_PIOABCD,
-		.offset		= AT91_PIOB,
-		.clock		= &pioABCD_clk,
+		.mmio_base	= AT91_PIOB,
+		.irq		= AT91CAP9_ID_PIOABCD,
 	}, {
-		.id		= AT91CAP9_ID_PIOABCD,
-		.offset		= AT91_PIOC,
-		.clock		= &pioABCD_clk,
+		.mmio_base	= AT91_PIOC,
+		.irq		= AT91CAP9_ID_PIOABCD,
 	}, {
-		.id		= AT91CAP9_ID_PIOABCD,
-		.offset		= AT91_PIOD,
-		.clock		= &pioABCD_clk,
+		.mmio_base	= AT91_PIOD,
+		.irq		= AT91CAP9_ID_PIOABCD,
 	}
 };
 
@@ -372,9 +371,6 @@ static void __init at91cap9_initialize(unsigned long main_clock)
 	/* Register the processor-specific clocks */
 	at91cap9_register_clocks();
 
-	/* Register GPIO subsystem */
-	at91_gpio_init(at91cap9_gpio, 4);
-
 	/* Remember the silicon revision */
 	if (cpu_is_at91cap9_revB())
 		system_rev = 0xB;
@@ -428,4 +424,8 @@ struct at91_soc __initdata at91cap9_soc = {
 	.name = "at91cap9",
 	.default_irq_priority = at91cap9_default_irq_priority,
 	.init = at91cap9_initialize,
+	.gpio = {
+		.resource = at91cap9_pios,
+		.num_resources = ARRAY_SIZE(at91cap9_pios),
+	},
 };
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 29a2a8a..e80d544 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -189,16 +189,16 @@ static struct clk *periph_clocks[] __initdata = {
 };
 
 static struct clk_lookup periph_clocks_lookups[] = {
+	CLKDEV_DEV_ID("at91_gpio.0", &pioA_clk),
+	CLKDEV_DEV_ID("at91_gpio.1", &pioB_clk),
+	CLKDEV_DEV_ID("at91_gpio.2", &pioC_clk),
+	CLKDEV_DEV_ID("at91_gpio.3", &pioD_clk),
 	CLKDEV_CON_ID("udc_clk", &udc_clk),
 	CLKDEV_CON_ID("ohci_clk", &ohci_clk),
 	CLKDEV_CON_ID("ether_clk", &ether_clk),
 	CLKDEV_CON_ID("mci_clk", &mmc_clk),
 	CLKDEV_CON_ID("twi_clk", &twi_clk),
 	CLKDEV_CON_ID("spi_clk", &spi_clk),
-	CLKDEV_CON_ID("pioA_clk", &pioA_clk),
-	CLKDEV_CON_ID("pioB_clk", &pioB_clk),
-	CLKDEV_CON_ID("pioC_clk", &pioC_clk),
-	CLKDEV_CON_ID("pioD_clk", &pioD_clk),
 	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tc0_clk),
 	CLKDEV_CON_DEV_ID("t1_clk", "atmel_tcb.0", &tc1_clk),
 	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.0", &tc2_clk),
@@ -284,23 +284,19 @@ struct clk* __init at91rm9200_get_uart_clock(int id)
  *  GPIO
  * -------------------------------------------------------------------- */
 
-static struct at91_gpio_bank at91rm9200_gpio[] = {
+static struct at91_dev_resource at91rm9200_pios[] __initdata = {
 	{
-		.id		= AT91RM9200_ID_PIOA,
-		.offset		= AT91_PIOA,
-		.clock		= &pioA_clk,
+		.mmio_base	= AT91_PIOA,
+		.irq		= AT91RM9200_ID_PIOA,
 	}, {
-		.id		= AT91RM9200_ID_PIOB,
-		.offset		= AT91_PIOB,
-		.clock		= &pioB_clk,
+		.mmio_base	= AT91_PIOB,
+		.irq		= AT91RM9200_ID_PIOB,
 	}, {
-		.id		= AT91RM9200_ID_PIOC,
-		.offset		= AT91_PIOC,
-		.clock		= &pioC_clk,
+		.mmio_base	= AT91_PIOC,
+		.irq		= AT91RM9200_ID_PIOC,
 	}, {
-		.id		= AT91RM9200_ID_PIOD,
-		.offset		= AT91_PIOD,
-		.clock		= &pioD_clk,
+		.mmio_base	= AT91_PIOD,
+		.irq		= AT91RM9200_ID_PIOD,
 	}
 };
 
@@ -318,6 +314,11 @@ static void at91rm9200_reset(void)
  * -------------------------------------------------------------------- */
 static void __init at91rm9200_initialize(unsigned long main_clock)
 {
+	if (cpu_is_at91rm9200_bga())
+		at91rm9200_soc.gpio.num_resources = AT91RM9200_BGA;
+	else
+		at91rm9200_soc.gpio.num_resources = AT91RM9200_PQFP;
+
 	/* Map peripherals */
 	iotable_init(at91rm9200_io_desc, ARRAY_SIZE(at91rm9200_io_desc));
 
@@ -332,10 +333,6 @@ static void __init at91rm9200_initialize(unsigned long main_clock)
 
 	/* Register the processor-specific clocks */
 	at91rm9200_register_clocks();
-
-	/* Initialize GPIO subsystem */
-	at91_gpio_init(at91rm9200_gpio,
-		cpu_is_at91rm9200_bga() ? AT91RM9200_BGA : AT91RM9200_PQFP);
 }
 
 
@@ -385,4 +382,8 @@ struct at91_soc __initdata at91rm9200_soc = {
 	.name = "at91rm9200",
 	.default_irq_priority = at91rm9200_default_irq_priority,
 	.init = at91rm9200_initialize,
+	.gpio = {
+		.resource = at91rm9200_pios,
+		.num_resources = ARRAY_SIZE(at91rm9200_pios),
+	},
 };
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 8c7de1e..4859231 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -215,9 +215,9 @@ static struct clk *periph_clocks[] __initdata = {
 };
 
 static struct clk_lookup periph_clocks_lookups[] = {
-	CLKDEV_CON_ID("pioA_clk", &pioA_clk),
-	CLKDEV_CON_ID("pioB_clk", &pioB_clk),
-	CLKDEV_CON_ID("pioC_clk", &pioC_clk),
+	CLKDEV_DEV_ID("at91_gpio.0", &pioA_clk),
+	CLKDEV_DEV_ID("at91_gpio.1", &pioB_clk),
+	CLKDEV_DEV_ID("at91_gpio.2", &pioC_clk),
 	CLKDEV_CON_ID("adc_clk", &adc_clk),
 	CLKDEV_CON_ID("mci_clk", &mmc_clk),
 	CLKDEV_CON_ID("udc_clk", &udc_clk),
@@ -300,19 +300,16 @@ struct clk* __init at91sam9260_get_uart_clock(int id)
  *  GPIO
  * -------------------------------------------------------------------- */
 
-static struct at91_gpio_bank at91sam9260_gpio[] = {
+static struct at91_dev_resource at91sam9260_pios[] __initdata = {
 	{
-		.id		= AT91SAM9260_ID_PIOA,
-		.offset		= AT91_PIOA,
-		.clock		= &pioA_clk,
+		.mmio_base	= AT91_PIOA,
+		.irq		= AT91SAM9260_ID_PIOA,
 	}, {
-		.id		= AT91SAM9260_ID_PIOB,
-		.offset		= AT91_PIOB,
-		.clock		= &pioB_clk,
+		.mmio_base	= AT91_PIOB,
+		.irq		= AT91SAM9260_ID_PIOB,
 	}, {
-		.id		= AT91SAM9260_ID_PIOC,
-		.offset		= AT91_PIOC,
-		.clock		= &pioC_clk,
+		.mmio_base	= AT91_PIOC,
+		.irq		= AT91SAM9260_ID_PIOC,
 	}
 };
 
@@ -368,9 +365,6 @@ static void __init at91sam9260_initialize(unsigned long main_clock)
 
 	/* Register the processor-specific clocks */
 	at91sam9260_register_clocks();
-
-	/* Register GPIO subsystem */
-	at91_gpio_init(at91sam9260_gpio, 3);
 }
 
 /* --------------------------------------------------------------------
@@ -419,4 +413,8 @@ struct at91_soc __initdata at91sam9260_soc = {
 	.name = "at91sam9260",
 	.default_irq_priority = at91sam9260_default_irq_priority,
 	.init = at91sam9260_initialize,
+	.gpio = {
+		.resource = at91sam9260_pios,
+		.num_resources = ARRAY_SIZE(at91sam9260_pios),
+	},
 };
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index bf28740..5a3f68b 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -171,9 +171,9 @@ static struct clk *periph_clocks[] __initdata = {
 };
 
 static struct clk_lookup periph_clocks_lookups[] = {
-	CLKDEV_CON_ID("pioA_clk", &pioA_clk),
-	CLKDEV_CON_ID("pioB_clk", &pioB_clk),
-	CLKDEV_CON_ID("pioC_clk", &pioC_clk),
+	CLKDEV_DEV_ID("at91_gpio.0", &pioA_clk),
+	CLKDEV_DEV_ID("at91_gpio.1", &pioB_clk),
+	CLKDEV_DEV_ID("at91_gpio.2", &pioC_clk),
 	CLKDEV_CON_ID("mci_clk", &mmc_clk),
 	CLKDEV_CON_ID("udc_clk", &udc_clk),
 	CLKDEV_CON_ID("twi_clk", &twi_clk),
@@ -288,19 +288,16 @@ struct clk* __init at91sam9261_get_uart_clock(int id)
  *  GPIO
  * -------------------------------------------------------------------- */
 
-static struct at91_gpio_bank at91sam9261_gpio[] = {
+static struct at91_dev_resource at91sam9261_pios[] __initdata = {
 	{
-		.id		= AT91SAM9261_ID_PIOA,
-		.offset		= AT91_PIOA,
-		.clock		= &pioA_clk,
+		.mmio_base	= AT91_PIOA,
+		.irq		= AT91SAM9261_ID_PIOA,
 	}, {
-		.id		= AT91SAM9261_ID_PIOB,
-		.offset		= AT91_PIOB,
-		.clock		= &pioB_clk,
+		.mmio_base	= AT91_PIOB,
+		.irq		= AT91SAM9261_ID_PIOB,
 	}, {
-		.id		= AT91SAM9261_ID_PIOC,
-		.offset		= AT91_PIOC,
-		.clock		= &pioC_clk,
+		.mmio_base	= AT91_PIOC,
+		.irq		= AT91SAM9261_ID_PIOC,
 	}
 };
 
@@ -334,9 +331,6 @@ static void __init at91sam9261_initialize(unsigned long main_clock)
 
 	/* Register the processor-specific clocks */
 	at91sam9261_register_clocks();
-
-	/* Register GPIO subsystem */
-	at91_gpio_init(at91sam9261_gpio, 3);
 }
 
 /* --------------------------------------------------------------------
@@ -385,4 +379,8 @@ struct at91_soc __initdata at91sam9261_soc = {
 	.name = "at91sam9261",
 	.default_irq_priority = at91sam9261_default_irq_priority,
 	.init = at91sam9261_initialize,
+	.gpio = {
+		.resource = at91sam9261_pios,
+		.num_resources = ARRAY_SIZE(at91sam9261_pios),
+	},
 };
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 763170b..9a0b3b4 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -196,9 +196,11 @@ static struct clk *periph_clocks[] __initdata = {
 };
 
 static struct clk_lookup periph_clocks_lookups[] = {
-	CLKDEV_CON_ID("pioA_clk", &pioA_clk),
-	CLKDEV_CON_ID("pioB_clk", &pioB_clk),
-	CLKDEV_CON_ID("pioCDE_clk", &pioCDE_clk),
+	CLKDEV_DEV_ID("at91_gpio.0", &pioA_clk),
+	CLKDEV_DEV_ID("at91_gpio.1", &pioB_clk),
+	CLKDEV_DEV_ID("at91_gpio.2", &pioCDE_clk),
+	CLKDEV_DEV_ID("at91_gpio.3", &pioCDE_clk),
+	CLKDEV_DEV_ID("at91_gpio.4", &pioCDE_clk),
 	CLKDEV_CON_ID("can_clk", &can_clk),
 	CLKDEV_CON_ID("twi_clk", &twi_clk),
 	CLKDEV_CON_ID("ac97_clk", &ac97_clk),
@@ -295,27 +297,22 @@ struct clk* __init at91sam9263_get_uart_clock(int id)
  *  GPIO
  * -------------------------------------------------------------------- */
 
-static struct at91_gpio_bank at91sam9263_gpio[] = {
+static struct at91_dev_resource at91sam9263_pios[] __initdata = {
 	{
-		.id		= AT91SAM9263_ID_PIOA,
-		.offset		= AT91_PIOA,
-		.clock		= &pioA_clk,
+		.mmio_base	= AT91_PIOA,
+		.irq		= AT91SAM9263_ID_PIOA,
 	}, {
-		.id		= AT91SAM9263_ID_PIOB,
-		.offset		= AT91_PIOB,
-		.clock		= &pioB_clk,
+		.mmio_base	= AT91_PIOB,
+		.irq		= AT91SAM9263_ID_PIOB,
 	}, {
-		.id		= AT91SAM9263_ID_PIOCDE,
-		.offset		= AT91_PIOC,
-		.clock		= &pioCDE_clk,
+		.mmio_base	= AT91_PIOC,
+		.irq		= AT91SAM9263_ID_PIOCDE,
 	}, {
-		.id		= AT91SAM9263_ID_PIOCDE,
-		.offset		= AT91_PIOD,
-		.clock		= &pioCDE_clk,
+		.mmio_base	= AT91_PIOD,
+		.irq		= AT91SAM9263_ID_PIOCDE,
 	}, {
-		.id		= AT91SAM9263_ID_PIOCDE,
-		.offset		= AT91_PIOE,
-		.clock		= &pioCDE_clk,
+		.mmio_base	= AT91_PIOE,
+		.irq		= AT91SAM9263_ID_PIOCDE,
 	}
 };
 
@@ -343,9 +340,6 @@ static void __init at91sam9263_initialize(unsigned long main_clock)
 
 	/* Register the processor-specific clocks */
 	at91sam9263_register_clocks();
-
-	/* Register GPIO subsystem */
-	at91_gpio_init(at91sam9263_gpio, 5);
 }
 
 /* --------------------------------------------------------------------
@@ -394,4 +388,8 @@ struct at91_soc __initdata at91sam9263_soc = {
 	.name = "at91sam9263",
 	.default_irq_priority = at91sam9263_default_irq_priority,
 	.init = at91sam9263_initialize,
+	.gpio = {
+		.resource = at91sam9263_pios,
+		.num_resources = ARRAY_SIZE(at91sam9263_pios),
+	},
 };
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index a1561d4..0fee23f 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -211,10 +211,11 @@ static struct clk *periph_clocks[] __initdata = {
 };
 
 static struct clk_lookup periph_clocks_lookups[] = {
-	CLKDEV_CON_ID("pioA_clk", &pioA_clk),
-	CLKDEV_CON_ID("pioB_clk", &pioB_clk),
-	CLKDEV_CON_ID("pioC_clk", &pioC_clk),
-	CLKDEV_CON_ID("pioDE_clk", &pioDE_clk),
+	CLKDEV_DEV_ID("at91_gpio.0", &pioA_clk),
+	CLKDEV_DEV_ID("at91_gpio.1", &pioB_clk),
+	CLKDEV_DEV_ID("at91_gpio.2", &pioC_clk),
+	CLKDEV_DEV_ID("at91_gpio.3", &pioDE_clk),
+	CLKDEV_DEV_ID("at91_gpio.4", &pioDE_clk),
 	CLKDEV_CON_ID("twi0_clk", &twi0_clk),
 	CLKDEV_CON_ID("twi1_clk", &twi1_clk),
 	CLKDEV_CON_ID("pwm_clk", &pwm_clk),
@@ -309,27 +310,22 @@ struct clk* __init at91sam9g45_get_uart_clock(int id)
  *  GPIO
  * -------------------------------------------------------------------- */
 
-static struct at91_gpio_bank at91sam9g45_gpio[] = {
+static struct at91_dev_resource at91sam9g45_pios[] __initdata = {
 	{
-		.id		= AT91SAM9G45_ID_PIOA,
-		.offset		= AT91_PIOA,
-		.clock		= &pioA_clk,
+		.mmio_base	= AT91_PIOA,
+		.irq		= AT91SAM9G45_ID_PIOA,
 	}, {
-		.id		= AT91SAM9G45_ID_PIOB,
-		.offset		= AT91_PIOB,
-		.clock		= &pioB_clk,
+		.mmio_base	= AT91_PIOB,
+		.irq		= AT91SAM9G45_ID_PIOB,
 	}, {
-		.id		= AT91SAM9G45_ID_PIOC,
-		.offset		= AT91_PIOC,
-		.clock		= &pioC_clk,
+		.mmio_base	= AT91_PIOC,
+		.irq		= AT91SAM9G45_ID_PIOC,
 	}, {
-		.id		= AT91SAM9G45_ID_PIODE,
-		.offset		= AT91_PIOD,
-		.clock		= &pioDE_clk,
+		.mmio_base	= AT91_PIOD,
+		.irq		= AT91SAM9G45_ID_PIODE,
 	}, {
-		.id		= AT91SAM9G45_ID_PIODE,
-		.offset		= AT91_PIOE,
-		.clock		= &pioDE_clk,
+		.mmio_base	= AT91_PIOE,
+		.irq		= AT91SAM9G45_ID_PIODE,
 	}
 };
 
@@ -362,9 +358,6 @@ static void __init at91sam9g45_initialize(unsigned long main_clock)
 
 	/* Register the processor-specific clocks */
 	at91sam9g45_register_clocks();
-
-	/* Register GPIO subsystem */
-	at91_gpio_init(at91sam9g45_gpio, 5);
 }
 
 /* --------------------------------------------------------------------
@@ -413,4 +406,8 @@ struct at91_soc __initdata at91sam9g45_soc = {
 	.name = "at91sam9g45",
 	.default_irq_priority = at91sam9g45_default_irq_priority,
 	.init = at91sam9g45_initialize,
+	.gpio = {
+		.resource = at91sam9g45_pios,
+		.num_resources = ARRAY_SIZE(at91sam9g45_pios),
+	},
 };
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 80acd8f..ec62ca01 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -184,10 +184,10 @@ static struct clk *periph_clocks[] __initdata = {
 };
 
 static struct clk_lookup periph_clocks_lookups[] = {
-	CLKDEV_CON_ID("pioA_clk", &pioA_clk),
-	CLKDEV_CON_ID("pioB_clk", &pioB_clk),
-	CLKDEV_CON_ID("pioC_clk", &pioC_clk),
-	CLKDEV_CON_ID("pioD_clk", &pioD_clk),
+	CLKDEV_DEV_ID("at91_gpio.0", &pioA_clk),
+	CLKDEV_DEV_ID("at91_gpio.1", &pioB_clk),
+	CLKDEV_DEV_ID("at91_gpio.2", &pioC_clk),
+	CLKDEV_DEV_ID("at91_gpio.3", &pioD_clk),
 	CLKDEV_CON_ID("mci_clk", &mmc_clk),
 	CLKDEV_CON_ID("twi0_clk", &twi0_clk),
 	CLKDEV_CON_ID("twi1_clk", &twi1_clk),
@@ -266,23 +266,19 @@ struct clk* __init at91sam9rl_get_uart_clock(int id)
  *  GPIO
  * -------------------------------------------------------------------- */
 
-static struct at91_gpio_bank at91sam9rl_gpio[] = {
+static struct at91_dev_resource at91sam9rl_pios[] __initdata = {
 	{
-		.id		= AT91SAM9RL_ID_PIOA,
-		.offset		= AT91_PIOA,
-		.clock		= &pioA_clk,
+		.mmio_base	= AT91_PIOA,
+		.irq		= AT91SAM9RL_ID_PIOA,
 	}, {
-		.id		= AT91SAM9RL_ID_PIOB,
-		.offset		= AT91_PIOB,
-		.clock		= &pioB_clk,
+		.mmio_base	= AT91_PIOB,
+		.irq		= AT91SAM9RL_ID_PIOB,
 	}, {
-		.id		= AT91SAM9RL_ID_PIOC,
-		.offset		= AT91_PIOC,
-		.clock		= &pioC_clk,
+		.mmio_base	= AT91_PIOC,
+		.irq		= AT91SAM9RL_ID_PIOC,
 	}, {
-		.id		= AT91SAM9RL_ID_PIOD,
-		.offset		= AT91_PIOD,
-		.clock		= &pioD_clk,
+		.mmio_base	= AT91_PIOD,
+		.irq		= AT91SAM9RL_ID_PIOD,
 	}
 };
 
@@ -328,9 +324,6 @@ static void __init at91sam9rl_initialize(unsigned long main_clock)
 
 	/* Register the processor-specific clocks */
 	at91sam9rl_register_clocks();
-
-	/* Register GPIO subsystem */
-	at91_gpio_init(at91sam9rl_gpio, 4);
 }
 
 /* --------------------------------------------------------------------
@@ -379,4 +372,8 @@ struct at91_soc __initdata at91sam9rl_soc = {
 	.name = "at91sam9rl",
 	.default_irq_priority = at91sam9rl_default_irq_priority,
 	.init = at91sam9rl_initialize,
+	.gpio = {
+		.resource = at91sam9rl_pios,
+		.num_resources = ARRAY_SIZE(at91sam9rl_pios),
+	},
 };
diff --git a/arch/arm/mach-at91/clock.h b/arch/arm/mach-at91/clock.h
index f0d8776..3e40da2 100644
--- a/arch/arm/mach-at91/clock.h
+++ b/arch/arm/mach-at91/clock.h
@@ -32,6 +32,12 @@ extern int __init clk_register(struct clk *clk);
 extern struct clk mck;
 extern struct clk utmi_clk;
 
+#define CLKDEV_DEV_ID(_id, _clk)			\
+	{						\
+		.dev_id = _id,				\
+		.clk = _clk,				\
+	}
+
 #define CLKDEV_CON_ID(_id, _clk)			\
 	{						\
 		.con_id = _id,				\
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
new file mode 100644
index 0000000..03ded48
--- /dev/null
+++ b/arch/arm/mach-at91/devices.c
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) 2007 Stelian Pop <stelian.pop@leadtechdesign.com>
+ * Copyright (C) 2007 Lead Tech Design <www.leadtechdesign.com>
+ * Copyright (C) 2007-2011 Atmel Corporation.
+ * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Under GPLv2
+ *
+ */
+
+#include <linux/platform_device.h>
+
+#include "devices.h"
+
+
diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
new file mode 100644
index 0000000..4d39f9b
--- /dev/null
+++ b/arch/arm/mach-at91/devices.h
@@ -0,0 +1,55 @@
+/*
+ * arch/arm/mach-at91/devices.h
+ *
+ * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Under GPLv2
+ *
+ */
+
+#ifndef _AT91_DEVICES_H
+#define _AT91_DEVICES_H
+
+#include <linux/types.h>
+#include <linux/platform_device.h>
+
+#define RES_MEM(size)				\
+	{					\
+		.end	= size - 1,		\
+		.flags	= IORESOURCE_MEM,	\
+	}
+
+#define RES_IRQ()				\
+	{					\
+		.flags	= IORESOURCE_IRQ,	\
+	}
+
+
+static inline void set_resource_mem(struct resource *res, resource_size_t mmio_base)
+{
+	BUG_ON(res->flags != IORESOURCE_MEM);
+	res->start = mmio_base;
+	res->end  += mmio_base;
+}
+
+static inline void set_resource_irq(struct resource *res, int irq)
+{
+	if (!irq)
+		return;
+
+	BUG_ON(res->flags != IORESOURCE_IRQ);
+	res->start = irq;
+	res->end   = irq;
+}
+
+struct at91_dev_resource {
+	resource_size_t	mmio_base;
+	int		irq;
+};
+
+struct at91_dev_resource_array {
+	struct at91_dev_resource *resource;
+	int num_resources;
+};
+
+#endif /* _AT91_DEVICES_H */
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index a039726..b2c7c3a 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -50,12 +50,6 @@ extern void at91sam9_alt_reset(void);
 #define AT91RM9200_PQFP		3	/* AT91RM9200 PQFP package has 3 banks */
 #define AT91RM9200_BGA		4	/* AT91RM9200 BGA package has 4 banks */
 
-struct at91_gpio_bank {
-	unsigned short id;		/* peripheral ID */
-	unsigned long offset;		/* offset from system peripheral base */
-	struct clk *clock;		/* associated clock */
-};
-extern void __init at91_gpio_init(struct at91_gpio_bank *, int nr_banks);
 extern void __init at91_gpio_irq_setup(void);
 
 extern void (*at91_arch_reset)(void);
diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index 4615528..dd05512 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -12,6 +12,7 @@
 #include <linux/clk.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
+#include <linux/platform_device.h>
 #include <linux/irq.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
@@ -26,12 +27,11 @@
 
 #include <asm/gpio.h>
 
-#include "generic.h"
-
 struct at91_gpio_chip {
 	struct gpio_chip	chip;
+	unsigned short		id;		/* peripheral ID */
+	struct clk		*clock;		/* associated clock */
 	struct at91_gpio_chip	*next;		/* Bank sharing same clock */
-	struct at91_gpio_bank	*bank;		/* Bank definition */
 	void __iomem		*regbase;	/* Base of register bank */
 };
 
@@ -287,7 +287,7 @@ static int gpio_irq_set_wake(struct irq_data *d, unsigned state)
 	else
 		wakeups[bank] &= ~mask;
 
-	irq_set_irq_wake(gpio_chip[bank].bank->id, state);
+	irq_set_irq_wake(gpio_chip[bank].id, state);
 
 	return 0;
 }
@@ -304,7 +304,7 @@ void at91_gpio_suspend(void)
 		__raw_writel(wakeups[i], pio + PIO_IER);
 
 		if (!wakeups[i])
-			clk_disable(gpio_chip[i].bank->clock);
+			clk_disable(gpio_chip[i].clock);
 		else {
 #ifdef CONFIG_PM_DEBUG
 			printk(KERN_DEBUG "GPIO-%c may wake for %08x\n", 'A'+i, wakeups[i]);
@@ -321,7 +321,7 @@ void at91_gpio_resume(void)
 		void __iomem	*pio = gpio_chip[i].regbase;
 
 		if (!wakeups[i])
-			clk_enable(gpio_chip[i].bank->clock);
+			clk_enable(gpio_chip[i].clock);
 
 		__raw_writel(wakeups[i], pio + PIO_IDR);
 		__raw_writel(backups[i], pio + PIO_IER);
@@ -499,7 +499,7 @@ void __init at91_gpio_irq_setup(void)
 	for (pioc = 0, pin = PIN_BASE, this = gpio_chip, prev = NULL;
 			pioc++ < gpio_banks;
 			prev = this, this++) {
-		unsigned	id = this->bank->id;
+		unsigned	id = this->id;
 		unsigned	i;
 
 		__raw_writel(~0, this->regbase + PIO_IDR);
@@ -599,34 +599,56 @@ static void at91_gpiolib_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	}
 }
 
-/*
- * Called from the processor-specific init to enable GPIO pin support.
- */
-void __init at91_gpio_init(struct at91_gpio_bank *data, int nr_banks)
+static int __devinit at91_gpio_probe(struct platform_device *pdev)
 {
-	unsigned		i;
-	struct at91_gpio_chip *at91_gpio, *last = NULL;
+	int id = pdev->id;
+	struct at91_gpio_chip *at91_gpio;
 
-	BUG_ON(nr_banks > MAX_GPIO_BANKS);
+	if (!is_early_platform_device(pdev)) {
+		pr_info("at91_gpio.%d: call via non early plaform\n", id);
+		return 0;
+	}
 
-	gpio_banks = nr_banks;
+	BUG_ON(id > MAX_GPIO_BANKS);
 
-	for (i = 0; i < nr_banks; i++) {
-		at91_gpio = &gpio_chip[i];
+	gpio_banks = max(gpio_banks, id + 1);
 
-		at91_gpio->bank = &data[i];
-		at91_gpio->chip.base = PIN_BASE + i * 32;
-		at91_gpio->regbase = at91_gpio->bank->offset +
+	at91_gpio = &gpio_chip[id];
+	at91_gpio->id = platform_get_irq(pdev, 0);
+	at91_gpio->chip.base = PIN_BASE + id * 32;
+	at91_gpio->regbase = pdev->resource[0].start +
 			(void __iomem *)AT91_VA_BASE_SYS;
 
-		/* enable PIO controller's clock */
-		clk_enable(at91_gpio->bank->clock);
+	at91_gpio->clock = clk_get_pdev(pdev, NULL);
 
-		/* AT91SAM9263_ID_PIOCDE groups PIOC, PIOD, PIOE */
-		if (last && last->bank->id == at91_gpio->bank->id)
-			last->next = at91_gpio;
-		last = at91_gpio;
+	/* enable PIO controller's clock */
+	clk_enable(at91_gpio->clock);
 
-		gpiochip_add(&at91_gpio->chip);
-	}
+	/* AT91SAM9263_ID_PIOCDE groups PIOC, PIOD, PIOE */
+	if (id > 0 && gpio_chip[id - 1].id == at91_gpio->id)
+		gpio_chip[id - 1].next = at91_gpio;
+
+	gpiochip_add(&at91_gpio->chip);
+
+	pr_debug("at91_gpio.%d: offset = 0x%x, clk = 0x%p, irq = %d\n",
+		id, pdev->resource[0].start, at91_gpio->clock,
+		at91_gpio->id);
+
+	return 0;
+}
+
+static int __devexit at91_gpio_remove(struct platform_device *pdev)
+{
+	return -EBUSY; /* cannot unregister clockevent and clocksource */
 }
+
+static struct platform_driver at91_gpio_driver = {
+	.probe		= at91_gpio_probe,
+	.remove		= __devexit_p(at91_gpio_remove),
+	.driver		= {
+		.name	= "at91_gpio",
+		.owner	= THIS_MODULE,
+	},
+};
+
+early_platform_init("early_at91_gpio", &at91_gpio_driver);
diff --git a/arch/arm/mach-at91/soc.c b/arch/arm/mach-at91/soc.c
index 6fe205f2..0e8604c 100644
--- a/arch/arm/mach-at91/soc.c
+++ b/arch/arm/mach-at91/soc.c
@@ -20,6 +20,7 @@
 #include "generic.h"
 
 static struct at91_soc __initdata current_soc;
+static void __init at91_add_gpio(void);
 
 struct at91_cpu_id cpu_id;
 EXPORT_SYMBOL(cpu_id);
@@ -114,4 +115,100 @@ void __init at91_initialize(unsigned long main_clock)
 	pr_info("AT91: detected soc: %s\n", current_soc.name);
 
 	current_soc.init(main_clock);
+
+	/* Register GPIO subsystem */
+	at91_add_gpio();
+}
+
+/* --------------------------------------------------------------------
+ *  GPIO
+ * -------------------------------------------------------------------- */
+
+static struct resource pioa_resources[] = {
+	[0] = RES_MEM(SZ_512),
+	[1] = RES_IRQ(),
+};
+
+static struct platform_device at91_pioa_device = {
+	.name		= "at91_gpio",
+	.id		= 0,
+	.resource	= pioa_resources,
+	.num_resources	= ARRAY_SIZE(pioa_resources),
+};
+
+static struct resource piob_resources[] = {
+	[0] = RES_MEM(SZ_512),
+	[1] = RES_IRQ(),
+};
+
+static struct platform_device at91_piob_device = {
+	.name		= "at91_gpio",
+	.id		= 1,
+	.resource	= piob_resources,
+	.num_resources	= ARRAY_SIZE(piob_resources),
+};
+
+static struct resource pioc_resources[] = {
+	[0] = RES_MEM(SZ_512),
+	[1] = RES_IRQ(),
+};
+
+static struct platform_device at91_pioc_device = {
+	.name		= "at91_gpio",
+	.id		= 2,
+	.resource	= pioc_resources,
+	.num_resources	= ARRAY_SIZE(pioc_resources),
+};
+
+static struct resource piod_resources[] = {
+	[0] = RES_MEM(SZ_512),
+	[1] = RES_IRQ(),
+};
+
+static struct platform_device at91_piod_device = {
+	.name		= "at91_gpio",
+	.id		= 3,
+	.resource	= piod_resources,
+	.num_resources	= ARRAY_SIZE(piod_resources),
+};
+
+static struct resource pioe_resources[] = {
+	[0] = RES_MEM(SZ_512),
+	[1] = RES_IRQ(),
+};
+
+static struct platform_device at91_pioe_device = {
+	.name		= "at91_gpio",
+	.id		= 4,
+	.resource	= pioe_resources,
+	.num_resources	= ARRAY_SIZE(pioe_resources),
+};
+
+static struct platform_device *at91_pio_devices[] __initdata = {
+	&at91_pioa_device,
+	&at91_piob_device,
+	&at91_pioc_device,
+	&at91_piod_device,
+	&at91_pioe_device,
+};
+
+static void __init at91_add_gpio(void)
+{
+	struct at91_dev_resource *gpios = current_soc.gpio.resource;
+	int nb = current_soc.gpio.num_resources;
+
+	int i;
+	struct resource *r;
+
+	BUG_ON(!gpios || nb < 0 || nb > ARRAY_SIZE(at91_pio_devices));
+
+	for (i = 0; i < nb; i++) {
+		r = at91_pio_devices[i]->resource;
+		set_resource_mem(&r[0], gpios[i].mmio_base);
+		set_resource_irq(&r[1], gpios[i].irq);
+	}
+
+	early_platform_add_devices(at91_pio_devices, nb);
+	early_platform_driver_register_all("early_at91_gpio");
+	early_platform_driver_probe("early_at91_gpio", nb , 0);
 }
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
index a097032..bf90d48 100644
--- a/arch/arm/mach-at91/soc.h
+++ b/arch/arm/mach-at91/soc.h
@@ -6,10 +6,14 @@
  *
  */
 
+#include "devices.h"
+
 struct at91_soc {
 	char *name;
 	unsigned int *default_irq_priority;
 
+	struct at91_dev_resource_array gpio;
+
 	void (*init)(unsigned long main_clock);
 };
 
-- 
1.7.4.1
