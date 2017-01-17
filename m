From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 17 Jan 2017 17:20:44 +0900
Subject: [PATCH v29 3/9] arm64: kdump: reserve memory for crash dump kernel
In-Reply-To: <20170113113914.GB26804@leverpostej>
References: <20161228043347.27358-1-takahiro.akashi@linaro.org>
 <20161228043605.27470-2-takahiro.akashi@linaro.org>
 <20170112150926.GA12249@leverpostej>
 <20170113081617.GI20972@linaro.org>
 <20170113113914.GB26804@leverpostej>
Message-ID: <20170117082043.GM20972@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 11:39:15AM +0000, Mark Rutland wrote:
> On Fri, Jan 13, 2017 at 05:16:18PM +0900, AKASHI Takahiro wrote:
> > On Thu, Jan 12, 2017 at 03:09:26PM +0000, Mark Rutland wrote:
> > > > +static int __init export_crashkernel(void)
> 
> > > > +	/* Add /chosen/linux,crashkernel-* properties */
> 
> > > > +	of_remove_property(node, of_find_property(node,
> > > > +				"linux,crashkernel-base", NULL));
> > > > +	of_remove_property(node, of_find_property(node,
> > > > +				"linux,crashkernel-size", NULL));
> > > > +
> > > > +	ret = of_add_property(node, &crash_base_prop);
> > > > +	if (ret)
> > > > +		goto ret_err;
> > > > +
> > > > +	ret = of_add_property(node, &crash_size_prop);
> > > > +	if (ret)
> > > > +		goto ret_err;
> 
> > > I very much do not like this.
> > > 
> > > I don't think we should be modifying the DT exposed to userspace in this
> > > manner, in the usual boot path, especially given that the kernel itself
> > > does not appear to be a consumer of this property. I do not think that
> > > it is right to use the DT exposed to userspace as a communication
> > > channel solely between the kernel and userspace.
> > 
> > As you mentioned in your comments against my patch#9, this property
> > originates from PPC implementation.
> > I added it solely from the sympathy for dt-based architectures.
> >
> > > So I think we should drop the above, and for arm64 have userspace
> > > consistently use /proc/iomem (or perhaps a new kexec-specific file) to
> > > determine the region reserved for the crash kernel, if it needs to know
> > > this.
> > 
> > As a matter of fact, my port of kexec-tools doesn't check this property
> > and dropping it won't cause any problem.
> 
> Ok. It sounds like we're both happy for this to go, then.
> 
> While it's unfortunate that architectures differ, I think we have
> legitimate reasons to differ, and it's preferable to do so. We have a
> different set of constraints (e.g. supporting EFI memory maps), and
> following the PPC approach creates longer term issues for us, making it
> harder to do the right thing consistently.
> 
> > > > +/*
> > > > + * reserve_crashkernel() - reserves memory for crash kernel
> > > > + *
> > > > + * This function reserves memory area given in "crashkernel=" kernel command
> > > > + * line parameter. The memory reserved is used by dump capture kernel when
> > > > + * primary kernel is crashing.
> > > > + */
> > > > +static void __init reserve_crashkernel(void)
> 
> > > > +	memblock_reserve(crash_base, crash_size);
> > > 
> > > This will mean that the crash kernel will have a permanent alias in the linear
> > > map which is vulnerable to being clobbered. There could also be issues
> > > with mismatched attributes in future.
> > 
> > Good point, I've never thought of that except making the memblock
> > region "reserved."
> > 
> > > We're probably ok for now, but in future we'll likely want to fix this
> > > up to remove the region (or mark it nomap), and only map it temporarily
> > > when loading things into the region.
> > 
> > Well, I found that the following commit is already in:
> >         commit 9b492cf58077
> >         Author: Xunlei Pang <xlpang@redhat.com>
> >         Date:   Mon May 23 16:24:10 2016 -0700
> > 
> >             kexec: introduce a protection mechanism for the crashkernel
> >             reserved memory
> > 
> > To make best use of this framework, I'd like to re-use set_memory_ro/rx()
> > instead of removing the region from linear mapping. But to do so,
> > we need to
> > * make memblock_isolate_range() global,
> > * allow set_memory_ro/rx() to be applied to regions in linear mapping
> > since set_memory_ro/rx() works only on page-level mappings.
> > 
> > What do you think?
> > (See my tentative solution below.)
> 
> Great! I think it would be better to follow the approach of
> mark_rodata_ro(), rather than opening up set_memory_*(), but otherwise,
> it looks like it should work.

I'm not quite sure what the approach of mark_rodata_ro() means, but
I found that using create_mapping_late() may cause two problems:

1) it fails when PTE_CONT bits mismatch between an old and new mmu entry.
   This can happen, say, if the memory range for crash dump kernel
   starts in the mid of _continuous_ pages.

2) The control code page, of one-page size, is still written out in
   machine_kexec() which is called at a crash, and this means that
   the range must be writable even after kexec_load(), but
   create_mapping_late() does not handle a case of changing attributes
   for a single page which is in _section_ mapping.
   We cannot make single-page mapping for the control page since the address
   of that page is not determined at the boot time.

As for (1), we need to call memblock_isolate_range() to make the region
an independent one.

> Either way, this still leaves us with an RO alias on crashed cores (and
> potential cache attribute mismatches in future). Do we need to read from
> the region later,

I believe not, but the region must be _writable_ as I mentioned in (2) above.
To avoid this issue, we have to move copying the control code page
to machine_kexec_prepare() which is called in kexec_load() and so
the region is writable anyway then.
I want Geoff to affirm that this change is safe.

(See my second solution below.)

> or could we unmap it entirely?

given the change above, I think we can.
Is there any code to re-use especially for unmapping?

Thanks,
-Takahiro AKASHI

> Thanks,
> Mark.
===8<===
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index c0fc3d458195..80a52e9aaf73 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -26,8 +26,6 @@
 extern const unsigned char arm64_relocate_new_kernel[];
 extern const unsigned long arm64_relocate_new_kernel_size;
 
-static unsigned long kimage_start;
-
 /**
  * kexec_image_info - For debugging output.
  */
@@ -68,7 +66,7 @@ void machine_kexec_cleanup(struct kimage *kimage)
  */
 int machine_kexec_prepare(struct kimage *kimage)
 {
-	kimage_start = kimage->start;
+	void *reboot_code_buffer;
 
 	kexec_image_info(kimage);
 
@@ -77,6 +75,21 @@ int machine_kexec_prepare(struct kimage *kimage)
 		return -EBUSY;
 	}
 
+	reboot_code_buffer =
+			phys_to_virt(page_to_phys(kimage->control_code_page));
+
+	/*
+	 * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
+	 * after the kernel is shut down.
+	 */
+	memcpy(reboot_code_buffer, arm64_relocate_new_kernel,
+		arm64_relocate_new_kernel_size);
+
+	/* Flush the reboot_code_buffer in preparation for its execution. */
+	__flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
+	flush_icache_range((uintptr_t)reboot_code_buffer,
+		arm64_relocate_new_kernel_size);
+
 	return 0;
 }
 
@@ -147,7 +160,6 @@ static void kexec_segment_flush(const struct kimage *kimage)
 void machine_kexec(struct kimage *kimage)
 {
 	phys_addr_t reboot_code_buffer_phys;
-	void *reboot_code_buffer;
 
 	/*
 	 * New cpus may have become stuck_in_kernel after we loaded the image.
@@ -156,7 +168,6 @@ void machine_kexec(struct kimage *kimage)
 			!WARN_ON(kimage == kexec_crash_image));
 
 	reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
-	reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
 
 	kexec_image_info(kimage);
 
@@ -164,26 +175,12 @@ void machine_kexec(struct kimage *kimage)
 		kimage->control_code_page);
 	pr_debug("%s:%d: reboot_code_buffer_phys:  %pa\n", __func__, __LINE__,
 		&reboot_code_buffer_phys);
-	pr_debug("%s:%d: reboot_code_buffer:       %p\n", __func__, __LINE__,
-		reboot_code_buffer);
 	pr_debug("%s:%d: relocate_new_kernel:      %p\n", __func__, __LINE__,
 		arm64_relocate_new_kernel);
 	pr_debug("%s:%d: relocate_new_kernel_size: 0x%lx(%lu) bytes\n",
 		__func__, __LINE__, arm64_relocate_new_kernel_size,
 		arm64_relocate_new_kernel_size);
 
-	/*
-	 * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
-	 * after the kernel is shut down.
-	 */
-	memcpy(reboot_code_buffer, arm64_relocate_new_kernel,
-		arm64_relocate_new_kernel_size);
-
-	/* Flush the reboot_code_buffer in preparation for its execution. */
-	__flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
-	flush_icache_range((uintptr_t)reboot_code_buffer,
-		arm64_relocate_new_kernel_size);
-
 	/* Flush the kimage list and its buffers. */
 	kexec_list_flush(kimage);
 
@@ -206,7 +203,7 @@ void machine_kexec(struct kimage *kimage)
 	 */
 
 	cpu_soft_restart(kimage != kexec_crash_image,
-		reboot_code_buffer_phys, kimage->head, kimage_start, 0);
+		reboot_code_buffer_phys, kimage->head, kimage->start, 0);
 
 	BUG(); /* Should never get here. */
 }
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 569ec3325bc8..e4cc170edc0c 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -90,6 +90,7 @@ early_param("initrd", early_initrd);
 static void __init reserve_crashkernel(void)
 {
 	unsigned long long crash_size, crash_base;
+	int start_rgn, end_rgn;
 	int ret;
 
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
@@ -120,6 +121,8 @@ static void __init reserve_crashkernel(void)
 			return;
 		}
 	}
+	memblock_isolate_range(&memblock.memory, crash_base, crash_size,
+			&start_rgn, &end_rgn);
 	memblock_reserve(crash_base, crash_size);
 
 	pr_info("Reserving %lldMB of memory at %lldMB for crashkernel\n",
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 17243e43184e..b7c75845407a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -22,6 +22,8 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/kexec.h>
 #include <linux/libfdt.h>
 #include <linux/mman.h>
 #include <linux/nodemask.h>
@@ -817,3 +819,27 @@ int pmd_clear_huge(pmd_t *pmd)
 	pmd_clear(pmd);
 	return 1;
 }
+
+#ifdef CONFIG_KEXEC_CORE
+void arch_kexec_protect_crashkres(void)
+{
+	flush_tlb_all();
+
+	create_mapping_late(crashk_res.start, __phys_to_virt(crashk_res.start),
+			    resource_size(&crashk_res), PAGE_KERNEL_RO);
+
+	/* flush the TLBs after updating live kernel mappings */
+	flush_tlb_all();
+}
+
+void arch_kexec_unprotect_crashkres(void)
+{
+	flush_tlb_all();
+
+	create_mapping_late(crashk_res.start, __phys_to_virt(crashk_res.start),
+			    resource_size(&crashk_res), PAGE_KERNEL);
+
+	/* flush the TLBs after updating live kernel mappings */
+	flush_tlb_all();
+}
+#endif
===>8===
