From: bhe@redhat.com (Baoquan He)
Date: Mon, 11 May 2015 15:54:47 +0800
Subject: [v2 1/5] arm64: kdump: reserve memory for crash dump kernel
In-Reply-To: <55505C91.8070503@linaro.org>
References: <1429861989-8417-1-git-send-email-takahiro.akashi@linaro.org>
 <1429861989-8417-2-git-send-email-takahiro.akashi@linaro.org>
 <20150428091935.GJ15033@dhcp-16-116.nay.redhat.com>
 <55505C91.8070503@linaro.org>
Message-ID: <20150511075447.GA4290@dhcp-128-28.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/15 at 04:38pm, AKASHI Takahiro wrote:
> Hi Baoquan,
> 
> On 04/28/2015 06:19 PM, Baoquan He wrote:
> >>+#ifdef CONFIG_CRASH_DUMP
> >>+/*
> >>+ * reserve_elfcorehdr() - reserves memory for elf core header
> >>+ *
> >>+ * This function reserves memory area given in "elfcorehdr=" kernel command
> >>+ * line parameter. The memory reserved is used by a dump capture kernel to
> >>+ * identify the memory used by primary kernel.
> >>+ */
> >
> >Hi AKASHI,
> >
> >May I know why elfcorehdr need be reserved separately but not locate a
> >memory region in crashkernel reserved region like all other ARCHs? Is
> >there any special reason?
> 
> I don't get your point, but arm as well as arm64 locates elfcorehdr
> in a crash kernel's memory region.
> See kexec/arch/arm{,64}/crashdump-arm{,64}.c in kexec-tools.
> 
> And this region is reserved at boot time *on crash kernel* because we don't want
> to corrupt it accidentally.
> (After Mark's comment, we might better remove the mmu mapping for this region, too.)


Sorry, I don't make myself clear.

In this patch you reserve a separate memory region in 1st kernel to
store elfcorehdr. I am wondering why you don't call add_buffer in
kexec-tools directly. Like this you can get a region from reserved
crashkernel region. Then you don't need reserve_elfcorehdr() to reserve
memory for elfcorehdr specifically. Like other ARCHs do only one memory
region is reserved in 1st kernel, that's crashkernel region.

Thanks
Baoquan
> 
> 
> Make sense?
> 
> -Takahiro AKASHI
> 
> >Thanks
> >Baoquan
> >
> >>+static void __init reserve_elfcorehdr(void)
> >>+{
> >>+	if (!elfcorehdr_size)
> >>+		return;
> >>+
> >>+	if (memblock_is_region_reserved(elfcorehdr_addr, elfcorehdr_size)) {
> >>+		pr_warn("elfcorehdr reservation failed - memory is in use (0x%llx)\n",
> >>+			elfcorehdr_addr);
> >>+		return;
> >>+	}
> >>+
> >>+	if (memblock_reserve(elfcorehdr_addr, elfcorehdr_size)) {
> >>+		pr_warn("elfcorehdr reservation failed - out of memory\n");
> >>+		return;
> >>+	}
> >>+
> >>+	pr_info("Reserving %lldKB of memory at %lldMB for elfcorehdr\n",
> >>+		elfcorehdr_size >> 10, elfcorehdr_addr >> 20);
> >>+}
> >>+#endif /* CONFIG_CRASH_DUMP */
> >>  /*
> >>   * Return the maximum physical address for ZONE_DMA (DMA_BIT_MASK(32)). It
> >>   * currently assumes that for memory starting above 4G, 32-bit devices will
> >>@@ -170,6 +247,13 @@ void __init arm64_memblock_init(void)
> >>  		memblock_reserve(__virt_to_phys(initrd_start), initrd_end - initrd_start);
> >>  #endif
> >>
> >>+#ifdef CONFIG_KEXEC
> >>+	reserve_crashkernel(memory_limit);
> >>+#endif
> >>+#ifdef CONFIG_CRASH_DUMP
> >>+	reserve_elfcorehdr();
> >>+#endif
> >>+
> >>  	early_init_fdt_scan_reserved_mem();
> >>
> >>  	/* 4GB maximum for 32-bit only capable devices */
> >>--
> >>1.7.9.5
> >>
> >>--
> >>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >>the body of a message to majordomo at vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>Please read the FAQ at  http://www.tux.org/lkml/
