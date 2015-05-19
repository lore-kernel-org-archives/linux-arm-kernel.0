From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 19 May 2015 10:57:58 +0800
Subject: [PATCH 1/2] ARM: imx: enable smp for i.MX7D
In-Reply-To: <1431378955-991-1-git-send-email-Frank.Li@freescale.com>
References: <1431378955-991-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150519025758.GK1071@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 05:15:54AM +0800, Frank.Li at freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> i.MX7D have two cores.
> enable multicore support.
> enable cpu hotplug support.
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  arch/arm/mach-imx/Kconfig      |   1 +
>  arch/arm/mach-imx/Makefile     |   2 +-
>  arch/arm/mach-imx/common.h     |   6 ++
>  arch/arm/mach-imx/gpcv2.c      | 137 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/headsmp.S    |   5 ++
>  arch/arm/mach-imx/hotplug.c    |   7 +++
>  arch/arm/mach-imx/mach-imx7d.c |   2 +
>  arch/arm/mach-imx/platsmp.c    |  14 +++++
>  arch/arm/mach-imx/src.c        |  38 +++++++++++-
>  9 files changed, 208 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm/mach-imx/gpcv2.c
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 1d87078..0e50ce7 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -586,6 +586,7 @@ config SOC_IMX7D
>  	bool "i.MX7 Dual support"
>  	select PINCTRL_IMX7D
>  	select ARM_GIC
> +	select ARM_ARCH_TIMER

Why does this change belong to smp enablement?

>  	help
>  		This enables support for Freescale i.MX7 Dual processor.
>  
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index 40df12a..8a83366 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -74,7 +74,7 @@ obj-$(CONFIG_MACH_VPR200) += mach-vpr200.o
>  obj-$(CONFIG_MACH_IMX35_DT) += imx35-dt.o
>  
>  obj-$(CONFIG_HAVE_IMX_ANATOP) += anatop.o
> -obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
> +obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o gpcv2.o

Have a new option for it.

>  obj-$(CONFIG_HAVE_IMX_MMDC) += mmdc.o
>  obj-$(CONFIG_HAVE_IMX_SRC) += src.o
>  ifneq ($(CONFIG_SOC_IMX6)$(CONFIG_SOC_LS1021A),)
> diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
> index d1e2873..216031b 100644
> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -67,6 +67,7 @@ void imx_gpc_check_dt(void);
>  void imx_gpc_set_arm_power_in_lpm(bool power_off);
>  void imx_gpc_set_arm_power_up_timing(u32 sw2iso, u32 sw);
>  void imx_gpc_set_arm_power_down_timing(u32 sw2iso, u32 sw);
> +void imx_gpcv2_set_core1_pdn_pup_by_software(bool pdn);

Can this function name be a little shorter?

>  
>  enum mxc_cpu_pwr_mode {
>  	WAIT_CLOCKED,		/* wfi only */
> @@ -86,11 +87,13 @@ enum mx3_cpu_pwr_mode {
>  void mx3_cpu_lp_set(enum mx3_cpu_pwr_mode mode);
>  
>  void imx_enable_cpu(int cpu, bool enable);
> +void imx_enable_cpu_ca7(int cpu, bool enable);
>  void imx_set_cpu_jump(int cpu, void *jump_addr);
>  u32 imx_get_cpu_arg(int cpu);
>  void imx_set_cpu_arg(int cpu, u32 arg);
>  #ifdef CONFIG_SMP
>  void v7_secondary_startup(void);
> +void ca7_secondary_startup(void);
>  void imx_scu_map_io(void);
>  void imx_smp_prepare(void);
>  #else
> @@ -111,9 +114,11 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode);
>  void imx6q_set_int_mem_clk_lpm(bool enable);
>  void imx6sl_set_wait_clk(bool enter);
>  int imx_mmdc_get_ddr_type(void);
> +int imx_gpcv2_init(const char *gpc_compat);
>  
>  void imx_cpu_die(unsigned int cpu);
>  int imx_cpu_kill(unsigned int cpu);
> +int imx_cpu_ca7_kill(unsigned int cpu);
>  
>  #ifdef CONFIG_SUSPEND
>  void v7_cpu_resume(void);
> @@ -149,6 +154,7 @@ static inline void imx_init_l2cache(void) {}
>  #endif
>  
>  extern struct smp_operations imx_smp_ops;
> +extern struct smp_operations imx_smp_ca7_ops;

Use CPU_METHOD_OF_DECLARE() to save this declaration.

>  extern struct smp_operations ls1021a_smp_ops;
>  
>  #endif
> diff --git a/arch/arm/mach-imx/gpcv2.c b/arch/arm/mach-imx/gpcv2.c
> new file mode 100644
> index 0000000..554dd5e
> --- /dev/null
> +++ b/arch/arm/mach-imx/gpcv2.c
> @@ -0,0 +1,137 @@
> +/*
> + * Copyright (C) 2015 Freescale Semiconductor, Inc.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/irqchip/arm-gic.h>

Sort it alphabetically, and have a new line here.

> +#include "common.h"
> +#include "hardware.h"
> +
> +#define IMR_NUM			4
> +#define GPC_LPCR_A7_BSC		0x0
> +#define GPC_LPCR_A7_AD		0x4
> +#define GPC_LPCR_M4		0x8
> +#define GPC_SLPCR		0x14
> +#define GPC_PGC_ACK_SEL_A7	0x24
> +#define GPC_MISC		0x2c
> +#define GPC_IMR1_CORE0		0x30
> +#define GPC_IMR1_CORE1		0x40
> +#define GPC_SLOT0_CFG		0xb0
> +#define GPC_PGC_CPU_MAPPING	0xec
> +#define GPC_CPU_PGC_SW_PUP_REQ	0xf0
> +#define GPC_PU_PGC_SW_PUP_REQ	0xf8
> +#define GPC_CPU_PGC_SW_PDN_REQ	0xfc
> +#define GPC_PU_PGC_SW_PDN_REQ	0x104
> +#define GPC_GTOR		0x124
> +#define GPC_PGC_C0		0x800
> +#define GPC_PGC_C1		0x840
> +#define GPC_PGC_SCU		0x880
> +#define GPC_PGC_FM		0xa00
> +#define GPC_PGC_MIPI_PHY	0xc00
> +#define GPC_PGC_PCIE_PHY	0xc40
> +#define GPC_PGC_USB_OTG1_PHY	0xc80
> +#define GPC_PGC_USB_OTG2_PHY	0xcc0
> +#define GPC_PGC_USB_HSIC_PHY	0xd00
> +
> +#define BM_LPCR_A7_BSC_IRQ_SRC_A7_WAKEUP	0x70000000
> +#define BM_LPCR_A7_BSC_CPU_CLK_ON_LPM		0x4000
> +#define BM_LPCR_A7_BSC_LPM1			0xc
> +#define BM_LPCR_A7_BSC_LPM0			0x3
> +#define BP_LPCR_A7_BSC_LPM1			2
> +#define BP_LPCR_A7_BSC_LPM0			0
> +#define BM_LPCR_M4_MASK_DSM_TRIGGER		0x80000000
> +#define BM_SLPCR_EN_DSM				0x80000000
> +#define BM_SLPCR_RBC_EN				0x40000000
> +#define BM_SLPCR_VSTBY				0x4
> +#define BM_SLPCR_SBYOS				0x2
> +#define BM_SLPCR_BYPASS_PMIC_READY		0x1
> +
> +#define BM_LPCR_A7_AD_EN_C1_PUP			0x800
> +#define BM_LPCR_A7_AD_EN_C1_IRQ_PUP		0x400
> +#define BM_LPCR_A7_AD_EN_C0_PUP			0x200
> +#define BM_LPCR_A7_AD_EN_C0_IRQ_PUP		0x100
> +#define BM_LPCR_A7_AD_EN_PLAT_PDN		0x10
> +#define BM_LPCR_A7_AD_EN_C1_PDN			0x8
> +#define BM_LPCR_A7_AD_EN_C1_WFI_PDN		0x4
> +#define BM_LPCR_A7_AD_EN_C0_PDN			0x2
> +#define BM_LPCR_A7_AD_EN_C0_WFI_PDN		0x1
> +
> +#define BM_CPU_PGC_SW_PDN_PUP_REQ_CORE1_A7	0x2
> +
> +#define BM_GPC_PGC_ACK_SEL_A7_DUMMY_PUP_ACK	0x80000000
> +#define BM_GPC_PGC_ACK_SEL_A7_DUMMY_PDN_ACK	0x8000
> +
> +#define BP_LPCR_A7_BSC_IRQ_SRC			28

Define bit fields only when you actually need them.

> +
> +#define MAX_SLOT_NUMBER				10
> +#define A7_LPM_WAIT				0x5
> +#define A7_LPM_STOP				0xa
> +
> +#define GPC_MAX_IRQS            (IMR_NUM * 32)

Define macros only when you actually need them.

> +
> +enum imx_gpc_slot {
> +	CORE0_A7,
> +	CORE1_A7,
> +	SCU_A7,
> +	FAST_MEGA_MIX,
> +	MIPI_PHY,
> +	PCIE_PHY,
> +	USB_OTG1_PHY,
> +	USB_OTG2_PHY,
> +	USB_HSIC_PHY,
> +	CORE0_M4,
> +};

Unused.

> +
> +static void __iomem *gpc_base;
> +
> +

One new line is enough.

> +void imx_gpcv2_set_m_core_pgc(bool enable, u32 offset)

static inline?

> +{
> +	writel_relaxed(enable, gpc_base + offset);

Why does offset need to be an argument instead of using GPC_PGC_C1
directly?

> +}
> +
> +void imx_gpcv2_set_core1_pdn_pup_by_software(bool pdn)
> +{
> +
> +	u32 val = readl_relaxed(gpc_base + (pdn ?
> +		GPC_CPU_PGC_SW_PDN_REQ : GPC_CPU_PGC_SW_PUP_REQ));

This ternary expression is used for a couple of times in this function,
and it may be worth a variable.

> +
> +	imx_gpcv2_set_m_core_pgc(true, GPC_PGC_C1);

Have a new line here, move the val assignment here to make the register
read/modify/write be grouped.

> +	val |= BM_CPU_PGC_SW_PDN_PUP_REQ_CORE1_A7;
> +	writel_relaxed(val, gpc_base + (pdn ?
> +		GPC_CPU_PGC_SW_PDN_REQ : GPC_CPU_PGC_SW_PUP_REQ));
> +
> +	while ((readl_relaxed(gpc_base + (pdn ?
> +		GPC_CPU_PGC_SW_PDN_REQ : GPC_CPU_PGC_SW_PUP_REQ)) &
> +		BM_CPU_PGC_SW_PDN_PUP_REQ_CORE1_A7) != 0)
> +		;

Timeout check?

> +	imx_gpcv2_set_m_core_pgc(false, GPC_PGC_C1);
> +}
> +
> +int __init imx_gpcv2_init(const char *gpc_compat)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, gpc_compat);
> +	gpc_base = of_iomap(np, 0);
> +	if (WARN_ON(!gpc_base))
> +		return -ENOMEM;

No need of a fat warning, since you return error code and caller should
be handling it.  Or, you use BUG_ON() and do not return error.

> +
> +	return 0;
> +}
> diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
> index de5047c..95467c7 100644
> --- a/arch/arm/mach-imx/headsmp.S
> +++ b/arch/arm/mach-imx/headsmp.S
> @@ -29,3 +29,8 @@ ENTRY(v7_secondary_startup)
>  	set_diag_reg
>  	b	secondary_startup
>  ENDPROC(v7_secondary_startup)
> +
> +ENTRY(ca7_secondary_startup)
> +	bl      v7_invalidate_l1
> +	b       secondary_startup
> +ENDPROC(ca7_secondary_startup)

v7_secondary_startup doesn't work for you?

> diff --git a/arch/arm/mach-imx/hotplug.c b/arch/arm/mach-imx/hotplug.c
> index b35e99c..9a7a00f 100644
> --- a/arch/arm/mach-imx/hotplug.c
> +++ b/arch/arm/mach-imx/hotplug.c
> @@ -68,3 +68,10 @@ int imx_cpu_kill(unsigned int cpu)
>  	imx_set_cpu_arg(cpu, 0);
>  	return 1;
>  }
> +
> +int imx_cpu_ca7_kill(unsigned int cpu)
> +{
> +	if (imx_cpu_kill(cpu))
> +		imx_gpcv2_set_core1_pdn_pup_by_software(true);

Can you put some comment to explain the additional operation required by
imx_cpu_ca7_kill()?

> +	return 1;
> +}
> diff --git a/arch/arm/mach-imx/mach-imx7d.c b/arch/arm/mach-imx/mach-imx7d.c
> index 4d4a190..6657645 100644
> --- a/arch/arm/mach-imx/mach-imx7d.c
> +++ b/arch/arm/mach-imx/mach-imx7d.c
> @@ -27,6 +27,7 @@ static void __init imx7d_init_machine(void)
>  static void __init imx7d_init_irq(void)
>  {
>  	imx_init_revision_from_anatop();
> +	imx_gpcv2_init("fsl,imx7d-gpc");
>  	imx_src_init();
>  	irqchip_init();
>  }
> @@ -37,6 +38,7 @@ static const char *imx7d_dt_compat[] __initconst = {
>  };
>  
>  DT_MACHINE_START(IMX7D, "Freescale i.MX7 Dual (Device Tree)")
> +	.smp            = smp_ops(imx_smp_ca7_ops),
>  	.init_irq	= imx7d_init_irq,
>  	.init_machine	= imx7d_init_machine,
>  	.dt_compat	= imx7d_dt_compat,
> diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
> index 7f27001..119f96a 100644
> --- a/arch/arm/mach-imx/platsmp.c
> +++ b/arch/arm/mach-imx/platsmp.c
> @@ -98,6 +98,20 @@ struct smp_operations  imx_smp_ops __initdata = {
>  #endif
>  };
>  
> +static int imx_ca7_boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +	imx_set_cpu_jump(cpu, ca7_secondary_startup);
> +	imx_enable_cpu_ca7(cpu, true);
> +	return 0;
> +}
> +
> +struct smp_operations  imx_smp_ca7_ops __initdata = {
> +	.smp_boot_secondary	= imx_ca7_boot_secondary,
> +#ifdef CONFIG_HOTPLUG_CPU
> +	.cpu_die		= imx_cpu_die,
> +	.cpu_kill		= imx_cpu_ca7_kill,
> +#endif
> +};
>  #define DCFG_CCSR_SCRATCHRW1	0x200
>  
>  static int ls1021a_boot_secondary(unsigned int cpu, struct task_struct *idle)
> diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
> index 45f7f4e..f4ea055 100644
> --- a/arch/arm/mach-imx/src.c
> +++ b/arch/arm/mach-imx/src.c
> @@ -30,8 +30,17 @@
>  #define BP_SRC_SCR_CORE1_RST		14
>  #define BP_SRC_SCR_CORE1_ENABLE		22
>  
> +/* below is for i.MX7D */
> +#define SRC_GPR1_V2                     0x074

Can we have the updated SRC and GPC named after imx7d or something
instead of the software version number which is quite arbitrary?

> +#define SRC_A7RCR0                      0x004
> +#define SRC_A7RCR1                      0x008
> +
> +#define BP_SRC_A7RCR0_A7_CORE_RESET0    0
> +#define BP_SRC_A7RCR1_A7_CORE1_ENABLE   1
> +
>  static void __iomem *src_base;
>  static DEFINE_SPINLOCK(scr_lock);
> +static int	src_gpr_offset;

Space instead of tab.

>  
>  static const int sw_reset_bits[5] = {
>  	BP_SRC_SCR_SW_GPU_RST,
> @@ -96,23 +105,39 @@ void imx_enable_cpu(int cpu, bool enable)
>  	spin_unlock(&scr_lock);
>  }
>  
> +void imx_enable_cpu_ca7(int cpu, bool enable)
> +{
> +	u32 mask, val;
> +
> +	cpu = cpu_logical_map(cpu);
> +	spin_lock(&scr_lock);
> +	if (enable)
> +		imx_gpcv2_set_core1_pdn_pup_by_software(false);
> +	mask = 1 << (BP_SRC_A7RCR1_A7_CORE1_ENABLE + cpu - 1);
> +	val = readl_relaxed(src_base + SRC_A7RCR1);
> +	val = enable ? val | mask : val & ~mask;
> +	writel_relaxed(val, src_base + SRC_A7RCR1);
> +	spin_unlock(&scr_lock);
> +

Drop this new line.

> +}
> +
>  void imx_set_cpu_jump(int cpu, void *jump_addr)
>  {
>  	cpu = cpu_logical_map(cpu);
>  	writel_relaxed(virt_to_phys(jump_addr),
> -		       src_base + SRC_GPR1 + cpu * 8);
> +		       src_base + src_gpr_offset + cpu * 8);
>  }
>  
>  u32 imx_get_cpu_arg(int cpu)
>  {
>  	cpu = cpu_logical_map(cpu);
> -	return readl_relaxed(src_base + SRC_GPR1 + cpu * 8 + 4);
> +	return readl_relaxed(src_base + src_gpr_offset + cpu * 8 + 4);
>  }
>  
>  void imx_set_cpu_arg(int cpu, u32 arg)
>  {
>  	cpu = cpu_logical_map(cpu);
> -	writel_relaxed(arg, src_base + SRC_GPR1 + cpu * 8 + 4);
> +	writel_relaxed(arg, src_base + src_gpr_offset + cpu * 8 + 4);
>  }
>  
>  void __init imx_src_init(void)
> @@ -120,6 +145,8 @@ void __init imx_src_init(void)
>  	struct device_node *np;
>  	u32 val;
>  
> +	src_gpr_offset = SRC_GPR1;
> +
>  	np = of_find_compatible_node(NULL, NULL, "fsl,imx51-src");

In the second patch, I do not see that gpc node has "fsl,imx51-src" in
the compatible.  How does the src_base get mapped in this case?

Shawn

>  	if (!np)
>  		return;
> @@ -127,6 +154,11 @@ void __init imx_src_init(void)
>  	WARN_ON(!src_base);
>  
>  	imx_reset_controller.of_node = np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx7d-src");
> +	if (np)
> +		src_gpr_offset = SRC_GPR1_V2;
> +
>  	if (IS_ENABLED(CONFIG_RESET_CONTROLLER))
>  		reset_controller_register(&imx_reset_controller);
>  
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
