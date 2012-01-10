From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 10 Jan 2012 10:39:05 +0000
Subject: [PATCH v2] irqdomain: Initialize number of IRQs for simple domains
In-Reply-To: <1326191059-26411-1-git-send-email-thierry.reding@avionic-design.de>
References: <1326191059-26411-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120110103905.GC3226@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On Tue, Jan 10, 2012 at 11:24:11AM +0100, Thierry Reding wrote:
> The irq_domain_add() function needs the number of interrupts in the
> domain to properly initialize them. In addition the allocated domain
> is now returned by the irq_domain_{add,generate}_simple() helpers.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: David Brown <davidb@codeaurora.org>
> ---
> Note: This patch should not be applied yet. There is a conflict with a
>       pending patch[0] by Benoit Cousson that will obsolete the OMAP2
>       hunk in this patch.
> 
>       [0]: http://www.spinics.net/lists/linux-omap/msg62124.html

I also have a patch in Russell's tracker to remove one of the calls for 
versatile (for the VIC) that is no longer needed.

> diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
> index e6bad17..811ce88 100644
> --- a/arch/arm/mach-imx/imx51-dt.c
> +++ b/arch/arm/mach-imx/imx51-dt.c
> @@ -47,7 +47,12 @@ static const struct of_dev_auxdata imx51_auxdata_lookup[] __initconst = {
>  static int __init imx51_tzic_add_irq_domain(struct device_node *np,
>  				struct device_node *interrupt_parent)
>  {
> -	irq_domain_add_simple(np, 0);
> +	struct irq_domain *domain;
> +
> +	domain = irq_domain_add_simple(np, 0, TZIC_NUM_IRQS);
> +	if (!domain)
> +		return -ENOMEM;
> +
>  	return 0;
>  }

A real nit, but could this be written as:

	return irq_domain_add_simple(np, 0, TZIC_NUM_IRQS) ? 0 : -ENOMEM;

to make it a little more concise (and the same for the others)?  Not a 
big deal though, so either way:

Reviewed-by: Jamie Iles <jamie@jamieiles.com>

Jamie
