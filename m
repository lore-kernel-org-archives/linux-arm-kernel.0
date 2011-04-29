From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 29 Apr 2011 14:59:18 +1200
Subject: [PATCH v3 09/23] at91: Make TCB device common
In-Reply-To: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
References: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1304045972-19319-10-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the individual TCB code for each at91 variant with a single
implementation in devices.c

This also fixes a bug on the AT572D940HF, where at91_add_device_tc was
never called.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/at572d940hf_devices.c |   52 +++-------------
 arch/arm/mach-at91/at91cap9_devices.c    |   38 +++---------
 arch/arm/mach-at91/at91rm9200_devices.c  |   93 ++++++----------------------
 arch/arm/mach-at91/at91sam9260_devices.c |   91 ++++++----------------------
 arch/arm/mach-at91/at91sam9261_devices.c |   52 +++-------------
 arch/arm/mach-at91/at91sam9263_devices.c |   38 +++---------
 arch/arm/mach-at91/at91sam9g45_devices.c |   64 +++++--------------
 arch/arm/mach-at91/at91sam9rl_devices.c  |   52 +++-------------
 arch/arm/mach-at91/devices.c             |   99 ++++++++++++++++++++++++++++++
 arch/arm/mach-at91/devices.h             |   13 ++++
 10 files changed, 212 insertions(+), 380 deletions(-)

diff --git a/arch/arm/mach-at91/at572d940hf_devices.c b/arch/arm/mach-at91/at572d940hf_devices.c
index 5f497c6..f5f35e1 100644
--- a/arch/arm/mach-at91/at572d940hf_devices.c
+++ b/arch/arm/mach-at91/at572d940hf_devices.c
@@ -170,51 +170,19 @@ static struct at91_dev_table_spi device_spi1 __initdata = {
  *  Timer/Counter blocks
  * -------------------------------------------------------------------- */
 
-#ifdef CONFIG_ATMEL_TCLIB
-
-static struct resource tcb_resources[] = {
-	[0] = {
-		.start	= AT572D940HF_BASE_TCB,
-		.end	= AT572D940HF_BASE_TCB + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT572D940HF_ID_TC0,
-		.end	= AT572D940HF_ID_TC0,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= AT572D940HF_ID_TC1,
-		.end	= AT572D940HF_ID_TC1,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start	= AT572D940HF_ID_TC2,
-		.end	= AT572D940HF_ID_TC2,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_tcb_res tcb_resources[] __initdata = {
+	/* this chip has a separate clock and irq for each TC channel */
+	{AT572D940HF_ID_TC0, "tc0_clk", "t0_clk"},
+	{AT572D940HF_ID_TC1, "tc1_clk", "t1_clk"},
+	{AT572D940HF_ID_TC2, "tc2_clk", "t2_clk"},
 };
 
-static struct platform_device at572d940hf_tcb_device = {
-	.name		= "atmel_tcb",
-	.id		= 0,
-	.resource	= tcb_resources,
-	.num_resources	= ARRAY_SIZE(tcb_resources),
+static struct at91_dev_table_tcb device_tcb __initdata = {
+	.mmio_base	= AT572D940HF_BASE_TCB,
+	.resources	= tcb_resources,
+	.nr_resources	= ARRAY_SIZE(tcb_resources),
 };
 
-static void __init at91_add_device_tc(void)
-{
-	/* this chip has a separate clock and irq for each TC channel */
-	at91_clock_associate("tc0_clk", &at572d940hf_tcb_device.dev, "t0_clk");
-	at91_clock_associate("tc1_clk", &at572d940hf_tcb_device.dev, "t1_clk");
-	at91_clock_associate("tc2_clk", &at572d940hf_tcb_device.dev, "t2_clk");
-	platform_device_register(&at572d940hf_tcb_device);
-}
-#else
-static void __init at91_add_device_tc(void) { }
-#endif
-
-
 /* --------------------------------------------------------------------
  *  RTT
  * -------------------------------------------------------------------- */
@@ -579,6 +547,7 @@ static struct at91_device_table at572d940hf_device_table __initdata = {
 	.twi[1]		= &device_twi1,
 	.spi[0]		= &device_spi0,
 	.spi[1]		= &device_spi1,
+	.tcb[0]		= &device_tcb,
 };
 
 void __init at572d940hf_init_devices(void)
@@ -596,7 +565,6 @@ static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_rtt();
 	at91_add_device_watchdog();
-	at91_add_device_tc();
 	return 0;
 }
 
diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index a54b6a5..555221e 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -279,39 +279,17 @@ static struct at91_dev_table_spi device_spi1 __initdata = {
  *  Timer/Counter block
  * -------------------------------------------------------------------- */
 
-#ifdef CONFIG_ATMEL_TCLIB
-
-static struct resource tcb_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_TCB0,
-		.end	= AT91CAP9_BASE_TCB0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_TCB,
-		.end	= AT91CAP9_ID_TCB,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_tcb_res tcb_resources[] __initdata = {
+	/* this chip has one clock and irq for all three TC channels */
+	{AT91CAP9_ID_TCB, "tcb_clk", "t0_clk"},
 };
 
-static struct platform_device at91cap9_tcb_device = {
-	.name		= "atmel_tcb",
-	.id		= 0,
-	.resource	= tcb_resources,
-	.num_resources	= ARRAY_SIZE(tcb_resources),
+static struct at91_dev_table_tcb device_tcb __initdata = {
+	.mmio_base	= AT91CAP9_BASE_TCB0,
+	.resources	= tcb_resources,
+	.nr_resources	= ARRAY_SIZE(tcb_resources),
 };
 
-static void __init at91_add_device_tc(void)
-{
-	/* this chip has one clock and irq for all three TC channels */
-	at91_clock_associate("tcb_clk", &at91cap9_tcb_device.dev, "t0_clk");
-	platform_device_register(&at91cap9_tcb_device);
-}
-#else
-static void __init at91_add_device_tc(void) { }
-#endif
-
-
 /* --------------------------------------------------------------------
  *  RTT
  * -------------------------------------------------------------------- */
@@ -907,6 +885,7 @@ static struct at91_device_table at91cap9_device_table __initdata = {
 	.twi[0]		= &device_twi,
 	.spi[0]		= &device_spi0,
 	.spi[1]		= &device_spi1,
+	.tcb[0]		= &device_tcb,
 };
 
 void __init at91cap9_init_devices(void)
@@ -923,7 +902,6 @@ static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_rtt();
 	at91_add_device_watchdog();
-	at91_add_device_tc();
 	return 0;
 }
 
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 6567e3c..5e9f269 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -250,86 +250,32 @@ static struct at91_dev_table_spi device_spi __initdata = {
  *  Timer/Counter blocks
  * -------------------------------------------------------------------- */
 
-#ifdef CONFIG_ATMEL_TCLIB
-
-static struct resource tcb0_resources[] = {
-	[0] = {
-		.start	= AT91RM9200_BASE_TCB0,
-		.end	= AT91RM9200_BASE_TCB0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91RM9200_ID_TC0,
-		.end	= AT91RM9200_ID_TC0,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= AT91RM9200_ID_TC1,
-		.end	= AT91RM9200_ID_TC1,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start	= AT91RM9200_ID_TC2,
-		.end	= AT91RM9200_ID_TC2,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_tcb_res tcb0_resources[] __initdata = {
+	/* this chip has a separate clock and irq for each TC channel */
+	{AT91RM9200_ID_TC0, "tc0_clk", "t0_clk"},
+	{AT91RM9200_ID_TC1, "tc1_clk", "t1_clk"},
+	{AT91RM9200_ID_TC2, "tc2_clk", "t2_clk"},
 };
 
-static struct platform_device at91rm9200_tcb0_device = {
-	.name		= "atmel_tcb",
-	.id		= 0,
-	.resource	= tcb0_resources,
-	.num_resources	= ARRAY_SIZE(tcb0_resources),
+static struct at91_dev_table_tcb device_tcb0 __initdata = {
+	.mmio_base	= AT91RM9200_BASE_TCB0,
+	.resources	= tcb0_resources,
+	.nr_resources	= ARRAY_SIZE(tcb0_resources),
 };
 
-static struct resource tcb1_resources[] = {
-	[0] = {
-		.start	= AT91RM9200_BASE_TCB1,
-		.end	= AT91RM9200_BASE_TCB1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91RM9200_ID_TC3,
-		.end	= AT91RM9200_ID_TC3,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= AT91RM9200_ID_TC4,
-		.end	= AT91RM9200_ID_TC4,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start	= AT91RM9200_ID_TC5,
-		.end	= AT91RM9200_ID_TC5,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_tcb_res tcb1_resources[] __initdata = {
+	/* this chip has a separate clock and irq for each TC channel */
+	{AT91RM9200_ID_TC3, "tc3_clk", "t0_clk"},
+	{AT91RM9200_ID_TC4, "tc4_clk", "t1_clk"},
+	{AT91RM9200_ID_TC5, "tc5_clk", "t2_clk"},
 };
 
-static struct platform_device at91rm9200_tcb1_device = {
-	.name		= "atmel_tcb",
-	.id		= 1,
-	.resource	= tcb1_resources,
-	.num_resources	= ARRAY_SIZE(tcb1_resources),
+static struct at91_dev_table_tcb device_tcb1 __initdata = {
+	.mmio_base	= AT91RM9200_BASE_TCB1,
+	.resources	= tcb1_resources,
+	.nr_resources	= ARRAY_SIZE(tcb1_resources),
 };
 
-static void __init at91_add_device_tc(void)
-{
-	/* this chip has a separate clock and irq for each TC channel */
-	at91_clock_associate("tc0_clk", &at91rm9200_tcb0_device.dev, "t0_clk");
-	at91_clock_associate("tc1_clk", &at91rm9200_tcb0_device.dev, "t1_clk");
-	at91_clock_associate("tc2_clk", &at91rm9200_tcb0_device.dev, "t2_clk");
-	platform_device_register(&at91rm9200_tcb0_device);
-
-	at91_clock_associate("tc3_clk", &at91rm9200_tcb1_device.dev, "t0_clk");
-	at91_clock_associate("tc4_clk", &at91rm9200_tcb1_device.dev, "t1_clk");
-	at91_clock_associate("tc5_clk", &at91rm9200_tcb1_device.dev, "t2_clk");
-	platform_device_register(&at91rm9200_tcb1_device);
-}
-#else
-static void __init at91_add_device_tc(void) { }
-#endif
-
-
 /* --------------------------------------------------------------------
  *  RTC
  * -------------------------------------------------------------------- */
@@ -848,6 +794,8 @@ static struct at91_device_table at91rm9200_device_table __initdata = {
 	.nand		= &device_nand,
 	.twi[0]		= &device_twi,
 	.spi[0]		= &device_spi,
+	.tcb[0]		= &device_tcb0,
+	.tcb[1]		= &device_tcb1,
 };
 
 void __init at91rm9200_init_devices(void)
@@ -865,7 +813,6 @@ static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_rtc();
 	at91_add_device_watchdog();
-	at91_add_device_tc();
 	return 0;
 }
 
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 9ccb731..55dce25 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -164,86 +164,30 @@ static struct at91_dev_table_spi device_spi1 __initdata = {
  *  Timer/Counter blocks
  * -------------------------------------------------------------------- */
 
-#ifdef CONFIG_ATMEL_TCLIB
-
-static struct resource tcb0_resources[] = {
-	[0] = {
-		.start	= AT91SAM9260_BASE_TCB0,
-		.end	= AT91SAM9260_BASE_TCB0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9260_ID_TC0,
-		.end	= AT91SAM9260_ID_TC0,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= AT91SAM9260_ID_TC1,
-		.end	= AT91SAM9260_ID_TC1,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start	= AT91SAM9260_ID_TC2,
-		.end	= AT91SAM9260_ID_TC2,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_tcb_res tcb0_resources[] __initdata = {
+	{AT91SAM9260_ID_TC0, "tc0_clk", "t0_clk"},
+	{AT91SAM9260_ID_TC1, "tc1_clk", "t1_clk"},
+	{AT91SAM9260_ID_TC2, "tc2_clk", "t2_clk"},
 };
 
-static struct platform_device at91sam9260_tcb0_device = {
-	.name		= "atmel_tcb",
-	.id		= 0,
-	.resource	= tcb0_resources,
-	.num_resources	= ARRAY_SIZE(tcb0_resources),
+static struct at91_dev_table_tcb device_tcb0 __initdata = {
+	.mmio_base	= AT91SAM9260_BASE_TCB0,
+	.resources	= tcb0_resources,
+	.nr_resources	= ARRAY_SIZE(tcb0_resources),
 };
 
-static struct resource tcb1_resources[] = {
-	[0] = {
-		.start	= AT91SAM9260_BASE_TCB1,
-		.end	= AT91SAM9260_BASE_TCB1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9260_ID_TC3,
-		.end	= AT91SAM9260_ID_TC3,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= AT91SAM9260_ID_TC4,
-		.end	= AT91SAM9260_ID_TC4,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start	= AT91SAM9260_ID_TC5,
-		.end	= AT91SAM9260_ID_TC5,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_tcb_res tcb1_resources[] __initdata = {
+	{AT91SAM9260_ID_TC3, "tc3_clk", "t0_clk"},
+	{AT91SAM9260_ID_TC4, "tc4_clk", "t1_clk"},
+	{AT91SAM9260_ID_TC5, "tc5_clk", "t2_clk"},
 };
 
-static struct platform_device at91sam9260_tcb1_device = {
-	.name		= "atmel_tcb",
-	.id		= 1,
-	.resource	= tcb1_resources,
-	.num_resources	= ARRAY_SIZE(tcb1_resources),
+static struct at91_dev_table_tcb device_tcb1 __initdata = {
+	.mmio_base	= AT91SAM9260_BASE_TCB1,
+	.resources	= tcb1_resources,
+	.nr_resources	= ARRAY_SIZE(tcb1_resources),
 };
 
-static void __init at91_add_device_tc(void)
-{
-	/* this chip has a separate clock and irq for each TC channel */
-	at91_clock_associate("tc0_clk", &at91sam9260_tcb0_device.dev, "t0_clk");
-	at91_clock_associate("tc1_clk", &at91sam9260_tcb0_device.dev, "t1_clk");
-	at91_clock_associate("tc2_clk", &at91sam9260_tcb0_device.dev, "t2_clk");
-	platform_device_register(&at91sam9260_tcb0_device);
-
-	at91_clock_associate("tc3_clk", &at91sam9260_tcb1_device.dev, "t0_clk");
-	at91_clock_associate("tc4_clk", &at91sam9260_tcb1_device.dev, "t1_clk");
-	at91_clock_associate("tc5_clk", &at91sam9260_tcb1_device.dev, "t2_clk");
-	platform_device_register(&at91sam9260_tcb1_device);
-}
-#else
-static void __init at91_add_device_tc(void) { }
-#endif
-
-
 /* --------------------------------------------------------------------
  *  RTT
  * -------------------------------------------------------------------- */
@@ -869,6 +813,8 @@ static struct at91_device_table at91sam9260_device_table __initdata = {
 	.twi[0]		= &device_twi,
 	.spi[0]		= &device_spi0,
 	.spi[1]		= &device_spi1,
+	.tcb[0]		= &device_tcb0,
+	.tcb[1]		= &device_tcb1,
 };
 
 void __init at91sam9260_init_devices(void)
@@ -885,7 +831,6 @@ static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_rtt();
 	at91_add_device_watchdog();
-	at91_add_device_tc();
 	return 0;
 }
 
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index dd19119..558c593 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -227,51 +227,19 @@ void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data) {}
  *  Timer/Counter block
  * -------------------------------------------------------------------- */
 
-#ifdef CONFIG_ATMEL_TCLIB
-
-static struct resource tcb_resources[] = {
-	[0] = {
-		.start	= AT91SAM9261_BASE_TCB0,
-		.end	= AT91SAM9261_BASE_TCB0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9261_ID_TC0,
-		.end	= AT91SAM9261_ID_TC0,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= AT91SAM9261_ID_TC1,
-		.end	= AT91SAM9261_ID_TC1,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start	= AT91SAM9261_ID_TC2,
-		.end	= AT91SAM9261_ID_TC2,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_tcb_res tcb_resources[] __initdata = {
+	/* this chip has a separate clock and irq for each TC channel */
+	{AT91SAM9261_ID_TC0, "tc0_clk", "t0_clk"},
+	{AT91SAM9261_ID_TC1, "tc1_clk", "t1_clk"},
+	{AT91SAM9261_ID_TC2, "tc2_clk", "t2_clk"},
 };
 
-static struct platform_device at91sam9261_tcb_device = {
-	.name		= "atmel_tcb",
-	.id		= 0,
-	.resource	= tcb_resources,
-	.num_resources	= ARRAY_SIZE(tcb_resources),
+static struct at91_dev_table_tcb device_tcb __initdata = {
+	.mmio_base	= AT91SAM9261_BASE_TCB0,
+	.resources	= tcb_resources,
+	.nr_resources	= ARRAY_SIZE(tcb_resources),
 };
 
-static void __init at91_add_device_tc(void)
-{
-	/* this chip has a separate clock and irq for each TC channel */
-	at91_clock_associate("tc0_clk", &at91sam9261_tcb_device.dev, "t0_clk");
-	at91_clock_associate("tc1_clk", &at91sam9261_tcb_device.dev, "t1_clk");
-	at91_clock_associate("tc2_clk", &at91sam9261_tcb_device.dev, "t2_clk");
-	platform_device_register(&at91sam9261_tcb_device);
-}
-#else
-static void __init at91_add_device_tc(void) { }
-#endif
-
-
 /* --------------------------------------------------------------------
  *  RTT
  * -------------------------------------------------------------------- */
@@ -732,6 +700,7 @@ static struct at91_device_table at91sam9261_device_table __initdata = {
 	.twi[0]		= &device_twi,
 	.spi[0]		= &device_spi0,
 	.spi[1]		= &device_spi1,
+	.tcb[0]		= &device_tcb,
 };
 
 void __init at91sam9261_init_devices(void)
@@ -749,7 +718,6 @@ static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_rtt();
 	at91_add_device_watchdog();
-	at91_add_device_tc();
 	return 0;
 }
 
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index b049f93..1b488ec 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -509,39 +509,17 @@ void __init at91_add_device_isi(void) {}
  *  Timer/Counter block
  * -------------------------------------------------------------------- */
 
-#ifdef CONFIG_ATMEL_TCLIB
-
-static struct resource tcb_resources[] = {
-	[0] = {
-		.start	= AT91SAM9263_BASE_TCB0,
-		.end	= AT91SAM9263_BASE_TCB0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9263_ID_TCB,
-		.end	= AT91SAM9263_ID_TCB,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_tcb_res tcb_resources[] __initdata = {
+	/* this chip has one clock and irq for all three TC channels */
+	{AT91SAM9263_ID_TCB, "tcb_clk", "t0_clk"},
 };
 
-static struct platform_device at91sam9263_tcb_device = {
-	.name		= "atmel_tcb",
-	.id		= 0,
-	.resource	= tcb_resources,
-	.num_resources	= ARRAY_SIZE(tcb_resources),
+static struct at91_dev_table_tcb device_tcb __initdata = {
+	.mmio_base	= AT91SAM9263_BASE_TCB0,
+	.resources	= tcb_resources,
+	.nr_resources	= ARRAY_SIZE(tcb_resources),
 };
 
-static void __init at91_add_device_tc(void)
-{
-	/* this chip has one clock and irq for all three TC channels */
-	at91_clock_associate("tcb_clk", &at91sam9263_tcb_device.dev, "t0_clk");
-	platform_device_register(&at91sam9263_tcb_device);
-}
-#else
-static void __init at91_add_device_tc(void) { }
-#endif
-
-
 /* --------------------------------------------------------------------
  *  RTT
  * -------------------------------------------------------------------- */
@@ -1027,6 +1005,7 @@ static struct at91_device_table at91sam9263_device_table __initdata = {
 	.twi[0]		= &device_twi,
 	.spi[0]		= &device_spi0,
 	.spi[1]		= &device_spi1,
+	.tcb[0]		= &device_tcb,
 };
 
 void __init at91sam9263_init_devices(void)
@@ -1043,7 +1022,6 @@ static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_rtt();
 	at91_add_device_watchdog();
-	at91_add_device_tc();
 	return 0;
 }
 
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index b25c0cc..f236ce8 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -464,61 +464,28 @@ void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data) {}
  *  Timer/Counter block
  * -------------------------------------------------------------------- */
 
-#ifdef CONFIG_ATMEL_TCLIB
-static struct resource tcb0_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_BASE_TCB0,
-		.end	= AT91SAM9G45_BASE_TCB0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_ID_TCB,
-		.end	= AT91SAM9G45_ID_TCB,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_tcb_res tcb0_resources[] __initdata = {
+	/* this chip has one clock and irq for all six TC channels */
+	{AT91SAM9G45_ID_TCB, "tcb0_clk", "t0_clk"},
 };
 
-static struct platform_device at91sam9g45_tcb0_device = {
-	.name		= "atmel_tcb",
-	.id		= 0,
-	.resource	= tcb0_resources,
-	.num_resources	= ARRAY_SIZE(tcb0_resources),
+static struct at91_dev_table_tcb device_tcb0 __initdata = {
+	.mmio_base	= AT91SAM9G45_BASE_TCB0,
+	.resources	= tcb0_resources,
+	.nr_resources	= ARRAY_SIZE(tcb0_resources),
 };
 
-/* TCB1 begins with TC3 */
-static struct resource tcb1_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_BASE_TCB1,
-		.end	= AT91SAM9G45_BASE_TCB1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_ID_TCB,
-		.end	= AT91SAM9G45_ID_TCB,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_tcb_res tcb1_resources[] __initdata = {
+	/* this chip has one clock and irq for all six TC channels */
+	{AT91SAM9G45_ID_TCB, "tcb1_clk", "t0_clk"},
 };
 
-static struct platform_device at91sam9g45_tcb1_device = {
-	.name		= "atmel_tcb",
-	.id		= 1,
-	.resource	= tcb1_resources,
-	.num_resources	= ARRAY_SIZE(tcb1_resources),
+static struct at91_dev_table_tcb device_tcb1 __initdata = {
+	.mmio_base	= AT91SAM9G45_BASE_TCB1,
+	.resources	= tcb1_resources,
+	.nr_resources	= ARRAY_SIZE(tcb1_resources),
 };
 
-static void __init at91_add_device_tc(void)
-{
-	/* this chip has one clock and irq for all six TC channels */
-	at91_clock_associate("tcb0_clk", &at91sam9g45_tcb0_device.dev, "t0_clk");
-	platform_device_register(&at91sam9g45_tcb0_device);
-	at91_clock_associate("tcb1_clk", &at91sam9g45_tcb1_device.dev, "t0_clk");
-	platform_device_register(&at91sam9g45_tcb1_device);
-}
-#else
-static void __init at91_add_device_tc(void) { }
-#endif
-
-
 /* --------------------------------------------------------------------
  *  RTC
  * -------------------------------------------------------------------- */
@@ -1107,6 +1074,8 @@ static struct at91_device_table at91sam9g45_device_table __initdata = {
 	.twi[1]		= &device_twi1,
 	.spi[0]		= &device_spi0,
 	.spi[1]		= &device_spi1,
+	.tcb[0]		= &device_tcb0,
+	.tcb[1]		= &device_tcb1,
 };
 
 void __init at91sam9g45_init_devices(void)
@@ -1125,7 +1094,6 @@ static int __init at91_add_standard_devices(void)
 	at91_add_device_rtc();
 	at91_add_device_rtt();
 	at91_add_device_watchdog();
-	at91_add_device_tc();
 	return 0;
 }
 
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 55a0918..d462ba0 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -351,51 +351,19 @@ void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data) {}
  *  Timer/Counter block
  * -------------------------------------------------------------------- */
 
-#ifdef CONFIG_ATMEL_TCLIB
-
-static struct resource tcb_resources[] = {
-	[0] = {
-		.start	= AT91SAM9RL_BASE_TCB0,
-		.end	= AT91SAM9RL_BASE_TCB0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9RL_ID_TC0,
-		.end	= AT91SAM9RL_ID_TC0,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= AT91SAM9RL_ID_TC1,
-		.end	= AT91SAM9RL_ID_TC1,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start	= AT91SAM9RL_ID_TC2,
-		.end	= AT91SAM9RL_ID_TC2,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_tcb_res tcb_resources[] __initdata = {
+	/* this chip has a separate clock and irq for each TC channel */
+	{AT91SAM9RL_ID_TC0, "tc0_clk", "t0_clk"},
+	{AT91SAM9RL_ID_TC1, "tc1_clk", "t1_clk"},
+	{AT91SAM9RL_ID_TC2, "tc2_clk", "t2_clk"},
 };
 
-static struct platform_device at91sam9rl_tcb_device = {
-	.name		= "atmel_tcb",
-	.id		= 0,
-	.resource	= tcb_resources,
-	.num_resources	= ARRAY_SIZE(tcb_resources),
+static struct at91_dev_table_tcb device_tcb __initdata = {
+	.mmio_base	= AT91SAM9RL_BASE_TCB0,
+	.resources	= tcb_resources,
+	.nr_resources	= ARRAY_SIZE(tcb_resources),
 };
 
-static void __init at91_add_device_tc(void)
-{
-	/* this chip has a separate clock and irq for each TC channel */
-	at91_clock_associate("tc0_clk", &at91sam9rl_tcb_device.dev, "t0_clk");
-	at91_clock_associate("tc1_clk", &at91sam9rl_tcb_device.dev, "t1_clk");
-	at91_clock_associate("tc2_clk", &at91sam9rl_tcb_device.dev, "t2_clk");
-	platform_device_register(&at91sam9rl_tcb_device);
-}
-#else
-static void __init at91_add_device_tc(void) { }
-#endif
-
-
 /* --------------------------------------------------------------------
  *  Touchscreen
  * -------------------------------------------------------------------- */
@@ -986,6 +954,7 @@ static struct at91_device_table at91sam9rl_device_table __initdata = {
 	.nand		= &device_nand,
 	.twi[0]		= &device_twi,
 	.spi[0]		= &device_spi,
+	.tcb[0]		= &device_tcb,
 };
 
 void __init at91sam9rl_init_devices(void)
@@ -1005,7 +974,6 @@ static int __init at91_add_standard_devices(void)
 	at91_add_device_rtc();
 	at91_add_device_rtt();
 	at91_add_device_watchdog();
-	at91_add_device_tc();
 	return 0;
 }
 
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index 9914b6f..40ad7e7 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c
@@ -832,7 +832,106 @@ void __init at91_add_device_spi(struct spi_board_info *spi_devices,
 void __init at91_add_device_spi(struct spi_board_info *spi_devices, int nr_devices) {}
 #endif
 
+#ifdef CONFIG_ATMEL_TCLIB
+
+static struct resource tcb0_resources[] = {
+	[0] = {
+		.end	= SZ_16K,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.flags	= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device at91_tcb0_device = {
+	.name		= "atmel_tcb",
+	.id		= 0,
+	.resource	= tcb0_resources,
+	.num_resources	= 1,
+};
+
+static struct resource tcb1_resources[] = {
+	[0] = {
+		.end	= SZ_16K,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.flags	= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device at91_tcb1_device = {
+	.name		= "atmel_tcb",
+	.id		= 1,
+	.resource	= tcb1_resources,
+	.num_resources	= 1,
+};
+
+static void __init at91_add_device_tc(void)
+{
+	struct at91_dev_table_tcb *info;
+	struct at91_tcb_res *res;
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(devices->tcb); i++) {
+		info = devices->tcb[i];
+		if (!info)
+			continue;
+
+		for (j = 0; j < info->nr_resources; j++) {
+			res = &info->resources[j];
+			if (i == 0) {
+				init_resource_irq(&tcb0_resources[j + 1],
+						  res->irq);
+				at91_clock_associate(res->clock_asc,
+						     &at91_tcb0_device.dev,
+						     res->clock_name);
+			} else {
+				init_resource_irq(&tcb1_resources[j + 1],
+						  res->irq);
+				at91_clock_associate(res->clock_asc,
+						     &at91_tcb1_device.dev,
+						     res->clock_name);
+			}
+		}
+
+		if (i == 0) {
+			init_resource_mem(&tcb0_resources[0], info->mmio_base);
+			at91_tcb0_device.num_resources += info->nr_resources;
+			platform_device_register(&at91_tcb0_device);
+		} else {
+			init_resource_mem(&tcb1_resources[0], info->mmio_base);
+			at91_tcb1_device.num_resources += info->nr_resources;
+			platform_device_register(&at91_tcb1_device);
+		}
+	}
+}
+#else
+static void __init at91_add_device_tc(void) { }
+#endif
+
 void __init at91_init_devices(struct at91_device_table *device_table)
 {
 	devices = device_table;
 }
+
+static int __init at91_add_standard_devices(void)
+{
+	at91_add_device_tc();
+	return 0;
+}
+
+arch_initcall(at91_add_standard_devices);
diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
index ba85523..41b6f6e 100644
--- a/arch/arm/mach-at91/devices.h
+++ b/arch/arm/mach-at91/devices.h
@@ -91,6 +91,18 @@ struct at91_dev_table_spi {
 	struct at91_pin_config	pin_spck;
 };
 
+struct at91_tcb_res {
+	int			irq;
+	const char		*clock_asc;
+	const char		*clock_name;
+};
+
+struct at91_dev_table_tcb {
+	unsigned		mmio_base;
+	struct at91_tcb_res	*resources;
+	int			nr_resources;
+};
+
 struct at91_device_table {
 	struct at91_dev_table_ethernet		*ethernet;
 	struct at91_dev_table_usb_ohci		*usbh_ohci;
@@ -100,6 +112,7 @@ struct at91_device_table {
 	struct at91_dev_table_nand		*nand;
 	struct at91_dev_table_twi		*twi[2];
 	struct at91_dev_table_spi		*spi[2];
+	struct at91_dev_table_tcb		*tcb[2];
 };
 
 extern void __init at91_init_devices(struct at91_device_table *device_table);
-- 
1.7.0.4
