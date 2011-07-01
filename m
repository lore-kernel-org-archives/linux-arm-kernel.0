From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri,  1 Jul 2011 08:44:38 +0200
Subject: [PATCH 4/8] at91: use structure to store the current soc
In-Reply-To: <1309502682-16897-1-git-send-email-plagnioj@jcrosoft.com>
References: <1309502682-16897-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1309502682-16897-4-git-send-email-plagnioj@jcrosoft.com>
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
 arch/arm/mach-at91/at91cap9.c         |    2 +-
 arch/arm/mach-at91/at91rm9200.c       |   10 +--
 arch/arm/mach-at91/at91sam9260.c      |    9 +-
 arch/arm/mach-at91/at91sam9261.c      |    2 +-
 arch/arm/mach-at91/at91sam9263.c      |    2 +-
 arch/arm/mach-at91/at91sam9g45.c      |    2 +-
 arch/arm/mach-at91/at91sam9rl.c       |    9 +-
 arch/arm/mach-at91/include/mach/cpu.h |  159 ++++++++++++++-----------
 arch/arm/mach-at91/setup.c            |  209 ++++++++++++++++++++++++++++++---
 arch/arm/mach-at91/soc.h              |   79 +++++++++----
 10 files changed, 352 insertions(+), 131 deletions(-)
 rewrite arch/arm/mach-at91/soc.h (63%)

diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index 9a01370..6287c0d 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -403,7 +403,7 @@ static unsigned int at91cap9_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller (IRQ1) */
 };
 
-struct at91_soc __initdata at91cap9_soc = {
+struct at91_init_soc __initdata at91cap9_soc = {
 	.map_io = at91cap9_map_io,
 	.default_irq_priority = at91cap9_default_irq_priority,
 	.init = at91cap9_initialize,
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index d7801be..36d37bd 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -300,14 +300,6 @@ static void at91rm9200_reset(void)
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
@@ -379,7 +371,7 @@ static unsigned int at91rm9200_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0	/* Advanced Interrupt Controller (IRQ6) */
 };
 
-struct at91_soc __initdata at91rm9200_soc = {
+struct at91_init_soc __initdata at91rm9200_soc = {
 	.map_io = at91rm9200_map_io,
 	.default_irq_priority = at91rm9200_default_irq_priority,
 	.init = at91rm9200_initialize,
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 57974b1..8a6b9aa 100644
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
@@ -322,11 +323,9 @@ static void at91sam9260_poweroff(void)
 
 static void __init at91sam9xe_map_io(void)
 {
-	unsigned long cidr, sram_size;
+	unsigned long sram_size;
 
-	cidr = dbgu_readl(AT91_DBGU, CIDR);
-
-	switch (cidr & AT91_CIDR_SRAMSIZ) {
+	switch (at91_soc_initdata.cidr & AT91_CIDR_SRAMSIZ) {
 		case AT91_CIDR_SRAMSIZ_32K:
 			sram_size = 2 * SZ_16K;
 			break;
@@ -410,7 +409,7 @@ static unsigned int at91sam9260_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller */
 };
 
-struct at91_soc __initdata at91sam9260_soc = {
+struct at91_init_soc __initdata at91sam9260_soc = {
 	.map_io = at91sam9260_map_io,
 	.default_irq_priority = at91sam9260_default_irq_priority,
 	.init = at91sam9260_initialize,
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 7a4a673..f6a2b30 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -361,7 +361,7 @@ static unsigned int at91sam9261_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller */
 };
 
-struct at91_soc __initdata at91sam9261_soc = {
+struct at91_init_soc __initdata at91sam9261_soc = {
 	.map_io = at91sam9261_map_io,
 	.default_irq_priority = at91sam9261_default_irq_priority,
 	.init = at91sam9261_initialize,
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 3140a13..7245a8e 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -372,7 +372,7 @@ static unsigned int at91sam9263_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller (IRQ1) */
 };
 
-struct at91_soc __initdata at91sam9263_soc = {
+struct at91_init_soc __initdata at91sam9263_soc = {
 	.map_io = at91sam9263_map_io,
 	.default_irq_priority = at91sam9263_default_irq_priority,
 	.init = at91sam9263_initialize,
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index f5e72da..57a4726 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -388,7 +388,7 @@ static unsigned int at91sam9g45_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller (IRQ0) */
 };
 
-struct at91_soc __initdata at91sam9g45_soc = {
+struct at91_init_soc __initdata at91sam9g45_soc = {
 	.map_io = at91sam9g45_map_io,
 	.default_irq_priority = at91sam9g45_default_irq_priority,
 	.init = at91sam9g45_initialize,
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 0788adb..b83098c 100644
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
@@ -281,11 +282,9 @@ static void at91sam9rl_poweroff(void)
 
 static void __init at91sam9rl_map_io(void)
 {
-	unsigned long cidr, sram_size;
+	unsigned long sram_size;
 
-	cidr = dbgu_readl(AT91_DBGU, CIDR);
-
-	switch (cidr & AT91_CIDR_SRAMSIZ) {
+	switch (at91_soc_initdata.cidr & AT91_CIDR_SRAMSIZ) {
 		case AT91_CIDR_SRAMSIZ_32K:
 			sram_size = 2 * SZ_16K;
 			break;
@@ -359,7 +358,7 @@ static unsigned int at91sam9rl_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller */
 };
 
-struct at91_soc __initdata at91sam9rl_soc = {
+struct at91_init_soc __initdata at91sam9rl_soc = {
 	.map_io = at91sam9rl_map_io,
 	.default_irq_priority = at91sam9rl_default_irq_priority,
 	.init = at91sam9rl_initialize,
diff --git a/arch/arm/mach-at91/include/mach/cpu.h b/arch/arm/mach-at91/include/mach/cpu.h
index 3cf6919..f6ce936 100644
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
@@ -39,16 +36,6 @@
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
@@ -60,40 +47,80 @@ static inline unsigned long at91_cpu_fully_identify(void)
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
+/* RM9200 type */
+#define ARCH_REVISON_9200_BGA	(0 << 0)
+#define ARCH_REVISON_9200_PQFP	(1 << 0)
+
+enum at91_soc_type {
+	/* 920T */
+	AT91_SOC_RM9200,
+
+	/* CAP */
+	AT91_SOC_CAP9,
+
+	/* SAM92xx */
+	AT91_SOC_SAM9260, AT91_SOC_SAM9261, AT91_SOC_SAM9263,
+
+	/* SAM9Gxx */
+	AT91_SOC_SAM9G10, AT91_SOC_SAM9G20, AT91_SOC_SAM9G45,
+
+	/* SAM9RL */
+	AT91_SOC_SAM9RL,
+
+	/* SAM9X5 */
+	AT91_SOC_SAM9X5,
+
+	/* Unknown type */
+	AT91_SOC_NONE
+};
+
+enum at91_soc_subtype {
+	/* RM9200 */
+	AT91_SOC_RM9200_BGA, AT91_SOC_RM9200_PQFP,
+
+	/* CAP9 */
+	AT91_SOC_CAP9_REV_B, AT91_SOC_CAP9_REV_C,
+
+	/* SAM9260 */
+	AT91_SOC_SAM9XE,
+
+	/* SAM9G45 */
+	AT91_SOC_SAM9G45ES, AT91_SOC_SAM9M10, AT91_SOC_SAM9G46, AT91_SOC_SAM9M11,
+
+	/* SAM9X5 */
+	AT91_SOC_SAM9G15, AT91_SOC_SAM9G35, AT91_SOC_SAM9X35,
+	AT91_SOC_SAM9G25, AT91_SOC_SAM9X25,
+
+	/* Unknown subtype */
+	AT91_SOC_SUBTYPE_NONE
+};
+
+struct at91_socinfo {
+	unsigned int type, subtype;
+	unsigned int cidr, exid;
+};
+
+extern struct at91_socinfo at91_soc_initdata;
+const char *at91_get_soc_type(struct at91_socinfo *c);
+const char *at91_get_soc_subtype(struct at91_socinfo *c);
+
+static inline int at91_soc_is_detected(void)
 {
-	return (at91_sys_read(AT91_PMC_VER));
+	return at91_soc_initdata.type != AT91_SOC_NONE;
 }
-#endif
 
 #ifdef CONFIG_ARCH_AT91RM9200
-extern int rm9200_type;
-#define ARCH_REVISON_9200_BGA	(0 << 0)
-#define ARCH_REVISON_9200_PQFP	(1 << 0)
-#define cpu_is_at91rm9200()	(at91_cpu_identify() == ARCH_ID_AT91RM9200)
-#define cpu_is_at91rm9200_bga()	(!cpu_is_at91rm9200_pqfp())
-#define cpu_is_at91rm9200_pqfp() (cpu_is_at91rm9200() && rm9200_type & ARCH_REVISON_9200_PQFP)
+#define cpu_is_at91rm9200()	(at91_soc_initdata.type == AT91_SOC_RM9200)
+#define cpu_is_at91rm9200_bga()	(at91_soc_initdata.subtype == AT91_SOC_RM9200_BGA)
+#define cpu_is_at91rm9200_pqfp() (at91_soc_initdata.subtype == AT91_SOC_RM9200_PQFP)
 #else
 #define cpu_is_at91rm9200()	(0)
 #define cpu_is_at91rm9200_bga()	(0)
@@ -101,52 +128,49 @@ extern int rm9200_type;
 #endif
 
 #ifdef CONFIG_ARCH_AT91SAM9260
-#define cpu_is_at91sam9xe()	(at91_arch_identify() == ARCH_FAMILY_AT91SAM9XE)
-#define cpu_is_at91sam9260()	((at91_cpu_identify() == ARCH_ID_AT91SAM9260) || cpu_is_at91sam9xe())
+#define cpu_is_at91sam9xe()	(at91_soc_initdata.subtype == AT91_SOC_SAM9XE)
+#define cpu_is_at91sam9260()	(at91_soc_initdata.type == AT91_SOC_SAM9260)
 #else
 #define cpu_is_at91sam9xe()	(0)
 #define cpu_is_at91sam9260()	(0)
 #endif
 
 #ifdef CONFIG_ARCH_AT91SAM9G20
-#define cpu_is_at91sam9g20()	(at91_cpu_identify() == ARCH_ID_AT91SAM9G20)
+#define cpu_is_at91sam9g20()	(at91_soc_initdata.type == AT91_SOC_SAM9G20)
 #else
 #define cpu_is_at91sam9g20()	(0)
 #endif
 
 #ifdef CONFIG_ARCH_AT91SAM9261
-#define cpu_is_at91sam9261()	(at91_cpu_identify() == ARCH_ID_AT91SAM9261)
+#define cpu_is_at91sam9261()	(at91_soc_initdata.type == AT91_SOC_SAM9261)
 #else
 #define cpu_is_at91sam9261()	(0)
 #endif
 
 #ifdef CONFIG_ARCH_AT91SAM9G10
-#define cpu_is_at91sam9g10()	((at91_cpu_identify() & ~AT91_CIDR_EXT)	== ARCH_ID_AT91SAM9G10)
+#define cpu_is_at91sam9g10()	(at91_soc_initdata.type == AT91_SOC_SAM9G10)
 #else
 #define cpu_is_at91sam9g10()	(0)
 #endif
 
 #ifdef CONFIG_ARCH_AT91SAM9263
-#define cpu_is_at91sam9263()	(at91_cpu_identify() == ARCH_ID_AT91SAM9263)
+#define cpu_is_at91sam9263()	(at91_soc_initdata.type == AT91_SOC_SAM9263)
 #else
 #define cpu_is_at91sam9263()	(0)
 #endif
 
 #ifdef CONFIG_ARCH_AT91SAM9RL
-#define cpu_is_at91sam9rl()	(at91_cpu_identify() == ARCH_ID_AT91SAM9RL64)
+#define cpu_is_at91sam9rl()	(at91_soc_initdata.type == AT91_SOC_SAM9RL)
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
+#define cpu_is_at91sam9g45()	(at91_soc_initdata.type == AT91_SOC_SAM9G45)
+#define cpu_is_at91sam9g45es()	(at91_soc_initdata.subtype == AT91_SOC_SAM9G45ES)
+#define cpu_is_at91sam9m10()	(at91_soc_initdata.subtype == AT91_SOC_SAM9M10)
+#define cpu_is_at91sam9g46()	(at91_soc_initdata.subtype == AT91_SOC_SAM9G46)
+#define cpu_is_at91sam9m11()	(at91_soc_initdata.subtype == AT91_SOC_SAM9M11)
 #else
 #define cpu_is_at91sam9g45()	(0)
 #define cpu_is_at91sam9g45es()	(0)
@@ -156,17 +180,12 @@ extern int rm9200_type;
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
+#define cpu_is_at91sam9x5()	(at91_soc_initdata.type == AT91_SOC_SAM9X5)
+#define cpu_is_at91sam9g15()	(at91_soc_initdata.subtype == AT91_SOC_SAM9G15)
+#define cpu_is_at91sam9g35()	(at91_soc_initdata.subtype == AT91_SOC_SAM9G35)
+#define cpu_is_at91sam9x35()	(at91_soc_initdata.subtype == AT91_SOC_SAM9X35)
+#define cpu_is_at91sam9g25()	(at91_soc_initdata.subtype == AT91_SOC_SAM9G25)
+#define cpu_is_at91sam9x25()	(at91_soc_initdata.subtype == AT91_SOC_SAM9X25)
 #else
 #define cpu_is_at91sam9x5()	(0)
 #define cpu_is_at91sam9g15()	(0)
@@ -177,9 +196,9 @@ extern int rm9200_type;
 #endif
 
 #ifdef CONFIG_ARCH_AT91CAP9
-#define cpu_is_at91cap9()	(at91_cpu_identify() == ARCH_ID_AT91CAP9)
-#define cpu_is_at91cap9_revB()	(at91cap9_rev_identify() == ARCH_REVISION_CAP9_B)
-#define cpu_is_at91cap9_revC()	(at91cap9_rev_identify() == ARCH_REVISION_CAP9_C)
+#define cpu_is_at91cap9()	(at91_soc_initdata.type == AT91_SOC_CAP9)
+#define cpu_is_at91cap9_revB()	(at91_soc_initdata.subtype == AT91_SOC_CAP9_REV_B)
+#define cpu_is_at91cap9_revC()	(at91_soc_initdata.subtype == AT91_SOC_CAP9_REV_C)
 #else
 #define cpu_is_at91cap9()	(0)
 #define cpu_is_at91cap9_revB()	(0)
@@ -192,4 +211,4 @@ extern int rm9200_type;
  */
 #define cpu_is_at32ap7000()	(0)
 
-#endif
+#endif /* __MACH_CPU_H__ */
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 8962d9a..9ea4183 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -12,11 +12,24 @@
 
 #include <mach/hardware.h>
 #include <mach/cpu.h>
+#include <mach/at91_dbgu.h>
+#include <mach/at91_pmc.h>
 
 #include "soc.h"
 #include "generic.h"
 
-struct at91_soc __initdata at91_boot_soc;
+struct at91_init_soc __initdata at91_boot_soc;
+
+struct at91_socinfo at91_soc_initdata;
+EXPORT_SYMBOL(at91_soc_initdata);
+
+void __init at91rm9200_set_type(int type)
+{
+	if (type == ARCH_REVISON_9200_PQFP)
+		at91_soc_initdata.subtype = AT91_SOC_RM9200_BGA;
+	else
+		at91_soc_initdata.subtype = AT91_SOC_RM9200_PQFP;
+}
 
 void __init at91_init_irq_default(void)
 {
@@ -39,33 +52,195 @@ static struct map_desc at91_io_desc __initdata = {
 	.type		= MT_DEVICE,
 };
 
-void __init at91_map_io(void)
+#define AT91_DBGU0	0xfffff200
+#define AT91_DBGU1	0xffffee00
+
+static void __init soc_detect(u32 dbgu_base)
 {
-	/* Map peripherals */
-	iotable_init(&at91_io_desc, 1);
+	u32 cidr, socid;
+
+	cidr = __raw_readl(AT91_IO_P2V(dbgu_base) + AT91_DBGU_CIDR);
+	socid = cidr & ~AT91_CIDR_VERSION;
 
-	if (cpu_is_at91cap9())
+	switch (socid) {
+	case ARCH_ID_AT91CAP9: {
+#ifdef CONFIG_AT91_PMC_UNIT
+		u32 pmc_ver = at91_sys_read(AT91_PMC_VER);
+
+		if (pmc_ver == ARCH_REVISION_CAP9_B)
+			at91_soc_initdata.subtype = AT91_SOC_CAP9_REV_B;
+		else if (pmc_ver == ARCH_REVISION_CAP9_C)
+			at91_soc_initdata.subtype = AT91_SOC_CAP9_REV_C;
+#endif
+		at91_soc_initdata.type = AT91_SOC_CAP9;
 		at91_boot_soc = at91cap9_soc;
-	else if (cpu_is_at91rm9200())
+		break;
+	}
+
+	case ARCH_ID_AT91RM9200:
+		at91_soc_initdata.type = AT91_SOC_RM9200;
 		at91_boot_soc = at91rm9200_soc;
-	else if (cpu_is_at91sam9260())
+		break;
+
+	case ARCH_ID_AT91SAM9260:
+		at91_soc_initdata.type = AT91_SOC_SAM9260;
 		at91_boot_soc = at91sam9260_soc;
-	else if (cpu_is_at91sam9261())
+		break;
+
+	case ARCH_ID_AT91SAM9261:
+		at91_soc_initdata.type = AT91_SOC_SAM9261;
 		at91_boot_soc = at91sam9261_soc;
-	else if (cpu_is_at91sam9263())
+		break;
+
+	case ARCH_ID_AT91SAM9263:
+		at91_soc_initdata.type = AT91_SOC_SAM9263;
 		at91_boot_soc = at91sam9263_soc;
-	else if (cpu_is_at91sam9g10())
-		at91_boot_soc = at91sam9261_soc;
-	else if (cpu_is_at91sam9g20())
+		break;
+
+	case ARCH_ID_AT91SAM9G20:
+		at91_soc_initdata.type = AT91_SOC_SAM9G20;
 		at91_boot_soc = at91sam9260_soc;
-	else if (cpu_is_at91sam9g45())
+		break;
+
+	case ARCH_ID_AT91SAM9G45:
+		at91_soc_initdata.type = AT91_SOC_SAM9G45;
+		if (cidr == ARCH_ID_AT91SAM9G45ES)
+			at91_soc_initdata.subtype = AT91_SOC_SAM9G45ES;
 		at91_boot_soc = at91sam9g45_soc;
-	else if (cpu_is_at91sam9rl())
+		break;
+
+	case ARCH_ID_AT91SAM9RL64:
+		at91_soc_initdata.type = AT91_SOC_SAM9RL;
 		at91_boot_soc = at91sam9rl_soc;
-	else if (cpu_is_at91sam9x5())
+		break;
+
+	case ARCH_ID_AT91SAM9X5:
+		at91_soc_initdata.type = AT91_SOC_SAM9X5;
 		at91_boot_soc = at91sam9x5_soc;
-	else
-		panic("Impossible to detect the SOC type");
+		break;
+	}
+
+	/* at91sam9g10 */
+	if ((cidr & ~AT91_CIDR_EXT) == ARCH_ID_AT91SAM9G10) {
+		at91_soc_initdata.type = AT91_SOC_SAM9G10;
+		at91_boot_soc = at91sam9261_soc;
+	}
+	/* at91sam9xe */
+	else if ((cidr & AT91_CIDR_ARCH) == ARCH_FAMILY_AT91SAM9XE) {
+		at91_soc_initdata.type = AT91_SOC_SAM9260;
+		at91_soc_initdata.subtype = AT91_SOC_SAM9XE;
+		at91_boot_soc = at91sam9260_soc;
+	}
+
+	if (!at91_soc_is_detected())
+		return;
+
+	at91_soc_initdata.cidr = cidr;
+
+	/* sub version of soc */
+	at91_soc_initdata.exid = __raw_readl(AT91_IO_P2V(dbgu_base) + AT91_DBGU_EXID);
+
+	if (at91_soc_initdata.type == AT91_SOC_SAM9G45) {
+		switch (at91_soc_initdata.exid) {
+		case ARCH_EXID_AT91SAM9M10:
+			at91_soc_initdata.subtype = AT91_SOC_SAM9M10;
+			break;
+		case ARCH_EXID_AT91SAM9G46:
+			at91_soc_initdata.subtype = AT91_SOC_SAM9G46;
+			break;
+		case ARCH_EXID_AT91SAM9M11:
+			at91_soc_initdata.subtype = AT91_SOC_SAM9M11;
+			break;
+		}
+	}
+
+	if (at91_soc_initdata.type == AT91_SOC_SAM9X5) {
+		switch (at91_soc_initdata.exid) {
+		case ARCH_EXID_AT91SAM9G15:
+			at91_soc_initdata.subtype = AT91_SOC_SAM9G15;
+			break;
+		case ARCH_EXID_AT91SAM9G35:
+			at91_soc_initdata.subtype = AT91_SOC_SAM9G35;
+			break;
+		case ARCH_EXID_AT91SAM9X35:
+			at91_soc_initdata.subtype = AT91_SOC_SAM9X35;
+			break;
+		case ARCH_EXID_AT91SAM9G25:
+			at91_soc_initdata.subtype = AT91_SOC_SAM9G25;
+			break;
+		case ARCH_EXID_AT91SAM9X25:
+			at91_soc_initdata.subtype = AT91_SOC_SAM9X25;
+			break;
+		}
+	}
+}
+
+static const char *soc_name[] = {
+	[AT91_SOC_RM9200]	= "at91rm9200",
+	[AT91_SOC_CAP9]		= "at91cap9",
+	[AT91_SOC_SAM9260]	= "at91sam9260",
+	[AT91_SOC_SAM9261]	= "at91sam9261",
+	[AT91_SOC_SAM9263]	= "at91sam9263",
+	[AT91_SOC_SAM9G10]	= "at91sam9g10",
+	[AT91_SOC_SAM9G20]	= "at91sam9g20",
+	[AT91_SOC_SAM9G45]	= "at91sam9g45",
+	[AT91_SOC_SAM9RL]	= "at91sam9rl",
+	[AT91_SOC_SAM9X5]	= "at91sam9x5",
+	[AT91_SOC_NONE]		= "Unknown"
+};
+
+const char *at91_get_soc_type(struct at91_socinfo *c)
+{
+	return soc_name[c->type];
+}
+EXPORT_SYMBOL(at91_get_soc_type);
+
+static const char *soc_subtype_name[] = {
+	[AT91_SOC_RM9200_BGA]	= "at91rm9200 BGA",
+	[AT91_SOC_RM9200_PQFP]	= "at91rm9200 PQFP",
+	[AT91_SOC_CAP9_REV_B]	= "at91cap9 revB",
+	[AT91_SOC_CAP9_REV_C]	= "at91cap9 revC",
+	[AT91_SOC_SAM9XE]	= "at91sam9xe",
+	[AT91_SOC_SAM9G45ES]	= "at91sam9g45es",
+	[AT91_SOC_SAM9M10]	= "at91sam9m10",
+	[AT91_SOC_SAM9G46]	= "at91sam9g46",
+	[AT91_SOC_SAM9M11]	= "at91sam9m11",
+	[AT91_SOC_SAM9G15]	= "at91sam9g15",
+	[AT91_SOC_SAM9G35]	= "at91sam9g35",
+	[AT91_SOC_SAM9X35]	= "at91sam9x35",
+	[AT91_SOC_SAM9G25]	= "at91sam9g25",
+	[AT91_SOC_SAM9X25]	= "at91sam9x25",
+	[AT91_SOC_SUBTYPE_NONE]	= "Unknown"
+};
+
+const char *at91_get_soc_subtype(struct at91_socinfo *c)
+{
+	return soc_subtype_name[c->subtype];
+}
+EXPORT_SYMBOL(at91_get_soc_subtype);
+
+void __init at91_map_io(void)
+{
+	/* Map peripherals */
+	iotable_init(&at91_io_desc, 1);
+
+	at91_soc_initdata.type = AT91_SOC_NONE;
+	at91_soc_initdata.subtype = AT91_SOC_SUBTYPE_NONE;
+
+	soc_detect(AT91_DBGU0);
+	if (!at91_soc_is_detected())
+		soc_detect(AT91_DBGU1);
+
+	if (!at91_soc_is_detected())
+		panic("AT91: Impossible to detect the SOC type");
+
+	pr_info("AT91: Detected soc type: %s\n",
+		at91_get_soc_type(&at91_soc_initdata));
+	pr_info("AT91: Detected soc subtype: %s\n",
+		at91_get_soc_subtype(&at91_soc_initdata));
+
+	if (!at91_soc_is_enabled())
+		panic("AT91: Soc not enabled");
 
 	if (at91_boot_soc.map_io)
 		at91_boot_soc.map_io();
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
dissimilarity index 63%
index 99afa7c..9de7be4 100644
--- a/arch/arm/mach-at91/soc.h
+++ b/arch/arm/mach-at91/soc.h
@@ -1,21 +1,58 @@
-/*
- * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
- *
- * Under GPLv2
- */
-
-struct at91_soc {
-	unsigned int *default_irq_priority;
-	void (*map_io)(void);
-	void (*init)(unsigned long main_clock);
-};
-
-extern struct at91_soc at91_boot_soc;
-extern struct at91_soc at91cap9_soc;
-extern struct at91_soc at91rm9200_soc;
-extern struct at91_soc at91sam9260_soc;
-extern struct at91_soc at91sam9261_soc;
-extern struct at91_soc at91sam9263_soc;
-extern struct at91_soc at91sam9g45_soc;
-extern struct at91_soc at91sam9rl_soc;
-extern struct at91_soc at91sam9x5_soc;
+/*
+ * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Under GPLv2
+ */
+
+struct at91_init_soc {
+	unsigned int *default_irq_priority;
+	void (*map_io)(void);
+	void (*init)(unsigned long main_clock);
+};
+
+extern struct at91_init_soc at91_boot_soc;
+extern struct at91_init_soc at91cap9_soc;
+extern struct at91_init_soc at91rm9200_soc;
+extern struct at91_init_soc at91sam9260_soc;
+extern struct at91_init_soc at91sam9261_soc;
+extern struct at91_init_soc at91sam9263_soc;
+extern struct at91_init_soc at91sam9g45_soc;
+extern struct at91_init_soc at91sam9rl_soc;
+extern struct at91_init_soc at91sam9x5_soc;
+
+static inline int at91_soc_is_enabled(void)
+{
+	return at91_boot_soc.init != NULL;
+}
+
+#if !defined(CONFIG_ARCH_AT91CAP9)
+#define at91cap9_soc	at91_boot_soc
+#endif
+
+#if !defined(CONFIG_ARCH_AT91RM9200)
+#define at91rm9200_soc	at91_boot_soc
+#endif
+
+#if !(defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM9G20))
+#define at91sam9260_soc	at91_boot_soc
+#endif
+
+#if !(defined(CONFIG_ARCH_AT91SAM9261) || defined(CONFIG_ARCH_AT91SAM9G10))
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
