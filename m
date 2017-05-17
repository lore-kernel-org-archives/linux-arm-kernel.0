From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 17 May 2017 19:36:42 +0200 (CEST)
Subject: [PATCH 2/4] ARM: imx: add initial support for imx7ulp
In-Reply-To: <1495036217-20049-3-git-send-email-aisheng.dong@nxp.com>
References: <1495036217-20049-1-git-send-email-aisheng.dong@nxp.com>
 <1495036217-20049-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <51686046.22567.1495042602979@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

> Dong Aisheng <aisheng.dong@nxp.com> hat am 17. Mai 2017 um 17:50 geschrieben:
> 
> 
> Add initial support for imx7ulp.
> 
> Note that we need configure power mode to Partial Stop mode 3 with
> system/bus clock enabled first as the default enabled STOP mode will
> gate off system/bus clock when execute WFI in MX7ULP SoC.
> 
> And there's still no MXC_CPU_IMX7ULP IDs read from register as ULP has no
> anatop as before. So we encode one with 0xff in reverse order in case new
> ones will be in the future.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  arch/arm/mach-imx/Kconfig        |  9 +++++++++
>  arch/arm/mach-imx/Makefile       |  1 +
>  arch/arm/mach-imx/common.h       |  1 +
>  arch/arm/mach-imx/cpu.c          |  3 +++
>  arch/arm/mach-imx/mach-imx7ulp.c | 37 +++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/mxc.h          |  1 +
>  arch/arm/mach-imx/pm-imx7ulp.c   | 33 +++++++++++++++++++++++++++++++++
>  7 files changed, 85 insertions(+)
>  create mode 100644 arch/arm/mach-imx/mach-imx7ulp.c
>  create mode 100644 arch/arm/mach-imx/pm-imx7ulp.c
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 936c59d..a07081d 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -553,6 +553,15 @@ comment "Cortex-A/Cortex-M asymmetric multiprocessing platforms"
>  
>  if ARCH_MULTI_V7 || ARM_SINGLE_ARMV7M
>  
> +config SOC_IMX7ULP
> +	bool "i.MX7ULP support"
> +	select ARM_GIC
> +	select CLKSRC_IMX_TPM
> +	select HAVE_ARM_ARCH_TIMER
> +	select PINCTRL_IMX7ULP
> +	help
> +	  This enables support for Freescale i.MX7 Ultra Low Power processor.
> +
>  config SOC_VF610
>  	bool "Vybrid Family VF610 support"
>  	select ARM_GIC if ARCH_MULTI_V7
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index cab1289..c5948b7 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -80,6 +80,7 @@ obj-$(CONFIG_SOC_IMX6SL) += mach-imx6sl.o
>  obj-$(CONFIG_SOC_IMX6SX) += mach-imx6sx.o
>  obj-$(CONFIG_SOC_IMX6UL) += mach-imx6ul.o
>  obj-$(CONFIG_SOC_IMX7D) += mach-imx7d.o
> +obj-$(CONFIG_SOC_IMX7ULP) += mach-imx7ulp.o pm-imx7ulp.o
>  
>  ifeq ($(CONFIG_SUSPEND),y)
>  AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
> diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
> index b09a2ec..b0e85df 100644
> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -128,6 +128,7 @@ void imx6dl_pm_init(void);
>  void imx6sl_pm_init(void);
>  void imx6sx_pm_init(void);
>  void imx6ul_pm_init(void);
> +void imx7ulp_pm_init(void);
>  
>  #ifdef CONFIG_PM
>  void imx51_pm_init(void);
> diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
> index b3347d3..3867e7f 100644
> --- a/arch/arm/mach-imx/cpu.c
> +++ b/arch/arm/mach-imx/cpu.c
> @@ -134,6 +134,9 @@ struct device * __init imx_soc_device_init(void)
>  	case MXC_CPU_IMX7D:
>  		soc_id = "i.MX7D";
>  		break;
> +	case MXC_CPU_IMX7ULP:
> +		soc_id = "i.MX7ULP";
> +		break;
>  	default:
>  		soc_id = "Unknown";
>  	}
> diff --git a/arch/arm/mach-imx/mach-imx7ulp.c b/arch/arm/mach-imx/mach-imx7ulp.c
> new file mode 100644
> index 0000000..9f7a25c
> --- /dev/null
> +++ b/arch/arm/mach-imx/mach-imx7ulp.c
> @@ -0,0 +1,37 @@
> +/*
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Copyright (C) 2017 NXP
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/irqchip.h>
> +#include <linux/of_platform.h>
> +#include <asm/mach/arch.h>
> +
> +#include "common.h"
> +#include "hardware.h"
> +
> +static void __init imx7ulp_init_machine(void)
> +{
> +	imx7ulp_pm_init();
> +
> +	mxc_set_cpu_type(MXC_CPU_IMX7ULP);
> +	imx_print_silicon_rev("i.MX7ULP", IMX_CHIP_REVISION_1_0);
> +	of_platform_default_populate(NULL, NULL, imx_soc_device_init());
> +}
> +
> +static const char *const imx7ulp_dt_compat[] __initconst = {
> +	"fsl,imx7ulp",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(IMX7ulp, "Freescale i.MX7ULP (Device Tree)")
> +	.init_machine	= imx7ulp_init_machine,
> +	.dt_compat	= imx7ulp_dt_compat,
> +MACHINE_END
> diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
> index 34f2ff6..3dfb09c 100644
> --- a/arch/arm/mach-imx/mxc.h
> +++ b/arch/arm/mach-imx/mxc.h
> @@ -40,6 +40,7 @@
>  #define MXC_CPU_IMX6Q		0x63
>  #define MXC_CPU_IMX6UL		0x64
>  #define MXC_CPU_IMX7D		0x72
> +#define MXC_CPU_IMX7ULP		0xff
>  
>  #define IMX_DDR_TYPE_LPDDR2		1
>  
> diff --git a/arch/arm/mach-imx/pm-imx7ulp.c b/arch/arm/mach-imx/pm-imx7ulp.c
> new file mode 100644
> index 0000000..df5d6b6
> --- /dev/null
> +++ b/arch/arm/mach-imx/pm-imx7ulp.c
> @@ -0,0 +1,33 @@
> +/*
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Copyright (C) 2017 NXP
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +
> +#define SMC_PMCTRL		0x10
> +#define BP_PMCTRL_PSTOPO        16
> +#define PSTOPO_PSTOP3		0x3
> +
> +void __init imx7ulp_pm_init(void)
> +{
> +	struct device_node *np;
> +	void __iomem *smc1_base;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx7ulp-smc1");

so actually there no dt-binding for this compatible, because there is no driver?
