From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 18 Feb 2014 14:38:00 +0100
Subject: [PATCH v3 5/6] ARM: init: add support for reserved memory defined by
 device tree
In-Reply-To: <1392730681-14695-1-git-send-email-m.szyprowski@samsung.com>
References: <1392730681-14695-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1392730681-14695-6-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable reserved memory initialization from device tree.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/Kconfig   |    1 +
 arch/arm/mm/init.c |    3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e25419817791..d0262bea8020 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1918,6 +1918,7 @@ config USE_OF
 	select IRQ_DOMAIN
 	select OF
 	select OF_EARLY_FLATTREE
+	select OF_RESERVED_MEM
 	help
 	  Include support for flattened device tree machine descriptions.
 
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 804d61566a53..ebafdb479410 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -17,6 +17,7 @@
 #include <linux/nodemask.h>
 #include <linux/initrd.h>
 #include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/highmem.h>
 #include <linux/gfp.h>
 #include <linux/memblock.h>
@@ -323,6 +324,8 @@ void __init arm_memblock_init(struct meminfo *mi,
 	if (mdesc->reserve)
 		mdesc->reserve();
 
+	early_init_dt_scan_reserved_mem();
+
 	/*
 	 * reserve memory for DMA contigouos allocations,
 	 * must come from DMA area inside low memory
-- 
1.7.9.5
