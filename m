From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Sep 2014 18:07:40 +0100
Subject: [PATCH 04/13] arm64: Add new hcall HVC_CALL_FUNC
In-Reply-To: <ea28cfef061d06e86704845a877802e057749b39.1410302383.git.geoff@infradead.org>
References: <cover.1410302383.git.geoff@infradead.org>
 <ea28cfef061d06e86704845a877802e057749b39.1410302383.git.geoff@infradead.org>
Message-ID: <20140910170740.GE1710@arm.com>
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

[...]

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
> +	mov	lr, x0
> +	mov	x0, x1
> +	mov	x1, x2
> +	mov	x2, x3
> +	blr	lr
> +	mov	lr, x29

Why are you clobbering x29?

Will
