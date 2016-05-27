From: panand@redhat.com (Pratyush Anand)
Date: Fri, 27 May 2016 17:07:46 +0530
Subject: [PATCH kexec-tools 28/32] arm: add support for boot-time crash
 kernel resource
In-Reply-To: <E1axXUG-0004jg-PD@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXUG-0004jg-PD@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <CAHB_GuqYApGpL1v-4mLUJ-iZcs9k-jg8DFedG8_S+Mat4mVoRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 3:53 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> Add support for detecting and using the boot-time crash kernel
> resource, which is needed for systems which have special boot-time
> memory views, such as Keystone 2.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/arm/crashdump-arm.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
> index 9113f5e..25fdbe9 100644
> --- a/kexec/arch/arm/crashdump-arm.c
> +++ b/kexec/arch/arm/crashdump-arm.c
> @@ -52,7 +52,7 @@ struct memory_ranges usablemem_rgns = {
>         .ranges = crash_memory_ranges,
>  };
>
> -/* memory range reserved for crashkernel */
> +/* The boot-time physical memory range reserved for crashkernel region */
>  static struct memory_range crash_kernel_mem;
>
>  /* reserved regions */
> @@ -366,13 +366,22 @@ static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
>                                 char *str, unsigned long long base,
>                                 unsigned long long length)
>  {
> -       if (strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL)) == 0) {
> +       if (strncmp(str, CRASH_KERNEL_BOOT, strlen(CRASH_KERNEL_BOOT)) == 0) {
>                 crash_kernel_mem.start = base;
>                 crash_kernel_mem.end = base + length - 1;
>                 crash_kernel_mem.type = RANGE_RAM;
>                 return mem_regions_add(&crash_reserved_rgns,
>                                        base, length, RANGE_RAM);
>         }
> +       else if (strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL)) == 0) {
> +               if (crash_kernel_mem.start == crash_kernel_mem.end) {
> +                       crash_kernel_mem.start = base;
> +                       crash_kernel_mem.end = base + length - 1;
> +                       crash_kernel_mem.type = RANGE_RAM;
> +               }
> +               return mem_regions_add(&crash_reserved_rgns,
> +                                      base, length, RANGE_RAM);
> +       }
>         else if (strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0) {
>                 return mem_regions_add(&usablemem_rgns,
>                                        base, length, RANGE_RAM);
> --
> 1.9.1
>
