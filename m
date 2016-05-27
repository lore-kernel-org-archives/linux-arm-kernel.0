From: panand@redhat.com (Pratyush Anand)
Date: Fri, 27 May 2016 17:06:15 +0530
Subject: [PATCH kexec-tools 26/32] arm: rename crash_reserved_mem to
 crash_kernel_mem
In-Reply-To: <E1axXU6-0004jU-At@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXU6-0004jU-At@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <CAHB_GurX7ZS0PaRaos5VZzndpsL+d+783Jw2Dm0K_h3C0aN3FA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 3:53 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> Rename crash_reserved_mem to crash_kernel_mem as we want to support
> multiple reserved memory ranges.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/arm/crashdump-arm.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
> index f2e6a0d..1a6ab88 100644
> --- a/kexec/arch/arm/crashdump-arm.c
> +++ b/kexec/arch/arm/crashdump-arm.c
> @@ -53,7 +53,7 @@ struct memory_ranges usablemem_rgns = {
>  };
>
>  /* memory range reserved for crashkernel */
> -static struct memory_range crash_reserved_mem;
> +static struct memory_range crash_kernel_mem;
>
>  static struct crash_elf_info elf_info = {
>         .class          = ELFCLASS32,
> @@ -140,7 +140,7 @@ static int get_kernel_page_offset(struct kexec_info *info,
>   */
>  static void crash_exclude_range(void)
>  {
> -       const struct memory_range *range = &crash_reserved_mem;
> +       const struct memory_range *range = &crash_kernel_mem;
>         int i;
>
>         for (i = 0; i < usablemem_rgns.size; i++) {
> @@ -262,8 +262,8 @@ static void dump_memory_ranges(void)
>                 return;
>
>         dbgprintf("crashkernel: [%#llx - %#llx] (%ldM)\n",
> -                 crash_reserved_mem.start, crash_reserved_mem.end,
> -                 (unsigned long)range_size(&crash_reserved_mem) >> 20);
> +                 crash_kernel_mem.start, crash_kernel_mem.end,
> +                 (unsigned long)range_size(&crash_kernel_mem) >> 20);
>
>         for (i = 0; i < usablemem_rgns.size; i++) {
>                 struct memory_range *r = usablemem_rgns.ranges + i;
> @@ -313,10 +313,10 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
>          * Ensure that the crash kernel memory range is sane. The crash kernel
>          * must be located within memory which is visible during booting.
>          */
> -       if (crash_reserved_mem.end > ARM_MAX_VIRTUAL) {
> +       if (crash_kernel_mem.end > ARM_MAX_VIRTUAL) {
>                 fprintf(stderr,
>                         "Crash kernel memory [0x%llx-0x%llx] is inaccessible at boot - unable to load crash kernel\n",
> -                       crash_reserved_mem.start, crash_reserved_mem.end);
> +                       crash_kernel_mem.start, crash_kernel_mem.end);
>                 return -1;
>         }
>
> @@ -349,8 +349,8 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
>          * regions to be aligned to SECTION_SIZE.
>          */
>         elfcorehdr = add_buffer_phys_virt(info, buf, bufsz, bufsz, 1 << 20,
> -                                         crash_reserved_mem.start,
> -                                         crash_reserved_mem.end, -1, 0);
> +                                         crash_kernel_mem.start,
> +                                         crash_kernel_mem.end, -1, 0);
>
>         dbgprintf("elfcorehdr: %#lx\n", elfcorehdr);
>         cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
> @@ -360,7 +360,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
>          * prevents the dump capture kernel from using any other memory regions
>          * which belong to the primary kernel.
>          */
> -       cmdline_add_mem(mod_cmdline, elfcorehdr - crash_reserved_mem.start);
> +       cmdline_add_mem(mod_cmdline, elfcorehdr - crash_kernel_mem.start);
>
>         dump_memory_ranges();
>         dbgprintf("kernel command line: \"%s\"\n", mod_cmdline);
> @@ -377,7 +377,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
>   * @length: size of the memory region
>   *
>   * This function is called for each memory range in /proc/iomem, stores
> - * the location of the crash kernel range into @crash_reserved_mem, and
> + * the location of the crash kernel range into @crash_kernel_mem, and
>   * stores the system RAM into @usablemem_rgns.
>   */
>  static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
> @@ -385,9 +385,9 @@ static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
>                                 unsigned long long length)
>  {
>         if (strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL)) == 0) {
> -               crash_reserved_mem.start = base;
> -               crash_reserved_mem.end = base + length - 1;
> -               crash_reserved_mem.type = RANGE_RAM;
> +               crash_kernel_mem.start = base;
> +               crash_kernel_mem.end = base + length - 1;
> +               crash_kernel_mem.type = RANGE_RAM;
>         }
>         else if (strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0) {
>                 return mem_regions_add(&usablemem_rgns,
> @@ -407,5 +407,5 @@ int is_crashkernel_mem_reserved(void)
>  {
>         kexec_iomem_for_each_line(NULL, iomem_range_callback, NULL);
>
> -       return crash_reserved_mem.start != crash_reserved_mem.end;
> +       return crash_kernel_mem.start != crash_kernel_mem.end;
>  }
> --
> 1.9.1
>
