From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 15 Sep 2014 19:11:01 +0100
Subject: [PATCH 04/13] arm64: Add new hcall HVC_CALL_FUNC
In-Reply-To: <ea28cfef061d06e86704845a877802e057749b39.1410302383.git.geoff@infradead.org>
References: <cover.1410302383.git.geoff@infradead.org>
 <ea28cfef061d06e86704845a877802e057749b39.1410302383.git.geoff@infradead.org>
Message-ID: <20140915181101.GE13789@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 11:49:04PM +0100, Geoff Levand wrote:
> Add the new hcall HVC_CALL_FUNC that allows execution of a function at EL2.
> During CPU reset the CPU must be brought to the exception level it had on
> entry to the kernel.  The HVC_CALL_FUNC hcall will provide the mechanism
> needed for this exception level switch.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/include/asm/virt.h | 11 +++++++++++
>  arch/arm64/kernel/hyp-stub.S  | 10 ++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> index 894fe53..b217fbc 100644
> --- a/arch/arm64/include/asm/virt.h
> +++ b/arch/arm64/include/asm/virt.h
> @@ -41,6 +41,17 @@
>  
>  #define HVC_KVM_CALL_HYP 3
>  
> +/*
> + * HVC_CALL_FUNC - Execute a function at EL2.
> + *
> + * @x0: Physical address of the funtion to be executed.
> + * @x1: Passed as the first argument to @fn.
> + * @x2: Passed as the second argument to @fn.
> + * @x3: Passed as the third argument to @fn.
> + */
> +
> +#define HVC_CALL_FUNC 4
> +

Can't we use the HVC_KVM_CALL_HYP for this as well? I thought we already
added the code to the stub to do that in the last patch.

Is there a difference between the two that I'm missing?

>  #ifndef __ASSEMBLY__
>  
>  /*
> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> index 9ab5f70..a21cf51 100644
> --- a/arch/arm64/kernel/hyp-stub.S
> +++ b/arch/arm64/kernel/hyp-stub.S
> @@ -75,7 +75,17 @@ el1_sync:
>  1:	cmp	x10, #HVC_SET_VECTORS
>  	b.ne	1f
>  	msr	vbar_el2, x0
> +	b	2f
>  
> +1:	cmp	x10, #HVC_CALL_FUNC
> +	b.ne    1f
> +	mov	x29, lr

What's the contract for functions we call through the stub?

If they can use all the caller-saved registers, then we need to stach
the original LR before issuing the HVC. Otherwise we can stash it in
x18 at EL2.

Thanks,
Mark.
