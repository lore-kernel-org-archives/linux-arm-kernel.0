From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 25 Apr 2011 20:31:15 +0200
Subject: [PATCH 05/14] at91: use structure to store the current soc
In-Reply-To: <20110425180847.GA12904@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
Message-ID: <1303756284-26529-5-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

instead of reading the registers everytime

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/mach-at91/at91rm9200.c       |    8 -
 arch/arm/mach-at91/at91sam9260.c      |    1 +
 arch/arm/mach-at91/at91sam9rl.c       |    1 +
 arch/arm/mach-at91/cpu.h              |  181 +++++++++++++++++
 arch/arm/mach-at91/include/mach/cpu.h |  355 ++++++++++++++-------------------
 arch/arm/mach-at91/soc.c              |   66 +++++-
 6 files changed, 391 insertions(+), 221 deletions(-)
 create mode 100644 arch/arm/mach-at91/cpu.h
 rewrite arch/arm/mach-at91/include/mach/cpu.h (71%)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index abc4cc9..afb29b9 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -263,14 +263,6 @@ static void at91rm9200_reset(void)
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
index 2838921..7bbdd2f 100644
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
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 53287d5..19e2e5a 100644
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
diff --git a/arch/arm/mach-at91/cpu.h b/arch/arm/mach-at91/cpu.h
new file mode 100644
index 0000000..77ce520
--- /dev/null
+++ b/arch/arm/mach-at91/cpu.h
@@ -0,0 +1,181 @@
+/*
+ * arch/arm/mach-at91/cpu.h
+ *
+ *  Copyright (C) 2006 SAN People
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#ifndef __ASM_ARCH_CPU_H
+#define __ASM_ARCH_CPU_H
+
+#include <mach/hardware.h>
+#include <mach/at91_dbgu.h>
+
+#define ARCH_ID_AT91RM9200	0x09290780
+#define ARCH_ID_AT91SAM9260	0x019803a0
+#define ARCH_ID_AT91SAM9261	0x019703a0
+#define ARCH_ID_AT91SAM9263	0x019607a0
+#define ARCH_ID_AT91SAM9G10	0x019903a0
+#define ARCH_ID_AT91SAM9G20	0x019905a0
+#define ARCH_ID_AT91SAM9RL64	0x019b03a0
+#define ARCH_ID_AT91SAM9G45	0x819b05a0
+#define ARCH_ID_AT91SAM9G45MRL	0x819b05a2	/* aka 9G45-ES2 & non ES lots */
+#define ARCH_ID_AT91SAM9G45ES	0x819b05a1	/* 9G45-ES (Engineering Sample) */
+#define ARCH_ID_AT91SAM9X5	0x819a05a0
+#define ARCH_ID_AT91CAP9	0x039A03A0
+
+#define ARCH_ID_AT91SAM9XE128	0x329973a0
+#define ARCH_ID_AT91SAM9XE256	0x329a93a0
+#define ARCH_ID_AT91SAM9XE512	0x329aa3a0
+
+#define ARCH_ID_AT572D940HF	0x0e0303e0
+
+#define ARCH_ID_AT91M40800	0x14080044
+#define ARCH_ID_AT91R40807	0x44080746
+#define ARCH_ID_AT91M40807	0x14080745
+#define ARCH_ID_AT91R40008	0x44000840
+
+static inline unsigned long at91_cpu_identify(void)
+{
+	return (at91_sys_read(AT91_DBGU_CIDR) & ~AT91_CIDR_VERSION);
+}
+
+static inline unsigned long at91_cpu_fully_identify(void)
+{
+	return at91_sys_read(AT91_DBGU_CIDR);
+}
+
+#define ARCH_EXID_AT91SAM9M11	0x00000001
+#define ARCH_EXID_AT91SAM9M10	0x00000002
+#define ARCH_EXID_AT91SAM9G46	0x00000003
+#define ARCH_EXID_AT91SAM9G45	0x00000004
+
+#define ARCH_EXID_AT91SAM9G15	0x00000000
+#define ARCH_EXID_AT91SAM9G35	0x00000001
+#define ARCH_EXID_AT91SAM9X35	0x00000002
+#define ARCH_EXID_AT91SAM9G25	0x00000003
+#define ARCH_EXID_AT91SAM9X25	0x00000004
+
+static inline unsigned long at91_exid_identify(void)
+{
+	return at91_sys_read(AT91_DBGU_EXID);
+}
+
+
+#define ARCH_FAMILY_AT91X92	0x09200000
+#define ARCH_FAMILY_AT91SAM9	0x01900000
+#define ARCH_FAMILY_AT91SAM9XE	0x02900000
+
+static inline unsigned long at91_arch_identify(void)
+{
+	return (at91_sys_read(AT91_DBGU_CIDR) & AT91_CIDR_ARCH);
+}
+
+#ifdef CONFIG_ARCH_AT91CAP9
+#include <mach/at91_pmc.h>
+
+#define ARCH_REVISION_CAP9_B	0x399
+#define ARCH_REVISION_CAP9_C	0x601
+
+static inline unsigned long at91cap9_rev_identify(void)
+{
+	return (at91_sys_read(AT91_PMC_VER));
+}
+#endif
+
+#ifdef CONFIG_ARCH_AT91RM9200
+#define __cpu_is_at91rm9200()	(at91_cpu_identify() == ARCH_ID_AT91RM9200)
+#else
+#define __cpu_is_at91rm9200()	(0)
+#endif
+
+#ifdef CONFIG_ARCH_AT91SAM9260
+#define __cpu_is_at91sam9xe()	(at91_arch_identify() == ARCH_FAMILY_AT91SAM9XE)
+#define __cpu_is_at91sam9260()	((at91_cpu_identify() == ARCH_ID_AT91SAM9260) || __cpu_is_at91sam9xe())
+#else
+#define __cpu_is_at91sam9xe()	(0)
+#define __cpu_is_at91sam9260()	(0)
+#endif
+
+#ifdef CONFIG_ARCH_AT91SAM9G20
+#define __cpu_is_at91sam9g20()	(at91_cpu_identify() == ARCH_ID_AT91SAM9G20)
+#else
+#define __cpu_is_at91sam9g20()	(0)
+#endif
+
+#ifdef CONFIG_ARCH_AT91SAM9261
+#define __cpu_is_at91sam9261()	(at91_cpu_identify() == ARCH_ID_AT91SAM9261)
+#else
+#define __cpu_is_at91sam9261()	(0)
+#endif
+
+#ifdef CONFIG_ARCH_AT91SAM9G10
+#define __cpu_is_at91sam9g10()	((at91_cpu_identify() & ~AT91_CIDR_EXT)	== ARCH_ID_AT91SAM9G10)
+#else
+#define __cpu_is_at91sam9g10()	(0)
+#endif
+
+#ifdef CONFIG_ARCH_AT91SAM9263
+#define __cpu_is_at91sam9263()	(at91_cpu_identify() == ARCH_ID_AT91SAM9263)
+#else
+#define __cpu_is_at91sam9263()	(0)
+#endif
+
+#ifdef CONFIG_ARCH_AT91SAM9RL
+#define __cpu_is_at91sam9rl()	(at91_cpu_identify() == ARCH_ID_AT91SAM9RL64)
+#else
+#define __cpu_is_at91sam9rl()	(0)
+#endif
+
+#ifdef CONFIG_ARCH_AT91SAM9G45
+#define __cpu_is_at91sam9g45()	(at91_cpu_identify() == ARCH_ID_AT91SAM9G45)
+#define __cpu_is_at91sam9g45es()	(at91_cpu_fully_identify() == ARCH_ID_AT91SAM9G45ES)
+#define __cpu_is_at91sam9m10()	(at91_exid_identify() == ARCH_EXID_AT91SAM9M10)
+#define __cpu_is_at91sam9g46()	(at91_exid_identify() == ARCH_EXID_AT91SAM9G46)
+#define __cpu_is_at91sam9m11()	(at91_exid_identify() == ARCH_EXID_AT91SAM9M11)
+#else
+#define __cpu_is_at91sam9g45()	(0)
+#define __cpu_is_at91sam9g45es()	(0)
+#define __cpu_is_at91sam9m10()	(0)
+#define __cpu_is_at91sam9g46()	(0)
+#define __cpu_is_at91sam9m11()	(0)
+#endif
+
+#ifdef CONFIG_ARCH_AT91SAM9X5
+#define __cpu_is_at91sam9x5()	(at91_cpu_identify() == ARCH_ID_AT91SAM9X5)
+#define __cpu_is_at91sam9g15()	(at91_exid_identify() == ARCH_EXID_AT91SAM9G15)
+#define __cpu_is_at91sam9g35()	(at91_exid_identify() == ARCH_EXID_AT91SAM9G35)
+#define __cpu_is_at91sam9x35()	(at91_exid_identify() == ARCH_EXID_AT91SAM9X35)
+#define __cpu_is_at91sam9g25()	(at91_exid_identify() == ARCH_EXID_AT91SAM9G25)
+#define __cpu_is_at91sam9x25()	(at91_exid_identify() == ARCH_EXID_AT91SAM9X25)
+#else
+#define __cpu_is_at91sam9x5()	(0)
+#define __cpu_is_at91sam9g15()	(0)
+#define __cpu_is_at91sam9g35()	(0)
+#define __cpu_is_at91sam9x35()	(0)
+#define __cpu_is_at91sam9g25()	(0)
+#define __cpu_is_at91sam9x25()	(0)
+#endif
+
+#ifdef CONFIG_ARCH_AT91CAP9
+#define __cpu_is_at91cap9()	(at91_cpu_identify() == ARCH_ID_AT91CAP9)
+#define __cpu_is_at91cap9_revB()	(at91cap9_rev_identify() == ARCH_REVISION_CAP9_B)
+#define __cpu_is_at91cap9_revC()	(at91cap9_rev_identify() == ARCH_REVISION_CAP9_C)
+#else
+#define __cpu_is_at91cap9()	(0)
+#define __cpu_is_at91cap9_revB()	(0)
+#define __cpu_is_at91cap9_revC()	(0)
+#endif
+
+#ifdef CONFIG_ARCH_AT572D940HF
+#define __cpu_is_at572d940hf()	(at91_cpu_identify() == ARCH_ID_AT572D940HF)
+#else
+#define __cpu_is_at572d940hf()	(0)
+#endif
+
+#endif
diff --git a/arch/arm/mach-at91/include/mach/cpu.h b/arch/arm/mach-at91/include/mach/cpu.h
dissimilarity index 71%
index ab00372..ad9d70f 100644
--- a/arch/arm/mach-at91/include/mach/cpu.h
+++ b/arch/arm/mach-at91/include/mach/cpu.h
@@ -1,203 +1,152 @@
-/*
- * arch/arm/mach-at91/include/mach/cpu.h
- *
- *  Copyright (C) 2006 SAN People
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- */
-
-#ifndef __ASM_ARCH_CPU_H
-#define __ASM_ARCH_CPU_H
-
-#include <mach/hardware.h>
-#include <mach/at91_dbgu.h>
-
-
-#define ARCH_ID_AT91RM9200	0x09290780
-#define ARCH_ID_AT91SAM9260	0x019803a0
-#define ARCH_ID_AT91SAM9261	0x019703a0
-#define ARCH_ID_AT91SAM9263	0x019607a0
-#define ARCH_ID_AT91SAM9G10	0x019903a0
-#define ARCH_ID_AT91SAM9G20	0x019905a0
-#define ARCH_ID_AT91SAM9RL64	0x019b03a0
-#define ARCH_ID_AT91SAM9G45	0x819b05a0
-#define ARCH_ID_AT91SAM9G45MRL	0x819b05a2	/* aka 9G45-ES2 & non ES lots */
-#define ARCH_ID_AT91SAM9G45ES	0x819b05a1	/* 9G45-ES (Engineering Sample) */
-#define ARCH_ID_AT91SAM9X5	0x819a05a0
-#define ARCH_ID_AT91CAP9	0x039A03A0
-
-#define ARCH_ID_AT91SAM9XE128	0x329973a0
-#define ARCH_ID_AT91SAM9XE256	0x329a93a0
-#define ARCH_ID_AT91SAM9XE512	0x329aa3a0
-
-#define ARCH_ID_AT572D940HF	0x0e0303e0
-
-#define ARCH_ID_AT91M40800	0x14080044
-#define ARCH_ID_AT91R40807	0x44080746
-#define ARCH_ID_AT91M40807	0x14080745
-#define ARCH_ID_AT91R40008	0x44000840
-
-static inline unsigned long at91_cpu_identify(void)
-{
-	return (at91_sys_read(AT91_DBGU_CIDR) & ~AT91_CIDR_VERSION);
-}
-
-static inline unsigned long at91_cpu_fully_identify(void)
-{
-	return at91_sys_read(AT91_DBGU_CIDR);
-}
-
-#define ARCH_EXID_AT91SAM9M11	0x00000001
-#define ARCH_EXID_AT91SAM9M10	0x00000002
-#define ARCH_EXID_AT91SAM9G46	0x00000003
-#define ARCH_EXID_AT91SAM9G45	0x00000004
-
-#define ARCH_EXID_AT91SAM9G15	0x00000000
-#define ARCH_EXID_AT91SAM9G35	0x00000001
-#define ARCH_EXID_AT91SAM9X35	0x00000002
-#define ARCH_EXID_AT91SAM9G25	0x00000003
-#define ARCH_EXID_AT91SAM9X25	0x00000004
-
-static inline unsigned long at91_exid_identify(void)
-{
-	return at91_sys_read(AT91_DBGU_EXID);
-}
-
-
-#define ARCH_FAMILY_AT91X92	0x09200000
-#define ARCH_FAMILY_AT91SAM9	0x01900000
-#define ARCH_FAMILY_AT91SAM9XE	0x02900000
-
-static inline unsigned long at91_arch_identify(void)
-{
-	return (at91_sys_read(AT91_DBGU_CIDR) & AT91_CIDR_ARCH);
-}
-
-#ifdef CONFIG_ARCH_AT91CAP9
-#include <mach/at91_pmc.h>
-
-#define ARCH_REVISION_CAP9_B	0x399
-#define ARCH_REVISION_CAP9_C	0x601
-
-static inline unsigned long at91cap9_rev_identify(void)
-{
-	return (at91_sys_read(AT91_PMC_VER));
-}
-#endif
-
-#ifdef CONFIG_ARCH_AT91RM9200
-extern int rm9200_type;
-#define ARCH_REVISON_9200_BGA	(0 << 0)
-#define ARCH_REVISON_9200_PQFP	(1 << 0)
-#define cpu_is_at91rm9200()	(at91_cpu_identify() == ARCH_ID_AT91RM9200)
-#define cpu_is_at91rm9200_bga()	(!cpu_is_at91rm9200_pqfp())
-#define cpu_is_at91rm9200_pqfp() (cpu_is_at91rm9200() && rm9200_type & ARCH_REVISON_9200_PQFP)
-#else
-#define cpu_is_at91rm9200()	(0)
-#define cpu_is_at91rm9200_bga()	(0)
-#define cpu_is_at91rm9200_pqfp() (0)
-#endif
-
-#ifdef CONFIG_ARCH_AT91SAM9260
-#define cpu_is_at91sam9xe()	(at91_arch_identify() == ARCH_FAMILY_AT91SAM9XE)
-#define cpu_is_at91sam9260()	((at91_cpu_identify() == ARCH_ID_AT91SAM9260) || cpu_is_at91sam9xe())
-#else
-#define cpu_is_at91sam9xe()	(0)
-#define cpu_is_at91sam9260()	(0)
-#endif
-
-#ifdef CONFIG_ARCH_AT91SAM9G20
-#define cpu_is_at91sam9g20()	(at91_cpu_identify() == ARCH_ID_AT91SAM9G20)
-#else
-#define cpu_is_at91sam9g20()	(0)
-#endif
-
-#ifdef CONFIG_ARCH_AT91SAM9261
-#define cpu_is_at91sam9261()	(at91_cpu_identify() == ARCH_ID_AT91SAM9261)
-#else
-#define cpu_is_at91sam9261()	(0)
-#endif
-
-#ifdef CONFIG_ARCH_AT91SAM9G10
-#define cpu_is_at91sam9g10()	((at91_cpu_identify() & ~AT91_CIDR_EXT)	== ARCH_ID_AT91SAM9G10)
-#else
-#define cpu_is_at91sam9g10()	(0)
-#endif
-
-#ifdef CONFIG_ARCH_AT91SAM9263
-#define cpu_is_at91sam9263()	(at91_cpu_identify() == ARCH_ID_AT91SAM9263)
-#else
-#define cpu_is_at91sam9263()	(0)
-#endif
-
-#ifdef CONFIG_ARCH_AT91SAM9RL
-#define cpu_is_at91sam9rl()	(at91_cpu_identify() == ARCH_ID_AT91SAM9RL64)
-#else
-#define cpu_is_at91sam9rl()	(0)
-#endif
-
-#ifdef CONFIG_ARCH_AT91SAM9G45
-#define cpu_is_at91sam9g45()	(at91_cpu_identify() == ARCH_ID_AT91SAM9G45)
-#define cpu_is_at91sam9g45es()	(at91_cpu_fully_identify() == ARCH_ID_AT91SAM9G45ES)
-#define cpu_is_at91sam9m10()    (cpu_is_at91sam9g45() && \
-                                (at91_exid_identify() == ARCH_EXID_AT91SAM9M10))
-#define cpu_is_at91sam9m46()    (cpu_is_at91sam9g45() && \
-                                (at91_exid_identify() == ARCH_EXID_AT91SAM9G46))
-#define cpu_is_at91sam9m11()    (cpu_is_at91sam9g45() && \
-                                (at91_exid_identify() == ARCH_EXID_AT91SAM9M11))
-#else
-#define cpu_is_at91sam9g45()	(0)
-#define cpu_is_at91sam9g45es()	(0)
-#define cpu_is_at91sam9m10()	(0)
-#define cpu_is_at91sam9g46()	(0)
-#define cpu_is_at91sam9m11()	(0)
-#endif
-
-#ifdef CONFIG_ARCH_AT91SAM9X5
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
-#else
-#define cpu_is_at91sam9x5()	(0)
-#define cpu_is_at91sam9g15()	(0)
-#define cpu_is_at91sam9g35()	(0)
-#define cpu_is_at91sam9x35()	(0)
-#define cpu_is_at91sam9g25()	(0)
-#define cpu_is_at91sam9x25()	(0)
-#endif
-
-#ifdef CONFIG_ARCH_AT91CAP9
-#define cpu_is_at91cap9()	(at91_cpu_identify() == ARCH_ID_AT91CAP9)
-#define cpu_is_at91cap9_revB()	(at91cap9_rev_identify() == ARCH_REVISION_CAP9_B)
-#define cpu_is_at91cap9_revC()	(at91cap9_rev_identify() == ARCH_REVISION_CAP9_C)
-#else
-#define cpu_is_at91cap9()	(0)
-#define cpu_is_at91cap9_revB()	(0)
-#define cpu_is_at91cap9_revC()	(0)
-#endif
-
-#ifdef CONFIG_ARCH_AT572D940HF
-#define cpu_is_at572d940hf() (at91_cpu_identify() == ARCH_ID_AT572D940HF)
-#else
-#define cpu_is_at572d940hf() (0)
-#endif
-
-/*
- * Since this is ARM, we will never run on any AVR32 CPU. But these
- * definitions may reduce clutter in common drivers.
- */
-#define cpu_is_at32ap7000()	(0)
-
-#endif
+/*
+ * arch/arm/mach-at91/include/mach/cpu.h
+ *
+ * Copyright (C) 2006 SAN People
+ * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#ifndef __MACH_CPU_H__
+#define __MACH_CPU_H__
+
+struct at91_cpu_id {
+	u8 is_at572d940hf;
+#define AT91_CAP9		(1 << 0)
+#define AT91_CAP9_REV_B		(1 << 1)
+#define AT91_CAP9_REV_C		(1 << 2)
+	u8 is_at91cap9;
+#define ARCH_REVISON_9200	(1 << 0)
+#define ARCH_REVISON_9200_BGA	(0 << 1)
+#define ARCH_REVISON_9200_PQFP	(1 << 1)
+	u8 is_at91rm9200;
+#define AT91_SAM9260		(1 << 0)
+#define AT91_SAM9XE		(1 << 1)
+	u8 is_at91sam9260;
+	u8 is_at91sam9261;
+	u8 is_at91sam9263;
+	u8 is_at91sam9g10;
+	u8 is_at91sam9g20;
+#define AT91_SAM9G45		(1 << 0)
+#define AT91_SAM9G45ES		(1 << 1)
+#define AT91_SAM9M10		(1 << 2)
+#define AT91_SAM9G46		(1 << 3)
+#define AT91_SAM9M11		(1 << 4)
+	u8 is_at91sam9g45;
+	u8 is_at91sam9rl;
+#define AT91_SAM9X5		(1 << 0)
+#define AT91_SAM9G15		(1 << 1)
+#define AT91_SAM9G35		(1 << 2)
+#define AT91_SAM9X35		(1 << 3)
+#define AT91_SAM9G25		(1 << 4)
+#define AT91_SAM9X25		(1 << 5)
+	u8 is_at91sam9x5;
+};
+
+extern struct at91_cpu_id cpu_id;
+
+#ifdef CONFIG_ARCH_AT91RM9200
+#define cpu_is_at91rm9200()	(cpu_id.is_at91rm9200)
+#define cpu_is_at91rm9200_bga()	(!cpu_is_at91rm9200_pqfp())
+#define cpu_is_at91rm9200_pqfp() (cpu_is_at91rm9200() && cpu_id.is_at91rm9200 & ARCH_REVISON_9200_PQFP)
+#else
+#define cpu_is_at91rm9200()	(0)
+#define cpu_is_at91rm9200_bga()	(0)
+#define cpu_is_at91rm9200_pqfp() (0)
+#endif
+
+#ifdef CONFIG_ARCH_AT91SAM9260
+#define cpu_is_at91sam9xe()	(cpu_id.is_at91sam9260 & AT91_SAM9XE)
+#define cpu_is_at91sam9260()	(cpu_id.is_at91sam9260)
+#else
+#define cpu_is_at91sam9xe()	(0)
+#define cpu_is_at91sam9260()	(0)
+#endif
+
+#ifdef CONFIG_ARCH_AT91SAM9G20
+#define cpu_is_at91sam9g20()	(cpu_id.is_at91sam9g20)
+#else
+#define cpu_is_at91sam9g20()	(0)
+#endif
+
+#ifdef CONFIG_ARCH_AT91SAM9261
+#define cpu_is_at91sam9261()	(cpu_id.is_at91sam9261)
+#else
+#define cpu_is_at91sam9261()	(0)
+#endif
+
+#ifdef CONFIG_ARCH_AT91SAM9G10
+#define cpu_is_at91sam9g10()	(cpu_id.is_at91sam9g10)
+#else
+#define cpu_is_at91sam9g10()	(0)
+#endif
+
+#ifdef CONFIG_ARCH_AT91SAM9263
+#define cpu_is_at91sam9263()	(cpu_id.is_at91sam9263)
+#else
+#define cpu_is_at91sam9263()	(0)
+#endif
+
+#ifdef CONFIG_ARCH_AT91SAM9RL
+#define cpu_is_at91sam9rl()	(cpu_id.is_at91sam9rl)
+#else
+#define cpu_is_at91sam9rl()	(0)
+#endif
+
+#ifdef CONFIG_ARCH_AT91SAM9G45
+#define cpu_is_at91sam9g45()	(cpu_id.is_at91sam9g45 & AT91_SAM9G45)
+#define cpu_is_at91sam9g45es()	(cpu_id.is_at91sam9g45 & AT91_SAM9G45ES)
+#define cpu_is_at91sam9m10()	(cpu_id.is_at91sam9g45 & AT91_SAM9M10)
+#define cpu_is_at91sam9g46()	(cpu_id.is_at91sam9g45 & AT91_SAM9G46)
+#define cpu_is_at91sam9m11()	(cpu_id.is_at91sam9g45 & AT91_SAM9M11)
+#else
+#define cpu_is_at91sam9g45()	(0)
+#define cpu_is_at91sam9g45es()	(0)
+#define cpu_is_at91sam9m10()	(0)
+#define cpu_is_at91sam9g46()	(0)
+#define cpu_is_at91sam9m11()	(0)
+#endif
+
+#ifdef CONFIG_ARCH_AT91SAM9X5
+#define cpu_is_at91sam9x5()	(cpu_id.is_at91sam9x5 & AT91_SAM9X5)
+#define cpu_is_at91sam9g15()	(cpu_id.is_at91sam9x5 & AT91_SAM9G15)
+#define cpu_is_at91sam9g35()	(cpu_id.is_at91sam9x5 & AT91_SAM9G35)
+#define cpu_is_at91sam9x35()	(cpu_id.is_at91sam9x5 & AT91_SAM9X35)
+#define cpu_is_at91sam9g25()	(cpu_id.is_at91sam9x5 & AT91_SAM9G25)
+#define cpu_is_at91sam9x25()	(cpu_id.is_at91sam9x5 & AT91_SAM9X25)
+#else
+#define cpu_is_at91sam9x5()	(0)
+#define cpu_is_at91sam9g15()	(0)
+#define cpu_is_at91sam9g35()	(0)
+#define cpu_is_at91sam9x35()	(0)
+#define cpu_is_at91sam9g25()	(0)
+#define cpu_is_at91sam9x25()	(0)
+#endif
+
+#ifdef CONFIG_ARCH_AT91CAP9
+#define cpu_is_at91cap9()	(cpu_id.is_at91cap9 & AT91_CAP9)
+#define cpu_is_at91cap9_revB()	(cpu_id.is_at91cap9 & AT91_CAP9_REV_B)
+#define cpu_is_at91cap9_revC()	(cpu_id.is_at91cap9 & AT91_CAP9_REV_C)
+#else
+#define cpu_is_at91cap9()	(0)
+#define cpu_is_at91cap9_revB()	(0)
+#define cpu_is_at91cap9_revC()	(0)
+#endif
+
+#ifdef CONFIG_ARCH_AT572D940HF
+#define cpu_is_at572d940hf()	(cpu_id.is_at572d940hf)
+#else
+#define cpu_is_at572d940hf()	(0)
+#endif
+
+/*
+ * Since this is ARM, we will never run on any AVR32 CPU. But these
+ * definitions may reduce clutter in common drivers.
+ */
+#define cpu_is_at32ap7000()	(0)
+
+#endif /* __MACH_CPU_H__ */
diff --git a/arch/arm/mach-at91/soc.c b/arch/arm/mach-at91/soc.c
index 6cf7f99..6fe205f2 100644
--- a/arch/arm/mach-at91/soc.c
+++ b/arch/arm/mach-at91/soc.c
@@ -15,11 +15,23 @@
 #include <mach/hardware.h>
 #include <mach/cpu.h>
 
+#include "cpu.h"
 #include "soc.h"
 #include "generic.h"
 
 static struct at91_soc __initdata current_soc;
 
+struct at91_cpu_id cpu_id;
+EXPORT_SYMBOL(cpu_id);
+
+void __init at91rm9200_set_type(int type)
+{
+	if (type == ARCH_REVISON_9200_PQFP)
+		cpu_id.is_at91rm9200 |= ARCH_REVISON_9200_PQFP;
+	else
+		cpu_id.is_at91rm9200 &= ~ARCH_REVISON_9200_PQFP;
+}
+
 void __init at91_init_interrupts(unsigned int *priority)
 {
 	if (!priority)
@@ -44,26 +56,60 @@ void __init at91_initialize(unsigned long main_clock)
 	/* Map peripherals */
 	iotable_init(&at91_io_desc, 1);
 
-	if (cpu_is_at572d940hf())
+	if (__cpu_is_at572d940hf()) {
+		cpu_id.is_at572d940hf = 1;
 		current_soc = at572d940hf_soc;
-	else if (cpu_is_at91cap9())
+	} else if (__cpu_is_at91cap9()) {
+		cpu_id.is_at91cap9 = AT91_CAP9;
+		if (__cpu_is_at91cap9_revB())
+			cpu_id.is_at91cap9 |= AT91_CAP9_REV_B;
+		else if (__cpu_is_at91cap9_revC())
+			cpu_id.is_at91cap9 |= AT91_CAP9_REV_C;
 		current_soc = at91cap9_soc;
-	else if (cpu_is_at91rm9200())
+	} else if (__cpu_is_at91rm9200()) {
+		cpu_id.is_at91rm9200 = 1;
 		current_soc = at91rm9200_soc;
-	else if (cpu_is_at91sam9260())
+	} else if (__cpu_is_at91sam9260()) {
+		cpu_id.is_at91sam9260 = AT91_SAM9260;
+		if (__cpu_is_at91sam9xe())
+			cpu_id.is_at91sam9260 |= AT91_SAM9XE;
 		current_soc = at91sam9260_soc;
-	else if (cpu_is_at91sam9261())
+	} else if (__cpu_is_at91sam9261()) {
+		cpu_id.is_at91sam9261 = 1;
 		current_soc = at91sam9261_soc;
-	else if (cpu_is_at91sam9263())
+	} else if (__cpu_is_at91sam9263()) {
+		cpu_id.is_at91sam9263 = 1;
 		current_soc = at91sam9263_soc;
-	else if (cpu_is_at91sam9g45())
+	} else if (__cpu_is_at91sam9g45()) {
+		cpu_id.is_at91sam9g45 = AT91_SAM9G45;
+		if (__cpu_is_at91sam9g45es())
+			cpu_id.is_at91sam9g45 |= AT91_SAM9G45ES;
+		else if (__cpu_is_at91sam9m10())
+			cpu_id.is_at91sam9g45 |= AT91_SAM9M10;
+		else if (__cpu_is_at91sam9g46())
+			cpu_id.is_at91sam9g45 |= AT91_SAM9G46;
+		else if (__cpu_is_at91sam9m11())
+			cpu_id.is_at91sam9g45 |= AT91_SAM9M11;
 		current_soc = at91sam9g45_soc;
-	else if (cpu_is_at91sam9rl())
+	} else if (__cpu_is_at91sam9rl()) {
+		cpu_id.is_at91sam9rl = 1;
 		current_soc = at91sam9rl_soc;
-	else if (cpu_is_at91sam9x5())
+	} else if (__cpu_is_at91sam9x5()) {
+		cpu_id.is_at91sam9x5 = AT91_SAM9X5;
+		if (__cpu_is_at91sam9g15())
+			cpu_id.is_at91sam9x5 |= AT91_SAM9G15;
+		else if (__cpu_is_at91sam9g35())
+			cpu_id.is_at91sam9x5 |= AT91_SAM9G35;
+		else if (__cpu_is_at91sam9x35())
+			cpu_id.is_at91sam9x5 |= AT91_SAM9X35;
+		else if (__cpu_is_at91sam9g25())
+			cpu_id.is_at91sam9x5 |= AT91_SAM9G25;
+		else if (__cpu_is_at91sam9x25())
+			cpu_id.is_at91sam9x5 |= AT91_SAM9X25;
 		current_soc = at91sam9x5_soc;
-	else
+	} else {
 		panic("Impossible to detect the CPU type");
+	}
 
 	pr_info("AT91: detected soc: %s\n", current_soc.name);
 
-- 
1.7.4.1
