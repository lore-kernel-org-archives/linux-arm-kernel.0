From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Thu, 4 Feb 2016 14:25:57 +0000
Subject: [PATCH] ARM: remove duplicate definitions of __vectors_start and
 __stubs_start
In-Reply-To: <1454574705-15109-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454574705-15109-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <HKXPR06MB0565A610565403E9E5E9546C8AD10@HKXPR06MB0565.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 Feb 2016, Ard Biesheuvel wrote:

> This is completely harmless by itself, since the wrong values are local
> symbols that cannot be referenced by other object files directly. However,
> since these symbols are also listed in the kallsyms symbol table in some
> cases (i.e., CONFIG_KALLSYMS_ALL=y and CONFIG_XIP_KERNEL=y), having these
> conflicting values can be confusing. So either remove them, or make them
> strictly local.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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


Tested with ARCH_R7S72100 with CONFIG_XIP_KERNEL=y and CONFIG_XIP_KERNEL=n

Duplicate symbols are gone, and boots fine (given the other patches from "[PATCH 0/3] kallsyms: remove special handling for CONFIG_ARM" for the CONFIG_XIP_KERNEL=y case) 


Acked-by: Chris Brandt <chris.brandt@renesas.com>
