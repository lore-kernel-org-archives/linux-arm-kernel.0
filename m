From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Mar 2013 22:00:46 +0000
Subject: [PATCH v5 7/7] irqchip: s3c24xx: add devicetree support
In-Reply-To: <201303252234.21314.heiko@sntech.de>
References: <201303252226.21402.heiko@sntech.de>
 <201303252234.21314.heiko@sntech.de>
Message-ID: <201303252200.46258.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 March 2013, Heiko St?bner wrote:
> Add the necessary code to initialize the interrupt controller
> thru devicetree data using the irqchip infrastructure.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

The binding looks fine now. I have a few detail comments but am happy
with the series otherwise.

> +Required properties:
> +- compatible: Compatible property value should be "samsung,s3c24xx-irq"
> +  for non s3c2416 machines and "samsung,s3c2416-irq" for s3c2416 machines

We try to avoid wildcards in the "compatible" properties. Better use
the name of the first SoC that had this controller, and let the other
ones mark themselves as compatible with that one.

I guess "samsung,s3c2410-irq" would be the right identifier here.

> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value shall be 4 and interrupt descriptor shall
> +  have the following format:
> +      <ctrl_num ctrl_irq parent_irq type>
> +
> +  ctrl_num contains the controller to use:
> +      - 0 ... main controller
> +      - 1 ... sub controller
> +      - 2 ... second main controller on s3c2416 and s3c2450
> +  ctrl_irq contains the interrupt bit of the controller
> +  parent_irq contains the parent bit in the main controller and will be
> +             ignored in main controllers

I expected the second and third cell to be in the opposite order, so
the meaning of the second cell is always the same.

> +	/* we're using individual domains for the non-dt case
> +	 * and one big domain for the dt case where the subintc
> +	 * starts at hwirq number 32.
> +	 */
> +	offset = (intc->domain->of_node) ? 32 : 0;

Wouldn't it be easier to always use the same setup for the domains here?

	Arnd
