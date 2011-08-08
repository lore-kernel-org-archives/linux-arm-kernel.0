From: tixy@yxit.co.uk (Jon Medhurst)
Date: Mon,  8 Aug 2011 15:28:27 +0100
Subject: [PATCH 07/12] ARM: mach-davinci: Setup consistent dma size at boot
	time
In-Reply-To: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
References: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1312813712-22808-8-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
CC: Sekhar Nori <nsekhar@ti.com>
CC: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-davinci/include/mach/memory.h |    5 -----
 arch/arm/mach-davinci/common.c              |    3 +++
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/memory.h b/arch/arm/mach-davinci/include/mach/memory.h
index 7873194..885d233 100644
--- a/arch/arm/mach-davinci/include/mach/memory.h
+++ b/arch/arm/mach-davinci/include/mach/memory.h
@@ -36,9 +36,4 @@
 #define DDR2_MCLKSTOPEN_BIT	BIT(30)
 #define DDR2_LPMODEN_BIT	BIT(31)
 
-/*
- * Increase size of DMA-consistent memory region
- */
-#define CONSISTENT_DMA_SIZE (14<<20)
-
 #endif /* __ASM_ARCH_MEMORY_H */
diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index 1d25573..865ffe5 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/etherdevice.h>
 #include <linux/davinci_emac.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/tlb.h>
 #include <asm/mach/map.h>
@@ -86,6 +87,8 @@ void __init davinci_common_init(struct davinci_soc_info *soc_info)
 		iotable_init(davinci_soc_info.io_desc,
 				davinci_soc_info.io_desc_num);
 
+	init_consistent_dma_size(14 << 20);
+
 	/*
 	 * Normally devicemaps_init() would flush caches and tlb after
 	 * mdesc->map_io(), but we must also do it here because of the CPU
-- 
1.7.2.5
