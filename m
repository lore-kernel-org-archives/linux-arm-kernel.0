From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 25 May 2016 17:23:01 +0200
Subject: [PATCH] arm64/efi: remove spurious WARN_ON for !4K kernels
In-Reply-To: <1464189116-30898-1-git-send-email-mark.rutland@arm.com>
References: <1464189116-30898-1-git-send-email-mark.rutland@arm.com>
Message-ID: <BA565A9C-8CC0-42E4-9821-7941852F835A@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On 25 mei 2016, at 17:11, Mark Rutland <mark.rutland@arm.com> wrote:
> 
> Since commit 1fd55a9a09b0293a ("arm64/efi: Apply strict permissions to
> UEFI Runtime Services regions"), booting a !4K page kernel results in a
> boot-time splat on some systems, due to to a WARN_ONCE added in that
> commit which fires if the base address of an EFI memory descriptor is
> not aligned to the kernel page size (which might be 4K, 16K, or 64K).
> 
> On page 38 of the UEFI 2.6 specification it is stated:
> 
>    If a 64KiB physical page contains any 4KiB page with any of the
>    following types listed below, then all 4KiB pages in the 64KiB
>    page must use identical ARM Memory Page Attributes (as described
>    in Table 8):
>    ? EfiRuntimeServicesCode
>    ? EfiRuntimeServicesData
>    ? EfiReserved
>    ? EfiACPIMemoryNVS
>    Mixed attribute mappings within a larger page are not allowed.
> 

The same section mentions that the ro/xp etc attributes are unused on arm, so if we go by the letter here, we need to remove those memory protection features entirely. So a spec update is clearly in order here.

That still means the patch is correct, of course ...

> On page 158 of the UEFI 2.6 specification, in the description of a
> memory descriptor, the PhysicalStart and VirtualStart fields are
> mandated as being 4K aligned, with NumberOfPages describing the number
> of 4K pages in the region.
> 
> No further restriction on alignment is provided in the UEFI
> specification, neither generically nor in a rule specific to AArch64.
> 
> So while attributes within a naturally-aligned 64K region must be
> consistent across memory descriptors, the regions described by those
> descriptors are not mandated to be 64K aligned.
> 
> Not being able to apply strict permissions is sub-optimal, and worthy of
> some notice, but it is not helpful to erroneously suggest that firmware
> is buggy, nor is it beneficial to have a noisy backtrace at boot time.
> 
> This patch downgrades the WARN_ONCE to a pr_warn_once, and re-words the
> message to also describe the implication of the insufficient alignment.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Leif Lindholm <leif.lindholm@linaro.org>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-efi at vger.kernel.org
> ---
> arch/arm64/kernel/efi.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index 78f5248..95e748e 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -30,14 +30,15 @@ static __init pteval_t create_mapping_protection(efi_memory_desc_t *md)
>    if (type == EFI_MEMORY_MAPPED_IO)
>        return PROT_DEVICE_nGnRE;
> 
> -    if (WARN_ONCE(!PAGE_ALIGNED(md->phys_addr),
> -              "UEFI Runtime regions are not aligned to 64 KB -- buggy firmware?"))
> +    if (!PAGE_ALIGNED(md->phys_addr)) {
> +        pr_warn_once("UEFI Runtime regions insufficiently aligned for strict permissions\n");
>        /*
>         * If the region is not aligned to the page size of the OS, we
>         * can not use strict permissions, since that would also affect
>         * the mapping attributes of the adjacent regions.
>         */
>        return pgprot_val(PAGE_KERNEL_EXEC);
> +    }
> 
>    /* R-- */
>    if ((attr & (EFI_MEMORY_XP | EFI_MEMORY_RO)) ==
> -- 
> 1.9.1
> 
