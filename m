From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 10 May 2011 18:34:15 +0200
Subject: [PATCH 5/9] at91: use structure to store the current soc
In-Reply-To: <20110510162730.GA18929@game.jcrosoft.org>
References: <20110510162730.GA18929@game.jcrosoft.org>
Message-ID: <1305045259-23066-5-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

instead of reading the registers everytime

the current implementation respect the following constrain:
 - allow 1 to n soc to be enabled
 - allow to have a virtual cpu type and subtype
 - always detect the cpu type and subtype and report it
 - detect if the soc support is enabled
 - prepare for sysfs export support
 - drop soc specific code via compiler when the soc not enabled
   (via cpu_is_xxx)

Today if we read the exid we will have the same value for 9g35 and 9m11
and we will need to check the cidr too

with the new implementation we just need to check the soc subtype

this will also allow to have specific virtual subtype for rm9200 which the
board will have to specify via at91rm9200_set_type(int) as we have no way to
detect it.

this implementation is inspired by the SH cpu detection support

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/mach-at91/at91rm9200.c       |    8 -
 arch/arm/mach-at91/at91sam9260.c      |    7 +-
 arch/arm/mach-at91/at91sam9rl.c       |    7 +-
 arch/arm/mach-at91/include/mach/cpu.h |  165 +++++++++++++-----------
 arch/arm/mach-at91/setup.c            |  227 +++++++++++++++++++++++++++++----
 arch/arm/mach-at91/soc.h              |   38 ++++++
 6 files changed, 337 insertions(+), 115 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 89e4807..9c8c8ce 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -313,14 +313,6 @@ static void at91rm9200_reset(void)
 	at91_sys_write(AT91_ST_CR, AT91_ST_WDRST);
 }
 
-int rm9200_type;
-EXPORT_SYMBOL(rm9200_type);
-
-void __init at91rm9200_set_type(int type)
-{
-	rm9200_type = type;
-}
-
 /* --------------------------------------------------------------------
  *  AT91RM9200 processor initialization
  * -------------------------------------------------------------------- */
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 291beb7..cac454e 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -17,6 +17,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/cpu.h>
+#include <mach/at91_dbgu.h>
 #include <mach/at91sam9260.h>
 #include <mach/at91_pmc.h>
 #include <mach/at91_rstc.h>
@@ -334,11 +335,9 @@ static void at91sam9260_poweroff(void)
 
 static void __init at91sam9xe_map_io(void)
 {
-	unsigned long cidr, sram_size;
+	unsigned long sram_size;
 
-	cidr = dbgu_readl(AT91_DBGU, CIDR);
-
-	switch (cidr & AT91_CIDR_SRAMSIZ) {
+	switch (at91_soc_data.cidr & AT91_CIDR_SRAMSIZ) {
 		case AT91_CIDR_SRAMSIZ_32K:
 			sram_size = 2 * SZ_16K;
 			break;
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 86fc31c..c25c173 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -16,6 +16,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/cpu.h>
+#include <mach/at91_dbgu.h>
 #include <mach/at91sam9rl.h>
 #include <mach/at91_pmc.h>
 #include <mach/at91_rstc.h>
@@ -297,11 +298,9 @@ static void at91sam9rl_poweroff(void)
 
 static void __init at91sam9rl_map_io(void)
 {
-	unsigned long cidr, sram_size;
+	unsigned long sram_size;
 
-	cidr = dbgu_readl(AT91_DBGU, CIDR);
-
-	switch (cidr & AT91_CIDR_SRAMSIZ) {
+	switch (at91_soc_data.cidr & AT91_CIDR_SRAMSIZ) {
 		case AT91_CIDR_SRAMSIZ_32K:
 			sram_size = 2 * SZ_16K;
 			break;
diff --git a/arch/arm/mach-at91/include/mach/cpu.h b/arch/arm/mach-at91/include/mach/cpu.h
index 0d81087..66b27a9f 100644
--- a/arch/arm/mach-at91/include/mach/cpu.h
+++ b/arch/arm/mach-at91/include/mach/cpu.h
@@ -1,7 +1,8 @@
 /*
  * arch/arm/mach-at91/include/mach/cpu.h
  *
- *  Copyright (C) 2006 SAN People
+ * Copyright (C) 2006 SAN People
+ * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -10,12 +11,8 @@
  *
  */
 
-#ifndef __ASM_ARCH_CPU_H
-#define __ASM_ARCH_CPU_H
-
-#include <mach/hardware.h>
-#include <mach/at91_dbgu.h>
-
+#ifndef __MACH_CPU_H__
+#define __MACH_CPU_H__
 
 #define ARCH_ID_AT91RM9200	0x09290780
 #define ARCH_ID_AT91SAM9260	0x019803a0
@@ -41,16 +38,6 @@
 #define ARCH_ID_AT91M40807	0x14080745
 #define ARCH_ID_AT91R40008	0x44000840
 
-static inline unsigned long at91_cpu_identify(void)
-{
-	return (dbgu_readl(AT91_DBGU, CIDR) & ~AT91_CIDR_VERSION);
-}
-
-static inline unsigned long at91_cpu_fully_identify(void)
-{
-	return dbgu_readl(AT91_DBGU, CIDR);
-}
-
 #define ARCH_EXID_AT91SAM9M11	0x00000001
 #define ARCH_EXID_AT91SAM9M10	0x00000002
 #define ARCH_EXID_AT91SAM9G46	0x00000003
@@ -62,40 +49,78 @@ static inline unsigned long at91_cpu_fully_identify(void)
 #define ARCH_EXID_AT91SAM9G25	0x00000003
 #define ARCH_EXID_AT91SAM9X25	0x00000004
 
-static inline unsigned long at91_exid_identify(void)
-{
-	return dbgu_readl(AT91_DBGU, EXID);
-}
-
-
 #define ARCH_FAMILY_AT91X92	0x09200000
 #define ARCH_FAMILY_AT91SAM9	0x01900000
 #define ARCH_FAMILY_AT91SAM9XE	0x02900000
 
-static inline unsigned long at91_arch_identify(void)
-{
-	return (dbgu_readl(AT91_DBGU, CIDR) & AT91_CIDR_ARCH);
-}
-
-#ifdef CONFIG_ARCH_AT91CAP9
-#include <mach/at91_pmc.h>
-
+/* PMC revision */
 #define ARCH_REVISION_CAP9_B	0x399
 #define ARCH_REVISION_CAP9_C	0x601
 
-static inline unsigned long at91cap9_rev_identify(void)
-{
-	return (at91_sys_read(AT91_PMC_VER));
-}
-#endif
-
-#ifdef CONFIG_ARCH_AT91RM9200
-extern int rm9200_type;
+/* RM9200 type */
 #define ARCH_REVISON_9200_BGA	(0 << 0)
 #define ARCH_REVISON_9200_PQFP	(1 << 0)
-#define cpu_is_at91rm9200()	(at91_cpu_identify() == ARCH_ID_AT91RM9200)
-#define cpu_is_at91rm9200_bga()	(!cpu_is_at91rm9200_pqfp())
-#define cpu_is_at91rm9200_pqfp() (cpu_is_at91rm9200() && rm9200_type & ARCH_REVISON_9200_PQFP)
+
+enum soc_type {
+	/* 920T */
+	SOC_RM9200,
+
+	/* DIPSIS */
+	SOC_572D940HF,
+
+	/* CAP */
+	SOC_CAP9,
+
+	/* SAM92xx */
+	SOC_SAM9260, SOC_SAM9261, SOC_SAM9263,
+
+	/* SAM9Gxx */
+	SOC_SAM9G10, SOC_SAM9G20, SOC_SAM9G45,
+
+	/* SAM9RL */
+	SOC_SAM9RL,
+
+	/* SAM9X5 */
+	SOC_SAM9X5,
+
+	/* Unknown type */
+	SOC_AT91_NONE
+};
+
+enum soc_sub_type {
+	/* RM9200 */
+	SOC_RM9200_BGA, SOC_RM9200_PQFP,
+
+	/* CAP9 */
+	SOC_CAP9_REV_B, SOC_CAP9_REV_C,
+
+	/* SAM9260 */
+	SOC_SAM9XE,
+
+	/* SAM9G45 */
+	SOC_SAM9G45ES, SOC_SAM9M10, SOC_SAM9G46, SOC_SAM9M11,
+
+	/* SAM9X5 */
+	SOC_SAM9G15, SOC_SAM9G35, SOC_SAM9X35,
+	SOC_SAM9G25, SOC_SAM9X25,
+
+	/* Unknown subtype */
+	SOC_AT91_SUBTYPE_NONE
+};
+
+struct at91_socinfo {
+	unsigned int type, subtype;
+	unsigned int cidr, exid;
+};
+
+extern struct at91_socinfo at91_soc_data;
+const char *get_at91_soc_type(struct at91_socinfo *c);
+const char *get_at91_soc_subtype(struct at91_socinfo *c);
+
+#ifdef CONFIG_ARCH_AT91RM9200
+#define cpu_is_at91rm9200()	(at91_soc_data.type == SOC_RM9200)
+#define cpu_is_at91rm9200_bga()	(at91_soc_data.subtype == SOC_RM9200_BGA)
+#define cpu_is_at91rm9200_pqfp() (at91_soc_data.subtype == SOC_RM9200_PQFP)
 #else
 #define cpu_is_at91rm9200()	(0)
 #define cpu_is_at91rm9200_bga()	(0)
@@ -103,52 +128,49 @@ extern int rm9200_type;
 #endif
 
 #ifdef CONFIG_ARCH_AT91SAM9260
-#define cpu_is_at91sam9xe()	(at91_arch_identify() == ARCH_FAMILY_AT91SAM9XE)
-#define cpu_is_at91sam9260()	((at91_cpu_identify() == ARCH_ID_AT91SAM9260) || cpu_is_at91sam9xe())
+#define cpu_is_at91sam9xe()	(at91_soc_data.subtype == SOC_SAM9XE)
+#define cpu_is_at91sam9260()	(at91_soc_data.type == SOC_SAM9260)
 #else
 #define cpu_is_at91sam9xe()	(0)
 #define cpu_is_at91sam9260()	(0)
 #endif
 
 #ifdef CONFIG_ARCH_AT91SAM9G20
-#define cpu_is_at91sam9g20()	(at91_cpu_identify() == ARCH_ID_AT91SAM9G20)
+#define cpu_is_at91sam9g20()	(at91_soc_data.type == SOC_SAM9G20)
 #else
 #define cpu_is_at91sam9g20()	(0)
 #endif
 
 #ifdef CONFIG_ARCH_AT91SAM9261
-#define cpu_is_at91sam9261()	(at91_cpu_identify() == ARCH_ID_AT91SAM9261)
+#define cpu_is_at91sam9261()	(at91_soc_data.type == SOC_SAM9261)
 #else
 #define cpu_is_at91sam9261()	(0)
 #endif
 
 #ifdef CONFIG_ARCH_AT91SAM9G10
-#define cpu_is_at91sam9g10()	((at91_cpu_identify() & ~AT91_CIDR_EXT)	== ARCH_ID_AT91SAM9G10)
+#define cpu_is_at91sam9g10()	(at91_soc_data.type == SOC_SAM9G10)
 #else
 #define cpu_is_at91sam9g10()	(0)
 #endif
 
 #ifdef CONFIG_ARCH_AT91SAM9263
-#define cpu_is_at91sam9263()	(at91_cpu_identify() == ARCH_ID_AT91SAM9263)
+#define cpu_is_at91sam9263()	(at91_soc_data.type == SOC_SAM9263)
 #else
 #define cpu_is_at91sam9263()	(0)
 #endif
 
 #ifdef CONFIG_ARCH_AT91SAM9RL
-#define cpu_is_at91sam9rl()	(at91_cpu_identify() == ARCH_ID_AT91SAM9RL64)
+#define cpu_is_at91sam9rl()	(at91_soc_data.type == SOC_SAM9RL)
 #else
 #define cpu_is_at91sam9rl()	(0)
 #endif
 
 #ifdef CONFIG_ARCH_AT91SAM9G45
-#define cpu_is_at91sam9g45()	(at91_cpu_identify() == ARCH_ID_AT91SAM9G45)
-#define cpu_is_at91sam9g45es()	(at91_cpu_fully_identify() == ARCH_ID_AT91SAM9G45ES)
-#define cpu_is_at91sam9m10()    (cpu_is_at91sam9g45() && \
-                                (at91_exid_identify() == ARCH_EXID_AT91SAM9M10))
-#define cpu_is_at91sam9m46()    (cpu_is_at91sam9g45() && \
-                                (at91_exid_identify() == ARCH_EXID_AT91SAM9G46))
-#define cpu_is_at91sam9m11()    (cpu_is_at91sam9g45() && \
-                                (at91_exid_identify() == ARCH_EXID_AT91SAM9M11))
+#define cpu_is_at91sam9g45()	(at91_soc_data.type == SOC_SAM9G45)
+#define cpu_is_at91sam9g45es()	(at91_soc_data.subtype == SOC_SAM9G45ES)
+#define cpu_is_at91sam9m10()	(at91_soc_data.subtype == SOC_SAM9M10)
+#define cpu_is_at91sam9g46()	(at91_soc_data.subtype == SOC_SAM9G46)
+#define cpu_is_at91sam9m11()	(at91_soc_data.subtype == SOC_SAM9M11)
 #else
 #define cpu_is_at91sam9g45()	(0)
 #define cpu_is_at91sam9g45es()	(0)
@@ -158,17 +180,12 @@ extern int rm9200_type;
 #endif
 
 #ifdef CONFIG_ARCH_AT91SAM9X5
-#define cpu_is_at91sam9x5()	(at91_cpu_identify() == ARCH_ID_AT91SAM9X5)
-#define cpu_is_at91sam9g15()	(cpu_is_at91sam9x5() && \
-				(at91_exid_identify() == ARCH_EXID_AT91SAM9G15))
-#define cpu_is_at91sam9g35()	(cpu_is_at91sam9x5() && \
-				(at91_exid_identify() == ARCH_EXID_AT91SAM9G35))
-#define cpu_is_at91sam9x35()	(cpu_is_at91sam9x5() && \
-				(at91_exid_identify() == ARCH_EXID_AT91SAM9X35))
-#define cpu_is_at91sam9g25()	(cpu_is_at91sam9x5() && \
-				(at91_exid_identify() == ARCH_EXID_AT91SAM9G25))
-#define cpu_is_at91sam9x25()	(cpu_is_at91sam9x5() && \
-				(at91_exid_identify() == ARCH_EXID_AT91SAM9X25))
+#define cpu_is_at91sam9x5()	(at91_soc_data.type == SOC_SAM9X5)
+#define cpu_is_at91sam9g15()	(at91_soc_data.subtype == SOC_SAM9G15)
+#define cpu_is_at91sam9g35()	(at91_soc_data.subtype == SOC_SAM9G35)
+#define cpu_is_at91sam9x35()	(at91_soc_data.subtype == SOC_SAM9X35)
+#define cpu_is_at91sam9g25()	(at91_soc_data.subtype == SOC_SAM9G25)
+#define cpu_is_at91sam9x25()	(at91_soc_data.subtype == SOC_SAM9X25)
 #else
 #define cpu_is_at91sam9x5()	(0)
 #define cpu_is_at91sam9g15()	(0)
@@ -179,9 +196,9 @@ extern int rm9200_type;
 #endif
 
 #ifdef CONFIG_ARCH_AT91CAP9
-#define cpu_is_at91cap9()	(at91_cpu_identify() == ARCH_ID_AT91CAP9)
-#define cpu_is_at91cap9_revB()	(at91cap9_rev_identify() == ARCH_REVISION_CAP9_B)
-#define cpu_is_at91cap9_revC()	(at91cap9_rev_identify() == ARCH_REVISION_CAP9_C)
+#define cpu_is_at91cap9()	(at91_soc_data.type == SOC_CAP9)
+#define cpu_is_at91cap9_revB()	(at91_soc_data.subtype == SOC_CAP9_REV_B)
+#define cpu_is_at91cap9_revC()	(at91_soc_data.subtype == SOC_CAP9_REV_C)
 #else
 #define cpu_is_at91cap9()	(0)
 #define cpu_is_at91cap9_revB()	(0)
@@ -189,9 +206,9 @@ extern int rm9200_type;
 #endif
 
 #ifdef CONFIG_ARCH_AT572D940HF
-#define cpu_is_at572d940hf() (at91_cpu_identify() == ARCH_ID_AT572D940HF)
+#define cpu_is_at572d940hf()	(at91_soc_data.type == SOC_572D940HF)
 #else
-#define cpu_is_at572d940hf() (0)
+#define cpu_is_at572d940hf()	(0)
 #endif
 
 /*
@@ -200,4 +217,4 @@ extern int rm9200_type;
  */
 #define cpu_is_at32ap7000()	(0)
 
-#endif
+#endif /* __MACH_CPU_H__ */
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index c8f23ae..df6ee4f 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -12,15 +12,28 @@
 
 #include <mach/hardware.h>
 #include <mach/cpu.h>
+#include <mach/at91_dbgu.h>
+#include <mach/at91_pmc.h>
 
 #include "soc.h"
 #include "generic.h"
 
 struct at91_soc __initdata at91_boot_soc;
 
+struct at91_socinfo at91_soc_data;
+EXPORT_SYMBOL(at91_soc_data);
+
+void __init at91rm9200_set_type(int type)
+{
+	if (type == ARCH_REVISON_9200_PQFP)
+		at91_soc_data.subtype = SOC_RM9200_BGA;
+	else
+		at91_soc_data.subtype = SOC_RM9200_PQFP;
+}
+
 void __init at91_init_irq_default(void)
 {
-	at91_init_interrupts(current_soc.default_irq_priority);
+	at91_init_interrupts(at91_boot_soc.default_irq_priority);
 }
 
 void __init at91_init_interrupts(unsigned int *priority)
@@ -39,35 +52,199 @@ static struct map_desc at91_io_desc __initdata = {
 	.type		= MT_DEVICE,
 };
 
+#define AT91_DBGU0	0xfffff200
+#define AT91_DBGU1	0xffffee00
+
+static void soc_detect(u32 dbgu_base)
+{
+	u32 cidr, socid;
+
+	cidr = __raw_readl(AT91_IO_P2V(dbgu_base) + AT91_DBGU_CIDR);
+	socid = cidr & ~AT91_CIDR_VERSION;
+
+	switch (socid) {
+	case ARCH_ID_AT572D940HF:
+		at91_soc_data.type = SOC_572D940HF;
+		set_at91_boot_soc(at572d940hf_soc);
+		break;
+
+	case ARCH_ID_AT91CAP9: {
+#ifdef CONFIG_AT91_PMC_UNIT
+		u32 pmc_ver = at91_sys_read(AT91_PMC_VER);
+
+		if (pmc_ver == ARCH_REVISION_CAP9_B)
+			at91_soc_data.subtype = SOC_CAP9_REV_B;
+		else if (pmc_ver == ARCH_REVISION_CAP9_C)
+			at91_soc_data.subtype = SOC_CAP9_REV_C;
+#endif
+		at91_soc_data.type = SOC_CAP9;
+		set_at91_boot_soc(at91cap9_soc);
+		break;
+	}
+
+	case ARCH_ID_AT91RM9200:
+		at91_soc_data.type = SOC_RM9200;
+		set_at91_boot_soc(at91rm9200_soc);
+		break;
+
+	case ARCH_ID_AT91SAM9260:
+		at91_soc_data.type = SOC_SAM9260;
+		set_at91_boot_soc(at91sam9260_soc);
+		break;
+
+	case ARCH_ID_AT91SAM9261:
+		at91_soc_data.type = SOC_SAM9261;
+		set_at91_boot_soc(at91sam9261_soc);
+		break;
+
+	case ARCH_ID_AT91SAM9263:
+		at91_soc_data.type = SOC_SAM9263;
+		set_at91_boot_soc(at91sam9263_soc);
+		break;
+
+	case ARCH_ID_AT91SAM9G20:
+		at91_soc_data.type = SOC_SAM9G20;
+		set_at91_boot_soc(at91sam9260_soc);
+		break;
+
+	case ARCH_ID_AT91SAM9G45:
+		at91_soc_data.type = SOC_SAM9G45;
+		if (cidr == ARCH_ID_AT91SAM9G45ES)
+			at91_soc_data.subtype = SOC_SAM9G45ES;
+		set_at91_boot_soc(at91sam9g45_soc);
+		break;
+
+	case ARCH_ID_AT91SAM9RL64:
+		at91_soc_data.type = SOC_SAM9RL;
+		set_at91_boot_soc(at91sam9rl_soc);
+		break;
+
+	case ARCH_ID_AT91SAM9X5:
+		at91_soc_data.type = SOC_SAM9X5;
+		set_at91_boot_soc(at91sam9x5_soc);
+		break;
+	}
+
+	/* at91sam9g10 */
+	if ((cidr & ~AT91_CIDR_EXT) == ARCH_ID_AT91SAM9G10) {
+		at91_soc_data.type = SOC_SAM9G10;
+		set_at91_boot_soc(at91sam9261_soc);
+	}
+	/* at91sam9xe */
+	else if ((cidr & AT91_CIDR_ARCH) == ARCH_FAMILY_AT91SAM9XE) {
+		at91_soc_data.type = SOC_SAM9260;
+		at91_soc_data.subtype = SOC_SAM9XE;
+		set_at91_boot_soc(at91sam9260_soc);
+	}
+
+	if (at91_soc_data.type == SOC_AT91_NONE)
+		return;
+
+	at91_soc_data.cidr = cidr;
+
+	/* sub version of soc */
+	at91_soc_data.exid = __raw_readl(AT91_IO_P2V(dbgu_base) + AT91_DBGU_EXID);
+
+	if (at91_soc_data.type == SOC_SAM9G45) {
+		switch (at91_soc_data.exid) {
+		case ARCH_EXID_AT91SAM9M10:
+			at91_soc_data.subtype = SOC_SAM9M10;
+			break;
+		case ARCH_EXID_AT91SAM9G46:
+			at91_soc_data.subtype = SOC_SAM9G46;
+			break;
+		case ARCH_EXID_AT91SAM9M11:
+			at91_soc_data.subtype = SOC_SAM9M11;
+			break;
+		}
+	}
+
+	if (at91_soc_data.type == SOC_SAM9X5) {
+		switch (at91_soc_data.exid) {
+		case ARCH_EXID_AT91SAM9G15:
+			at91_soc_data.subtype = SOC_SAM9G15;
+			break;
+		case ARCH_EXID_AT91SAM9G35:
+			at91_soc_data.subtype = SOC_SAM9G35;
+			break;
+		case ARCH_EXID_AT91SAM9X35:
+			at91_soc_data.subtype = SOC_SAM9X35;
+			break;
+		case ARCH_EXID_AT91SAM9G25:
+			at91_soc_data.subtype = SOC_SAM9G25;
+			break;
+		case ARCH_EXID_AT91SAM9X25:
+			at91_soc_data.subtype = SOC_SAM9X25;
+			break;
+		}
+	}
+}
+
+static const char *soc_name[] = {
+	[SOC_RM9200]	= "at91rm9200",
+	[SOC_572D940HF]	= "at572d940hf",
+	[SOC_CAP9]	= "at91cap9",
+	[SOC_SAM9260]	= "at91sam9260",
+	[SOC_SAM9261]	= "at91sam9261",
+	[SOC_SAM9263]	= "at91sam9263",
+	[SOC_SAM9G10]	= "at91sam9g10",
+	[SOC_SAM9G20]	= "at91sam9g20",
+	[SOC_SAM9G45]	= "at91sam9g45",
+	[SOC_SAM9RL]	= "at91sam9rl",
+	[SOC_SAM9X5]	= "at91sam9x5",
+	[SOC_AT91_NONE]	= "Unknown"
+};
+
+const char *get_at91_soc_type(struct at91_socinfo *c)
+{
+	return soc_name[c->type];
+}
+EXPORT_SYMBOL(get_at91_soc_type);
+
+static const char *soc_subtype_name[] = {
+	[SOC_RM9200_BGA]	= "at91rm9200 BGA",
+	[SOC_RM9200_PQFP]	= "at91rm9200 PQFP",
+	[SOC_CAP9_REV_B]	= "at91cap9 revB",
+	[SOC_CAP9_REV_C]	= "at91cap9 revC",
+	[SOC_SAM9XE]		= "at91sam9xe",
+	[SOC_SAM9G45ES]		= "at91sam9g45es",
+	[SOC_SAM9M10]		= "at91sam9m10",
+	[SOC_SAM9G46]		= "at91sam9g46",
+	[SOC_SAM9M11]		= "at91sam9m11",
+	[SOC_SAM9G15]		= "at91sam9g15",
+	[SOC_SAM9G35]		= "at91sam9g35",
+	[SOC_SAM9X35]		= "at91sam9x35",
+	[SOC_SAM9G25]		= "at91sam9g25",
+	[SOC_SAM9X25]		= "at91sam9x25",
+	[SOC_AT91_SUBTYPE_NONE]	= "Unknown"
+};
+
+const char *get_at91_soc_subtype(struct at91_socinfo *c)
+{
+	return soc_subtype_name[c->subtype];
+}
+EXPORT_SYMBOL(get_at91_soc_subtype);
+
 void __init at91_map_io(void)
 {
 	/* Map peripherals */
 	iotable_init(&at91_io_desc, 1);
 
-	if (cpu_is_at572d940hf())
-		at91_boot_soc = at572d940hf_soc;
-	else if (cpu_is_at91cap9())
-		at91_boot_soc = at91cap9_soc;
-	else if (cpu_is_at91rm9200())
-		at91_boot_soc = at91rm9200_soc;
-	else if (cpu_is_at91sam9260())
-		at91_boot_soc = at91sam9260_soc;
-	else if (cpu_is_at91sam9261())
-		at91_boot_soc = at91sam9261_soc;
-	else if (cpu_is_at91sam9263())
-		at91_boot_soc = at91sam9263_soc;
-	else if (cpu_is_at91sam9g10())
-		at91_boot_soc = at91sam9261_soc;
-	else if (cpu_is_at91sam9g20())
-		at91_boot_soc = at91sam9260_soc;
-	else if (cpu_is_at91sam9g45())
-		at91_boot_soc = at91sam9g45_soc;
-	else if (cpu_is_at91sam9rl())
-		at91_boot_soc = at91sam9rl_soc;
-	else if (cpu_is_at91sam9x5())
-		at91_boot_soc = at91sam9x5_soc;
-	else
-		panic("Impossible to detect the SOC type");
+	at91_soc_data.type = SOC_AT91_NONE;
+	at91_soc_data.subtype = SOC_AT91_SUBTYPE_NONE;
+
+	soc_detect(AT91_DBGU0);
+	if (at91_soc_data.type == SOC_AT91_NONE)
+		soc_detect(AT91_DBGU1);
+
+	if (at91_soc_data.type == SOC_AT91_NONE)
+		panic("AT91: Impossible to detect the SOC type");
+
+	pr_info("AT91: Detected soc type: %s\n", get_at91_soc_type(&at91_soc_data));
+	pr_info("AT91: Detected soc subtype: %s\n", get_at91_soc_subtype(&at91_soc_data));
+
+	if (!at91_boot_soc.init)
+		panic("AT91: Soc not enabled");
 
 	if (at91_boot_soc.map_io)
 		at91_boot_soc.map_io();
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
index d847565..1125671 100644
--- a/arch/arm/mach-at91/soc.h
+++ b/arch/arm/mach-at91/soc.h
@@ -20,3 +20,41 @@ extern struct at91_soc at91sam9263_soc;
 extern struct at91_soc at91sam9g45_soc;
 extern struct at91_soc at91sam9rl_soc;
 extern struct at91_soc at91sam9x5_soc;
+
+#define set_at91_boot_soc(c) do { at91_boot_soc = c; } while(0)
+
+#if !defined(CONFIG_ARCH_AT572D940HF)
+#define at572d940hf_soc	at91_boot_soc
+#endif
+
+#if !defined(CONFIG_ARCH_AT91CAP9)
+#define at91cap9_soc	at91_boot_soc
+#endif
+
+#if !defined(CONFIG_ARCH_AT91RM9200)
+#define at91rm9200_soc	at91_boot_soc
+#endif
+
+#if !(defined(CONFIG_ARCH_AT91SAM9260) && defined(CONFIG_ARCH_AT91SAM9G20))
+#define at91sam9260_soc	at91_boot_soc
+#endif
+
+#if !(defined(CONFIG_ARCH_AT91SAM9261) && defined(CONFIG_ARCH_AT91SAM9G10))
+#define at91sam9261_soc	at91_boot_soc
+#endif
+
+#if !defined(CONFIG_ARCH_AT91SAM9263)
+#define at91sam9263_soc	at91_boot_soc
+#endif
+
+#if !defined(CONFIG_ARCH_AT91SAM9G45)
+#define at91sam9g45_soc	at91_boot_soc
+#endif
+
+#if !defined(CONFIG_ARCH_AT91SAM9RL)
+#define at91sam9rl_soc	at91_boot_soc
+#endif
+
+#if !defined(CONFIG_ARCH_AT91SAM9X5)
+#define at91sam9x5_soc	at91_boot_soc
+#endif
-- 
1.7.4.1
