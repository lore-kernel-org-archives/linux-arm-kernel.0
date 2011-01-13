From: dima@android.com (Dima Zavin)
Date: Wed, 12 Jan 2011 16:10:24 -0800
Subject: [PATCH] ARM: use memblock memory regions for "System RAM" I/O
	resources
In-Reply-To: <1294877317-25832-1-git-send-email-dima@android.com>
References: <20110112235223.GM11039@n2100.arm.linux.org.uk>
	<1294877317-25832-1-git-send-email-dima@android.com>
Message-ID: <AANLkTin9JVf2+KtG99kmwDWwHyQjsFSBwiO4Va2HhJMS@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the review.

--Dima

On Wed, Jan 12, 2011 at 4:08 PM, Dima Zavin <dima@android.com> wrote:
> Do not use memory bank info to request the "system ram" resources as
> they do not track holes created by memblock_remove inside
> machine's reserve callback. If the removed memory is passed as
> platform_device's ioresource, then drivers that call
> request_mem_region would fail due to a conflict with the incorrectly
> configured system ram resource.
>
> Instead, iterate through the regions of memblock.memory and add
> those as "System RAM" resources.
>
> Signed-off-by: Dima Zavin <dima@android.com>
> ---
> ?arch/arm/kernel/setup.c | ? 16 ++++++----------
> ?1 files changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 336f14e..470efbc 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -517,25 +517,21 @@ setup_ramdisk(int doload, int prompt, int image_start, unsigned int rd_sz)
> ?#endif
> ?}
>
> -static void __init
> -request_standard_resources(struct meminfo *mi, struct machine_desc *mdesc)
> +static void __init request_standard_resources(struct machine_desc *mdesc)
> ?{
> + ? ? ? struct memblock_region *region;
> ? ? ? ?struct resource *res;
> - ? ? ? int i;
>
> ? ? ? ?kernel_code.start ? = virt_to_phys(_text);
> ? ? ? ?kernel_code.end ? ? = virt_to_phys(_etext - 1);
> ? ? ? ?kernel_data.start ? = virt_to_phys(_sdata);
> ? ? ? ?kernel_data.end ? ? = virt_to_phys(_end - 1);
>
> - ? ? ? for (i = 0; i < mi->nr_banks; i++) {
> - ? ? ? ? ? ? ? if (mi->bank[i].size == 0)
> - ? ? ? ? ? ? ? ? ? ? ? continue;
> -
> + ? ? ? for_each_memblock(memory, region) {
> ? ? ? ? ? ? ? ?res = alloc_bootmem_low(sizeof(*res));
> ? ? ? ? ? ? ? ?res->name ?= "System RAM";
> - ? ? ? ? ? ? ? res->start = mi->bank[i].start;
> - ? ? ? ? ? ? ? res->end ? = mi->bank[i].start + mi->bank[i].size - 1;
> + ? ? ? ? ? ? ? res->start = __pfn_to_phys(memblock_region_memory_base_pfn(region));
> + ? ? ? ? ? ? ? res->end = __pfn_to_phys(memblock_region_memory_end_pfn(region)) - 1;
> ? ? ? ? ? ? ? ?res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>
> ? ? ? ? ? ? ? ?request_resource(&iomem_resource, res);
> @@ -857,7 +853,7 @@ void __init setup_arch(char **cmdline_p)
> ? ? ? ?arm_memblock_init(&meminfo, mdesc);
>
> ? ? ? ?paging_init(mdesc);
> - ? ? ? request_standard_resources(&meminfo, mdesc);
> + ? ? ? request_standard_resources(mdesc);
>
> ?#ifdef CONFIG_SMP
> ? ? ? ?if (is_smp())
> --
> 1.7.3.1
>
>
