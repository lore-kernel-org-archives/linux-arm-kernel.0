From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 25 Apr 2011 20:31:12 +0200
Subject: [PATCH 02/14] at91: introduce commom AT91_BASE_SYS
In-Reply-To: <20110425180847.GA12904@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
Message-ID: <1303756284-26529-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

on all at91 except rm9200 and x40 have the System Controller start in reallity
at 0xffffc000 of 16KiB

on rm9200 it's start at 0xfffe4000 of 111KiB with non reserved data starting
at 0xfffff000

so we will use a common AT91_BASE_SYS at 0xffffc000 of 16KiB
and map the same memory space

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/mach-at91/Makefile                   |    2 +-
 arch/arm/mach-at91/at572d940hf.c              |   12 +++---
 arch/arm/mach-at91/at91cap9.c                 |   13 +++---
 arch/arm/mach-at91/at91rm9200.c               |   13 +++---
 arch/arm/mach-at91/at91sam9260.c              |   18 +++-----
 arch/arm/mach-at91/at91sam9261.c              |   18 +++-----
 arch/arm/mach-at91/at91sam9263.c              |   13 +++---
 arch/arm/mach-at91/at91sam9g45.c              |   13 +++---
 arch/arm/mach-at91/at91sam9rl.c               |   18 +++-----
 arch/arm/mach-at91/board-1arm.c               |    2 +-
 arch/arm/mach-at91/board-afeb-9260v1.c        |    2 +-
 arch/arm/mach-at91/board-at572d940hf_ek.c     |    2 +-
 arch/arm/mach-at91/board-cam60.c              |    2 +-
 arch/arm/mach-at91/board-cap9adk.c            |    2 +-
 arch/arm/mach-at91/board-carmeva.c            |    2 +-
 arch/arm/mach-at91/board-cpu9krea.c           |    2 +-
 arch/arm/mach-at91/board-cpuat91.c            |    2 +-
 arch/arm/mach-at91/board-csb337.c             |    2 +-
 arch/arm/mach-at91/board-csb637.c             |    2 +-
 arch/arm/mach-at91/board-eb9200.c             |    2 +-
 arch/arm/mach-at91/board-ecbat91.c            |    2 +-
 arch/arm/mach-at91/board-eco920.c             |    2 +-
 arch/arm/mach-at91/board-flexibity.c          |    2 +-
 arch/arm/mach-at91/board-foxg20.c             |    2 +-
 arch/arm/mach-at91/board-kafa.c               |    2 +-
 arch/arm/mach-at91/board-kb9202.c             |    2 +-
 arch/arm/mach-at91/board-neocore926.c         |    2 +-
 arch/arm/mach-at91/board-picotux200.c         |    2 +-
 arch/arm/mach-at91/board-qil-a9260.c          |    2 +-
 arch/arm/mach-at91/board-rm9200dk.c           |    2 +-
 arch/arm/mach-at91/board-rm9200ek.c           |    2 +-
 arch/arm/mach-at91/board-sam9-l9260.c         |    2 +-
 arch/arm/mach-at91/board-sam9260ek.c          |    2 +-
 arch/arm/mach-at91/board-sam9261ek.c          |    2 +-
 arch/arm/mach-at91/board-sam9263ek.c          |    2 +-
 arch/arm/mach-at91/board-sam9g20ek.c          |    2 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c       |    2 +-
 arch/arm/mach-at91/board-sam9rlek.c           |    2 +-
 arch/arm/mach-at91/board-snapper9260.c        |    2 +-
 arch/arm/mach-at91/board-stamp9g20.c          |    2 +-
 arch/arm/mach-at91/board-usb-a9260.c          |    2 +-
 arch/arm/mach-at91/board-usb-a9263.c          |    2 +-
 arch/arm/mach-at91/board-yl-9200.c            |    2 +-
 arch/arm/mach-at91/generic.h                  |    9 +----
 arch/arm/mach-at91/include/mach/at572d940hf.h |    1 -
 arch/arm/mach-at91/include/mach/at91cap9.h    |    1 -
 arch/arm/mach-at91/include/mach/at91rm9200.h  |    1 -
 arch/arm/mach-at91/include/mach/at91sam9260.h |    1 -
 arch/arm/mach-at91/include/mach/at91sam9261.h |    1 -
 arch/arm/mach-at91/include/mach/at91sam9263.h |    1 -
 arch/arm/mach-at91/include/mach/at91sam9g45.h |    1 -
 arch/arm/mach-at91/include/mach/at91sam9rl.h  |    1 -
 arch/arm/mach-at91/include/mach/hardware.h    |   14 ++++++
 arch/arm/mach-at91/soc.c                      |   57 +++++++++++++++++++++++++
 arch/arm/mach-at91/soc.h                      |   22 ++++++++++
 55 files changed, 184 insertions(+), 114 deletions(-)
 create mode 100644 arch/arm/mach-at91/soc.c
 create mode 100644 arch/arm/mach-at91/soc.h

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index a83835e..eeb5287 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-obj-y		:= irq.o gpio.o
+obj-y		:= irq.o gpio.o soc.o
 obj-m		:=
 obj-n		:=
 obj-		:=
diff --git a/arch/arm/mach-at91/at572d940hf.c b/arch/arm/mach-at91/at572d940hf.c
index a6b9c68..df0d691 100644
--- a/arch/arm/mach-at91/at572d940hf.c
+++ b/arch/arm/mach-at91/at572d940hf.c
@@ -31,16 +31,12 @@
 #include <mach/at91_pmc.h>
 #include <mach/at91_rstc.h>
 
+#include "soc.h"
 #include "generic.h"
 #include "clock.h"
 
 static struct map_desc at572d940hf_io_desc[] __initdata = {
 	{
-		.virtual	= AT91_VA_BASE_SYS,
-		.pfn		= __phys_to_pfn(AT91_BASE_SYS),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= AT91_IO_VIRT_BASE - AT572D940HF_SRAM_SIZE,
 		.pfn		= __phys_to_pfn(AT572D940HF_SRAM_BASE),
 		.length		= AT572D940HF_SRAM_SIZE,
@@ -302,7 +298,7 @@ static void at572d940hf_reset(void)
  *  AT572D940HF processor initialization
  * -------------------------------------------------------------------- */
 
-void __init at572d940hf_initialize(unsigned long main_clock)
+static void __init at572d940hf_initialize(unsigned long main_clock)
 {
 	/* Map peripherals */
 	iotable_init(at572d940hf_io_desc, ARRAY_SIZE(at572d940hf_io_desc));
@@ -375,3 +371,7 @@ void __init at572d940hf_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	at91_gpio_irq_setup();
 }
 
+struct at91_soc __initdata at572d940hf_soc = {
+	.name = "at572d940hf",
+	.init = at572d940hf_initialize,
+};
diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index 7337617..4c06b19 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -25,16 +25,12 @@
 #include <mach/at91_rstc.h>
 #include <mach/at91_shdwc.h>
 
+#include "soc.h"
 #include "generic.h"
 #include "clock.h"
 
 static struct map_desc at91cap9_io_desc[] __initdata = {
 	{
-		.virtual	= AT91_VA_BASE_SYS,
-		.pfn		= __phys_to_pfn(AT91_BASE_SYS),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= AT91_IO_VIRT_BASE - AT91CAP9_SRAM_SIZE,
 		.pfn		= __phys_to_pfn(AT91CAP9_SRAM_BASE),
 		.length		= AT91CAP9_SRAM_SIZE,
@@ -303,7 +299,7 @@ static void at91cap9_poweroff(void)
  *  AT91CAP9 processor initialization
  * -------------------------------------------------------------------- */
 
-void __init at91cap9_initialize(unsigned long main_clock)
+static void __init at91cap9_initialize(unsigned long main_clock)
 {
 	/* Map peripherals */
 	iotable_init(at91cap9_io_desc, ARRAY_SIZE(at91cap9_io_desc));
@@ -381,3 +377,8 @@ void __init at91cap9_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
 }
+
+struct at91_soc __initdata at91cap9_soc = {
+	.name = "at91cap9",
+	.init = at91cap9_initialize,
+};
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 7bdf566..46ae08f 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -20,16 +20,12 @@
 #include <mach/at91_st.h>
 #include <mach/cpu.h>
 
+#include "soc.h"
 #include "generic.h"
 #include "clock.h"
 
 static struct map_desc at91rm9200_io_desc[] __initdata = {
 	{
-		.virtual	= AT91_VA_BASE_SYS,
-		.pfn		= __phys_to_pfn(AT91_BASE_SYS),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= AT91_VA_BASE_EMAC,
 		.pfn		= __phys_to_pfn(AT91RM9200_BASE_EMAC),
 		.length		= SZ_16K,
@@ -278,7 +274,7 @@ void __init at91rm9200_set_type(int type)
 /* --------------------------------------------------------------------
  *  AT91RM9200 processor initialization
  * -------------------------------------------------------------------- */
-void __init at91rm9200_initialize(unsigned long main_clock)
+static void __init at91rm9200_initialize(unsigned long main_clock)
 {
 	/* Map peripherals */
 	iotable_init(at91rm9200_io_desc, ARRAY_SIZE(at91rm9200_io_desc));
@@ -354,3 +350,8 @@ void __init at91rm9200_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
 }
+
+struct at91_soc __initdata at91rm9200_soc = {
+	.name = "at91rm9200",
+	.init = at91rm9200_initialize,
+};
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 32524ef..b1a9aa4 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -22,18 +22,10 @@
 #include <mach/at91_rstc.h>
 #include <mach/at91_shdwc.h>
 
+#include "soc.h"
 #include "generic.h"
 #include "clock.h"
 
-static struct map_desc at91sam9260_io_desc[] __initdata = {
-	{
-		.virtual	= AT91_VA_BASE_SYS,
-		.pfn		= __phys_to_pfn(AT91_BASE_SYS),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}
-};
-
 static struct map_desc at91sam9260_sram_desc[] __initdata = {
 	{
 		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9260_SRAM_SIZE,
@@ -300,10 +292,9 @@ static void __init at91sam9xe_initialize(void)
 	iotable_init(at91sam9xe_sram_desc, ARRAY_SIZE(at91sam9xe_sram_desc));
 }
 
-void __init at91sam9260_initialize(unsigned long main_clock)
+static void __init at91sam9260_initialize(unsigned long main_clock)
 {
 	/* Map peripherals */
-	iotable_init(at91sam9260_io_desc, ARRAY_SIZE(at91sam9260_io_desc));
 
 	if (cpu_is_at91sam9xe())
 		at91sam9xe_initialize();
@@ -380,3 +371,8 @@ void __init at91sam9260_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
 }
+
+struct at91_soc __initdata at91sam9260_soc = {
+	.name = "at91sam9260",
+	.init = at91sam9260_initialize,
+};
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index fcad886..3851e77 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -22,18 +22,10 @@
 #include <mach/at91_rstc.h>
 #include <mach/at91_shdwc.h>
 
+#include "soc.h"
 #include "generic.h"
 #include "clock.h"
 
-static struct map_desc at91sam9261_io_desc[] __initdata = {
-	{
-		.virtual	= AT91_VA_BASE_SYS,
-		.pfn		= __phys_to_pfn(AT91_BASE_SYS),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	},
-};
-
 static struct map_desc at91sam9261_sram_desc[] __initdata = {
 	{
 		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9261_SRAM_SIZE,
@@ -267,10 +259,9 @@ static void at91sam9261_poweroff(void)
  *  AT91SAM9261 processor initialization
  * -------------------------------------------------------------------- */
 
-void __init at91sam9261_initialize(unsigned long main_clock)
+static void __init at91sam9261_initialize(unsigned long main_clock)
 {
 	/* Map peripherals */
-	iotable_init(at91sam9261_io_desc, ARRAY_SIZE(at91sam9261_io_desc));
 
 	if (cpu_is_at91sam9g10())
 		iotable_init(at91sam9g10_sram_desc, ARRAY_SIZE(at91sam9g10_sram_desc));
@@ -346,3 +337,8 @@ void __init at91sam9261_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
 }
+
+struct at91_soc __initdata at91sam9261_soc = {
+	.name = "at91sam9261",
+	.init = at91sam9261_initialize,
+};
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 249f900..481a890 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -21,16 +21,12 @@
 #include <mach/at91_rstc.h>
 #include <mach/at91_shdwc.h>
 
+#include "soc.h"
 #include "generic.h"
 #include "clock.h"
 
 static struct map_desc at91sam9263_io_desc[] __initdata = {
 	{
-		.virtual	= AT91_VA_BASE_SYS,
-		.pfn		= __phys_to_pfn(AT91_BASE_SYS),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9263_SRAM0_SIZE,
 		.pfn		= __phys_to_pfn(AT91SAM9263_SRAM0_BASE),
 		.length		= AT91SAM9263_SRAM0_SIZE,
@@ -279,7 +275,7 @@ static void at91sam9263_poweroff(void)
  *  AT91SAM9263 processor initialization
  * -------------------------------------------------------------------- */
 
-void __init at91sam9263_initialize(unsigned long main_clock)
+static void __init at91sam9263_initialize(unsigned long main_clock)
 {
 	/* Map peripherals */
 	iotable_init(at91sam9263_io_desc, ARRAY_SIZE(at91sam9263_io_desc));
@@ -351,3 +347,8 @@ void __init at91sam9263_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
 }
+
+struct at91_soc __initdata at91sam9263_soc = {
+	.name = "at91sam9263",
+	.init = at91sam9263_initialize,
+};
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index c67b47f..9cb5090 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -22,16 +22,12 @@
 #include <mach/at91_shdwc.h>
 #include <mach/cpu.h>
 
+#include "soc.h"
 #include "generic.h"
 #include "clock.h"
 
 static struct map_desc at91sam9g45_io_desc[] __initdata = {
 	{
-		.virtual	= AT91_VA_BASE_SYS,
-		.pfn		= __phys_to_pfn(AT91_BASE_SYS),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9G45_SRAM_SIZE,
 		.pfn		= __phys_to_pfn(AT91SAM9G45_SRAM_BASE),
 		.length		= AT91SAM9G45_SRAM_SIZE,
@@ -306,7 +302,7 @@ static void at91sam9g45_poweroff(void)
  *  AT91SAM9G45 processor initialization
  * -------------------------------------------------------------------- */
 
-void __init at91sam9g45_initialize(unsigned long main_clock)
+static void __init at91sam9g45_initialize(unsigned long main_clock)
 {
 	/* Map peripherals */
 	iotable_init(at91sam9g45_io_desc, ARRAY_SIZE(at91sam9g45_io_desc));
@@ -378,3 +374,8 @@ void __init at91sam9g45_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
 }
+
+struct at91_soc __initdata at91sam9g45_soc = {
+	.name = "at91sam9g45",
+	.init = at91sam9g45_initialize,
+};
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 6a9d24e..e6f23c3 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -21,18 +21,10 @@
 #include <mach/at91_rstc.h>
 #include <mach/at91_shdwc.h>
 
+#include "soc.h"
 #include "generic.h"
 #include "clock.h"
 
-static struct map_desc at91sam9rl_io_desc[] __initdata = {
-	{
-		.virtual	= AT91_VA_BASE_SYS,
-		.pfn		= __phys_to_pfn(AT91_BASE_SYS),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	},
-};
-
 static struct map_desc at91sam9rl_sram_desc[] __initdata = {
 	{
 		.pfn		= __phys_to_pfn(AT91SAM9RL_SRAM_BASE),
@@ -252,12 +244,11 @@ static void at91sam9rl_poweroff(void)
  *  AT91SAM9RL processor initialization
  * -------------------------------------------------------------------- */
 
-void __init at91sam9rl_initialize(unsigned long main_clock)
+static void __init at91sam9rl_initialize(unsigned long main_clock)
 {
 	unsigned long cidr, sram_size;
 
 	/* Map peripherals */
-	iotable_init(at91sam9rl_io_desc, ARRAY_SIZE(at91sam9rl_io_desc));
 
 	cidr = at91_sys_read(AT91_DBGU_CIDR);
 
@@ -343,3 +334,8 @@ void __init at91sam9rl_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
 }
+
+struct at91_soc __initdata at91sam9rl_soc = {
+	.name = "at91sam9rl",
+	.init = at91sam9rl_initialize,
+};
diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
index d294293..b0d235e 100644
--- a/arch/arm/mach-at91/board-1arm.c
+++ b/arch/arm/mach-at91/board-1arm.c
@@ -46,7 +46,7 @@ static void __init onearm_map_io(void)
 	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
 
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index cba7f77..855c641 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -51,7 +51,7 @@
 static void __init afeb9260_map_io(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91sam9260_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-at572d940hf_ek.c b/arch/arm/mach-at91/board-at572d940hf_ek.c
index 8ad58bd..ca796c2 100644
--- a/arch/arm/mach-at91/board-at572d940hf_ek.c
+++ b/arch/arm/mach-at91/board-at572d940hf_ek.c
@@ -50,7 +50,7 @@
 static void __init eb_map_io(void)
 {
 	/* Initialize processor: 12.500 MHz crystal */
-	at572d940hf_initialize(12000000);
+	at91_initialize(12000000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index b54e3e6..f6b08f0 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -48,7 +48,7 @@
 static void __init cam60_map_io(void)
 {
 	/* Initialize processor: 10 MHz crystal */
-	at91sam9260_initialize(10000000);
+	at91_initialize(10000000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-cap9adk.c b/arch/arm/mach-at91/board-cap9adk.c
index 69aa349..f9138dc 100644
--- a/arch/arm/mach-at91/board-cap9adk.c
+++ b/arch/arm/mach-at91/board-cap9adk.c
@@ -53,7 +53,7 @@
 static void __init cap9adk_map_io(void)
 {
 	/* Initialize processor: 12 MHz crystal */
-	at91cap9_initialize(12000000);
+	at91_initialize(12000000);
 
 	/* Setup the LEDs: USER1 and USER2 LED for cpu/timer... */
 	at91_init_leds(AT91_PIN_PA10, AT91_PIN_PA11);
diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
index ac8f224..f87fd72 100644
--- a/arch/arm/mach-at91/board-carmeva.c
+++ b/arch/arm/mach-at91/board-carmeva.c
@@ -43,7 +43,7 @@
 static void __init carmeva_map_io(void)
 {
 	/* Initialize processor: 20.000 MHz crystal */
-	at91rm9200_initialize(20000000);
+	at91_initialize(20000000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index 3838594..c228d3a 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -50,7 +50,7 @@
 static void __init cpu9krea_map_io(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91sam9260_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* DGBU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
index c25db34..7858e3c 100644
--- a/arch/arm/mach-at91/board-cpuat91.c
+++ b/arch/arm/mach-at91/board-cpuat91.c
@@ -57,7 +57,7 @@ static void __init cpuat91_map_io(void)
 	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
 
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-csb337.c b/arch/arm/mach-at91/board-csb337.c
index 2a3f2f7..a3dd759 100644
--- a/arch/arm/mach-at91/board-csb337.c
+++ b/arch/arm/mach-at91/board-csb337.c
@@ -46,7 +46,7 @@
 static void __init csb337_map_io(void)
 {
 	/* Initialize processor: 3.6864 MHz crystal */
-	at91rm9200_initialize(3686400);
+	at91_initialize(3686400);
 
 	/* Setup the LEDs */
 	at91_init_leds(AT91_PIN_PB0, AT91_PIN_PB1);
diff --git a/arch/arm/mach-at91/board-csb637.c b/arch/arm/mach-at91/board-csb637.c
index d42a7c3..5849ed1 100644
--- a/arch/arm/mach-at91/board-csb637.c
+++ b/arch/arm/mach-at91/board-csb637.c
@@ -43,7 +43,7 @@
 static void __init csb637_map_io(void)
 {
 	/* Initialize processor: 3.6864 MHz crystal */
-	at91rm9200_initialize(3686400);
+	at91_initialize(3686400);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-eb9200.c b/arch/arm/mach-at91/board-eb9200.c
index e732350..1dee160 100644
--- a/arch/arm/mach-at91/board-eb9200.c
+++ b/arch/arm/mach-at91/board-eb9200.c
@@ -43,7 +43,7 @@
 static void __init eb9200_map_io(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index 587ed99..3bfc55a 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -49,7 +49,7 @@ static void __init ecb_at91map_io(void)
 	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
 
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* Setup the LEDs */
 	at91_init_leds(AT91_PIN_PC7, AT91_PIN_PC7);
diff --git a/arch/arm/mach-at91/board-eco920.c b/arch/arm/mach-at91/board-eco920.c
index 5cc591f..85d0742 100644
--- a/arch/arm/mach-at91/board-eco920.c
+++ b/arch/arm/mach-at91/board-eco920.c
@@ -35,7 +35,7 @@ static void __init eco920_map_io(void)
 	/* Set cpu type: PQFP */
 	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
 
-	at91rm9200_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* Setup the LEDs */
 	at91_init_leds(AT91_PIN_PB0, AT91_PIN_PB1);
diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
index c8a62dc..345ba51 100644
--- a/arch/arm/mach-at91/board-flexibity.c
+++ b/arch/arm/mach-at91/board-flexibity.c
@@ -40,7 +40,7 @@
 static void __init flexibity_map_io(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91sam9260_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-foxg20.c b/arch/arm/mach-at91/board-foxg20.c
index dfc7dfe..6948af9 100644
--- a/arch/arm/mach-at91/board-foxg20.c
+++ b/arch/arm/mach-at91/board-foxg20.c
@@ -60,7 +60,7 @@
 static void __init foxg20_map_io(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91sam9260_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
index 1def877..944ad13 100644
--- a/arch/arm/mach-at91/board-kafa.c
+++ b/arch/arm/mach-at91/board-kafa.c
@@ -46,7 +46,7 @@ static void __init kafa_map_io(void)
 	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
 
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* Set up the LEDs */
 	at91_init_leds(AT91_PIN_PB4, AT91_PIN_PB4);
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index ad0fe91..e744e44 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -48,7 +48,7 @@ static void __init kb9202_map_io(void)
 	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
 
 	/* Initialize processor: 10 MHz crystal */
-	at91rm9200_initialize(10000000);
+	at91_initialize(10000000);
 
 	/* Set up the LEDs */
 	at91_init_leds(AT91_PIN_PC19, AT91_PIN_PC18);
diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index fe5f1d4..2bd4cda 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -54,7 +54,7 @@
 static void __init neocore926_map_io(void)
 {
 	/* Initialize processor: 20 MHz crystal */
-	at91sam9263_initialize(20000000);
+	at91_initialize(20000000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index c153863..d22b1a3 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -46,7 +46,7 @@
 static void __init picotux200_map_io(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index 69d15a8..d977e7e 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -51,7 +51,7 @@
 static void __init ek_map_io(void)
 {
 	/* Initialize processor: 12.000 MHz crystal */
-	at91sam9260_initialize(12000000);
+	at91_initialize(12000000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index b8f3b3d..0175eef 100644
--- a/arch/arm/mach-at91/board-rm9200dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -48,7 +48,7 @@
 static void __init dk_map_io(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* Setup the LEDs */
 	at91_init_leds(AT91_PIN_PB2, AT91_PIN_PB2);
diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index b55edc6..882d016 100644
--- a/arch/arm/mach-at91/board-rm9200ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -48,7 +48,7 @@
 static void __init ek_map_io(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* Setup the LEDs */
 	at91_init_leds(AT91_PIN_PB1, AT91_PIN_PB2);
diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
index 25a26be..36f765a 100644
--- a/arch/arm/mach-at91/board-sam9-l9260.c
+++ b/arch/arm/mach-at91/board-sam9-l9260.c
@@ -47,7 +47,7 @@
 static void __init ek_map_io(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91sam9260_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* Setup the LEDs */
 	at91_init_leds(AT91_PIN_PA9, AT91_PIN_PA6);
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index fb05ec0..cc864a9 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -53,7 +53,7 @@
 static void __init ek_map_io(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91sam9260_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index a0b182e..010636c 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -57,7 +57,7 @@
 static void __init ek_map_io(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91sam9261_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* Setup the LEDs */
 	at91_init_leds(AT91_PIN_PA13, AT91_PIN_PA14);
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index 3c9cbd8..0c3a54d 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -56,7 +56,7 @@
 static void __init ek_map_io(void)
 {
 	/* Initialize processor: 16.367 MHz crystal */
-	at91sam9263_initialize(16367660);
+	at91_initialize(16367660);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 2de10ca..74676c6 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -64,7 +64,7 @@ static int inline ek_have_2mmc(void)
 static void __init ek_map_io(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91sam9260_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index 200e155..15ccaad 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -50,7 +50,7 @@
 static void __init ek_map_io(void)
 {
 	/* Initialize processor: 12.000 MHz crystal */
-	at91sam9g45_initialize(12000000);
+	at91_initialize(12000000);
 
 	/* DGBU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index 3bf3408..7b232b3 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -41,7 +41,7 @@
 static void __init ek_map_io(void)
 {
 	/* Initialize processor: 12.000 MHz crystal */
-	at91sam9rl_initialize(12000000);
+	at91_initialize(12000000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
index 17f7d9b..db5e67a 100644
--- a/arch/arm/mach-at91/board-snapper9260.c
+++ b/arch/arm/mach-at91/board-snapper9260.c
@@ -42,7 +42,7 @@
 
 static void __init snapper9260_map_io(void)
 {
-	at91sam9260_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* Debug on ttyS0 */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index f8902b1..bd0c8ce 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -35,7 +35,7 @@
 void __init stamp9g20_map_io(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91sam9260_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* DGBU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-usb-a9260.c b/arch/arm/mach-at91/board-usb-a9260.c
index 07784ba..8b0955f 100644
--- a/arch/arm/mach-at91/board-usb-a9260.c
+++ b/arch/arm/mach-at91/board-usb-a9260.c
@@ -51,7 +51,7 @@
 static void __init ek_map_io(void)
 {
 	/* Initialize processor: 12.000 MHz crystal */
-	at91sam9260_initialize(12000000);
+	at91_initialize(12000000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-usb-a9263.c b/arch/arm/mach-at91/board-usb-a9263.c
index b6145089..5b2a7bb 100644
--- a/arch/arm/mach-at91/board-usb-a9263.c
+++ b/arch/arm/mach-at91/board-usb-a9263.c
@@ -50,7 +50,7 @@
 static void __init ek_map_io(void)
 {
 	/* Initialize processor: 12.00 MHz crystal */
-	at91sam9263_initialize(12000000);
+	at91_initialize(12000000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index 097328b..b473252 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -56,7 +56,7 @@ static void __init yl9200_map_io(void)
 	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
 
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* Setup the LEDs D2=PB17 (timer), D3=PB16 (cpu) */
 	at91_init_leds(AT91_PIN_PB16, AT91_PIN_PB17);
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 87ec31d..e1a5007 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -10,15 +10,8 @@
 
  /* Processors */
 extern void __init at91rm9200_set_type(int type);
-extern void __init at91rm9200_initialize(unsigned long main_clock);
-extern void __init at91sam9260_initialize(unsigned long main_clock);
-extern void __init at91sam9261_initialize(unsigned long main_clock);
-extern void __init at91sam9263_initialize(unsigned long main_clock);
-extern void __init at91sam9rl_initialize(unsigned long main_clock);
-extern void __init at91sam9g45_initialize(unsigned long main_clock);
+extern void __init at91_initialize(unsigned long main_clock);
 extern void __init at91x40_initialize(unsigned long main_clock);
-extern void __init at91cap9_initialize(unsigned long main_clock);
-extern void __init at572d940hf_initialize(unsigned long main_clock);
 
  /* Interrupts */
 extern void __init at91rm9200_init_interrupts(unsigned int priority[]);
diff --git a/arch/arm/mach-at91/include/mach/at572d940hf.h b/arch/arm/mach-at91/include/mach/at572d940hf.h
index be510cf..2dc22d3 100644
--- a/arch/arm/mach-at91/include/mach/at572d940hf.h
+++ b/arch/arm/mach-at91/include/mach/at572d940hf.h
@@ -83,7 +83,6 @@
 #define AT572D940HF_BASE_EMAC	0xfffd8000
 #define AT572D940HF_BASE_CAN0	0xfffdc000
 #define AT572D940HF_BASE_CAN1	0xfffe0000
-#define AT91_BASE_SYS		0xffffea00
 
 
 /*
diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
index 9c6af97..adac25a 100644
--- a/arch/arm/mach-at91/include/mach/at91cap9.h
+++ b/arch/arm/mach-at91/include/mach/at91cap9.h
@@ -77,7 +77,6 @@
 #define AT91CAP9_BASE_EMAC		0xfffbc000
 #define AT91CAP9_BASE_ADC		0xfffc0000
 #define AT91CAP9_BASE_ISI		0xfffc4000
-#define AT91_BASE_SYS			0xffffe200
 
 /*
  * System Peripherals (offset from AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91rm9200.h b/arch/arm/mach-at91/include/mach/at91rm9200.h
index 7898315..aedc28f 100644
--- a/arch/arm/mach-at91/include/mach/at91rm9200.h
+++ b/arch/arm/mach-at91/include/mach/at91rm9200.h
@@ -76,7 +76,6 @@
 #define AT91RM9200_BASE_SSC1	0xfffd4000
 #define AT91RM9200_BASE_SSC2	0xfffd8000
 #define AT91RM9200_BASE_SPI	0xfffe0000
-#define AT91_BASE_SYS		0xfffff000
 
 
 /*
diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
index 6c53b95..6da5ce6 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9260.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
@@ -78,7 +78,6 @@
 #define AT91SAM9260_BASE_TC4		0xfffdc040
 #define AT91SAM9260_BASE_TC5		0xfffdc080
 #define AT91SAM9260_BASE_ADC		0xfffe0000
-#define AT91_BASE_SYS			0xffffe800
 
 /*
  * System Peripherals (offset from AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91sam9261.h b/arch/arm/mach-at91/include/mach/at91sam9261.h
index 2b56185..6c4ea40 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9261.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9261.h
@@ -62,7 +62,6 @@
 #define AT91SAM9261_BASE_SSC2		0xfffc4000
 #define AT91SAM9261_BASE_SPI0		0xfffc8000
 #define AT91SAM9261_BASE_SPI1		0xfffcc000
-#define AT91_BASE_SYS			0xffffea00
 
 
 /*
diff --git a/arch/arm/mach-at91/include/mach/at91sam9263.h b/arch/arm/mach-at91/include/mach/at91sam9263.h
index 2091f1e..1572453 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9263.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9263.h
@@ -72,7 +72,6 @@
 #define AT91SAM9263_BASE_EMAC		0xfffbc000
 #define AT91SAM9263_BASE_ISI		0xfffc4000
 #define AT91SAM9263_BASE_2DGE		0xfffc8000
-#define AT91_BASE_SYS			0xffffe000
 
 /*
  * System Peripherals (offset from AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
index a526869..b00cc18 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
@@ -84,7 +84,6 @@
 #define AT91SAM9G45_BASE_TC3		0xfffd4000
 #define AT91SAM9G45_BASE_TC4		0xfffd4040
 #define AT91SAM9G45_BASE_TC5		0xfffd4080
-#define AT91_BASE_SYS			0xffffe200
 
 /*
  * System Peripherals (offset from AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
index 87ba851..b6c18c7 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
@@ -66,7 +66,6 @@
 #define AT91SAM9RL_BASE_TSC	0xfffd0000
 #define AT91SAM9RL_BASE_UDPHS	0xfffd4000
 #define AT91SAM9RL_BASE_AC97C	0xfffd8000
-#define AT91_BASE_SYS		0xffffc000
 
 
 /*
diff --git a/arch/arm/mach-at91/include/mach/hardware.h b/arch/arm/mach-at91/include/mach/hardware.h
index 3d64a75..b7ff44a 100644
--- a/arch/arm/mach-at91/include/mach/hardware.h
+++ b/arch/arm/mach-at91/include/mach/hardware.h
@@ -16,6 +16,20 @@
 
 #include <asm/sizes.h>
 
+#if !defined(CONFIG_ARCH_AT91X40)
+/*
+ * on all at91 except rm9200 and x40 have the System Controller start in reallity
+ * at 0xffffc000 of 16KiB
+ *
+ * on rm9200 it's start at 0xfffe4000 of 111KiB with non reserved data starting
+ * at 0xfffff000
+ *
+ * so we will use a common AT91_BASE_SYS at 0xffffc000 of 16KiB
+ * and map the same memory space
+ */
+#define AT91_BASE_SYS	0xffffc000
+#endif
+
 #if defined(CONFIG_ARCH_AT91RM9200)
 #include <mach/at91rm9200.h>
 #elif defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM9G20)
diff --git a/arch/arm/mach-at91/soc.c b/arch/arm/mach-at91/soc.c
new file mode 100644
index 0000000..81f5815
--- /dev/null
+++ b/arch/arm/mach-at91/soc.c
@@ -0,0 +1,57 @@
+/*
+ *
+ * Copyright (C) 2007 Atmel Corporation.
+ * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Under GPLv2
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/io.h>
+
+#include <asm/mach/map.h>
+
+#include <mach/hardware.h>
+#include <mach/cpu.h>
+
+#include "soc.h"
+#include "generic.h"
+
+static struct at91_soc __initdata current_soc;
+
+static struct map_desc at91_io_desc __initdata = {
+	.virtual	= AT91_VA_BASE_SYS,
+	.pfn		= __phys_to_pfn(AT91_BASE_SYS),
+	.length		= SZ_16K,
+	.type		= MT_DEVICE,
+};
+
+void __init at91_initialize(unsigned long main_clock)
+{
+	/* Map peripherals */
+	iotable_init(&at91_io_desc, 1);
+
+	if (cpu_is_at91rm9200())
+		current_soc = at91rm9200_soc;
+	else if (cpu_is_at91sam9260())
+		current_soc = at91sam9260_soc;
+	else if (cpu_is_at91sam9261())
+		current_soc = at91sam9261_soc;
+	else if (cpu_is_at91sam9263())
+		current_soc = at91sam9263_soc;
+	else if (cpu_is_at91sam9rl())
+		current_soc = at91sam9rl_soc;
+	else if (cpu_is_at91sam9g45())
+		current_soc = at91sam9g45_soc;
+	else if (cpu_is_at91cap9())
+		current_soc = at91cap9_soc;
+	else if (cpu_is_at572d940hf())
+		current_soc = at572d940hf_soc;
+	else
+		panic("Impossible to detect the CPU type");
+
+	pr_info("AT91: detected soc: %s\n", current_soc.name);
+
+	current_soc.init(main_clock);
+}
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
new file mode 100644
index 0000000..6c30d74
--- /dev/null
+++ b/arch/arm/mach-at91/soc.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2007 Atmel Corporation.
+ * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Under GPLv2
+ *
+ */
+
+struct at91_soc {
+	char *name;
+
+	void (*init)(unsigned long main_clock);
+};
+
+extern struct at91_soc at91rm9200_soc;
+extern struct at91_soc at91sam9260_soc;
+extern struct at91_soc at91sam9261_soc;
+extern struct at91_soc at91sam9263_soc;
+extern struct at91_soc at91sam9rl_soc;
+extern struct at91_soc at91sam9g45_soc;
+extern struct at91_soc at91cap9_soc;
+extern struct at91_soc at572d940hf_soc;
-- 
1.7.4.1
