From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Feb 2017 18:26:49 +0000
Subject: [PATCHv2 2/2] arch: Rename CONFIG_DEBUG_RODATA and
 CONFIG_DEBUG_MODULE_RONX
In-Reply-To: <1486144343-24998-3-git-send-email-labbott@redhat.com>
References: <1486144343-24998-1-git-send-email-labbott@redhat.com>
 <1486144343-24998-3-git-send-email-labbott@redhat.com>
Message-ID: <20170203182648.GB26578@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2017 at 09:52:22AM -0800, Laura Abbott wrote:
> 
> Both of these options are poorly named. The features they provide are
> necessary for system security and should not be considered debug only.
> Change the name to something that accurately describes what these
> options do.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>

As with patch 1, this looks good to me. FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
> index 939815e..560a8d8 100644
> --- a/arch/arm64/Kconfig.debug
> +++ b/arch/arm64/Kconfig.debug
> @@ -72,7 +72,7 @@ config DEBUG_WX
>  	  If in doubt, say "Y".
>  
>  config DEBUG_ALIGN_RODATA
> -	depends on DEBUG_RODATA
> +	depends on STRICT_KERNEL_RWX
>  	bool "Align linker sections up to SECTION_SIZE"
>  	help
>  	  If this option is enabled, sections that may potentially be marked as
> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> index 94b62c1..67f9cb9 100644
> --- a/arch/arm64/kernel/insn.c
> +++ b/arch/arm64/kernel/insn.c
> @@ -93,7 +93,7 @@ static void __kprobes *patch_map(void *addr, int fixmap)
>  	bool module = !core_kernel_text(uintaddr);
>  	struct page *page;
>  
> -	if (module && IS_ENABLED(CONFIG_DEBUG_SET_MODULE_RONX))
> +	if (module && IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
>  		page = vmalloc_to_page(addr);
>  	else if (!module)
>  		page = pfn_to_page(PHYS_PFN(__pa(addr)));

Since CONFIG_STRICT_MODULE_RWX is mandatory for arm64, we should be able
to simplify this, but that can wait for a later patch.

Thanks,
Mark.
