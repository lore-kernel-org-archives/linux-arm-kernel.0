From: rmallon@gmail.com (Ryan Mallon)
Date: Mon, 20 Feb 2012 11:22:30 +1100
Subject: [PATCH 04/18] ARM: at91: make ST (System Timer) soc independent
In-Reply-To: <957702b1ff83afcc0a8e842f53f05ff3f40b78b3.1329500622.git.nicolas.ferre@atmel.com>
References: <1329501010-30468-1-git-send-email-nicolas.ferre@atmel.com>
 <957702b1ff83afcc0a8e842f53f05ff3f40b78b3.1329500622.git.nicolas.ferre@atmel.com>
Message-ID: <4F419246.6080405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/02/12 04:49, Nicolas Ferre wrote:

> From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  arch/arm/mach-at91/at91rm9200.c              |    4 +-
>  arch/arm/mach-at91/at91rm9200_time.c         |   37 ++++++++++++++++----------
>  arch/arm/mach-at91/generic.h                 |    1 +
>  arch/arm/mach-at91/include/mach/at91_st.h    |   32 +++++++++++++++-------
>  arch/arm/mach-at91/include/mach/at91rm9200.h |    2 +-
>  drivers/watchdog/at91rm9200_wdt.c            |    8 +++---
>  6 files changed, 53 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c

Hi Jean, Nicolas,

Patch looks mostly good, couple of points below.

~Ryan

<snip>

>  	/* Cancel any pending alarm; flush any pending IRQ */
> -	at91_sys_write(AT91_ST_RTAR, alm);
> -	(void) at91_sys_read(AT91_ST_SR);
> +	at91_st_write(AT91_ST_RTAR, alm);
> +	(void) at91_st_read(AT91_ST_SR);


Can we please remove the (void) casting of the return value when making
this change, especially since at91_st_read is now a macro which doesn't
even have a return value. Same in a few other places.

>  
>  	/* Schedule alarm by writing RTAR. */
>  	alm += delta;
> -	at91_sys_write(AT91_ST_RTAR, alm);
> +	at91_st_write(AT91_ST_RTAR, alm);
>  
>  	return status;
>  }
> @@ -175,15 +175,24 @@ static struct clock_event_device clkevt = {
>  	.set_mode	= clkevt32k_mode,
>  };
>  
> +void __iomem *at91_st_base;
> +
> +void __init at91rm9200_ioremap_st(u32 addr)
> +{
> +	at91_st_base = ioremap(AT91RM9200_BASE_ST, 256);
> +	if (!at91_st_base)
> +		panic("Impossible to ioremap ST\n");
> +}


I can't see anything in this patch which calls this function? Also, why
is it extern? Can't it just be moved to whichever file is going to call
it and make it static there?
