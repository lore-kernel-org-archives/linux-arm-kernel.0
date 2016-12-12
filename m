From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 12 Dec 2016 16:06:36 +0100
Subject: [PATCH] arm64: Re-enable PAN on uaccess_enable
In-Reply-To: <1481550626-30956-1-git-send-email-marc.zyngier@arm.com>
References: <1481550626-30956-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20161212150636.GA7070@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2016 at 01:50:26PM +0000, Marc Zyngier wrote:
> Commit 4b65a5db3627 ("arm64: Introduce uaccess_{disable,enable}
> functionality based on TTBR0_EL1") added conditional PAN
> enable/disable. Unfortunately, a typo prevents PAN from being
> re-enabled once it has been disabled.
> 
> Restore the PAN functionnality by adding the missing '!'.
> 
> Fixes: b65a5db3627 ("arm64: Introduce uaccess_{disable,enable} functionality based on TTBR0_EL1")
> Reported-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> Christoffer, any chance you could give this a go and let me know
> if that fixes your issues?

Yep, fixes the issue.  Thanks!

-Christoffer

> 
>  arch/arm64/include/asm/uaccess.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 6986f56..d26750c 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -188,7 +188,7 @@ do {									\
>  
>  #define __uaccess_enable(alt)						\
>  do {									\
> -	if (uaccess_ttbr0_enable())					\
> +	if (!uaccess_ttbr0_enable())					\
>  		asm(ALTERNATIVE("nop", SET_PSTATE_PAN(0), alt,		\
>  				CONFIG_ARM64_PAN));			\
>  } while (0)
> -- 
> 2.1.4
> 
