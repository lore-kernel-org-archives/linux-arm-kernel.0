From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 24 Jul 2017 17:49:32 +0200
Subject: [PATCH] gpio: mvebu: Fix cause computation in irq handler
In-Reply-To: <20170712112229.858-1-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Wed, 12 Jul 2017 13:22:29 +0200")
References: <20170712112229.858-1-gregory.clement@free-electrons.com>
Message-ID: <874lu14yyb.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
 
 On mer., juil. 12 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> When switching to regmap, the way to compute the irq cause was
> reorganized. However while doing it, a typo was introduced: a 'xor'
> replaced a 'and'.
>
> This lead to wrong behavior in the interrupt handler ans one of the
> symptom was wrong irq handler called on the Armada 388 GP:
> "->handle_irq():  c016303c,
> handle_bad_irq+0x0/0x278
> ->irq_data.chip(): c0b0ec0c,
> 0xc0b0ec0c
> ->action():   (null)
>    IRQ_NOPROBE set
>  IRQ_NOREQUEST set
> unexpected IRQ trap at vector 00
> irq 0, desc: ee804800, depth: 1, count: 0, unhandled: 0"
>
> Fixes: 2233bf7a92e7 ("gpio: mvebu: switch to regmap for register access")
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Would it be possible to push this fix on the current kernel (v4.13-rc) ?

Indeed currently due to this bug, the Armada 388 GP board does not boot
anymore because this board uses a gpio interrupt. So it prevents to have
continuous integration on this one with kci for instance.

Thanks,

Gregory


> ---
>  drivers/gpio/gpio-mvebu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index e338c3743562..45c65f805fd6 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -557,7 +557,7 @@ static void mvebu_gpio_irq_handler(struct irq_desc *desc)
>  	edge_cause = mvebu_gpio_read_edge_cause(mvchip);
>  	edge_mask  = mvebu_gpio_read_edge_mask(mvchip);
>  
> -	cause = (data_in ^ level_mask) | (edge_cause & edge_mask);
> +	cause = (data_in & level_mask) | (edge_cause & edge_mask);
>  
>  	for (i = 0; i < mvchip->chip.ngpio; i++) {
>  		int irq;
> -- 
> 2.13.2
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
