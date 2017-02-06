From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 6 Feb 2017 13:40:39 +0000
Subject: IRQ masking hierarchy with GIC as the root
In-Reply-To: <1486383720.2275.22.camel@pengutronix.de>
References: <1486383720.2275.22.camel@pengutronix.de>
Message-ID: <158e22d4-9864-a788-d4fd-576b3531ae22@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/17 12:22, Lucas Stach wrote:
> Hi Marc and others,
> 
> in the conversion of the old GIC arch_extension to proper stacked IRQ
> domain chips you added calls to irq_chip_mask_parent() to both the Tegra
> LIC (drivers/irqchip/irq-tegra.c) and the i.MX GPC
> (arch/arm/mach-imx/gpc.c).
> 
> Both IRQ controllers should be able to mask the IRQ on their own,
> meaning the IRQ will not reach the GIC if it is masked at this hierarchy
> level. Is it safe to remove the the call to mask the IRQ at the GIC
> level, or is there something more to it that I don't (yet) see?

It should be safe, as long as you can guarantee that the LIC (resp. the
GPC) is always active between the device and the GIC (it never goes in
some bypass mode). If that condition holds, you can then cut it short.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
