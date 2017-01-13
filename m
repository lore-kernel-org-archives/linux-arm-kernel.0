From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 13 Jan 2017 17:16:18 +0900
Subject: [PATCH v29 3/9] arm64: kdump: reserve memory for crash dump kernel
In-Reply-To: <20170112150926.GA12249@leverpostej>
References: <20161228043347.27358-1-takahiro.akashi@linaro.org>
 <20161228043605.27470-2-takahiro.akashi@linaro.org>
 <20170112150926.GA12249@leverpostej>
Message-ID: <20170113081617.GI20972@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, Jan 12, 2017 at 03:09:26PM +0000, Mark Rutland wrote:
> Hi,
> 
> As a general note, I must apologise for my minimial review of the series
> until this point. Judging by the way the DT parts are organised. I'm
> very concerned with the way the DT parts are organised, and clearly I
> did not communicate my concerns and suggestions effectively in prior
> rounds of review.
> 
> On Wed, Dec 28, 2016 at 01:36:00PM +0900, AKASHI Takahiro wrote:
> > "crashkernel=" kernel parameter specifies the size (and optionally
> > the start address) of the system ram used by crash dump kernel.
> > reserve_crashkernel() will allocate and reserve the memory at the startup
> > of primary kernel.
> > 
> > This memory range will be exported to userspace via:
> > 	- an entry named "Crash kernel" in /proc/iomem, and
> > 	- "linux,crashkernel-base" and "linux,crashkernel-size" under
> > 	  /sys/firmware/devicetree/base/chosen
> 
> > +#ifdef CONFIG_KEXEC_CORE
> > +static unsigned long long crash_size, crash_base;
> > +static struct property crash_base_prop = {
> > +	.name = "linux,crashkernel-base",
> > +	.length = sizeof(u64),
> > +	.value = &crash_base
> > +};
> > +static struct property crash_size_prop = {
> > +	.name = "linux,crashkernel-size",
> > +	.length = sizeof(u64),
> > +	.value = &crash_size,
> > +};
> > +
> > +static int __init export_crashkernel(void)
> > +{
> > +	struct device_node *node;
> > +	int ret;
> > +
> > +	if (!crash_size)
> > +		return 0;
> > +
> > +	/* Add /chosen/linux,crashkernel-* properties */
> > +	node = of_find_node_by_path("/chosen");
> > +	if (!node)
> > +		return -ENOENT;
> > +
> > +	/*
> > +	 * There might be existing crash kernel properties, but we can't
> > +	 * be sure what's in them, so remove them.
> > +	 */
> > +	of_remove_property(node, of_find_property(node,
> > +				"linux,crashkernel-base", NULL));
> > +	of_remove_property(node, of_find_property(node,
> > +				"linux,crashkernel-size", NULL));
> > +
> > +	ret = of_add_property(node, &crash_base_prop);
> > +	if (ret)
> > +		goto ret_err;
> > +
> > +	ret = of_add_property(node, &crash_size_prop);
> > +	if (ret)
> > +		goto ret_err;
> > +
> > +	return 0;
> > +
> > +ret_err:
> > +	pr_warn("Exporting crashkernel region to device tree failed\n");
> > +	return ret;
> > +}
> > +late_initcall(export_crashkernel);
> 
> I very much do not like this.
> 
> I don't think we should be modifying the DT exposed to userspace in this
> manner, in the usual boot path, especially given that the kernel itself
> does not appear to be a consumer of this property. I do not think that
> it is right to use the DT exposed to userspace as a communication
> channel solely between the kernel and userspace.

As you mentioned in your comments against my patch#9, this property
originates from PPC implementation.
I added it solely from the sympathy for dt-based architectures.

> So I think we should drop the above, and for arm64 have userspace
> consistently use /proc/iomem (or perhaps a new kexec-specific file) to
> determine the region reserved for the crash kernel, if it needs to know
> this.

As a matter of fact, my port of kexec-tools doesn't check this property
and dropping it won't cause any problem.

> I'll have further comments on this front in the binding patch.
> 
> > +/*
> > + * reserve_crashkernel() - reserves memory for crash kernel
> > + *
> > + * This function reserves memory area given in "crashkernel=" kernel command
> > + * line parameter. The memory reserved is used by dump capture kernel when
> > + * primary kernel is crashing.
> > + */
> > +static void __init reserve_crashkernel(void)
> > +{
> > +	int ret;
> > +
> > +	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> > +				&crash_size, &crash_base);
> > +	/* no crashkernel= or invalid value specified */
> > +	if (ret || !crash_size)
> > +		return;
> > +
> > +	if (crash_base == 0) {
> > +		/* Current arm64 boot protocol requires 2MB alignment */
> > +		crash_base = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
> > +				crash_size, SZ_2M);
> > +		if (crash_base == 0) {
> > +			pr_warn("Unable to allocate crashkernel (size:%llx)\n",
> > +				crash_size);
> > +			return;
> > +		}
> > +	} else {
> > +		/* User specifies base address explicitly. */
> > +		if (!memblock_is_region_memory(crash_base, crash_size) ||
> > +			memblock_is_region_reserved(crash_base, crash_size)) {
> > +			pr_warn("crashkernel has wrong address or size\n");
> > +			return;
> > +		}
> > +
> > +		if (!IS_ALIGNED(crash_base, SZ_2M)) {
> > +			pr_warn("crashkernel base address is not 2MB aligned\n");
> > +			return;
> > +		}
> > +	}
> > +	memblock_reserve(crash_base, crash_size);
> 
> This will mean that the crash kernel will have a permanent alias in the linear
> map which is vulnerable to being clobbered. There could also be issues
> with mismatched attributes in future.

Good point, I've never thought of that except making the memblock
region "reserved."

> We're probably ok for now, but in future we'll likely want to fix this
> up to remove the region (or mark it nomap), and only map it temporarily
> when loading things into the region.

Well, I found that the following commit is already in:
        commit 9b492cf58077
        Author: Xunlei Pang <xlpang@redhat.com>
        Date:   Mon May 23 16:24:10 2016 -0700

            kexec: introduce a protection mechanism for the crashkernel
            reserved memory

To make best use of this framework, I'd like to re-use set_memory_ro/rx()
instead of removing the region from linear mapping. But to do so,
we need to
* make memblock_isolate_range() global,
* allow set_memory_ro/rx() to be applied to regions in linear mapping
since set_memory_ro/rx() works only on page-level mappings.

What do you think?
(See my tentative solution below.)

> > +
> > +	pr_info("Reserving %lldMB of memory at %lldMB for crashkernel\n",
> > +		crash_size >> 20, crash_base >> 20);
> > +
> > +	crashk_res.start = crash_base;
> > +	crashk_res.end = crash_base + crash_size - 1;
> > +}
> > +#else
> > +static void __init reserve_crashkernel(void)
> > +{
> > +	;
> 
> Nit: the ';' line can go.

OK

Thanks,
-Takahiro AKASHI

> > +}
> > +#endif /* CONFIG_KEXEC_CORE */
> > +
> >  /*
> >   * Return the maximum physical address for ZONE_DMA (DMA_BIT_MASK(32)). It
> >   * currently assumes that for memory starting above 4G, 32-bit devices will
> > @@ -331,6 +438,9 @@ void __init arm64_memblock_init(void)
> >  		arm64_dma_phys_limit = max_zone_dma_phys();
> >  	else
> >  		arm64_dma_phys_limit = PHYS_MASK + 1;
> > +
> > +	reserve_crashkernel();
> > +
> >  	dma_contiguous_reserve(arm64_dma_phys_limit);
> >  
> >  	memblock_allow_resize();
> > -- 
> > 2.11.0
> 
> Other than my comments regarding the DT usage above, this looks fine to
> me.
> 
> Thanks,
> Mark.

===8<===
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index c0fc3d458195..bb21c0473b8e 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -211,6 +211,44 @@ void machine_kexec(struct kimage *kimage)
 	BUG(); /* Should never get here. */
 }
 
+static int kexec_mark_range(unsigned long start, unsigned long end,
+							bool protect)
+{
+	unsigned int nr_pages;
+
+	if (!end || start >= end)
+		return 0;
+
+	nr_pages = (end >> PAGE_SHIFT) - (start >> PAGE_SHIFT) + 1;
+
+	if (protect)
+		return set_memory_ro(__phys_to_virt(start), nr_pages);
+	else
+		return set_memory_rw(__phys_to_virt(start), nr_pages);
+}
+
+static void kexec_mark_crashkres(bool protect)
+{
+	unsigned long control;
+
+	/* Don't touch the control code page used in crash_kexec().*/
+	control = page_to_phys(kexec_crash_image->control_code_page);
+	kexec_mark_range(crashk_res.start, control - 1, protect);
+
+	control += KEXEC_CONTROL_PAGE_SIZE;
+	kexec_mark_range(control, crashk_res.end, protect);
+}
+
+void arch_kexec_protect_crashkres(void)
+{
+	kexec_mark_crashkres(true);
+}
+
+void arch_kexec_unprotect_crashkres(void)
+{
+	kexec_mark_crashkres(false);
+}
+
 static void machine_kexec_mask_interrupts(void)
 {
 	unsigned int i;
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 569ec3325bc8..764ec89c4f76 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -90,6 +90,7 @@ early_param("initrd", early_initrd);
 static void __init reserve_crashkernel(void)
 {
 	unsigned long long crash_size, crash_base;
+	int start_rgn, end_rgn;
 	int ret;
 
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
@@ -121,6 +122,9 @@ static void __init reserve_crashkernel(void)
 		}
 	}
 	memblock_reserve(crash_base, crash_size);
+	memblock_isolate_range(&memblock.memory, crash_base, crash_size,
+			&start_rgn, &end_rgn);
+
 
 	pr_info("Reserving %lldMB of memory at %lldMB for crashkernel\n",
 		crash_size >> 20, crash_base >> 20);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 17243e43184e..0f60f19c287b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/kexec.h>
 #include <linux/libfdt.h>
 #include <linux/mman.h>
 #include <linux/nodemask.h>
@@ -362,6 +363,17 @@ static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end
 	unsigned long kernel_start = __pa(_text);
 	unsigned long kernel_end = __pa(__init_begin);
 
+#ifdef CONFIG_KEXEC_CORE
+	if (crashk_res.end && start >= crashk_res.start &&
+			end <= (crashk_res.end + 1)) {
+		__create_pgd_mapping(pgd, start, __phys_to_virt(start),
+				     end - start, PAGE_KERNEL,
+				     early_pgtable_alloc,
+				     true);
+		return;
+	}
+#endif
+
 	/*
 	 * Take care not to create a writable alias for the
 	 * read-only text and rodata sections of the kernel image.
===>8===
