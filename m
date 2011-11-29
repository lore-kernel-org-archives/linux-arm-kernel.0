From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 29 Nov 2011 18:52:41 +0100
Subject: [PATCH 5/6] ARM: at91: Fix at91sam9g45 and at91cap9 reset
In-Reply-To: <20111129173514.GW15008@game.jcrosoft.org>
References: <20111129173514.GW15008@game.jcrosoft.org>
Message-ID: <1322589162-5212-5-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As on the other sam9 we to cleanly shutdown the DDR before rebooting

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/Kconfig             |    5 ++++
 arch/arm/mach-at91/Makefile            |    1 +
 arch/arm/mach-at91/at91cap9.c          |    8 +-----
 arch/arm/mach-at91/at91sam9g45.c       |    6 ----
 arch/arm/mach-at91/at91sam9g45_reset.S |   41 ++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/generic.h           |    1 +
 6 files changed, 49 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/mach-at91/at91sam9g45_reset.S

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 4275577..c5626b7 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -21,6 +21,9 @@ config HAVE_AT91_USART5
 config AT91_SAM9_ALT_RESET
 	bool
 
+config AT91_SAM9G45_ALT_RESET
+	bool
+
 menu "Atmel AT91 System-on-Chip"
 
 choice
@@ -97,6 +100,7 @@ config ARCH_AT91SAM9G45
 	select HAVE_FB_ATMEL
 	select HAVE_NET_MACB
 	select HAVE_AT91_DBGU1
+	select AT91_SAM9G45_ALT_RESET
 
 config ARCH_AT91CAP9
 	bool "AT91CAP9"
@@ -105,6 +109,7 @@ config ARCH_AT91CAP9
 	select HAVE_FB_ATMEL
 	select HAVE_NET_MACB
 	select HAVE_AT91_DBGU1
+	select AT91_SAM9G45_ALT_RESET
 
 config ARCH_AT91X40
 	bool "AT91x40"
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index e8e961b..ef07d31 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -9,6 +9,7 @@ obj-		:=
 
 obj-$(CONFIG_AT91_PMC_UNIT)	+= clock.o
 obj-$(CONFIG_AT91_SAM9_ALT_RESET) += at91sam9_alt_reset.o
+obj-$(CONFIG_AT91_SAM9G45_ALT_RESET) += at91sam9g45_reset.o
 
 # CPU-specific support
 obj-$(CONFIG_ARCH_AT91RM9200)	+= at91rm9200.o at91rm9200_time.o at91rm9200_devices.o
diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index e484a09..7b7f30b 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -21,7 +21,6 @@
 #include <mach/cpu.h>
 #include <mach/at91cap9.h>
 #include <mach/at91_pmc.h>
-#include <mach/at91_rstc.h>
 
 #include "soc.h"
 #include "generic.h"
@@ -312,11 +311,6 @@ static struct at91_gpio_bank at91cap9_gpio[] __initdata = {
 	}
 };
 
-static void at91cap9_restart(char mode, const char *cmd)
-{
-	at91_sys_write(AT91_RSTC_CR, AT91_RSTC_KEY | AT91_RSTC_PROCRST | AT91_RSTC_PERRST);
-}
-
 /* --------------------------------------------------------------------
  *  AT91CAP9 processor initialization
  * -------------------------------------------------------------------- */
@@ -335,7 +329,7 @@ static void __init at91cap9_ioremap_registers(void)
 
 static void __init at91cap9_initialize(void)
 {
-	arm_pm_restart = at91cap9_restart;
+	arm_pm_restart = at91sam9g45_restart;
 	at91_extern_irq = (1 << AT91CAP9_ID_IRQ0) | (1 << AT91CAP9_ID_IRQ1);
 
 	/* Register GPIO subsystem */
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 9344da5..2d6e29f 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -18,7 +18,6 @@
 #include <asm/mach/map.h>
 #include <mach/at91sam9g45.h>
 #include <mach/at91_pmc.h>
-#include <mach/at91_rstc.h>
 #include <mach/cpu.h>
 
 #include "soc.h"
@@ -316,11 +315,6 @@ static struct at91_gpio_bank at91sam9g45_gpio[] __initdata = {
 	}
 };
 
-static void at91sam9g45_restart(char mode, const char *cmd)
-{
-	at91_sys_write(AT91_RSTC_CR, AT91_RSTC_KEY | AT91_RSTC_PROCRST | AT91_RSTC_PERRST);
-}
-
 /* --------------------------------------------------------------------
  *  AT91SAM9G45 processor initialization
  * -------------------------------------------------------------------- */
diff --git a/arch/arm/mach-at91/at91sam9g45_reset.S b/arch/arm/mach-at91/at91sam9g45_reset.S
new file mode 100644
index 0000000..69c75fd
--- /dev/null
+++ b/arch/arm/mach-at91/at91sam9g45_reset.S
@@ -0,0 +1,41 @@
+/*
+ * reset AT91SAM9G45 as per errata
+ *
+ * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcosoft.com>
+ *
+ * unless the SDRAM is cleanly shutdown before we hit the
+ * reset register it can be left driving the data bus and
+ * killing the chance of a subsequent boot from NAND
+ *
+ * GPLv2 Only
+ */
+
+#include <linux/linkage.h>
+#include <mach/hardware.h>
+#include <mach/at91sam9_ddrsdr.h>
+#include <mach/at91_rstc.h>
+
+			.arm
+
+			.globl	at91sam9g45_restart
+
+at91sam9g45_restart:
+			ldr	r0, .at91_va_base_sdramc0	@ preload constants
+			ldr	r1, .at91_va_base_rstc_cr
+
+			mov	r2, #1
+			mov	r3, #AT91_DDRSDRC_LPCB_POWER_DOWN
+			ldr	r4, =AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST
+
+			.balign	32				@ align to cache line
+
+			str	r2, [r0, #AT91_DDRSDRC_RTR]	@ disable DDR0 access
+			str	r3, [r0, #AT91_DDRSDRC_LPR]	@ power down DDR0
+			str	r4, [r1]			@ reset processor
+
+			b	.
+
+.at91_va_base_sdramc0:
+	.word AT91_VA_BASE_SYS + AT91_DDRSDRC0
+.at91_va_base_rstc_cr:
+	.word AT91_VA_BASE_SYS + AT91_RSTC_CR
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 4866b81..33907ce 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -59,6 +59,7 @@ extern void at91_irq_resume(void);
 
 /* reset */
 extern void at91sam9_alt_restart(char, const char *);
+extern void at91sam9g45_restart(char, const char *);
 
 /* shutdown */
 extern void at91_ioremap_shdwc(u32 base_addr);
-- 
1.7.7
