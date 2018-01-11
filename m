From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 11 Jan 2018 20:38:41 +0900
Subject: [PATCH] arm64: kdump: retain reserved memory regions
In-Reply-To: <5A55F87F.2080501@arm.com>
References: <20180110100943.6082-1-takahiro.akashi@linaro.org>
 <5A55F87F.2080501@arm.com>
Message-ID: <20180111113840.GF18820@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

James,

On Wed, Jan 10, 2018 at 11:26:55AM +0000, James Morse wrote:
> Hi Akashi,
> 
> On 10/01/18 10:09, AKASHI Takahiro wrote:
> > This is a fix against the issue that crash dump kernel may hang up
> > during booting, which can happen on any ACPI-based system with "ACPI
> > Reclaim Memory."
> > 
> > 	<kicking off kdump after panic>
> > 	Bye!
> > 	   (snip...)
> > 	ACPI: Core revision 20170728
> > 	pud=000000002e7d0003, *pmd=000000002e7c0003, *pte=00e8000039710707
> > 	Internal error: Oops: 96000021 [#1] SMP
> > 	Modules linked in:
> > 	CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.0-rc6 #1
> > 	task: ffff000008d05180 task.stack: ffff000008cc0000
> > 	PC is at acpi_ns_lookup+0x25c/0x3c0
> > 	LR is at acpi_ds_load1_begin_op+0xa4/0x294
> > 	   (snip...)
> > 	Process swapper/0 (pid: 0, stack limit = 0xffff000008cc0000)
> > 	Call trace:
> > 	   (snip...)
> > 	[<ffff0000084a6764>] acpi_ns_lookup+0x25c/0x3c0
> > 	[<ffff00000849b4f8>] acpi_ds_load1_begin_op+0xa4/0x294
> > 	[<ffff0000084ad4ac>] acpi_ps_build_named_op+0xc4/0x198
> > 	[<ffff0000084ad6cc>] acpi_ps_create_op+0x14c/0x270
> > 	[<ffff0000084acfa8>] acpi_ps_parse_loop+0x188/0x5c8
> > 	[<ffff0000084ae048>] acpi_ps_parse_aml+0xb0/0x2b8
> > 	[<ffff0000084a8e10>] acpi_ns_one_complete_parse+0x144/0x184
> > 	[<ffff0000084a8e98>] acpi_ns_parse_table+0x48/0x68
> > 	[<ffff0000084a82cc>] acpi_ns_load_table+0x4c/0xdc
> > 	[<ffff0000084b32f8>] acpi_tb_load_namespace+0xe4/0x264
> > 	[<ffff000008baf9b4>] acpi_load_tables+0x48/0xc0
> > 	[<ffff000008badc20>] acpi_early_init+0x9c/0xd0
> > 	[<ffff000008b70d50>] start_kernel+0x3b4/0x43c
> > 	Code: b9008fb9 2a000318 36380054 32190318 (b94002c0)
> > 	---[ end trace c46ed37f9651c58e ]---
> > 	Kernel panic - not syncing: Fatal exception
> > 	Rebooting in 10 seconds..
> > 
> > (diagnosis)
> > * This fault is a data abort, alignment fault (ESR=0x96000021)
> >   during reading out ACPI table.
> > * Initial ACPI tables are normally stored in system ram and marked as
> >   "ACPI Reclaim memory" by the firmware.
> > * After the commit f56ab9a5b73c ("efi/arm: Don't mark ACPI reclaim
> >   memory as MEMBLOCK_NOMAP"), those regions' attribute were changed
> >   removing NOMAP bit and they are instead "memblock-reserved".
> > * When crash dump kernel boots up, it tries to accesses ACPI tables by
> >   ioremap'ing them (through acpi_os_ioremap()).
> > * Since those regions are not included in device tree's
> >   "usable-memory-range" and so not recognized as part of crash dump
> >   kernel's system ram, ioremap() will create a non-cacheable mapping here.
> 
> Ugh, because acpi_os_ioremap() looks at the efi memory map through the prism of
> what we pulled into memblock, which is different during kdump.
> 
> Is an alternative to teach acpi_os_ioremap() to ask
> efi_mem_attributes() directly for the attributes to use?
> (e.g. arch_apei_get_mem_attribute())

I didn't think of this approach.
Do you mean a change like the patch below?
(I'm still debugging this code since the kernel fails to boot.)

Thanks,
-Takahiro AKASHI

> 
> > * ACPI accessor/helper functions are compiled in without unaligned access
> >   support (ACPI_MISALIGNMENT_NOT_SUPPORTED), eventually ending up a fatal
> >   panic when accessing ACPI tables.
> > 
> > With this patch, all the reserved memory regions, as well as NOMAP-
> > attributed ones which are presumably ACPI runtime code and data, are set
> > to be retained in system ram even if they are outside of usable memory
> > range specified by device tree blob. Accordingly, ACPI tables are mapped
> > as cacheable and can be safely accessed without causing unaligned access
> > faults.
> 
> 
> Thanks,
> 
> James
===8<===
diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 32f465a80e4e..6953aaaf2bfa 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -16,6 +16,7 @@
 #include <linux/psci.h>
 
 #include <asm/cputype.h>
+#include <asm/io.h>
 #include <asm/smp_plat.h>
 #include <asm/tlbflush.h>
 
@@ -29,18 +30,13 @@
 
 /* Basic configuration for ACPI */
 #ifdef	CONFIG_ACPI
+pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
+
 /* ACPI table mapping after acpi_permanent_mmap is set */
 static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
 					    acpi_size size)
 {
-	/*
-	 * EFI's reserve_regions() call adds memory with the WB attribute
-	 * to memblock via early_init_dt_add_memory_arch().
-	 */
-	if (!memblock_is_memory(phys))
-		return ioremap(phys, size);
-
-	return ioremap_cache(phys, size);
+	return __ioremap(phys, size, __acpi_get_mem_attribute(phys));
 }
 #define acpi_os_ioremap acpi_os_ioremap
 
@@ -125,7 +121,10 @@ static inline const char *acpi_get_enable_method(int cpu)
  * for compatibility.
  */
 #define acpi_disable_cmcff 1
-pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
+static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
+{
+	return __acpi_get_mem_attribute(addr);
+}
 #endif /* CONFIG_ACPI_APEI */
 
 #ifdef CONFIG_ACPI_NUMA
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index b3162715ed78..43e9d8371f88 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -239,8 +239,7 @@ void __init acpi_boot_table_init(void)
 	}
 }
 
-#ifdef CONFIG_ACPI_APEI
-pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
+pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
 {
 	/*
 	 * According to "Table 8 Map: EFI memory types to AArch64 memory
@@ -261,4 +260,3 @@ pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 		return __pgprot(PROT_NORMAL_NC);
 	return __pgprot(PROT_DEVICE_nGnRnE);
 }
-#endif
