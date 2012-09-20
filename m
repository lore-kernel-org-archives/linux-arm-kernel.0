From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 20 Sep 2012 14:28:14 -0400 (EDT)
Subject: [PATCH 1/4] ARM: mm: use pteval_t to represent page protection
 values
In-Reply-To: <1348156605-30398-2-git-send-email-will.deacon@arm.com>
References: <1348156605-30398-1-git-send-email-will.deacon@arm.com>
 <1348156605-30398-2-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.02.1209201422230.6667@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Sep 2012, Will Deacon wrote:

> When updating the page protection map after calculating the user_pgprot
> value, the base protection map is temporarily stored in an unsigned long
> type, causing truncation of the protection bits when LPAE is enabled.
> This effectively means that calls to mprotect() will corrupt the upper
> page attributes, clearing the XN bit unconditionally.
> 
> This patch uses pteval_t to store the intermediate protection values,
> preserving the upper bits for 64-bit descriptors.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

Maybe CC to stable?

Are you sure there are no other occurences of this elsewhere?  
Unfortunately, STRICT_MM_TYPECHECKS can't help here.

> ---
>  arch/arm/mm/mmu.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index c2fa21d..b68b531 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -498,7 +498,7 @@ static void __init build_mem_type_table(void)
>  #endif
>  
>  	for (i = 0; i < 16; i++) {
> -		unsigned long v = pgprot_val(protection_map[i]);
> +		pteval_t v = pgprot_val(protection_map[i]);
>  		protection_map[i] = __pgprot(v | user_pgprot);
>  	}
>  
> -- 
> 1.7.4.1
> 
