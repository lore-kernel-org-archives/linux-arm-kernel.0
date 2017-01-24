From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 24 Jan 2017 17:49:57 +0900
Subject: [PATCH v30 03/11] arm64: kdump: reserve memory for crash dump kernel
In-Reply-To: <20170124084638.3770-1-takahiro.akashi@linaro.org>
References: <20170124084638.3770-1-takahiro.akashi@linaro.org>
Message-ID: <20170124085004.3892-2-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"crashkernel=" kernel parameter specifies the size (and optionally
the start address) of the system ram used by crash dump kernel.
reserve_crashkernel() will allocate and reserve the memory at the startup
of primary kernel.

This memory range will be exported to userspace via an entry named
"Crash kernel" in /proc/iomem.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Mark Salter <msalter@redhat.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
Reviewed-by: James Morse <james.morse@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/setup.c |  7 +++++-
 arch/arm64/mm/init.c      | 62 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index b051367e2149..515e9c6696df 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -31,7 +31,6 @@
 #include <linux/screen_info.h>
 #include <linux/init.h>
 #include <linux/kexec.h>
-#include <linux/crash_dump.h>
 #include <linux/root_dev.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
@@ -224,6 +223,12 @@ static void __init request_standard_resources(void)
 		if (kernel_data.start >= res->start &&
 		    kernel_data.end <= res->end)
 			request_resource(res, &kernel_data);
+#ifdef CONFIG_KEXEC_CORE
+		/* Userspace will find "Crash kernel" region in /proc/iomem. */
+		if (crashk_res.end && crashk_res.start >= res->start &&
+		    crashk_res.end <= res->end)
+			request_resource(res, &crashk_res);
+#endif
 	}
 }
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 6cddb566eb21..2aba75dc7720 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -30,12 +30,14 @@
 #include <linux/gfp.h>
 #include <linux/memblock.h>
 #include <linux/sort.h>
+#include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma-contiguous.h>
 #include <linux/efi.h>
 #include <linux/swiotlb.h>
 #include <linux/vmalloc.h>
+#include <linux/kexec.h>
 
 #include <asm/boot.h>
 #include <asm/fixmap.h>
@@ -76,6 +78,63 @@ static int __init early_initrd(char *p)
 early_param("initrd", early_initrd);
 #endif
 
+#ifdef CONFIG_KEXEC_CORE
+/*
+ * reserve_crashkernel() - reserves memory for crash kernel
+ *
+ * This function reserves memory area given in "crashkernel=" kernel command
+ * line parameter. The memory reserved is used by dump capture kernel when
+ * primary kernel is crashing.
+ */
+static void __init reserve_crashkernel(void)
+{
+	unsigned long long crash_base, crash_size;
+	int ret;
+
+	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
+				&crash_size, &crash_base);
+	/* no crashkernel= or invalid value specified */
+	if (ret || !crash_size)
+		return;
+
+	crash_size = PAGE_ALIGN(crash_size);
+
+	if (crash_base == 0) {
+		/* Current arm64 boot protocol requires 2MB alignment */
+		crash_base = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
+				crash_size, SZ_2M);
+		if (crash_base == 0) {
+			pr_warn("Unable to allocate crashkernel (size:%llx)\n",
+				crash_size);
+			return;
+		}
+	} else {
+		/* User specifies base address explicitly. */
+		if (!memblock_is_region_memory(crash_base, crash_size) ||
+			memblock_is_region_reserved(crash_base, crash_size)) {
+			pr_warn("crashkernel has wrong address or size\n");
+			return;
+		}
+
+		if (!IS_ALIGNED(crash_base, SZ_2M)) {
+			pr_warn("crashkernel base address is not 2MB aligned\n");
+			return;
+		}
+	}
+	memblock_reserve(crash_base, crash_size);
+
+	pr_info("Reserving %lldMB of memory at %lldMB for crashkernel\n",
+		crash_size >> 20, crash_base >> 20);
+
+	crashk_res.start = crash_base;
+	crashk_res.end = crash_base + crash_size - 1;
+}
+#else
+static void __init reserve_crashkernel(void)
+{
+}
+#endif /* CONFIG_KEXEC_CORE */
+
 /*
  * Return the maximum physical address for ZONE_DMA (DMA_BIT_MASK(32)). It
  * currently assumes that for memory starting above 4G, 32-bit devices will
@@ -331,6 +390,9 @@ void __init arm64_memblock_init(void)
 		arm64_dma_phys_limit = max_zone_dma_phys();
 	else
 		arm64_dma_phys_limit = PHYS_MASK + 1;
+
+	reserve_crashkernel();
+
 	dma_contiguous_reserve(arm64_dma_phys_limit);
 
 	memblock_allow_resize();
-- 
2.11.0
