From: tixy@yxit.co.uk (Jon Medhurst)
Date: Mon,  8 Aug 2011 15:28:28 +0100
Subject: [PATCH 08/12] ARM: mach-u300: Setup consistent dma size at boot time
In-Reply-To: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
References: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1312813712-22808-9-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
CC: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-u300/include/mach/memory.h |    5 -----
 arch/arm/mach-u300/core.c                |    3 +++
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-u300/include/mach/memory.h b/arch/arm/mach-u300/include/mach/memory.h
index 888e2e3..38741da 100644
--- a/arch/arm/mach-u300/include/mach/memory.h
+++ b/arch/arm/mach-u300/include/mach/memory.h
@@ -34,9 +34,4 @@
 	    (CONFIG_MACH_U300_ACCESS_MEM_SIZE & 1))*1024*1024 + 0x100)
 #endif
 
-/*
- * We enable a real big DMA buffer if need be.
- */
-#define CONSISTENT_DMA_SIZE SZ_4M
-
 #endif
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 399c89f..376b6df 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -25,6 +25,7 @@
 #include <linux/err.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/fsmc.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/types.h>
 #include <asm/setup.h>
@@ -92,6 +93,8 @@ static struct map_desc u300_io_desc[] __initdata = {
 void __init u300_map_io(void)
 {
 	iotable_init(u300_io_desc, ARRAY_SIZE(u300_io_desc));
+	/* We enable a real big DMA buffer if need be. */
+	init_consistent_dma_size(SZ_4M);
 }
 
 /*
-- 
1.7.2.5
