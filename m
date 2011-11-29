From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 29 Nov 2011 18:52:42 +0100
Subject: [PATCH 6/6] ARM: at91: make rstc soc independent
In-Reply-To: <20111129173514.GW15008@game.jcrosoft.org>
References: <20111129173514.GW15008@game.jcrosoft.org>
Message-ID: <1322589162-5212-6-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91cap9.c                 |    1 +
 arch/arm/mach-at91/at91sam9260.c              |    1 +
 arch/arm/mach-at91/at91sam9261.c              |    1 +
 arch/arm/mach-at91/at91sam9263.c              |    1 +
 arch/arm/mach-at91/at91sam9_alt_reset.S       |    7 +++----
 arch/arm/mach-at91/at91sam9g45.c              |    1 +
 arch/arm/mach-at91/at91sam9g45_reset.S        |    7 +++----
 arch/arm/mach-at91/at91sam9rl.c               |    1 +
 arch/arm/mach-at91/generic.h                  |    1 +
 arch/arm/mach-at91/include/mach/at91_rstc.h   |   18 +++++++++++++++---
 arch/arm/mach-at91/include/mach/at91cap9.h    |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9260.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9261.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9263.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9g45.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9rl.h  |    2 +-
 arch/arm/mach-at91/pm.c                       |    9 ++-------
 arch/arm/mach-at91/setup.c                    |    9 +++++++++
 18 files changed, 45 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index 7b7f30b..90daf48 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -323,6 +323,7 @@ static void __init at91cap9_map_io(void)
 static void __init at91cap9_ioremap_registers(void)
 {
 	at91_ioremap_shdwc(AT91CAP9_BASE_SHDWC);
+	at91_ioremap_rstc(AT91CAP9_BASE_RSTC);
 	at91sam926x_ioremap_pit(AT91CAP9_BASE_PIT);
 	at91sam9_ioremap_smc(0, AT91CAP9_BASE_SMC);
 }
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 9219b29..22bbad7 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -321,6 +321,7 @@ static void __init at91sam9260_map_io(void)
 static void __init at91sam9260_ioremap_registers(void)
 {
 	at91_ioremap_shdwc(AT91SAM9260_BASE_SHDWC);
+	at91_ioremap_rstc(AT91SAM9260_BASE_RSTC);
 	at91sam926x_ioremap_pit(AT91SAM9260_BASE_PIT);
 	at91sam9_ioremap_smc(0, AT91SAM9260_BASE_SMC);
 }
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index b85b9ea..023c2ff 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -281,6 +281,7 @@ static void __init at91sam9261_map_io(void)
 static void __init at91sam9261_ioremap_registers(void)
 {
 	at91_ioremap_shdwc(AT91SAM9261_BASE_SHDWC);
+	at91_ioremap_rstc(AT91SAM9261_BASE_RSTC);
 	at91sam926x_ioremap_pit(AT91SAM9261_BASE_PIT);
 	at91sam9_ioremap_smc(0, AT91SAM9261_BASE_SMC);
 }
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index c26e0a1..5a7f902 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -299,6 +299,7 @@ static void __init at91sam9263_map_io(void)
 static void __init at91sam9263_ioremap_registers(void)
 {
 	at91_ioremap_shdwc(AT91SAM9263_BASE_SHDWC);
+	at91_ioremap_rstc(AT91SAM9263_BASE_RSTC);
 	at91sam926x_ioremap_pit(AT91SAM9263_BASE_PIT);
 	at91sam9_ioremap_smc(0, AT91SAM9263_BASE_SMC0);
 	at91sam9_ioremap_smc(1, AT91SAM9263_BASE_SMC1);
diff --git a/arch/arm/mach-at91/at91sam9_alt_reset.S b/arch/arm/mach-at91/at91sam9_alt_reset.S
index d3f931c..518e423 100644
--- a/arch/arm/mach-at91/at91sam9_alt_reset.S
+++ b/arch/arm/mach-at91/at91sam9_alt_reset.S
@@ -23,7 +23,8 @@
 			.globl	at91sam9_alt_restart
 
 at91sam9_alt_restart:	ldr	r0, .at91_va_base_sdramc	@ preload constants
-			ldr	r1, .at91_va_base_rstc_cr
+			ldr	r1, =at91_rstc_base
+			ldr	r1, [r1]
 
 			mov	r2, #1
 			mov	r3, #AT91_SDRAMC_LPCB_POWER_DOWN
@@ -33,11 +34,9 @@ at91sam9_alt_restart:	ldr	r0, .at91_va_base_sdramc	@ preload constants
 
 			str	r2, [r0, #AT91_SDRAMC_TR]	@ disable SDRAM access
 			str	r3, [r0, #AT91_SDRAMC_LPR]	@ power down SDRAM
-			str	r4, [r1]			@ reset processor
+			str	r4, [r1, #AT91_RSTC_CR]		@ reset processor
 
 			b	.
 
 .at91_va_base_sdramc:
 	.word AT91_VA_BASE_SYS + AT91_SDRAMC0
-.at91_va_base_rstc_cr:
-	.word AT91_VA_BASE_SYS + AT91_RSTC_CR
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 2d6e29f..7436c37 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -328,6 +328,7 @@ static void __init at91sam9g45_map_io(void)
 static void __init at91sam9g45_ioremap_registers(void)
 {
 	at91_ioremap_shdwc(AT91SAM9G45_BASE_SHDWC);
+	at91_ioremap_rstc(AT91SAM9G45_BASE_RSTC);
 	at91sam926x_ioremap_pit(AT91SAM9G45_BASE_PIT);
 	at91sam9_ioremap_smc(0, AT91SAM9G45_BASE_SMC);
 }
diff --git a/arch/arm/mach-at91/at91sam9g45_reset.S b/arch/arm/mach-at91/at91sam9g45_reset.S
index 69c75fd..0468be1 100644
--- a/arch/arm/mach-at91/at91sam9g45_reset.S
+++ b/arch/arm/mach-at91/at91sam9g45_reset.S
@@ -21,7 +21,8 @@
 
 at91sam9g45_restart:
 			ldr	r0, .at91_va_base_sdramc0	@ preload constants
-			ldr	r1, .at91_va_base_rstc_cr
+			ldr	r1, =at91_rstc_base
+			ldr	r1, [r1]
 
 			mov	r2, #1
 			mov	r3, #AT91_DDRSDRC_LPCB_POWER_DOWN
@@ -31,11 +32,9 @@ at91sam9g45_restart:
 
 			str	r2, [r0, #AT91_DDRSDRC_RTR]	@ disable DDR0 access
 			str	r3, [r0, #AT91_DDRSDRC_LPR]	@ power down DDR0
-			str	r4, [r1]			@ reset processor
+			str	r4, [r1, #AT91_RSTC_CR]		@ reset processor
 
 			b	.
 
 .at91_va_base_sdramc0:
 	.word AT91_VA_BASE_SYS + AT91_DDRSDRC0
-.at91_va_base_rstc_cr:
-	.word AT91_VA_BASE_SYS + AT91_RSTC_CR
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index d6bcb1d..d2c91a8 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -286,6 +286,7 @@ static void __init at91sam9rl_map_io(void)
 static void __init at91sam9rl_ioremap_registers(void)
 {
 	at91_ioremap_shdwc(AT91SAM9RL_BASE_SHDWC);
+	at91_ioremap_rstc(AT91SAM9RL_BASE_RSTC);
 	at91sam926x_ioremap_pit(AT91SAM9RL_BASE_PIT);
 	at91sam9_ioremap_smc(0, AT91SAM9RL_BASE_SMC);
 }
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 33907ce..5941334 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -58,6 +58,7 @@ extern void at91_irq_suspend(void);
 extern void at91_irq_resume(void);
 
 /* reset */
+extern void at91_ioremap_rstc(u32 base_addr);
 extern void at91sam9_alt_restart(char, const char *);
 extern void at91sam9g45_restart(char, const char *);
 
diff --git a/arch/arm/mach-at91/include/mach/at91_rstc.h b/arch/arm/mach-at91/include/mach/at91_rstc.h
index cbd2bf0..875fa33 100644
--- a/arch/arm/mach-at91/include/mach/at91_rstc.h
+++ b/arch/arm/mach-at91/include/mach/at91_rstc.h
@@ -16,13 +16,25 @@
 #ifndef AT91_RSTC_H
 #define AT91_RSTC_H
 
-#define AT91_RSTC_CR		(AT91_RSTC + 0x00)	/* Reset Controller Control Register */
+#ifndef __ASSEMBLY__
+extern void __iomem *at91_rstc_base;
+
+#define at91_rstc_read(field) \
+	__raw_readl(at91_rstc_base + field)
+
+#define at91_rstc_write(field, value) \
+	__raw_writel(value, at91_rstc_base + field);
+#else
+.extern at91_rstc_base
+#endif
+
+#define AT91_RSTC_CR		0x00			/* Reset Controller Control Register */
 #define		AT91_RSTC_PROCRST	(1 << 0)		/* Processor Reset */
 #define		AT91_RSTC_PERRST	(1 << 2)		/* Peripheral Reset */
 #define		AT91_RSTC_EXTRST	(1 << 3)		/* External Reset */
 #define		AT91_RSTC_KEY		(0xa5 << 24)		/* KEY Password */
 
-#define AT91_RSTC_SR		(AT91_RSTC + 0x04)	/* Reset Controller Status Register */
+#define AT91_RSTC_SR		0x04			/* Reset Controller Status Register */
 #define		AT91_RSTC_URSTS		(1 << 0)		/* User Reset Status */
 #define		AT91_RSTC_RSTTYP	(7 << 8)		/* Reset Type */
 #define			AT91_RSTC_RSTTYP_GENERAL	(0 << 8)
@@ -33,7 +45,7 @@
 #define		AT91_RSTC_NRSTL		(1 << 16)		/* NRST Pin Level */
 #define		AT91_RSTC_SRCMP		(1 << 17)		/* Software Reset Command in Progress */
 
-#define AT91_RSTC_MR		(AT91_RSTC + 0x08)	/* Reset Controller Mode Register */
+#define AT91_RSTC_MR		0x08			/* Reset Controller Mode Register */
 #define		AT91_RSTC_URSTEN	(1 << 0)		/* User Reset Enable */
 #define		AT91_RSTC_URSTIEN	(1 << 4)		/* User Reset Interrupt Enable */
 #define		AT91_RSTC_ERSTL		(0xf << 8)		/* External Reset Length */
diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
index 4c0e2f6..61d9529 100644
--- a/arch/arm/mach-at91/include/mach/at91cap9.h
+++ b/arch/arm/mach-at91/include/mach/at91cap9.h
@@ -83,7 +83,6 @@
 #define AT91_DDRSDRC0	(0xffffe600 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffea00 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
-#define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_GPBR	(cpu_is_at91cap9_revB() ?	\
 			(0xfffffd50 - AT91_BASE_SYS) :	\
 			(0xfffffd60 - AT91_BASE_SYS))
@@ -96,6 +95,7 @@
 #define AT91CAP9_BASE_PIOB	0xfffff400
 #define AT91CAP9_BASE_PIOC	0xfffff600
 #define AT91CAP9_BASE_PIOD	0xfffff800
+#define AT91CAP9_BASE_RSTC	0xfffffd00
 #define AT91CAP9_BASE_SHDWC	0xfffffd10
 #define AT91CAP9_BASE_RTT	0xfffffd20
 #define AT91CAP9_BASE_PIT	0xfffffd30
diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
index f937c47..fa5ca27 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9260.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
@@ -83,7 +83,6 @@
 #define AT91_SDRAMC0	(0xffffea00 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
-#define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
 
 #define AT91SAM9260_BASE_ECC	0xffffe800
@@ -92,6 +91,7 @@
 #define AT91SAM9260_BASE_PIOA	0xfffff400
 #define AT91SAM9260_BASE_PIOB	0xfffff600
 #define AT91SAM9260_BASE_PIOC	0xfffff800
+#define AT91SAM9260_BASE_RSTC	0xfffffd00
 #define AT91SAM9260_BASE_SHDWC	0xfffffd10
 #define AT91SAM9260_BASE_RTT	0xfffffd20
 #define AT91SAM9260_BASE_PIT	0xfffffd30
diff --git a/arch/arm/mach-at91/include/mach/at91sam9261.h b/arch/arm/mach-at91/include/mach/at91sam9261.h
index 175604e..7cde2d3 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9261.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9261.h
@@ -68,7 +68,6 @@
 #define AT91_SDRAMC0	(0xffffea00 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
-#define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
 
 #define AT91SAM9261_BASE_SMC	0xffffec00
@@ -76,6 +75,7 @@
 #define AT91SAM9261_BASE_PIOA	0xfffff400
 #define AT91SAM9261_BASE_PIOB	0xfffff600
 #define AT91SAM9261_BASE_PIOC	0xfffff800
+#define AT91SAM9261_BASE_RSTC	0xfffffd00
 #define AT91SAM9261_BASE_SHDWC	0xfffffd10
 #define AT91SAM9261_BASE_RTT	0xfffffd20
 #define AT91SAM9261_BASE_PIT	0xfffffd30
diff --git a/arch/arm/mach-at91/include/mach/at91sam9263.h b/arch/arm/mach-at91/include/mach/at91sam9263.h
index 80c9150..5949abd 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9263.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9263.h
@@ -78,7 +78,6 @@
 #define AT91_SDRAMC1	(0xffffe800 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffec00 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
-#define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 
 #define AT91SAM9263_BASE_ECC0	0xffffe000
@@ -91,6 +90,7 @@
 #define AT91SAM9263_BASE_PIOC	0xfffff600
 #define AT91SAM9263_BASE_PIOD	0xfffff800
 #define AT91SAM9263_BASE_PIOE	0xfffffa00
+#define AT91SAM9263_BASE_RSTC	0xfffffd00
 #define AT91SAM9263_BASE_SHDWC	0xfffffd10
 #define AT91SAM9263_BASE_RTT0	0xfffffd20
 #define AT91SAM9263_BASE_PIT	0xfffffd30
diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
index f0c23c9..dd9c95e 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
@@ -90,7 +90,6 @@
 #define AT91_DDRSDRC0	(0xffffe600 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffea00 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
-#define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 
 #define AT91SAM9G45_BASE_ECC	0xffffe200
@@ -102,6 +101,7 @@
 #define AT91SAM9G45_BASE_PIOC	0xfffff600
 #define AT91SAM9G45_BASE_PIOD	0xfffff800
 #define AT91SAM9G45_BASE_PIOE	0xfffffa00
+#define AT91SAM9G45_BASE_RSTC	0xfffffd00
 #define AT91SAM9G45_BASE_SHDWC	0xfffffd10
 #define AT91SAM9G45_BASE_RTT	0xfffffd20
 #define AT91SAM9G45_BASE_PIT	0xfffffd30
diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
index 2bb359e..d7bead7 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
@@ -72,7 +72,6 @@
 #define AT91_SDRAMC0	(0xffffea00 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
-#define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SCKCR	(0xfffffd50 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 
@@ -84,6 +83,7 @@
 #define AT91SAM9RL_BASE_PIOB	0xfffff600
 #define AT91SAM9RL_BASE_PIOC	0xfffff800
 #define AT91SAM9RL_BASE_PIOD	0xfffffa00
+#define AT91SAM9RL_BASE_RSTC	0xfffffd00
 #define AT91SAM9RL_BASE_SHDWC	0xfffffd10
 #define AT91SAM9RL_BASE_RTT	0xfffffd20
 #define AT91SAM9RL_BASE_PIT	0xfffffd30
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 62ad955..1606379 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -34,7 +34,6 @@
 /*
  * Show the reason for the previous system reset.
  */
-#if defined(AT91_RSTC)
 
 #include <mach/at91_rstc.h>
 #include <mach/at91_shdwc.h>
@@ -58,10 +57,10 @@ static void __init show_reset_status(void)
 	char *reason, *r2 = reset;
 	u32 reset_type, wake_type;
 
-	if (!at91_shdwc_base)
+	if (!at91_shdwc_base || !at91_rstc_base)
 		return;
 
-	reset_type = at91_sys_read(AT91_RSTC_SR) & AT91_RSTC_RSTTYP;
+	reset_type = at91_rstc_read(AT91_RSTC_SR) & AT91_RSTC_RSTTYP;
 	wake_type = at91_shdwc_read(AT91_SHDW_SR);
 
 	switch (reset_type) {
@@ -102,10 +101,6 @@ static void __init show_reset_status(void)
 	}
 	pr_info("AT91: Starting after %s %s\n", reason, r2);
 }
-#else
-static void __init show_reset_status(void) {}
-#endif
-
 
 static int at91_pm_valid_state(suspend_state_t state)
 {
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 242c26b..63902fb 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -299,6 +299,15 @@ void __init at91_ioremap_shdwc(u32 base_addr)
 	pm_power_off = at91sam9_poweroff;
 }
 
+void __iomem *at91_rstc_base;
+
+void __init at91_ioremap_rstc(u32 base_addr)
+{
+	at91_rstc_base = ioremap(base_addr, 16);
+	if (!at91_rstc_base)
+		panic("Impossible to ioremap at91_rstc_base\n");
+}
+
 void __init at91_initialize(unsigned long main_clock)
 {
 	at91_boot_soc.ioremap_registers();
-- 
1.7.7
