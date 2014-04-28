From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 17:58:27 +0100
Subject: [PATCH 08/16] ARM: l2c: convert prima2 to generic l2c initialisation
In-Reply-To: <20140428165631.GM26756@n2100.arm.linux.org.uk>
References: <20140428165631.GM26756@n2100.arm.linux.org.uk>
Message-ID: <E1Weost-0002Pn-OT@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Along with this change, we can delete l2x0.c from prima2.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-prima2/Makefile |  1 -
 arch/arm/mach-prima2/common.c |  6 ++++++
 arch/arm/mach-prima2/l2x0.c   | 17 -----------------
 3 files changed, 6 insertions(+), 18 deletions(-)
 delete mode 100644 arch/arm/mach-prima2/l2x0.c

diff --git a/arch/arm/mach-prima2/Makefile b/arch/arm/mach-prima2/Makefile
index 7a6b4a323125..8846e7d87ea5 100644
--- a/arch/arm/mach-prima2/Makefile
+++ b/arch/arm/mach-prima2/Makefile
@@ -2,7 +2,6 @@ obj-y += rstc.o
 obj-y += common.o
 obj-y += rtciobrg.o
 obj-$(CONFIG_DEBUG_LL) += lluart.o
-obj-$(CONFIG_CACHE_L2X0) += l2x0.o
 obj-$(CONFIG_SUSPEND) += pm.o sleep.o
 obj-$(CONFIG_SMP) += platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)  += hotplug.o
diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index 47c7819edb9b..1cdb8b565cfe 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -34,6 +34,8 @@ static const char *atlas6_dt_match[] __initconst = {
 
 DT_MACHINE_START(ATLAS6_DT, "Generic ATLAS6 (Flattened Device Tree)")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
+	.l2c_aux_val	= 0,
+	.l2c_aux_mask	= ~0,
 	.map_io         = sirfsoc_map_io,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = atlas6_dt_match,
@@ -48,6 +50,8 @@ static const char *prima2_dt_match[] __initconst = {
 
 DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
+	.l2c_aux_val	= 0,
+	.l2c_aux_mask	= ~0,
 	.map_io         = sirfsoc_map_io,
 	.dma_zone_size	= SZ_256M,
 	.init_late	= sirfsoc_init_late,
@@ -64,6 +68,8 @@ static const char *marco_dt_match[] __initconst = {
 DT_MACHINE_START(MARCO_DT, "Generic MARCO (Flattened Device Tree)")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
 	.smp            = smp_ops(sirfsoc_smp_ops),
+	.l2c_aux_val	= 0,
+	.l2c_aux_mask	= ~0,
 	.map_io         = sirfsoc_map_io,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = marco_dt_match,
diff --git a/arch/arm/mach-prima2/l2x0.c b/arch/arm/mach-prima2/l2x0.c
deleted file mode 100644
index 09f68f046830..000000000000
--- a/arch/arm/mach-prima2/l2x0.c
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * l2 cache initialization for CSR SiRFprimaII
- *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
- *
- * Licensed under GPLv2 or later.
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <asm/hardware/cache-l2x0.h>
-
-static int __init sirfsoc_l2x0_init(void)
-{
-	return l2x0_of_init(0, ~0);
-}
-early_initcall(sirfsoc_l2x0_init);
-- 
1.8.3.1
