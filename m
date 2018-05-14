From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 14 May 2018 12:07:40 +0100
Subject: [PATCH 11/18] arm64: zero GPRs upon entry from EL0
In-Reply-To: <20180514094640.27569-12-mark.rutland@arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-12-mark.rutland@arm.com>
Message-ID: <20180514110738.GG7753@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 10:46:33AM +0100, Mark Rutland wrote:
> We can zero GPRs x0 - x29 upon entry from EL0 to make it harder for
> userspace to control values consumed by speculative gadgets.
> 
> We don't blat x30, since this is stashed much later, and we'll blat it
> before invoking C code.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/entry.S | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 13afefbf608f..4dd529fd03fd 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -62,6 +62,12 @@
>  #endif
>  	.endm
>  
> +	.macro	clear_gp_regs
> +	.irp	n,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29
> +	mov	x\n, xzr
> +	.endr
> +	.endm
> +

Looks OK, but consider moving _for from fpsimdmacros.h to assembler.h
and just writing

 _for n, 0, 29,	mov	x\n, xzr

(could even omit the wrapper macro, since this is a one-liner).

The implementation of _for is a bit gross, but since we already have it,
we might as well use it.

[...]

Cheers
---Dave
