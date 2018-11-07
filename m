From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Nov 2018 21:59:12 +0000
Subject: [PATCH 4/7] arm64: Add fast-path for stack alignment
In-Reply-To: <1537970184-44348-5-git-send-email-julien.thierry@arm.com>
References: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
 <1537970184-44348-5-git-send-email-julien.thierry@arm.com>
Message-ID: <20181107215911.GF12248@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2018 at 02:56:21PM +0100, Julien Thierry wrote:
> Avoiding stack alignment for already aligned stack can give a small
> performance boost.
> 
> Branch out of the aligning code when the stack is known to be aligned.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> ---
>  arch/arm64/kernel/entry.S | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 8fb66e4..bd8d52c 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -61,6 +61,10 @@
>  
>  	.macro force_stack_align
>  	xchg_sp	x0
> +
> +	tst	x0, #0xf
> +	b.eq	0f
> +
>  	str	x1, [x0] // store x1 far away from S_SP
>  
>  	// aligned_sp[S_SP] = old_sp
> @@ -69,6 +73,11 @@
>  
>  	ldr	x1, [x0]
>  	bic	x0, x0, #0xf	// x0 = aligned_sp
> +	b	1f
> +
> +0:
> +	str	x0, [x0, #S_SP]
> +1:

I couldn't figure out a better way to do this, but please remove the empty
lines that you're adding here. With that:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
