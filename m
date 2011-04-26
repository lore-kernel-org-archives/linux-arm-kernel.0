From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 26 Apr 2011 03:11:40 +0200
Subject: [PATCH 14/14] at91: move clock subsystem init to soc generic init
In-Reply-To: <20110425180847.GA12904@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
Message-ID: <1303780300-2205-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/mach-at91/at572d940hf.c |    5 +----
 arch/arm/mach-at91/at91cap9.c    |    5 +----
 arch/arm/mach-at91/at91rm9200.c  |    5 +----
 arch/arm/mach-at91/at91sam9260.c |    5 +----
 arch/arm/mach-at91/at91sam9261.c |    5 +----
 arch/arm/mach-at91/at91sam9263.c |    5 +----
 arch/arm/mach-at91/at91sam9g45.c |    5 +----
 arch/arm/mach-at91/at91sam9rl.c  |    5 +----
 arch/arm/mach-at91/soc.c         |    5 ++++-
 arch/arm/mach-at91/soc.h         |    2 +-
 10 files changed, 13 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-at91/at572d940hf.c b/arch/arm/mach-at91/at572d940hf.c
index 7d7a4f2..f945171 100644
--- a/arch/arm/mach-at91/at572d940hf.c
+++ b/arch/arm/mach-at91/at572d940hf.c
@@ -359,7 +359,7 @@ static void at572d940hf_reset(void)
  *  AT572D940HF processor initialization
  * -------------------------------------------------------------------- */
 
-static void __init at572d940hf_initialize(unsigned long main_clock)
+static void __init at572d940hf_initialize(void)
 {
 	/* Map peripherals */
 	iotable_init(at572d940hf_io_desc, ARRAY_SIZE(at572d940hf_io_desc));
@@ -367,9 +367,6 @@ static void __init at572d940hf_initialize(unsigned long main_clock)
 	at91_arch_reset = at572d940hf_reset;
 	at91_extern_irq = (1 << AT572D940HF_ID_IRQ0) | (1 << AT572D940HF_ID_IRQ1)
 			| (1 << AT572D940HF_ID_IRQ2);
-
-	/* Init clock subsystem */
-	at91_clock_init(main_clock);
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index c304d9c..3487f97 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -356,7 +356,7 @@ static void at91cap9_poweroff(void)
  *  AT91CAP9 processor initialization
  * -------------------------------------------------------------------- */
 
-static void __init at91cap9_initialize(unsigned long main_clock)
+static void __init at91cap9_initialize(void)
 {
 	/* Map peripherals */
 	iotable_init(at91cap9_io_desc, ARRAY_SIZE(at91cap9_io_desc));
@@ -365,9 +365,6 @@ static void __init at91cap9_initialize(unsigned long main_clock)
 	pm_power_off = at91cap9_poweroff;
 	at91_extern_irq = (1 << AT91CAP9_ID_IRQ0) | (1 << AT91CAP9_ID_IRQ1);
 
-	/* Init clock subsystem */
-	at91_clock_init(main_clock);
-
 	/* Remember the silicon revision */
 	if (cpu_is_at91cap9_revB())
 		system_rev = 0xB;
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index f5f5711..1a16ca1 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -312,7 +312,7 @@ static void at91rm9200_reset(void)
 /* --------------------------------------------------------------------
  *  AT91RM9200 processor initialization
  * -------------------------------------------------------------------- */
-static void __init at91rm9200_initialize(unsigned long main_clock)
+static void __init at91rm9200_initialize(void)
 {
 	if (cpu_is_at91rm9200_bga())
 		at91rm9200_soc.gpio.num_resources = AT91RM9200_BGA;
@@ -327,9 +327,6 @@ static void __init at91rm9200_initialize(unsigned long main_clock)
 			| (1 << AT91RM9200_ID_IRQ2) | (1 << AT91RM9200_ID_IRQ3)
 			| (1 << AT91RM9200_ID_IRQ4) | (1 << AT91RM9200_ID_IRQ5)
 			| (1 << AT91RM9200_ID_IRQ6);
-
-	/* Init clock subsystem */
-	at91_clock_init(main_clock);
 }
 
 
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 7a2d10b..ae0bf40 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -344,7 +344,7 @@ static void __init at91sam9xe_initialize(void)
 	iotable_init(at91sam9xe_sram_desc, ARRAY_SIZE(at91sam9xe_sram_desc));
 }
 
-static void __init at91sam9260_initialize(unsigned long main_clock)
+static void __init at91sam9260_initialize(void)
 {
 	/* Map peripherals */
 
@@ -359,9 +359,6 @@ static void __init at91sam9260_initialize(unsigned long main_clock)
 	pm_power_off = at91sam9260_poweroff;
 	at91_extern_irq = (1 << AT91SAM9260_ID_IRQ0) | (1 << AT91SAM9260_ID_IRQ1)
 			| (1 << AT91SAM9260_ID_IRQ2);
-
-	/* Init clock subsystem */
-	at91_clock_init(main_clock);
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index a2ee99d..52bd316 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -311,7 +311,7 @@ static void at91sam9261_poweroff(void)
  *  AT91SAM9261 processor initialization
  * -------------------------------------------------------------------- */
 
-static void __init at91sam9261_initialize(unsigned long main_clock)
+static void __init at91sam9261_initialize(void)
 {
 	/* Map peripherals */
 
@@ -325,9 +325,6 @@ static void __init at91sam9261_initialize(unsigned long main_clock)
 	pm_power_off = at91sam9261_poweroff;
 	at91_extern_irq = (1 << AT91SAM9261_ID_IRQ0) | (1 << AT91SAM9261_ID_IRQ1)
 			| (1 << AT91SAM9261_ID_IRQ2);
-
-	/* Init clock subsystem */
-	at91_clock_init(main_clock);
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 0b9a6b4..619565a 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -326,7 +326,7 @@ static void at91sam9263_poweroff(void)
  *  AT91SAM9263 processor initialization
  * -------------------------------------------------------------------- */
 
-static void __init at91sam9263_initialize(unsigned long main_clock)
+static void __init at91sam9263_initialize(void)
 {
 	/* Map peripherals */
 	iotable_init(at91sam9263_io_desc, ARRAY_SIZE(at91sam9263_io_desc));
@@ -334,9 +334,6 @@ static void __init at91sam9263_initialize(unsigned long main_clock)
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9263_poweroff;
 	at91_extern_irq = (1 << AT91SAM9263_ID_IRQ0) | (1 << AT91SAM9263_ID_IRQ1);
-
-	/* Init clock subsystem */
-	at91_clock_init(main_clock);
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 96cfc16..bad29a3 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -344,7 +344,7 @@ static void at91sam9g45_poweroff(void)
  *  AT91SAM9G45 processor initialization
  * -------------------------------------------------------------------- */
 
-static void __init at91sam9g45_initialize(unsigned long main_clock)
+static void __init at91sam9g45_initialize(void)
 {
 	/* Map peripherals */
 	iotable_init(at91sam9g45_io_desc, ARRAY_SIZE(at91sam9g45_io_desc));
@@ -352,9 +352,6 @@ static void __init at91sam9g45_initialize(unsigned long main_clock)
 	at91_arch_reset = at91sam9g45_reset;
 	pm_power_off = at91sam9g45_poweroff;
 	at91_extern_irq = (1 << AT91SAM9G45_ID_IRQ0);
-
-	/* Init clock subsystem */
-	at91_clock_init(main_clock);
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 638e921..82d3805 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -292,7 +292,7 @@ static void at91sam9rl_poweroff(void)
  *  AT91SAM9RL processor initialization
  * -------------------------------------------------------------------- */
 
-static void __init at91sam9rl_initialize(unsigned long main_clock)
+static void __init at91sam9rl_initialize(void)
 {
 	unsigned long cidr, sram_size;
 
@@ -318,9 +318,6 @@ static void __init at91sam9rl_initialize(unsigned long main_clock)
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9rl_poweroff;
 	at91_extern_irq = (1 << AT91SAM9RL_ID_IRQ0);
-
-	/* Init clock subsystem */
-	at91_clock_init(main_clock);
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/soc.c b/arch/arm/mach-at91/soc.c
index c82d219..2d4e415 100644
--- a/arch/arm/mach-at91/soc.c
+++ b/arch/arm/mach-at91/soc.c
@@ -115,7 +115,10 @@ void __init at91_initialize(unsigned long main_clock)
 
 	pr_info("AT91: detected soc: %s\n", current_soc.name);
 
-	current_soc.init(main_clock);
+	current_soc.init();
+
+	/* Init clock subsystem */
+	at91_clock_init(main_clock);
 
 	/* Register the processor-specific clocks */
 	current_soc.register_clocks();
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
index ca8b30e..21c66fd 100644
--- a/arch/arm/mach-at91/soc.h
+++ b/arch/arm/mach-at91/soc.h
@@ -17,7 +17,7 @@ struct at91_soc {
 	struct at91_dev_resource *st;
 
 	void (*register_clocks)(void);
-	void (*init)(unsigned long main_clock);
+	void (*init)(void);
 };
 
 extern struct at91_soc at572d940hf_soc;
-- 
1.7.4.1
