From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Sep 2014 20:40:47 +0100
Subject: [PATCH v11 11/19] irqchip: vic: Add support for FIQ management
In-Reply-To: <1409662853-29313-12-git-send-email-daniel.thompson@linaro.org>
References: <1408466769-20004-1-git-send-email-daniel.thompson@linaro.org>
 <1409662853-29313-1-git-send-email-daniel.thompson@linaro.org>
 <1409662853-29313-12-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20140902194047.GY30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 02:00:45PM +0100, Daniel Thompson wrote:
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index bda5a91..8821160 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -502,13 +502,17 @@ static void __init gic_init_fiq(struct gic_chip_data *gic,
>  /*
>   * Fully acknowledge (both ack and eoi) a FIQ-based IPI
>   */
> -static int gic_handle_fiq_ipi(struct notifier_block *nb, unsigned long regs,
> -			   void *data)
> +void gic_handle_fiq_ipi(void)
>  {
>  	struct gic_chip_data *gic = &gic_data[0];
> -	void __iomem *cpu_base = gic_data_cpu_base(gic);
> +	void __iomem *cpu_base;
>  	unsigned long irqstat, irqnr;
>  
> +	if (!gic || !gic->fiq_enable)
> +		return;
> +
> +	cpu_base = gic_data_cpu_base(gic);
> +
>  	if (WARN_ON(!in_nmi()))
>  		return NOTIFY_BAD;
>  
> @@ -525,13 +529,6 @@ static int gic_handle_fiq_ipi(struct notifier_block *nb, unsigned long regs,
>  
>  	return NOTIFY_OK;
>  }
> -
> -/*
> - * Notifier to ensure IPI FIQ is acknowledged correctly.
> - */
> -static struct notifier_block gic_fiq_ipi_notifier = {
> -	.notifier_call = gic_handle_fiq_ipi,
> -};
>  #else /* CONFIG_FIQ */
>  static inline void gic_set_group_irq(void __iomem *base, unsigned int hwirq,
>  				     int group) {}
> @@ -1250,10 +1247,6 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>  #ifdef CONFIG_SMP
>  		set_smp_cross_call(gic_raise_softirq);
>  		register_cpu_notifier(&gic_cpu_notifier);
> -#ifdef CONFIG_FIQ
> -		if (gic_data_fiq_enable(gic))
> -			register_fiq_nmi_notifier(&gic_fiq_ipi_notifier);
> -#endif
>  #endif
>  		set_handle_irq(gic_handle_irq);
>  	}

Shouldn't this be merged into some other patch?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
