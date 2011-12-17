From: jamie@jamieiles.com (Jamie Iles)
Date: Sat, 17 Dec 2011 13:42:34 +0000
Subject: [PATCHv2 2/5] ARM: picoxcell: don't reserve irq_descs
In-Reply-To: <1324129357-16030-1-git-send-email-jamie@jamieiles.com>
References: <1324129357-16030-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1324129357-16030-3-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All irq_desc's are now dynamically allocated so we don't need to
statically reserve them.

v2:	- select SPARSE_IRQ and set .nr_irqs to NR_IRQS_LEGACY to skip
	ISA and IRQ 0.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/Kconfig                            |    1 +
 arch/arm/mach-picoxcell/common.c            |    2 +-
 arch/arm/mach-picoxcell/include/mach/irqs.h |    9 ++-------
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 44789ef..0831d48 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -650,6 +650,7 @@ config ARCH_PICOXCELL
 	select HAVE_SCHED_CLOCK
 	select HAVE_TCM
 	select NO_IOPORT
+	select SPARSE_IRQ
 	select USE_OF
 	help
 	  This enables support for systems based on the Picochip picoXcell
diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
index ad871bd..d34b333 100644
--- a/arch/arm/mach-picoxcell/common.c
+++ b/arch/arm/mach-picoxcell/common.c
@@ -45,7 +45,7 @@ static void __init picoxcell_init_irq(void)
 
 DT_MACHINE_START(PICOXCELL, "Picochip picoXcell")
 	.map_io		= picoxcell_map_io,
-	.nr_irqs	= ARCH_NR_IRQS,
+	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= picoxcell_init_irq,
 	.handle_irq	= vic_handle_irq,
 	.timer		= &picoxcell_timer,
diff --git a/arch/arm/mach-picoxcell/include/mach/irqs.h b/arch/arm/mach-picoxcell/include/mach/irqs.h
index 4d13ed9..59eac1e 100644
--- a/arch/arm/mach-picoxcell/include/mach/irqs.h
+++ b/arch/arm/mach-picoxcell/include/mach/irqs.h
@@ -1,8 +1,6 @@
 /*
  * Copyright (c) 2011 Picochip Ltd., Jamie Iles
  *
- * This file contains the hardware definitions of the picoXcell SoC devices.
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -16,10 +14,7 @@
 #ifndef __MACH_IRQS_H
 #define __MACH_IRQS_H
 
-#define ARCH_NR_IRQS			64
-#define NR_IRQS				(128 + ARCH_NR_IRQS)
-
-#define IRQ_VIC0_BASE			0
-#define IRQ_VIC1_BASE			32
+/* We dynamically allocate our irq_desc's. */
+#define NR_IRQS				0
 
 #endif /* __MACH_IRQS_H */
-- 
1.7.5.4
