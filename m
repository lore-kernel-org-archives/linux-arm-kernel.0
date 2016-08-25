From: labbott@redhat.com (Laura Abbott)
Date: Thu, 25 Aug 2016 11:20:26 -0700
Subject: [PATCH] arm64: always enable DEBUG_RODATA and remove the Kconfig
 option
In-Reply-To: <1472142204-14258-1-git-send-email-mark.rutland@arm.com>
References: <1472142204-14258-1-git-send-email-mark.rutland@arm.com>
Message-ID: <789f1679-d6fb-2229-9950-bb2c63a9fa62@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/25/2016 09:23 AM, Mark Rutland wrote:
> Follow the example set by x86 in commit 9ccaf77cf05915f5 ("x86/mm:
> Always enable CONFIG_DEBUG_RODATA and remove the Kconfig option"), and
> make these protections a fundamental security feature rather than an
> opt-in. This also results in a minor code simplification.
>
> For those rare cases when users wish to disable this protection (e.g.
> for debugging), this can be done by passing 'rodata=off' on the command
> line.
>
> As DEBUG_RODATA_ALIGN is only intended to address a performance/memory
> tradeoff, and does not affect correctness, this is left user-selectable.
> DEBUG_MODULE_RONX is also left user-selectable until the core code
> provides a boot-time option to disable the protection for debugging
> use-cases.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Will Deacon <will.deacon@arm.com>

Excellent!

Acked-by: Laura Abbott <labbott@redhat.com>

> ---
>  arch/arm64/Kconfig       |  3 +++
>  arch/arm64/Kconfig.debug | 10 ----------
>  arch/arm64/kernel/insn.c |  2 +-
>  3 files changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index bc3f00f..43d6134 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -122,6 +122,9 @@ config ARCH_PHYS_ADDR_T_64BIT
>  config MMU
>  	def_bool y
>
> +config DEBUG_RODATA
> +	def_bool y
> +
>  config ARM64_PAGE_SHIFT
>  	int
>  	default 16 if ARM64_64K_PAGES
> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
> index 0cc758c..b661fe7 100644
> --- a/arch/arm64/Kconfig.debug
> +++ b/arch/arm64/Kconfig.debug
> @@ -49,16 +49,6 @@ config DEBUG_SET_MODULE_RONX
>
>  	  If in doubt, say Y.
>
> -config DEBUG_RODATA
> -	bool "Make kernel text and rodata read-only"
> -	default y
> -	help
> -	  If this is set, kernel text and rodata will be made read-only. This
> -	  is to help catch accidental or malicious attempts to change the
> -	  kernel's executable code.
> -
> -	  If in doubt, say Y.
> -
>  config DEBUG_ALIGN_RODATA
>  	depends on DEBUG_RODATA
>  	bool "Align linker sections up to SECTION_SIZE"
> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> index 63f9432..178488f 100644
> --- a/arch/arm64/kernel/insn.c
> +++ b/arch/arm64/kernel/insn.c
> @@ -96,7 +96,7 @@ static void __kprobes *patch_map(void *addr, int fixmap)
>
>  	if (module && IS_ENABLED(CONFIG_DEBUG_SET_MODULE_RONX))
>  		page = vmalloc_to_page(addr);
> -	else if (!module && IS_ENABLED(CONFIG_DEBUG_RODATA))
> +	else if (!module)
>  		page = pfn_to_page(PHYS_PFN(__pa(addr)));
>  	else
>  		return addr;
>
