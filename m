From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Fri, 31 Jul 2015 15:26:30 +0000
Subject: [PATCH v7 2/2] ARM: imx: Add suspend codes for imx7D
In-Reply-To: <b6623a40ae0a76c05af0bf428f723479@agner.ch>
References: <1438025400-5919-1-git-send-email-shenwei.wang@freescale.com>
 <1438025400-5919-3-git-send-email-shenwei.wang@freescale.com>
 <b6623a40ae0a76c05af0bf428f723479@agner.ch>
Message-ID: <CY1PR0301MB0843AE1B324FFB8EA41319F3838A0@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

> -----Original Message-----
> From: Stefan Agner [mailto:stefan at agner.ch]
> Sent: 2015?7?30? 17:44
> To: Wang Shenwei-B38339
> Cc: shawn.guo at linaro.org; tglx at linutronix.de; jason at lakedaemon.net; Huang
> Yongcai-B20788; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v7 2/2] ARM: imx: Add suspend codes for imx7D
> 
> Hi Shenwei,
> 
> The Subject sounds somewhat strange, if you mean your program code, then you
> should not use the plural. Or maybe "add suspend states..." or "support suspend
> states..."?

Good suggestion! Will change to support suspend states on imx7d.

> On 2015-07-27 21:30, Shenwei Wang wrote:
> > IMX7D contains a new version of GPC IP block (GPCv2). It has two major
> > functions: power management and wakeup source management.
> >
> > GPCv2 provides low power mode control for Cortex-A7 and Cortex-M4
> > domains. And it can support WAIT, STOP, and DSM(Deep Sleep Mode) modes.
> > After configuring the GPCv2 module, the platform can enter into a
> > selected mode either automatically triggered by ARM WFI instruction or
> > manually by software. The system will exit the low power states by the
> > predefined wakeup sources which are managed by the gpcv2 irqchip
> > driver.
> >
> > This patch adds a new suspend driver to manage the power states on IMX7D.
> > It currently supports "SUSPEND_STANDBY" and "SUSPEND_MEM" states.
> >
> > Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
> > Signed-off-by: Anson Huang <b20788@freescale.com>
> > ---
> >  arch/arm/mach-imx/Kconfig        |   1 +
> >  arch/arm/mach-imx/Makefile       |   2 +
> >  arch/arm/mach-imx/pm-imx7.c      | 901
> +++++++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-imx/suspend-imx7.S | 529 +++++++++++++++++++++++
> >  4 files changed, 1433 insertions(+)
> >  create mode 100644 arch/arm/mach-imx/pm-imx7.c  create mode 100644
> > arch/arm/mach-imx/suspend-imx7.S
> >
> > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > index 8ceda28..54f8553 100644
> > --- a/arch/arm/mach-imx/Kconfig
> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -562,6 +562,7 @@ config SOC_IMX7D
> >  	select ARM_GIC
> >  	select HAVE_IMX_ANATOP
> >  	select HAVE_IMX_MMDC
> > +	select IMX_GPCV2
> >  	help
> >  		This enables support for Freescale i.MX7 Dual processor.
> >
> > diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> > index fb689d8..ca4c566 100644
> > --- a/arch/arm/mach-imx/Makefile
> > +++ b/arch/arm/mach-imx/Makefile
> > @@ -88,6 +88,8 @@ obj-$(CONFIG_SOC_IMX7D) += mach-imx7d.o
> >
> >  ifeq ($(CONFIG_SUSPEND),y)
> >  AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
> > +AFLAGS_suspend-imx7.o :=-Wa,-march=armv7-a
> > +obj-$(CONFIG_IMX_GPCV2)	+= suspend-imx7.o pm-imx7.o
> >  obj-$(CONFIG_SOC_IMX6) += suspend-imx6.o
> 
> A rather strange ordering, can you keep the AFLAGS near the object file?
> 
> >  obj-$(CONFIG_SOC_IMX53) += suspend-imx53.o  endif diff --git
> > a/arch/arm/mach-imx/pm-imx7.c b/arch/arm/mach-imx/pm-imx7.c new file
> > mode 100644 index 0000000..9035368
> > --- /dev/null
> > +++ b/arch/arm/mach-imx/pm-imx7.c
> > @@ -0,0 +1,901 @@
> > +/*
> > + * Copyright (C) 2015 Freescale Semiconductor, Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/regmap.h>
> > +#include <linux/suspend.h>
> > +#include <linux/slab.h>
> > +#include <asm/suspend.h>
> > +#include <asm/fncpy.h>
> > +
> > +#include <soc/imx/gpcv2.h>
> > +
> > +#define BM_LPCR_A7_AD_L2PGE			0x10000
> > +#define BM_LPCR_A7_AD_EN_C1_PUP			0x800
> > +#define BM_LPCR_A7_AD_EN_C1_IRQ_PUP		0x400
> > +#define BM_LPCR_A7_AD_EN_C0_PUP			0x200
> > +#define BM_LPCR_A7_AD_EN_C0_IRQ_PUP		0x100
> > +#define BM_LPCR_A7_AD_EN_PLAT_PDN		0x10
> > +#define BM_LPCR_A7_AD_EN_C1_PDN			0x8
> > +#define BM_LPCR_A7_AD_EN_C1_WFI_PDN		0x4
> > +#define BM_LPCR_A7_AD_EN_C0_PDN			0x2
> > +#define BM_LPCR_A7_AD_EN_C0_WFI_PDN		0x1
> > +
> > +#define BM_LPCR_A7_BSC_IRQ_SRC_A7_WAKEUP	0x70000000
> > +#define BM_LPCR_A7_BSC_CPU_CLK_ON_LPM		0x4000
> > +#define BM_LPCR_A7_BSC_LPM1			0xc
> > +#define BM_LPCR_A7_BSC_LPM0			0x3
> > +#define BP_LPCR_A7_BSC_LPM1			2
> > +#define BP_LPCR_A7_BSC_LPM0			0
> > +
> > +#define BM_LPCR_M4_MASK_DSM_TRIGGER		0x80000000
> > +
> > +#define BM_SLPCR_EN_DSM				0x80000000
> > +#define BM_SLPCR_RBC_EN				0x40000000
> > +#define BM_SLPCR_VSTBY				0x4
> > +#define BM_SLPCR_SBYOS				0x2
> > +#define BM_SLPCR_BYPASS_PMIC_READY		0x1
> > +
> > +#define BM_GPC_PGC_ACK_SEL_A7_DUMMY_PUP_ACK	0x80000000
> > +#define BM_GPC_PGC_ACK_SEL_A7_DUMMY_PDN_ACK	0x8000
> 
> Typically the bit field size + shifts is used here, e.g.

Okay.

> #define BM_LPCR_A7_BSC_IRQ_SRC_A7_WAKEUP	(0x7 << 28)
> #define BM_LPCR_A7_BSC_CPU_CLK_ON_LPM		(0x1 << 14)
> 
> This is much easier to verify against the data sheet.
> 
> > +
> > +#define GPC_LPCR_A7_BSC		0x0
> > +#define GPC_LPCR_A7_AD		0x4
> > +#define GPC_LPCR_M4		0x8
> > +
> > +#define GPC_PGC_CPU_MAPPING	0xec
> > +#define GPC_PGC_SCU_TIMING	0x890
> > +
> > +#define GPC_SLPCR		0x14
> > +#define GPC_PGC_ACK_SEL_A7	0x24
> > +
> > +#define GPC_SLOT0_CFG		0xb0
> > +
> > +#define GPC_PGC_C0		0x800
> > +#define GPC_PGC_SCU_TIMING	0x890
> > +#define GPC_PGC_C1		0x840
> > +#define GPC_PGC_SCU		0x880
> > +#define GPC_PGC_FM		0xa00
> > +
> > +#define ANADIG_ARM_PLL		0x60
> > +#define ANADIG_DDR_PLL		0x70
> > +#define ANADIG_SYS_PLL		0xb0
> > +#define ANADIG_ENET_PLL		0xe0
> > +#define ANADIG_AUDIO_PLL	0xf0
> > +#define ANADIG_VIDEO_PLL	0x130
> > +
> > +#define MAX_SLOT_NUMBER		10
> > +#define A7_LPM_WAIT		0x5
> > +#define A7_LPM_STOP		0xa
> > +
> > +#define REG_SET			0x4
> > +#define REG_CLR			0x8
> > +
> > +enum gpcv2_mode {
> > +	WAIT_CLOCKED,
> > +	WAIT_UNCLOCKED,
> > +	WAIT_UNCLOCKED_POWER_OFF,
> > +	STOP_POWER_ON,
> > +	STOP_POWER_OFF,
> > +};
> > +
> > +/* GPCv2 has the following power domains, and each domain can be
> > +power-up
> > + * and power-down via GPC settings.
> > + *
> > + * 	Core 0 of A7 power domain
> > + * 	Core1 of A7 power domain
> > + * 	SCU/L2 cache RAM of A7 power domain
> > + * 	Fastmix and megamix power domain
> > + * 	USB OTG1 PHY power domain
> > + * 	USB OTG2 PHY power domain
> > + * 	PCIE PHY power domain
> > + * 	USB HSIC PHY power domain
> > + *	Core 0 of M4 power domain
> > + */
> 
> Nit: a empty line is the preferred format in this part of the kernel:
> 
> /*
>  * Start here...
> 

Okay.

> > +enum gpcv2_slot {
> > +	CORE0_A7,
> > +	CORE1_A7,
> > +	SCU_A7,
> > +	FAST_MEGA_MIX,
> > +	MIPI_PHY,
> > +	PCIE_PHY,
> > +	USB_OTG1_PHY,
> > +	USB_OTG2_PHY,
> > +	USB_HSIC_PHY,
> > +	CORE0_M4,
> > +};
> > +
> > +struct imx_gpcv2;
> > +
> > +struct imx_gpcv2_suspend {
> > +	struct regmap *anatop;
> > +	struct regmap *imx_src;
> > +	u32 mfmix_mask[IMR_NUM];
> > +	u32 wakeupmix_mask[IMR_NUM];
> > +	u32 lpsrmix_mask[IMR_NUM];
> > +
> > +	void (*set_mode)(struct imx_gpcv2 *, enum gpcv2_mode mode);
> > +	void (*lpm_cpu_power_gate)(struct imx_gpcv2 *, u32, bool);
> > +	void (*lpm_plat_power_gate)(struct imx_gpcv2 *, bool);
> > +	void (*lpm_env_setup)(struct imx_gpcv2 *);
> > +	void (*lpm_env_clean)(struct imx_gpcv2 *);
> > +
> > +	void (*set_slot)(struct imx_gpcv2 *cd, u32 index,
> > +			enum gpcv2_slot m_core, bool mode, bool ack);
> > +	void (*clear_slots)(struct imx_gpcv2 *);
> > +	void (*lpm_enable_core)(struct imx_gpcv2 *,
> > +			bool enable, u32 offset);
> > +
> > +	void (*standby)(struct imx_gpcv2 *);
> > +	void (*suspend)(struct imx_gpcv2 *);
> > +
> > +	void (*suspend_fn_in_ocram)(void __iomem *ocram_vbase);
> > +	void __iomem *ocram_vbase;
> > +};
> > +
> > +struct imx_gpcv2 {
> > +	spinlock_t lock;
> > +	struct imx_gpcv2_irq *irqchip;
> > +	struct imx_gpcv2_suspend *pm;
> > +};
> > +
> > +extern struct imx_gpcv2_irq *gpcv2_irq_instance; static struct
> > +imx_gpcv2 *gpcv2_instance;
> > +
> > +static void imx_gpcv2_lpm_clear_slots(struct imx_gpcv2 *gpc) {
> > +	struct imx_gpcv2_irq *cd = gpc->irqchip;
> > +	unsigned long flags;
> > +	int i;
> > +
> > +	spin_lock_irqsave(&gpc->lock, flags);
> > +	for (i = 0; i < MAX_SLOT_NUMBER; i++)
> > +		writel_relaxed(0x0, cd->gpc_base + GPC_SLOT0_CFG + i * 0x4);
> > +	writel_relaxed(BM_GPC_PGC_ACK_SEL_A7_DUMMY_PUP_ACK |
> > +		BM_GPC_PGC_ACK_SEL_A7_DUMMY_PDN_ACK,
> > +		cd->gpc_base + GPC_PGC_ACK_SEL_A7);
> > +
> > +	spin_unlock_irqrestore(&gpc->lock, flags); }
> > +
> > +static void imx_gpcv2_lpm_enable_core(struct imx_gpcv2 *gpc,
> > +			bool enable, u32 offset)
> > +{
> > +	struct imx_gpcv2_irq *cd = gpc->irqchip;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&gpc->lock, flags);
> > +	writel_relaxed(enable, cd->gpc_base + offset);
> > +	spin_unlock_irqrestore(&gpc->lock, flags); }
> > +
> > +static void imx_gpcv2_lpm_slot_setup(struct imx_gpcv2 *gpc,
> > +		u32 index, enum gpcv2_slot m_core, bool mode, bool ack) {
> > +	struct imx_gpcv2_irq *cd = gpc->irqchip;
> > +	unsigned long flags;
> > +	u32 val;
> > +
> > +	if (index >= MAX_SLOT_NUMBER)
> > +		pr_err("Invalid slot index!\n");
> 
> Is a return missing here? The check seems rather useless otherwise.

Yes, should return here.

> > +
> > +	spin_lock_irqsave(&gpc->lock, flags);
> > +	/* set slot */
> > +	writel_relaxed((mode + 1) << (m_core * 2), cd->gpc_base +
> > +		GPC_SLOT0_CFG + index * 4);
> 
> Can you create a preprocessor for the slot register?
> 
> #define GPC_SLOTx_CFG(x) (0xb0 + 4 * (x))
> 
> The parameter m_core has a unintuitive name, slot sounds much better to me.
> 
> Also boolean and an addition is somewhat strange, I would prefer something like:
> mode ? 0x2 : 0x1 << (slot * 2)

Yes. Will follow this idea in the new patch.

> > +
> > +	if (ack) {
> > +		/* set ack */
> > +		val = readl_relaxed(cd->gpc_base + GPC_PGC_ACK_SEL_A7);
> > +		/* clear dummy ack */
> > +		val &= ~(1 << (15 + (mode ? 16 : 0)));
> > +		val |= 1 << (m_core + (mode ? 16 : 0));
> 
> Can you come up with macros here too? That is not readable...
> 
> For the dummy ack I would suggest to create dedicated defines and for the power
> domain acks something which takes the slot as argument...

Will consider that in new patch.


> > +		writel_relaxed(val, cd->gpc_base + GPC_PGC_ACK_SEL_A7);
> > +	}
> > +
> > +	spin_unlock_irqrestore(&gpc->lock, flags); }
> > +
> > +static void imx_gpcv2_lpm_env_setup(struct imx_gpcv2 *gpc) {
> > +	struct imx_gpcv2_suspend *pm = gpc->pm;
> > +
> > +	/* PLL and PFDs overwrite set */
> > +	regmap_write(pm->anatop, ANADIG_ARM_PLL + REG_SET, 1 << 20);
> > +	regmap_write(pm->anatop, ANADIG_DDR_PLL + REG_SET, 1 << 19);
> > +	regmap_write(pm->anatop, ANADIG_SYS_PLL + REG_SET, 0x1ff << 17);
> > +	regmap_write(pm->anatop, ANADIG_ENET_PLL + REG_SET, 1 << 13);
> > +	regmap_write(pm->anatop, ANADIG_AUDIO_PLL + REG_SET, 1 << 24);
> > +	regmap_write(pm->anatop, ANADIG_VIDEO_PLL + REG_SET, 1 << 24); }
> > +
> > +static void imx_gpcv2_lpm_env_clean(struct imx_gpcv2 *gpc) {
> > +	struct imx_gpcv2_suspend *pm = gpc->pm;
> > +
> > +	/* PLL and PFDs overwrite clear */
> > +	regmap_write(pm->anatop, ANADIG_ARM_PLL + REG_CLR, 1 << 20);
> > +	regmap_write(pm->anatop, ANADIG_DDR_PLL + REG_CLR, 1 << 19);
> > +	regmap_write(pm->anatop, ANADIG_SYS_PLL + REG_CLR, 0x1ff << 17);
> > +	regmap_write(pm->anatop, ANADIG_ENET_PLL + REG_CLR, 1 << 13);
> > +	regmap_write(pm->anatop, ANADIG_AUDIO_PLL + REG_CLR, 1 << 24);
> > +	regmap_write(pm->anatop, ANADIG_VIDEO_PLL + REG_CLR, 1 << 24); }
> > +
> > +static void imx_gpcv2_lpm_set_mode(struct imx_gpcv2 *gpc,
> > +		enum gpcv2_mode mode)
> > +{
> > +	struct imx_gpcv2_irq *cd = gpc->irqchip;
> > +	unsigned long flags;
> > +	u32 val1, val2;
> 
> Please use names which say something. tmp and i is ok, if it's a temporary
> variable or a counter, but not val1/val2...
> 
> > +
> > +	spin_lock_irqsave(&gpc->lock, flags);
> > +
> > +	val1 = readl_relaxed(cd->gpc_base + GPC_LPCR_A7_BSC);
> > +	val2 = readl_relaxed(cd->gpc_base + GPC_SLPCR);
> > +
> > +	/* all cores' LPM settings must be same */
> > +	val1 &= ~(BM_LPCR_A7_BSC_LPM0 | BM_LPCR_A7_BSC_LPM1);
> > +
> > +	val1 |= BM_LPCR_A7_BSC_CPU_CLK_ON_LPM;
> > +
> > +	val2 &= ~(BM_SLPCR_EN_DSM | BM_SLPCR_VSTBY | BM_SLPCR_RBC_EN |
> > +		BM_SLPCR_SBYOS | BM_SLPCR_BYPASS_PMIC_READY);
> > +	/*
> > +	 * GPCv2: When improper low-power sequence is used,
> > +	 * the SoC enters low power mode before the ARM core executes WFI.
> > +	 *
> > +	 * Software workaround:
> > +	 * 1) Software should trigger IRQ #32 (IOMUX) to be always pending
> > +	 *    by setting IOMUX_GPR1_IRQ.
> > +	 * 2) Software should then unmask IRQ #32 in GPC before setting GPC
> > +	 *    Low-Power mode.
> > +	 * 3) Software should mask IRQ #32 right after GPC Low-Power mode
> > +	 *    is set.
> > +	 */
> > +	switch (mode) {
> > +	case WAIT_CLOCKED:
> > +		break;
> > +	case WAIT_UNCLOCKED:
> > +		val1 |= A7_LPM_WAIT << BP_LPCR_A7_BSC_LPM0;
> > +		val1 &= ~BM_LPCR_A7_BSC_CPU_CLK_ON_LPM;
> > +		break;
> > +	case STOP_POWER_ON:
> > +		val1 |= A7_LPM_STOP << BP_LPCR_A7_BSC_LPM0;
> > +		val1 &= ~BM_LPCR_A7_BSC_CPU_CLK_ON_LPM;
> > +		val2 |= BM_SLPCR_EN_DSM;
> > +		val2 |= BM_SLPCR_RBC_EN;
> > +		val2 |= BM_SLPCR_BYPASS_PMIC_READY;
> > +		break;
> > +	case STOP_POWER_OFF:
> > +		val1 |= A7_LPM_STOP << BP_LPCR_A7_BSC_LPM0;
> > +		val1 &= ~BM_LPCR_A7_BSC_CPU_CLK_ON_LPM;
> > +		val2 |= BM_SLPCR_EN_DSM;
> > +		val2 |= BM_SLPCR_RBC_EN;
> > +		val2 |= BM_SLPCR_SBYOS;
> > +		val2 |= BM_SLPCR_VSTBY;
> > +		val2 |= BM_SLPCR_BYPASS_PMIC_READY;
> > +		break;
> > +	default:
> > +		return;
> 
> What about the spin lock?

It is a bug.

> > +	}
> > +	writel_relaxed(val1, cd->gpc_base + GPC_LPCR_A7_BSC);
> > +	writel_relaxed(val2, cd->gpc_base + GPC_SLPCR);
> > +
> > +	spin_unlock_irqrestore(&gpc->lock, flags); }
> > +
> > +
> > +static void imx_gpcv2_lpm_cpu_power_gate(struct imx_gpcv2 *gpc,
> > +				u32 cpu, bool pdn)
> 
> Hm, pdn is somewhat overused here. Your bool pdn says that you want to power
> gate a certain core. Below you then set PDN and PUP, that is somewhat confusing.
> Maybe bool engate or en_lpm?

Good suggestion!

> > +{
> > +	struct imx_gpcv2_irq *cd = gpc->irqchip;
> > +	unsigned long flags;
> > +	u32 val;
> > +
> > +	const u32 val_pdn[2] = {
> > +		BM_LPCR_A7_AD_EN_C0_PDN | BM_LPCR_A7_AD_EN_C0_PUP,
> > +		BM_LPCR_A7_AD_EN_C1_PDN | BM_LPCR_A7_AD_EN_C1_PUP,
> > +	};
> > +
> > +	spin_lock_irqsave(&gpc->lock, flags);
> > +
> > +	val = readl_relaxed(cd->gpc_base + GPC_LPCR_A7_AD);
> > +	if (pdn)
> > +		val |= val_pdn[cpu];
> > +	else
> > +		val &= ~val_pdn[cpu];
> > +
> > +	writel_relaxed(val, cd->gpc_base + GPC_LPCR_A7_AD);
> > +	spin_unlock_irqrestore(&gpc->lock, flags); }
> > +
> > +static void imx_lpm_plat_power_gate(struct imx_gpcv2 *gpc, bool pdn)
> > +{
> > +	struct imx_gpcv2_irq *cd = gpc->irqchip;
> > +	unsigned long flags;
> > +	u32 val;
> > +
> > +	spin_lock_irqsave(&gpc->lock, flags);
> > +	val = readl_relaxed(cd->gpc_base + GPC_LPCR_A7_AD);
> > +	val &= ~(BM_LPCR_A7_AD_EN_PLAT_PDN | BM_LPCR_A7_AD_L2PGE);
> > +	if (pdn)
> > +		val |= BM_LPCR_A7_AD_EN_PLAT_PDN | BM_LPCR_A7_AD_L2PGE;
> > +
> > +	writel_relaxed(val, cd->gpc_base + GPC_LPCR_A7_AD);
> > +	spin_unlock_irqrestore(&gpc->lock, flags); }
> > +
> > +static void imx_gpcv2_lpm_standby(struct imx_gpcv2 *gpc) {
> > +	struct imx_gpcv2_suspend *pm = gpc->pm;
> > +
> > +	pm->lpm_env_setup(gpc);
> > +	/* pm->set_mode(gpc, STOP_POWER_OFF); */
> > +	pm->set_mode(gpc, WAIT_UNCLOCKED);
> > +
> > +	pr_debug("[GPCv2] %s %d\r\n", __func__, __LINE__);
> > +	/* Zzz ... */
> > +	cpu_do_idle();
> > +
> > +	pm->set_mode(gpc, WAIT_CLOCKED);
> > +	pm->lpm_env_clean(gpc);
> > +}
> > +
> > +
> > +
> > +static int gpcv2_suspend_finish(unsigned long val) {
> > +	struct imx_gpcv2_suspend *pm = (struct imx_gpcv2_suspend *)val;
> > +
> > +	if (!pm->suspend_fn_in_ocram) {
> > +		cpu_do_idle();
> > +	} else {
> > +		/*
> > +		 * call low level suspend function in ocram,
> > +		 * as we need to float DDR IO.
> > +		 */
> > +		local_flush_tlb_all();
> > +		pm->suspend_fn_in_ocram(pm->ocram_vbase);
> > +	}
> > +
> > +	return 0;
> > +}
> > +static void imx_gpcv2_lpm_suspend(struct imx_gpcv2 *gpc) {
> > +	struct imx_gpcv2_suspend *pm = gpc->pm;
> > +	struct imx_gpcv2_irq *cd = gpc->irqchip;
> > +	int i = 0;
> > +
> > +	pm->lpm_env_setup(gpc);
> > +	pm->set_mode(gpc, STOP_POWER_OFF);
> > +
> > +	/* enable core0 power down/up with low power mode */
> > +	pm->lpm_cpu_power_gate(gpc, 0, true);
> > +
> > +	/* enable plat power down with low power mode */
> > +	pm->lpm_plat_power_gate(gpc, true);
> > +
> > +	/*
> > +	 * To avoid confuse, we use slot 0~4 for power down,
> > +	 * slot 5~9 for power up.
> > +	 *
> > +	 * Power down slot sequence:
> > +	 * Slot0 -> CORE0
> > +	 * Slot1 -> Mega/Fast MIX
> > +	 * Slot2 -> SCU
> > +	 *
> > +	 * Power up slot sequence:
> > +	 * Slot5 -> Mega/Fast MIX
> > +	 * Slot6 -> SCU
> > +	 * Slot7 -> CORE0
> > +	 */
> > +	pm->set_slot(gpc, 0, CORE0_A7, false, false);
> > +	pm->set_slot(gpc, 2, SCU_A7, false, true);
> 
> Maybe it would be better to introduce a enum for the power-up/power-down?
> 
> 
> > +
> > +	for (i = 0; i < IMR_NUM; i++) {
> > +		if ((~cd->wakeup_sources[i] & pm->mfmix_mask[i]) != 0)
> > +			break;
> > +
> > +		pm->set_slot(gpc, 1, FAST_MEGA_MIX, false, false);
> > +		pm->set_slot(gpc, 5, FAST_MEGA_MIX, true, false);
> > +		pm->lpm_enable_core(gpc, true, GPC_PGC_FM);
> > +		break;
> > +	}
> 
> This is somewhat weird. You break either way in the first loop don't you? Why
> using a loop then?

It is a logic bug. Corrected it in the new patch.

> > +
> > +	pm->set_slot(gpc, 6, SCU_A7, true, false);
> > +	pm->set_slot(gpc, 7, CORE0_A7, true, true);
> > +
> > +	/* enable core0, scu */
> > +	pm->lpm_enable_core(gpc, true, GPC_PGC_C0);
> > +	pm->lpm_enable_core(gpc, true, GPC_PGC_SCU);
> > +
> > +	/* Suspend to MEM has not been implemented yet */
> > +	cpu_suspend((unsigned long)pm, gpcv2_suspend_finish);
> 
> What does that mean?

It is an old comment. Will remove it.
 

> > +
> > +	pm->lpm_env_clean(gpc);
> > +	pm->set_mode(gpc, WAIT_CLOCKED);
> > +	pm->lpm_cpu_power_gate(gpc, 0, false);
> > +	pm->lpm_plat_power_gate(gpc, false);
> > +
> > +	pm->lpm_enable_core(gpc, false, GPC_PGC_C0);
> > +	pm->lpm_enable_core(gpc, false, GPC_PGC_SCU);
> > +	pm->lpm_enable_core(gpc, false, GPC_PGC_FM);
> > +	pm->clear_slots(gpc);
> > +}
> > +
> > +static int imx_gpcv2_pm_enter(suspend_state_t state) {
> > +	struct imx_gpcv2_suspend *pm;
> > +
> > +	BUG_ON(!gpcv2_instance);
> > +	pm = gpcv2_instance->pm;
> > +
> > +	switch (state) {
> > +	case PM_SUSPEND_STANDBY:
> > +		pm->standby(gpcv2_instance);
> > +		break;
> > +
> > +	case PM_SUSPEND_MEM:
> > +		pm->suspend(gpcv2_instance);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx_gpcv2_pm_valid(suspend_state_t state) {
> > +	return state == PM_SUSPEND_MEM || state == PM_SUSPEND_STANDBY; }
> > +
> > +
> > +#define MX7_MAX_DDRC_NUM		32
> > +#define MX7_MAX_DDRC_PHY_NUM		16
> > +
> > +#define READ_DATA_FROM_HARDWARE		0
> > +#define MX7_SUSPEND_OCRAM_SIZE		0x1000
> > +
> > +struct imx7_pm_base {
> > +	phys_addr_t pbase;
> > +	void __iomem *vbase;
> > +};
> > +
> > +struct imx7_pm_socdata {
> > +	u32 ddr_type;
> > +	const char *ddrc_compat;
> > +	const char *ddrc_phy_compat;
> > +	const char *src_compat;
> > +	const char *iomuxc_gpr_compat;
> > +	const char *ccm_compat;
> > +	const char *gpc_compat;
> > +	const char *anatop_compat;
> > +	const u32 ddrc_num;
> > +	const u32 (*ddrc_offset)[2];
> > +	const u32 ddrc_phy_num;
> > +	const u32 (*ddrc_phy_offset)[2];
> > +};
> > +
> > +/*
> > + * This structure is for passing necessary data for low level ocram
> > + * suspend code(arch/arm/mach-imx/suspend-imx7.S), if this struct
> > + * definition is changed, the offset definition in
> > + * arch/arm/mach-imx/suspend-imx7.S must be also changed accordingly,
> > + * otherwise, the suspend to ocram function will be broken!
> > + */
> > +struct imx7_cpu_pm_info {
> > +	u32 m4_reserve0;
> > +	u32 m4_reserve1;
> > +	u32 m4_reserve2;
> > +
> > +	/* The physical address of pm_info. */
> > +	phys_addr_t pbase;
> > +
> > +	/* The physical resume address for asm code */
> > +	phys_addr_t resume_addr;
> > +	u32 ddr_type;
> > +
> > +	u32 pm_info_size;
> > +
> > +	struct imx7_pm_base ddrc_base;
> > +	struct imx7_pm_base ddrc_phy_base;
> > +	struct imx7_pm_base src_base;
> > +	struct imx7_pm_base iomuxc_gpr_base;
> > +	struct imx7_pm_base ccm_base;
> > +	struct imx7_pm_base gpc_base;
> > +	struct imx7_pm_base l2_base;
> > +	struct imx7_pm_base anatop_base;
> > +
> > +	u32 ttbr1;
> > +
> > +	/* Number of DDRC which need saved/restored. */
> > +	u32 ddrc_num;
> > +
> > +	/* To save offset and value */
> > +	u32 ddrc_val[MX7_MAX_DDRC_NUM][2];
> > +
> > +	/* Number of DDRC which need saved/restored. */
> > +	u32 ddrc_phy_num;
> > +
> > +	/* To save offset and value */
> > +	u32 ddrc_phy_val[MX7_MAX_DDRC_NUM][2];
> > +} __aligned(8);
> > +
> > +static int __init imx_get_base_from_node(struct device_node *node,
> > +			struct imx7_pm_base *base)
> > +{
> > +	struct resource res;
> > +	int ret = 0;
> > +
> > +	ret = of_address_to_resource(node, 0, &res);
> > +	if (ret)
> > +		goto put_node;
> > +
> > +	base->pbase = res.start;
> > +	base->vbase = ioremap(res.start, resource_size(&res));
> > +	if (!base->vbase) {
> > +		iounmap(base->vbase);
> > +		ret = -ENOMEM;
> > +	}
> > +put_node:
> > +	of_node_put(node);
> > +
> > +	return ret;
> > +}
> > +
> > +static int __init imx_get_base_from_dt(struct imx7_pm_base *base,
> > +				const char *compat)
> > +{
> > +	struct device_node *node;
> > +	struct resource res;
> > +	int ret = 0;
> > +
> > +	node = of_find_compatible_node(NULL, NULL, compat);
> > +	if (!node) {
> > +		ret = -ENODEV;
> > +		goto out;
> > +	}
> > +
> > +	ret = of_address_to_resource(node, 0, &res);
> > +	if (ret)
> > +		goto put_node;
> > +
> > +	base->pbase = res.start;
> > +	base->vbase = ioremap(res.start, resource_size(&res));
> > +	if (!base->vbase)
> > +		ret = -ENOMEM;
> > +
> > +put_node:
> > +	of_node_put(node);
> > +out:
> > +	return ret;
> > +}
> > +
> > +static int __init imx_get_exec_base_from_dt(struct imx7_pm_base *base,
> > +				const char *compat)
> > +{
> > +	struct device_node *node;
> > +	struct resource res;
> > +	int ret = 0;
> > +
> > +	node = of_find_compatible_node(NULL, NULL, compat);
> > +	if (!node) {
> > +		ret = -ENODEV;
> > +		goto out;
> > +	}
> > +
> > +	ret = of_address_to_resource(node, 0, &res);
> > +	if (ret)
> > +		goto put_node;
> > +
> > +	base->pbase = res.start;
> > +	base->vbase = __arm_ioremap_exec(res.start, resource_size(&res),
> > +false);
> > +
> > +	if (!base->vbase)
> > +		ret = -ENOMEM;
> > +
> > +put_node:
> > +	of_node_put(node);
> > +out:
> > +	return ret;
> > +}
> > +
> > +static const u32 imx7d_ddrc_ddr3_setting[][2] __initconst = {
> > +	{ 0x0, READ_DATA_FROM_HARDWARE },
> > +	{ 0x1a0, READ_DATA_FROM_HARDWARE },
> > +	{ 0x1a4, READ_DATA_FROM_HARDWARE },
> > +	{ 0x1a8, READ_DATA_FROM_HARDWARE },
> > +	{ 0x64, READ_DATA_FROM_HARDWARE },
> > +	{ 0x490, 0x00000001 },
> > +	{ 0xd0, 0xc0020001 },
> > +	{ 0xd4, READ_DATA_FROM_HARDWARE },
> > +	{ 0xdc, READ_DATA_FROM_HARDWARE },
> > +	{ 0xe0, READ_DATA_FROM_HARDWARE },
> > +	{ 0xe4, READ_DATA_FROM_HARDWARE },
> > +	{ 0xf4, READ_DATA_FROM_HARDWARE },
> > +	{ 0x100, READ_DATA_FROM_HARDWARE },
> > +	{ 0x104, READ_DATA_FROM_HARDWARE },
> > +	{ 0x108, READ_DATA_FROM_HARDWARE },
> > +	{ 0x10c, READ_DATA_FROM_HARDWARE },
> > +	{ 0x110, READ_DATA_FROM_HARDWARE },
> > +	{ 0x114, READ_DATA_FROM_HARDWARE },
> > +	{ 0x120, 0x03030803 },
> > +	{ 0x180, READ_DATA_FROM_HARDWARE },
> > +	{ 0x190, READ_DATA_FROM_HARDWARE },
> > +	{ 0x194, READ_DATA_FROM_HARDWARE },
> > +	{ 0x200, READ_DATA_FROM_HARDWARE },
> > +	{ 0x204, READ_DATA_FROM_HARDWARE },
> > +	{ 0x214, READ_DATA_FROM_HARDWARE },
> > +	{ 0x218, READ_DATA_FROM_HARDWARE },
> > +	{ 0x240, 0x06000601 },
> > +	{ 0x244, READ_DATA_FROM_HARDWARE },
> > +};
> > +
> > +static const u32 imx7d_ddrc_phy_ddr3_setting[][2] __initconst = {
> > +	{ 0x0, READ_DATA_FROM_HARDWARE },
> > +	{ 0x4, READ_DATA_FROM_HARDWARE },
> > +	{ 0x10, READ_DATA_FROM_HARDWARE },
> > +	{ 0x9c, READ_DATA_FROM_HARDWARE },
> > +	{ 0x20, READ_DATA_FROM_HARDWARE },
> > +	{ 0x30, READ_DATA_FROM_HARDWARE },
> > +	{ 0x50, 0x01000010 },
> > +	{ 0x50, 0x00000010 },
> > +	{ 0xc0, 0x0e407304 },
> > +	{ 0xc0, 0x0e447304 },
> > +	{ 0xc0, 0x0e447306 },
> > +	{ 0xc0, 0x0e447304 },
> > +	{ 0xc0, 0x0e407306 },
> > +};
> > +
> > +static const struct imx7_pm_socdata imx7d_pm_data_ddr3 __initconst = {
> > +	.iomuxc_gpr_compat = "fsl,imx7d-iomuxc",
> > +	.ddrc_phy_compat = "fsl,imx7d-ddrc-phy",
> > +	.anatop_compat = "fsl,imx7d-anatop",
> > +	.ddrc_compat = "fsl,imx7d-ddrc",
> > +	.ccm_compat = "fsl,imx7d-ccm",
> > +	.src_compat = "fsl,imx7d-src",
> > +	.gpc_compat = "fsl,imx7d-gpc",
> > +	.ddrc_phy_num = ARRAY_SIZE(imx7d_ddrc_phy_ddr3_setting),
> > +	.ddrc_phy_offset = imx7d_ddrc_phy_ddr3_setting,
> > +	.ddrc_num = ARRAY_SIZE(imx7d_ddrc_ddr3_setting),
> > +	.ddrc_offset = imx7d_ddrc_ddr3_setting, };
> > +
> > +static int __init imx_gpcv2_suspend_init(struct imx_gpcv2_suspend *pm,
> > +			const struct imx7_pm_socdata *socdata) {
> > +	struct imx7_pm_base aips_base[3] = { {0, 0}, {0, 0}, {0, 0} };
> > +	struct imx7_pm_base sram_base = {0, 0};
> > +	struct imx7_cpu_pm_info *pm_info;
> > +	struct device_node *node;
> > +	int i, ret = 0;
> > +
> > +	const u32 (*ddrc_phy_offset_array)[2];
> > +	const u32 (*ddrc_offset_array)[2];
> > +
> > +	if (!socdata || !pm) {
> > +		pr_warn("%s: invalid argument!\n", __func__);
> > +		return -EINVAL;
> > +	}
> > +
> > +	node = NULL;
> 
> You can do the initialization on top.
> 
> > +	for (i = 0; i < 3; i++) {
> > +		node = of_find_compatible_node(node, NULL, "fsl,aips-bus");
> > +		if (!node) {
> > +			pr_warn("%s: failed to find aips %d node!\n",
> > +					__func__, i);
> > +			break;
> > +		}
> > +		ret = imx_get_base_from_node(node, &aips_base[i]);
> > +		if (ret) {
> > +			pr_warn("%s: failed to get aips[%d] base %d!\n",
> > +					__func__, i, ret);
> > +		}
> > +	}
> 
> What are the aips_base used for? You would need to call of_node_put for each of
> them.

These addresses will be used in assemble codes.  

> > +
> > +	ret = imx_get_exec_base_from_dt(&sram_base, "fsl,lpm-sram");
> > +	if (ret) {
> > +		pr_warn("%s: failed to get lpm-sram base %d!\n",
> > +				__func__, ret);
> > +		goto lpm_sram_map_failed;
> > +	}
> > +
> > +	pm_info = sram_base.vbase;
> > +	pm_info->pbase = sram_base.pbase;
> > +	pm_info->resume_addr = virt_to_phys(ca7_cpu_resume);
> > +	pm_info->pm_info_size = sizeof(*pm_info);
> > +
> > +	ret = imx_get_base_from_dt(&pm_info->ccm_base,
> socdata->ccm_compat);
> > +	if (ret) {
> > +		pr_warn("%s: failed to get ccm base %d!\n", __func__, ret);
> > +		goto ccm_map_failed;
> > +	}
> > +
> > +	ret = imx_get_base_from_dt(&pm_info->ddrc_base,
> socdata->ddrc_compat);
> > +	if (ret) {
> > +		pr_warn("%s: failed to get ddrc base %d!\n", __func__, ret);
> > +		goto ddrc_map_failed;
> > +	}
> > +
> > +	ret = imx_get_base_from_dt(&pm_info->ddrc_phy_base,
> > +				socdata->ddrc_phy_compat);
> > +	if (ret) {
> > +		pr_warn("%s: failed to get ddrc_phy base %d!\n", __func__, ret);
> > +		goto ddrc_phy_map_failed;
> > +	}
> > +
> > +	ret = imx_get_base_from_dt(&pm_info->src_base, socdata->src_compat);
> > +	if (ret) {
> > +		pr_warn("%s: failed to get src base %d!\n", __func__, ret);
> > +		goto src_map_failed;
> > +	}
> > +
> > +	ret = imx_get_base_from_dt(&pm_info->iomuxc_gpr_base,
> > +				socdata->iomuxc_gpr_compat);
> > +	if (ret) {
> > +		pr_warn("%s: failed to get iomuxc_gpr base %d!\n",
> > +					__func__, ret);
> > +		goto iomuxc_gpr_map_failed;
> > +	}
> > +
> > +	ret = imx_get_base_from_dt(&pm_info->gpc_base, socdata->gpc_compat);
> > +	if (ret) {
> > +		pr_warn("%s: failed to get gpc base %d!\n", __func__, ret);
> > +		goto gpc_map_failed;
> > +	}
> > +
> > +	ret = imx_get_base_from_dt(&pm_info->anatop_base,
> > +				socdata->anatop_compat);
> > +	if (ret) {
> > +		pr_warn("%s: failed to get anatop base %d!\n", __func__, ret);
> > +		goto anatop_map_failed;
> > +	}
> > +
> > +	pm_info->ddrc_num = socdata->ddrc_num;
> > +	ddrc_offset_array = socdata->ddrc_offset;
> > +	pm_info->ddrc_phy_num = socdata->ddrc_phy_num;
> > +	ddrc_phy_offset_array = socdata->ddrc_phy_offset;
> > +
> > +	/* initialize DDRC settings */
> > +	for (i = 0; i < pm_info->ddrc_num; i++) {
> > +		pm_info->ddrc_val[i][0] = ddrc_offset_array[i][0];
> > +		if (ddrc_offset_array[i][1] == READ_DATA_FROM_HARDWARE)
> > +			pm_info->ddrc_val[i][1] =
> > +				readl_relaxed(pm_info->ddrc_base.vbase +
> > +				ddrc_offset_array[i][0]);
> > +		else
> > +			pm_info->ddrc_val[i][1] = ddrc_offset_array[i][1];
> > +	}
> > +
> > +	/* initialize DDRC PHY settings */
> > +	for (i = 0; i < pm_info->ddrc_phy_num; i++) {
> > +		pm_info->ddrc_phy_val[i][0] =
> > +			ddrc_phy_offset_array[i][0];
> > +		if (ddrc_phy_offset_array[i][1] == READ_DATA_FROM_HARDWARE)
> > +			pm_info->ddrc_phy_val[i][1] =
> > +				readl_relaxed(pm_info->ddrc_phy_base.vbase +
> > +				ddrc_phy_offset_array[i][0]);
> > +		else
> > +			pm_info->ddrc_phy_val[i][1] =
> > +				ddrc_phy_offset_array[i][1];
> > +	}
> > +
> > +	pm->suspend_fn_in_ocram = fncpy(
> > +		sram_base.vbase + sizeof(*pm_info),
> > +		&imx7_suspend,
> > +		MX7_SUSPEND_OCRAM_SIZE - sizeof(*pm_info));
> > +	pm->ocram_vbase = sram_base.vbase;
> > +
> > +	goto put_node;
> > +
> > +anatop_map_failed:
> > +	iounmap(pm_info->anatop_base.vbase);
> > +gpc_map_failed:
> > +	iounmap(pm_info->gpc_base.vbase);
> > +iomuxc_gpr_map_failed:
> > +	iounmap(pm_info->iomuxc_gpr_base.vbase);
> > +src_map_failed:
> > +	iounmap(pm_info->src_base.vbase);
> > +ddrc_phy_map_failed:
> > +	iounmap(pm_info->ddrc_phy_base.vbase);
> > +ddrc_map_failed:
> > +	iounmap(pm_info->ddrc_base.vbase);
> > +ccm_map_failed:
> > +	iounmap(pm_info->ccm_base.vbase);
> > +lpm_sram_map_failed:
> > +	iounmap(sram_base.vbase);
> > +put_node:
> > +	of_node_put(node);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct platform_suspend_ops imx_gpcv2_pm_ops = {
> > +	.enter = imx_gpcv2_pm_enter,
> > +	.valid = imx_gpcv2_pm_valid,
> > +};
> > +
> > +static int __init imx_gpcv2_pm_init(void) {
> > +	struct imx_gpcv2_suspend *pm;
> > +	struct imx_gpcv2_irq *cd;
> > +	struct imx_gpcv2 *gpc;
> > +	int val;
> > +
> > +	pm = kzalloc(sizeof(struct imx_gpcv2_suspend), GFP_KERNEL);
> > +	gpc = kzalloc(sizeof(struct imx_gpcv2), GFP_KERNEL);
> > +	cd = gpcv2_irq_instance;
> > +
> > +	if (!cd || !pm || !gpc) {
> > +		pr_debug("[GPCv2] %s init failed\r\n", __func__);
> > +		return 0;
> > +	}
> 
> This shortcut doesn't work, what if allocating pm succeeds and gpc does not?

Any allocation failures here will cause the initialization to fail. I will have a better solution in new patch.
 
> > +
> > +	imx_gpcv2_suspend_init(pm, &imx7d_pm_data_ddr3);
> > +
> > +	pm->lpm_env_setup = imx_gpcv2_lpm_env_setup;
> > +	pm->lpm_env_clean = imx_gpcv2_lpm_env_clean;
> > +
> > +	pm->lpm_cpu_power_gate = imx_gpcv2_lpm_cpu_power_gate;
> > +	pm->lpm_plat_power_gate = imx_lpm_plat_power_gate;
> > +	pm->lpm_enable_core = imx_gpcv2_lpm_enable_core;
> > +	pm->set_mode = imx_gpcv2_lpm_set_mode;
> > +
> > +	pm->clear_slots = imx_gpcv2_lpm_clear_slots;
> > +	pm->set_slot = imx_gpcv2_lpm_slot_setup;
> > +
> > +	pm->standby = imx_gpcv2_lpm_standby;
> > +	pm->suspend = imx_gpcv2_lpm_suspend;
> > +
> > +	pr_debug("[GPCv2] %s \r\n", __func__);
> > +	pm->anatop = syscon_regmap_lookup_by_compatible("fsl,imx6q-anatop");
> > +	WARN_ON(!pm->anatop);
> > +	pm->imx_src = syscon_regmap_lookup_by_compatible("fsl,imx7d-src");
> > +	WARN_ON(!pm->imx_src);
> > +
> > +	/*
> > +	 * Due to hardware design failure, need to make sure GPR
> > +	 * interrupt(#32) is unmasked during RUN mode to avoid entering
> > +	 * DSM by mistake.
> > +	 */
> > +	writel_relaxed(~0x1, cd->gpc_base + cd->cpu2wakeup);
> > +
> > +	/* only external IRQs to wake up LPM and core 0/1 */
> > +	val = readl_relaxed(cd->gpc_base + GPC_LPCR_A7_BSC);
> > +	val |= BM_LPCR_A7_BSC_IRQ_SRC_A7_WAKEUP;
> > +	writel_relaxed(val, cd->gpc_base + GPC_LPCR_A7_BSC);
> > +	/* mask m4 dsm trigger */
> > +	writel_relaxed(readl_relaxed(cd->gpc_base + GPC_LPCR_M4) |
> > +		BM_LPCR_M4_MASK_DSM_TRIGGER, cd->gpc_base +
> GPC_LPCR_M4);
> > +	/* set mega/fast mix in A7 domain */
> > +	writel_relaxed(0x1, cd->gpc_base + GPC_PGC_CPU_MAPPING);
> > +	/* set SCU timing */
> > +	writel_relaxed((0x59 << 10) | 0x5B | (0x51 << 20),
> > +		cd->gpc_base + GPC_PGC_SCU_TIMING);
> > +
> > +	/* Mask the wakeup sources in M/F power domain */
> > +	pm->mfmix_mask[0] = 0x54010000;
> > +	pm->mfmix_mask[1] = 0xc00;
> > +	pm->mfmix_mask[2] = 0x0;
> > +	pm->mfmix_mask[3] = 0x400010;
> 
> What is this doing?

The IP blocks which may be the wakeup sources are allocated into several power domains. MFMIX is one
of those power domains. If a bit is '1', it means the IP block is inside MFMIX power domain. We will use it
to decide if a power domain should be power gated or not.

> I stop here for now, will have a look at the assembly part another time.

Thank you very much for the excellent review!

Shenwei

> --
> Stefan
