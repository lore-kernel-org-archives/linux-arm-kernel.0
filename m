From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 May 2014 16:00:23 +0100
Subject: [RFC v2 01/10] arm: fiq: Allow EOI to be communicated to the intc
In-Reply-To: <1400853478-5824-2-git-send-email-daniel.thompson@linaro.org>
References: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
 <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
 <1400853478-5824-2-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20140523150022.GW3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 02:57:49PM +0100, Daniel Thompson wrote:
> +void eoi_fiq(int fiq)
> +{
> +	struct irq_data *irq_data = irq_get_irq_data(fiq + fiq_start);
> +	struct irq_chip *chip = irq_data_get_irq_chip(irq_data);
> +
> +	if (chip->irq_eoi)
> +			chip->irq_eoi(irq_data);
> +}

So what if the IRQ chip takes a spinlock?  You can't take spinlocks in
FIQ context...  Who checks for that kind of stuff - just hoping that
the IRQ driver doesn't take a spinlock sounds real fragile.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
