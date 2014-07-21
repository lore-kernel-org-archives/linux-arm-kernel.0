From: marex@denx.de (Marek Vasut)
Date: Mon, 21 Jul 2014 18:07:00 +0200
Subject: [PATCH RFC 1/9] irqchip: gic: Provide support for interrupt
 grouping
In-Reply-To: <1405954040-30399-2-git-send-email-daniel.thompson@linaro.org>
References: <1405954040-30399-1-git-send-email-daniel.thompson@linaro.org>
 <1405954040-30399-2-git-send-email-daniel.thompson@linaro.org>
Message-ID: <201407211807.00119.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 21, 2014 at 04:47:12 PM, Daniel Thompson wrote:
> All GIC hardware except GICv1-without-TrustZone support provides a means
> to group exceptions into group 0 (which can optionally be signally using
> use FIQ) and group 1. The kernel currently provides no means to exploit
> this. This patch alters the initialization of the GIC to place all
> interrupts into group 1 which is the foundational requirement to
> meaningfully use FIQ.

[...]

> @@ -670,7 +753,11 @@ static void gic_raise_softirq(const struct cpumask
> *mask, unsigned int irq) dmb(ishst);
> 
>  	/* this always happens on GIC0 */
> -	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) +
> GIC_DIST_SOFTINT); +	softint = map << 16 | irq;
> +	if (gic_data_fiq_enable(&gic_data[0]))
> +		softint |= 0x8000;

These magic bits here could use some clarification, possibly a comment.

> +	writel_relaxed(softint,
> +		       gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
> 
>  	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
>  }
[...]

Best regards,
Marek Vasut
