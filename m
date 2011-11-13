From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 13 Nov 2011 19:12:31 +0100
Subject: [PATCH 11/12] ARM: at91: make DBGU soc independent
In-Reply-To: <20111113180954.GD15318@game.jcrosoft.org>
References: <20111113180954.GD15318@game.jcrosoft.org>
Message-ID: <1321207952-13556-11-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this will allow to select the DBGU to use based on the SOC enabled for the
DEBUG_LL and early_printk via Kconfig

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/Kconfig                    |   36 +++++++++++++++++++++++-
 arch/arm/mach-at91/at91cap9_devices.c         |    4 +-
 arch/arm/mach-at91/at91rm9200_devices.c       |    4 +-
 arch/arm/mach-at91/at91sam9260_devices.c      |    4 +-
 arch/arm/mach-at91/at91sam9261_devices.c      |    4 +-
 arch/arm/mach-at91/at91sam9263_devices.c      |    4 +-
 arch/arm/mach-at91/at91sam9g45_devices.c      |    4 +-
 arch/arm/mach-at91/at91sam9rl_devices.c       |    4 +-
 arch/arm/mach-at91/include/mach/at91_dbgu.h   |    2 +-
 arch/arm/mach-at91/include/mach/at91cap9.h    |    2 +-
 arch/arm/mach-at91/include/mach/at91rm9200.h  |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9260.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9261.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9263.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9g45.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9rl.h  |    2 +-
 arch/arm/mach-at91/include/mach/debug-macro.S |   10 +++++-
 arch/arm/mach-at91/include/mach/hardware.h    |    6 ++++
 arch/arm/mach-at91/include/mach/uncompress.h  |    6 +++-
 arch/arm/mach-at91/setup.c                    |    7 +---
 20 files changed, 76 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index d9ff0cd..c8d715e 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -3,6 +3,12 @@ if ARCH_AT91
 config HAVE_AT91_DATAFLASH_CARD
 	bool
 
+config HAVE_AT91_DBGU0
+	bool
+
+config HAVE_AT91_DBGU1
+	bool
+
 config HAVE_AT91_USART3
 	bool
 
@@ -21,12 +27,14 @@ config ARCH_AT91RM9200
 	bool "AT91RM9200"
 	select CPU_ARM920T
 	select GENERIC_CLOCKEVENTS
+	select HAVE_AT91_DBGU0
 	select HAVE_AT91_USART3
 
 config ARCH_AT91SAM9260
 	bool "AT91SAM9260 or AT91SAM9XE"
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
+	select HAVE_AT91_DBGU0
 	select HAVE_AT91_USART3
 	select HAVE_AT91_USART4
 	select HAVE_AT91_USART5
@@ -37,6 +45,7 @@ config ARCH_AT91SAM9261
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
 	select HAVE_FB_ATMEL
+	select HAVE_AT91_DBGU0
 
 config ARCH_AT91SAM9263
 	bool "AT91SAM9263"
@@ -44,6 +53,7 @@ config ARCH_AT91SAM9263
 	select GENERIC_CLOCKEVENTS
 	select HAVE_FB_ATMEL
 	select HAVE_NET_MACB
+	select HAVE_AT91_DBGU1
 
 config ARCH_AT91SAM9RL
 	bool "AT91SAM9RL"
@@ -51,6 +61,7 @@ config ARCH_AT91SAM9RL
 	select GENERIC_CLOCKEVENTS
 	select HAVE_AT91_USART3
 	select HAVE_FB_ATMEL
+	select HAVE_AT91_DBGU0
 
 config ARCH_AT91SAM9G45
 	bool "AT91SAM9G45"
@@ -59,6 +70,7 @@ config ARCH_AT91SAM9G45
 	select HAVE_AT91_USART3
 	select HAVE_FB_ATMEL
 	select HAVE_NET_MACB
+	select HAVE_AT91_DBGU1
 
 config ARCH_AT91CAP9
 	bool "AT91CAP9"
@@ -66,6 +78,7 @@ config ARCH_AT91CAP9
 	select GENERIC_CLOCKEVENTS
 	select HAVE_FB_ATMEL
 	select HAVE_NET_MACB
+	select HAVE_AT91_DBGU1
 
 config ARCH_AT91X40
 	bool "AT91x40"
@@ -478,8 +491,13 @@ config AT91_TIMER_HZ
 choice
 	prompt "Select a UART for early kernel messages"
 
-config AT91_EARLY_DBGU
-	bool "DBGU"
+config AT91_EARLY_DBGU0
+	bool "DBGU on rm9200, 9260, 9261 and 9rl"
+	depends on HAVE_AT91_DBGU0
+
+config AT91_EARLY_DBGU1
+	bool "DBGU on 9263, 9g45 and cap9"
+	depends on HAVE_AT91_DBGU1
 
 config AT91_EARLY_USART0
 	bool "USART0"
@@ -505,6 +523,20 @@ config AT91_EARLY_USART5
 
 endchoice
 
+choice
+	prompt "Select a DBGU for DEBUG_LL"
+	depends on DEBUG_LL
+
+config AT91_DEBUG_LL_DBGU0
+	bool "DBGU on rm9200, 9260, 9261 and 9rl"
+	depends on HAVE_AT91_DBGU0
+
+config AT91_DEBUG_LL_DBGU1
+	bool "DBGU on 9263, 9g45 and cap9"
+	depends on HAVE_AT91_DBGU1
+
+endchoice
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index 019dac0..19975cf 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -1030,8 +1030,8 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 #if defined(CONFIG_SERIAL_ATMEL)
 static struct resource dbgu_resources[] = {
 	[0] = {
-		.start	= AT91_BASE_SYS + AT91_DBGU,
-		.end	= AT91_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.start	= AT91CAP9_BASE_DBGU,
+		.end	= AT91CAP9_BASE_DBGU + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 66591fa..1007ba8 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -877,8 +877,8 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 #if defined(CONFIG_SERIAL_ATMEL)
 static struct resource dbgu_resources[] = {
 	[0] = {
-		.start	= AT91_BASE_SYS + AT91_DBGU,
-		.end	= AT91_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.start	= AT91RM9200_BASE_DBGU,
+		.end	= AT91RM9200_BASE_DBGU + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 9cdaffa..5b424fc 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -846,8 +846,8 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 #if defined(CONFIG_SERIAL_ATMEL)
 static struct resource dbgu_resources[] = {
 	[0] = {
-		.start	= AT91_BASE_SYS + AT91_DBGU,
-		.end	= AT91_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.start	= AT91SAM9260_BASE_DBGU,
+		.end	= AT91SAM9260_BASE_DBGU + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index c59e1e9..e5cff1d 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -825,8 +825,8 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 #if defined(CONFIG_SERIAL_ATMEL)
 static struct resource dbgu_resources[] = {
 	[0] = {
-		.start	= AT91_BASE_SYS + AT91_DBGU,
-		.end	= AT91_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.start	= AT91SAM9261_BASE_DBGU,
+		.end	= AT91SAM9261_BASE_DBGU + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index b5f4e25..20e681c 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -1205,8 +1205,8 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 
 static struct resource dbgu_resources[] = {
 	[0] = {
-		.start	= AT91_BASE_SYS + AT91_DBGU,
-		.end	= AT91_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.start	= AT91SAM9263_BASE_DBGU,
+		.end	= AT91SAM9263_BASE_DBGU + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 3b91706..153dad0 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1341,8 +1341,8 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 #if defined(CONFIG_SERIAL_ATMEL)
 static struct resource dbgu_resources[] = {
 	[0] = {
-		.start	= AT91_BASE_SYS + AT91_DBGU,
-		.end	= AT91_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.start	= AT91SAM9G45_BASE_DBGU,
+		.end	= AT91SAM9G45_BASE_DBGU + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index c7961b4..366c1cf 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -917,8 +917,8 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 #if defined(CONFIG_SERIAL_ATMEL)
 static struct resource dbgu_resources[] = {
 	[0] = {
-		.start	= AT91_BASE_SYS + AT91_DBGU,
-		.end	= AT91_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.start	= AT91SAM9RL_BASE_DBGU,
+		.end	= AT91SAM9RL_BASE_DBGU + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/arch/arm/mach-at91/include/mach/at91_dbgu.h b/arch/arm/mach-at91/include/mach/at91_dbgu.h
index dbfe455a..2aa0c5e 100644
--- a/arch/arm/mach-at91/include/mach/at91_dbgu.h
+++ b/arch/arm/mach-at91/include/mach/at91_dbgu.h
@@ -19,7 +19,7 @@
 #define dbgu_readl(dbgu, field) \
 	__raw_readl(AT91_VA_BASE_SYS + dbgu + AT91_DBGU_ ## field)
 
-#ifdef AT91_DBGU
+#if !defined(CONFIG_ARCH_AT91X40)
 #define AT91_DBGU_CR		(0x00)	/* Control Register */
 #define AT91_DBGU_MR		(0x04)	/* Mode Register */
 #define AT91_DBGU_IER		(0x08)	/* Interrupt Enable Register */
diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
index 844cba1..6bcb188 100644
--- a/arch/arm/mach-at91/include/mach/at91cap9.h
+++ b/arch/arm/mach-at91/include/mach/at91cap9.h
@@ -82,7 +82,6 @@
 #define AT91_BCRAMC	(0xffffe400 - AT91_BASE_SYS)
 #define AT91_DDRSDRC0	(0xffffe600 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffea00 - AT91_BASE_SYS)
-#define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
@@ -94,6 +93,7 @@
 #define AT91CAP9_BASE_DMA	0xffffec00
 #define AT91CAP9_BASE_SMC	0xffffe800
 #define AT91CAP9_BASE_CCFG	0xffffeb10
+#define AT91CAP9_BASE_DBGU	AT91_BASE_DBGU1
 #define AT91CAP9_BASE_PIOA	0xfffff200
 #define AT91CAP9_BASE_PIOB	0xfffff400
 #define AT91CAP9_BASE_PIOC	0xfffff600
diff --git a/arch/arm/mach-at91/include/mach/at91rm9200.h b/arch/arm/mach-at91/include/mach/at91rm9200.h
index 5740954..1f767e2 100644
--- a/arch/arm/mach-at91/include/mach/at91rm9200.h
+++ b/arch/arm/mach-at91/include/mach/at91rm9200.h
@@ -80,12 +80,12 @@
  * System Peripherals (offset from AT91_BASE_SYS)
  */
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)	/* Advanced Interrupt Controller */
-#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)	/* Debug Unit */
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)	/* Power Management Controller */
 #define AT91_ST		(0xfffffd00 - AT91_BASE_SYS)	/* System Timer */
 #define AT91_RTC	(0xfffffe00 - AT91_BASE_SYS)	/* Real-Time Clock */
 #define AT91_MC		(0xffffff00 - AT91_BASE_SYS)	/* Memory Controllers */
 
+#define AT91RM9200_BASE_DBGU	AT91_BASE_DBGU0	/* Debug Unit */
 #define AT91RM9200_BASE_PIOA	0xfffff400	/* PIO Controller A */
 #define AT91RM9200_BASE_PIOB	0xfffff600	/* PIO Controller B */
 #define AT91RM9200_BASE_PIOC	0xfffff800	/* PIO Controller C */
diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
index 8a26045..6deddb6 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9260.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
@@ -83,7 +83,6 @@
 #define AT91_SDRAMC0	(0xffffea00 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
-#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
@@ -91,6 +90,7 @@
 #define AT91SAM9260_BASE_ECC	0xffffe800
 #define AT91SAM9260_BASE_SMC	0xffffec00
 #define AT91SAM9260_BASE_CCFG	0xffffef10
+#define AT91SAM9260_BASE_DBGU	AT91_BASE_DBGU0
 #define AT91SAM9260_BASE_PIOA	0xfffff400
 #define AT91SAM9260_BASE_PIOB	0xfffff600
 #define AT91SAM9260_BASE_PIOC	0xfffff800
diff --git a/arch/arm/mach-at91/include/mach/at91sam9261.h b/arch/arm/mach-at91/include/mach/at91sam9261.h
index df2ddfd..2ccc8a53 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9261.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9261.h
@@ -68,12 +68,12 @@
 #define AT91_SDRAMC0	(0xffffea00 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
-#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
 
 #define AT91SAM9261_BASE_SMC	0xffffec00
+#define AT91SAM9261_BASE_DBGU	AT91_BASE_DBGU0
 #define AT91SAM9261_BASE_PIOA	0xfffff400
 #define AT91SAM9261_BASE_PIOB	0xfffff600
 #define AT91SAM9261_BASE_PIOC	0xfffff800
diff --git a/arch/arm/mach-at91/include/mach/at91sam9263.h b/arch/arm/mach-at91/include/mach/at91sam9263.h
index f958ac9..f9eebb6 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9263.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9263.h
@@ -77,7 +77,6 @@
 #define AT91_SDRAMC0	(0xffffe200 - AT91_BASE_SYS)
 #define AT91_SDRAMC1	(0xffffe800 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffec00 - AT91_BASE_SYS)
-#define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
@@ -88,6 +87,7 @@
 #define AT91SAM9263_BASE_ECC1	0xffffe600
 #define AT91SAM9263_BASE_SMC1	0xffffea00
 #define AT91SAM9263_BASE_CCFG	0xffffed10
+#define AT91SAM9263_BASE_DBGU	AT91_BASE_DBGU1
 #define AT91SAM9263_BASE_PIOA	0xfffff200
 #define AT91SAM9263_BASE_PIOB	0xfffff400
 #define AT91SAM9263_BASE_PIOC	0xfffff600
diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
index 65098c3..211721b 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
@@ -89,7 +89,6 @@
 #define AT91_DDRSDRC1	(0xffffe400 - AT91_BASE_SYS)
 #define AT91_DDRSDRC0	(0xffffe600 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffea00 - AT91_BASE_SYS)
-#define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
@@ -99,6 +98,7 @@
 #define AT91SAM9G45_BASE_ECC	0xffffe200
 #define AT91SAM9G45_BASE_DMA	0xffffec00
 #define AT91SAM9G45_BASE_SMC	0xffffe800
+#define AT91SAM9G45_BASE_DBGU	AT91_BASE_DBGU1
 #define AT91SAM9G45_BASE_PIOA	0xfffff200
 #define AT91SAM9G45_BASE_PIOB	0xfffff400
 #define AT91SAM9G45_BASE_PIOC	0xfffff600
diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
index 6aee975..c7e3ab6 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
@@ -72,7 +72,6 @@
 #define AT91_SDRAMC0	(0xffffea00 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
-#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SCKCR	(0xfffffd50 - AT91_BASE_SYS)
@@ -83,6 +82,7 @@
 #define AT91SAM9RL_BASE_ECC	0xffffe800
 #define AT91SAM9RL_BASE_SMC	0xffffec00
 #define AT91SAM9RL_BASE_CCFG	0xffffef10
+#define AT91SAM9RL_BASE_DBGU	AT91_BASE_DBGU0
 #define AT91SAM9RL_BASE_PIOA	0xfffff400
 #define AT91SAM9RL_BASE_PIOB	0xfffff600
 #define AT91SAM9RL_BASE_PIOC	0xfffff800
diff --git a/arch/arm/mach-at91/include/mach/debug-macro.S b/arch/arm/mach-at91/include/mach/debug-macro.S
index 0ed8648..c6bb9e2 100644
--- a/arch/arm/mach-at91/include/mach/debug-macro.S
+++ b/arch/arm/mach-at91/include/mach/debug-macro.S
@@ -14,9 +14,15 @@
 #include <mach/hardware.h>
 #include <mach/at91_dbgu.h>
 
+#if defined(CONFIG_AT91_DEBUG_LL_DBGU0)
+#define AT91_DBGU AT91_BASE_DBGU0
+#else
+#define AT91_DBGU AT91_BASE_DBGU1
+#endif
+
 	.macro	addruart, rp, rv, tmp
-	ldr	\rp, =(AT91_BASE_SYS + AT91_DBGU)	@ System peripherals (phys address)
-	ldr	\rv, =(AT91_VA_BASE_SYS	+ AT91_DBGU)	@ System peripherals (virt address)
+	ldr	\rp, =AT91_DBGU				@ System peripherals (phys address)
+	ldr	\rv, =AT91_IO_P2V(AT91_DBGU)		@ System peripherals (virt address)
 	.endm
 
 	.macro	senduart,rd,rx
diff --git a/arch/arm/mach-at91/include/mach/hardware.h b/arch/arm/mach-at91/include/mach/hardware.h
index d0f634e2..8d24034 100644
--- a/arch/arm/mach-at91/include/mach/hardware.h
+++ b/arch/arm/mach-at91/include/mach/hardware.h
@@ -16,6 +16,12 @@
 
 #include <asm/sizes.h>
 
+/* DBGU base */
+/* rm9200, 9260/9g20, 9261/9g10, 9rl */
+#define AT91_BASE_DBGU0	0xfffff200
+/* 9263, 9g45, cap9 */
+#define AT91_BASE_DBGU1	0xffffee00
+
 #if defined(CONFIG_ARCH_AT91RM9200)
 #include <mach/at91rm9200.h>
 #elif defined(CONFIG_ARCH_AT91SAM9260)
diff --git a/arch/arm/mach-at91/include/mach/uncompress.h b/arch/arm/mach-at91/include/mach/uncompress.h
index 18bdcde..0234fd9 100644
--- a/arch/arm/mach-at91/include/mach/uncompress.h
+++ b/arch/arm/mach-at91/include/mach/uncompress.h
@@ -24,8 +24,10 @@
 #include <linux/io.h>
 #include <linux/atmel_serial.h>
 
-#if defined(CONFIG_AT91_EARLY_DBGU)
-#define UART_OFFSET (AT91_DBGU + AT91_BASE_SYS)
+#if defined(CONFIG_AT91_EARLY_DBGU0)
+#define UART_OFFSET AT91_BASE_DBGU0
+#elif defined(CONFIG_AT91_EARLY_DBGU1)
+#define UART_OFFSET AT91_BASE_DBGU1
 #elif defined(CONFIG_AT91_EARLY_USART0)
 #define UART_OFFSET AT91_USART0
 #elif defined(CONFIG_AT91_EARLY_USART1)
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 8ba2790..de93b7d 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -93,9 +93,6 @@ void at91_iounmap(volatile void __iomem *addr)
 }
 EXPORT_SYMBOL(at91_iounmap);
 
-#define AT91_DBGU0	0xfffff200
-#define AT91_DBGU1	0xffffee00
-
 static void __init soc_detect(u32 dbgu_base)
 {
 	u32 cidr, socid;
@@ -268,9 +265,9 @@ void __init at91_map_io(void)
 	at91_soc_initdata.type = AT91_SOC_NONE;
 	at91_soc_initdata.subtype = AT91_SOC_SUBTYPE_NONE;
 
-	soc_detect(AT91_DBGU0);
+	soc_detect(AT91_BASE_DBGU0);
 	if (!at91_soc_is_detected())
-		soc_detect(AT91_DBGU1);
+		soc_detect(AT91_BASE_DBGU1);
 
 	if (!at91_soc_is_detected())
 		panic("AT91: Impossible to detect the SOC type");
-- 
1.7.7
