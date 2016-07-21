From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 21 Jul 2016 09:57:58 +0900
Subject: [PATCH v22 2/8] arm64: limit memory regions based on DT
 property, usable-memory-range
In-Reply-To: <578D1A31.5080509@arm.com>
References: <20160712050514.22307-1-takahiro.akashi@linaro.org>
 <20160712050514.22307-3-takahiro.akashi@linaro.org>
 <578D1A31.5080509@arm.com>
Message-ID: <20160721005756.GN20774@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

James,

On Mon, Jul 18, 2016 at 07:04:33PM +0100, James Morse wrote:
> Hi!
> 
> (CC: Dennis Chen)
> 
> On 12/07/16 06:05, AKASHI Takahiro wrote:
> > Crash dump kernel will be run with a limited range of memory as System
> > RAM.
> > 
> > On arm64, we will use a device-tree property under /chosen,
> >    linux,usable-memory-range = <BASE SIZE>
> > in order for primary kernel either on uefi or non-uefi (device tree only)
> > system to hand over the information about usable memory region to crash
> > dump kernel. This property will supercede entries in uefi memory map table
> > and "memory" nodes in a device tree.
> 
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 51b1302..d8b296f 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -300,10 +300,48 @@ static int __init early_mem(char *p)
> >  }
> >  early_param("mem", early_mem);
> >  
> > +static int __init early_init_dt_scan_usablemem(unsigned long node,
> > +		const char *uname, int depth, void *data)
> > +{
> > +	struct memblock_region *usablemem = (struct memblock_region *)data;
> > +	const __be32 *reg;
> > +	int len;
> > +
> > +	usablemem->size = 0;
> > +
> > +	if (depth != 1 || strcmp(uname, "chosen") != 0)
> > +		return 0;
> > +
> > +	reg = of_get_flat_dt_prop(node, "linux,usable-memory-range", &len);
> > +	if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
> > +		return 1;
> > +
> > +	usablemem->base = dt_mem_next_cell(dt_root_addr_cells, &reg);
> > +	usablemem->size = dt_mem_next_cell(dt_root_size_cells, &reg);
> > +
> > +	return 1;
> > +}
> > +
> > +static void __init fdt_enforce_memory_region(void)
> > +{
> > +	struct memblock_region reg;
> > +
> > +	of_scan_flat_dt(early_init_dt_scan_usablemem, &reg);
> > +
> > +	if (reg.size) {
> > +		memblock_remove(0, PAGE_ALIGN(reg.base));
> > +		memblock_remove(round_down(reg.base + reg.size, PAGE_SIZE),
> > +				ULLONG_MAX);
> 
> I think this is a new way to trip the problem Dennis Chen has been working on
> [0]. If I kdump with --reuse-cmdline on a kernel booted with 'acpi=on', I get
> the panic below [1]...
> 
> It looks like Dennis's fix involves changes in mm/memblock.c, maybe they can be
> extended to support a range instead of just a limit?

Could you please apply the diff attached below and confirm that
kdump works in your environment?
I can't test it by myself since my hikey board seems to be broken now.

Thanks,
-Takahiro AKASHI

> (It looks like x86 explicitly adds the acpi regions to the crash-kernels memory
> map in crash_setup_memmap_entries()).
> 
> 
> 
> Is it possible for the kernel text to be outside this range? (a bug in
> kexec-tools, or another user of the DT property) If we haven't already failed in
> this case, it may be worth printing a warning, or refusing to
> restrict-memory/expose-vmcore.
> 
> 
> 
> Thanks,
> 
> James
> 
> 
> [0] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/443356.html
> [1]
> [    0.000000] efi: Getting EFI parameters from FDT:
> [    0.000000] efi: EFI v2.50 by ARM Juno EFI Nov 24 2015 12:36:35
> [    0.000000] efi:  ACPI=0xf95b0000  ACPI 2.0=0xf95b0014  PROP=0xfe8db4d8
> [    0.000000] Reserving 1KB of memory at 0x9fffff000 for elfcorehdr
> [    0.000000] cma: Reserved 16 MiB at 0x00000009fec00000
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: RSDP 0x00000000F95B0014 000024 (v02 ARMLTD)
> [    0.000000] ACPI: XSDT 0x00000000F95A00E8 00004C (v01 ARMLTD ARM-JUNO 2014072
> 7      01000013)
> [    0.000000] ACPI: FACP 0x00000000F9500000 00010C (v05 ARMLTD ARM-JUNO 2014072
> 7 ARM  00000099)
> [    0.000000] ACPI: DSDT 0x00000000F94C0000 000396 (v01 ARMLTD ARM-JUNO 2014072
> 7 INTL 20150619)
> [    0.000000] ACPI: GTDT 0x00000000F94F0000 000060 (v02 ARMLTD ARM-JUNO 2014072
> 7 ARM  00000099)
> [    0.000000] ACPI: APIC 0x00000000F94E0000 000224 (v03 ARMLTD ARM-JUNO 2014072
> 7 ARM  00000099)
> [    0.000000] ACPI: SSDT 0x00000000F94D0000 0001E3 (v01 ARMLTD ARM-JUNO 2014072
> 7 INTL 20150619)
> [    0.000000] ACPI: MCFG 0x00000000F94B0000 00003C (v01 ARMLTD ARM-JUNO 2014072
> 7 ARM  00000099)
> ...
> [    0.737577] Serial: AMBA PL011 UART driver
> [    0.786086] HugeTLB registered 2 MB page size, pre-allocated 0 pages
> [    0.794203] ACPI: Added _OSI(Module Device)
> [    0.798659] ACPI: Added _OSI(Processor Device)
> [    0.803190] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.807973] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.813653] Unable to handle kernel paging request at virtual address ffff000
> 00804e027
> [    0.821704] pgd = ffff000008cce000
> [    0.825155] [ffff00000804e027] *pgd=00000009ffffd003, *pud=00000009ffffc003,
> *pmd=00000009ffffb003, *pte=00e80000f94c0707
> [    0.836319] Internal error: Oops: 96000021 [#1] PREEMPT SMP
> [    0.841972] Modules linked in:
> [    0.845073] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G S              4.7.0-rc4
> + #4569
> [    0.852927] Hardware name: ARM Juno development board (r1) (DT)
> [    0.858936] task: ffff80003d898000 ti: ffff80003d894000 task.ti: ffff80003d89
> 4000
> [    0.866537] PC is at acpi_ns_lookup+0x23c/0x378
> [    0.871131] LR is at acpi_ds_load1_begin_op+0x88/0x260
> [    0.876340] pc : [<ffff0000084061a4>] lr : [<ffff0000083fc08c>] pstate: 60000
> 045
> [    0.883846] sp : ffff80003d8979b0
> [    0.887206] x29: ffff80003d8979b0 x28: 0000000000000000
> [    0.892596] x27: 000000000000001b x26: ffff000008a80a07
> [    0.897986] x25: ffff80003d897a48 x24: 0000000000000001
> [    0.903377] x23: 0000000000000001 x22: ffff00000804e027
> [    0.908769] x21: 000000000000001b x20: 0000000000000001
> [    0.914158] x19: 0000000000000000 x18: ffff00000804efff
> [    0.919547] x17: 00000000000038ff x16: 0000000000000002
> [    0.924937] x15: ffff00000804efff x14: 0000008000000000
> [    0.930326] x13: ffff000008c942b2 x12: ffff00000804efff
> [    0.935717] x11: ffff000008bf0000 x10: 00000000ffffff76
> [    0.941107] x9 : 0000000000000000 x8 : ffff000008cb6000
> [    0.946498] x7 : 0000000000000000 x6 : ffff80003d897aa8
> [    0.951891] x5 : ffff80003d028400 x4 : 0000000000000001
> [    0.957281] x3 : 0000000000000003 x2 : ffff000008cb6090
> [    0.962673] x1 : 000000000000005f x0 : 0000000000000000
> [    0.968063]
> [    0.969569] Process swapper/0 (pid: 1, stack limit = 0xffff80003d894020)
> [    1.387661] Call trace:
> ...
> [    1.473172] [<ffff0000084061a4>] acpi_ns_lookup+0x23c/0x378
> [    1.478832] [<ffff0000083fc08c>] acpi_ds_load1_begin_op+0x88/0x260
> [    1.485105] [<ffff00000840c0e8>] acpi_ps_build_named_op+0xa8/0x170
> [    1.491378] [<ffff00000840c2e0>] acpi_ps_create_op+0x130/0x230
> [    1.497299] [<ffff00000840bc28>] acpi_ps_parse_loop+0x168/0x580
> [    1.503302] [<ffff00000840cb44>] acpi_ps_parse_aml+0xa0/0x278
> [    1.509135] [<ffff0000084081d0>] acpi_ns_one_complete_parse+0x128/0x150
> [    1.515852] [<ffff00000840821c>] acpi_ns_parse_table+0x24/0x44
> [    1.521775] [<ffff0000084079e8>] acpi_ns_load_table+0x54/0xdc
> [    1.527612] [<ffff000008411038>] acpi_tb_load_namespace+0xd0/0x230
> [    1.533887] [<ffff000008b2695c>] acpi_load_tables+0x3c/0xa8
> [    1.539542] [<ffff000008b25974>] acpi_init+0x88/0x2b0
> [    1.544670] [<ffff000008081a08>] do_one_initcall+0x38/0x128
> [    1.550325] [<ffff000008b00cc0>] kernel_init_freeable+0x14c/0x1f0
> [    1.556517] [<ffff0000087d2088>] kernel_init+0x10/0x100
> [    1.561823] [<ffff000008084e10>] ret_from_fork+0x10/0x40
> [    1.567216] Code: b9008fbb 2a000318 36380054 32190318 (b94002c0)
> [    1.573451] ---[ end trace dec6cecdcba673b7 ]---
> [    1.578158] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00
> 00000b
> [    1.578158]
> [    1.587428] SMP: stopping secondary CPUs
> [    1.591411] ---[ end Kernel panic - not syncing: Attempted to kill init! exit
> code=0x0000000b
> [    0.969225] Process swapper/0 (pid: 1, stack limit = 0xffff80003d894020)
> 
> 
===8<===
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 4bd55cd..c027275 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -380,11 +380,8 @@ static void __init fdt_enforce_memory_region(void)
 
 	of_scan_flat_dt(early_init_dt_scan_usablemem, &reg);
 
-	if (reg.size) {
-		memblock_remove(0, PAGE_ALIGN(reg.base));
-		memblock_remove(round_down(reg.base + reg.size, PAGE_SIZE),
-				ULLONG_MAX);
-	}
+	if (reg.size)
+		memblock_cap_memory_range(reg.base, reg.size);
 }
 
 void __init arm64_memblock_init(void)
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 3106ac1..9ab17a9 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -333,6 +333,7 @@ phys_addr_t memblock_mem_size(unsigned long limit_pfn);
 phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
 void memblock_enforce_memory_limit(phys_addr_t memory_limit);
+void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
 bool memblock_is_memory(phys_addr_t addr);
 int memblock_is_map_memory(phys_addr_t addr);
 int memblock_is_region_memory(phys_addr_t base, phys_addr_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index ac12489..30badf1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1486,6 +1486,34 @@ void __init memblock_enforce_memory_limit(phys_addr_t limit)
 			      (phys_addr_t)ULLONG_MAX);
 }
 
+void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
+{
+	int start_rgn, end_rgn;
+	int i, ret;
+
+	if (!size)
+		return;
+
+	ret = memblock_isolate_range(&memblock.memory, base, size,
+						&start_rgn, &end_rgn);
+	if (ret)
+		return;
+
+	/* remove all the MAP regions */
+	for (i = memblock.memory.cnt - 1; i >= end_rgn; i--)
+		if (!memblock_is_nomap(&memblock.memory.regions[i]))
+			memblock_remove_region(&memblock.memory, i);
+
+	for (i = start_rgn - 1; i >= 0; i--)
+		if (!memblock_is_nomap(&memblock.memory.regions[i]))
+			memblock_remove_region(&memblock.memory, i);
+
+	/* truncate the reserved regions */
+	memblock_remove_range(&memblock.reserved, 0, base);
+	memblock_remove_range(&memblock.reserved,
+			base + size, (phys_addr_t)ULLONG_MAX);
+}
+
 static int __init_memblock memblock_search(struct memblock_type *type, phys_addr_t addr)
 {
 	unsigned int left = 0, right = type->cnt;
