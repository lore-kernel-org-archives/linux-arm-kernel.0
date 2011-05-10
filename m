From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 10 May 2011 18:34:18 +0200
Subject: [PATCH 8/9] at91: factorize sram init
In-Reply-To: <20110510162730.GA18929@game.jcrosoft.org>
References: <20110510162730.GA18929@game.jcrosoft.org>
Message-ID: <1305045259-23066-8-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/mach-at91/at572d940hf.c |   11 +-------
 arch/arm/mach-at91/at91cap9.c    |   11 +-------
 arch/arm/mach-at91/at91rm9200.c  |    6 +---
 arch/arm/mach-at91/at91sam9260.c |   53 ++++++-------------------------------
 arch/arm/mach-at91/at91sam9261.c |   22 +--------------
 arch/arm/mach-at91/at91sam9263.c |   17 +----------
 arch/arm/mach-at91/at91sam9g45.c |   11 +-------
 arch/arm/mach-at91/at91sam9rl.c  |   12 +--------
 arch/arm/mach-at91/generic.h     |    2 +
 arch/arm/mach-at91/setup.c       |   20 ++++++++++++++
 10 files changed, 40 insertions(+), 125 deletions(-)

diff --git a/arch/arm/mach-at91/at572d940hf.c b/arch/arm/mach-at91/at572d940hf.c
index f3e2c65..4a26877 100644
--- a/arch/arm/mach-at91/at572d940hf.c
+++ b/arch/arm/mach-at91/at572d940hf.c
@@ -35,15 +35,6 @@
 #include "generic.h"
 #include "clock.h"
 
-static struct map_desc at572d940hf_sram_desc[] __initdata = {
-	{
-		.virtual	= AT91_IO_VIRT_BASE - AT572D940HF_SRAM_SIZE,
-		.pfn		= __phys_to_pfn(AT572D940HF_SRAM_BASE),
-		.length		= AT572D940HF_SRAM_SIZE,
-		.type		= MT_DEVICE,
-	},
-};
-
 /* --------------------------------------------------------------------
  *  Clocks
  * -------------------------------------------------------------------- */
@@ -364,7 +355,7 @@ static void at572d940hf_reset(void)
 
 static void __init at572d940hf_map_io(void)
 {
-	iotable_init(at572d940hf_sram_desc, ARRAY_SIZE(at572d940hf_sram_desc));
+	at91_init_sram(0, AT572D940HF_SRAM_BASE, AT572D940HF_SRAM_SIZE);
 }
 
 static void __init at572d940hf_initialize(void)
diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index 23790b9..18745ae 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -29,15 +29,6 @@
 #include "generic.h"
 #include "clock.h"
 
-static struct map_desc at91cap9_sram_desc[] __initdata = {
-	{
-		.virtual	= AT91_IO_VIRT_BASE - AT91CAP9_SRAM_SIZE,
-		.pfn		= __phys_to_pfn(AT91CAP9_SRAM_BASE),
-		.length		= AT91CAP9_SRAM_SIZE,
-		.type		= MT_DEVICE,
-	},
-};
-
 /* --------------------------------------------------------------------
  *  Clocks
  * -------------------------------------------------------------------- */
@@ -359,7 +350,7 @@ static void at91cap9_poweroff(void)
 
 static void __init at91cap9_map_io(void)
 {
-	iotable_init(at91cap9_sram_desc, ARRAY_SIZE(at91cap9_sram_desc));
+	at91_init_sram(0, AT91CAP9_SRAM_BASE, AT91CAP9_SRAM_SIZE);
 }
 
 static void __init at91cap9_initialize(void)
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 0b512a3..68088fa4f 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -30,11 +30,6 @@ static struct map_desc at91rm9200_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(AT91RM9200_BASE_EMAC),
 		.length		= SZ_16K,
 		.type		= MT_DEVICE,
-	}, {
-		.virtual	= AT91_IO_VIRT_BASE - AT91RM9200_SRAM_SIZE,
-		.pfn		= __phys_to_pfn(AT91RM9200_SRAM_BASE),
-		.length		= AT91RM9200_SRAM_SIZE,
-		.type		= MT_DEVICE,
 	},
 };
 
@@ -319,6 +314,7 @@ static void at91rm9200_reset(void)
 static void __init at91rm9200_map_io(void)
 {
 	/* Map peripherals */
+	at91_init_sram(0, AT91RM9200_SRAM_BASE, AT91RM9200_SRAM_SIZE);
 	iotable_init(at91rm9200_io_desc, ARRAY_SIZE(at91rm9200_io_desc));
 }
 
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 7da4f2a..6133f30 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -27,41 +27,6 @@
 #include "generic.h"
 #include "clock.h"
 
-static struct map_desc at91sam9260_sram_desc[] __initdata = {
-	{
-		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9260_SRAM0_SIZE,
-		.pfn		= __phys_to_pfn(AT91SAM9260_SRAM0_BASE),
-		.length		= AT91SAM9260_SRAM0_SIZE,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9260_SRAM0_SIZE - AT91SAM9260_SRAM1_SIZE,
-		.pfn		= __phys_to_pfn(AT91SAM9260_SRAM1_BASE),
-		.length		= AT91SAM9260_SRAM1_SIZE,
-		.type		= MT_DEVICE,
-	}
-};
-
-static struct map_desc at91sam9g20_sram_desc[] __initdata = {
-	{
-		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9G20_SRAM0_SIZE,
-		.pfn		= __phys_to_pfn(AT91SAM9G20_SRAM0_BASE),
-		.length		= AT91SAM9G20_SRAM0_SIZE,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9G20_SRAM0_SIZE - AT91SAM9G20_SRAM1_SIZE,
-		.pfn		= __phys_to_pfn(AT91SAM9G20_SRAM1_BASE),
-		.length		= AT91SAM9G20_SRAM1_SIZE,
-		.type		= MT_DEVICE,
-	}
-};
-
-static struct map_desc at91sam9xe_sram_desc[] __initdata = {
-	{
-		.pfn		= __phys_to_pfn(AT91SAM9XE_SRAM_BASE),
-		.type		= MT_DEVICE,
-	}
-};
-
 /* --------------------------------------------------------------------
  *  Clocks
  * -------------------------------------------------------------------- */
@@ -346,20 +311,20 @@ static void __init at91sam9xe_map_io(void)
 			sram_size = SZ_16K;
 	}
 
-	at91sam9xe_sram_desc->virtual = AT91_IO_VIRT_BASE - sram_size;
-	at91sam9xe_sram_desc->length = sram_size;
-
-	iotable_init(at91sam9xe_sram_desc, ARRAY_SIZE(at91sam9xe_sram_desc));
+	at91_init_sram(0, AT91SAM9XE_SRAM_BASE, sram_size);
 }
 
 static void __init at91sam9260_map_io(void)
 {
-	if (cpu_is_at91sam9xe())
+	if (cpu_is_at91sam9xe()) {
 		at91sam9xe_map_io();
-	else if (cpu_is_at91sam9g20())
-		iotable_init(at91sam9g20_sram_desc, ARRAY_SIZE(at91sam9g20_sram_desc));
-	else
-		iotable_init(at91sam9260_sram_desc, ARRAY_SIZE(at91sam9260_sram_desc));
+	} else if (cpu_is_at91sam9g20()) {
+		at91_init_sram(0, AT91SAM9G20_SRAM0_BASE, AT91SAM9G20_SRAM0_SIZE);
+		at91_init_sram(1, AT91SAM9G20_SRAM1_BASE, AT91SAM9G20_SRAM1_SIZE);
+	} else {
+		at91_init_sram(0, AT91SAM9260_SRAM0_BASE, AT91SAM9260_SRAM0_SIZE);
+		at91_init_sram(1, AT91SAM9260_SRAM1_BASE, AT91SAM9260_SRAM1_SIZE);
+	}
 }
 
 static void __init at91sam9260_initialize(void)
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index bbaf72b..07e0dff 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -26,24 +26,6 @@
 #include "generic.h"
 #include "clock.h"
 
-static struct map_desc at91sam9261_sram_desc[] __initdata = {
-	{
-		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9261_SRAM_SIZE,
-		.pfn		= __phys_to_pfn(AT91SAM9261_SRAM_BASE),
-		.length		= AT91SAM9261_SRAM_SIZE,
-		.type		= MT_DEVICE,
-	},
-};
-
-static struct map_desc at91sam9g10_sram_desc[] __initdata = {
-	{
-		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9G10_SRAM_SIZE,
-		.pfn		= __phys_to_pfn(AT91SAM9G10_SRAM_BASE),
-		.length		= AT91SAM9G10_SRAM_SIZE,
-		.type		= MT_DEVICE,
-	},
-};
-
 /* --------------------------------------------------------------------
  *  Clocks
  * -------------------------------------------------------------------- */
@@ -317,9 +299,9 @@ static void at91sam9261_poweroff(void)
 static void __init at91sam9261_map_io(void)
 {
 	if (cpu_is_at91sam9g10())
-		iotable_init(at91sam9g10_sram_desc, ARRAY_SIZE(at91sam9g10_sram_desc));
+		at91_init_sram(0, AT91SAM9G10_SRAM_BASE, AT91SAM9G10_SRAM_SIZE);
 	else
-		iotable_init(at91sam9261_sram_desc, ARRAY_SIZE(at91sam9261_sram_desc));
+		at91_init_sram(0, AT91SAM9261_SRAM_BASE, AT91SAM9261_SRAM_SIZE);
 }
 
 static void __init at91sam9261_initialize(void)
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 88de596..a8ab580 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -25,20 +25,6 @@
 #include "generic.h"
 #include "clock.h"
 
-static struct map_desc at91sam9263_sram_desc[] __initdata = {
-	{
-		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9263_SRAM0_SIZE,
-		.pfn		= __phys_to_pfn(AT91SAM9263_SRAM0_BASE),
-		.length		= AT91SAM9263_SRAM0_SIZE,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9263_SRAM0_SIZE - AT91SAM9263_SRAM1_SIZE,
-		.pfn		= __phys_to_pfn(AT91SAM9263_SRAM1_BASE),
-		.length		= AT91SAM9263_SRAM1_SIZE,
-		.type		= MT_DEVICE,
-	},
-};
-
 /* --------------------------------------------------------------------
  *  Clocks
  * -------------------------------------------------------------------- */
@@ -331,7 +317,8 @@ static void at91sam9263_poweroff(void)
 
 static void __init at91sam9263_map_io(void)
 {
-	iotable_init(at91sam9263_sram_desc, ARRAY_SIZE(at91sam9263_sram_desc));
+	at91_init_sram(0, AT91SAM9263_SRAM0_BASE, AT91SAM9263_SRAM0_SIZE);
+	at91_init_sram(1, AT91SAM9263_SRAM1_BASE, AT91SAM9263_SRAM1_SIZE);
 }
 
 static void __init at91sam9263_initialize(void)
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 0e5dace..11f59d6 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -26,15 +26,6 @@
 #include "generic.h"
 #include "clock.h"
 
-static struct map_desc at91sam9g45_sram_desc[] __initdata = {
-	{
-		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9G45_SRAM_SIZE,
-		.pfn		= __phys_to_pfn(AT91SAM9G45_SRAM_BASE),
-		.length		= AT91SAM9G45_SRAM_SIZE,
-		.type		= MT_DEVICE,
-	}
-};
-
 /* --------------------------------------------------------------------
  *  Clocks
  * -------------------------------------------------------------------- */
@@ -350,7 +341,7 @@ static void at91sam9g45_poweroff(void)
 
 static void __init at91sam9g45_map_io(void)
 {
-	iotable_init(at91sam9g45_sram_desc, ARRAY_SIZE(at91sam9g45_sram_desc));
+	at91_init_sram(0, AT91SAM9G45_SRAM_BASE, AT91SAM9G45_SRAM_SIZE);
 }
 
 static void __init at91sam9g45_initialize(void)
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index adad00d..6c411f6 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -26,13 +26,6 @@
 #include "generic.h"
 #include "clock.h"
 
-static struct map_desc at91sam9rl_sram_desc[] __initdata = {
-	{
-		.pfn		= __phys_to_pfn(AT91SAM9RL_SRAM_BASE),
-		.type		= MT_DEVICE,
-	}
-};
-
 /* --------------------------------------------------------------------
  *  Clocks
  * -------------------------------------------------------------------- */
@@ -309,11 +302,8 @@ static void __init at91sam9rl_map_io(void)
 			sram_size = SZ_16K;
 	}
 
-	at91sam9rl_sram_desc->virtual = AT91_IO_VIRT_BASE - sram_size;
-	at91sam9rl_sram_desc->length = sram_size;
-
 	/* Map SRAM */
-	iotable_init(at91sam9rl_sram_desc, ARRAY_SIZE(at91sam9rl_sram_desc));
+	at91_init_sram(0, AT91SAM9RL_SRAM_BASE, sram_size);
 }
 
 static void __init at91sam9rl_initialize(void)
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 9fd0fa3..cf83f8b 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -12,6 +12,8 @@
 
  /* Map io */
 extern void __init at91_map_io(void);
+extern void __init at91_init_sram(int bank, unsigned long base,
+				  unsigned int length);
 
  /* Processors */
 extern void __init at91rm9200_set_type(int type);
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 9aaca5f..d2b1a06 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -45,6 +45,26 @@ void __init at91_init_interrupts(unsigned int *priority)
 	at91_gpio_irq_setup();
 }
 
+static struct map_desc sram_desc[2] __initdata;
+
+void __init at91_init_sram(int bank, unsigned long base, unsigned int length)
+{
+	struct map_desc *desc = &sram_desc[bank];
+
+	desc->virtual = AT91_IO_VIRT_BASE - length;
+	if (bank > 0)
+		desc->virtual -= sram_desc[bank - 1].length;
+
+	desc->pfn = __phys_to_pfn(base);
+	desc->length = length;
+	desc->type = MT_DEVICE;
+
+	pr_info("AT91: sram at 0x%lx of 0x%x mapped at 0x%lx\n",
+		base, length, desc->virtual);
+
+	iotable_init(desc, 1);
+}
+
 static struct map_desc at91_io_desc __initdata = {
 	.virtual	= AT91_VA_BASE_SYS,
 	.pfn		= __phys_to_pfn(AT91_BASE_SYS),
-- 
1.7.4.1
