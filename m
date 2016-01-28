From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Thu, 28 Jan 2016 22:59:00 +0000
Subject: [PATCH 2/3] arm64: vmlinux.lds.S: handle .init.rodata.xxx and
 .init.bss sections
In-Reply-To: <1453979254-25374-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1453979254-25374-1-git-send-email-ard.biesheuvel@linaro.org>
 <1453979254-25374-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160128225900.GG2571@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Jan, at 12:07:33PM, Ard Biesheuvel wrote:
> The EFI stub is typically built into the decompressor (x86, ARM) so none
> of its symbols are annotated as __init. However, on arm64, the stub is
> linked into the kernel proper, and the code is __init annotated at the
> section level by prepending all names of SHF_ALLOC sections with '.init'.
> 
> This results in section names like .init.rodata.str1.8 (for string literals)
> and .init.bss (which is tiny), both of which can be moved into the .init.data
> output section.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/vmlinux.lds.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index e3928f578891..cbf4db440e9c 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -134,6 +134,7 @@ SECTIONS
>  		CON_INITCALL
>  		SECURITY_INITCALL
>  		INIT_RAM_FS
> +		*(.init.rodata.* .init.bss)	/* from the EFI stub */
>  	}
>  	.exit.data : {
>  		ARM_EXIT_KEEP(EXIT_DATA)

FWIW,

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
