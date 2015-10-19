From: geoff@infradead.org (Geoff Levand)
Date: Mon, 19 Oct 2015 23:38:54 +0000
Subject: [PATCH 11/16] arm64: kdump: reserve memory for crash dump kernel
In-Reply-To: <cover.1445297709.git.geoff@infradead.org>
References: <cover.1445297709.git.geoff@infradead.org>
Message-ID: <2a2dedbeafd39f862f1704a9cc7f57612223ffe5.1445297709.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

On primary kernel, the memory region used by crash dump kernel must be
specified by "crashkernel=" boot parameter. reserve_crashkernel()
will allocate and reserve the region for later use.

User space tools will be able to find the region marked as "Crash kernel"
in /proc/iomem.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/setup.c |  7 +++++-
 arch/arm64/mm/init.c      | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 2322479..9d085ac 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -32,7 +32,6 @@
 #include <linux/screen_info.h>
 #include <linux/init.h>
 #include <linux/kexec.h>
-#include <linux/crash_dump.h>
 #include <linux/root_dev.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
@@ -337,6 +336,12 @@ static void __init request_standard_resources(void)
 		    kernel_data.end <= res->end)
 			request_resource(res, &kernel_data);
 	}
+
+#ifdef CONFIG_KEXEC
+	/* User space tools will find "Crash kernel" region in /proc/iomem. */
+	if (crashk_res.end)
+		insert_resource(&iomem_resource, &crashk_res);
+#endif
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f5c0680..f33f201 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -34,6 +34,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/efi.h>
 #include <linux/swiotlb.h>
+#include <linux/kexec.h>
 
 #include <asm/fixmap.h>
 #include <asm/memory.h>
@@ -66,6 +67,55 @@ static int __init early_initrd(char *p)
 early_param("initrd", early_initrd);
 #endif
 
+#ifdef CONFIG_KEXEC
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
+	if (ret)
+		return;
+
+	if (crash_base == 0) {
+		crash_base = memblock_alloc(crash_size, 1 << 21);
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
+		if (crash_base & ((1 << 21) - 1)) {
+			pr_warn("crashkernel base address is not 2MB aligned\n");
+			return;
+		}
+
+		memblock_reserve(crash_base, crash_size);
+	}
+
+	pr_info("Reserving %lldMB of memory@%lldMB for crashkernel\n",
+		crash_size >> 20, crash_base >> 20);
+
+	crashk_res.start = crash_base;
+	crashk_res.end = crash_base + crash_size - 1;
+}
+#endif /* CONFIG_KEXEC */
+
 /*
  * Return the maximum physical address for ZONE_DMA (DMA_BIT_MASK(32)). It
  * currently assumes that for memory starting above 4G, 32-bit devices will
@@ -170,6 +220,10 @@ void __init arm64_memblock_init(void)
 		memblock_reserve(__virt_to_phys(initrd_start), initrd_end - initrd_start);
 #endif
 
+#ifdef CONFIG_KEXEC
+	reserve_crashkernel();
+#endif
+
 	early_init_fdt_scan_reserved_mem();
 
 	/* 4GB maximum for 32-bit only capable devices */
-- 
2.5.0
