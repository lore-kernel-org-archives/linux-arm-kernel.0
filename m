From: panand@redhat.com (Pratyush Anand)
Date: Fri, 27 May 2016 17:07:23 +0530
Subject: [PATCH kexec-tools 27/32] arm: add support for multiple reserved
 regions
In-Reply-To: <E1axXUB-0004ja-JE@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXUB-0004ja-JE@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <CAHB_Gur-Z8ypohfG7rACR_hvnf_03TqrpJuFtZxAynnmRY6bUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 3:53 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> Add support for reserving multiple memory regions rather than just a
> single region.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/arm/crashdump-arm.c | 66 ++++++++++++++++--------------------------
>  1 file changed, 25 insertions(+), 41 deletions(-)
>
> diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
> index 1a6ab88..9113f5e 100644
> --- a/kexec/arch/arm/crashdump-arm.c
> +++ b/kexec/arch/arm/crashdump-arm.c
> @@ -55,6 +55,14 @@ struct memory_ranges usablemem_rgns = {
>  /* memory range reserved for crashkernel */
>  static struct memory_range crash_kernel_mem;
>
> +/* reserved regions */
> +#define CRASH_MAX_RESERVED_RANGES 2
> +static struct memory_range crash_reserved_ranges[CRASH_MAX_RESERVED_RANGES];
> +static struct memory_ranges crash_reserved_rgns = {
> +       .max_size = CRASH_MAX_RESERVED_RANGES,
> +       .ranges = crash_reserved_ranges,
> +};
> +
>  static struct crash_elf_info elf_info = {
>         .class          = ELFCLASS32,
>         .data           = ELFDATANATIVE,
> @@ -133,44 +141,6 @@ static int get_kernel_page_offset(struct kexec_info *info,
>  }
>
>  /**
> - * crash_exclude_range() - excludes memory region reserved for crashkernel
> - *
> - * Function locates where crashkernel reserved memory is and removes that region
> - * from the available memory regions.
> - */
> -static void crash_exclude_range(void)
> -{
> -       const struct memory_range *range = &crash_kernel_mem;
> -       int i;
> -
> -       for (i = 0; i < usablemem_rgns.size; i++) {
> -               struct memory_range *r = usablemem_rgns.ranges + i;
> -
> -               /*
> -                * We assume that crash area is fully contained in
> -                * some larger memory area.
> -                */
> -               if (r->start <= range->start && r->end >= range->end) {
> -                       struct memory_range *new;
> -                       /*
> -                        * Let's split this area into 2 smaller ones and
> -                        * remove excluded range from between. First create
> -                        * new entry for the remaining area.
> -                        */
> -                       new = usablemem_rgns.ranges + usablemem_rgns.size;
> -                       new->start = range->end + 1;
> -                       new->end = r->end;
> -                       usablemem_rgns.size++;
> -                       /*
> -                        * Next update this area to end before excluded range.
> -                        */
> -                       r->end = range->start - 1;
> -                       break;
> -               }
> -       }
> -}
> -
> -/**
>   * crash_get_memory_ranges() - read system physical memory
>   *
>   * Function reads through system physical memory and stores found memory regions
> @@ -181,16 +151,28 @@ static void crash_exclude_range(void)
>   */
>  static int crash_get_memory_ranges(void)
>  {
> +       int i;
> +
>         if (usablemem_rgns.size < 1) {
>                 errno = EINVAL;
>                 return -1;
>         }
>
>         /*
> -        * Exclude memory reserved for crashkernel (this may result a split memory
> -        * region).
> +        * Exclude all reserved memory from the usable memory regions.
> +        * We want to avoid dumping the crashkernel region itself.  Note
> +        * that this may result memory regions in usablemem_rgns being
> +        * split.
>          */
> -       crash_exclude_range();
> +       for (i = 0; i < crash_reserved_rgns.size; i++) {
> +               if (mem_regions_exclude(&usablemem_rgns,
> +                                       &crash_reserved_rgns.ranges[i])) {
> +                       fprintf(stderr,
> +                               "Error: Number of crash memory ranges excedeed the max limit\n");
> +                       errno = ENOMEM;
> +                       return -1;
> +               }
> +       }
>
>         /*
>          * Make sure that the memory regions are sorted.
> @@ -388,6 +370,8 @@ static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
>                 crash_kernel_mem.start = base;
>                 crash_kernel_mem.end = base + length - 1;
>                 crash_kernel_mem.type = RANGE_RAM;
> +               return mem_regions_add(&crash_reserved_rgns,
> +                                      base, length, RANGE_RAM);
>         }
>         else if (strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0) {
>                 return mem_regions_add(&usablemem_rgns,
> --
> 1.9.1
>
