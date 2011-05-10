From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 10 May 2011 18:34:12 +0200
Subject: [PATCH 2/9] at91: introduce commom AT91_BASE_SYS
In-Reply-To: <20110510162730.GA18929@game.jcrosoft.org>
References: <20110510162730.GA18929@game.jcrosoft.org>
Message-ID: <1305045259-23066-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On all at91 except rm9200 and x40 have the System Controller starts
at address 0xffffc000 and has a size of 16KiB.

On rm9200 it's start at 0xfffe4000 of 111KiB with non reserved data starting
at 0xfffff000

This patch removes the individual definitions of AT91_BASE_SYS and
replaces them with a common version at base 0xfffffc000 and size 16KiB
and map the same memory space

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/mach-at91/Makefile                   |    2 +-
 arch/arm/mach-at91/at572d940hf.c              |   19 ++++----
 arch/arm/mach-at91/at91cap9.c                 |   21 ++++----
 arch/arm/mach-at91/at91rm9200.c               |   15 +++---
 arch/arm/mach-at91/at91sam9260.c              |   22 +++-----
 arch/arm/mach-at91/at91sam9261.c              |   22 +++-----
 arch/arm/mach-at91/at91sam9263.c              |   20 ++++----
 arch/arm/mach-at91/at91sam9g45.c              |   20 ++++----
 arch/arm/mach-at91/at91sam9rl.c               |   22 +++-----
 arch/arm/mach-at91/board-1arm.c               |    4 +-
 arch/arm/mach-at91/board-afeb-9260v1.c        |    4 +-
 arch/arm/mach-at91/board-at572d940hf_ek.c     |    4 +-
 arch/arm/mach-at91/board-cam60.c              |    4 +-
 arch/arm/mach-at91/board-cap9adk.c            |    4 +-
 arch/arm/mach-at91/board-carmeva.c            |    4 +-
 arch/arm/mach-at91/board-cpu9krea.c           |    4 +-
 arch/arm/mach-at91/board-cpuat91.c            |    4 +-
 arch/arm/mach-at91/board-csb337.c             |    4 +-
 arch/arm/mach-at91/board-csb637.c             |    4 +-
 arch/arm/mach-at91/board-eb9200.c             |    4 +-
 arch/arm/mach-at91/board-ecbat91.c            |    4 +-
 arch/arm/mach-at91/board-eco920.c             |    4 +-
 arch/arm/mach-at91/board-flexibity.c          |    4 +-
 arch/arm/mach-at91/board-foxg20.c             |    4 +-
 arch/arm/mach-at91/board-gsia18s.c            |    2 +-
 arch/arm/mach-at91/board-kafa.c               |    4 +-
 arch/arm/mach-at91/board-kb9202.c             |    4 +-
 arch/arm/mach-at91/board-neocore926.c         |    4 +-
 arch/arm/mach-at91/board-pcontrol-g20.c       |    2 +-
 arch/arm/mach-at91/board-picotux200.c         |    4 +-
 arch/arm/mach-at91/board-qil-a9260.c          |    4 +-
 arch/arm/mach-at91/board-rm9200dk.c           |    4 +-
 arch/arm/mach-at91/board-rm9200ek.c           |    4 +-
 arch/arm/mach-at91/board-sam9-l9260.c         |    4 +-
 arch/arm/mach-at91/board-sam9260ek.c          |    4 +-
 arch/arm/mach-at91/board-sam9261ek.c          |    4 +-
 arch/arm/mach-at91/board-sam9263ek.c          |    4 +-
 arch/arm/mach-at91/board-sam9g20ek.c          |    6 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c       |    4 +-
 arch/arm/mach-at91/board-sam9rlek.c           |    4 +-
 arch/arm/mach-at91/board-snapper9260.c        |    4 +-
 arch/arm/mach-at91/board-stamp9g20.c          |    6 +-
 arch/arm/mach-at91/board-usb-a9260.c          |    4 +-
 arch/arm/mach-at91/board-usb-a9263.c          |    4 +-
 arch/arm/mach-at91/board-yl-9200.c            |    4 +-
 arch/arm/mach-at91/generic.h                  |   19 +-------
 arch/arm/mach-at91/include/mach/at572d940hf.h |    1 -
 arch/arm/mach-at91/include/mach/at91cap9.h    |    1 -
 arch/arm/mach-at91/include/mach/at91rm9200.h  |    1 -
 arch/arm/mach-at91/include/mach/at91sam9260.h |    1 -
 arch/arm/mach-at91/include/mach/at91sam9261.h |    1 -
 arch/arm/mach-at91/include/mach/at91sam9263.h |    1 -
 arch/arm/mach-at91/include/mach/at91sam9g45.h |    1 -
 arch/arm/mach-at91/include/mach/at91sam9rl.h  |    1 -
 arch/arm/mach-at91/include/mach/hardware.h    |   14 +++++
 arch/arm/mach-at91/setup.c                    |   65 +++++++++++++++++++++++++
 arch/arm/mach-at91/soc.h                      |   21 ++++++++
 57 files changed, 246 insertions(+), 188 deletions(-)
 create mode 100644 arch/arm/mach-at91/setup.c
 create mode 100644 arch/arm/mach-at91/soc.h

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index a83835e..311b7d1 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-obj-y		:= irq.o gpio.o
+obj-y		:= irq.o gpio.o setup.o
 obj-m		:=
 obj-n		:=
 obj-		:=
diff --git a/arch/arm/mach-at91/at572d940hf.c b/arch/arm/mach-at91/at572d940hf.c
index 5c6af40..1b5b320 100644
--- a/arch/arm/mach-at91/at572d940hf.c
+++ b/arch/arm/mach-at91/at572d940hf.c
@@ -31,16 +31,12 @@
 #include <mach/at91_pmc.h>
 #include <mach/at91_rstc.h>
 
+#include "soc.h"
 #include "generic.h"
 #include "clock.h"
 
-static struct map_desc at572d940hf_io_desc[] __initdata = {
+static struct map_desc at572d940hf_sram_desc[] __initdata = {
 	{
-		.virtual	= AT91_VA_BASE_SYS,
-		.pfn		= __phys_to_pfn(AT91_BASE_SYS),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= AT91_IO_VIRT_BASE - AT572D940HF_SRAM_SIZE,
 		.pfn		= __phys_to_pfn(AT572D940HF_SRAM_BASE),
 		.length		= AT572D940HF_SRAM_SIZE,
@@ -366,13 +362,12 @@ static void at572d940hf_reset(void)
  *  AT572D940HF processor initialization
  * -------------------------------------------------------------------- */
 
-void __init at572d940hf_map_io(void)
+static void __init at572d940hf_map_io(void)
 {
-	/* Map peripherals */
-	iotable_init(at572d940hf_io_desc, ARRAY_SIZE(at572d940hf_io_desc));
+	iotable_init(at572d940hf_sram_desc, ARRAY_SIZE(at572d940hf_sram_desc));
 }
 
-void __init at572d940hf_initialize(unsigned long main_clock)
+static void __init at572d940hf_initialize(unsigned long main_clock)
 {
 	at91_arch_reset = at572d940hf_reset;
 	at91_extern_irq = (1 << AT572D940HF_ID_IRQ0) | (1 << AT572D940HF_ID_IRQ1)
@@ -442,3 +437,7 @@ void __init at572d940hf_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	at91_gpio_irq_setup();
 }
 
+struct at91_soc __initdata at572d940hf_soc = {
+	.map_io = at572d940hf_map_io,
+	.init = at572d940hf_initialize,
+};
diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index 794e036..cc32ac8 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -25,16 +25,12 @@
 #include <mach/at91_rstc.h>
 #include <mach/at91_shdwc.h>
 
+#include "soc.h"
 #include "generic.h"
 #include "clock.h"
 
-static struct map_desc at91cap9_io_desc[] __initdata = {
+static struct map_desc at91cap9_sram_desc[] __initdata = {
 	{
-		.virtual	= AT91_VA_BASE_SYS,
-		.pfn		= __phys_to_pfn(AT91_BASE_SYS),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= AT91_IO_VIRT_BASE - AT91CAP9_SRAM_SIZE,
 		.pfn		= __phys_to_pfn(AT91CAP9_SRAM_BASE),
 		.length		= AT91CAP9_SRAM_SIZE,
@@ -361,14 +357,12 @@ static void at91cap9_poweroff(void)
  *  AT91CAP9 processor initialization
  * -------------------------------------------------------------------- */
 
-void __init at91cap9_map_io(void)
+static void __init at91cap9_map_io(void)
 {
-	/* Map peripherals */
-	iotable_init(at91cap9_io_desc, ARRAY_SIZE(at91cap9_io_desc));
+	iotable_init(at91cap9_sram_desc, ARRAY_SIZE(at91cap9_sram_desc));
 }
 
-void __init at91cap9_initialize(unsigned long main_clock)
-{
+static void __init at91cap9_initialize(unsigned long main_clock)
 	at91_arch_reset = at91cap9_reset;
 	pm_power_off = at91cap9_poweroff;
 	at91_extern_irq = (1 << AT91CAP9_ID_IRQ0) | (1 << AT91CAP9_ID_IRQ1);
@@ -442,3 +436,8 @@ void __init at91cap9_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
 }
+
+struct at91_soc __initdata at91cap9_soc = {
+	.map_io = at91cap9_map_io,
+	.init = at91cap9_initialize,
+};
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index a67143a..382354f 100644
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
@@ -328,13 +324,13 @@ void __init at91rm9200_set_type(int type)
 /* --------------------------------------------------------------------
  *  AT91RM9200 processor initialization
  * -------------------------------------------------------------------- */
-void __init at91rm9200_map_io(void)
+static void __init at91rm9200_map_io(void)
 {
 	/* Map peripherals */
 	iotable_init(at91rm9200_io_desc, ARRAY_SIZE(at91rm9200_io_desc));
 }
 
-void __init at91rm9200_initialize(unsigned long main_clock)
+static void __init at91rm9200_initialize(unsigned long main_clock)
 {
 	at91_arch_reset = at91rm9200_reset;
 	at91_extern_irq = (1 << AT91RM9200_ID_IRQ0) | (1 << AT91RM9200_ID_IRQ1)
@@ -407,3 +403,8 @@ void __init at91rm9200_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
 }
+
+struct at91_soc __initdata at91rm9200_soc = {
+	.map_io = at91rm9200_map_io,
+	.init = at91rm9200_initialize,
+};
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index edaec71..11b73e0 100644
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
 		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9260_SRAM0_SIZE,
@@ -361,11 +353,8 @@ static void __init at91sam9xe_map_io(void)
 	iotable_init(at91sam9xe_sram_desc, ARRAY_SIZE(at91sam9xe_sram_desc));
 }
 
-void __init at91sam9260_map_io(void)
+static void __init at91sam9260_map_io(void)
 {
-	/* Map peripherals */
-	iotable_init(at91sam9260_io_desc, ARRAY_SIZE(at91sam9260_io_desc));
-
 	if (cpu_is_at91sam9xe())
 		at91sam9xe_map_io();
 	else if (cpu_is_at91sam9g20())
@@ -374,7 +363,7 @@ void __init at91sam9260_map_io(void)
 		iotable_init(at91sam9260_sram_desc, ARRAY_SIZE(at91sam9260_sram_desc));
 }
 
-void __init at91sam9260_initialize(unsigned long main_clock)
+static void __init at91sam9260_initialize(unsigned long main_clock)
 {
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9260_poweroff;
@@ -444,3 +433,8 @@ void __init at91sam9260_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
 }
+
+struct at91_soc __initdata at91sam9260_soc = {
+	.map_io = at91sam9260_map_io,
+	.init = at91sam9260_initialize,
+};
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index d2e5fee..42eca26 100644
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
@@ -322,18 +314,15 @@ static void at91sam9261_poweroff(void)
  *  AT91SAM9261 processor initialization
  * -------------------------------------------------------------------- */
 
-void __init at91sam9261_map_io(void)
+static void __init at91sam9261_map_io(void)
 {
-	/* Map peripherals */
-	iotable_init(at91sam9261_io_desc, ARRAY_SIZE(at91sam9261_io_desc));
-
 	if (cpu_is_at91sam9g10())
 		iotable_init(at91sam9g10_sram_desc, ARRAY_SIZE(at91sam9g10_sram_desc));
 	else
 		iotable_init(at91sam9261_sram_desc, ARRAY_SIZE(at91sam9261_sram_desc));
 }
 
-void __init at91sam9261_initialize(unsigned long main_clock)
+static void __init at91sam9261_initialize(unsigned long main_clock)
 {
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9261_poweroff;
@@ -403,3 +392,8 @@ void __init at91sam9261_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
 }
+
+struct at91_soc __initdata at91sam9261_soc = {
+	.map_io = at91sam9261_map_io,
+	.init = at91sam9261_initialize,
+};
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 9502bfd..6515897 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -21,16 +21,12 @@
 #include <mach/at91_rstc.h>
 #include <mach/at91_shdwc.h>
 
+#include "soc.h"
 #include "generic.h"
 #include "clock.h"
 
-static struct map_desc at91sam9263_io_desc[] __initdata = {
+static struct map_desc at91sam9263_sram_desc[] __initdata = {
 	{
-		.virtual	= AT91_VA_BASE_SYS,
-		.pfn		= __phys_to_pfn(AT91_BASE_SYS),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9263_SRAM0_SIZE,
 		.pfn		= __phys_to_pfn(AT91SAM9263_SRAM0_BASE),
 		.length		= AT91SAM9263_SRAM0_SIZE,
@@ -333,13 +329,12 @@ static void at91sam9263_poweroff(void)
  *  AT91SAM9263 processor initialization
  * -------------------------------------------------------------------- */
 
-void __init at91sam9263_map_io(void)
+static void __init at91sam9263_map_io(void)
 {
-	/* Map peripherals */
-	iotable_init(at91sam9263_io_desc, ARRAY_SIZE(at91sam9263_io_desc));
+	iotable_init(at91sam9263_sram_desc, ARRAY_SIZE(at91sam9263_sram_desc));
 }
 
-void __init at91sam9263_initialize(unsigned long main_clock)
+static void __init at91sam9263_initialize(unsigned long main_clock)
 {
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9263_poweroff;
@@ -408,3 +403,8 @@ void __init at91sam9263_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
 }
+
+struct at91_soc __initdata at91sam9263_soc = {
+	.map_io = at91sam9263_map_io,
+	.init = at91sam9263_initialize,
+};
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 3db8132..a5f1473 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -22,16 +22,12 @@
 #include <mach/at91_shdwc.h>
 #include <mach/cpu.h>
 
+#include "soc.h"
 #include "generic.h"
 #include "clock.h"
 
-static struct map_desc at91sam9g45_io_desc[] __initdata = {
+static struct map_desc at91sam9g45_sram_desc[] __initdata = {
 	{
-		.virtual	= AT91_VA_BASE_SYS,
-		.pfn		= __phys_to_pfn(AT91_BASE_SYS),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9G45_SRAM_SIZE,
 		.pfn		= __phys_to_pfn(AT91SAM9G45_SRAM_BASE),
 		.length		= AT91SAM9G45_SRAM_SIZE,
@@ -352,13 +348,12 @@ static void at91sam9g45_poweroff(void)
  *  AT91SAM9G45 processor initialization
  * -------------------------------------------------------------------- */
 
-void __init at91sam9g45_map_io(void)
+static void __init at91sam9g45_map_io(void)
 {
-	/* Map peripherals */
-	iotable_init(at91sam9g45_io_desc, ARRAY_SIZE(at91sam9g45_io_desc));
+	iotable_init(at91sam9g45_sram_desc, ARRAY_SIZE(at91sam9g45_sram_desc));
 }
 
-void __init at91sam9g45_initialize(unsigned long main_clock)
+static void __init at91sam9g45_initialize(unsigned long main_clock)
 {
 	at91_arch_reset = at91sam9g45_reset;
 	pm_power_off = at91sam9g45_poweroff;
@@ -427,3 +422,8 @@ void __init at91sam9g45_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
 }
+
+struct at91_soc __initdata at91sam9g45_soc = {
+	.map_io = at91sam9g45_map_io,
+	.init = at91sam9g45_initialize,
+};
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index d2f521e..77a20ef 100644
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
@@ -303,13 +295,10 @@ static void at91sam9rl_poweroff(void)
  *  AT91SAM9RL processor initialization
  * -------------------------------------------------------------------- */
 
-void __init at91sam9rl_map_io(void)
+static void __init at91sam9rl_map_io(void)
 {
 	unsigned long cidr, sram_size;
 
-	/* Map peripherals */
-	iotable_init(at91sam9rl_io_desc, ARRAY_SIZE(at91sam9rl_io_desc));
-
 	cidr = at91_sys_read(AT91_DBGU_CIDR);
 
 	switch (cidr & AT91_CIDR_SRAMSIZ) {
@@ -328,7 +317,7 @@ void __init at91sam9rl_map_io(void)
 	iotable_init(at91sam9rl_sram_desc, ARRAY_SIZE(at91sam9rl_sram_desc));
 }
 
-void __init at91sam9rl_initialize(unsigned long main_clock)
+static void __init at91sam9rl_initialize(unsigned long main_clock)
 {
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9rl_poweroff;
@@ -397,3 +386,8 @@ void __init at91sam9rl_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
 }
+
+struct at91_soc __initdata at91sam9rl_soc = {
+	.map_io = at91sam9rl_map_io,
+	.init = at91sam9rl_initialize,
+};
diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
index ab1d463..e588a9e 100644
--- a/arch/arm/mach-at91/board-1arm.c
+++ b/arch/arm/mach-at91/board-1arm.c
@@ -46,7 +46,7 @@ static void __init onearm_init_early(void)
 	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
 
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
@@ -97,7 +97,7 @@ static void __init onearm_board_init(void)
 MACHINE_START(ONEARM, "Ajeco 1ARM single board computer")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.timer		= &at91rm9200_timer,
-	.map_io		= at91rm9200_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= onearm_init_early,
 	.init_irq	= onearm_init_irq,
 	.init_machine	= onearm_board_init,
diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index a4924de..7cd1cb2 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -51,7 +51,7 @@
 static void __init afeb9260_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91sam9260_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
@@ -219,7 +219,7 @@ static void __init afeb9260_board_init(void)
 MACHINE_START(AFEB9260, "Custom afeb9260 board")
 	/* Maintainer: Sergey Lapin <slapin@ossfans.org> */
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91sam9260_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= afeb9260_init_early,
 	.init_irq	= afeb9260_init_irq,
 	.init_machine	= afeb9260_board_init,
diff --git a/arch/arm/mach-at91/board-at572d940hf_ek.c b/arch/arm/mach-at91/board-at572d940hf_ek.c
index dfa896d..f263aa8 100644
--- a/arch/arm/mach-at91/board-at572d940hf_ek.c
+++ b/arch/arm/mach-at91/board-at572d940hf_ek.c
@@ -50,7 +50,7 @@
 static void __init eb_init_early(void)
 {
 	/* Initialize processor: 12.500 MHz crystal */
-	at572d940hf_initialize(12000000);
+	at91_initialize(12000000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
@@ -316,7 +316,7 @@ static void __init eb_board_init(void)
 MACHINE_START(AT572D940HFEB, "Atmel AT91D940HF-EB")
 	/* Maintainer: Atmel <costa.antonior@gmail.com> */
 	.timer		= &at91sam926x_timer,
-	.map_io		= at572d940hf_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= eb_init_early,
 	.init_irq	= eb_init_irq,
 	.init_machine	= eb_board_init,
diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index 148fccb..bdc52e6 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -48,7 +48,7 @@
 static void __init cam60_init_early(void)
 {
 	/* Initialize processor: 10 MHz crystal */
-	at91sam9260_initialize(10000000);
+	at91_initialize(10000000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
@@ -199,7 +199,7 @@ static void __init cam60_board_init(void)
 MACHINE_START(CAM60, "KwikByte CAM60")
 	/* Maintainer: KwikByte */
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91sam9260_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= cam60_init_early,
 	.init_irq	= cam60_init_irq,
 	.init_machine	= cam60_board_init,
diff --git a/arch/arm/mach-at91/board-cap9adk.c b/arch/arm/mach-at91/board-cap9adk.c
index 1904fdf..dfafdf9 100644
--- a/arch/arm/mach-at91/board-cap9adk.c
+++ b/arch/arm/mach-at91/board-cap9adk.c
@@ -53,7 +53,7 @@
 static void __init cap9adk_init_early(void)
 {
 	/* Initialize processor: 12 MHz crystal */
-	at91cap9_initialize(12000000);
+	at91_initialize(12000000);
 
 	/* Setup the LEDs: USER1 and USER2 LED for cpu/timer... */
 	at91_init_leds(AT91_PIN_PA10, AT91_PIN_PA11);
@@ -397,7 +397,7 @@ static void __init cap9adk_board_init(void)
 MACHINE_START(AT91CAP9ADK, "Atmel AT91CAP9A-DK")
 	/* Maintainer: Stelian Pop <stelian.pop@leadtechdesign.com> */
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91cap9_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= cap9adk_init_early,
 	.init_irq	= cap9adk_init_irq,
 	.init_machine	= cap9adk_board_init,
diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
index f36b186..0a92b7a 100644
--- a/arch/arm/mach-at91/board-carmeva.c
+++ b/arch/arm/mach-at91/board-carmeva.c
@@ -43,7 +43,7 @@
 static void __init carmeva_init_early(void)
 {
 	/* Initialize processor: 20.000 MHz crystal */
-	at91rm9200_initialize(20000000);
+	at91_initialize(20000000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
@@ -163,7 +163,7 @@ static void __init carmeva_board_init(void)
 MACHINE_START(CARMEVA, "Carmeva")
 	/* Maintainer: Conitec Datasystems */
 	.timer		= &at91rm9200_timer,
-	.map_io		= at91rm9200_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= carmeva_init_early,
 	.init_irq	= carmeva_init_irq,
 	.init_machine	= carmeva_board_init,
diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index 9805110..01128f9 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -50,7 +50,7 @@
 static void __init cpu9krea_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91sam9260_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* DGBU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
@@ -376,7 +376,7 @@ MACHINE_START(CPUAT9G20, "Eukrea CPU9G20")
 #endif
 	/* Maintainer: Eric Benard - EUKREA Electromatique */
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91sam9260_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= cpu9krea_init_early,
 	.init_irq	= cpu9krea_init_irq,
 	.init_machine	= cpu9krea_board_init,
diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
index 6daabe3..0692606 100644
--- a/arch/arm/mach-at91/board-cpuat91.c
+++ b/arch/arm/mach-at91/board-cpuat91.c
@@ -57,7 +57,7 @@ static void __init cpuat91_init_early(void)
 	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
 
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
@@ -180,7 +180,7 @@ static void __init cpuat91_board_init(void)
 MACHINE_START(CPUAT91, "Eukrea")
 	/* Maintainer: Eric Benard - EUKREA Electromatique */
 	.timer		= &at91rm9200_timer,
-	.map_io		= at91rm9200_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= cpuat91_init_early,
 	.init_irq	= cpuat91_init_irq,
 	.init_machine	= cpuat91_board_init,
diff --git a/arch/arm/mach-at91/board-csb337.c b/arch/arm/mach-at91/board-csb337.c
index d98bcec..923cccb 100644
--- a/arch/arm/mach-at91/board-csb337.c
+++ b/arch/arm/mach-at91/board-csb337.c
@@ -46,7 +46,7 @@
 static void __init csb337_init_early(void)
 {
 	/* Initialize processor: 3.6864 MHz crystal */
-	at91rm9200_initialize(3686400);
+	at91_initialize(3686400);
 
 	/* Setup the LEDs */
 	at91_init_leds(AT91_PIN_PB0, AT91_PIN_PB1);
@@ -258,7 +258,7 @@ static void __init csb337_board_init(void)
 MACHINE_START(CSB337, "Cogent CSB337")
 	/* Maintainer: Bill Gatliff */
 	.timer		= &at91rm9200_timer,
-	.map_io		= at91rm9200_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= csb337_init_early,
 	.init_irq	= csb337_init_irq,
 	.init_machine	= csb337_board_init,
diff --git a/arch/arm/mach-at91/board-csb637.c b/arch/arm/mach-at91/board-csb637.c
index 019aab4..51131ca 100644
--- a/arch/arm/mach-at91/board-csb637.c
+++ b/arch/arm/mach-at91/board-csb637.c
@@ -43,7 +43,7 @@
 static void __init csb637_init_early(void)
 {
 	/* Initialize processor: 3.6864 MHz crystal */
-	at91rm9200_initialize(3686400);
+	at91_initialize(3686400);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
@@ -139,7 +139,7 @@ static void __init csb637_board_init(void)
 MACHINE_START(CSB637, "Cogent CSB637")
 	/* Maintainer: Bill Gatliff */
 	.timer		= &at91rm9200_timer,
-	.map_io		= at91rm9200_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= csb637_init_early,
 	.init_irq	= csb637_init_irq,
 	.init_machine	= csb637_board_init,
diff --git a/arch/arm/mach-at91/board-eb9200.c b/arch/arm/mach-at91/board-eb9200.c
index e948453..705071c 100644
--- a/arch/arm/mach-at91/board-eb9200.c
+++ b/arch/arm/mach-at91/board-eb9200.c
@@ -43,7 +43,7 @@
 static void __init eb9200_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
@@ -121,7 +121,7 @@ static void __init eb9200_board_init(void)
 
 MACHINE_START(ATEB9200, "Embest ATEB9200")
 	.timer		= &at91rm9200_timer,
-	.map_io		= at91rm9200_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= eb9200_init_early,
 	.init_irq	= eb9200_init_irq,
 	.init_machine	= eb9200_board_init,
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index a6f57fa..a9f106a 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -49,7 +49,7 @@ static void __init ecb_at91init_early(void)
 	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
 
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* Setup the LEDs */
 	at91_init_leds(AT91_PIN_PC7, AT91_PIN_PC7);
@@ -173,7 +173,7 @@ static void __init ecb_at91board_init(void)
 MACHINE_START(ECBAT91, "emQbit's ECB_AT91")
 	/* Maintainer: emQbit.com */
 	.timer		= &at91rm9200_timer,
-	.map_io		= at91rm9200_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= ecb_at91init_early,
 	.init_irq	= ecb_at91init_irq,
 	.init_machine	= ecb_at91board_init,
diff --git a/arch/arm/mach-at91/board-eco920.c b/arch/arm/mach-at91/board-eco920.c
index bfc0062..8639fbd 100644
--- a/arch/arm/mach-at91/board-eco920.c
+++ b/arch/arm/mach-at91/board-eco920.c
@@ -35,7 +35,7 @@ static void __init eco920_init_early(void)
 	/* Set cpu type: PQFP */
 	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
 
-	at91rm9200_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* Setup the LEDs */
 	at91_init_leds(AT91_PIN_PB0, AT91_PIN_PB1);
@@ -135,7 +135,7 @@ static void __init eco920_board_init(void)
 MACHINE_START(ECO920, "eco920")
 	/* Maintainer: Sascha Hauer */
 	.timer		= &at91rm9200_timer,
-	.map_io		= at91rm9200_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= eco920_init_early,
 	.init_irq	= eco920_init_irq,
 	.init_machine	= eco920_board_init,
diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
index 466c063..f45583e 100644
--- a/arch/arm/mach-at91/board-flexibity.c
+++ b/arch/arm/mach-at91/board-flexibity.c
@@ -40,7 +40,7 @@
 static void __init flexibity_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91sam9260_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
@@ -155,7 +155,7 @@ static void __init flexibity_board_init(void)
 MACHINE_START(FLEXIBITY, "Flexibity Connect")
 	/* Maintainer: Maxim Osipov */
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91sam9260_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= flexibity_init_early,
 	.init_irq	= flexibity_init_irq,
 	.init_machine	= flexibity_board_init,
diff --git a/arch/arm/mach-at91/board-foxg20.c b/arch/arm/mach-at91/board-foxg20.c
index e2d1dc9..b78442b 100644
--- a/arch/arm/mach-at91/board-foxg20.c
+++ b/arch/arm/mach-at91/board-foxg20.c
@@ -60,7 +60,7 @@
 static void __init foxg20_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91sam9260_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
@@ -267,7 +267,7 @@ static void __init foxg20_board_init(void)
 MACHINE_START(ACMENETUSFOXG20, "Acme Systems srl FOX Board G20")
 	/* Maintainer: Sergio Tanzilli */
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91sam9260_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= foxg20_init_early,
 	.init_irq	= foxg20_init_irq,
 	.init_machine	= foxg20_board_init,
diff --git a/arch/arm/mach-at91/board-gsia18s.c b/arch/arm/mach-at91/board-gsia18s.c
index 1d4f36b..6588143 100644
--- a/arch/arm/mach-at91/board-gsia18s.c
+++ b/arch/arm/mach-at91/board-gsia18s.c
@@ -577,7 +577,7 @@ static void __init gsia18s_board_init(void)
 
 MACHINE_START(GSIA18S, "GS_IA18_S")
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91sam9260_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= gsia18s_init_early,
 	.init_irq	= init_irq,
 	.init_machine	= gsia18s_board_init,
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
index 9b003ff..d26b960 100644
--- a/arch/arm/mach-at91/board-kafa.c
+++ b/arch/arm/mach-at91/board-kafa.c
@@ -46,7 +46,7 @@ static void __init kafa_init_early(void)
 	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
 
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* Set up the LEDs */
 	at91_init_leds(AT91_PIN_PB4, AT91_PIN_PB4);
@@ -99,7 +99,7 @@ static void __init kafa_board_init(void)
 MACHINE_START(KAFA, "Sperry-Sun KAFA")
 	/* Maintainer: Sergei Sharonov */
 	.timer		= &at91rm9200_timer,
-	.map_io		= at91rm9200_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= kafa_init_early,
 	.init_irq	= kafa_init_irq,
 	.init_machine	= kafa_board_init,
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index a813a74..a4d8153 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -48,7 +48,7 @@ static void __init kb9202_init_early(void)
 	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
 
 	/* Initialize processor: 10 MHz crystal */
-	at91rm9200_initialize(10000000);
+	at91_initialize(10000000);
 
 	/* Set up the LEDs */
 	at91_init_leds(AT91_PIN_PC19, AT91_PIN_PC18);
@@ -140,7 +140,7 @@ static void __init kb9202_board_init(void)
 MACHINE_START(KB9200, "KB920x")
 	/* Maintainer: KwikByte, Inc. */
 	.timer		= &at91rm9200_timer,
-	.map_io		= at91rm9200_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= kb9202_init_early,
 	.init_irq	= kb9202_init_irq,
 	.init_machine	= kb9202_board_init,
diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index 961e805..26a4c63 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -54,7 +54,7 @@
 static void __init neocore926_init_early(void)
 {
 	/* Initialize processor: 20 MHz crystal */
-	at91sam9263_initialize(20000000);
+	at91_initialize(20000000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
@@ -388,7 +388,7 @@ static void __init neocore926_board_init(void)
 MACHINE_START(NEOCORE926, "ADENEO NEOCORE 926")
 	/* Maintainer: ADENEO */
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91sam9263_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= neocore926_init_early,
 	.init_irq	= neocore926_init_irq,
 	.init_machine	= neocore926_board_init,
diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
index 21a21af..7651e7f 100644
--- a/arch/arm/mach-at91/board-pcontrol-g20.c
+++ b/arch/arm/mach-at91/board-pcontrol-g20.c
@@ -223,7 +223,7 @@ static void __init pcontrol_g20_board_init(void)
 MACHINE_START(PCONTROL_G20, "PControl G20")
 	/* Maintainer: pgsellmann at portner-elektronik.at */
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91sam9260_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= pcontrol_g20_init_early,
 	.init_irq	= init_irq,
 	.init_machine	= pcontrol_g20_board_init,
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index 756cc2a..c7294f8 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -46,7 +46,7 @@
 static void __init picotux200_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
@@ -124,7 +124,7 @@ static void __init picotux200_board_init(void)
 MACHINE_START(PICOTUX2XX, "picotux 200")
 	/* Maintainer: Kleinhenz Elektronik GmbH */
 	.timer		= &at91rm9200_timer,
-	.map_io		= at91rm9200_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= picotux200_init_early,
 	.init_irq	= picotux200_init_irq,
 	.init_machine	= picotux200_board_init,
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index d1a6001..68e31a9 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -51,7 +51,7 @@
 static void __init ek_init_early(void)
 {
 	/* Initialize processor: 12.000 MHz crystal */
-	at91sam9260_initialize(12000000);
+	at91_initialize(12000000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
@@ -269,7 +269,7 @@ static void __init ek_board_init(void)
 MACHINE_START(QIL_A9260, "CALAO QIL_A9260")
 	/* Maintainer: calao-systems */
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91sam9260_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index aef9627..97c6f21 100644
--- a/arch/arm/mach-at91/board-rm9200dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -48,7 +48,7 @@
 static void __init dk_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* Setup the LEDs */
 	at91_init_leds(AT91_PIN_PB2, AT91_PIN_PB2);
@@ -228,7 +228,7 @@ static void __init dk_board_init(void)
 MACHINE_START(AT91RM9200DK, "Atmel AT91RM9200-DK")
 	/* Maintainer: SAN People/Atmel */
 	.timer		= &at91rm9200_timer,
-	.map_io		= at91rm9200_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= dk_init_early,
 	.init_irq	= dk_init_irq,
 	.init_machine	= dk_board_init,
diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index 015a021..72aa8bf 100644
--- a/arch/arm/mach-at91/board-rm9200ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -48,7 +48,7 @@
 static void __init ek_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* Setup the LEDs */
 	at91_init_leds(AT91_PIN_PB1, AT91_PIN_PB2);
@@ -194,7 +194,7 @@ static void __init ek_board_init(void)
 MACHINE_START(AT91RM9200EK, "Atmel AT91RM9200-EK")
 	/* Maintainer: SAN People/Atmel */
 	.timer		= &at91rm9200_timer,
-	.map_io		= at91rm9200_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
index aaf1bf0..93c36bd 100644
--- a/arch/arm/mach-at91/board-sam9-l9260.c
+++ b/arch/arm/mach-at91/board-sam9-l9260.c
@@ -47,7 +47,7 @@
 static void __init ek_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91sam9260_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* Setup the LEDs */
 	at91_init_leds(AT91_PIN_PA9, AT91_PIN_PA6);
@@ -213,7 +213,7 @@ static void __init ek_board_init(void)
 MACHINE_START(SAM9_L9260, "Olimex SAM9-L9260")
 	/* Maintainer: Olimex */
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91sam9260_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index d600dc1..0330db3 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -53,7 +53,7 @@
 static void __init ek_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91sam9260_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
@@ -354,7 +354,7 @@ static void __init ek_board_init(void)
 MACHINE_START(AT91SAM9260EK, "Atmel AT91SAM9260-EK")
 	/* Maintainer: Atmel */
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91sam9260_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index f897f84..65ab1cd 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -57,7 +57,7 @@
 static void __init ek_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91sam9261_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* Setup the LEDs */
 	at91_init_leds(AT91_PIN_PA13, AT91_PIN_PA14);
@@ -621,7 +621,7 @@ MACHINE_START(AT91SAM9G10EK, "Atmel AT91SAM9G10-EK")
 #endif
 	/* Maintainer: Atmel */
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91sam9261_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index 605b26f..5b07981 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -56,7 +56,7 @@
 static void __init ek_init_early(void)
 {
 	/* Initialize processor: 16.367 MHz crystal */
-	at91sam9263_initialize(16367660);
+	at91_initialize(16367660);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
@@ -452,7 +452,7 @@ static void __init ek_board_init(void)
 MACHINE_START(AT91SAM9263EK, "Atmel AT91SAM9263-EK")
 	/* Maintainer: Atmel */
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91sam9263_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 7624cf0..8e7327a 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -64,7 +64,7 @@ static int inline ek_have_2mmc(void)
 static void __init ek_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91sam9260_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
@@ -404,7 +404,7 @@ static void __init ek_board_init(void)
 MACHINE_START(AT91SAM9G20EK, "Atmel AT91SAM9G20-EK")
 	/* Maintainer: Atmel */
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91sam9260_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
@@ -413,7 +413,7 @@ MACHINE_END
 MACHINE_START(AT91SAM9G20EK_2MMC, "Atmel AT91SAM9G20-EK 2 MMC Slot Mod")
 	/* Maintainer: Atmel */
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91sam9260_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index 063c95d..f112ad9 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -50,7 +50,7 @@
 static void __init ek_init_early(void)
 {
 	/* Initialize processor: 12.000 MHz crystal */
-	at91sam9g45_initialize(12000000);
+	at91_initialize(12000000);
 
 	/* DGBU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
@@ -422,7 +422,7 @@ static void __init ek_board_init(void)
 MACHINE_START(AT91SAM9M10G45EK, "Atmel AT91SAM9M10G45-EK")
 	/* Maintainer: Atmel */
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91sam9g45_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index effb399..defbca4 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -41,7 +41,7 @@
 static void __init ek_init_early(void)
 {
 	/* Initialize processor: 12.000 MHz crystal */
-	at91sam9rl_initialize(12000000);
+	at91_initialize(12000000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
@@ -330,7 +330,7 @@ static void __init ek_board_init(void)
 MACHINE_START(AT91SAM9RLEK, "Atmel AT91SAM9RL-EK")
 	/* Maintainer: Atmel */
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91sam9rl_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
index 3eb0a11..c600b14 100644
--- a/arch/arm/mach-at91/board-snapper9260.c
+++ b/arch/arm/mach-at91/board-snapper9260.c
@@ -42,7 +42,7 @@
 
 static void __init snapper9260_init_early(void)
 {
-	at91sam9260_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* Debug on ttyS0 */
 	at91_register_uart(0, 0, 0);
@@ -179,7 +179,7 @@ static void __init snapper9260_board_init(void)
 
 MACHINE_START(SNAPPER_9260, "Bluewater Systems Snapper 9260/9G20 module")
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91sam9260_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= snapper9260_init_early,
 	.init_irq	= snapper9260_init_irq,
 	.init_machine	= snapper9260_board_init,
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index 5e5c856..e65efda 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -35,7 +35,7 @@
 void __init stamp9g20_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91sam9260_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* DGBU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
@@ -299,7 +299,7 @@ static void __init stamp9g20evb_board_init(void)
 MACHINE_START(PORTUXG20, "taskit PortuxG20")
 	/* Maintainer: taskit GmbH */
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91sam9260_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= portuxg20_init_early,
 	.init_irq	= init_irq,
 	.init_machine	= portuxg20_board_init,
@@ -308,7 +308,7 @@ MACHINE_END
 MACHINE_START(STAMP9G20, "taskit Stamp9G20")
 	/* Maintainer: taskit GmbH */
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91sam9260_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= stamp9g20evb_init_early,
 	.init_irq	= init_irq,
 	.init_machine	= stamp9g20evb_board_init,
diff --git a/arch/arm/mach-at91/board-usb-a9260.c b/arch/arm/mach-at91/board-usb-a9260.c
index 0e784e6..afc3b04 100644
--- a/arch/arm/mach-at91/board-usb-a9260.c
+++ b/arch/arm/mach-at91/board-usb-a9260.c
@@ -51,7 +51,7 @@
 static void __init ek_init_early(void)
 {
 	/* Initialize processor: 12.000 MHz crystal */
-	at91sam9260_initialize(12000000);
+	at91_initialize(12000000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
@@ -229,7 +229,7 @@ static void __init ek_board_init(void)
 MACHINE_START(USB_A9260, "CALAO USB_A9260")
 	/* Maintainer: calao-systems */
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91sam9260_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
diff --git a/arch/arm/mach-at91/board-usb-a9263.c b/arch/arm/mach-at91/board-usb-a9263.c
index cf626dd..25357e0 100644
--- a/arch/arm/mach-at91/board-usb-a9263.c
+++ b/arch/arm/mach-at91/board-usb-a9263.c
@@ -50,7 +50,7 @@
 static void __init ek_init_early(void)
 {
 	/* Initialize processor: 12.00 MHz crystal */
-	at91sam9263_initialize(12000000);
+	at91_initialize(12000000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
@@ -245,7 +245,7 @@ static void __init ek_board_init(void)
 MACHINE_START(USB_A9263, "CALAO USB_A9263")
 	/* Maintainer: calao-systems */
 	.timer		= &at91sam926x_timer,
-	.map_io		= at91sam9263_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index c208cc3..e8a8ab9 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -56,7 +56,7 @@ static void __init yl9200_init_early(void)
 	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
 
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000);
+	at91_initialize(18432000);
 
 	/* Setup the LEDs D2=PB17 (timer), D3=PB16 (cpu) */
 	at91_init_leds(AT91_PIN_PB16, AT91_PIN_PB17);
@@ -599,7 +599,7 @@ static void __init yl9200_board_init(void)
 MACHINE_START(YL9200, "uCdragon YL-9200")
 	/* Maintainer: S.Birtles */
 	.timer		= &at91rm9200_timer,
-	.map_io		= at91rm9200_map_io,
+	.map_io		= at91_map_io,
 	.init_early	= yl9200_init_early,
 	.init_irq	= yl9200_init_irq,
 	.init_machine	= yl9200_board_init,
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 46721996..84e5b1d 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -11,27 +11,12 @@
 #include <linux/clkdev.h>
 
  /* Map io */
-extern void __init at91rm9200_map_io(void);
-extern void __init at91sam9260_map_io(void);
-extern void __init at91sam9261_map_io(void);
-extern void __init at91sam9263_map_io(void);
-extern void __init at91sam9rl_map_io(void);
-extern void __init at91sam9g45_map_io(void);
-extern void __init at91x40_map_io(void);
-extern void __init at91cap9_map_io(void);
-extern void __init at572d940hf_map_io(void);
+extern void __init at91_map_io(void);
 
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
index a738dc7..80c3df2 100644
--- a/arch/arm/mach-at91/include/mach/at572d940hf.h
+++ b/arch/arm/mach-at91/include/mach/at572d940hf.h
@@ -81,7 +81,6 @@
 #define AT572D940HF_BASE_EMAC	0xfffd8000
 #define AT572D940HF_BASE_CAN0	0xfffdc000
 #define AT572D940HF_BASE_CAN1	0xfffe0000
-#define AT91_BASE_SYS		0xffffea00
 
 
 /*
diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
index 6659938..c5df1e8 100644
--- a/arch/arm/mach-at91/include/mach/at91cap9.h
+++ b/arch/arm/mach-at91/include/mach/at91cap9.h
@@ -75,7 +75,6 @@
 #define AT91CAP9_BASE_EMAC		0xfffbc000
 #define AT91CAP9_BASE_ADC		0xfffc0000
 #define AT91CAP9_BASE_ISI		0xfffc4000
-#define AT91_BASE_SYS			0xffffe200
 
 /*
  * System Peripherals (offset from AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91rm9200.h b/arch/arm/mach-at91/include/mach/at91rm9200.h
index 99e0f8d..e4037b5 100644
--- a/arch/arm/mach-at91/include/mach/at91rm9200.h
+++ b/arch/arm/mach-at91/include/mach/at91rm9200.h
@@ -74,7 +74,6 @@
 #define AT91RM9200_BASE_SSC1	0xfffd4000
 #define AT91RM9200_BASE_SSC2	0xfffd8000
 #define AT91RM9200_BASE_SPI	0xfffe0000
-#define AT91_BASE_SYS		0xfffff000
 
 
 /*
diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
index 8b6bf83..9a79116 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9260.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
@@ -76,7 +76,6 @@
 #define AT91SAM9260_BASE_TC4		0xfffdc040
 #define AT91SAM9260_BASE_TC5		0xfffdc080
 #define AT91SAM9260_BASE_ADC		0xfffe0000
-#define AT91_BASE_SYS			0xffffe800
 
 /*
  * System Peripherals (offset from AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91sam9261.h b/arch/arm/mach-at91/include/mach/at91sam9261.h
index eafbdda..ce59620 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9261.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9261.h
@@ -60,7 +60,6 @@
 #define AT91SAM9261_BASE_SSC2		0xfffc4000
 #define AT91SAM9261_BASE_SPI0		0xfffc8000
 #define AT91SAM9261_BASE_SPI1		0xfffcc000
-#define AT91_BASE_SYS			0xffffea00
 
 
 /*
diff --git a/arch/arm/mach-at91/include/mach/at91sam9263.h b/arch/arm/mach-at91/include/mach/at91sam9263.h
index e2d3482..f1b9296 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9263.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9263.h
@@ -70,7 +70,6 @@
 #define AT91SAM9263_BASE_EMAC		0xfffbc000
 #define AT91SAM9263_BASE_ISI		0xfffc4000
 #define AT91SAM9263_BASE_2DGE		0xfffc8000
-#define AT91_BASE_SYS			0xffffe000
 
 /*
  * System Peripherals (offset from AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
index 659304a..2c611b9 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
@@ -82,7 +82,6 @@
 #define AT91SAM9G45_BASE_TC3		0xfffd4000
 #define AT91SAM9G45_BASE_TC4		0xfffd4040
 #define AT91SAM9G45_BASE_TC5		0xfffd4080
-#define AT91_BASE_SYS			0xffffe200
 
 /*
  * System Peripherals (offset from AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
index 41dbbe6..1aabacd 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
@@ -64,7 +64,6 @@
 #define AT91SAM9RL_BASE_TSC	0xfffd0000
 #define AT91SAM9RL_BASE_UDPHS	0xfffd4000
 #define AT91SAM9RL_BASE_AC97C	0xfffd8000
-#define AT91_BASE_SYS		0xffffc000
 
 
 /*
diff --git a/arch/arm/mach-at91/include/mach/hardware.h b/arch/arm/mach-at91/include/mach/hardware.h
index 469d3af..e820c96 100644
--- a/arch/arm/mach-at91/include/mach/hardware.h
+++ b/arch/arm/mach-at91/include/mach/hardware.h
@@ -38,6 +38,20 @@
 #error "Unsupported AT91 processor"
 #endif
 
+#if !defined(CONFIG_ARCH_AT91X40)
+/*
+ * On all at91 except rm9200 and x40 have the System Controller starts
+ * at address 0xffffc000 and has a size of 16KiB.
+ *
+ * On rm9200 it's start at 0xfffe4000 of 111KiB with non reserved data starting
+ * at 0xfffff000
+ *
+ * Removes the individual definitions of AT91_BASE_SYS and
+ * replaces them with a common version at base 0xfffffc000 and size 16KiB
+ * and map the same memory space
+ */
+#define AT91_BASE_SYS	0xffffc000
+#endif
 
 /*
  * Peripheral identifiers/interrupts.
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
new file mode 100644
index 0000000..dd62c46
--- /dev/null
+++ b/arch/arm/mach-at91/setup.c
@@ -0,0 +1,65 @@
+/*
+ * Copyright (C) 2007 Atmel Corporation.
+ * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Under GPLv2
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
+struct at91_soc __initdata at91_boot_soc;
+
+static struct map_desc at91_io_desc __initdata = {
+	.virtual	= AT91_VA_BASE_SYS,
+	.pfn		= __phys_to_pfn(AT91_BASE_SYS),
+	.length		= SZ_16K,
+	.type		= MT_DEVICE,
+};
+
+void __init at91_map_io(void)
+{
+	/* Map peripherals */
+	iotable_init(&at91_io_desc, 1);
+
+	if (cpu_is_at572d940hf())
+		at91_boot_soc = at572d940hf_soc;
+	else if (cpu_is_at91cap9())
+		at91_boot_soc = at91cap9_soc;
+	else if (cpu_is_at91rm9200())
+		at91_boot_soc = at91rm9200_soc;
+	else if (cpu_is_at91sam9260())
+		at91_boot_soc = at91sam9260_soc;
+	else if (cpu_is_at91sam9261())
+		at91_boot_soc = at91sam9261_soc;
+	else if (cpu_is_at91sam9263())
+		at91_boot_soc = at91sam9263_soc;
+	else if (cpu_is_at91sam9g10())
+		at91_boot_soc = at91sam9261_soc;
+	else if (cpu_is_at91sam9g20())
+		at91_boot_soc = at91sam9260_soc;
+	else if (cpu_is_at91sam9g45())
+		at91_boot_soc = at91sam9g45_soc;
+	else if (cpu_is_at91sam9rl())
+		at91_boot_soc = at91sam9rl_soc;
+	else if (cpu_is_at91sam9x5())
+		at91_boot_soc = at91sam9x5_soc;
+	else
+		panic("Impossible to detect the SOC type");
+
+	if (at91_boot_soc.map_io)
+		at91_boot_soc.map_io();
+}
+
+void __init at91_initialize(unsigned long main_clock)
+{
+	at91_boot_soc.init(main_clock);
+}
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
new file mode 100644
index 0000000..917f610
--- /dev/null
+++ b/arch/arm/mach-at91/soc.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Under GPLv2
+ */
+
+struct at91_soc {
+	void (*map_io)(void);
+	void (*init)(unsigned long main_clock);
+};
+
+extern struct at91_soc at91_boot_soc;
+extern struct at91_soc at572d940hf_soc;
+extern struct at91_soc at91cap9_soc;
+extern struct at91_soc at91rm9200_soc;
+extern struct at91_soc at91sam9260_soc;
+extern struct at91_soc at91sam9261_soc;
+extern struct at91_soc at91sam9263_soc;
+extern struct at91_soc at91sam9g45_soc;
+extern struct at91_soc at91sam9rl_soc;
+extern struct at91_soc at91sam9x5_soc;
-- 
1.7.4.1
