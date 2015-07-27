From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 27 Jul 2015 21:40:58 +0800
Subject: [PATCH v6 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <1437584859-64203-2-git-send-email-shenwei.wang@freescale.com>
References: <1437584859-64203-1-git-send-email-shenwei.wang@freescale.com>
 <1437584859-64203-2-git-send-email-shenwei.wang@freescale.com>
Message-ID: <20150727134058.GL12927@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 22, 2015 at 12:07:38PM -0500, Shenwei Wang wrote:
> diff --git a/include/soc/imx/gpcv2.h b/include/soc/imx/gpcv2.h
> new file mode 100644
> index 0000000..73d6e75
> --- /dev/null
> +++ b/include/soc/imx/gpcv2.h

I do not like this header, which couples imx7d irqchip and pm driver so
much.  Can you please elaborate why we have to have this header?

Shawn

> @@ -0,0 +1,163 @@
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
> +	WAIT_CLOCKED,
> +	WAIT_UNCLOCKED,
> +	WAIT_UNCLOCKED_POWER_OFF,
> +	STOP_POWER_ON,
> +	STOP_POWER_OFF,
> +};
> +
> +
> +/* GPCv2 has the following power domains, and each domain can be power-up
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
> +struct imx_gpcv2_irq {
> +	spinlock_t lock;
> +	void __iomem *gpc_base;
> +	u32 wakeup_sources[IMR_NUM];
> +	u32 enabled_irqs[IMR_NUM];
> +	u32 cpu2wakeup;
> +};
> +
> +struct imx_gpcv2_suspend {
> +	struct regmap *anatop;
> +	struct regmap *imx_src;
> +	u32 mfmix_mask[IMR_NUM];
> +	u32 wakeupmix_mask[IMR_NUM];
> +	u32 lpsrmix_mask[IMR_NUM];
> +
> +	void (*set_mode)(struct imx_gpcv2 *, enum gpcv2_mode mode);
> +	void (*lpm_cpu_power_gate)(struct imx_gpcv2 *, u32, bool);
> +	void (*lpm_plat_power_gate)(struct imx_gpcv2 *, bool);
> +	void (*lpm_env_setup)(struct imx_gpcv2 *);
> +	void (*lpm_env_clean)(struct imx_gpcv2 *);
> +
> +	void (*set_slot)(struct imx_gpcv2 *cd, u32 index,
> +			enum gpcv2_slot m_core, bool mode, bool ack);
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
> +	struct imx_gpcv2_irq *irqchip;
> +	struct imx_gpcv2_suspend *pm;
> +};
> +
> +void ca7_cpu_resume(void);
> +void imx7_suspend(void __iomem *ocram_vbase);
> +
> +#endif  /* __SOC_IMX_GPCV2_H__ */
> -- 
> 2.5.0.rc2
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
