From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 11 Oct 2011 10:56:39 +0100
Subject: [RFC/PATCH 5/7] ARM: Move get_thread_info macro definition to
	<asm/assembler.h>
In-Reply-To: <1317955121-28047-6-git-send-email-gdavis@mvista.com>
References: <1317877714-11355-1-git-send-email-gdavis@mvista.com>
	<1317955121-28047-1-git-send-email-gdavis@mvista.com>
	<1317955121-28047-6-git-send-email-gdavis@mvista.com>
Message-ID: <20111011095639.GB23848@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2011 at 03:38:39AM +0100, gdavis at mvista.com wrote:
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 29035e8..78397d0 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -23,6 +23,19 @@
>  #include <asm/ptrace.h>
>  #include <asm/domain.h>
>  
> +#ifndef CONFIG_THUMB2_KERNEL
> +	.macro	get_thread_info, rd
> +	mov	\rd, sp, lsr #13
> +	mov	\rd, \rd, lsl #13
> +	.endm
> +#else   /* CONFIG_THUMB2_KERNEL */
> +	.macro	get_thread_info, rd
> +	mov	\rd, sp
> +	lsr	\rd, \rd, #13
> +	mov	\rd, \rd, lsl #13
> +	.endm
> +#endif  /* !CONFIG_THUMB2_KERNEL */

We could even write some preempt_enable and preempt_disable asm macros,
I think it would simplify the code in the other files.

-- 
Catalin
