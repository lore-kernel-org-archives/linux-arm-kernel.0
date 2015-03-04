From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 4 Mar 2015 08:59:07 +0100
Subject: [PATCH] mfd: mt6397: Use set_irq_flags only on ARM
In-Reply-To: <1425453869-18482-1-git-send-email-s.hauer@pengutronix.de>
References: <1425453869-18482-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150304075907.GN7865@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

[Cc += tglx, rmk]

On Wed, Mar 04, 2015 at 08:24:29AM +0100, Sascha Hauer wrote:
> Continue the common pattern in MFD drivers and use set_irq_flags on ARM
> and irq_set_noprobe on other architectures. This fixes compilation on
> non ARM architecures.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> 
> Lee, feel free to squash this into the patch adding mt6397 core support.
> Alternatively I could also add some Kconfig dependency to compile this
> on ARM only if you are more comfortable with that.
> 
>  drivers/mfd/mt6397-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index b61c4eb..09bc780 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -121,7 +121,11 @@ static int mt6397_irq_domain_map(struct irq_domain *d, unsigned int irq,
>  	irq_set_chip_data(irq, mt6397);
>  	irq_set_chip_and_handler(irq, &mt6397_irq_chip, handle_level_irq);
>  	irq_set_nested_thread(irq, 1);
> +#ifdef CONFIG_ARM
>  	set_irq_flags(irq, IRQF_VALID);
> +#else
> +	irq_set_noprobe(irq);
> +#endif
While this is what everyone does, I wonder why ARM is special here.
Has this only historic reasons and needs refurbishment?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
