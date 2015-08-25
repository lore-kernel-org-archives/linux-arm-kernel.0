From: nschichan@freebox.fr (Nicolas Schichan)
Date: Tue, 25 Aug 2015 19:07:39 +0200
Subject: [PATCH v2 10/10] ARM: software-based priviledged-no-access support
In-Reply-To: <E1ZUGMS-0000BG-8B@rmk-PC.arm.linux.org.uk>
References: <20150825154026.GT7557@n2100.arm.linux.org.uk>
 <E1ZUGMS-0000BG-8B@rmk-PC.arm.linux.org.uk>
Message-ID: <55DCA0DB.7000103@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/25/2015 05:42 PM, Russell King wrote:
> Provide a software-based implementation of the priviledged no access
> support found in ARMv8.1.
[...]
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index a91177043467..ff74f0b54b0e 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -446,15 +446,45 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
>  	.endm
>  
>  	.macro	uaccess_disable, tmp, isb=1
> +#ifdef CONFIG_CPU_SW_DOMAIN_PAN
> +	/*
> +	 * Whenever we re-enter userspace, the domains should always be
> +	 * set appropriately.
> +	 */
> +	mov	\tmp, #DACR_UACCESS_DISABLE
> +	mcr	p15, 0, \tmp, c3, c0, 0		@ Set domain register
> +	.if	\isb
> +	isb
> +	.endif
> +#endif
>  	.endm
>  
>  	.macro	uaccess_enable, tmp, isb=1
> +#ifdef CONFIG_CPU_SW_DOMAIN_PAN
> +	/*
> +	 * Whenever we re-enter userspace, the domains should always be
> +	 * set appropriately.
> +	 */
> +	mov	\tmp, #DACR_UACCESS_ENABLE
> +	mcr	p15, 0, \tmp, c3, c0, 0
> +	.if	\isb
> +	isb
> +	.endif
> +#endif
>  	.endm

Thanks for the updated serie,

on ARMv5, I get the following compile error:

arch/arm/kernel/entry-common.S: Assembler messages:
arch/arm/kernel/entry-common.S:200: Error: selected processor does not support
ARM mode `isb'

replacing those two "isb" occurences with "instr_sync" fixed it.

With that added access to LIST_POISON are still correctly catched, when
CONFIG_CPU_SW_DOMAIN_PAN is set. Also the transmit of an ipv6 packet does not
result in a fault anymore. Also with CONFIG_CPU_SW_DOMAIN_PAN disabled, the
system now boots fine.

This has been tested on Linux 4.1 / kirkwood and Linux 4.2-rc8 / qemu,armv5.

Thanks,

-- 
Nicolas Schichan
Freebox SAS
