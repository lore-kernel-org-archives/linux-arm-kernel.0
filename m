From: panand@redhat.com (Pratyush Anand)
Date: Fri, 27 May 2016 17:03:46 +0530
Subject: [PATCH kexec-tools 23/32] arm: move crash system RAM parsing
 earlier
In-Reply-To: <E1axXTq-0004jC-OH@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXTq-0004jC-OH@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <CAHB_GuqgsukrjzjuttWVHN=s6vUkynEGAyRp0o7SH8JS40kCaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 3:53 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/arm/Makefile        |  2 ++
>  kexec/arch/arm/crashdump-arm.c | 51 ++++++++----------------------------------
>  2 files changed, 11 insertions(+), 42 deletions(-)
>
> diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile
> index 60e433a..71db8c3 100644
> --- a/kexec/arch/arm/Makefile
> +++ b/kexec/arch/arm/Makefile
> @@ -7,6 +7,8 @@ arm_FS2DT              = kexec/fs2dt.c
>  arm_FS2DT_INCLUDE      = -include $(srcdir)/kexec/arch/arm/crashdump-arm.h \
>                           -include $(srcdir)/kexec/arch/arm/kexec-arm.h
>
> +arm_MEM_REGIONS        = kexec/mem_regions.c
> +
>  arm_KEXEC_SRCS=  kexec/arch/arm/kexec-elf-rel-arm.c
>  arm_KEXEC_SRCS+= kexec/arch/arm/kexec-zImage-arm.c
>  arm_KEXEC_SRCS+= kexec/arch/arm/kexec-uImage-arm.c
> diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
> index d6db566..f2e6a0d 100644
> --- a/kexec/arch/arm/crashdump-arm.c
> +++ b/kexec/arch/arm/crashdump-arm.c
> @@ -30,6 +30,7 @@
>  #include "../../kexec.h"
>  #include "../../kexec-elf.h"
>  #include "../../crashdump.h"
> +#include "../../mem_regions.h"
>  #include "crashdump-arm.h"
>  #include "iomem.h"
>
> @@ -132,39 +133,6 @@ static int get_kernel_page_offset(struct kexec_info *info,
>  }
>
>  /**
> - * crash_range_callback() - callback called for each iomem region
> - * @data: not used
> - * @nr: not used
> - * @str: name of the memory region
> - * @base: start address of the memory region
> - * @length: size of the memory region
> - *
> - * This function is called once for each memory region found in /proc/iomem. It
> - * locates system RAM and places these into @crash_memory_ranges. Number of
> - * memory regions is placed in @crash_memory_nr_ranges.
> - */
> -static int crash_range_callback(void *UNUSED(data), int UNUSED(nr),
> -                               char *str, unsigned long long base,
> -                               unsigned long long length)
> -{
> -       struct memory_range *range;
> -
> -       if (usablemem_rgns.size >= CRASH_MAX_MEMORY_RANGES)
> -               return 1;
> -
> -       range = usablemem_rgns.ranges + usablemem_rgns.size;
> -
> -       if (strncmp(str, "System RAM\n", 11) == 0) {
> -               range->start = base;
> -               range->end = base + length - 1;
> -               range->type = RANGE_RAM;
> -               usablemem_rgns.size++;
> -       }
> -
> -       return 0;
> -}
> -
> -/**
>   * crash_exclude_range() - excludes memory region reserved for crashkernel
>   *
>   * Function locates where crashkernel reserved memory is and removes that region
> @@ -213,12 +181,6 @@ static void crash_exclude_range(void)
>   */
>  static int crash_get_memory_ranges(void)
>  {
> -       /*
> -        * First read all memory regions that can be considered as
> -        * system memory including the crash area.
> -        */
> -       kexec_iomem_for_each_line(NULL, crash_range_callback, NULL);
> -
>         if (usablemem_rgns.size < 1) {
>                 errno = EINVAL;
>                 return -1;
> @@ -414,8 +376,9 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
>   * @base: start address of the memory region
>   * @length: size of the memory region
>   *
> - * This function is called for each memory range in /proc/iomem, and stores
> - * the location of the crash kernel range into @crash_reserved_mem.
> + * This function is called for each memory range in /proc/iomem, stores
> + * the location of the crash kernel range into @crash_reserved_mem, and
> + * stores the system RAM into @usablemem_rgns.
>   */
>  static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
>                                 char *str, unsigned long long base,
> @@ -426,6 +389,10 @@ static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
>                 crash_reserved_mem.end = base + length - 1;
>                 crash_reserved_mem.type = RANGE_RAM;
>         }
> +       else if (strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0) {
> +               return mem_regions_add(&usablemem_rgns,
> +                                      base, length, RANGE_RAM);
> +       }
>         return 0;
>  }
>
> @@ -434,7 +401,7 @@ static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
>   *
>   * Check for the crashkernel reserved region in /proc/iomem, and return
>   * true if it is present, or false otherwise. We use this to store the
> - * location of this region.
> + * location of this region, and system RAM regions.
>   */
>  int is_crashkernel_mem_reserved(void)
>  {
> --
> 1.9.1
>
