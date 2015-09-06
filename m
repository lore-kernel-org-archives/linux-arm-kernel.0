From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 6 Sep 2015 15:22:45 +0800
Subject: [PATCH] ARM: ls1021a: add platform notifier for dma-coherent
 requirement
In-Reply-To: <1438941719-38350-1-git-send-email-b18965@freescale.com>
References: <1438941719-38350-1-git-send-email-b18965@freescale.com>
Message-ID: <20150906072245.GG30746@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 07, 2015 at 06:01:59PM +0800, Alison Wang wrote:
> This patch adds platform notifier for dma-coherent requirement.
> Structure arm_coherent_dma_ops is used instead of arm_dma_ops.
> 
> Signed-off-by: Alison Wang <alison.wang@freescale.com>
> ---
>  arch/arm/mach-imx/mach-ls1021a.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/mach-ls1021a.c b/arch/arm/mach-imx/mach-ls1021a.c
> index b89c858..6bfc71b 100644
> --- a/arch/arm/mach-imx/mach-ls1021a.c
> +++ b/arch/arm/mach-imx/mach-ls1021a.c
> @@ -7,10 +7,39 @@
>   * (at your option) any later version.
>   */
>  
> +#include <linux/dma-mapping.h>
> +#include <linux/of_platform.h>
>  #include <asm/mach/arch.h>
>  
>  #include "common.h"
>  
> +static int ls1021a_platform_notifier(struct notifier_block *nb,
> +				  unsigned long event, void *__dev)
> +{
> +	struct device *dev = __dev;
> +
> +	if (event != BUS_NOTIFY_ADD_DEVICE)
> +		return NOTIFY_DONE;
> +
> +	if (of_device_is_compatible(dev->of_node, "fsl,etsec2"))
> +		set_dma_ops(dev, &arm_coherent_dma_ops);

Why cannot you simply add property dma-coherent for etsec2 node in
device tree?  In that case, of_dma_configure() will just do the job from
of_platform_device_create_pdata().

Shawn

> +	else if (of_property_read_bool(dev->of_node, "dma-coherent"))
> +		set_dma_ops(dev, &arm_coherent_dma_ops);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block ls1021a_platform_nb = {
> +	.notifier_call = ls1021a_platform_notifier,
> +};
> +
> +static void __init ls1021a_init_machine(void)
> +{
> +	bus_register_notifier(&platform_bus_type, &ls1021a_platform_nb);
> +
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}
> +
>  static const char * const ls1021a_dt_compat[] __initconst = {
>  	"fsl,ls1021a",
>  	NULL,
> @@ -18,5 +47,6 @@ static const char * const ls1021a_dt_compat[] __initconst = {
>  
>  DT_MACHINE_START(LS1021A, "Freescale LS1021A")
>  	.smp		= smp_ops(ls1021a_smp_ops),
> +	.init_machine   = ls1021a_init_machine,
>  	.dt_compat	= ls1021a_dt_compat,
>  MACHINE_END
> -- 
> 2.1.0.27.g96db324
> 
