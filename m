From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 20 Sep 2017 13:47:26 +0100
Subject: [PATCH v2] bootwrapper: SVE: Enable SVE for EL2 and below
In-Reply-To: <1505909388-13513-1-git-send-email-Dave.Martin@arm.com>
References: <1505909388-13513-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170920124726.GA26836@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 01:09:48PM +0100, Dave Martin wrote:
> By default, SVE will trap to EL3.  We also want to make sure that
> lower ELs have access to the full SVE vector length before dropping
> down.
> 
> This patch programs CPTR_EL3 and ZCR_EL3 appropriately to enable
> SVE for lower exception levels and make sure that they can use the
> full vector length provided by the hardware.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alex Benn?e <alex.bennee@linaro.org>

This looks fine, builds with my toolchain collection, and I assume
you've boot-tested this.

I've pushed this out now.

Thanks,
Mark.

> ---
> 
> This is basically the same as v1 [1], but rebased to an up-to-date
> bootwrapper tree.  (I was previously tracking Catalin's tree, which no
> longer exists...)
> 
> [1] [PATCH] bootwrapper: SVE: Enable SVE for EL2 and below
> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-August/527000.html
> 
> 
>  arch/aarch64/boot.S            | 13 +++++++++++++
>  arch/aarch64/include/asm/cpu.h |  5 +++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/aarch64/boot.S b/arch/aarch64/boot.S
> index ceeee76..f7d795a 100644
> --- a/arch/aarch64/boot.S
> +++ b/arch/aarch64/boot.S
> @@ -45,6 +45,19 @@ _start:
>  
>  	msr	cptr_el3, xzr			// Disable copro. traps to EL3
>  
> +	mrs	x0, id_aa64pfr0_el1
> +	ubfx	x0, x0, #32, #4			// SVE present?
> +	cbz	x0, 1f				// Skip SVE init if not
> +
> +	mrs	x0, cptr_el3
> +	orr	x0, x0, #CPTR_EL3_EZ		// enable SVE
> +	msr	cptr_el3, x0
> +	isb
> +
> +	mov	x0, #ZCR_EL3_LEN_MASK		// SVE: Enable full vector len
> +	msr	ZCR_EL3, x0			// for EL2.
> +
> +1:
>  	ldr	x0, =CNTFRQ
>  	msr	cntfrq_el0, x0
>  
> diff --git a/arch/aarch64/include/asm/cpu.h b/arch/aarch64/include/asm/cpu.h
> index 66726ef..ccb5397 100644
> --- a/arch/aarch64/include/asm/cpu.h
> +++ b/arch/aarch64/include/asm/cpu.h
> @@ -27,6 +27,11 @@
>  #define SPSR_EL2H		(9 << 0)	/* EL2 Handler mode */
>  #define SPSR_HYP		(0x1a << 0)	/* M[3:0] = hyp, M[4] = AArch32 */
>  
> +#define CPTR_EL3_EZ		(1 << 8)
> +
> +#define ZCR_EL3			s3_6_c1_c2_0
> +#define ZCR_EL3_LEN_MASK	0x1ff
> +
>  #define SCTLR_EL1_CP15BEN	(1 << 5)
>  #define SCTLR_EL1_RES1		(3 << 28 | 3 << 22 | 1 << 11)
>  
> -- 
> 2.1.4
> 
