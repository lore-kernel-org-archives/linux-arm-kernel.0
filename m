From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 5 Dec 2014 10:01:01 +0100
Subject: [PATCH] arm64: respect mem= for EFI
In-Reply-To: <1417692140-29796-1-git-send-email-mark.rutland@arm.com>
References: <1417692140-29796-1-git-send-email-mark.rutland@arm.com>
Message-ID: <CAKv+Gu8X6XDDLeEiSn-rAtJyP2+yMSvXa=4Y=70o0ZusJ_P1gQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 December 2014 at 12:22, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi all,
>
> While trying to debug a userspace test failure, I noticed that the mem=
> option didn't work when booting via EFI due to some unfortunate init
> ordering.
>
> However, with that alone fixed (patch below) things blow up early if a
> mem= option is passed to the kernel, because of the way we currently map
> the EFI runtime services.
>
> I've given this patch a spin atop of Ard's rework of the runtime
> services mapping [1], and that's far happier; I can boot to userspace
> and memory is limited int he way I expect.
>
> Assuming people are fine with this, would this make sense to append to
> the runtime services mapping series?
>

I think the patch is good. If people agree, I can carry it along when
I send out the next UEFI virtmap for kexec series.

-- 
Ard.


> [1] https://git.linaro.org/people/ard.biesheuvel/linux-arm.git/shortlog/refs/heads/efi-for-arm64
>
> ---->8----
> When booting with EFI, we acquire the EFI memory map after parsing the
> early params. This unfortuantely renders the option useless as we call
> memblock_enforce_memory_limit (which uses memblock_remove_range behind
> the scenes) before we've added any memblocks. We end up removing
> nothing, then adding all of memory later when efi_init calls
> reserve_regions.
>
> Instead, we can log the limit and apply this later when we do the rest
> of the memblock work in memblock_init, which should work regardless of
> the presence of EFI. At the same time we may as well move the early
> parameter into arm64's mm/init.c, close to arm64_memblock_init.
>
> Any memory which must be mapped (e.g. for use by EFI runtime services)
> must be mapped explicitly reather than relying on the linear mapping,
> which may be truncated as a result of a mem= option passed on the kernel
> command line.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Leif Lindholm <leif.lindholm@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/setup.c | 19 -------------------
>  arch/arm64/mm/init.c      | 19 +++++++++++++++++++
>  2 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 4c9b0e0..00137ef 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -322,25 +322,6 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
>         dump_stack_set_arch_desc("%s (DT)", of_flat_dt_get_machine_name());
>  }
>
> -/*
> - * Limit the memory size that was specified via FDT.
> - */
> -static int __init early_mem(char *p)
> -{
> -       phys_addr_t limit;
> -
> -       if (!p)
> -               return 1;
> -
> -       limit = memparse(p, &p) & PAGE_MASK;
> -       pr_notice("Memory limited to %lldMB\n", limit >> 20);
> -
> -       memblock_enforce_memory_limit(limit);
> -
> -       return 0;
> -}
> -early_param("mem", early_mem);
> -
>  static void __init request_standard_resources(void)
>  {
>         struct memblock_region *region;
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index bac492c..11c7b70 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -136,10 +136,29 @@ static void arm64_memory_present(void)
>  }
>  #endif
>
> +static phys_addr_t memory_limit = (phys_addr_t)ULLONG_MAX;
> +
> +/*
> + * Limit the memory size that was specified via FDT.
> + */
> +static int __init early_mem(char *p)
> +{
> +       if (!p)
> +               return 1;
> +
> +       memory_limit = memparse(p, &p) & PAGE_MASK;
> +       pr_notice("Memory limited to %lldMB\n", memory_limit >> 20);
> +
> +       return 0;
> +}
> +early_param("mem", early_mem);
> +
>  void __init arm64_memblock_init(void)
>  {
>         phys_addr_t dma_phys_limit = 0;
>
> +       memblock_enforce_memory_limit(memory_limit);
> +
>         /*
>          * Register the kernel text, kernel data, initrd, and initial
>          * pagetables with memblock.
> --
> 1.9.1
>
