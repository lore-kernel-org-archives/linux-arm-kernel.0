From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Mar 2013 23:14:28 +0100
Subject: [PATCH 2/5] ARM: cns3xxx: enable sparse IRQ support
In-Reply-To: <1363299271-8283-1-git-send-email-arnd@arndb.de>
References: <1363299271-8283-1-git-send-email-arnd@arndb.de>
Message-ID: <1363299271-8283-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This trivially enables sparse IRQ on cns3xxx by moving the
nr_irqs definition from mach/irqs.h into the machine
descriptor. These interrupts will still get statically
assigned, so nothing changes here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                          |  1 +
 arch/arm/mach-cns3xxx/cns3420vb.c         |  1 +
 arch/arm/mach-cns3xxx/include/mach/irqs.h | 24 ------------------------
 3 files changed, 2 insertions(+), 24 deletions(-)
 delete mode 100644 arch/arm/mach-cns3xxx/include/mach/irqs.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5b71469..8bad33e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -390,6 +390,7 @@ config ARCH_CNS3XXX
 	select MIGHT_HAVE_CACHE_L2X0
 	select MIGHT_HAVE_PCI
 	select PCI_DOMAINS if PCI
+	select SPARSE_IRQ
 	help
 	  Support for Cavium Networks CNS3XXX platform.
 
diff --git a/arch/arm/mach-cns3xxx/cns3420vb.c b/arch/arm/mach-cns3xxx/cns3420vb.c
index d863d87..ce096d6 100644
--- a/arch/arm/mach-cns3xxx/cns3420vb.c
+++ b/arch/arm/mach-cns3xxx/cns3420vb.c
@@ -246,6 +246,7 @@ static void __init cns3420_map_io(void)
 
 MACHINE_START(CNS3420VB, "Cavium Networks CNS3420 Validation Board")
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_IRQS_CNS3XXX,
 	.map_io		= cns3420_map_io,
 	.init_irq	= cns3xxx_init_irq,
 	.init_time	= cns3xxx_timer_init,
diff --git a/arch/arm/mach-cns3xxx/include/mach/irqs.h b/arch/arm/mach-cns3xxx/include/mach/irqs.h
deleted file mode 100644
index 2ab96f8..0000000
--- a/arch/arm/mach-cns3xxx/include/mach/irqs.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * Copyright 2000 Deep Blue Solutions Ltd.
- * Copyright 2003 ARM Limited
- * Copyright 2008 Cavium Networks
- *
- * This file is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, Version 2, as
- * published by the Free Software Foundation.
- */
-
-#ifndef __MACH_IRQS_H
-#define __MACH_IRQS_H
-
-#define IRQ_LOCALTIMER		29
-#define IRQ_LOCALWDOG		30
-#define IRQ_TC11MP_GIC_START	32
-
-#include <mach/cns3xxx.h>
-
-#ifndef NR_IRQS
-#error "NR_IRQS not defined by the board-specific files"
-#endif
-
-#endif
-- 
1.8.1.2
