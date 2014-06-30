From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 30 Jun 2014 12:12:27 +0800
Subject: [PATCH v2 2/2] ARM: imx53: globally disable supervisor protect
In-Reply-To: <1403694091-27247-2-git-send-email-s.trumtrar@pengutronix.de>
References: <1403694091-27247-1-git-send-email-s.trumtrar@pengutronix.de>
 <1403694091-27247-2-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20140630041226.GB3329@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 01:01:31PM +0200, Steffen Trumtrar wrote:
> Most peripherals on the i.MX53 have an
> 	Off-Platform Peripheral Access Control Register (OPACR)
> in which the access rights (together with the MPROT registers) can be declared.
> However, this does not seem to work for example for SSI1+SDMA, because the
> supervisor bit is not set for the SDMA unit.
> It does work for SSI2, the QSB for example uses SSI2 for its audio. But SSI2 only
> works because it does NOT have an OPACR.
> 
> The right solution would be to fix the access rights for the SDMA, but the unit
> responsible for this is the Central Security Unit (CSU), which of course is NOT
> documented. So, until documentation for this is openly available, turn off the
> supervisor protection because it cripples the hardware.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  arch/arm/mach-imx/mach-imx53.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
> index 2bad387..380c7ee 100644
> --- a/arch/arm/mach-imx/mach-imx53.c
> +++ b/arch/arm/mach-imx/mach-imx53.c
> @@ -15,6 +15,7 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> +#include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <asm/mach/arch.h>
> @@ -24,11 +25,24 @@
>  #include "hardware.h"
>  #include "mx53.h"
>  
> +static const struct of_device_id aips_of_matches[] __initconst = {
> +	{ .compatible = "fsl,imx53-aipstz" },
> +	{ /*sentinel*/ }
> +};
> +
>  static void __init imx53_dt_init(void)
>  {
> +	void __iomem *aips_base_addr;
> +	struct device_node *np;
> +
>  	mxc_arch_reset_init_dt();
>  
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +
> +	for_each_matching_node(np, aips_of_matches) {
> +		aips_base_addr = of_iomap(np, 0);
> +		imx_set_aips(aips_base_addr);
> +	}

The same code pattern might be needed for i.MX31 and i.MX35 device tree
support later.  Can we have a helper for it, so that i.MX3 DT conversion
can benefit from it?

Shawn

>  }
>  
>  static const char *imx53_dt_board_compat[] __initconst = {
> -- 
> 2.0.0
> 
