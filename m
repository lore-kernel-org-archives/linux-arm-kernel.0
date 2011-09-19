From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Sep 2011 19:22:58 -0400 (EDT)
Subject: [PATCH] arm: Add unwinding annotations for 64bit division
	functions
In-Reply-To: <1316470297-5063-1-git-send-email-lauraa@codeaurora.org>
References: <1316470297-5063-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <alpine.LFD.2.00.1109191913210.12663@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Sep 2011, Laura Abbott wrote:

> The 64bit division functions never had unwinding annotations
> added. This prevents a backtrace from being printed within
> the function and if a division by 0 occurs. Add the annotations.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
>  arch/arm/lib/div64.S |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/lib/div64.S b/arch/arm/lib/div64.S
> index faa7748..e55c484 100644
> --- a/arch/arm/lib/div64.S
> +++ b/arch/arm/lib/div64.S
> @@ -13,6 +13,7 @@
>   */
>  
>  #include <linux/linkage.h>
> +#include <asm/unwind.h>
>  
>  #ifdef __ARMEB__
>  #define xh r0
> @@ -44,6 +45,7 @@
>   */
>  
>  ENTRY(__do_div64)
> +UNWIND(.fnstart)
>  
>  	@ Test for easy paths first.
>  	subs	ip, r4, #1
> @@ -189,7 +191,12 @@ ENTRY(__do_div64)
>  	moveq	yh, xh
>  	moveq	xh, #0
>  	moveq	pc, lr
> +UNWIND(.fnend)
>  
> +UNWIND(.fnstart)
> +UNWIND(.pad #4)
> +UNWIND(.save {lr})
> +Ldiv0_64:

Why this phony fnend+fnstart here?


Nicolas
