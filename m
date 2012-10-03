From: will.deacon@arm.com (Will Deacon)
Date: Wed, 3 Oct 2012 10:42:48 +0100
Subject: [PATCH] ARM: proc-v7: Ensure correct instruction set after
 cpu_reset
In-Reply-To: <1349256170-4367-1-git-send-email-dave.martin@linaro.org>
References: <1349256170-4367-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20121003094248.GG22445@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 03, 2012 at 10:22:50AM +0100, Dave Martin wrote:
> Because mov pc,<Rn> never switches instruction set when executed in
> Thumb code, Thumb-2 kernels will silently execute the target code
> after cpu_reset as Thumb code, even if the passed code pointer
> denotes ARM (bit 0 clear).
> 
> This patch uses bx instead, ensuring the correct instruction set
> for the target code.
> 
> Thumb code in the kernel is not supported prior to ARMv7, so other
> CPUs are not affected.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
>  arch/arm/mm/proc-v7.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

I pondered why kexec was working, but we have the following in the
purgatory code:

	/* Jump to relocated kernel */
	mov lr,r1
	mov r0,#0
	ldr r1,kexec_mach_type
	ldr r2,kexec_boot_atags
 ARM(	mov pc, lr	)
 THUMB(	bx lr		)

> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index c2e2b66..ca5b575 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -57,7 +57,7 @@ ENTRY(cpu_v7_reset)
>   THUMB(	bic	r1, r1, #1 << 30 )		@ SCTLR.TE (Thumb exceptions)
>  	mcr	p15, 0, r1, c1, c0, 0		@ disable MMU
>  	isb
> -	mov	pc, r0
> +	bx	r0
>  ENDPROC(cpu_v7_reset)
>  	.popsection

So this looks fine to me:

Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
