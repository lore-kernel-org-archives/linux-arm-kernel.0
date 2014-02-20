From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 20 Feb 2014 11:52:46 +0100
Subject: [PATCH v4 6/7] arm64: add support for reserved memory defined by
 device tree
In-Reply-To: <1392893567-31623-1-git-send-email-m.szyprowski@samsung.com>
References: <1392893567-31623-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1392893567-31623-7-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable reserved memory initialization from device tree.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm64/Kconfig   |    1 +
 arch/arm64/mm/init.c |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 27bbcfc7202a..6abf15407dca 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -43,6 +43,7 @@ config ARM64
 	select NO_BOOTMEM
 	select OF
 	select OF_EARLY_FLATTREE
+	select OF_RESERVED_MEM
 	select PERF_USE_VMALLOC
 	select POWER_RESET
 	select POWER_SUPPLY
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index d0b4c2efda90..447550d6bd9b 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -30,6 +30,7 @@
 #include <linux/memblock.h>
 #include <linux/sort.h>
 #include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/dma-contiguous.h>
 
 #include <asm/sections.h>
@@ -160,6 +161,7 @@ void __init arm64_memblock_init(void)
 		memblock_reserve(base, size);
 	}
 
+	early_init_fdt_scan_reserved_mem();
 	dma_contiguous_reserve(0);
 
 	memblock_allow_resize();
-- 
1.7.9.5
