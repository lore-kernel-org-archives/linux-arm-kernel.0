From: panand@redhat.com (Pratyush Anand)
Date: Fri, 27 May 2016 16:57:47 +0530
Subject: [PATCH kexec-tools 18/32] arm: report if crash kernel is out of
 bounds
In-Reply-To: <E1axXTQ-0004ih-NN@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXTQ-0004ih-NN@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <CAHB_Guo-N0Coxj=fHBBM=QULMo6QK3uKbzOh15R6FCihGERjMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 3:52 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> Report an error if the crash kernel memory region is outside of the
> boot-view memory range - this can happen with systems such as
> Keystone 2.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>
> ---
>  kexec/arch/arm/crashdump-arm.c | 11 +++++++++++
>  kexec/arch/arm/crashdump-arm.h |  1 +
>  2 files changed, 12 insertions(+)
>
> diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
> index fcc4d42..739c906 100644
> --- a/kexec/arch/arm/crashdump-arm.c
> +++ b/kexec/arch/arm/crashdump-arm.c
> @@ -365,6 +365,17 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
>         if (get_kernel_page_offset(info, &elf_info))
>                 return -1;
>
> +       /*
> +        * Ensure that the crash kernel memory range is sane. The crash kernel
> +        * must be located within memory which is visible during booting.
> +        */
> +       if (crash_reserved_mem.end > ARM_MAX_VIRTUAL) {
> +               fprintf(stderr,
> +                       "Crash kernel memory [0x%llx-0x%llx] is inaccessible at boot - unable to load crash kernel\n",
> +                       crash_reserved_mem.start, crash_reserved_mem.end);
> +               return -1;
> +       }
> +
>         last_ranges = usablemem_rgns.size - 1;
>         if (last_ranges < 0)
>                 last_ranges = 0;
> diff --git a/kexec/arch/arm/crashdump-arm.h b/kexec/arch/arm/crashdump-arm.h
> index 2dbde04..7314960 100644
> --- a/kexec/arch/arm/crashdump-arm.h
> +++ b/kexec/arch/arm/crashdump-arm.h
> @@ -9,6 +9,7 @@ extern "C" {
>  #define DEFAULT_PAGE_OFFSET            (0xc0000000)
>  #define KVBASE_MASK    (0x1ffffff)
>  #define CRASH_MAX_MEMORY_RANGES        32
> +#define ARM_MAX_VIRTUAL                UINT32_MAX

If I see a kernel code then a virtual address is always defined as
unsigned long. So, shouldn't we use ULONG_MAX instead?

>
>
>  extern struct memory_ranges usablemem_rgns;
> --
> 1.9.1
>
