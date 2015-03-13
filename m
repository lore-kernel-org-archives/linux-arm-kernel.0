From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 13 Mar 2015 13:35:49 +0800
Subject: [PATCH v2 4/7] ARM: mx25: Retrieve IIM base from dt
In-Reply-To: <1426083694-6624-4-git-send-email-festevam@gmail.com>
References: <1426083694-6624-1-git-send-email-festevam@gmail.com>
 <1426083694-6624-4-git-send-email-festevam@gmail.com>
Message-ID: <20150313053547.GT20455@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 11:21:31AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> We should use dt to retrieve the IIM base address.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Use BUG_ON as suggested by Russell
> 
>  arch/arm/mach-imx/cpu-imx25.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/cpu-imx25.c b/arch/arm/mach-imx/cpu-imx25.c
> index 96ec64b..0d2d860 100644
> --- a/arch/arm/mach-imx/cpu-imx25.c
> +++ b/arch/arm/mach-imx/cpu-imx25.c
> @@ -11,6 +11,8 @@
>   */
>  #include <linux/module.h>
>  #include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
>  
>  #include "iim.h"
>  #include "hardware.h"
> @@ -20,8 +22,15 @@ static int mx25_cpu_rev = -1;
>  static int mx25_read_cpu_rev(void)
>  {
>  	u32 rev;
> +	void __iomem *iim_base;
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx25-iim");
> +	iim_base = of_iomap(np, 0);
> +	BUG_ON(!iim_base);
> +	rev = readl(iim_base + MXC_IIMSREV);
> +	iounmap(iim_base);
>  
> -	rev = __raw_readl(MX25_IO_ADDRESS(MX25_IIM_BASE_ADDR + MXC_IIMSREV));

Patch order is wrong.  Static mapping removal should go after this
patch.

Shawn

>  	switch (rev) {
>  	case 0x00:
>  		return IMX_CHIP_REVISION_1_0;
> -- 
> 1.9.1
> 
