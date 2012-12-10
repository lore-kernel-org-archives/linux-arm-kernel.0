From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 10 Dec 2012 10:57:43 +0000
Subject: [PATCH] ARM: head: Remove boot-time HYP mode check for v5 and
 below
In-Reply-To: <1354887959-14863-1-git-send-email-dave.martin@linaro.org>
References: <1354887959-14863-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20121210105743.GA1953@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Do you want me to send this patch to the patch system?

Until we have confirmation from Marko (or someone else with a board)
there's no way to know whether it fixes the problem.  But it should
restore us back to the old behaviour older hardware, reducing the
likelihood of side issues.

This could be reverted later if it proves to be unnecessary.

Cheers
---Dave

On Fri, Dec 07, 2012 at 01:45:59PM +0000, Dave Martin wrote:
> The kernel can only be entered on HYP mode on CPUs which actually
> support it, i.e.  >= ARMv7.  pre-v6 platform support cannot coexist
> in the same kernel as support for v7 and higher, so there is no
> advantage in having the HYP mode check on pre-v6 hardware.
> 
> At least one pre-v6 board is known to fail when the HYP mode check
> code is present, although the exact cause remains unknown and may
> be unrelated.  [1]
> 
> This patch restores the old behaviour for pre-v6 platforms, whereby
> the CPSR is forced directly to SVC mode with IRQs and FIQs masked.
> All kernels capable of booting on v7 hardware will retain the
> check, so this should not impair functionality.
> 
> [1] http://lists.arm.linux.org.uk/lurker/message/20121130.013814.19218413.en.html
> ([ARM] head.S change broke platform device registration?)
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
>  arch/arm/include/asm/assembler.h |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 2ef9581..eb87200 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -250,6 +250,7 @@
>   * Beware, it also clobers LR.
>   */
>  .macro safe_svcmode_maskall reg:req
> +#if __LINUX_ARM_ARCH__ >= 6
>  	mrs	\reg , cpsr
>  	mov	lr , \reg
>  	and	lr , lr , #MODE_MASK
> @@ -266,6 +267,13 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
>  	__ERET
>  1:	msr	cpsr_c, \reg
>  2:
> +#else
> +/*
> + * workaround for possibly broken pre-v6 hardware
> + * (akita, Sharp Zaurus C-1000, PXA270-based)
> + */
> +	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, \reg
> +#endif
>  .endm
>  
>  /*
> -- 
> 1.7.4.1
> 
