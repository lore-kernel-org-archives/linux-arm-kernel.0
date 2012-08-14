From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 14 Aug 2012 04:28:30 +0200
Subject: [PATCH] ARM: at91: fix drivers broken because of sparse irq
 support
In-Reply-To: <1344872334-1532-2-git-send-email-ludovic.desroches@atmel.com>
References: <1344872334-1532-1-git-send-email-ludovic.desroches@atmel.com>
 <1344872334-1532-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20120814022830.GB8836@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:38 Mon 13 Aug     , ludovic.desroches at atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Some drivers directly use AT91_ID_SYS as virq so they are broken because of
> the NR_IRQS_LEGACY virq offset introduced with sparse irq support.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Cc: stable at vger.kernel.org
> ---
>  arch/arm/mach-at91/at91rm9200_time.c |  2 +-
>  drivers/rtc/rtc-at91sam9.c           | 11 ++++++-----
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
> index 104ca40..aaa443b 100644
> --- a/arch/arm/mach-at91/at91rm9200_time.c
> +++ b/arch/arm/mach-at91/at91rm9200_time.c
> @@ -197,7 +197,7 @@ void __init at91rm9200_timer_init(void)
>  	at91_st_read(AT91_ST_SR);
>  
>  	/* Make IRQs happen for the system timer */
> -	setup_irq(AT91_ID_SYS, &at91rm9200_timer_irq);
> +	setup_irq(NR_IRQS_LEGACY + AT91_ID_SYS, &at91rm9200_timer_irq);
>  
>  	/* The 32KiHz "Slow Clock" (tick every 30517.58 nanoseconds) is used
>  	 * directly for the clocksource and all clockevents, after adjusting
> diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
> index 8318689..2969047 100644
> --- a/drivers/rtc/rtc-at91sam9.c
> +++ b/drivers/rtc/rtc-at91sam9.c
> @@ -345,11 +345,12 @@ static int __devinit at91_rtc_probe(struct platform_device *pdev)
>  	}
>  
>  	/* register irq handler after we know what name we'll use */
> -	ret = request_irq(AT91_ID_SYS, at91_rtc_interrupt,
> +	ret = request_irq(NR_IRQS_LEGACY + AT91_ID_SYS, at91_rtc_interrupt,
the irq need to be pass by resources and not hardcoded

Best Regrds,
J.
