From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 9 Jan 2014 23:03:55 +0800
Subject: [PATCH V2 1/3] ARM: imx: add suspend in ocram support on i.mx6q
In-Reply-To: <1389171067-32008-1-git-send-email-b20788@freescale.com>
References: <1389171067-32008-1-git-send-email-b20788@freescale.com>
Message-ID: <20140109150349.GF21717@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 04:51:04PM +0800, Anson Huang wrote:
> When system enter suspend, we can set the DDR IO
> to high-Z state to save DDR IO's power, this operation
> can save many power(from ~26mA at 1.5V to ~15mA at 1.5V,
> measured on i.MX6Q/DL SabreSD board, R25) of DDR IO. To
> achieve that, we need to copy the suspend code to ocram
> and run the low level hardware related code(set DDR IO
> to high-Z) in ocram.
> 
> If there is no ocram space available, then system will
> still do suspend in DDR, hence no DDR IO will be set
> to high-Z.
> 
> The OCRAM usage layout is as below,
> 
> ocram suspend region:
> ======================== high address ======================
>             common resume address(v7_cpu_resume)
>             mmdc io settings
>                    v
>                    v
>                    v
>                    .
>                    .
>                    .
>                    .
>                    ^
>                    ^
>                    ^
>             imx6_suspend code
>             PM_INFO structure(imx6_cpu_pm_info)
> ======================== low address =======================
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
> Changes since V1:
>   1. Remove static iomap, get those necessary io address from
>      DTS and pass them to asm code;
>   2. Re-organize the ARM register usage for a better reading
>      and save some code lines.
> 
>  arch/arm/mach-imx/Makefile       |    3 +-
>  arch/arm/mach-imx/common.h       |    4 +-
>  arch/arm/mach-imx/hardware.h     |    4 +-
>  arch/arm/mach-imx/pm-imx6q.c     |  181 ++++++++++++++-
>  arch/arm/mach-imx/suspend-imx6.S |  473 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 658 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm/mach-imx/suspend-imx6.S
> 
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index befcaf5..3d96a45 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -102,7 +102,8 @@ obj-$(CONFIG_SOC_IMX6Q) += clk-imx6q.o mach-imx6q.o
>  obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o mach-imx6sl.o
>  
>  ifeq ($(CONFIG_PM),y)
> -obj-$(CONFIG_SOC_IMX6Q) += pm-imx6q.o headsmp.o
> +AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
> +obj-$(CONFIG_SOC_IMX6Q) += pm-imx6q.o headsmp.o suspend-imx6.o
>  # i.MX6SL reuses i.MX6Q code
>  obj-$(CONFIG_SOC_IMX6SL) += pm-imx6q.o headsmp.o
>  endif
> diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
> index 59c3b9b..9a6f265 100644
> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright 2004-2013 Freescale Semiconductor, Inc. All Rights Reserved.
> + * Copyright 2004-2014 Freescale Semiconductor, Inc. All Rights Reserved.
>   */
>  
>  /*
> @@ -145,10 +145,12 @@ void imx_cpu_die(unsigned int cpu);
>  int imx_cpu_kill(unsigned int cpu);
>  
>  #ifdef CONFIG_PM
> +void imx6_suspend(void);
>  void imx6q_pm_init(void);
>  void imx6q_pm_set_ccm_base(void __iomem *base);
>  void imx5_pm_init(void);
>  #else
> +static inline void imx6_suspend(void) {}
>  static inline void imx6q_pm_init(void) {}
>  static inline void imx6q_pm_set_ccm_base(void __iomem *base) {}
>  static inline void imx5_pm_init(void) {}
> diff --git a/arch/arm/mach-imx/hardware.h b/arch/arm/mach-imx/hardware.h
> index a3b0b04..abf43bb 100644
> --- a/arch/arm/mach-imx/hardware.h
> +++ b/arch/arm/mach-imx/hardware.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
> + * Copyright 2004-2007, 2014 Freescale Semiconductor, Inc. All Rights Reserved.
>   * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
>   *
>   * This program is free software; you can redistribute it and/or
> @@ -20,7 +20,9 @@
>  #ifndef __ASM_ARCH_MXC_HARDWARE_H__
>  #define __ASM_ARCH_MXC_HARDWARE_H__
>  
> +#ifndef __ASSEMBLY__
>  #include <asm/io.h>
> +#endif
>  #include <asm/sizes.h>
>  
>  #define addr_in_module(addr, mod) \
> diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
> index 9d47adc..4ade606 100644
> --- a/arch/arm/mach-imx/pm-imx6q.c
> +++ b/arch/arm/mach-imx/pm-imx6q.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright 2011-2013 Freescale Semiconductor, Inc.
> + * Copyright 2011-2014 Freescale Semiconductor, Inc.
>   * Copyright 2011 Linaro Ltd.
>   *
>   * The code contained herein is licensed under the GNU General Public
> @@ -18,12 +18,17 @@
>  #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_device.h>

of_find_device_by_node() declaration is in of_platform.h rather than
of_device.h

>  #include <linux/regmap.h>
>  #include <linux/suspend.h>
> +#include <linux/genalloc.h>

Sort it alphabetically.

>  #include <asm/cacheflush.h>
> +#include <asm/fncpy.h>
> +#include <asm/hardware/cache-l2x0.h>
> +#include <asm/mach/map.h>
>  #include <asm/proc-fns.h>
>  #include <asm/suspend.h>
> -#include <asm/hardware/cache-l2x0.h>
> +#include <asm/tlb.h>
>  
>  #include "common.h"
>  #include "hardware.h"
> @@ -58,7 +63,51 @@
>  #define CGPR				0x64
>  #define BM_CGPR_CHICKEN_BIT		(0x1 << 17)
>  
> +#define MX6Q_SUSPEND_OCRAM_SIZE		0x1000
> +
>  static void __iomem *ccm_base;
> +static void *suspend_ocram_base;

We should probably have it be void __iomem * to match the return type of
__arm_ioremap()?

> +static struct gen_pool *ocram_pool;

This can be a local variable in imx6q_pm_init()?

> +static unsigned long ocram_pbase;

It should be phys_addr_t for better, and ditto, it could be a local
variable in imx6q_pm_init()?

> +static int (*imx6_suspend_in_ocram_fn)(void *ocram_vbase);

void __iomem *ocram_vbase

> +
> +/*
> + * suspend ocram space layout:
> + * ======================== high address ======================
> + *             stack for asm code to save necessary data
> + *                    v
> + *                    v
> + *                    v
> + *                    .
> + *                    .
> + *                    .
> + *                    .
> + *                    ^
> + *                    ^
> + *                    ^
> + *             imx6_suspend code
> + *             PM_INFO structure(imx6_cpu_pm_info)
> + * ======================== low address =======================
> + */
> +/*
> + * This structure is for passing necessary data for low level ocram
> + * suspend code(arch/arm/mach-imx/suspend-imx6.S), if this struct
> + * definition is changed, the offset definition in
> + * arch/arm/mach-imx/suspend-imx6.S must be also changed accordingly,
> + * otherwise, the suspend to ocram fucntion will be broken!
> + */
> +struct imx6_cpu_pm_info {
> +	u32 cpu_type;
> +	unsigned long pbase;

phys_addr_t

> +	void *mmdc_addr[2];
> +	void *src_addr[2];
> +	void *iomuxc_addr[2];
> +	void *ccm_addr[2];
> +	void *gpc_addr[2];
> +	void *l2_addr[2];

I suggest we have a little structure for these addresses.

struct imx6_pm_base {
	phys_addr_t pbase;	
	void __iomem *vbase;
};

	struct imx6_pm_base mmdc_base;
	struct imx6_pm_base src_base;
	...

> +	u32 pm_info_size;
> +	u32 suspend_ocram_size;
> +};
>  
>  void imx6q_set_chicken_bit(void)
>  {
> @@ -177,7 +226,17 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
>  
>  static int imx6q_suspend_finish(unsigned long val)
>  {
> -	cpu_do_idle();
> +	if (!imx6_suspend_in_ocram_fn) {
> +		cpu_do_idle();
> +	} else {
> +		/*
> +		 * call low level suspend function in ocram,
> +		 * as we need to float DDR IO.
> +		 */
> +		local_flush_tlb_all();
> +		imx6_suspend_in_ocram_fn(suspend_ocram_base);
> +	}
> +
>  	return 0;
>  }
>  
> @@ -187,7 +246,12 @@ static int imx6q_pm_enter(suspend_state_t state)
>  	case PM_SUSPEND_MEM:
>  		imx6q_set_lpm(STOP_POWER_OFF);
>  		imx6q_enable_wb(true);
> -		imx6q_enable_rbc(true);
> +		/*
> +		 * For suspend into ocram, asm code already take care of
> +		 * RBC setting, so we do NOT need to do that here.
> +		 */
> +		if (!imx6_suspend_in_ocram_fn)
> +			imx6q_enable_rbc(true);
>  		imx_gpc_pre_suspend();
>  		imx_anatop_pre_suspend();
>  		imx_set_cpu_jump(0, v7_cpu_resume);
> @@ -220,8 +284,117 @@ void __init imx6q_pm_set_ccm_base(void __iomem *base)
>  
>  void __init imx6q_pm_init(void)
>  {
> +	unsigned long ocram_base;
> +	struct device_node *node;
> +	struct platform_device *pdev;
>  	struct regmap *gpr;
> +	void __iomem *base;
> +	struct imx6_cpu_pm_info *pm_info;
> +
> +	node = of_find_compatible_node(NULL, NULL, "mmio-sram");

I did not see of_node_put() call on this node anyway.  You need to do
that when you're done with the node.

> +	if (!node) {
> +		pr_warn("failed to find ocram node!\n");

Add __func__ in pr_warn() will give people who're checking the warning
message a little context.

> +		goto ocram_out;
> +	}
> +
> +	pdev = of_find_device_by_node(node);
> +	if (!pdev) {
> +		pr_warn("failed to find ocram device!\n");
> +		goto ocram_out;
> +	}
> +
> +	ocram_pool = dev_get_gen_pool(&pdev->dev);
> +	if (!ocram_pool) {
> +		pr_warn("ocram pool unavailable!\n");
> +		goto ocram_out;
> +	}
> +
> +	ocram_base = gen_pool_alloc(ocram_pool, MX6Q_SUSPEND_OCRAM_SIZE);
> +	if (!ocram_base) {
> +		pr_warn("unable to alloc ocram!\n");
> +		goto ocram_out;
> +	}
> +
> +	ocram_pbase = gen_pool_virt_to_phys(ocram_pool, ocram_base);
> +	suspend_ocram_base = __arm_ioremap(ocram_pbase, MX6Q_SUSPEND_OCRAM_SIZE,

__arm_ioremap_exec() should be better for this case.

> +			MT_MEMORY_RWX_NONCACHED);

I do not have this in my tree, so I have no way to apply the patch.
Actually for patches to go through my tree, you should base them on my
for-next branch instead of linux-next.

> +
> +	pm_info = suspend_ocram_base;
> +	pm_info->pm_info_size = sizeof(*pm_info);
> +	pm_info->pbase = ocram_pbase;
> +	pm_info->suspend_ocram_size = MX6Q_SUSPEND_OCRAM_SIZE;
> +
> +	node = of_find_compatible_node(NULL, NULL, "fsl,imx6q-mmdc");
> +	if (!node) {
> +		pr_warn("failed to find mmdc node!\n");
> +		goto ocram_out;
> +	}
> +	base = of_iomap(node, 0);
> +	pm_info->mmdc_addr[0] = (void *)be32_to_cpu(*of_get_address(node, 0, NULL, NULL));
> +	pm_info->mmdc_addr[1] = base;

I think this is a common pattern in the following code, which could be
well defined as a function.

static int __init imx6_pm_get_base(struct imx6_pm_base *base,
				   const char *compat)
{
	struct device_node *node;
	struct resource res;
	int ret = 0;

	node = of_find_compatible_node(NULL, NULL, compat);
	if (!node) {
		ret = -ENODEV;
		goto out;
	}

	ret = of_address_to_resource(node, 0, &res);
	if (ret)
		goto put_node;

	base->pbase = res.start;
	base->vbase = ioremap(res.start, resource_size(&res));
	if (!base->vbase)
		ret = -ENOMEM;

put_node:
	of_node_put(node);
out:
	return ret;
}

And then we can use it like below.

	ret = imx6_pm_get_base(&pm_info->mmdc_base, "fsl,imx6q-mmdc");
	if (ret) {
		... /* error */
	}

> +
> +	node = of_find_compatible_node(NULL, NULL, "fsl,imx6q-src");
> +	if (!node) {
> +		pr_warn("failed to find src node!\n");
> +		goto ocram_out;
> +	}
> +	base = of_iomap(node, 0);
> +	pm_info->src_addr[0] = (void *)be32_to_cpu(*of_get_address(node, 0, NULL, NULL));
> +	pm_info->src_addr[1] = base;
> +
> +	node = of_find_compatible_node(NULL, NULL, "fsl,imx6q-iomuxc");
> +	if (!node) {
> +		pr_warn("failed to find iomuxc node!\n");
> +		goto ocram_out;
> +	}
> +	base = of_iomap(node, 0);
> +	pm_info->iomuxc_addr[0] = (void *)be32_to_cpu(*of_get_address(node, 0, NULL, NULL));
> +	pm_info->iomuxc_addr[1] = base;
> +
> +	node = of_find_compatible_node(NULL, NULL, "fsl,imx6q-ccm");
> +	if (!node) {
> +		pr_warn("failed to find ccm node!\n");
> +		goto ocram_out;
> +	}
> +	pm_info->ccm_addr[0] = (void *)be32_to_cpu(*of_get_address(node, 0, NULL, NULL));
> +	pm_info->ccm_addr[1] = ccm_base;
> +
> +	node = of_find_compatible_node(NULL, NULL, "fsl,imx6q-gpc");
> +	if (!node) {
> +		pr_warn("failed to find gpc node!\n");
> +		goto ocram_out;
> +	}
> +	base = of_iomap(node, 0);
> +	pm_info->gpc_addr[0] = (void *)be32_to_cpu(*of_get_address(node, 0, NULL, NULL));
> +	pm_info->gpc_addr[1] = base;
> +
> +	node = of_find_compatible_node(NULL, NULL, "arm,pl310-cache");
> +	if (!node) {
> +		pr_warn("failed to find pl310-cache node!\n");
> +		goto ocram_out;
> +	}
> +	base = of_iomap(node, 0);
> +	pm_info->l2_addr[0] = (void *)be32_to_cpu(*of_get_address(node, 0, NULL, NULL));
> +	pm_info->l2_addr[1] = base;
> +
> +	if (!pm_info->mmdc_addr[1] || !pm_info->src_addr[1] || !pm_info->iomuxc_addr[1]
> +		|| !pm_info->ccm_addr[1] || !pm_info->gpc_addr[1] || !pm_info->l2_addr[1]) {
> +		pr_warn("failed to initialize pm_info!\n");
> +		goto ocram_out;

In this case, you should unmap those blocks which have been successfully
mapped.

> +	}
> +
> +	/* Set cpu_type for DSM */
> +	if (cpu_is_imx6q())
> +		pm_info->cpu_type = MXC_CPU_IMX6Q;
> +	else if (cpu_is_imx6dl())
> +		pm_info->cpu_type = MXC_CPU_IMX6DL;
> +	else
> +		pm_info->cpu_type = MXC_CPU_IMX6SL;
> +
> +	imx6_suspend_in_ocram_fn = (void *)fncpy(suspend_ocram_base + sizeof(*pm_info),
> +		&imx6_suspend, MX6Q_SUSPEND_OCRAM_SIZE - sizeof(*pm_info));

I would suggest we put all these ocram suspend initialization code into
a function and call it from imx6q_pm_init().

>  
> +ocram_out:
>  	WARN_ON(!ccm_base);
>  
>  	/*
> diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
> new file mode 100644
> index 0000000..be0f6bf
> --- /dev/null
> +++ b/arch/arm/mach-imx/suspend-imx6.S
> @@ -0,0 +1,473 @@
> +/*
> + * Copyright 2014 Freescale Semiconductor, Inc.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/hardware/cache-l2x0.h>
> +#include "hardware.h"
> +
> +/*
> + * ==================== low level suspend ====================
> + *
> + * Better to follow below rules to use ARM registers:
> + * r0: pm_info structure address;
> + * r1~r4: for saving pm_info members;
> + * r5~r9: free registers;
> + * r10: stack pointer for saving necessary data;
> + * r11: io base address.
> + *
> + * suspend ocram space layout:
> + * ======================== high address ======================
> + *             common resume address(v7_cpu_resume)
> + *             mmdc io settings
> + *                    v
> + *                    v
> + *                    v
> + *                    .
> + *                    .
> + *                    .
> + *                    .
> + *                    ^
> + *                    ^
> + *                    ^
> + *             imx6_suspend code
> + *             PM_INFO structure(imx6_cpu_pm_info)
> + * ======================== low address =======================
> + */
> +
> +/*
> + * Below offsets are based on struct imx6_cpu_pm_info
> + * which defined in arch/arm/mach-imx/pm-imx6q.c, this
> + * structure contains necessary pm info for low level
> + * suspend related code.
> + */
> +#define PM_INFO_CPU_TYPE_OFFSET			0x0
> +#define PM_INFO_PBASE_OFFSET			0x4
> +#define PM_INFO_MX6Q_MMDC_P_OFFSET		0x8
> +#define PM_INFO_MX6Q_MMDC_V_OFFSET		0xC
> +#define PM_INFO_MX6Q_SRC_P_OFFSET		0x10
> +#define PM_INFO_MX6Q_SRC_V_OFFSET		0x14
> +#define PM_INFO_MX6Q_IOMUXC_P_OFFSET		0x18
> +#define PM_INFO_MX6Q_IOMUXC_V_OFFSET		0x1C
> +#define PM_INFO_MX6Q_CCM_P_OFFSET		0x20
> +#define PM_INFO_MX6Q_CCM_V_OFFSET		0x24
> +#define PM_INFO_MX6Q_GPC_P_OFFSET		0x28
> +#define PM_INFO_MX6Q_GPC_V_OFFSET		0x2C
> +#define PM_INFO_MX6Q_L2_P_OFFSET		0x30
> +#define PM_INFO_MX6Q_L2_V_OFFSET		0x34
> +#define PM_INFO_PM_INFO_SIZE_OFFSET		0x38
> +#define PM_INFO_SUSPEND_OCRAM_SIZE_OFFSET	0x3C
> +
> +#define MX6Q_SRC_GPR1	0x20
> +#define MX6Q_SRC_GPR2	0x24
> +#define MX6Q_MMDC_MAPSR	0x404
> +#define MX6Q_GPC_IMR1	0x08
> +#define MX6Q_GPC_IMR2	0x0c
> +#define MX6Q_GPC_IMR3	0x10
> +#define MX6Q_GPC_IMR4	0x14
> +#define MX6Q_CCM_CCR	0x0
> +
> +	.align 3
> +
> +	.macro	imx6dq_ddr_io_save
> +
> +	ldr	r6, [r11, #0x5ac] /* DRAM_DQM0 */
> +	ldr	r7, [r11, #0x5b4] /* DRAM_DQM1 */
> +	ldr	r8, [r11, #0x528] /* DRAM_DQM2 */
> +	ldr	r9, [r11, #0x520] /* DRAM_DQM3 */
> +	stmfd	r10!, {r6-r9}
> +
> +	ldr	r6, [r11, #0x514] /* DRAM_DQM4 */
> +	ldr	r7, [r11, #0x510] /* DRAM_DQM5 */
> +	ldr	r8, [r11, #0x5bc] /* DRAM_DQM6 */
> +	ldr	r9, [r11, #0x5c4] /* DRAM_DQM7 */
> +	stmfd	r10!, {r6-r9}
> +
> +	ldr	r6, [r11, #0x56c] /* DRAM_CAS */
> +	ldr	r7, [r11, #0x578] /* DRAM_RAS */
> +	ldr	r8, [r11, #0x588] /* DRAM_SDCLK_0 */
> +	ldr	r9, [r11, #0x594] /* DRAM_SDCLK_1 */
> +	stmfd	r10!, {r6-r9}
> +
> +	ldr	r8, [r11, #0x750] /* DDRMODE_CTL */
> +	ldr	r9, [r11, #0x774] /* DDRMODE */
> +	stmfd	r10!, {r6-r9}
> +
> +	ldr	r6, [r11, #0x5a8] /* DRAM_SDQS0 */
> +	ldr	r7, [r11, #0x5b0] /* DRAM_SDQS1 */
> +	ldr	r8, [r11, #0x524] /* DRAM_SDQS2 */
> +	ldr	r9, [r11, #0x51c] /* DRAM_SDQS3 */
> +	stmfd	r10!, {r6-r9}
> +
> +	ldr	r6, [r11, #0x518] /* DRAM_SDQS4 */
> +	ldr	r7, [r11, #0x50c] /* DRAM_SDQS5 */
> +	ldr	r8, [r11, #0x5b8] /* DRAM_SDQS6 */
> +	ldr	r9, [r11, #0x5c0] /* DRAM_SDQS7 */
> +	stmfd	r10!, {r6-r9}
> +
> +	ldr	r6, [r11, #0x784] /* GPR_B0DS */
> +	ldr	r7, [r11, #0x788] /* GPR_B1DS */
> +	ldr	r8, [r11, #0x794] /* GPR_B2DS */
> +	ldr	r9, [r11, #0x79c] /* GPR_B3DS */
> +	stmfd	r10!, {r6-r9}
> +
> +	ldr	r6, [r11, #0x7a0] /* GPR_B4DS */
> +	ldr	r7, [r11, #0x7a4] /* GPR_B5DS */
> +	ldr	r8, [r11, #0x7a8] /* GPR_B6DS */
> +	ldr	r9, [r11, #0x748] /* GPR_B7DS */
> +	stmfd	r10!, {r6-r9}
> +
> +	ldr	r7, [r11, #0x74c] /* GPR_ADDS*/
> +	ldr	r8, [r11, #0x59c] /* DRAM_SODT0*/
> +	ldr	r9, [r11, #0x5a0] /* DRAM_SODT1*/
> +	stmfd	r10!, {r7-r9}
> +
> +	.endm
> +
> +	.macro	imx6dq_ddr_io_restore
> +
> +	ldmea	r10!, {r6-r9}
> +	str	r6, [r11, #0x5ac] /* DRAM_DQM0 */
> +	str	r7, [r11, #0x5b4] /* DRAM_DQM1 */
> +	str	r8, [r11, #0x528] /* DRAM_DQM2 */
> +	str	r9, [r11, #0x520] /* DRAM_DQM3 */
> +
> +	ldmea	r10!, {r6-r9}
> +	str	r6, [r11, #0x514] /* DRAM_DQM4 */
> +	str	r7, [r11, #0x510] /* DRAM_DQM5 */
> +	str	r8, [r11, #0x5bc] /* DRAM_DQM6 */
> +	str	r9, [r11, #0x5c4] /* DRAM_DQM7 */
> +
> +	ldmea	r10!, {r6-r9}
> +	str	r6, [r11, #0x56c] /* DRAM_CAS */
> +	str	r7, [r11, #0x578] /* DRAM_RAS */
> +	str	r8, [r11, #0x588] /* DRAM_SDCLK_0 */
> +	str	r9, [r11, #0x594] /* DRAM_SDCLK_1 */
> +
> +	ldmea	r10!, {r8-r9}
> +	str	r8, [r11, #0x750] /* DDRMODE_CTL */
> +	str	r9, [r11, #0x774] /* DDRMODE */
> +
> +	ldmea	r10!, {r6-r9}
> +	str	r6, [r11, #0x5a8] /* DRAM_SDQS0 */
> +	str	r7, [r11, #0x5b0] /* DRAM_SDQS1 */
> +	str	r8, [r11, #0x524] /* DRAM_SDQS2 */
> +	str	r9, [r11, #0x51c] /* DRAM_SDQS3 */
> +
> +	ldmea	r10!, {r6-r9}
> +	str	r6, [r11, #0x518] /* DRAM_SDQS4 */
> +	str	r7, [r11, #0x50c] /* DRAM_SDQS5 */
> +	str	r8, [r11, #0x5b8] /* DRAM_SDQS6 */
> +	str	r9, [r11, #0x5c0] /* DRAM_SDQS7 */
> +
> +	ldmea	r10!, {r6-r9}
> +	str	r6, [r11, #0x784] /* GPR_B0DS */
> +	str	r7, [r11, #0x788] /* GPR_B1DS */
> +	str	r8, [r11, #0x794] /* GPR_B2DS */
> +	str	r9, [r11, #0x79c] /* GPR_B3DS */
> +
> +	ldmea	r10!, {r6-r9}
> +	str	r6, [r11, #0x7a0] /* GPR_B4DS */
> +	str	r7, [r11, #0x7a4] /* GPR_B5DS */
> +	str	r8, [r11, #0x7a8] /* GPR_B6DS */
> +	str	r9, [r11, #0x748] /* GPR_B7DS */
> +
> +	ldmea	r10!, {r7-r9}
> +	str	r7, [r11, #0x74c] /* GPR_ADDS*/
> +	str	r8, [r11, #0x59c] /* DRAM_SODT0*/
> +	str	r9, [r11, #0x5a0] /* DRAM_SODT1*/
> +
> +	.endm
> +
> +	.macro	imx6dq_ddr_io_set_lpm
> +
> +	mov	r9, #0
> +	str	r9, [r11, #0x5ac] /* DRAM_DQM0 */
> +	str	r9, [r11, #0x5b4] /* DRAM_DQM1 */
> +	str	r9, [r11, #0x528] /* DRAM_DQM2 */
> +	str	r9, [r11, #0x520] /* DRAM_DQM3 */
> +
> +	str	r9, [r11, #0x514] /* DRAM_DQM4 */
> +	str	r9, [r11, #0x510] /* DRAM_DQM5 */
> +	str	r9, [r11, #0x5bc] /* DRAM_DQM6 */
> +	str	r9, [r11, #0x5c4] /* DRAM_DQM7 */
> +
> +	str	r9, [r11, #0x56c] /* DRAM_CAS */
> +	str	r9, [r11, #0x578] /* DRAM_RAS */
> +	str	r9, [r11, #0x588] /* DRAM_SDCLK_0 */
> +	str	r9, [r11, #0x594] /* DRAM_SDCLK_1 */
> +
> +	str	r9, [r11, #0x750] /* DDRMODE_CTL */
> +	str	r9, [r11, #0x774] /* DDRMODE */
> +
> +	str	r9, [r11, #0x5a8] /* DRAM_SDQS0 */
> +	str	r9, [r11, #0x5b0] /* DRAM_SDQS1 */
> +	str	r9, [r11, #0x524] /* DRAM_SDQS2 */
> +	str	r9, [r11, #0x51c] /* DRAM_SDQS3 */
> +
> +	str	r9, [r11, #0x518] /* DRAM_SDQS4 */
> +	str	r9, [r11, #0x50c] /* DRAM_SDQS5 */
> +	str	r9, [r11, #0x5b8] /* DRAM_SDQS6 */
> +	str	r9, [r11, #0x5c0] /* DRAM_SDQS7 */
> +
> +	str	r9, [r11, #0x784] /* GPR_B0DS */
> +	str	r9, [r11, #0x788] /* GPR_B1DS */
> +	str	r9, [r11, #0x794] /* GPR_B2DS */
> +	str	r9, [r11, #0x79c] /* GPR_B3DS */
> +
> +	str	r9, [r11, #0x7a0] /* GPR_B4DS */
> +	str	r9, [r11, #0x7a4] /* GPR_B5DS */
> +	str	r9, [r11, #0x7a8] /* GPR_B6DS */
> +	str	r9, [r11, #0x748] /* GPR_B7DS */
> +
> +	str	r9, [r11, #0x74c] /* GPR_ADDS*/
> +	str	r9, [r11, #0x59c] /* DRAM_SODT0*/
> +	str	r9, [r11, #0x5a0] /* DRAM_SODT1*/
> +
> +	.endm
> +
> +	.macro  sync_l2_cache
> +
> +	/* sync L2 cache to drain L2's buffers to DRAM. */
> +#ifdef CONFIG_CACHE_L2X0
> +	ldr	r11, [r0, #PM_INFO_MX6Q_L2_V_OFFSET]
> +	mov	r9, #0x0
> +	str	r9, [r11, #L2X0_CACHE_SYNC]
> +1:
> +	ldr	r9, [r11, #L2X0_CACHE_SYNC]
> +	ands	r9, r9, #0x1
> +	bne	1b
> +#endif
> +	.endm
> +
> +ENTRY(imx6_suspend)
> +	ldr	r1, [r0, #PM_INFO_CPU_TYPE_OFFSET]
> +	ldr	r2, [r0, #PM_INFO_PBASE_OFFSET]
> +	ldr	r3, [r0, #PM_INFO_PM_INFO_SIZE_OFFSET]
> +	ldr	r4, [r0, #PM_INFO_SUSPEND_OCRAM_SIZE_OFFSET]
> +	/*
> +	 * counting the resume address in iram
> +	 * to set it in SRC register.
> +	 */
> +	ldr	r6, =imx6_suspend
> +	ldr	r7, =resume
> +	sub	r7, r7, r6
> +	add	r8, r2, r3
> +	add	r9, r8, r7
> +
> +	/*
> +	 * make sure TLB contain the addr we want,
> +	 * as we will access after DDR IO floated.
> +	 */
> +
> +	ldr	r11, [r0, #PM_INFO_MX6Q_CCM_V_OFFSET]
> +	ldr	r5, [r11, #0x0]
> +	ldr	r11, [r0, #PM_INFO_MX6Q_GPC_V_OFFSET]
> +	ldr	r5, [r11, #0x0]
> +
> +	/* use r11 to store the IO address */
> +	ldr	r11, [r0, #PM_INFO_MX6Q_SRC_V_OFFSET]
> +
> +	/*
> +	 * read previous resume address from SRC
> +	 * register, which is v7_cpu_resume, this
> +	 * is for the jump when we finish DDR IO
> +	 * restore.
> +	 */
> +	ldr	r5, [r11, #MX6Q_SRC_GPR1]
> +	add	r10, r0, r4
> +	str	r9, [r11, #MX6Q_SRC_GPR1]
> +	str	r2, [r11, #MX6Q_SRC_GPR2]
> +
> +	stmfd	r10!, {r5}
> +
> +	ldr	r11, [r0, #PM_INFO_MX6Q_IOMUXC_V_OFFSET]
> +
> +	cmp     r1, #MXC_CPU_IMX6Q
> +	bne	ddr_io_save_dsm_done
> +	imx6dq_ddr_io_save

Will those DRAM_* register values ever change after the initialization?
If they do not change at run-time, it does not make too much sense to
save them on each suspend.  Instead, we may want to save the register
address and value pairs into imx6_cpu_pm_info in initialization
for once, and loop over the registers to clear them at suspend and
restore at resume.

I'm not quite sure if we can do this.  But it'd be great if we can,
because doing so will help us save all those imx6dq_ddr_io_* macros,
and cpu type check can also be saved, since all the differences have
been encoded into imx6_cpu_pm_info.

Shawn

> +ddr_io_save_dsm_done:
> +
> +	/* need to sync L2 cache before DSM. */
> +	sync_l2_cache
> +
> +	ldr	r11, [r0, #PM_INFO_MX6Q_MMDC_V_OFFSET]
> +	/*
> +	 * put DDR explicitly into self-refresh and
> +	 * disable Automatic power savings.
> +	 */
> +	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
> +	orr	r7, r7, #0x01
> +	str	r7, [r11, #MX6Q_MMDC_MAPSR]
> +
> +	/* make the DDR explicitly enter self-refresh. */
> +	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
> +	orr	r7, r7, #(1 << 21)
> +	str	r7, [r11, #MX6Q_MMDC_MAPSR]
> +
> +poll_dvfs_set_1:
> +	ldr	r7, [r11, #0x404]
> +	ands	r7, r7, #(1 << 25)
> +	beq	poll_dvfs_set_1
> +
> +	ldr	r11, [r0, #PM_INFO_MX6Q_IOMUXC_V_OFFSET]
> +
> +	cmp     r1, #MXC_CPU_IMX6Q
> +	bne	ddr_io_set_lpm_dsm_done
> +	imx6dq_ddr_io_set_lpm
> +ddr_io_set_lpm_dsm_done:
> +
> +	/*
> +	 * mask all GPC interrupts before
> +	 * enabling the RBC counters to
> +	 * avoid the counter starting too
> +	 * early if an interupt is already
> +	 * pending.
> +	 */
> +	ldr	r11, [r0, #PM_INFO_MX6Q_GPC_V_OFFSET]
> +	ldr	r5, [r11, #MX6Q_GPC_IMR1]
> +	ldr	r6, [r11, #MX6Q_GPC_IMR2]
> +	ldr	r7, [r11, #MX6Q_GPC_IMR3]
> +	ldr	r8, [r11, #MX6Q_GPC_IMR4]
> +
> +	ldr	r9, =0xffffffff
> +	str	r9, [r11, #MX6Q_GPC_IMR1]
> +	str	r9, [r11, #MX6Q_GPC_IMR2]
> +	str	r9, [r11, #MX6Q_GPC_IMR3]
> +	str	r9, [r11, #MX6Q_GPC_IMR4]
> +
> +	/*
> +	 * enable the RBC bypass counter here
> +	 * to hold off the interrupts. RBC counter
> +	 * = 32 (1ms), Minimum RBC delay should be
> +	 * 400us for the analog LDOs to power down.
> +	 */
> +	ldr	r11, [r0, #PM_INFO_MX6Q_CCM_V_OFFSET]
> +	ldr	r9, [r11, #MX6Q_CCM_CCR]
> +	bic	r9, r9, #(0x3f << 21)
> +	orr	r9, r9, #(0x20 << 21)
> +	str	r9, [r11, #MX6Q_CCM_CCR]
> +
> +	/* enable the counter. */
> +	ldr	r9, [r11, #MX6Q_CCM_CCR]
> +	orr	r9, r9, #(0x1 << 27)
> +	str	r9, [r11, #MX6Q_CCM_CCR]
> +
> +	/* unmask all the GPC interrupts. */
> +	ldr	r11, [r0, #PM_INFO_MX6Q_GPC_V_OFFSET]
> +	str	r5, [r11, #MX6Q_GPC_IMR1]
> +	str	r6, [r11, #MX6Q_GPC_IMR2]
> +	str	r7, [r11, #MX6Q_GPC_IMR3]
> +	str	r8, [r11, #MX6Q_GPC_IMR4]
> +
> +	/*
> +	 * now delay for a short while (3usec)
> +	 * ARM is at 1GHz at this point
> +	 * so a short loop should be enough.
> +	 * this delay is required to ensure that
> +	 * the RBC counter can start counting in
> +	 * case an interrupt is already pending
> +	 * or in case an interrupt arrives just
> +	 * as ARM is about to assert DSM_request.
> +	 */
> +	ldr     r5, =2000
> +rbc_loop:
> +	sub     r5, r5, #0x1
> +	cmp     r5, #0x0
> +	bne     rbc_loop
> +
> +	/* Zzz, enter stop mode */
> +	wfi
> +	nop
> +	nop
> +	nop
> +	nop
> +
> +	/*
> +	 * run to here means there is pending
> +	 * wakeup source, system should auto
> +	 * resume, we need to restore DDR IO first
> +	 */
> +
> +	add	r10, r0, r4
> +	/* skip the lr saved in iram */
> +	sub	r10, r10, #0x4
> +
> +	ldr	r11, [r0, #PM_INFO_MX6Q_IOMUXC_V_OFFSET]
> +
> +	cmp     r1, #MXC_CPU_IMX6Q
> +	bne	ddr_io_restore_done
> +	imx6dq_ddr_io_restore
> +ddr_io_restore_done:
> +
> +	ldr	r11, [r0, #PM_INFO_MX6Q_MMDC_V_OFFSET]
> +	/* let DDR out of self-refresh. */
> +	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
> +	bic	r7, r7, #(1 << 21)
> +	str	r7, [r11, #MX6Q_MMDC_MAPSR]
> +
> +poll_dvfs_clear_2:
> +	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
> +	ands	r7, r7, #(1 << 25)
> +	bne     poll_dvfs_clear_2
> +	/* enable DDR auto power saving */
> +	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
> +	bic	r7, r7, #0x1
> +	str	r7, [r11, #MX6Q_MMDC_MAPSR]
> +	/* return to suspend finish */
> +	mov	pc, lr
> +
> +resume:
> +	/* invalidate L1 I-cache first */
> +	mov     r5,     #0x0
> +	mcr     p15, 0, r5, c7, c5, 0
> +	mcr     p15, 0, r5, c7, c5, 0
> +	mcr     p15, 0, r5, c7, c5, 6
> +	/* enable the Icache and branch prediction */
> +	mov     r5, #0x1800
> +	mcr     p15, 0, r5, c1, c0, 0
> +	isb
> +
> +	ldr	r4, [r0, #PM_INFO_SUSPEND_OCRAM_SIZE_OFFSET]
> +	add	r10, r0, r4
> +	ldmea	r10!, {lr}
> +
> +	/* get cpu type */
> +	ldr	r1, [r0, #PM_INFO_CPU_TYPE_OFFSET]
> +
> +	/* clear core0's entry and parameter */
> +	ldr	r11, [r0, #PM_INFO_MX6Q_SRC_P_OFFSET]
> +	mov	r7, #0
> +	str	r7, [r11, #MX6Q_SRC_GPR1]
> +	str	r7, [r11, #MX6Q_SRC_GPR2]
> +
> +	ldr	r11, [r0, #PM_INFO_MX6Q_IOMUXC_P_OFFSET]
> +
> +	cmp	r1, #MXC_CPU_IMX6Q
> +	bne	ddr_io_restore_dsm_done
> +	imx6dq_ddr_io_restore
> +ddr_io_restore_dsm_done:
> +
> +	ldr	r11, [r0, #PM_INFO_MX6Q_MMDC_P_OFFSET]
> +	/* let DDR out of self-refresh */
> +	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
> +	bic	r7, r7, #(1 << 21)
> +	str	r7, [r11, #MX6Q_MMDC_MAPSR]
> +
> +poll_dvfs_clear_1:
> +	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
> +	ands	r7, r7, #(1 << 25)
> +	bne	poll_dvfs_clear_1
> +	/* enable DDR auto power saving */
> +	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
> +	bic	r7, r7, #0x1
> +	str	r7, [r11, #MX6Q_MMDC_MAPSR]
> +	mov	pc, lr
> +ENDPROC(imx6_suspend)
> -- 
> 1.7.9.5
> 
> 
