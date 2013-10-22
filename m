From: tony@atomide.com (Tony Lindgren)
Date: Tue, 22 Oct 2013 07:55:29 -0700
Subject: [PATCH] ARM: omap2: irq, AM33XX add missing register check
In-Reply-To: <1381994318-10207-1-git-send-email-mpa@pengutronix.de>
References: <1381994318-10207-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20131022145529.GM15154@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Markus Pargmann <mpa@pengutronix.de> [131017 00:19]:
> am33xx has a INTC_PENDING_IRQ3 register that is not checked for pending
> interrupts. This patch adds AM33XX to the ifdef of SOCs that have to
> check this register.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Thanks, it seems this can wait for the merge window, but I'll also add cc
stable to it as it can save some duplicate debugging for people.

So I'll apply this into omap-for-v3.13/fixes-not-urgent.

Regards,

Tony

> ---
>  arch/arm/mach-omap2/irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index 3926f37..e022a86 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -233,7 +233,7 @@ static inline void omap_intc_handle_irq(void __iomem *base_addr, struct pt_regs
>  			goto out;
>  
>  		irqnr = readl_relaxed(base_addr + 0xd8);
> -#ifdef CONFIG_SOC_TI81XX
> +#if IS_ENABLED(CONFIG_SOC_TI81XX) || IS_ENABLED(CONFIG_SOC_AM33XX)
>  		if (irqnr)
>  			goto out;
>  		irqnr = readl_relaxed(base_addr + 0xf8);
> -- 
> 1.8.4.rc3
> 
