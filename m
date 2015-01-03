From: 21cnbao@gmail.com (Barry Song)
Date: Sat,  3 Jan 2015 16:27:41 +0800
Subject: [PATCH V3 07/10] ARM: sirf: move to debug_ll_io_init and drop map_io
In-Reply-To: <1420273664-10438-1-git-send-email-21cnbao@gmail.com>
References: <1420273664-10438-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1420273664-10438-8-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

this patch moves to debug_ll_io_init(), then finally drops CSR map_io()
machine callbacks.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-prima2/common.c |  7 -------
 arch/arm/mach-prima2/lluart.c | 33 ---------------------------------
 2 files changed, 40 deletions(-)
 delete mode 100644 arch/arm/mach-prima2/lluart.c

diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index a20b8d4..c62ff68 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -20,11 +20,6 @@ static void __init sirfsoc_init_late(void)
 	sirfsoc_pm_init();
 }
 
-static __init void sirfsoc_map_io(void)
-{
-	sirfsoc_map_lluart();
-}
-
 #ifdef CONFIG_ARCH_ATLAS6
 static const char *atlas6_dt_match[] __initconst = {
 	"sirf,atlas6",
@@ -35,7 +30,6 @@ DT_MACHINE_START(ATLAS6_DT, "Generic ATLAS6 (Flattened Device Tree)")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
-	.map_io         = sirfsoc_map_io,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = atlas6_dt_match,
 MACHINE_END
@@ -51,7 +45,6 @@ DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
-	.map_io         = sirfsoc_map_io,
 	.dma_zone_size	= SZ_256M,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = prima2_dt_match,
diff --git a/arch/arm/mach-prima2/lluart.c b/arch/arm/mach-prima2/lluart.c
deleted file mode 100644
index 20453c1..0000000
--- a/arch/arm/mach-prima2/lluart.c
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * Static memory mapping for DEBUG_LL
- *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
- *
- * Licensed under GPLv2 or later.
- */
-
-#include <linux/kernel.h>
-#include <asm/page.h>
-#include <asm/mach/map.h>
-#include "common.h"
-
-#if defined(CONFIG_DEBUG_SIRFPRIMA2_UART1)
-#define SIRFSOC_UART1_PA_BASE          0xb0060000
-#else
-#define SIRFSOC_UART1_PA_BASE          0
-#endif
-
-#define SIRFSOC_UART1_VA_BASE          SIRFSOC_VA(0x060000)
-#define SIRFSOC_UART1_SIZE		SZ_4K
-
-void __init sirfsoc_map_lluart(void)
-{
-	struct map_desc sirfsoc_lluart_map = {
-		.virtual        = SIRFSOC_UART1_VA_BASE,
-		.pfn            = __phys_to_pfn(SIRFSOC_UART1_PA_BASE),
-		.length         = SIRFSOC_UART1_SIZE,
-		.type           = MT_DEVICE,
-	};
-
-	iotable_init(&sirfsoc_lluart_map, 1);
-}
-- 
2.2.1
