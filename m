From: pkondeti@codeaurora.org (Pavan Kondeti)
Date: Thu, 18 Nov 2010 16:45:27 +0530
Subject: [PATCH v3 2/2] msm: gpio: Add irq support to v2 gpiolib.
In-Reply-To: <1289943516-11367-2-git-send-email-gbean@codeaurora.org>
References: <1289943516-11367-1-git-send-email-gbean@codeaurora.org>
	<1289943516-11367-2-git-send-email-gbean@codeaurora.org>
Message-ID: <20101118111527.GD11700@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Tue, Nov 16, 2010 at 01:38:36PM -0800, Gregory Bean wrote:
> Complete the MSM v2 gpio subsystem by adding irq_chip.
> 
> Signed-off-by: Gregory Bean <gbean@codeaurora.org>
> ---
>  arch/arm/mach-msm/gpio-v2.c |  344 ++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 326 insertions(+), 18 deletions(-)
> 
>  
> +#ifdef CONFIG_PM
> +static int msm_gpio_suspend_noirq(struct device *dev)
> +{
> +	unsigned long irq_flags;
> +	unsigned long i;
> +
> +	spin_lock_irqsave(&tlmm_lock, irq_flags);
> +	for_each_set_bit(i, msm_gpio.enabled_irqs, NR_GPIO_IRQS) {
> +		if (!test_bit(i, msm_gpio.wake_irqs))
> +			writel(TARGET_PROC_NONE, GPIO_INTR_CFG_SU(i));
> +	}
If none of the enabled irqs is configured as a wakeup source, should not we
disable the summary IRQ?
> +	spin_unlock_irqrestore(&tlmm_lock, irq_flags);
> +	return 0;
> +}
> +
> +static int msm_gpio_resume_noirq(struct device *dev)
> +{
> +	unsigned long irq_flags;
> +	unsigned long i;
> +
> +	spin_lock_irqsave(&tlmm_lock, irq_flags);
> +	for_each_set_bit(i, msm_gpio.enabled_irqs, NR_GPIO_IRQS)
> +		writel(TARGET_PROC_SCORPION, GPIO_INTR_CFG_SU(i));
> +	spin_unlock_irqrestore(&tlmm_lock, irq_flags);
> +	return 0;
> +}
> +#else
> +#define msm_gpio_suspend_noirq NULL
> +#define msm_gpio_resume_noirq NULL
> +#endif
> +
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
