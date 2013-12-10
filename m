From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon,  9 Dec 2013 16:12:13 -0800
Subject: [PATCH 2/3] arm64: Enable CMA
In-Reply-To: <1386634334-31139-1-git-send-email-lauraa@codeaurora.org>
References: <1386634334-31139-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1386634334-31139-3-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64 bit targets need the features CMA provides. Add the appropriate
hooks, header files, and Kconfig to allow this to happen.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/Kconfig                      |    1 +
 arch/arm64/include/asm/dma-contiguous.h |   29 +++++++++++++++++++++++++++++
 arch/arm64/mm/init.c                    |    3 +++
 3 files changed, 33 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/dma-contiguous.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 88c8b6c1..0dee133 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -24,6 +24,7 @@ config ARM64
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_ATTRS
+	select HAVE_DMA_CONTIGUOUS
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_MEMBLOCK
diff --git a/arch/arm64/include/asm/dma-contiguous.h b/arch/arm64/include/asm/dma-contiguous.h
new file mode 100644
index 0000000..3d967f3
--- /dev/null
+++ b/arch/arm64/include/asm/dma-contiguous.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (c) 2013, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef ASMARM64_DMA_CONTIGUOUS_H
+#define ASMARM64_DMA_CONTIGUOUS_H
+
+#ifdef __KERNEL__
+#ifdef CONFIG_DMA_CMA
+
+#include <linux/types.h>
+#include <asm-generic/dma-contiguous.h>
+
+static inline void
+dma_contiguous_early_fixup(phys_addr_t base, unsigned long size) { }
+
+#endif
+#endif
+
+#endif
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 0cb8742..d0b4c2e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -30,6 +30,7 @@
 #include <linux/memblock.h>
 #include <linux/sort.h>
 #include <linux/of_fdt.h>
+#include <linux/dma-contiguous.h>
 
 #include <asm/sections.h>
 #include <asm/setup.h>
@@ -159,6 +160,8 @@ void __init arm64_memblock_init(void)
 		memblock_reserve(base, size);
 	}
 
+	dma_contiguous_reserve(0);
+
 	memblock_allow_resize();
 	memblock_dump_all();
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
