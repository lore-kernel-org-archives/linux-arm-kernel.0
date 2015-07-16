From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Thu, 16 Jul 2015 14:16:35 +0000
Subject: [PATCH V4 1/1] irqchip: imx-gpcv2: IMX GPCv2 drivers for wakeup
 source and suspend
In-Reply-To: <1436371523-18083-1-git-send-email-shenwei.wang@freescale.com>
References: <1436371523-18083-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <BL2PR03MB370D2B063B9102C323A042283990@BL2PR03MB370.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kindly PING.

Shenwei

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org] On
> Behalf Of Shenwei Wang
> Sent: 2015?7?8? 11:05
> To: shawn.guo at linaro.org; tglx at linutronix.de; jason at lakedaemon.net
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: [PATCH V4 1/1] irqchip: imx-gpcv2: IMX GPCv2 drivers for wakeup source
> and suspend
> 
> IMX7D contains a new version of GPC IP block (GPCv2). It has two major functions:
> power management and wakeup source management.
> This patch adds a new irqchip driver to manage the interrupt wakeup sources and
> power management on IMX7D.
> When the system is in WFI (wait for interrupt) mode, this GPC block will be the
> first block on the platform to be activated and signaled.
> Under normal wait mode during cpu idle, the system can be woke up by any
> enabled interrupts. Under standby or suspend mode, the system can only be
> woke up by the pre-defined wakeup sources.
> 
> GPCv2 also provides low power mode control for Cortex-A7 and Cortex-M4
> domains. And it can support WAIT, STOP, and DSM(Deep Sleep Mode) modes.
> After configuring the GPCv2 module, the platform can enter into a selected mode
> either automatically triggered by ARM WFI instruction or manually by software.
> 
> Two drivers are developed to take the use of the GPCv2 hardware features. One
> irqchip driver (irq-imx-gpcv2.c) is implemented to manage the interrupt wakeup
> source. One suspend driver (pm-imx7.c) is used to manage the system power
> states. It currently supports "SUSPEND_STANDBY" and "SUSPEND_MEM" states.
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
> ---
> Patch V4:
> 	Splitted the driver into two function drivers: one irqchip driver
> 	for wakeup source management, and one suspend driver for power
> 	state management.
> 
> Patch V3:
> 	Added the assemble codes (suspend-imx7.S) for SUSPEND_MEM state.
> 	Supported the SUSPEND_MEM power mode.
> 
> Patch V2:
> 	Added the basic driver APIs for power management.
> 	Supported the STANDBY power mode.
> 
> Patch V1:
> 	Implemented the driver for IRQ wakeup sources.
> 
>  arch/arm/mach-imx/Kconfig        |   1 +
>  arch/arm/mach-imx/Makefile       |   2 +
>  arch/arm/mach-imx/pm-imx7.c      | 735
> +++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/suspend-imx7.S | 494 ++++++++++++++++++++++++++
>  drivers/irqchip/Kconfig          |   7 +
>  drivers/irqchip/Makefile         |   1 +
>  drivers/irqchip/irq-imx-gpcv2.c  | 311 +++++++++++++++++
>  include/soc/imx/gpcv2.h          | 137 ++++++++
>  8 files changed, 1688 insertions(+)
>  create mode 100644 arch/arm/mach-imx/pm-imx7.c  create mode 100644
> arch/arm/mach-imx/suspend-imx7.S  create mode 100644
> drivers/irqchip/irq-imx-gpcv2.c  create mode 100644 include/soc/imx/gpcv2.h
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig index
> 5ccc9ea..4269c1e 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -552,6 +552,7 @@ config SOC_IMX7D
>  	bool "i.MX7 Dual support"
>  	select PINCTRL_IMX7D
>  	select ARM_GIC
> +	select IMX_GPCV2
>  	select HAVE_IMX_ANATOP
>  	select HAVE_IMX_MMDC
>  	help
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile index
> 37c502a..b2ad476 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -87,6 +87,8 @@ obj-$(CONFIG_SOC_IMX7D) += mach-imx7d.o
> 
>  ifeq ($(CONFIG_SUSPEND),y)
>  AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
> +AFLAGS_suspend-imx7.o :=-Wa,-march=armv7-a
> +obj-$(CONFIG_IMX_GPCV2)	+= suspend-imx7.o pm-imx7.o
>  obj-$(CONFIG_SOC_IMX6) += suspend-imx6.o
>  obj-$(CONFIG_SOC_IMX53) += suspend-imx53.o  endif diff --git
> a/arch/arm/mach-imx/pm-imx7.c b/arch/arm/mach-imx/pm-imx7.c new file
> mode 100644 index 0000000..70e4424
> --- /dev/null
> +++ b/arch/arm/mach-imx/pm-imx7.c
> @@ -0,0 +1,735 @@
> +
> +/*
> + * Copyright (C) 2015 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/suspend.h>
> +#include <asm/suspend.h>
> +#include <asm/fncpy.h>
> +
> +#include <soc/imx/gpcv2.h>
> +
> +
> +static struct imx_irq_gpcv2 *gpcv2_get_chip_data(void) {
> +	struct irq_data *data;
> +	int virq;
> +
> +	/* Since GPCv2 is the default IRQ domain, its private data can
> +	 * be gotten from any irq descriptor. Here we use interrupt #19
> +	 * which is for snvs-rtc.
> +	 */
> +	virq = irq_find_mapping(0, 19);
> +
> +	for (data = irq_get_irq_data(virq); data;
> +	     data = data->parent_data) {
> +		if (!data->domain)
> +			continue;
> +
> +		if (!strcmp(data->domain->name, "GPCv2"))
> +			return data->chip_data;
> +	}
> +
> +	return 0;
> +}
> +
> +static void imx_gpcv2_lpm_clear_slots(struct imx_irq_gpcv2 *cd) {
> +	int i;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cd->lock, flags);
> +	for (i = 0; i < MAX_SLOT_NUMBER; i++)
> +		writel_relaxed(0x0, cd->gpc_base + GPC_SLOT0_CFG + i * 0x4);
> +	writel_relaxed(BM_GPC_PGC_ACK_SEL_A7_DUMMY_PUP_ACK |
> +		BM_GPC_PGC_ACK_SEL_A7_DUMMY_PDN_ACK,
> +		cd->gpc_base + GPC_PGC_ACK_SEL_A7);
> +
> +	spin_unlock_irqrestore(&cd->lock, flags); }
> +
> +static void imx_gpcv2_lpm_enable_core(struct imx_irq_gpcv2 *cd,
> +			bool enable, u32 offset)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cd->lock, flags);
> +	writel_relaxed(enable, cd->gpc_base + offset);
> +	spin_unlock_irqrestore(&cd->lock, flags); }
> +
> +static void imx_gpcv2_lpm_slot_setup(struct imx_irq_gpcv2 *cd,
> +		u32 index, enum gpcv2_slot m_core, bool mode, bool ack) {
> +	u32 val;
> +	unsigned long flags;
> +
> +	if (index >= MAX_SLOT_NUMBER)
> +		pr_err("Invalid slot index!\n");
> +
> +	spin_lock_irqsave(&cd->lock, flags);
> +	/* set slot */
> +	writel_relaxed((mode + 1) << (m_core * 2), cd->gpc_base +
> +		GPC_SLOT0_CFG + index * 4);
> +
> +	if (ack) {
> +		/* set ack */
> +		val = readl_relaxed(cd->gpc_base + GPC_PGC_ACK_SEL_A7);
> +		/* clear dummy ack */
> +		val &= ~(1 << (15 + (mode ? 16 : 0)));
> +		val |= 1 << (m_core + (mode ? 16 : 0));
> +		writel_relaxed(val, cd->gpc_base + GPC_PGC_ACK_SEL_A7);
> +	}
> +
> +	spin_unlock_irqrestore(&cd->lock, flags); }
> +
> +static void imx_gpcv2_lpm_env_setup(struct imx_irq_gpcv2 *cd) {
> +	/* PLL and PFDs overwrite set */
> +	regmap_write(cd->anatop, ANADIG_ARM_PLL + REG_SET, 1 << 20);
> +	regmap_write(cd->anatop, ANADIG_DDR_PLL + REG_SET, 1 << 19);
> +	regmap_write(cd->anatop, ANADIG_SYS_PLL + REG_SET, 0x1ff << 17);
> +	regmap_write(cd->anatop, ANADIG_ENET_PLL + REG_SET, 1 << 13);
> +	regmap_write(cd->anatop, ANADIG_AUDIO_PLL + REG_SET, 1 << 24);
> +	regmap_write(cd->anatop, ANADIG_VIDEO_PLL + REG_SET, 1 << 24); }
> +
> +static void imx_gpcv2_lpm_env_clean(struct imx_irq_gpcv2 *cd) {
> +	/* PLL and PFDs overwrite clear */
> +	regmap_write(cd->anatop, ANADIG_ARM_PLL + REG_CLR, 1 << 20);
> +	regmap_write(cd->anatop, ANADIG_DDR_PLL + REG_CLR, 1 << 19);
> +	regmap_write(cd->anatop, ANADIG_SYS_PLL + REG_CLR, 0x1ff << 17);
> +	regmap_write(cd->anatop, ANADIG_ENET_PLL + REG_CLR, 1 << 13);
> +	regmap_write(cd->anatop, ANADIG_AUDIO_PLL + REG_CLR, 1 << 24);
> +	regmap_write(cd->anatop, ANADIG_VIDEO_PLL + REG_CLR, 1 << 24); }
> +
> +static void imx_gpcv2_lpm_set_mode(struct imx_irq_gpcv2 *cd,
> +		enum gpcv2_mode mode)
> +{
> +
> +	unsigned long flags;
> +	u32 val1, val2;
> +
> +	spin_lock_irqsave(&cd->lock, flags);
> +
> +	val1 = readl_relaxed(cd->gpc_base + GPC_LPCR_A7_BSC);
> +	val2 = readl_relaxed(cd->gpc_base + GPC_SLPCR);
> +
> +	/* all cores' LPM settings must be same */
> +	val1 &= ~(BM_LPCR_A7_BSC_LPM0 | BM_LPCR_A7_BSC_LPM1);
> +
> +	val1 |= BM_LPCR_A7_BSC_CPU_CLK_ON_LPM;
> +
> +	val2 &= ~(BM_SLPCR_EN_DSM | BM_SLPCR_VSTBY | BM_SLPCR_RBC_EN |
> +		BM_SLPCR_SBYOS | BM_SLPCR_BYPASS_PMIC_READY);
> +	/*
> +	 * GPCv2: When improper low-power sequence is used,
> +	 * the SoC enters low power mode before the ARM core executes WFI.
> +	 *
> +	 * Software workaround:
> +	 * 1) Software should trigger IRQ #32 (IOMUX) to be always pending
> +	 *    by setting IOMUX_GPR1_IRQ.
> +	 * 2) Software should then unmask IRQ #32 in GPC before setting GPC
> +	 *    Low-Power mode.
> +	 * 3) Software should mask IRQ #32 right after GPC Low-Power mode
> +	 *    is set.
> +	 */
> +	switch (mode) {
> +	case WAIT_CLOCKED:
> +		break;
> +	case WAIT_UNCLOCKED:
> +		val1 |= A7_LPM_WAIT << BP_LPCR_A7_BSC_LPM0;
> +		val1 &= ~BM_LPCR_A7_BSC_CPU_CLK_ON_LPM;
> +		break;
> +	case STOP_POWER_ON:
> +		val1 |= A7_LPM_STOP << BP_LPCR_A7_BSC_LPM0;
> +		val1 &= ~BM_LPCR_A7_BSC_CPU_CLK_ON_LPM;
> +		val2 |= BM_SLPCR_EN_DSM;
> +		val2 |= BM_SLPCR_RBC_EN;
> +		val2 |= BM_SLPCR_BYPASS_PMIC_READY;
> +		break;
> +	case STOP_POWER_OFF:
> +		val1 |= A7_LPM_STOP << BP_LPCR_A7_BSC_LPM0;
> +		val1 &= ~BM_LPCR_A7_BSC_CPU_CLK_ON_LPM;
> +		val2 |= BM_SLPCR_EN_DSM;
> +		val2 |= BM_SLPCR_RBC_EN;
> +		val2 |= BM_SLPCR_SBYOS;
> +		val2 |= BM_SLPCR_VSTBY;
> +		val2 |= BM_SLPCR_BYPASS_PMIC_READY;
> +		break;
> +	default:
> +		return;
> +	}
> +	writel_relaxed(val1, cd->gpc_base + GPC_LPCR_A7_BSC);
> +	writel_relaxed(val2, cd->gpc_base + GPC_SLPCR);
> +
> +	spin_unlock_irqrestore(&cd->lock, flags); }
> +
> +
> +static void imx_gpcv2_lpm_cpu_power_gate(struct imx_irq_gpcv2 *cd,
> +				u32 cpu, bool pdn)
> +{
> +
> +	unsigned long flags;
> +	u32 val;
> +	const u32 val_pdn[2] = {
> +		BM_LPCR_A7_AD_EN_C0_PDN | BM_LPCR_A7_AD_EN_C0_PUP,
> +		BM_LPCR_A7_AD_EN_C1_PDN | BM_LPCR_A7_AD_EN_C1_PUP,
> +	};
> +
> +	spin_lock_irqsave(&cd->lock, flags);
> +
> +	val = readl_relaxed(cd->gpc_base + GPC_LPCR_A7_AD);
> +	if (pdn)
> +		val |= val_pdn[cpu];
> +	else
> +		val &= ~val_pdn[cpu];
> +
> +	writel_relaxed(val, cd->gpc_base + GPC_LPCR_A7_AD);
> +	spin_unlock_irqrestore(&cd->lock, flags); }
> +
> +static void imx_lpm_plat_power_gate(struct imx_irq_gpcv2 *cd, bool pdn)
> +{
> +	unsigned long flags;
> +	u32 val = readl_relaxed(cd->gpc_base + GPC_LPCR_A7_AD);
> +
> +	spin_lock_irqsave(&cd->lock, flags);
> +	val &= ~(BM_LPCR_A7_AD_EN_PLAT_PDN | BM_LPCR_A7_AD_L2PGE);
> +	if (pdn)
> +		val |= BM_LPCR_A7_AD_EN_PLAT_PDN | BM_LPCR_A7_AD_L2PGE;
> +
> +	writel_relaxed(val, cd->gpc_base + GPC_LPCR_A7_AD);
> +	spin_unlock_irqrestore(&cd->lock, flags); }
> +
> +static void imx_gpcv2_lpm_standby(struct imx_irq_gpcv2 *cd) {
> +
> +	cd->lpm_env_setup(cd);
> +	cd->set_mode(cd, STOP_POWER_OFF);
> +	/*cd->set_mode(cd, WAIT_UNCLOCKED);*/
> +
> +	pr_debug("[GPCv2] %s %d\r\n", __func__, __LINE__);
> +	/* Zzz ... */
> +	cpu_do_idle();
> +
> +	cd->set_mode(cd, WAIT_CLOCKED);
> +	cd->lpm_env_clean(cd);
> +}
> +
> +
> +
> +static int gpcv2_suspend_finish(unsigned long val) {
> +	struct imx_irq_gpcv2 *cd = (struct imx_irq_gpcv2 *)val;
> +
> +	if (!cd->suspend_fn_in_ocram) {
> +		cpu_do_idle();
> +	} else {
> +		/*
> +		 * call low level suspend function in ocram,
> +		 * as we need to float DDR IO.
> +		 */
> +		local_flush_tlb_all();
> +		cd->suspend_fn_in_ocram(cd->ocram_vbase);
> +	}
> +
> +	return 0;
> +}
> +static void imx_gpcv2_lpm_suspend(struct imx_irq_gpcv2 *cd) {
> +	int i = 0;
> +
> +	cd->lpm_env_setup(cd);
> +	cd->set_mode(cd, STOP_POWER_OFF);
> +
> +	/* enable core0 power down/up with low power mode */
> +	cd->lpm_cpu_power_gate(cd, 0, true);
> +
> +	/* enable plat power down with low power mode */
> +	cd->lpm_plat_power_gate(cd, true);
> +
> +
> +	/*
> +	 * To avoid confuse, we use slot 0~4 for power down,
> +	 * slot 5~9 for power up.
> +	 *
> +	 * Power down slot sequence:
> +	 * Slot0 -> CORE0
> +	 * Slot1 -> Mega/Fast MIX
> +	 * Slot2 -> SCU
> +	 *
> +	 * Power up slot sequence:
> +	 * Slot5 -> Mega/Fast MIX
> +	 * Slot6 -> SCU
> +	 * Slot7 -> CORE0
> +	 */
> +	cd->set_slot(cd, 0, CORE0_A7, false, false);
> +	cd->set_slot(cd, 2, SCU_A7, false, true);
> +
> +	for (i = 0; i < IMR_NUM; i++) {
> +		if ((~cd->wakeup_sources[i] & cd->mfmix_mask[i]) != 0)
> +			break;
> +
> +		cd->set_slot(cd, 1, FAST_MEGA_MIX, false, false);
> +		cd->set_slot(cd, 5, FAST_MEGA_MIX, true, false);
> +		cd->lpm_enable_core(cd, true, GPC_PGC_FM);
> +		break;
> +	}
> +
> +	cd->set_slot(cd, 6, SCU_A7, true, false);
> +	cd->set_slot(cd, 7, CORE0_A7, true, true);
> +
> +	/* enable core0, scu */
> +	cd->lpm_enable_core(cd, true, GPC_PGC_C0);
> +	cd->lpm_enable_core(cd, true, GPC_PGC_SCU);
> +
> +	/* Suspend to MEM has not been implemented yet */
> +	cpu_suspend((unsigned long)cd, gpcv2_suspend_finish);
> +
> +	cd->lpm_env_clean(cd);
> +	cd->set_mode(cd, WAIT_CLOCKED);
> +	cd->lpm_cpu_power_gate(cd, 0, false);
> +	cd->lpm_plat_power_gate(cd, false);
> +
> +	cd->lpm_enable_core(cd, false, GPC_PGC_C0);
> +	cd->lpm_enable_core(cd, false, GPC_PGC_SCU);
> +	cd->lpm_enable_core(cd, false, GPC_PGC_FM);
> +	cd->clear_slots(cd);
> +}
> +
> +static int imx_gpcv2_pm_enter(suspend_state_t state) {
> +	struct imx_irq_gpcv2 *cd;
> +
> +	cd = gpcv2_get_chip_data();
> +	BUG_ON(!cd);
> +
> +	switch (state) {
> +	case PM_SUSPEND_STANDBY:
> +		cd->standby(cd);
> +		break;
> +
> +	case PM_SUSPEND_MEM:
> +		cd->suspend(cd);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +
> +static int imx_gpcv2_pm_valid(suspend_state_t state) {
> +	return state == PM_SUSPEND_MEM || state == PM_SUSPEND_STANDBY; }
> +
> +static const struct platform_suspend_ops imx_gpcv2_pm_ops = {
> +	.enter = imx_gpcv2_pm_enter,
> +	.valid = imx_gpcv2_pm_valid,
> +};
> +
> +
> +#define MX7_MAX_DDRC_NUM		32
> +#define MX7_MAX_DDRC_PHY_NUM		16
> +
> +#define READ_DATA_FROM_HARDWARE		0
> +#define MX7_SUSPEND_OCRAM_SIZE		0x1000
> +
> +struct imx7_pm_base {
> +	phys_addr_t pbase;
> +	void __iomem *vbase;
> +};
> +
> +struct imx7_pm_socdata {
> +	u32 ddr_type;
> +	const char *ddrc_compat;
> +	const char *ddrc_phy_compat;
> +	const char *src_compat;
> +	const char *iomuxc_gpr_compat;
> +	const char *ccm_compat;
> +	const char *gpc_compat;
> +	const char *anatop_compat;
> +	const u32 ddrc_num;
> +	const u32 (*ddrc_offset)[2];
> +	const u32 ddrc_phy_num;
> +	const u32 (*ddrc_phy_offset)[2];
> +};
> +
> +/*
> + * This structure is for passing necessary data for low level ocram
> + * suspend code(arch/arm/mach-imx/suspend-imx7.S), if this struct
> + * definition is changed, the offset definition in
> + * arch/arm/mach-imx/suspend-imx7.S must be also changed accordingly,
> + * otherwise, the suspend to ocram function will be broken!
> + */
> +struct imx7_cpu_pm_info {
> +	u32 m4_reserve0;
> +	u32 m4_reserve1;
> +	u32 m4_reserve2;
> +	phys_addr_t pbase; /* The physical address of pm_info. */
> +	phys_addr_t resume_addr; /* The physical resume address for asm code */
> +	u32 ddr_type;
> +	u32 pm_info_size; /* Size of pm_info. */
> +	struct imx7_pm_base ddrc_base;
> +	struct imx7_pm_base ddrc_phy_base;
> +	struct imx7_pm_base src_base;
> +	struct imx7_pm_base iomuxc_gpr_base;
> +	struct imx7_pm_base ccm_base;
> +	struct imx7_pm_base gpc_base;
> +	struct imx7_pm_base l2_base;
> +	struct imx7_pm_base anatop_base;
> +	u32 ttbr1; /* Store TTBR1 */
> +	u32 ddrc_num; /* Number of DDRC which need saved/restored. */
> +	u32 ddrc_val[MX7_MAX_DDRC_NUM][2]; /* To save offset and value */
> +	u32 ddrc_phy_num; /* Number of DDRC which need saved/restored. */
> +	u32 ddrc_phy_val[MX7_MAX_DDRC_NUM][2]; /* To save offset and value */
> +} __aligned(8);
> +
> +
> +static int __init imx_get_base_from_node(struct device_node *node,
> +			struct imx7_pm_base *base)
> +{
> +	int ret = 0;
> +	struct resource res;
> +
> +	ret = of_address_to_resource(node, 0, &res);
> +	if (ret)
> +		goto put_node;
> +
> +	base->pbase = res.start;
> +	base->vbase = ioremap(res.start, resource_size(&res));
> +	if (!base->vbase) {
> +		iounmap(base->vbase);
> +		ret = -ENOMEM;
> +	}
> +put_node:
> +	of_node_put(node);
> +
> +	return ret;
> +}
> +
> +static int __init imx_get_base_from_dt(struct imx7_pm_base *base,
> +				const char *compat)
> +{
> +	struct device_node *node;
> +	struct resource res;
> +	int ret = 0;
> +
> +	node = of_find_compatible_node(NULL, NULL, compat);
> +	if (!node) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	ret = of_address_to_resource(node, 0, &res);
> +	if (ret)
> +		goto put_node;
> +
> +	base->pbase = res.start;
> +	base->vbase = ioremap(res.start, resource_size(&res));
> +	if (!base->vbase)
> +		ret = -ENOMEM;
> +
> +put_node:
> +	of_node_put(node);
> +out:
> +	return ret;
> +}
> +
> +static int __init imx_get_exec_base_from_dt(struct imx7_pm_base *base,
> +				const char *compat)
> +{
> +	struct device_node *node;
> +	struct resource res;
> +	int ret = 0;
> +
> +	node = of_find_compatible_node(NULL, NULL, compat);
> +	if (!node) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	ret = of_address_to_resource(node, 0, &res);
> +	if (ret)
> +		goto put_node;
> +
> +	base->pbase = res.start;
> +	base->vbase = __arm_ioremap_exec(res.start, resource_size(&res),
> +false);
> +
> +	if (!base->vbase)
> +		ret = -ENOMEM;
> +
> +put_node:
> +	of_node_put(node);
> +out:
> +	return ret;
> +}
> +
> +static const u32 imx7d_ddrc_ddr3_setting[][2] __initconst = {
> +	{ 0x0, READ_DATA_FROM_HARDWARE },
> +	{ 0x1a0, READ_DATA_FROM_HARDWARE },
> +	{ 0x1a4, READ_DATA_FROM_HARDWARE },
> +	{ 0x1a8, READ_DATA_FROM_HARDWARE },
> +	{ 0x64, READ_DATA_FROM_HARDWARE },
> +	{ 0x490, 0x00000001 },
> +	{ 0xd0, 0xc0020001 },
> +	{ 0xd4, READ_DATA_FROM_HARDWARE },
> +	{ 0xdc, READ_DATA_FROM_HARDWARE },
> +	{ 0xe0, READ_DATA_FROM_HARDWARE },
> +	{ 0xe4, READ_DATA_FROM_HARDWARE },
> +	{ 0xf4, READ_DATA_FROM_HARDWARE },
> +	{ 0x100, READ_DATA_FROM_HARDWARE },
> +	{ 0x104, READ_DATA_FROM_HARDWARE },
> +	{ 0x108, READ_DATA_FROM_HARDWARE },
> +	{ 0x10c, READ_DATA_FROM_HARDWARE },
> +	{ 0x110, READ_DATA_FROM_HARDWARE },
> +	{ 0x114, READ_DATA_FROM_HARDWARE },
> +	{ 0x120, 0x03030803 },
> +	{ 0x180, READ_DATA_FROM_HARDWARE },
> +	{ 0x190, READ_DATA_FROM_HARDWARE },
> +	{ 0x194, READ_DATA_FROM_HARDWARE },
> +	{ 0x200, READ_DATA_FROM_HARDWARE },
> +	{ 0x204, READ_DATA_FROM_HARDWARE },
> +	{ 0x214, READ_DATA_FROM_HARDWARE },
> +	{ 0x218, READ_DATA_FROM_HARDWARE },
> +	{ 0x240, 0x06000601 },
> +	{ 0x244, READ_DATA_FROM_HARDWARE },
> +};
> +
> +static const u32 imx7d_ddrc_phy_ddr3_setting[][2] __initconst = {
> +	{ 0x0, READ_DATA_FROM_HARDWARE },
> +	{ 0x4, READ_DATA_FROM_HARDWARE },
> +	{ 0x10, READ_DATA_FROM_HARDWARE },
> +	{ 0x9c, READ_DATA_FROM_HARDWARE },
> +	{ 0x20, READ_DATA_FROM_HARDWARE },
> +	{ 0x30, READ_DATA_FROM_HARDWARE },
> +	{ 0x50, 0x01000010 },
> +	{ 0x50, 0x00000010 },
> +	{ 0xc0, 0x0e407304 },
> +	{ 0xc0, 0x0e447304 },
> +	{ 0xc0, 0x0e447306 },
> +	{ 0xc0, 0x0e447304 },
> +	{ 0xc0, 0x0e407306 },
> +};
> +
> +static const struct imx7_pm_socdata imx7d_pm_data_ddr3 __initconst = {
> +	.ddrc_compat = "fsl,imx7d-ddrc",
> +	.ddrc_phy_compat = "fsl,imx7d-ddrc-phy",
> +	.ccm_compat = "fsl,imx7d-ccm",
> +	.src_compat = "fsl,imx7d-src",
> +	.iomuxc_gpr_compat = "fsl,imx7d-iomuxc",
> +	.gpc_compat = "fsl,imx7d-gpc",
> +	.anatop_compat = "fsl,imx7d-anatop",
> +	.ddrc_num = ARRAY_SIZE(imx7d_ddrc_ddr3_setting),
> +	.ddrc_offset = imx7d_ddrc_ddr3_setting,
> +	.ddrc_phy_num = ARRAY_SIZE(imx7d_ddrc_phy_ddr3_setting),
> +	.ddrc_phy_offset = imx7d_ddrc_phy_ddr3_setting, };
> +
> +
> +static int __init imx_gpcv2_suspend_init(struct imx_irq_gpcv2 *cd,
> +			const struct imx7_pm_socdata *socdata) {
> +	struct device_node *node;
> +	struct imx7_cpu_pm_info *pm_info;
> +	int i, ret = 0;
> +	struct imx7_pm_base sram_base = {0, 0};
> +	struct imx7_pm_base aips_base[3] = { {0, 0}, {0, 0}, {0, 0} };
> +	const u32 (*ddrc_offset_array)[2];
> +	const u32 (*ddrc_phy_offset_array)[2];
> +
> +	if (!socdata || !cd) {
> +		pr_warn("%s: invalid argument!\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	node = NULL;
> +	for (i = 0; i < 3; i++) {
> +		node = of_find_compatible_node(node, NULL, "fsl,aips-bus");
> +		if (!node) {
> +			pr_warn("%s: failed to find aips %d node!\n",
> +					__func__, i);
> +			break;
> +		}
> +		ret = imx_get_base_from_node(node, &aips_base[i]);
> +		if (ret) {
> +			pr_warn("%s: failed to get aips[%d] base %d!\n",
> +					__func__, i, ret);
> +		}
> +	}
> +
> +	ret = imx_get_exec_base_from_dt(&sram_base, "fsl,lpm-sram");
> +	if (ret) {
> +		pr_warn("%s: failed to get lpm-sram base %d!\n",
> +				__func__, ret);
> +		goto lpm_sram_map_failed;
> +	}
> +
> +	pm_info = sram_base.vbase;
> +	pm_info->pbase = sram_base.pbase;
> +	pm_info->resume_addr = virt_to_phys(ca7_cpu_resume);
> +	pm_info->pm_info_size = sizeof(*pm_info);
> +
> +	ret = imx_get_base_from_dt(&pm_info->ccm_base,
> socdata->ccm_compat);
> +	if (ret) {
> +		pr_warn("%s: failed to get ccm base %d!\n", __func__, ret);
> +		goto ccm_map_failed;
> +	}
> +
> +
> +	ret = imx_get_base_from_dt(&pm_info->ddrc_base,
> socdata->ddrc_compat);
> +	if (ret) {
> +		pr_warn("%s: failed to get ddrc base %d!\n", __func__, ret);
> +		goto ddrc_map_failed;
> +	}
> +
> +	ret = imx_get_base_from_dt(&pm_info->ddrc_phy_base,
> +				socdata->ddrc_phy_compat);
> +	if (ret) {
> +		pr_warn("%s: failed to get ddrc_phy base %d!\n", __func__, ret);
> +		goto ddrc_phy_map_failed;
> +	}
> +
> +
> +	ret = imx_get_base_from_dt(&pm_info->src_base, socdata->src_compat);
> +	if (ret) {
> +		pr_warn("%s: failed to get src base %d!\n", __func__, ret);
> +		goto src_map_failed;
> +	}
> +
> +	ret = imx_get_base_from_dt(&pm_info->iomuxc_gpr_base,
> +				socdata->iomuxc_gpr_compat);
> +	if (ret) {
> +		pr_warn("%s: failed to get iomuxc_gpr base %d!\n",
> +					__func__, ret);
> +		goto iomuxc_gpr_map_failed;
> +	}
> +
> +	ret = imx_get_base_from_dt(&pm_info->gpc_base, socdata->gpc_compat);
> +	if (ret) {
> +		pr_warn("%s: failed to get gpc base %d!\n", __func__, ret);
> +		goto gpc_map_failed;
> +	}
> +
> +	ret = imx_get_base_from_dt(&pm_info->anatop_base,
> +				socdata->anatop_compat);
> +	if (ret) {
> +		pr_warn("%s: failed to get anatop base %d!\n", __func__, ret);
> +		goto anatop_map_failed;
> +	}
> +
> +	pm_info->ddrc_num = socdata->ddrc_num;
> +	ddrc_offset_array = socdata->ddrc_offset;
> +	pm_info->ddrc_phy_num = socdata->ddrc_phy_num;
> +	ddrc_phy_offset_array = socdata->ddrc_phy_offset;
> +
> +	/* initialize DDRC settings */
> +	for (i = 0; i < pm_info->ddrc_num; i++) {
> +		pm_info->ddrc_val[i][0] = ddrc_offset_array[i][0];
> +		if (ddrc_offset_array[i][1] == READ_DATA_FROM_HARDWARE)
> +			pm_info->ddrc_val[i][1] =
> +				readl_relaxed(pm_info->ddrc_base.vbase +
> +				ddrc_offset_array[i][0]);
> +		else
> +			pm_info->ddrc_val[i][1] = ddrc_offset_array[i][1];
> +	}
> +
> +	/* initialize DDRC PHY settings */
> +	for (i = 0; i < pm_info->ddrc_phy_num; i++) {
> +		pm_info->ddrc_phy_val[i][0] =
> +			ddrc_phy_offset_array[i][0];
> +		if (ddrc_phy_offset_array[i][1] == READ_DATA_FROM_HARDWARE)
> +			pm_info->ddrc_phy_val[i][1] =
> +				readl_relaxed(pm_info->ddrc_phy_base.vbase +
> +				ddrc_phy_offset_array[i][0]);
> +		else
> +			pm_info->ddrc_phy_val[i][1] =
> +				ddrc_phy_offset_array[i][1];
> +	}
> +
> +	cd->suspend_fn_in_ocram = fncpy(
> +		sram_base.vbase + sizeof(*pm_info),
> +		&imx7_suspend,
> +		MX7_SUSPEND_OCRAM_SIZE - sizeof(*pm_info));
> +	cd->ocram_vbase = sram_base.vbase;
> +
> +	goto put_node;
> +
> +anatop_map_failed:
> +	iounmap(pm_info->anatop_base.vbase);
> +gpc_map_failed:
> +	iounmap(pm_info->gpc_base.vbase);
> +iomuxc_gpr_map_failed:
> +	iounmap(pm_info->iomuxc_gpr_base.vbase);
> +src_map_failed:
> +	iounmap(pm_info->src_base.vbase);
> +ddrc_phy_map_failed:
> +	iounmap(pm_info->ddrc_phy_base.vbase);
> +ddrc_map_failed:
> +	iounmap(pm_info->ddrc_base.vbase);
> +ccm_map_failed:
> +	iounmap(pm_info->ccm_base.vbase);
> +lpm_sram_map_failed:
> +	iounmap(sram_base.vbase);
> +put_node:
> +	of_node_put(node);
> +
> +	return ret;
> +}
> +
> +static int __init imx_gpcv2_pm_init(void) {
> +	struct imx_irq_gpcv2 *cd;
> +
> +
> +	cd = gpcv2_get_chip_data();
> +	if (!cd) {
> +		pr_debug("[GPCv2] %s init failed\r\n", __func__);
> +		return 0;
> +	}
> +
> +	imx_gpcv2_suspend_init(cd, &imx7d_pm_data_ddr3);
> +
> +	cd->lpm_env_setup = imx_gpcv2_lpm_env_setup;
> +	cd->lpm_env_clean = imx_gpcv2_lpm_env_clean;
> +	cd->set_mode = imx_gpcv2_lpm_set_mode;
> +	cd->standby = imx_gpcv2_lpm_standby;
> +
> +	cd->lpm_cpu_power_gate = imx_gpcv2_lpm_cpu_power_gate;
> +	cd->lpm_plat_power_gate = imx_lpm_plat_power_gate;
> +	cd->suspend = imx_gpcv2_lpm_suspend;
> +	cd->set_slot = imx_gpcv2_lpm_slot_setup;
> +
> +	cd->clear_slots = imx_gpcv2_lpm_clear_slots;
> +	cd->lpm_enable_core = imx_gpcv2_lpm_enable_core;
> +
> +	pr_debug("[GPCv2] %s \r\n", __func__);
> +	cd->anatop = syscon_regmap_lookup_by_compatible("fsl,imx6q-anatop");
> +	WARN_ON(!cd->anatop);
> +	cd->imx_src = syscon_regmap_lookup_by_compatible("fsl,imx7d-src");
> +	WARN_ON(!cd->imx_src);
> +
> +	suspend_set_ops(&imx_gpcv2_pm_ops);
> +
> +	return 0;
> +}
> +
> +device_initcall(imx_gpcv2_pm_init);
> +
> diff --git a/arch/arm/mach-imx/suspend-imx7.S
> b/arch/arm/mach-imx/suspend-imx7.S
> new file mode 100644
> index 0000000..7334894
> --- /dev/null
> +++ b/arch/arm/mach-imx/suspend-imx7.S
> @@ -0,0 +1,494 @@
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
> +#include <linux/linkage.h>
> +#include <asm/asm-offsets.h>
> +#include "hardware.h"
> +
> +/*
> + * ==================== low level suspend ====================
> + *
> + * Better to follow below rules to use ARM registers:
> + * r0: pm_info structure address;
> + * r1 ~ r4: for saving pm_info members;
> + * r5 ~ r10: free registers;
> + * r11: io base address.
> + *
> + * suspend ocram space layout:
> + * ======================== high address ======================
> + *                              .
> + *                              .
> + *                              .
> + *                              ^
> + *                              ^
> + *                              ^
> + *                      imx7_suspend code
> + *              PM_INFO structure(imx7_cpu_pm_info)
> + * ======================== low address =======================  */
> +
> +/*
> + * Below offsets are based on struct imx7_cpu_pm_info
> + * which defined in arch/arm/mach-imx/pm-imx7.c, this
> + * structure contains necessary pm info for low level
> + * suspend related code.
> + */
> +#define PM_INFO_M4_RESERVE0_OFFSET		0x0
> +#define PM_INFO_M4_RESERVE1_OFFSET		0x4
> +#define PM_INFO_M4_RESERVE2_OFFSET		0x8
> +#define PM_INFO_PBASE_OFFSET			0xc
> +#define PM_INFO_RESUME_ADDR_OFFSET		0x10
> +#define PM_INFO_DDR_TYPE_OFFSET			0x14
> +#define PM_INFO_PM_INFO_SIZE_OFFSET		0x18
> +#define PM_INFO_MX7_DDRC_P_OFFSET		0x1c
> +#define PM_INFO_MX7_DDRC_V_OFFSET		0x20
> +#define PM_INFO_MX7_DDRC_PHY_P_OFFSET		0x24
> +#define PM_INFO_MX7_DDRC_PHY_V_OFFSET		0x28
> +#define PM_INFO_MX7_SRC_P_OFFSET		0x2c
> +#define PM_INFO_MX7_SRC_V_OFFSET		0x30
> +#define PM_INFO_MX7_IOMUXC_GPR_P_OFFSET		0x34
> +#define PM_INFO_MX7_IOMUXC_GPR_V_OFFSET		0x38
> +#define PM_INFO_MX7_CCM_P_OFFSET		0x3c
> +#define PM_INFO_MX7_CCM_V_OFFSET		0x40
> +#define PM_INFO_MX7_GPC_P_OFFSET		0x44
> +#define PM_INFO_MX7_GPC_V_OFFSET		0x48
> +#define PM_INFO_MX7_L2_P_OFFSET			0x4c
> +#define PM_INFO_MX7_L2_V_OFFSET			0x50
> +#define PM_INFO_MX7_ANATOP_P_OFFSET		0x54
> +#define PM_INFO_MX7_ANATOP_V_OFFSET		0x58
> +#define PM_INFO_MX7_TTBR1_V_OFFSET		0x5c
> +#define PM_INFO_DDRC_REG_NUM_OFFSET		0x60
> +#define PM_INFO_DDRC_REG_OFFSET			0x64
> +#define PM_INFO_DDRC_VALUE_OFFSET		0x68
> +#define PM_INFO_DDRC_PHY_REG_NUM_OFFSET		0x164
> +#define PM_INFO_DDRC_PHY_REG_OFFSET		0x168
> +#define PM_INFO_DDRC_PHY_VALUE_OFFSET		0x16c
> +
> +#define MX7_SRC_GPR1	0x74
> +#define MX7_SRC_GPR2	0x78
> +#define GPC_PGC_FM	0xa00
> +#define ANADIG_SNVS_MISC_CTRL	0x380
> +#define DDRC_STAT	0x4
> +#define DDRC_PWRCTL	0x30
> +#define DDRC_PSTAT	0x3fc
> +#define DDRC_PCTRL_0	0x490
> +#define DDRC_DFIMISC	0x1b0
> +#define DDRC_SWCTL	0x320
> +#define DDRC_SWSTAT	0x324
> +#define DDRPHY_LP_CON0	0x18
> +
> +	.align 3
> +
> +	.macro	disable_l1_dcache
> +
> +	/*
> +	 * Flush all data from the L1 data cache before disabling
> +	 * SCTLR.C bit.
> +	 */
> +	push	{r0 - r10, lr}
> +	ldr	r7, =v7_flush_dcache_all
> +	mov	lr, pc
> +	mov	pc, r7
> +	pop	{r0 - r10, lr}
> +
> +	/* disable d-cache */
> +	mrc	p15, 0, r7, c1, c0, 0
> +	bic	r7, r7, #(1 << 2)
> +	mcr	p15, 0, r7, c1, c0, 0
> +	dsb
> +	isb
> +
> +	push	{r0 - r10, lr}
> +	ldr	r7, =v7_flush_dcache_all
> +	mov	lr, pc
> +	mov	pc, r7
> +	pop	{r0 - r10, lr}
> +
> +	.endm
> +
> +	.macro ddrc_enter_self_refresh
> +
> +	ldr	r11, [r0, #PM_INFO_MX7_DDRC_V_OFFSET]
> +
> +	/* let DDR out of self-refresh */
> +	ldr	r7, =0x0
> +	str	r7, [r11, #DDRC_PWRCTL]
> +
> +	/* wait rw port_busy clear */
> +	ldr	r6, =(0x1 << 16)
> +	orr	r6, r6, #0x1
> +1:
> +	ldr	r7, [r11, #DDRC_PSTAT]
> +	ands	r7, r7, r6
> +	bne	1b
> +
> +	/* enter self-refresh bit 5 */
> +	ldr	r7, =(0x1 << 5)
> +	str	r7, [r11, #DDRC_PWRCTL]
> +
> +	/* wait until self-refresh mode entered */
> +2:
> +	ldr	r7, [r11, #DDRC_STAT]
> +	and	r7, r7, #0x3
> +	cmp	r7, #0x3
> +	bne	2b
> +3:
> +	ldr	r7, [r11, #DDRC_STAT]
> +	ands	r7, r7, #0x20
> +	beq	3b
> +
> +	/* disable dram clk */
> +	ldr	r7, [r11, #DDRC_PWRCTL]
> +	orr	r7, r7, #(1 << 3)
> +	str	r7, [r11, #DDRC_PWRCTL]
> +
> +	.endm
> +
> +	.macro ddrc_exit_self_refresh
> +
> +	cmp	r5, #0x0
> +	ldreq	r11, [r0, #PM_INFO_MX7_DDRC_V_OFFSET]
> +	ldrne	r11, [r0, #PM_INFO_MX7_DDRC_P_OFFSET]
> +
> +	/* let DDR out of self-refresh */
> +	ldr	r7, =0x0
> +	str	r7, [r11, #DDRC_PWRCTL]
> +
> +	/* wait until self-refresh mode entered */
> +4:
> +	ldr	r7, [r11, #DDRC_STAT]
> +	and	r7, r7, #0x3
> +	cmp	r7, #0x3
> +	beq	4b
> +
> +	/* enable auto self-refresh */
> +	ldr	r7, [r11, #DDRC_PWRCTL]
> +	orr	r7, r7, #(1 << 0)
> +	str	r7, [r11, #DDRC_PWRCTL]
> +
> +	.endm
> +
> +	.macro wait_delay
> +5:
> +	subs	r6, r6, #0x1
> +	bne	5b
> +
> +	.endm
> +
> +	.macro ddr_enter_retention
> +
> +	ldr	r11, [r0, #PM_INFO_MX7_DDRC_V_OFFSET]
> +
> +	/* let DDR out of self-refresh */
> +	ldr	r7, =0x0
> +	str	r7, [r11, #DDRC_PCTRL_0]
> +
> +	/* wait rw port_busy clear */
> +	ldr	r6, =(0x1 << 16)
> +	orr	r6, r6, #0x1
> +6:
> +	ldr	r7, [r11, #DDRC_PSTAT]
> +	ands	r7, r7, r6
> +	bne	6b
> +
> +	ldr	r11, [r0, #PM_INFO_MX7_DDRC_V_OFFSET]
> +	/* enter self-refresh bit 5 */
> +	ldr	r7, =(0x1 << 5)
> +	str	r7, [r11, #DDRC_PWRCTL]
> +
> +	/* wait until self-refresh mode entered */
> +7:
> +	ldr	r7, [r11, #DDRC_STAT]
> +	and	r7, r7, #0x3
> +	cmp	r7, #0x3
> +	bne	7b
> +8:
> +	ldr	r7, [r11, #DDRC_STAT]
> +	ands	r7, r7, #0x20
> +	beq	8b
> +
> +	/* disable dram clk */
> +	ldr	r7, =(0x1 << 5)
> +	orr	r7, r7, #(1 << 3)
> +	str	r7, [r11, #DDRC_PWRCTL]
> +
> +	/* reset ddr_phy  */
> +	ldr	r11, [r0, #PM_INFO_MX7_ANATOP_V_OFFSET]
> +	ldr	r7, =0x0
> +	str	r7, [r11, #ANADIG_SNVS_MISC_CTRL]
> +
> +	/* delay 7 us */
> +	ldr	r6, =6000
> +	wait_delay
> +
> +	ldr	r11, [r0, #PM_INFO_MX7_SRC_V_OFFSET]
> +	ldr	r6, =0x1000
> +	ldr	r7, [r11, r6]
> +	orr	r7, r7, #0x1
> +	str	r7, [r11, r6]
> +	/* turn off ddr power */
> +	ldr	r11, [r0, #PM_INFO_MX7_ANATOP_V_OFFSET]
> +	ldr	r7, =(0x1 << 29)
> +	str	r7, [r11, #ANADIG_SNVS_MISC_CTRL]
> +
> +	.endm
> +
> +	.macro ddr_exit_retention
> +
> +	cmp	r5, #0x0
> +	ldreq	r1, [r0, #PM_INFO_MX7_ANATOP_V_OFFSET]
> +	ldrne	r1, [r0, #PM_INFO_MX7_ANATOP_P_OFFSET]
> +	ldreq	r2, [r0, #PM_INFO_MX7_SRC_V_OFFSET]
> +	ldrne	r2, [r0, #PM_INFO_MX7_SRC_P_OFFSET]
> +	ldreq	r3, [r0, #PM_INFO_MX7_DDRC_V_OFFSET]
> +	ldrne	r3, [r0, #PM_INFO_MX7_DDRC_P_OFFSET]
> +	ldreq	r4, [r0, #PM_INFO_MX7_DDRC_PHY_V_OFFSET]
> +	ldrne	r4, [r0, #PM_INFO_MX7_DDRC_PHY_P_OFFSET]
> +	ldreq	r10, [r0, #PM_INFO_MX7_CCM_V_OFFSET]
> +	ldrne	r10, [r0, #PM_INFO_MX7_CCM_P_OFFSET]
> +	ldreq	r11, [r0, #PM_INFO_MX7_IOMUXC_GPR_V_OFFSET]
> +	ldrne	r11, [r0, #PM_INFO_MX7_IOMUXC_GPR_P_OFFSET]
> +
> +	/* turn on ddr power */
> +	ldr	r7, =(0x1 << 29)
> +	str	r7, [r1, #ANADIG_SNVS_MISC_CTRL]
> +
> +	ldr	r6, =50
> +	wait_delay
> +
> +	ldr	r7, =0x0
> +	str	r7, [r1, #ANADIG_SNVS_MISC_CTRL]
> +
> +	/* clear ddr_phy reset */
> +	ldr	r6, =0x1000
> +	ldr	r7, [r2, r6]
> +	orr	r7, r7, #0x3
> +	str	r7, [r2, r6]
> +	ldr	r7, [r2, r6]
> +	bic	r7, r7, #0x1
> +	str	r7, [r2, r6]
> +
> +	ldr	r6, [r0, #PM_INFO_DDRC_REG_NUM_OFFSET]
> +	ldr	r7, =PM_INFO_DDRC_REG_OFFSET
> +	add	r7, r7, r0
> +9:
> +	ldr	r8, [r7], #0x4
> +	ldr	r9, [r7], #0x4
> +	str	r9, [r3, r8]
> +	subs	r6, r6, #0x1
> +	bne	9b
> +	ldr	r7, =0x20
> +	str	r7, [r3, #DDRC_PWRCTL]
> +	ldr	r7, =0x0
> +	str	r7, [r3, #DDRC_DFIMISC]
> +
> +	/* do PHY, clear ddr_phy reset */
> +	ldr	r6, =0x1000
> +	ldr	r7, [r2, r6]
> +	bic	r7, r7, #0x2
> +	str	r7, [r2, r6]
> +
> +	ldr	r7, =(0x1 << 30)
> +	str	r7, [r1, #ANADIG_SNVS_MISC_CTRL]
> +
> +	/* need to delay ~5mS */
> +	ldr	r6, =0x100000
> +	wait_delay
> +
> +	ldr	r6, [r0, #PM_INFO_DDRC_PHY_REG_NUM_OFFSET]
> +	ldr	r7, =PM_INFO_DDRC_PHY_REG_OFFSET
> +	add	r7, r7, r0
> +
> +10:
> +	ldr	r8, [r7], #0x4
> +	ldr	r9, [r7], #0x4
> +	str	r9, [r4, r8]
> +	subs	r6, r6, #0x1
> +	bne	10b
> +
> +	ldr	r7, =0x0
> +	add	r9, r10, #0x4000
> +	str	r7, [r9, #0x130]
> +
> +	ldr	r7, =0x170
> +	orr	r7, r7, #0x8
> +	str	r7, [r11, #0x20]
> +
> +	ldr	r7, =0x2
> +	add	r9, r10, #0x4000
> +	str	r7, [r9, #0x130]
> +
> +	ldr	r7, =0xf
> +	str	r7, [r4, #DDRPHY_LP_CON0]
> +
> +	/* wait until self-refresh mode entered */
> +11:
> +	ldr	r7, [r3, #DDRC_STAT]
> +	and	r7, r7, #0x3
> +	cmp	r7, #0x3
> +	bne	11b
> +	ldr	r7, =0x0
> +	str	r7, [r3, #DDRC_SWCTL]
> +	ldr	r7, =0x1
> +	str	r7, [r3, #DDRC_DFIMISC]
> +	ldr	r7, =0x1
> +	str	r7, [r3, #DDRC_SWCTL]
> +12:
> +	ldr	r7, [r3, #DDRC_SWSTAT]
> +	and	r7, r7, #0x1
> +	cmp	r7, #0x1
> +	bne	12b
> +13:
> +	ldr	r7, [r3, #DDRC_STAT]
> +	and	r7, r7, #0x20
> +	cmp	r7, #0x20
> +	bne	13b
> +
> +	/* let DDR out of self-refresh */
> +	ldr	r7, =0x0
> +	str	r7, [r3, #DDRC_PWRCTL]
> +14:
> +	ldr	r7, [r3, #DDRC_STAT]
> +	and	r7, r7, #0x30
> +	cmp	r7, #0x0
> +	bne	14b
> +
> +15:
> +	ldr	r7, [r3, #DDRC_STAT]
> +	and	r7, r7, #0x3
> +	cmp	r7, #0x1
> +	bne	15b
> +
> +	/* enable port */
> +	ldr	r7, =0x1
> +	str	r7, [r3, #DDRC_PCTRL_0]
> +
> +	.endm
> +
> +ENTRY(imx7_suspend)
> +	push	{r4-r12}
> +	/*
> +	 * The value of r0 is mapped the same in origin table and IRAM table,
> +	 * thus no need to care r0 here.
> +	 */
> +	ldr	r1, [r0, #PM_INFO_PBASE_OFFSET]
> +	ldr	r2, [r0, #PM_INFO_RESUME_ADDR_OFFSET]
> +	ldr	r3, [r0, #PM_INFO_DDR_TYPE_OFFSET]
> +	ldr	r4, [r0, #PM_INFO_PM_INFO_SIZE_OFFSET]
> +
> +	/*
> +	 * counting the resume address in iram
> +	 * to set it in SRC register.
> +	 */
> +	ldr	r6, =imx7_suspend
> +	ldr	r7, =resume
> +	sub	r7, r7, r6
> +	add	r8, r1, r4
> +	add	r9, r8, r7
> +
> +	ldr	r11, [r0, #PM_INFO_MX7_SRC_V_OFFSET]
> +	/* store physical resume addr and pm_info address. */
> +	str	r9, [r11, #MX7_SRC_GPR1]
> +	str	r1, [r11, #MX7_SRC_GPR2]
> +
> +	disable_l1_dcache
> +
> +	/*
> +	 * make sure TLB contain the addr we want,
> +	 * as we will access them after DDR is in
> +	 * self-refresh mode.
> +	 */
> +	ldr	r6, [r0, #PM_INFO_MX7_ANATOP_V_OFFSET]
> +	ldr	r7, [r6, #0x0]
> +	ldr	r6, [r0, #PM_INFO_MX7_SRC_V_OFFSET]
> +	ldr	r7, [r6, #0x0]
> +	ldr	r6, [r0, #PM_INFO_MX7_DDRC_V_OFFSET]
> +	ldr	r7, [r6, #0x0]
> +	ldr	r6, [r0, #PM_INFO_MX7_DDRC_PHY_V_OFFSET]
> +	ldr	r7, [r6, #0x0]
> +	ldr	r6, [r0, #PM_INFO_MX7_CCM_V_OFFSET]
> +	ldr	r7, [r6, #0x0]
> +	ldr	r6, [r0, #PM_INFO_MX7_IOMUXC_GPR_V_OFFSET]
> +	ldr	r7, [r0, #0x0]
> +
> +	ldr	r11, [r0, #PM_INFO_MX7_GPC_V_OFFSET]
> +	ldr	r7, [r11, #GPC_PGC_FM]
> +	cmp	r7, #0
> +	beq	ddr_only_self_refresh
> +
> +	ddr_enter_retention
> +	b	ddr_retention_enter_out
> +ddr_only_self_refresh:
> +	ddrc_enter_self_refresh
> +ddr_retention_enter_out:
> +
> +	/* Zzz, enter stop mode */
> +	wfi
> +	nop
> +	nop
> +	nop
> +	nop
> +
> +	mov	r5, #0x0
> +
> +	ldr	r11, [r0, #PM_INFO_MX7_GPC_V_OFFSET]
> +	ldr	r7, [r11, #GPC_PGC_FM]
> +	cmp	r7, #0
> +	beq	wfi_ddr_self_refresh_out
> +
> +	ddr_exit_retention
> +	b	wfi_ddr_retention_out
> +wfi_ddr_self_refresh_out:
> +	ddrc_exit_self_refresh
> +wfi_ddr_retention_out:
> +
> +	pop	{r4-r12}
> +	/* return to suspend finish */
> +	mov	pc, lr
> +
> +resume:
> +	/* invalidate L1 I-cache first */
> +	mov     r6, #0x0
> +	mcr     p15, 0, r6, c7, c5, 0
> +	mcr     p15, 0, r6, c7, c5, 6
> +	/* enable the Icache and branch prediction */
> +	mov     r6, #0x1800
> +	mcr     p15, 0, r6, c1, c0, 0
> +	isb
> +
> +	/* get physical resume address from pm_info. */
> +	ldr	lr, [r0, #PM_INFO_RESUME_ADDR_OFFSET]
> +	/* clear core0's entry and parameter */
> +	ldr	r11, [r0, #PM_INFO_MX7_SRC_P_OFFSET]
> +	mov	r7, #0x0
> +	str	r7, [r11, #MX7_SRC_GPR1]
> +	str	r7, [r11, #MX7_SRC_GPR2]
> +
> +	mov	r5, #0x1
> +
> +	ldr	r11, [r0, #PM_INFO_MX7_GPC_P_OFFSET]
> +	ldr	r7, [r11, #GPC_PGC_FM]
> +	cmp	r7, #0
> +	beq	dsm_ddr_self_refresh_out
> +
> +	ddr_exit_retention
> +	b	dsm_ddr_retention_out
> +dsm_ddr_self_refresh_out:
> +	ddrc_exit_self_refresh
> +dsm_ddr_retention_out:
> +
> +	mov	pc, lr
> +ENDPROC(imx7_suspend)
> +
> +ENTRY(ca7_cpu_resume)
> +	bl	v7_invalidate_l1
> +	b	cpu_resume
> +ENDPROC(ca7_cpu_resume)
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig index
> 6de62a9..6a68cd5 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -158,3 +158,10 @@ config KEYSTONE_IRQ  config MIPS_GIC
>  	bool
>  	select MIPS_CM
> +
> +config IMX_GPCV2
> +	bool
> +	select IRQ_DOMAIN
> +	help
> +	  Enables the wakeup IRQs for IMX platforms with GPCv2 block
> +
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile index
> dda4927..e6f4495 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -47,3 +47,4 @@ obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
>  obj-$(CONFIG_MIPS_GIC)			+= irq-mips-gic.o
>  obj-$(CONFIG_ARCH_MEDIATEK)		+= irq-mtk-sysirq.o
>  obj-$(CONFIG_ARCH_DIGICOLOR)		+= irq-digicolor.o
> +obj-$(CONFIG_IMX_GPCV2)			+= irq-imx-gpcv2.o
> diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c new
> file mode 100644 index 0000000..ab64e94
> --- /dev/null
> +++ b/drivers/irqchip/irq-imx-gpcv2.c
> @@ -0,0 +1,311 @@
> +
> +/*
> + * Copyright (C) 2015 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/slab.h>
> +#include <linux/syscore_ops.h>
> +#include "irqchip.h"
> +
> +#include <soc/imx/gpcv2.h>
> +
> +static struct imx_irq_gpcv2 *gpcv2_get_chip_data(void) {
> +	struct irq_data *data;
> +	int virq;
> +
> +	/* Since GPCv2 is the default IRQ domain, its private data can
> +	 * be gotten from any irq descriptor. Here we use interrupt #19
> +	 * which is for snvs-rtc.
> +	 */
> +	virq = irq_find_mapping(0, 19);
> +
> +	for (data = irq_get_irq_data(virq); data;
> +	     data = data->parent_data) {
> +		if (!data->domain)
> +			continue;
> +
> +		if (!strcmp(data->domain->name, "GPCv2"))
> +			return data->chip_data;
> +	}
> +
> +	return 0;
> +}
> +
> +static int gpcv2_wakeup_source_save(void) {
> +	struct imx_irq_gpcv2 *cd;
> +	void __iomem *reg;
> +	int i;
> +
> +	cd = gpcv2_get_chip_data();
> +	if (!cd)
> +		return 0;
> +
> +	for (i = 0; i < IMR_NUM; i++) {
> +		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> +		cd->enabled_irqs[i] = readl_relaxed(reg);
> +		writel_relaxed(cd->wakeup_sources[i], reg);
> +	}
> +
> +	pr_devel("%s ----\r\n", __func__);
> +	pr_devel("Enabled IRQ:\t %08X %08X %08X %08X\r\n",
> +			cd->enabled_irqs[0],
> +			cd->enabled_irqs[1],
> +			cd->enabled_irqs[2],
> +			cd->enabled_irqs[3]);
> +	pr_devel("Wakeup Sources:\t %08X %08X %08X %08X\r\n",
> +			cd->wakeup_sources[0],
> +			cd->wakeup_sources[1],
> +			cd->wakeup_sources[2],
> +			cd->wakeup_sources[3]);
> +	return 0;
> +}
> +
> +static void gpcv2_wakeup_source_restore(void) {
> +	struct imx_irq_gpcv2 *cd;
> +	void __iomem *reg;
> +	int i;
> +
> +	cd = gpcv2_get_chip_data();
> +	if (!cd)
> +		return;
> +
> +	for (i = 0; i < IMR_NUM; i++) {
> +		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> +		writel_relaxed(cd->enabled_irqs[i], reg);
> +		cd->wakeup_sources[i] = ~0;
> +	}
> +
> +	pr_devel("%s ----\r\n", __func__);
> +	pr_devel("Enabled IRQ:\t %08X %08X %08X %08X\r\n",
> +			cd->enabled_irqs[0],
> +			cd->enabled_irqs[1],
> +			cd->enabled_irqs[2],
> +			cd->enabled_irqs[3]);
> +	pr_devel("Wakeup Sources:\t %08X %08X %08X %08X\r\n",
> +			cd->wakeup_sources[0],
> +			cd->wakeup_sources[1],
> +			cd->wakeup_sources[2],
> +			cd->wakeup_sources[3]);
> +}
> +
> +static struct syscore_ops imx_gpcv2_syscore_ops = {
> +	.suspend	= gpcv2_wakeup_source_save,
> +	.resume		= gpcv2_wakeup_source_restore,
> +};
> +
> +static int imx_gpcv2_irq_set_wake(struct irq_data *d, unsigned int on)
> +{
> +	unsigned int idx = d->hwirq / 32;
> +	struct imx_irq_gpcv2 *cd = d->chip_data;
> +	u32 mask, val;
> +	unsigned long flags;
> +	void __iomem *reg;
> +
> +	spin_lock_irqsave(&cd->lock, flags);
> +	reg = cd->gpc_base + cd->cpu2wakeup + idx * 4;
> +	mask = 1 << d->hwirq % 32;
> +	val = cd->wakeup_sources[idx];
> +
> +	cd->wakeup_sources[idx] = on ? (val & ~mask) : (val | mask);
> +	spin_unlock_irqrestore(&cd->lock, flags);
> +
> +	/*
> +	 * Do *not* call into the parent, as the GIC doesn't have any
> +	 * wake-up facility...
> +	 */
> +
> +	return 0;
> +}
> +
> +
> +static void imx_gpcv2_irq_unmask(struct irq_data *d) {
> +	void __iomem *reg;
> +	struct imx_irq_gpcv2 *cd = d->chip_data;
> +	u32 val;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cd->lock, flags);
> +	reg = cd->gpc_base + cd->cpu2wakeup + d->hwirq / 32 * 4;
> +	val = readl_relaxed(reg);
> +	val &= ~(1 << d->hwirq % 32);
> +	writel_relaxed(val, reg);
> +	irq_chip_unmask_parent(d);
> +	spin_unlock_irqrestore(&cd->lock, flags); }
> +
> +static void imx_gpcv2_irq_mask(struct irq_data *d) {
> +	void __iomem *reg;
> +	struct imx_irq_gpcv2 *cd = d->chip_data;
> +	u32 val;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cd->lock, flags);
> +	reg = cd->gpc_base + cd->cpu2wakeup + d->hwirq / 32 * 4;
> +	val = readl_relaxed(reg);
> +	val |= 1 << (d->hwirq % 32);
> +	writel_relaxed(val, reg);
> +
> +	irq_chip_mask_parent(d);
> +	spin_unlock_irqrestore(&cd->lock, flags); }
> +
> +
> +static struct irq_chip imx_gpcv2_irq_chip = {
> +	.name			= "GPCv2",
> +	.irq_eoi		= irq_chip_eoi_parent,
> +	.irq_mask		= imx_gpcv2_irq_mask,
> +	.irq_unmask		= imx_gpcv2_irq_unmask,
> +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> +	.irq_set_wake		= imx_gpcv2_irq_set_wake,
> +#ifdef CONFIG_SMP
> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> +#endif
> +};
> +
> +static int imx_gpcv2_domain_xlate(struct irq_domain *domain,
> +				struct device_node *controller,
> +				const u32 *intspec,
> +				unsigned int intsize,
> +				unsigned long *out_hwirq,
> +				unsigned int *out_type)
> +{
> +	if (domain->of_node != controller)
> +		return -EINVAL;	/* Shouldn't happen, really... */
> +	if (intsize != 3)
> +		return -EINVAL;	/* Not GIC compliant */
> +	if (intspec[0] != 0)
> +		return -EINVAL;	/* No PPI should point to this domain */
> +
> +	*out_hwirq = intspec[1];
> +	*out_type = intspec[2];
> +	return 0;
> +}
> +
> +static int imx_gpcv2_domain_alloc(struct irq_domain *domain,
> +				  unsigned int irq,
> +				  unsigned int nr_irqs, void *data) {
> +	struct of_phandle_args *args = data;
> +	struct of_phandle_args parent_args;
> +	irq_hw_number_t hwirq;
> +	int i;
> +
> +	if (args->args_count != 3)
> +		return -EINVAL;	/* Not GIC compliant */
> +	if (args->args[0] != 0)
> +		return -EINVAL;	/* No PPI should point to this domain */
> +
> +	hwirq = args->args[1];
> +	if (hwirq >= GPC_MAX_IRQS)
> +		return -EINVAL;	/* Can't deal with this */
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		irq_domain_set_hwirq_and_chip(domain, irq + i, hwirq + i,
> +				&imx_gpcv2_irq_chip, domain->host_data);
> +	}
> +	parent_args = *args;
> +	parent_args.np = domain->parent->of_node;
> +	return irq_domain_alloc_irqs_parent(domain, irq, nr_irqs,
> +&parent_args); }
> +
> +static struct irq_domain_ops imx_gpcv2_irq_domain_ops = {
> +	.xlate	= imx_gpcv2_domain_xlate,
> +	.alloc	= imx_gpcv2_domain_alloc,
> +	.free	= irq_domain_free_irqs_common,
> +};
> +
> +
> +
> +static int __init imx_gpcv2_irqchip_init(struct device_node *node,
> +			       struct device_node *parent)
> +{
> +	struct irq_domain *parent_domain, *domain;
> +	int i, val;
> +	struct imx_irq_gpcv2 *cd;
> +
> +	if (!parent) {
> +		pr_err("%s: no parent, giving up\n", node->full_name);
> +		return -ENODEV;
> +	}
> +
> +	parent_domain = irq_find_host(parent);
> +	if (!parent_domain) {
> +		pr_err("%s: unable to obtain parent domain\n", node->full_name);
> +		return -ENXIO;
> +	}
> +
> +	cd = kzalloc(sizeof(struct imx_irq_gpcv2), GFP_KERNEL);
> +	BUG_ON(!cd);
> +
> +	cd->gpc_base = of_iomap(node, 0);
> +	if (!cd->gpc_base) {
> +		pr_err("fsl-gpcv2: unable to map gpc registers\n");
> +		kzfree(cd);
> +		return -ENOMEM;
> +	}
> +
> +	domain = irq_domain_add_hierarchy(parent_domain, 0, GPC_MAX_IRQS,
> +				node, &imx_gpcv2_irq_domain_ops, cd);
> +	if (!domain) {
> +		iounmap(cd->gpc_base);
> +		kzfree(cd);
> +		return -ENOMEM;
> +	}
> +	irq_set_default_host(domain);
> +
> +	/* Initially mask all interrupts */
> +	for (i = 0; i < IMR_NUM; i++) {
> +		writel_relaxed(~0, cd->gpc_base + GPC_IMR1_CORE0 + i * 4);
> +		writel_relaxed(~0, cd->gpc_base + GPC_IMR1_CORE1 + i * 4);
> +		cd->wakeup_sources[i] = ~0;
> +	}
> +
> +	/* Let CORE0 as the default CPU to wake up by GPC */
> +	cd->cpu2wakeup = GPC_IMR1_CORE0;
> +
> +	/*
> +	 * Due to hardware design requirement, need to make sure GPR
> +	 * interrupt(#32) is unmasked during RUN mode to avoid entering
> +	 * DSM by mistake.
> +	 */
> +	writel_relaxed(~0x1, cd->gpc_base + cd->cpu2wakeup);
> +
> +	/* Mask the wakeup sources in M/F power domain */
> +	cd->mfmix_mask[0] = 0x54010000;
> +	cd->mfmix_mask[1] = 0xc00;
> +	cd->mfmix_mask[2] = 0x0;
> +	cd->mfmix_mask[3] = 0x400010;
> +
> +	/* only external IRQs to wake up LPM and core 0/1 */
> +	val = readl_relaxed(cd->gpc_base + GPC_LPCR_A7_BSC);
> +	val |= BM_LPCR_A7_BSC_IRQ_SRC_A7_WAKEUP;
> +	writel_relaxed(val, cd->gpc_base + GPC_LPCR_A7_BSC);
> +	/* mask m4 dsm trigger */
> +	writel_relaxed(readl_relaxed(cd->gpc_base + GPC_LPCR_M4) |
> +		BM_LPCR_M4_MASK_DSM_TRIGGER, cd->gpc_base +
> GPC_LPCR_M4);
> +	/* set mega/fast mix in A7 domain */
> +	writel_relaxed(0x1, cd->gpc_base + GPC_PGC_CPU_MAPPING);
> +	/* set SCU timing */
> +	writel_relaxed((0x59 << 10) | 0x5B | (0x51 << 20),
> +		cd->gpc_base + GPC_PGC_SCU_TIMING);
> +
> +	register_syscore_ops(&imx_gpcv2_syscore_ops);
> +
> +	return 0;
> +}
> +
> +
> +IRQCHIP_DECLARE(imx_gpcv2, "fsl,imx7d-gpc", imx_gpcv2_irqchip_init);
> +
> +
> diff --git a/include/soc/imx/gpcv2.h b/include/soc/imx/gpcv2.h new file mode
> 100644 index 0000000..aec862cd
> --- /dev/null
> +++ b/include/soc/imx/gpcv2.h
> @@ -0,0 +1,137 @@
> +/*
> + * Copyright (C) 2015 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __SOC_IMX_GPCV2_H__
> +#define __SOC_IMX_GPCV2_H__
> +
> +
> +#define IMR_NUM			4
> +#define GPC_MAX_IRQS            (IMR_NUM * 32)
> +
> +#define GPC_LPCR_A7_BSC		0x0
> +#define GPC_LPCR_M4		0x8
> +
> +#define GPC_IMR1_CORE0		0x30
> +#define GPC_IMR1_CORE1		0x40
> +
> +#define GPC_PGC_CPU_MAPPING	0xec
> +#define GPC_PGC_SCU_TIMING	0x890
> +
> +#define BM_LPCR_A7_BSC_IRQ_SRC_A7_WAKEUP	0x70000000
> +#define BM_LPCR_M4_MASK_DSM_TRIGGER		0x80000000
> +
> +
> +#define GPC_LPCR_A7_AD		0x4
> +#define GPC_SLPCR		0x14
> +#define GPC_PGC_ACK_SEL_A7	0x24
> +
> +#define GPC_SLOT0_CFG		0xb0
> +
> +#define GPC_PGC_C0		0x800
> +#define GPC_PGC_SCU_TIMING	0x890
> +#define GPC_PGC_C1		0x840
> +#define GPC_PGC_SCU		0x880
> +#define GPC_PGC_FM		0xa00
> +
> +#define BM_LPCR_A7_BSC_CPU_CLK_ON_LPM		0x4000
> +#define BM_LPCR_A7_BSC_LPM1			0xc
> +#define BM_LPCR_A7_BSC_LPM0			0x3
> +#define BP_LPCR_A7_BSC_LPM1			2
> +#define BP_LPCR_A7_BSC_LPM0			0
> +
> +#define BM_SLPCR_EN_DSM				0x80000000
> +#define BM_SLPCR_RBC_EN				0x40000000
> +#define BM_SLPCR_VSTBY				0x4
> +#define BM_SLPCR_SBYOS				0x2
> +#define BM_SLPCR_BYPASS_PMIC_READY		0x1
> +
> +
> +#define BM_LPCR_A7_AD_L2PGE			0x10000
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
> +#define BM_GPC_PGC_ACK_SEL_A7_DUMMY_PUP_ACK	0x80000000
> +#define BM_GPC_PGC_ACK_SEL_A7_DUMMY_PDN_ACK	0x8000
> +
> +#define MAX_SLOT_NUMBER				10
> +#define A7_LPM_WAIT				0x5
> +#define A7_LPM_STOP				0xa
> +
> +
> +#define REG_SET		0x4
> +#define REG_CLR		0x8
> +
> +#define ANADIG_ARM_PLL		0x60
> +#define ANADIG_DDR_PLL		0x70
> +#define ANADIG_SYS_PLL		0xb0
> +#define ANADIG_ENET_PLL		0xe0
> +#define ANADIG_AUDIO_PLL	0xf0
> +#define ANADIG_VIDEO_PLL	0x130
> +
> +
> +enum gpcv2_mode {
> +	WAIT_CLOCKED,		/* wfi only */
> +	WAIT_UNCLOCKED,		/* WAIT */
> +	WAIT_UNCLOCKED_POWER_OFF,	/* WAIT + SRPG */
> +	STOP_POWER_ON,		/* just STOP */
> +	STOP_POWER_OFF,		/* STOP + SRPG */
> +};
> +
> +enum gpcv2_slot {
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
> +
> +struct imx_irq_gpcv2 {
> +	spinlock_t lock;
> +	void __iomem *gpc_base;
> +	struct regmap *anatop;
> +	struct regmap *imx_src;
> +	u32 wakeup_sources[IMR_NUM];
> +	u32 enabled_irqs[IMR_NUM];
> +	u32 mfmix_mask[IMR_NUM];
> +	u32 wakeupmix_mask[IMR_NUM];
> +	u32 lpsrmix_mask[IMR_NUM];
> +	u32 cpu2wakeup;
> +	void (*lpm_env_setup)(struct imx_irq_gpcv2 *);
> +	void (*lpm_env_clean)(struct imx_irq_gpcv2 *);
> +	void (*lpm_cpu_power_gate)(struct imx_irq_gpcv2 *, u32, bool);
> +	void (*lpm_plat_power_gate)(struct imx_irq_gpcv2 *, bool);
> +	void (*set_mode)(struct imx_irq_gpcv2 *, enum gpcv2_mode mode);
> +	void (*standby)(struct imx_irq_gpcv2 *);
> +	void (*suspend)(struct imx_irq_gpcv2 *);
> +	void (*set_slot)(struct imx_irq_gpcv2 *cd, u32 index,
> +			enum gpcv2_slot m_core, bool mode, bool ack);
> +	void (*clear_slots)(struct imx_irq_gpcv2 *);
> +	void (*lpm_enable_core)(struct imx_irq_gpcv2 *,
> +			bool enable, u32 offset);
> +
> +
> +	void (*suspend_fn_in_ocram)(void __iomem *ocram_vbase);
> +	void __iomem *ocram_vbase;
> +};
> +
> +void ca7_cpu_resume(void);
> +void imx7_suspend(void __iomem *ocram_vbase);
> +
> +#endif  /* __SOC_IMX_GPCV2_H__ */
> --
> 1.9.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
