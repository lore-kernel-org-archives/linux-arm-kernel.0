From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed,  6 Jul 2016 16:52:19 +0900
Subject: [PATCH v21 1/8] arm64: kdump: reserve memory for crash dump kernel
In-Reply-To: <20160706075226.27609-1-takahiro.akashi@linaro.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
Message-ID: <20160706075226.27609-2-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the startup of primary kernel, the memory region used by crash dump
kernel must be specified by "crashkernel=" kernel parameter.
reserve_crashkernel() will allocate and reserve the region for later use.

User space tools, like kexec-tools, will be able to find that region marked
as "Crash kernel" in /proc/iomem.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Mark Salter <msalter@redhat.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/setup.c |  7 +++++-
 arch/arm64/mm/init.c      | 62 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index c1509e6..cb5eee0 100644
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
@@ -222,6 +221,12 @@ static void __init request_standard_resources(void)
 		    kernel_data.end <= res->end)
 			request_resource(res, &kernel_data);
 	}
+
+#ifdef CONFIG_KEXEC_CORE
+	/* User space tools will find "Crash kernel" region in /proc/iomem. */
+	if (crashk_res.end)
+		insert_resource(&iomem_resource, &crashk_res);
+#endif
 }
 
 u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 2ade7a6..e1134fb 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -34,6 +34,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/efi.h>
 #include <linux/swiotlb.h>
+#include <linux/kexec.h>
 
 #include <asm/boot.h>
 #include <asm/fixmap.h>
@@ -76,6 +77,65 @@ static int __init early_initrd(char *p)
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
+	unsigned long long crash_size = 0, crash_base = 0;
+	int ret;
+
+	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
+				&crash_size, &crash_base);
+	/* no crashkernel= or invalid value specified */
+	if (ret || !crash_size)
+		return;
+
+	if (crash_base == 0) {
+		/* Current arm64 boot protocol requires 2MB alignment */
+		crash_base = memblock_find_in_range(0,
+				MEMBLOCK_ALLOC_ACCESSIBLE, crash_size, SZ_2M);
+		if (crash_base == 0) {
+			pr_warn("Unable to allocate crashkernel (size:%llx)\n",
+				crash_size);
+			return;
+		}
+		memblock_reserve(crash_base, crash_size);
+
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
+
+		memblock_reserve(crash_base, crash_size);
+	}
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
+	;
+}
+#endif /* CONFIG_KEXEC_CORE */
+
 /*
  * Return the maximum physical address for ZONE_DMA (DMA_BIT_MASK(32)). It
  * currently assumes that for memory starting above 4G, 32-bit devices will
@@ -289,6 +349,8 @@ void __init arm64_memblock_init(void)
 	}
 #endif
 
+	reserve_crashkernel();
+
 	early_init_fdt_scan_reserved_mem();
 
 	/* 4GB maximum for 32-bit only capable devices */
-- 
2.9.0
