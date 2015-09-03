From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Thu, 3 Sep 2015 20:41:00 +0000
Subject: [PATCH v8 2/2] ARM: imx: support suspend states on imx7D
In-Reply-To: <1438378439-11569-3-git-send-email-shenwei.wang@freescale.com>
References: <1438378439-11569-1-git-send-email-shenwei.wang@freescale.com>
 <1438378439-11569-3-git-send-email-shenwei.wang@freescale.com>
Message-ID: <CY1PR0301MB084396E9EAC2A9D159F6D58783680@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2nd ping.

Shenwei

> -----Original Message-----
> From: linux-kernel-owner at vger.kernel.org
> [mailto:linux-kernel-owner at vger.kernel.org] On Behalf Of Shenwei Wang
> Sent: 2015?7?31? 16:34
> To: shawn.guo at linaro.org; tglx at linutronix.de; jason at lakedaemon.net
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Huang
> Yongcai-B20788
> Subject: [PATCH v8 2/2] ARM: imx: support suspend states on imx7D
> 
> IMX7D contains a new version of GPC IP block (GPCv2). It has two major functions:
> power management and wakeup source management.
> 
> GPCv2 provides low power mode control for Cortex-A7 and Cortex-M4 domains.
> And it can support WAIT, STOP, and DSM(Deep Sleep Mode) modes.
> After configuring the GPCv2 module, the platform can enter into a selected mode
> either automatically triggered by ARM WFI instruction or manually by software.
> The system will exit the low power states by the predefined wakeup sources
> which are managed by the gpcv2 irqchip driver.
> 
> This patch adds a new suspend driver to manage the power states on IMX7D.
> It currently supports "SUSPEND_STANDBY" and "SUSPEND_MEM" states.
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  arch/arm/mach-imx/Kconfig        |   1 +
>  arch/arm/mach-imx/Makefile       |   2 +
>  arch/arm/mach-imx/common.h       |   4 +
>  arch/arm/mach-imx/pm-imx7.c      | 917
> +++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/suspend-imx7.S | 529 ++++++++++++++++++++++
>  5 files changed, 1453 insertions(+)
>  create mode 100644 arch/arm/mach-imx/pm-imx7.c  create mode 100644
> arch/arm/mach-imx/suspend-imx7.S
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig index
> 8ceda28..54f8553 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -562,6 +562,7 @@ config SOC_IMX7D
>  	select ARM_GIC
>  	select HAVE_IMX_ANATOP
>  	select HAVE_IMX_MMDC
> +	select IMX_GPCV2
>  	help
>  		This enables support for Freescale i.MX7 Dual processor.
> 
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile index
> fb689d8..60f13fd 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -88,6 +88,8 @@ obj-$(CONFIG_SOC_IMX7D) += mach-imx7d.o
> 
>  ifeq ($(CONFIG_SUSPEND),y)
>  AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
> +AFLAGS_suspend-imx7.o :=-Wa,-march=armv7-a
> +obj-$(CONFIG_SOC_IMX7D)	+= suspend-imx7.o pm-imx7.o
>  obj-$(CONFIG_SOC_IMX6) += suspend-imx6.o
>  obj-$(CONFIG_SOC_IMX53) += suspend-imx53.o  endif diff --git
> a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h index
> 21e4e86..c5767f4 100644
> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -126,6 +126,10 @@ static const u32 imx53_suspend_sz;  static inline void
> imx6_suspend(void __iomem *ocram_vbase) {}  #endif
> 
> +void ca7_cpu_resume(void);
> +void imx7_suspend(void __iomem *ocram_vbase);
> +u32 imx_gpcv2_get_wakeup_source(u32 **sources);
> +
>  void imx6_pm_ccm_init(const char *ccm_compat);  void imx6q_pm_init(void);
> void imx6dl_pm_init(void); diff --git a/arch/arm/mach-imx/pm-imx7.c
> b/arch/arm/mach-imx/pm-imx7.c new file mode 100644 index 0000000..052c2cb
> --- /dev/null
> +++ b/arch/arm/mach-imx/pm-imx7.c
> @@ -0,0 +1,917 @@
> +/*
> + * Copyright (C) 2015 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/regmap.h>
> +#include <linux/suspend.h>
> +#include <linux/slab.h>
> +#include <asm/suspend.h>
> +#include <asm/fncpy.h>
> +
> +#include "common.h"
> +
> +#define GPC_LPCR_A7_BSC		0x0
> +#define GPC_LPCR_A7_AD		0x4
> +#define GPC_LPCR_M4		0x8
> +
> +#define GPC_SLPCR		0x14
> +#define GPC_PGC_ACK_SEL_A7	0x24
> +
> +#define GPC_SLOTx_CFG(x) 	(0xb0 + 4 * (x))
> +
> +#define GPC_PGC_CPU_MAPPING	0xec
> +
> +#define GPC_PGC_C0		0x800
> +#define GPC_PGC_C1		0x840
> +#define GPC_PGC_SCU		0x880
> +#define GPC_PGC_SCU_TIMING	0x890
> +#define GPC_PGC_FM		0xa00
> +#define GPC_PGC_MIPI_PHY	0xc00
> +#define GPC_PGC_PCIE_PHY	0xc40
> +#define GPC_PGC_USB_OTG1_PHY	0xc80
> +#define GPC_PGC_USB_OTG2_PHY	0xcc0
> +#define GPC_PGC_USB_HSIC_PHY	0xd00
> +
> +#define ANADIG_ARM_PLL		0x60
> +#define ANADIG_DDR_PLL		0x70
> +#define ANADIG_SYS_PLL		0xb0
> +#define ANADIG_ENET_PLL		0xe0
> +#define ANADIG_AUDIO_PLL	0xf0
> +#define ANADIG_VIDEO_PLL	0x130
> +
> +#define BM_LPCR_A7_AD_L2PGE			(0x1 << 16)
> +#define BM_LPCR_A7_AD_EN_C1_PUP			(0x1 << 11)
> +#define BM_LPCR_A7_AD_EN_C1_IRQ_PUP		(0x1 << 10)
> +#define BM_LPCR_A7_AD_EN_C0_PUP			(0x1 << 9)
> +#define BM_LPCR_A7_AD_EN_C0_IRQ_PUP		(0x1 << 8)
> +#define BM_LPCR_A7_AD_EN_PLAT_PDN		(0x1 << 4)
> +#define BM_LPCR_A7_AD_EN_C1_PDN			(0x1 << 3)
> +#define BM_LPCR_A7_AD_EN_C1_WFI_PDN		(0x1 << 2)
> +#define BM_LPCR_A7_AD_EN_C0_PDN			(0x1 << 1)
> +#define BM_LPCR_A7_AD_EN_C0_WFI_PDN		(0x1)
> +
> +#define BM_LPCR_A7_BSC_IRQ_SRC_A7_WAKEUP	(0x7 << 28)
> +#define BM_LPCR_A7_BSC_CPU_CLK_ON_LPM		(0x1 << 14)
> +#define BM_LPCR_A7_BSC_LPM1			(0x3 << 2)
> +#define BM_LPCR_A7_BSC_LPM0			(0x3)
> +
> +#define BM_LPCR_M4_MASK_DSM_TRIGGER		(0x1 << 31)
> +
> +#define BM_SLPCR_EN_DSM				(0x1 << 31)
> +#define BM_SLPCR_RBC_EN				(0x1 << 30)
> +#define BM_SLPCR_VSTBY				(0x1 << 2)
> +#define BM_SLPCR_SBYOS				(0x1 << 1)
> +#define BM_SLPCR_BYPASS_PMIC_READY		(0x1)
> +
> +#define BM_GPC_PGC_ACK_SEL_A7_DUMMY_PUP		(0x1 << 31)
> +#define BM_GPC_PGC_ACK_SEL_A7_DUMMY_PDN		(0x1 << 15)
> +
> +#define BM_ANADIG_ARM_PLL_OVERRIDE		(0x1 << 20)
> +#define BM_ANADIG_DDR_PLL_OVERRIDE		(0x1 << 19)
> +#define BM_ANADIG_SYS_PLL_PFDx_OVERRIDE		(0x1FF << 17)
> +#define BM_ANADIG_ENET_PLL_OVERRIDE		(0x1 << 13)
> +#define BM_ANADIG_AUDIO_PLL_OVERRIDE		(0x1 << 24)
> +#define BM_ANADIG_VIDEO_PLL_OVERRIDE		(0x1 << 24)
> +
> +#define A7_LPM_WAIT		0x5
> +#define A7_LPM_STOP		0xa
> +#define GPC_MAX_SLOT_NUMBER	10
> +
> +#define REG_SET			0x4
> +#define REG_CLR			0x8
> +
> +#define MX7_MAX_DDRC_NUM		32
> +#define MX7_MAX_DDRC_PHY_NUM		16
> +
> +#define READ_DATA_FROM_HARDWARE		0
> +#define MX7_SUSPEND_OCRAM_SIZE		0x1000
> +
> +enum gpcv2_mode {
> +	GPC_WAIT_CLOCKED,
> +	GPC_WAIT_UNCLOCKED,
> +	GPC_STOP_POWER_ON,
> +	GPC_STOP_POWER_OFF,
> +};
> +
> +/*
> + * GPCv2 has the following power domains, and each domain can be
> +power-up
> + * and power-down via GPC settings.
> + *
> + * 	Core 0 of A7 power domain
> + * 	Core1 of A7 power domain
> + * 	SCU/L2 cache RAM of A7 power domain
> + * 	Fastmix and megamix power domain
> + * 	USB OTG1 PHY power domain
> + * 	USB OTG2 PHY power domain
> + * 	PCIE PHY power domain
> + * 	USB HSIC PHY power domain
> + *	Core 0 of M4 power domain
> + */
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
> +struct imx_gpcv2;
> +
> +struct imx_gpcv2_suspend {
> +	void (*set_mode)(struct imx_gpcv2 *, enum gpcv2_mode mode);
> +	void (*lpm_cpu_power_gate)(struct imx_gpcv2 *, u32, bool);
> +	void (*lpm_plat_power_gate)(struct imx_gpcv2 *, bool);
> +	void (*lpm_env_setup)(struct imx_gpcv2 *);
> +	void (*lpm_env_clean)(struct imx_gpcv2 *);
> +
> +	void (*set_slot)(struct imx_gpcv2 *cd, u32 index,
> +			enum gpcv2_slot slot, bool mode);
> +	void (*set_act)(struct imx_gpcv2 *cd,
> +			enum gpcv2_slot slot, bool mode);
> +	void (*clear_slots)(struct imx_gpcv2 *);
> +	void (*lpm_enable_core)(struct imx_gpcv2 *,
> +			bool enable, u32 offset);
> +
> +	void (*standby)(struct imx_gpcv2 *);
> +	void (*suspend)(struct imx_gpcv2 *);
> +
> +	void (*suspend_fn_in_ocram)(void __iomem *ocram_vbase);
> +	void __iomem *ocram_vbase;
> +};
> +
> +struct imx_gpcv2 {
> +	u32 *wakeupmix_mask;
> +	u32 *lpsrmix_mask;
> +	u32 *mfmix_mask;
> +	spinlock_t lock;
> +
> +	struct imx_gpcv2_suspend *pm;
> +	struct regmap *anatop;
> +	struct regmap *gpcv2;
> +
> +	u32 (*get_wakeup_source)(u32 **);
> +};
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
> +
> +struct imx7_cpu_pm_info {
> +	u32 m4_reserve0;
> +	u32 m4_reserve1;
> +	u32 m4_reserve2;
> +
> +	/* The physical address of pm_info. */
> +	phys_addr_t pbase;
> +
> +	/* The physical resume address for asm code */
> +	phys_addr_t resume_addr;
> +	u32 ddr_type;
> +
> +	u32 pm_info_size;
> +
> +	struct imx7_pm_base ddrc_base;
> +	struct imx7_pm_base ddrc_phy_base;
> +	struct imx7_pm_base src_base;
> +	struct imx7_pm_base iomuxc_gpr_base;
> +	struct imx7_pm_base ccm_base;
> +	struct imx7_pm_base gpc_base;
> +	struct imx7_pm_base l2_base;
> +	struct imx7_pm_base anatop_base;
> +
> +	u32 ttbr1;
> +
> +	/* Number of DDRC which need saved/restored. */
> +	u32 ddrc_num;
> +
> +	/* To save offset and value */
> +	u32 ddrc_val[MX7_MAX_DDRC_NUM][2];
> +
> +	/* Number of DDRC which need saved/restored. */
> +	u32 ddrc_phy_num;
> +
> +	/* To save offset and value */
> +	u32 ddrc_phy_val[MX7_MAX_DDRC_NUM][2];
> +} __aligned(8);
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
> +	.iomuxc_gpr_compat = "fsl,imx7d-iomuxc",
> +	.ddrc_phy_compat = "fsl,imx7d-ddrc-phy",
> +	.anatop_compat = "fsl,imx7d-anatop",
> +	.ddrc_compat = "fsl,imx7d-ddrc",
> +	.ccm_compat = "fsl,imx7d-ccm",
> +	.src_compat = "fsl,imx7d-src",
> +	.gpc_compat = "fsl,imx7d-gpc",
> +	.ddrc_phy_num = ARRAY_SIZE(imx7d_ddrc_phy_ddr3_setting),
> +	.ddrc_phy_offset = imx7d_ddrc_phy_ddr3_setting,
> +	.ddrc_num = ARRAY_SIZE(imx7d_ddrc_ddr3_setting),
> +	.ddrc_offset = imx7d_ddrc_ddr3_setting, };
> +
> +static struct imx_gpcv2 *gpcv2_instance;
> +
> +static void imx_gpcv2_lpm_clear_slots(struct imx_gpcv2 *gpc) {
> +	int i;
> +
> +	for (i = 0; i < GPC_MAX_SLOT_NUMBER; i++)
> +		regmap_write(gpc->gpcv2, GPC_SLOTx_CFG(i), 0x0);
> +
> +	regmap_write(gpc->gpcv2, GPC_PGC_ACK_SEL_A7,
> +			BM_GPC_PGC_ACK_SEL_A7_DUMMY_PUP |
> +			BM_GPC_PGC_ACK_SEL_A7_DUMMY_PDN);
> +}
> +
> +static void imx_gpcv2_lpm_enable_core(struct imx_gpcv2 *gpc,
> +			bool enable, u32 offset)
> +{
> +	regmap_write(gpc->gpcv2, offset, enable); }
> +
> +static void imx_gpcv2_lpm_slot_setup(struct imx_gpcv2 *gpc,
> +		u32 index, enum gpcv2_slot slot, bool powerup) {
> +	u32 val;
> +
> +	if (index >= GPC_MAX_SLOT_NUMBER) {
> +		pr_err("Invalid slot index!\n");
> +		return;
> +	}
> +
> +	val = (powerup ? 0x2 : 0x1) << (slot * 2);
> +	regmap_write(gpc->gpcv2, GPC_SLOTx_CFG(index), val); }
> +
> +static void imx_gpcv2_lpm_set_ack(struct imx_gpcv2 *gpc,
> +		enum gpcv2_slot slot, bool powerup)
> +{
> +	u32 val;
> +
> +	regmap_read(gpc->gpcv2, GPC_PGC_ACK_SEL_A7, &val);
> +
> +	/* clear dummy ack */
> +	val &= ~(powerup ? BM_GPC_PGC_ACK_SEL_A7_DUMMY_PUP :
> +				BM_GPC_PGC_ACK_SEL_A7_DUMMY_PDN);
> +
> +	val |= 1 << (slot + (powerup ? 16 : 0));
> +	regmap_write(gpc->gpcv2, GPC_PGC_ACK_SEL_A7, val); }
> +
> +static void imx_gpcv2_lpm_env_setup(struct imx_gpcv2 *gpc) {
> +	/* PLL and PFDs overwrite set */
> +	regmap_write(gpc->anatop, ANADIG_ARM_PLL + REG_SET,
> +			BM_ANADIG_ARM_PLL_OVERRIDE);
> +	regmap_write(gpc->anatop, ANADIG_DDR_PLL + REG_SET,
> +			BM_ANADIG_DDR_PLL_OVERRIDE);
> +	regmap_write(gpc->anatop, ANADIG_SYS_PLL + REG_SET,
> +			BM_ANADIG_SYS_PLL_PFDx_OVERRIDE);
> +	regmap_write(gpc->anatop, ANADIG_ENET_PLL + REG_SET,
> +			BM_ANADIG_ENET_PLL_OVERRIDE);
> +	regmap_write(gpc->anatop, ANADIG_AUDIO_PLL + REG_SET,
> +			BM_ANADIG_AUDIO_PLL_OVERRIDE);
> +	regmap_write(gpc->anatop, ANADIG_VIDEO_PLL + REG_SET,
> +			BM_ANADIG_VIDEO_PLL_OVERRIDE);
> +}
> +
> +static void imx_gpcv2_lpm_env_clean(struct imx_gpcv2 *gpc) {
> +	/* PLL and PFDs overwrite clear */
> +	regmap_write(gpc->anatop, ANADIG_ARM_PLL + REG_CLR,
> +			BM_ANADIG_ARM_PLL_OVERRIDE);
> +	regmap_write(gpc->anatop, ANADIG_DDR_PLL + REG_CLR,
> +			BM_ANADIG_DDR_PLL_OVERRIDE);
> +	regmap_write(gpc->anatop, ANADIG_SYS_PLL + REG_CLR,
> +			BM_ANADIG_SYS_PLL_PFDx_OVERRIDE);
> +	regmap_write(gpc->anatop, ANADIG_ENET_PLL + REG_CLR,
> +			BM_ANADIG_ENET_PLL_OVERRIDE);
> +	regmap_write(gpc->anatop, ANADIG_AUDIO_PLL + REG_CLR,
> +			BM_ANADIG_AUDIO_PLL_OVERRIDE);
> +	regmap_write(gpc->anatop, ANADIG_VIDEO_PLL + REG_CLR,
> +			BM_ANADIG_VIDEO_PLL_OVERRIDE);
> +}
> +
> +static void imx_gpcv2_lpm_set_mode(struct imx_gpcv2 *gpc,
> +		enum gpcv2_mode mode)
> +{
> +	u32 lpcr, slpcr;
> +
> +	regmap_read(gpc->gpcv2, GPC_LPCR_A7_BSC, &lpcr);
> +	regmap_read(gpc->gpcv2, GPC_SLPCR, &slpcr);
> +
> +	/* all cores' LPM settings must be same */
> +	lpcr &= ~(BM_LPCR_A7_BSC_LPM0 | BM_LPCR_A7_BSC_LPM1);
> +	lpcr |= BM_LPCR_A7_BSC_CPU_CLK_ON_LPM;
> +
> +	slpcr &= ~(BM_SLPCR_EN_DSM | BM_SLPCR_VSTBY | BM_SLPCR_RBC_EN
> |
> +		BM_SLPCR_SBYOS | BM_SLPCR_BYPASS_PMIC_READY);
> +
> +	switch (mode) {
> +	case GPC_WAIT_CLOCKED:
> +		break;
> +	case GPC_WAIT_UNCLOCKED:
> +		lpcr |= A7_LPM_WAIT;
> +		lpcr &= ~BM_LPCR_A7_BSC_CPU_CLK_ON_LPM;
> +		break;
> +	case GPC_STOP_POWER_ON:
> +		lpcr |= A7_LPM_STOP;
> +		lpcr &= ~BM_LPCR_A7_BSC_CPU_CLK_ON_LPM;
> +		slpcr |= (BM_SLPCR_EN_DSM | BM_SLPCR_RBC_EN |
> +			BM_SLPCR_BYPASS_PMIC_READY);
> +		break;
> +	case GPC_STOP_POWER_OFF:
> +		lpcr |= A7_LPM_STOP;
> +		lpcr &= ~BM_LPCR_A7_BSC_CPU_CLK_ON_LPM;
> +		slpcr |= (BM_SLPCR_EN_DSM | BM_SLPCR_RBC_EN |
> +			BM_SLPCR_SBYOS | BM_SLPCR_VSTBY  |
> +			BM_SLPCR_BYPASS_PMIC_READY);
> +		break;
> +	default:
> +		return;
> +	}
> +	regmap_write(gpc->gpcv2, GPC_LPCR_A7_BSC, lpcr);
> +	regmap_write(gpc->gpcv2, GPC_SLPCR, slpcr); }
> +
> +static void imx_gpcv2_lpm_cpu_power_gate(struct imx_gpcv2 *gpc,
> +				u32 cpu, bool engate)
> +{
> +	u32 val;
> +
> +	const u32 val_pdn[2] = {
> +		BM_LPCR_A7_AD_EN_C0_PDN | BM_LPCR_A7_AD_EN_C0_PUP,
> +		BM_LPCR_A7_AD_EN_C1_PDN | BM_LPCR_A7_AD_EN_C1_PUP,
> +	};
> +
> +	regmap_read(gpc->gpcv2, GPC_LPCR_A7_AD, &val);
> +	if (engate)
> +		val |= val_pdn[cpu];
> +	else
> +		val &= ~val_pdn[cpu];
> +
> +	regmap_write(gpc->gpcv2, GPC_LPCR_A7_AD, val); }
> +
> +static void imx_lpm_plat_power_gate(struct imx_gpcv2 *gpc, bool engate)
> +{
> +	u32 val;
> +
> +	regmap_read(gpc->gpcv2, GPC_LPCR_A7_AD, &val);
> +	val &= ~(BM_LPCR_A7_AD_EN_PLAT_PDN | BM_LPCR_A7_AD_L2PGE);
> +	if (engate)
> +		val |= BM_LPCR_A7_AD_EN_PLAT_PDN | BM_LPCR_A7_AD_L2PGE;
> +
> +	regmap_write(gpc->gpcv2, GPC_LPCR_A7_AD, val); }
> +
> +static void imx_gpcv2_lpm_standby(struct imx_gpcv2 *gpc) {
> +	struct imx_gpcv2_suspend *pm = gpc->pm;
> +
> +	pm->lpm_env_setup(gpc);
> +	/* pm->set_mode(gpc, GPC_STOP_POWER_OFF); */
> +	pm->set_mode(gpc, GPC_WAIT_UNCLOCKED);
> +
> +	/* Zzz ... */
> +	cpu_do_idle();
> +
> +	pm->set_mode(gpc, GPC_WAIT_CLOCKED);
> +	pm->lpm_env_clean(gpc);
> +}
> +
> +static int gpcv2_suspend_finish(unsigned long val) {
> +	struct imx_gpcv2_suspend *pm = (struct imx_gpcv2_suspend *)val;
> +
> +	if (!pm->suspend_fn_in_ocram) {
> +		cpu_do_idle();
> +	} else {
> +		/*
> +		 * call low level suspend function in ocram,
> +		 * as we need to float DDR IO.
> +		 */
> +		local_flush_tlb_all();
> +		pm->suspend_fn_in_ocram(pm->ocram_vbase);
> +	}
> +
> +	return 0;
> +}
> +
> +static void imx_gpcv2_lpm_suspend(struct imx_gpcv2 *gpc) {
> +	struct imx_gpcv2_suspend *pm = gpc->pm;
> +	u32 *sources;
> +	int i, num;
> +
> +	pm->lpm_env_setup(gpc);
> +	pm->set_mode(gpc, GPC_STOP_POWER_OFF);
> +
> +	/* enable core0 power down/up with low power mode */
> +	pm->lpm_cpu_power_gate(gpc, 0, true);
> +
> +	/* enable plat power down with low power mode */
> +	pm->lpm_plat_power_gate(gpc, true);
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
> +	pm->set_slot(gpc, 0, CORE0_A7, false);
> +	pm->set_slot(gpc, 2, SCU_A7, false);
> +
> +	if (gpc->get_wakeup_source) {
> +		pm->set_slot(gpc, 1, FAST_MEGA_MIX, false);
> +		pm->set_slot(gpc, 5, FAST_MEGA_MIX, true);
> +		pm->lpm_enable_core(gpc, true, GPC_PGC_FM);
> +		num = gpc->get_wakeup_source(&sources);
> +		for (i = 0; i < num; i++) {
> +			if ((~sources[i] & gpc->mfmix_mask[i]) == 0)
> +				continue;
> +			pm->lpm_enable_core(gpc, false, GPC_PGC_FM);
> +			break;
> +		}
> +	}
> +
> +	pm->set_slot(gpc, 6, SCU_A7, true);
> +	pm->set_slot(gpc, 7, CORE0_A7, true);
> +
> +	/* Set Power down act */
> +	pm->set_act(gpc, SCU_A7, false);
> +
> +	/* Set Power up act */
> +	pm->set_act(gpc, CORE0_A7, true);
> +
> +	/* enable core0, scu */
> +	pm->lpm_enable_core(gpc, true, GPC_PGC_C0);
> +	pm->lpm_enable_core(gpc, true, GPC_PGC_SCU);
> +
> +	cpu_suspend((unsigned long)pm, gpcv2_suspend_finish);
> +
> +	pm->lpm_env_clean(gpc);
> +	pm->set_mode(gpc, GPC_WAIT_CLOCKED);
> +	pm->lpm_cpu_power_gate(gpc, 0, false);
> +	pm->lpm_plat_power_gate(gpc, false);
> +
> +	pm->lpm_enable_core(gpc, false, GPC_PGC_C0);
> +	pm->lpm_enable_core(gpc, false, GPC_PGC_SCU);
> +	pm->lpm_enable_core(gpc, false, GPC_PGC_FM);
> +	pm->clear_slots(gpc);
> +}
> +
> +static int imx_gpcv2_pm_enter(suspend_state_t state) {
> +	struct imx_gpcv2_suspend *pm;
> +
> +	BUG_ON(!gpcv2_instance);
> +	pm = gpcv2_instance->pm;
> +
> +	switch (state) {
> +	case PM_SUSPEND_STANDBY:
> +		pm->standby(gpcv2_instance);
> +		break;
> +
> +	case PM_SUSPEND_MEM:
> +		pm->suspend(gpcv2_instance);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx_gpcv2_pm_valid(suspend_state_t state) {
> +	return state == PM_SUSPEND_MEM || state == PM_SUSPEND_STANDBY; }
> +
> +static int __init imx_get_base_from_node(struct device_node *node,
> +			struct imx7_pm_base *base)
> +{
> +	struct resource res;
> +	int ret = 0;
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
> +static int __init imx_gpcv2_suspend_init(struct imx_gpcv2_suspend *pm,
> +			const struct imx7_pm_socdata *socdata) {
> +	struct imx7_pm_base aips_base[3] = { {0, 0}, {0, 0}, {0, 0} };
> +	struct imx7_pm_base sram_base = {0, 0};
> +	struct imx7_cpu_pm_info *pm_info;
> +	struct device_node *node = NULL;
> +	int i, ret = 0;
> +
> +	const u32 (*ddrc_phy_offset_array)[2];
> +	const u32 (*ddrc_offset_array)[2];
> +
> +	if (!socdata || !pm) {
> +		pr_warn("%s: invalid argument!\n", __func__);
> +		return -EINVAL;
> +	}
> +
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
> +	pm->suspend_fn_in_ocram = fncpy(
> +		sram_base.vbase + sizeof(*pm_info),
> +		&imx7_suspend,
> +		MX7_SUSPEND_OCRAM_SIZE - sizeof(*pm_info));
> +	pm->ocram_vbase = sram_base.vbase;
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
> +static const struct platform_suspend_ops imx_gpcv2_pm_ops = {
> +	.enter = imx_gpcv2_pm_enter,
> +	.valid = imx_gpcv2_pm_valid,
> +};
> +
> +static int __init imx_gpcv2_pm_init(void) {
> +	struct imx_gpcv2_suspend *pm;
> +	struct imx_gpcv2 *gpc;
> +	int val, num;
> +
> +	pm = kzalloc(sizeof(struct imx_gpcv2_suspend), GFP_KERNEL);
> +	if (!pm) {
> +		pr_warn("[GPCv2] %s init failed\r\n", __func__);
> +		return -ENOMEM;
> +	}
> +
> +	gpc = kzalloc(sizeof(struct imx_gpcv2), GFP_KERNEL);
> +	if (!gpc) {
> +		pr_warn("[GPCv2] %s init failed\r\n", __func__);
> +		kfree(pm);
> +		return -ENOMEM;
> +	}
> +
> +	imx_gpcv2_suspend_init(pm, &imx7d_pm_data_ddr3);
> +
> +	pm->lpm_env_setup = imx_gpcv2_lpm_env_setup;
> +	pm->lpm_env_clean = imx_gpcv2_lpm_env_clean;
> +
> +	pm->lpm_cpu_power_gate = imx_gpcv2_lpm_cpu_power_gate;
> +	pm->lpm_plat_power_gate = imx_lpm_plat_power_gate;
> +	pm->lpm_enable_core = imx_gpcv2_lpm_enable_core;
> +	pm->set_mode = imx_gpcv2_lpm_set_mode;
> +
> +	pm->clear_slots = imx_gpcv2_lpm_clear_slots;
> +	pm->set_slot = imx_gpcv2_lpm_slot_setup;
> +	pm->set_act = imx_gpcv2_lpm_set_ack;
> +
> +	pm->standby = imx_gpcv2_lpm_standby;
> +	pm->suspend = imx_gpcv2_lpm_suspend;
> +
> +	gpc->anatop = syscon_regmap_lookup_by_compatible("fsl,imx6q-anatop");
> +	if (IS_ERR(gpc->anatop))
> +		goto error_exit;
> +
> +	gpc->gpcv2 = syscon_regmap_lookup_by_compatible("fsl,imx7d-gpc");
> +	if (IS_ERR(gpc->gpcv2))
> +		goto error_exit;
> +
> +	/* only external IRQs to wake up LPM and core 0/1 */
> +	regmap_read(gpc->gpcv2, GPC_LPCR_A7_BSC, &val);
> +	val |= BM_LPCR_A7_BSC_IRQ_SRC_A7_WAKEUP;
> +	regmap_write(gpc->gpcv2, GPC_LPCR_A7_BSC, val);
> +	/* mask m4 dsm trigger */
> +	regmap_read(gpc->gpcv2, GPC_LPCR_M4, &val);
> +	val |= BM_LPCR_M4_MASK_DSM_TRIGGER;
> +	regmap_write(gpc->gpcv2, GPC_LPCR_M4, val);
> +
> +	/* set mega/fast mix in A7 domain */
> +	regmap_write(gpc->gpcv2, GPC_PGC_CPU_MAPPING, 0x1);
> +	/* set SCU timing */
> +	val = (0x59 << 10) | 0x5B | (0x51 << 20);
> +	regmap_write(gpc->gpcv2, GPC_PGC_SCU_TIMING, val);
> +
> +	gpc->pm = pm;
> +	gpc->get_wakeup_source = imx_gpcv2_get_wakeup_source;
> +	gpcv2_instance = gpc;
> +
> +	num = imx_gpcv2_get_wakeup_source(0);
> +
> +	/*
> +	 * The IP blocks which may be the wakeup sources are allocated into
> +	 * several power domains. MFMIX, LPSRMX, and WAKEUPMIX are three of
> +	 * those power domains. If a bit is '1' in the mask, it means the IP
> +	 * block is inside the power domain. The mask will be used to decide
> +	 * if a power domain should be shutdown or not when system goes into
> +	 * suspend states.
> +	 */
> +
> +	if (num)
> +		gpc->wakeupmix_mask = kzalloc(sizeof(u32)*num*3, GFP_KERNEL);
> +
> +	if (!gpc->wakeupmix_mask)
> +		goto error_exit;
> +
> +	/*
> +	 * Shutdown LPSRMIX and WAKEUP power domain has not been
> +	 * implemented in this patch yet.
> +	 */
> +
> +	gpc->lpsrmix_mask = gpc->wakeupmix_mask + num;
> +	gpc->mfmix_mask = gpc->wakeupmix_mask + num*2;
> +
> +	/* Mask the wakeup sources in M/F power domain */
> +	gpc->mfmix_mask[0] = 0x54010000;
> +	gpc->mfmix_mask[1] = 0xC00;
> +	gpc->mfmix_mask[2] = 0x0;
> +	gpc->mfmix_mask[3] = 0x400010;
> +
> +	suspend_set_ops(&imx_gpcv2_pm_ops);
> +	return 0;
> +
> +error_exit:
> +	kfree(pm);
> +	kfree(gpc);
> +	return -ENODEV;
> +}
> +
> +device_initcall(imx_gpcv2_pm_init);
> diff --git a/arch/arm/mach-imx/suspend-imx7.S
> b/arch/arm/mach-imx/suspend-imx7.S
> new file mode 100644
> index 0000000..8c3f516
> --- /dev/null
> +++ b/arch/arm/mach-imx/suspend-imx7.S
> @@ -0,0 +1,529 @@
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
> +
> +	.macro enable_l1_dcache
> +
> +	/* Enable L1 data cache. */
> +	mrc	p15, 0, r6, c1, c0, 0
> +	orr	r6, r6, #0x4
> +	mcr	p15, 0, r6, c1, c0, 0
> +
> +	dsb
> +	isb
> +
> +	.endm
> +
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
> +	cmp	r5, #0x0
> +	beq	101f
> +	ldr	r7, =0x170
> +	orr	r7, r7, #0x8
> +	str	r7, [r11, #0x20]
> +
> +101:
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
> +
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
> +	ldr	r6, [r0, #PM_INFO_MX7_IOMUXC_GPR_V_OFFSET]
> +	ldr	r7, [r0, #0x0]
> +	ldr	r6, [r0, #PM_INFO_MX7_CCM_V_OFFSET]
> +	add	r6, #0x4000
> +	ldr	r7, [r6]
> +	ldr	r6, [r0, #PM_INFO_MX7_ANATOP_V_OFFSET]
> +	ldr	r7, [r6, #0x0]
> +	ldr	r6, [r0, #PM_INFO_MX7_SRC_V_OFFSET]
> +	ldr	r7, [r6, #0x0]
> +	add	r6, #0x1000
> +	ldr	r7, [r6]
> +	ldr	r6, [r0, #PM_INFO_MX7_DDRC_V_OFFSET]
> +	ldr	r7, [r6, #0x0]
> +	ldr	r7, [r6, #0x490]
> +	ldr	r6, [r0, #PM_INFO_MX7_DDRC_PHY_V_OFFSET]
> +	ldr	r7, [r6, #0x0]
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
> +	ldr	r11, [r0, #PM_INFO_MX7_IOMUXC_GPR_V_OFFSET]
> +	ldr	r7, =0x170
> +	orr	r7, r7, #0x8
> +	str	r7, [r11, #0x20]
> +
> +	/* clear core0's entry and parameter */
> +	ldr	r11, [r0, #PM_INFO_MX7_SRC_V_OFFSET]
> +	mov	r7, #0x0
> +	str	r7, [r11, #MX7_SRC_GPR1]
> +	str	r7, [r11, #MX7_SRC_GPR2]
> +
> +	enable_l1_dcache
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
> --
> 2.5.0.rc2
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
