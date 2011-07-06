From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:30:21 -0400
Subject: [PATCH 37/37] ARM: mach-pxa: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-37-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                        |    1 +
 arch/arm/mach-pxa/include/mach/memory.h |   20 --------------------
 arch/arm/mach-pxa/pxa25x.c              |    2 +-
 arch/arm/mach-pxa/pxa27x.c              |    2 +-
 arch/arm/mach-pxa/pxa3xx.c              |    2 +-
 arch/arm/mach-pxa/zeus.c                |    2 +-
 6 files changed, 5 insertions(+), 24 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 46d4c84..ec1c799 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -655,6 +655,7 @@ config ARCH_PXA
 	select TICK_ONESHOT
 	select PLAT_PXA
 	select SPARSE_IRQ
+	select NO_MACH_MEMORY_H
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
 
diff --git a/arch/arm/mach-pxa/include/mach/memory.h b/arch/arm/mach-pxa/include/mach/memory.h
deleted file mode 100644
index d05a597..0000000
--- a/arch/arm/mach-pxa/include/mach/memory.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- *  arch/arm/mach-pxa/include/mach/memory.h
- *
- * Author:	Nicolas Pitre
- * Copyright:	(C) 2001 MontaVista Software Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-/*
- * Physical DRAM offset.
- */
-#define PLAT_PHYS_OFFSET	UL(0xa0000000)
-
-#endif
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index fed363c..8b18ccc 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -244,7 +244,7 @@ static void pxa25x_cpu_pm_enter(suspend_state_t state)
 
 	switch (state) {
 	case PM_SUSPEND_MEM:
-		pxa25x_cpu_suspend(PWRMODE_SLEEP, PLAT_PHYS_OFFSET - PAGE_OFFSET);
+		pxa25x_cpu_suspend(PWRMODE_SLEEP, PHYS_OFFSET - PAGE_OFFSET);
 		break;
 	}
 }
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 2fecbec..81e0052 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -299,7 +299,7 @@ void pxa27x_cpu_pm_enter(suspend_state_t state)
 		pxa_cpu_standby();
 		break;
 	case PM_SUSPEND_MEM:
-		pxa27x_cpu_suspend(pwrmode, PLAT_PHYS_OFFSET - PAGE_OFFSET);
+		pxa27x_cpu_suspend(pwrmode, PHYS_OFFSET - PAGE_OFFSET);
 		break;
 	}
 }
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 8521d7d..4d48321 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -162,7 +162,7 @@ static void pxa3xx_cpu_pm_suspend(void)
 	/* overwrite with the resume address */
 	*p = virt_to_phys(cpu_resume);
 
-	pxa3xx_cpu_suspend(PLAT_PHYS_OFFSET - PAGE_OFFSET);
+	pxa3xx_cpu_suspend(PHYS_OFFSET - PAGE_OFFSET);
 
 	*p = saved_data;
 
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 56fa747..c48b558 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -676,7 +676,7 @@ static struct pxa2xx_udc_mach_info zeus_udc_info = {
 static void zeus_power_off(void)
 {
 	local_irq_disable();
-	pxa27x_cpu_suspend(PWRMODE_DEEPSLEEP, PLAT_PHYS_OFFSET - PAGE_OFFSET);
+	pxa27x_cpu_suspend(PWRMODE_DEEPSLEEP, PHYS_OFFSET - PAGE_OFFSET);
 }
 #else
 #define zeus_power_off   NULL
-- 
1.7.4
