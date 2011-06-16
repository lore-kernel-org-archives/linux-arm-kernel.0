From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 16 Jun 2011 20:06:33 +0100
Subject: [RFC PATCH 05/16] ARM: local timers: remove localtimer.c from
	plat-versatile
In-Reply-To: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1308251204-16719-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the localtimer infrastructure is not use anymore by any of
the Versatile platforms, remove localtimer.c.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/plat-versatile/Makefile     |    1 -
 arch/arm/plat-versatile/localtimer.c |   28 ----------------------------
 2 files changed, 0 insertions(+), 29 deletions(-)
 delete mode 100644 arch/arm/plat-versatile/localtimer.c

diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index 69714db..a5cb194 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1,5 +1,4 @@
 obj-y	:= clock.o
-obj-$(CONFIG_LOCAL_TIMERS) += localtimer.o
 obj-$(CONFIG_PLAT_VERSATILE_CLCD) += clcd.o
 obj-$(CONFIG_PLAT_VERSATILE_FPGA_IRQ) += fpga-irq.o
 obj-$(CONFIG_PLAT_VERSATILE_LEDS) += leds.o
diff --git a/arch/arm/plat-versatile/localtimer.c b/arch/arm/plat-versatile/localtimer.c
deleted file mode 100644
index a76daf4..0000000
--- a/arch/arm/plat-versatile/localtimer.c
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- *  linux/arch/arm/plat-versatile/localtimer.c
- *
- *  Copyright (C) 2002 ARM Ltd.
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/clockchips.h>
-
-#include <asm/smp_twd.h>
-#include <asm/localtimer.h>
-#include <asm/hardware/gic.h>
-#include <mach/irqs.h>
-
-/*
- * Setup the local clock events for a CPU.
- */
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	evt->irq = gic_ppi_to_vppi(IRQ_LOCALTIMER);
-	twd_timer_setup(evt);
-	return 0;
-}
-- 
1.7.0.4
