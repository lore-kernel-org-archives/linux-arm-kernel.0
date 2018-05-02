From: james.morse@arm.com (James Morse)
Date: Wed, 2 May 2018 11:35:04 +0100
Subject: [PATCH] arm64: export memblock_reserve()d regions via /proc/iomem
In-Reply-To: <20180425132250.9397-1-james.morse@arm.com>
References: <20180425132250.9397-1-james.morse@arm.com>
Message-ID: <2708a0b0-72c7-b518-cced-a87b8a94ab79@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

On 25/04/18 14:22, James Morse wrote:
> There has been some confusion around what is necessary to prevent kexec
> overwriting important memory regions. memblock: reserve, or nomap?
> Only memblock nomap regions are reported via /proc/iomem, kexec's
> user-space doesn't know about memblock_reserve()d regions.
> 
> Until commit f56ab9a5b73ca ("efi/arm: Don't mark ACPI reclaim memory
> as MEMBLOCK_NOMAP") the ACPI tables were nomap, now they are reserved
> and thus possible for kexec to overwrite with the new kernel or initrd.
> But this was always broken, as the UEFI memory map is also reserved
> and not marked as nomap.
> 
> It turns out that while kexec-tools will pick up reserved sections in
> iomem that look like:
> | 80000000-dfffffff : System RAM
> |   81000000-8158ffff : reserved
> 
> The reserved section is ignored by its 'locate_hole()' code. To fix
> this, we need to describe memblock_reserved() and nomap regions as
> 'reserved' at the top level:
> | 80000000-80ffffff : System RAM
> | 81000000-8158ffff : reserved
> | 81590000-dfffffff : System RAM
> 
> To complicate matters, our existing named sections are described as
> being part of 'System RAM', but they are also memblock_reserve()d.
> We need to keep this in-case something is depending on it. To do this
> involves walking memblock multiple times:
> 
> First add the 'System RAM' sections that are memory and not-reserved.
> These may be smaller than a page if part of the page is reserved. In
> this case we want to describe the page as reserved, so we round these
> regions down to the smallest page-size region, which may be empty.
> (We round-up the memblock_reserved() regions to fill in the gaps).
> 
> The boundaries for kernel_data are changed because paging_init() punches
> holes in the _sdata -> _edata region, and this code can't add a named
> region that crosses memblock_reserve()d<->normal-memory regions. The
> new helpers will catch any more overlapping regions that occur.
> 
> Lastly, we add the memblock_reserved() regions using
> reserve_region_with_split(), which will fill in the gaps between the
> existing named regions. (e.g. the regions occupied by the __init code).
> This call uses the slab allocator, so has to run from an initcall.

Re-reading Akashi's description of how kdump generates the ELF headers for
/proc/vmcore, this change might break kdump, as now the memblock_reserved()
regions may be missing from /proc/vmcore. (I'll test that).

Unless there is a 'name' for a region that kexec-tools interprets as "don't
overwrite this, but do include it in the ELF header", then we're stuck. We can't
fix kexec without breaking kdump, we have to change user-space.

Of the two, missing data from kdump vmcore would be preferable to failed-to-boot
kexec. If we have to change user-space, I'd like to make use of the kernels
ability to generate the ELF header itself, (e.g. kexec_file_load()).


> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 30ad2f085d1f..e82c0d5c70f8 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -202,45 +202,135 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)

>  static void __init request_standard_resources(void)
>  {

[...]

> +	/*
> +	 * We can't allocate memory while walking free memory, count the number
> +	 * of struct resource's we will need. Round start/end to the smallest
> +	 * page-size region as we round the reserved regions up.
> +	 */
> +	for_each_free_mem_range(i, NUMA_NO_NODE, 0, &start, &end, NULL) {

Nit: That 0 should be MEMBLOCK_NONE



Thanks,

James
