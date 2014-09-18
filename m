From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Sep 2014 09:17:39 +0100
Subject: [PATCH 3.17-rc4 v7 4/6] irqchip: gic: Add support for IPI FIQ
In-Reply-To: <1410970218-28847-5-git-send-email-daniel.thompson@linaro.org>
References: <1410970218-28847-1-git-send-email-daniel.thompson@linaro.org>
 <1410970218-28847-5-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20140918081739.GA5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 09:10:16AM -0700, Daniel Thompson wrote:
> @@ -604,8 +731,19 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>  {
>  	int cpu;
>  	unsigned long flags, map = 0;
> +	unsigned long softint;
>  
> -	raw_spin_lock_irqsave(&irq_controller_lock, flags);
> +	/*
> +	 * The locking in this function ensures we don't use stale cpu mappings
> +	 * and thus we never route an IPI to the wrong physical core during a
> +	 * big.LITTLE switch. The switch code takes both of these locks meaning
> +	 * we can choose whichever lock is safe to use from our current calling
> +	 * context.
> +	 */
> +	if (in_nmi())
> +		raw_spin_lock(&fiq_safe_migration_lock);
> +	else
> +		raw_spin_lock_irqsave(&irq_controller_lock, flags);

BTW, I see this code is still here...

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
