From: panand@redhat.com (Pratyush Anand)
Date: Fri, 27 May 2016 17:00:36 +0530
Subject: [PATCH kexec-tools 21/32] arm: parse crash_reserved_mem early
In-Reply-To: <E1axXTg-0004iz-CQ@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXTg-0004iz-CQ@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <CAHB_GupGaahVrx7L9B36V_Ndepo=AstWgdPdcLEZdm-W=fGuYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 3:52 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> We parse the crash kernel memory region in several locations in the
> kexec tools - once to check that there's a region, another time for
> real when we're locating the memory regions to dump, and another
> while loading the image.
>
> Move the real parsing step to is_crashkernel_mem_reserved(), which
> matches what x86 is doing.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/arm/crashdump-arm.c | 47 +++++++++++++++++++++++++++++++-----------
>  kexec/arch/arm/iomem.h         |  7 +++++++
>  2 files changed, 42 insertions(+), 12 deletions(-)
>  create mode 100644 kexec/arch/arm/iomem.h
>
> diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
> index 195b43f..85afd9f 100644
> --- a/kexec/arch/arm/crashdump-arm.c
> +++ b/kexec/arch/arm/crashdump-arm.c
> @@ -31,6 +31,7 @@
>  #include "../../kexec-elf.h"
>  #include "../../crashdump.h"
>  #include "crashdump-arm.h"
> +#include "iomem.h"
>
>  #if __BYTE_ORDER == __LITTLE_ENDIAN
>  #define ELFDATANATIVE ELFDATA2LSB
> @@ -139,9 +140,8 @@ static int get_kernel_page_offset(struct kexec_info *info,
>   * @length: size of the memory region
>   *
>   * This function is called once for each memory region found in /proc/iomem. It
> - * locates system RAM and crashkernel reserved memory and places these to
> - * variables: @crash_memory_ranges and @crash_reserved_mem. Number of memory
> - * regions is placed in @crash_memory_nr_ranges.
> + * locates system RAM and places these into @crash_memory_ranges. Number of
> + * memory regions is placed in @crash_memory_nr_ranges.
>   */
>  static int crash_range_callback(void *UNUSED(data), int UNUSED(nr),
>                                 char *str, unsigned long long base,
> @@ -159,10 +159,6 @@ static int crash_range_callback(void *UNUSED(data), int UNUSED(nr),
>                 range->end = base + length - 1;
>                 range->type = RANGE_RAM;
>                 usablemem_rgns.size++;
> -       } else if (strncmp(str, "Crash kernel\n", 13) == 0) {
> -               crash_reserved_mem.start = base;
> -               crash_reserved_mem.end = base + length - 1;
> -               crash_reserved_mem.type = RANGE_RAM;
>         }
>
>         return 0;
> @@ -424,12 +420,39 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
>         return 0;
>  }
>
> -int is_crashkernel_mem_reserved(void)
> +/**
> + * iomem_range_callback() - callback called for each iomem region
> + * @data: not used
> + * @nr: not used
> + * @str: name of the memory region (not NULL terminated)
> + * @base: start address of the memory region
> + * @length: size of the memory region
> + *
> + * This function is called for each memory range in /proc/iomem, and stores
> + * the location of the crash kernel range into @crash_reserved_mem.
> + */
> +static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
> +                               char *str, unsigned long long base,
> +                               unsigned long long length)
>  {
> -       uint64_t start, end;
> +       if (strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL)) == 0) {
> +               crash_reserved_mem.start = base;
> +               crash_reserved_mem.end = base + length - 1;
> +               crash_reserved_mem.type = RANGE_RAM;
> +       }
> +       return 0;
> +}
>
> -       if (parse_iomem_single("Crash kernel\n", &start, &end) == 0)
> -               return start != end;
> +/**
> + * is_crashkernel_mem_reserved() - check for the crashkernel reserved region
> + *
> + * Check for the crashkernel reserved region in /proc/iomem, and return
> + * true if it is present, or false otherwise. We use this to store the
> + * location of this region.
> + */
> +int is_crashkernel_mem_reserved(void)
> +{
> +       kexec_iomem_for_each_line(NULL, iomem_range_callback, NULL);
>
> -       return 0;
> +       return crash_reserved_mem.start != crash_reserved_mem.end;
>  }
> diff --git a/kexec/arch/arm/iomem.h b/kexec/arch/arm/iomem.h
> new file mode 100644
> index 0000000..81c593d
> --- /dev/null
> +++ b/kexec/arch/arm/iomem.h
> @@ -0,0 +1,7 @@
> +#ifndef IOMEM_H
> +#define IOMEM_H
> +
> +#define SYSTEM_RAM             "System RAM\n"
> +#define CRASH_KERNEL           "Crash kernel\n"
> +
> +#endif
> --
> 1.9.1
>
