From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 27 Oct 2015 11:37:04 +0900
Subject: [PATCH] arm64: page-align sections for DEBUG_RODATA
In-Reply-To: <1445895753-2095-1-git-send-email-mark.rutland@arm.com>
References: <1445895753-2095-1-git-send-email-mark.rutland@arm.com>
Message-ID: <CAKv+Gu-jCxeQt1DffTnYiMLT-jB75GiQCOUR7GqNH7hAeB84LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 October 2015 at 06:42, Mark Rutland <mark.rutland@arm.com> wrote:
> A kernel built with DEBUG_RO_DATA && !CONFIG_DEBUG_ALIGN_RODATA doesn't
> have .text aligned to a page boundary, though fixup_executable works at
> page-granularity thanks to its use of create_mapping. If .text is not
> page-aligned, the first page it exists in may be marked non-executable,
> leading to failures when an attempt is made to execute code in said
> page.
>
> This patch upgrades ALIGN_DEBUG_RO and ALIGN_DEBUG_RO_MIN to force page
> alignment for DEBUG_RO_DATA && !CONFIG_DEBUG_ALIGN_RODATA kernels,
> ensuring that all sections with specific RWX permission requirements are
> mapped with the correct permissions.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> Reviewed-by: Laura Abbott <laura@labbott.name>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/vmlinux.lds.S | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> Note: this is intended to supercede [1,2].
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/380486.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/380999.html
>
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 9807333..4d77757 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -60,9 +60,12 @@ PECOFF_FILE_ALIGNMENT = 0x200;
>  #define PECOFF_EDATA_PADDING
>  #endif
>
> -#ifdef CONFIG_DEBUG_ALIGN_RODATA
> +#if defined(CONFIG_DEBUG_ALIGN_RODATA)
>  #define ALIGN_DEBUG_RO                 . = ALIGN(1<<SECTION_SHIFT);
>  #define ALIGN_DEBUG_RO_MIN(min)                ALIGN_DEBUG_RO
> +#elif defined(CONFIG_DEBUG_RODATA)
> +#define ALIGN_DEBUG_RO                 . = ALIGN(1<<PAGE_SHIFT);
> +#define ALIGN_DEBUG_RO_MIN(min)                ALIGN_DEBUG_RO
>  #else
>  #define ALIGN_DEBUG_RO
>  #define ALIGN_DEBUG_RO_MIN(min)                . = ALIGN(min);

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
