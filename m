From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 3 Aug 2010 09:36:27 +0200
Subject: [PATCHv2] fix Thumb-2 decompressor broken by "Auto calculate
	ZRELADDR"
In-Reply-To: <1280796006-32028-1-git-send-email-rabin@rab.in>
References: <20100731125009.GA15412@pengutronix.de>
	<1280796006-32028-1-git-send-email-rabin@rab.in>
Message-ID: <20100803073627.GA17297@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Rabin,

On Tue, Aug 03, 2010 at 06:10:06AM +0530, Rabin Vincent wrote:
> "ARM: Auto calculate ZRELADDR and provide option for exceptions" broke
> the Thumb-2 decompressor because it removed an entry in the LC0 table
> but didn't adjust the offset the Thumb-2 code uses to load the SP from
> that table.
> 
> Fix it, and also change the ARM code to use the separate SP-load since
> ARM instructions that include the SP in the LDM register list are
> deprecated.
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>
Acked-and-regretted-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

> ---
> v2: don't need separate code for ARM and THUMB since they're now
>     the same.
> 
>  arch/arm/boot/compressed/head.S |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index abf4d65..6af9907 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -170,9 +170,8 @@ not_angel:
>  
>  		.text
>  		adr	r0, LC0
> - ARM(		ldmia	r0, {r1, r2, r3, r5, r6, r11, ip, sp})
> - THUMB(		ldmia	r0, {r1, r2, r3, r5, r6, r11, ip}	)
> - THUMB(		ldr	sp, [r0, #32]				)
> +		ldmia	r0, {r1, r2, r3, r5, r6, r11, ip}
> +		ldr	sp, [r0, #28]
>  #ifdef CONFIG_AUTO_ZRELADDR
>  		@ determine final kernel image address
>  		and	r4, pc, #0xf8000000
> -- 
> 1.7.1
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
