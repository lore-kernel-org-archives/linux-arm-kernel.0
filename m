From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 18 Jan 2012 11:20:55 +0100
Subject: [PATCH] Skip unnecessary pte makeup when clearing it.
In-Reply-To: <1326880345-17306-1-git-send-email-bill4carson@gmail.com>
References: <1326880345-17306-1-git-send-email-bill4carson@gmail.com>
Message-ID: <20120118102055.GV14252@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 05:52:25PM +0800, bill4carson at gmail.com wrote:
> From: Bill Carson <bill4carson@gmail.com>
> 
> If we are only about to clear a hardware pte entry, then pte makeup code is
> unnecessary for cpu_v7_set_pte_ext and armv6_set_pte_ext, so just skip it.
> 
> Signed-off-by: Bill Carson <bill4carson@gmail.com>
> ---
>  arch/arm/mm/proc-macros.S    |   10 +++++-----
>  arch/arm/mm/proc-v7-2level.S |   10 +++++-----
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> index 2d8ff3a..11288b3 100644
> --- a/arch/arm/mm/proc-macros.S
> +++ b/arch/arm/mm/proc-macros.S
> @@ -138,6 +138,10 @@
>  	.macro	armv6_set_pte_ext pfx
>  	str	r1, [r0], #2048			@ linux version
>  
> +	tst	r1, #L_PTE_YOUNG
> +	tstne	r1, #L_PTE_PRESENT
> +	moveq	r3, #0
> +	moveq	set_pte
>  	bic	r3, r1, #0x000003fc
>  	bic	r3, r3, #PTE_TYPE_MASK
>  	orr	r3, r3, r2
I guess you want

	beq	set_pte

instead of

	moveq	set_pte

here?!

Additionally this doesn't seem to be able to be compiled to thumb. I
don't know if it must be though.

> @@ -163,11 +167,7 @@
>  	orrne	r3, r3, #PTE_EXT_XN
>  
>  	orr	r3, r3, r2
> -
> -	tst	r1, #L_PTE_YOUNG
> -	tstne	r1, #L_PTE_PRESENT
> -	moveq	r3, #0
> -
> +set_pte:

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
