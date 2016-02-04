From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 4 Feb 2016 11:49:34 -0500 (EST)
Subject: [PATCH] ARM: remove duplicate definitions of __vectors_start
 and __stubs_start
In-Reply-To: <1454574705-15109-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454574705-15109-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <alpine.LFD.2.20.1602041148050.17825@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 4 Feb 2016, Ard Biesheuvel wrote:

> Commit b9b32bf70f2f ("ARM: use linker magic for vectors and vector stubs")
> introduced new global definitions of __vectors_start and __stubs_start,
> and changed the existing ones to have internal linkage only. However, these
> symbols are still visible to kallsyms, and due to the way the .vectors and
> .stubs sections are emitted at the base of the VMA space, these duplicate
> definitions have conflicting values.
> 
>   $ nm -n vmlinux |grep -E __vectors\|__stubs
>   00000000 t __vectors_start
>   00001000 t __stubs_start
>   c0e77000 T __vectors_start
>   c0e77020 T __stubs_start
> 
> This is completely harmless by itself, since the wrong values are local
> symbols that cannot be referenced by other object files directly. However,
> since these symbols are also listed in the kallsyms symbol table in some
> cases (i.e., CONFIG_KALLSYMS_ALL=y and CONFIG_XIP_KERNEL=y), having these
> conflicting values can be confusing. So either remove them, or make them
> strictly local.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
> 
> This is a separate fix for the duplicate symbols based on v4.5-rc2,
> so that it can be applied separately if desired. In that case, I will
> rebase my kallsyms series onto this patch.
> 
>  arch/arm/kernel/entry-armv.S | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index 3ce377f7251f..788e40c1254f 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -1064,7 +1064,6 @@ ENDPROC(vector_\name)
>  	.endm
>  
>  	.section .stubs, "ax", %progbits
> -__stubs_start:
>  	@ This must be the first word
>  	.word	vector_swi
>  
> @@ -1206,10 +1205,10 @@ vector_addrexcptn:
>  	.equ	vector_fiq_offset, vector_fiq
>  
>  	.section .vectors, "ax", %progbits
> -__vectors_start:
> +.L__vectors_start:
>  	W(b)	vector_rst
>  	W(b)	vector_und
> -	W(ldr)	pc, __vectors_start + 0x1000
> +	W(ldr)	pc, .L__vectors_start + 0x1000
>  	W(b)	vector_pabt
>  	W(b)	vector_dabt
>  	W(b)	vector_addrexcptn
> -- 
> 2.5.0
> 
> 
