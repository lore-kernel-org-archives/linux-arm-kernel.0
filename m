From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 10 May 2013 16:17:10 +0200
Subject: [PATCH 3/3] ARM: versatile: Make able to use UART ports for
 KGDB FIQ debugger
In-Reply-To: <1368144651-11250-4-git-send-email-john.stultz@linaro.org>
References: <1368144651-11250-1-git-send-email-john.stultz@linaro.org>
 <1368144651-11250-4-git-send-email-john.stultz@linaro.org>
Message-ID: <20130510161710.45b18866@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear John Stultz,

On Thu,  9 May 2013 17:10:51 -0700, John Stultz wrote:

> +static void kgdb_fiq_select(bool on)
> +{
> +	void __iomem *sel = kgdb_irq_base + VIC_INT_SELECT;
> +	u32 msk = 1 << kgdb_irq;
> +	u32 val;
> +
> +	pr_debug("rerouting VIC vector %d to %s\n", kgdb_irq,
> +		 on ? "FIQ" : "IRQ");
> +
> +	val = readl(sel);
> +	val &= ~msk;
> +	if (on)
> +		val |= msk;
> +	writel(val, sel);
> +}
> +
> +static bool kgdb_is_fiq_rised(void)

Shouldn't this function be kgdb_is_fiq_raised() ?

> +{
> +	return readl(kgdb_irq_base + VIC_FIQ_STATUS) & (1 << kgdb_irq);
> +}
> +
> +static int __init kgdb_fiq_init(void)
> +{
> +	kgdb_irq_base = __io_address(VERSATILE_VIC_BASE);
> +	kgdb_irq += INT_UARTINT0;
> +	WARN_ON(kgdb_irq > INT_UARTINT2);
> +
> +	return kgdb_register_fiq(kgdb_fiq_select, kgdb_is_fiq_rised);
> +}
> +console_initcall(kgdb_fiq_init);

Also, this code that uses hardcoded addresses and IRQ numbers doesn't
seem to play really well with the DT. I was considering toying around
with this thing on the mach-mvebu platform, but don't have those
hardcoded addresses and IRQs, and the register offsets of the IRQ
controller driver are not exposed in an header file. Shouldn't IRQ
controller driver be exposing a the fiq_select() functionality instead?
Like a new flag for irq_chip->irq_set_type(), or a completely new hook
irq_chip->irq_set_mode() or something like that?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
