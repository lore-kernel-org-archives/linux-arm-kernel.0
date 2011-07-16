From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 16 Jul 2011 11:58:37 +0900
Subject: [PATCH 3/4] ARM: samsung: Check NULL return from
	irq_alloc_generic_chip
In-Reply-To: <1310510305-4540-1-git-send-email-toddpoynor@google.com>
References: <1310510305-4540-1-git-send-email-toddpoynor@google.com>
Message-ID: <034e01cc4364$44048800$cc0d9800$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Todd Poynor wrote:
> 
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
>  arch/arm/plat-samsung/irq-uart.c      |    7 +++++++
>  arch/arm/plat-samsung/irq-vic-timer.c |    7 +++++++
>  2 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/irq-uart.c
b/arch/arm/plat-samsung/irq-uart.c
> index 32582c0..38c5364 100644
> --- a/arch/arm/plat-samsung/irq-uart.c
> +++ b/arch/arm/plat-samsung/irq-uart.c
> @@ -54,6 +54,13 @@ static void __init s3c_init_uart_irq(struct
s3c_uart_irq *uirq)
> 
>  	gc = irq_alloc_generic_chip("s3c-uart", 1, uirq->base_irq, reg_base,
>  				    handle_level_irq);
> +
> +	if (!gc) {
> +		pr_err("%s: irq_alloc_generic_chip for IRQ %u failed\n",
> +		       __func__, uirq->base_irq);
> +		return;
> +	}
> +
>  	ct = gc->chip_types;
>  	ct->chip.irq_ack = irq_gc_ack;
>  	ct->chip.irq_mask = irq_gc_mask_set_bit;
> diff --git a/arch/arm/plat-samsung/irq-vic-timer.c
b/arch/arm/plat-samsung/irq-vic-
> timer.c
> index a607546..f714d06 100644
> --- a/arch/arm/plat-samsung/irq-vic-timer.c
> +++ b/arch/arm/plat-samsung/irq-vic-timer.c
> @@ -54,6 +54,13 @@ void __init s3c_init_vic_timer_irq(unsigned int num,
> unsigned int timer_irq)
> 
>  	s3c_tgc = irq_alloc_generic_chip("s3c-timer", 1, timer_irq,
>  					 S3C64XX_TINT_CSTAT,
> handle_level_irq);
> +
> +	if (!s3c_tgc) {
> +		pr_err("%s: irq_alloc_generic_chip for IRQ %d failed\n",
> +		       __func__, timer_irq);
> +		return;
> +	}
> +
>  	ct = s3c_tgc->chip_types;
>  	ct->chip.irq_mask = irq_gc_mask_clr_bit;
>  	ct->chip.irq_unmask = irq_gc_mask_set_bit;
> --
> 1.7.3.1

Looks good to me, will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
