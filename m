From: bp@alien8.de (Borislav Petkov)
Date: Fri, 12 Aug 2016 11:12:48 +0200
Subject: [Patch v4 8/9] driver/edac/layerscape_edac: Add Layerscape EDAC
 support
In-Reply-To: <1470779760-16483-9-git-send-email-york.sun@nxp.com>
References: <1470779760-16483-1-git-send-email-york.sun@nxp.com>
 <1470779760-16483-9-git-send-email-york.sun@nxp.com>
Message-ID: <20160812091248.GA333@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 02:55:45PM -0700, York Sun wrote:
> Add DDR EDAC for ARM-based compatible controllers. Both big-endian
> and little-endian are supported, as specified in device tree.
> 
> Signed-off-by: York Sun <york.sun@nxp.com>
> 
> ---
> Change log
>   v4: Drop adding atomic_scrub() for arm64
>       Drop NO_IRQ
>   v3: no change
>   v2: Create new driver using shared DDR object
> 
>  arch/arm64/Kconfig.platforms   |  1 +
>  drivers/edac/Kconfig           |  7 +++++
>  drivers/edac/Makefile          |  3 ++
>  drivers/edac/fsl_ddr_edac.c    |  2 +-
>  drivers/edac/layerscape_edac.c | 67 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 79 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/edac/layerscape_edac.c
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 7ef1d05..185a215 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -41,6 +41,7 @@ config ARCH_EXYNOS
>  
>  config ARCH_LAYERSCAPE
>  	bool "ARMv8 based Freescale Layerscape SoC family"
> +	select EDAC_SUPPORT
>  	help
>  	  This enables support for the Freescale Layerscape SoC family.
>  
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 6ca7474..f1ac4e2 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -258,6 +258,13 @@ config EDAC_MPC85XX
>  	  Support for error detection and correction on the Freescale
>  	  MPC8349, MPC8560, MPC8540, MPC8548, T4240
>  
> +config EDAC_LAYERSCAPE
> +	tristate "Freescale Layerscape DDR"
> +	depends on EDAC_MM_EDAC && ARCH_LAYERSCAPE
> +	help
> +	  Support for error detection and correction on Freescale memory
> +	  controllers on Layerscape SoCs.
> +
>  config EDAC_MV64X60
>  	tristate "Marvell MV64x60"
>  	depends on EDAC_MM_EDAC && MV64X60
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index ee047a4..910dc83 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -54,6 +54,9 @@ obj-$(CONFIG_EDAC_PASEMI)		+= pasemi_edac.o
>  mpc85xx_edac_mod-y			:= fsl_ddr_edac.o mpc85xx_edac.o
>  obj-$(CONFIG_EDAC_MPC85XX)		+= mpc85xx_edac_mod.o
>  
> +layerscape_edac_mod-y			:= fsl_ddr_edac.o layerscape_edac.o
> +obj-$(CONFIG_EDAC_LAYERSCAPE)		+= layerscape_edac_mod.o
> +
>  obj-$(CONFIG_EDAC_MV64X60)		+= mv64x60_edac.o
>  obj-$(CONFIG_EDAC_CELL)			+= cell_edac.o
>  obj-$(CONFIG_EDAC_PPC4XX)		+= ppc4xx_edac.o
> diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
> index d8ce1f6..afade14 100644
> --- a/drivers/edac/fsl_ddr_edac.c
> +++ b/drivers/edac/fsl_ddr_edac.c
> @@ -26,6 +26,7 @@
>  
>  #include <linux/of_platform.h>
>  #include <linux/of_device.h>
> +#include <linux/of_address.h>
>  #include "edac_module.h"
>  #include "edac_core.h"
>  #include "fsl_ddr_edac.h"
> @@ -478,7 +479,6 @@ int fsl_mc_err_probe(struct platform_device *op)
>  
>  	pdata = mci->pvt_info;
>  	pdata->name = "fsl_mc_err";
> -	pdata->irq = NO_IRQ;
>  	mci->pdev = &op->dev;
>  	pdata->edac_idx = edac_mc_idx++;
>  	dev_set_drvdata(mci->pdev, mci);
> diff --git a/drivers/edac/layerscape_edac.c b/drivers/edac/layerscape_edac.c
> new file mode 100644
> index 0000000..6ba771d
> --- /dev/null
> +++ b/drivers/edac/layerscape_edac.c
> @@ -0,0 +1,67 @@
> +/*
> + * Freescale Memory Controller kernel module
> + *
> + * Derived from mpc85xx_edac.c

Up to here is fine...

> + * Author: Dave Jiang <djiang@mvista.com>
> + *
> + * 2006-2007 (c) MontaVista Software, Inc. This file is licensed under
> + * the terms of the GNU General Public License version 2. This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + */

... but I'm not sure about this. This is a new driver which you are
adding and not Dave. You probably could say

"Author: York Sun <york.sun@nxp.com>
(c) NXP ...

Derived from mpc85xx_edac.c, (c) Montavista ..."

so that we have both copyright tags in there.

> +
> +#include "edac_core.h"
> +#include "fsl_ddr_edac.h"
> +
> +static const struct of_device_id fsl_ddr_mc_err_of_match[] = {
> +	{ .compatible = "fsl,qoriq-memory-controller", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, fsl_ddr_mc_err_of_match);
> +
> +static struct platform_driver fsl_ddr_mc_err_driver = {
> +	.probe = fsl_mc_err_probe,
> +	.remove = fsl_mc_err_remove,
> +	.driver = {
> +		.name = "fsl_ddr_mc_err",
> +		.of_match_table = fsl_ddr_mc_err_of_match,
> +	},
> +};
> +
> +static int __init fsl_ddr_mc_init(void)
> +{
> +	int res = 0;

No need to init it since it is going to be overwritten anyway.

> +
> +	/* make sure error reporting method is sane */
> +	switch (edac_op_state) {
> +	case EDAC_OPSTATE_POLL:
> +	case EDAC_OPSTATE_INT:
> +		break;
> +	default:
> +		edac_op_state = EDAC_OPSTATE_INT;
> +		break;
> +	}
> +
> +	res = platform_driver_register(&fsl_ddr_mc_err_driver);
> +	if (res) {
> +		pr_err("Layerscape EDAC: MC fails to register\n");

This is done with pr_fmt(). Grep the tree for examples.

You could define EDAC_MOD_STR like the rest of the drivers do.



> +		return res;
> +	}
> +
> +	return 0;
> +}
> +
> +module_init(fsl_ddr_mc_init);
> +
> +static void __exit fsl_ddr_mc_exit(void)
> +{
> +	platform_driver_unregister(&fsl_ddr_mc_err_driver);
> +}
> +
> +module_exit(fsl_ddr_mc_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Montavista Software, Inc.");

See above.

> +module_param(edac_op_state, int, 0444);
> +MODULE_PARM_DESC(edac_op_state,
> +		 "EDAC Error Reporting state: 0=Poll, 2=Interrupt");
> -- 

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
