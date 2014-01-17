From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 17 Jan 2014 10:50:29 -0800
Subject: [PATCH] ARM: Make pgtbl macro more robust
In-Reply-To: <1389015593-31716-1-git-send-email-cov@codeaurora.org>
References: <1389015593-31716-1-git-send-email-cov@codeaurora.org>
Message-ID: <20140117185029.GC13785@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06, Christopher Covington wrote:
> The pgtbl macro couldn't handle the specific
> (TEXT_OFFSET - PG_DIR_SIZE) value that the combination of
> MSM platforms and LPAE created:
> 
> head.S:163: Error: invalid constant (203000) after fixup
> 
> Regardless of whether this combination of configuration options
> will work on currently support platforms at run time, make it
> at least assemble properly.
> 
> Signed-off-by: Christopher Covington <cov@codeaurora.org>

Looks good to me.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

I think you can put it in the patch tracker. Russell?

> ---
>  arch/arm/kernel/head.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 9cf6063..af30cac 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -52,7 +52,8 @@
>  	.equ	swapper_pg_dir, KERNEL_RAM_VADDR - PG_DIR_SIZE
>  
>  	.macro	pgtbl, rd, phys
> -	add	\rd, \phys, #TEXT_OFFSET - PG_DIR_SIZE
> +	add	\rd, \phys, #TEXT_OFFSET
> +	sub	\rd, \rd, #PG_DIR_SIZE
>  	.endm
>  
>  /*

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
