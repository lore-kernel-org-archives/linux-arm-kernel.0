From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 23 Sep 2016 17:37:29 +0900
Subject: [PATCH v26 1/7] arm64: kdump: reserve memory for crash dump kernel
In-Reply-To: <26b1e4d1-e4a6-a4f7-bdf8-cd97363ce1ee@suse.com>
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <20160907042908.6232-2-takahiro.akashi@linaro.org>
 <26b1e4d1-e4a6-a4f7-bdf8-cd97363ce1ee@suse.com>
Message-ID: <20160923083728.GM30248@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2016 at 12:23:08PM +0200, Matthias Bruger wrote:
> 
> 
> On 09/07/2016 06:29 AM, AKASHI Takahiro wrote:
> >On the startup of primary kernel, the memory region used by crash dump
> >kernel must be specified by "crashkernel=" kernel parameter.
> >reserve_crashkernel() will allocate and reserve the region for later use.
> >
> >User space tools, like kexec-tools, will be able to find that region as
> >	- "Crash kernel" in /proc/iomem, or
> >	- "linux,crashkernel-base" and "linux,crashkernel-size" under
> >	  /sys/firmware/devicetree/base/chosen
> >
> >Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >Signed-off-by: Mark Salter <msalter@redhat.com>
> >Signed-off-by: Pratyush Anand <panand@redhat.com>
> >Reviewed-by: James Morse <james.morse@arm.com>
> >---
> > arch/arm64/kernel/setup.c |   7 ++-
> > arch/arm64/mm/init.c      | 113 ++++++++++++++++++++++++++++++++++++++++++++++
> > 2 files changed, 119 insertions(+), 1 deletion(-)
> >
> >diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> >index 514b4e3..38589b5 100644
> >--- a/arch/arm64/kernel/setup.c
> >+++ b/arch/arm64/kernel/setup.c
> >@@ -31,7 +31,6 @@
> > #include <linux/screen_info.h>
> > #include <linux/init.h>
> > #include <linux/kexec.h>
> >-#include <linux/crash_dump.h>
> > #include <linux/root_dev.h>
> > #include <linux/cpu.h>
> > #include <linux/interrupt.h>
> >@@ -225,6 +224,12 @@ static void __init request_standard_resources(void)
> > 		    kernel_data.end <= res->end)
> > 			request_resource(res, &kernel_data);
> > 	}
> >+
> >+#ifdef CONFIG_KEXEC_CORE
> >+	/* User space tools will find "Crash kernel" region in /proc/iomem. */
> >+	if (crashk_res.end)
> >+		insert_resource(&iomem_resource, &crashk_res);
> >+#endif
> > }
> >
> > u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
> >diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >index bbb7ee7..dd273ec 100644
> >--- a/arch/arm64/mm/init.c
> >+++ b/arch/arm64/mm/init.c
> >@@ -29,11 +29,13 @@
> > #include <linux/gfp.h>
> > #include <linux/memblock.h>
> > #include <linux/sort.h>
> >+#include <linux/of.h>
> > #include <linux/of_fdt.h>
> > #include <linux/dma-mapping.h>
> > #include <linux/dma-contiguous.h>
> > #include <linux/efi.h>
> > #include <linux/swiotlb.h>
> >+#include <linux/kexec.h>
> >
> > #include <asm/boot.h>
> > #include <asm/fixmap.h>
> >@@ -76,6 +78,114 @@ static int __init early_initrd(char *p)
> > early_param("initrd", early_initrd);
> > #endif
> >
> >+#ifdef CONFIG_KEXEC_CORE
> >+static unsigned long long crash_size, crash_base;
> >+static struct property crash_base_prop = {
> >+	.name = "linux,crashkernel-base",
> >+	.length = sizeof(u64),
> >+	.value = &crash_base
> >+};
> >+static struct property crash_size_prop = {
> >+	.name = "linux,crashkernel-size",
> >+	.length = sizeof(u64),
> >+	.value = &crash_size,
> >+};
> >+
> >+static int __init export_crashkernel(void)
> >+{
> >+	struct device_node *node;
> >+	int ret;
> >+
> >+	if (!crashk_res.end)
> >+		return 0;
> >+
> >+	crash_base = cpu_to_be64(crashk_res.start);
> >+	crash_size = cpu_to_be64(crashk_res.end - crashk_res.start + 1);
> >+
> 
> Shouldn't that be the same values as in reserve_crashkernel()?
> IMHO this does not need to be recalculated here.

Right. crashk_res is calculated from crash_base/size.
So I should and will remove those lines.

Thanks,
-Takahiro AKASHI

> Regards,
> Matthias
> 
> >+	/* Add /chosen/linux,crashkernel-* properties */
> >+	node = of_find_node_by_path("/chosen");
> >+	if (!node)
> >+		return -ENOENT;
> >+
> >+	/*
> >+	 * There might be existing crash kernel properties, but we can't
> >+	 * be sure what's in them, so remove them.
> >+	 */
> >+	of_remove_property(node, of_find_property(node,
> >+				"linux,crashkernel-base", NULL));
> >+	of_remove_property(node, of_find_property(node,
> >+				"linux,crashkernel-size", NULL));
> >+
> >+	ret = of_add_property(node, &crash_base_prop);
> >+	if (ret)
> >+		goto ret_err;
> >+
> >+	ret = of_add_property(node, &crash_size_prop);
> >+	if (ret)
> >+		goto ret_err;
> >+
> >+	return 0;
> >+
> >+ret_err:
> >+	pr_warn("Exporting crashkernel region to device tree failed\n");
> >+	return ret;
> >+}
> >+late_initcall(export_crashkernel);
> >+
> >+/*
> >+ * reserve_crashkernel() - reserves memory for crash kernel
> >+ *
> >+ * This function reserves memory area given in "crashkernel=" kernel command
> >+ * line parameter. The memory reserved is used by dump capture kernel when
> >+ * primary kernel is crashing.
> >+ */
> >+static void __init reserve_crashkernel(void)
> >+{
> >+	int ret;
> >+
> >+	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> >+				&crash_size, &crash_base);
> >+	/* no crashkernel= or invalid value specified */
> >+	if (ret || !crash_size)
> >+		return;
> >+
> >+	if (crash_base == 0) {
> >+		/* Current arm64 boot protocol requires 2MB alignment */
> >+		crash_base = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
> >+				crash_size, SZ_2M);
> >+		if (crash_base == 0) {
> >+			pr_warn("Unable to allocate crashkernel (size:%llx)\n",
> >+				crash_size);
> >+			return;
> >+		}
> >+	} else {
> >+		/* User specifies base address explicitly. */
> >+		if (!memblock_is_region_memory(crash_base, crash_size) ||
> >+			memblock_is_region_reserved(crash_base, crash_size)) {
> >+			pr_warn("crashkernel has wrong address or size\n");
> >+			return;
> >+		}
> >+
> >+		if (!IS_ALIGNED(crash_base, SZ_2M)) {
> >+			pr_warn("crashkernel base address is not 2MB aligned\n");
> >+			return;
> >+		}
> >+	}
> >+	memblock_reserve(crash_base, crash_size);
> >+
> >+	pr_info("Reserving %lldMB of memory at %lldMB for crashkernel\n",
> >+		crash_size >> 20, crash_base >> 20);
> >+
> >+	crashk_res.start = crash_base;
> >+	crashk_res.end = crash_base + crash_size - 1;
> >+}
> >+#else
> >+static void __init reserve_crashkernel(void)
> >+{
> >+	;
> >+}
> >+#endif /* CONFIG_KEXEC_CORE */
> >+
> > /*
> >  * Return the maximum physical address for ZONE_DMA (DMA_BIT_MASK(32)). It
> >  * currently assumes that for memory starting above 4G, 32-bit devices will
> >@@ -296,6 +406,9 @@ void __init arm64_memblock_init(void)
> > 		arm64_dma_phys_limit = max_zone_dma_phys();
> > 	else
> > 		arm64_dma_phys_limit = PHYS_MASK + 1;
> >+
> >+	reserve_crashkernel();
> >+
> > 	dma_contiguous_reserve(arm64_dma_phys_limit);
> >
> > 	memblock_allow_resize();
> >
