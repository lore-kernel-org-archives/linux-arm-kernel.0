From: kmpark@infradead.org (Kyungmin Park)
Date: Sat, 4 Feb 2012 18:41:08 +0900
Subject: [PATCH 1/2] ARM: EXYNOS: Add files about definition of C2C
In-Reply-To: <000501cce314$cf9fcff0$6edf6fd0$%lee@samsung.com>
References: <000501cce314$cf9fcff0$6edf6fd0$%lee@samsung.com>
Message-ID: <CAH9JG2UZ5DzR4ReTQSvAcGJVY8HL1mUk-yWEu+KGDMJLtpehgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 4, 2012 at 5:13 PM, Kisang Lee <kisang80.lee@samsung.com> wrote:
> Cc: Arnd Bergmann <arnd <at> arndb.de>
> Cc: Greg Kroah-Hartman <greg <at> kroah.com>
>
> Following files are added for C2C driver
> c2c.h : Definition of C2C platform data and mode
> regs-c2c.h : Definition of C2C registers
>
> Signed-off-by: Kisang Lee <kisang80.lee@samsung.com>
> ---
Hi,
> ?arch/arm/mach-exynos/include/mach/c2c.h ? ? ?| ? 65 +++++++++++++++++++++++
One nit. some parts are c2c common and gpio and platform setup codes
are exynos specific.
> ?arch/arm/mach-exynos/include/mach/regs-c2c.h | ? 71 ++++++++++++++++++++++++++
Are there any reason to put here? I think you can merge with 2/2
patch. I mean you can move it under drivers/misc/c2c.

Thank you,
Kyungmin Park
> ?2 files changed, 136 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-exynos/include/mach/c2c.h
> ?create mode 100644 arch/arm/mach-exynos/include/mach/regs-c2c.h
>
> diff --git a/arch/arm/mach-exynos/include/mach/c2c.h b/arch/arm/mach-exynos/include/mach/c2c.h
> new file mode 100644
> index 0000000..c3d6131
> --- /dev/null
> +++ b/arch/arm/mach-exynos/include/mach/c2c.h
> @@ -0,0 +1,65 @@
> +/* linux/arch/arm/mach-exynos/include/mach/c2c.h
> + *
> + * Copyright 2011 Samsung Electronics Co., Ltd.
> + * ? ? ? ? ? ? http://www.samsung.com/
> + *
> + * Platform header file for Samsung C2C Interface driver
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +#ifndef __ASM_PLAT_C2C_H
> +#define __ASM_PLAT_C2C_H __FILE__
> +
> +#define C2C_SHAREDMEM_BASE 0x60000000
> +
> +enum c2c_opp_mode {
> + ? ? ? C2C_OPP0 = 0,
> + ? ? ? C2C_OPP25 = 1,
> + ? ? ? C2C_OPP50 = 2,
> + ? ? ? C2C_OPP100 = 3,
> +};
> +
> +enum c2c_buswidth {
> + ? ? ? C2C_BUSWIDTH_8 = 0,
> + ? ? ? C2C_BUSWIDTH_10 = 1,
> + ? ? ? C2C_BUSWIDTH_16 = 2,
> +};
> +
> +enum c2c_shrdmem_size {
> + ? ? ? C2C_MEMSIZE_4 = 0,
> + ? ? ? C2C_MEMSIZE_8 = 1,
> + ? ? ? C2C_MEMSIZE_16 = 2,
> + ? ? ? C2C_MEMSIZE_32 = 3,
> + ? ? ? C2C_MEMSIZE_64 = 4,
> + ? ? ? C2C_MEMSIZE_128 = 5,
> + ? ? ? C2C_MEMSIZE_256 = 6,
> + ? ? ? C2C_MEMSIZE_512 = 7,
> +};
> +
> +struct exynos_c2c_platdata {
> + ? ? ? void (*setup_gpio)(enum c2c_buswidth rx_width,
> + ? ? ? ? ? ? ? ? ? ? ? enum c2c_buswidth tx_width);
> +
> + ? ? ? u32 shdmem_addr;
> + ? ? ? enum c2c_shrdmem_size shdmem_size;
> +
> + ? ? ? void __iomem *ap_sscm_addr;
> + ? ? ? void __iomem *cp_sscm_addr;
> +
> + ? ? ? enum c2c_buswidth rx_width;
> + ? ? ? enum c2c_buswidth tx_width;
> + ? ? ? u32 clk_opp100; /* clock of OPP100 mode */
> + ? ? ? u32 clk_opp50; ?/* clock of OPP50 mode */
> + ? ? ? u32 clk_opp25; ?/* clock of OPP25 */
> + ? ? ? enum c2c_opp_mode default_opp_mode;
> +
> + ? ? ? void __iomem *c2c_sysreg; ? ? ? /* System Register address for C2C */
> + ? ? ? char *c2c_clk;
> +};
> +
> +extern void exynos_c2c_set_platdata(struct exynos_c2c_platdata *pd);
> +extern void exynos_c2c_cfg_gpio(enum c2c_buswidth rx_width,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? enum c2c_buswidth tx_width);
> +#endif /*__ASM_PLAT_C2C_H */
> diff --git a/arch/arm/mach-exynos/include/mach/regs-c2c.h b/arch/arm/mach-exynos/include/mach/regs-c2c.h
> new file mode 100644
> index 0000000..0c3d005
> --- /dev/null
> +++ b/arch/arm/mach-exynos/include/mach/regs-c2c.h
> @@ -0,0 +1,71 @@
> +/* linux/arch/arm/mach-exynos/include/mach/regs-c2c.h
> + *
> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> + * http://www.samsung.com/
> + *
> + * Register definition file for Samsung C2C
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __ASM_ARM_REGS_S5P_C2C_H
> +#define __ASM_ARM_REGS_S5P_C2C_H
> +
> +/***************************************************************/
> +/* C2C Registers part ? ? ? ? ? ? ? ? ? ? ? ? ?*/
> +/***************************************************************/
> +#define EXYNOS_C2C_REVISION ? ? ? ? ? ?0x0
> +#define EXYNOS_C2C_SYSCONFIG ? ? ? ? ? 0x4
> +#define EXYNOS_C2C_SYSSTATUS ? ? ? ? ? 0x8
> +#define EXYNOS_C2C_PORTCONFIG ? ? ? ? ?0xc
> +#define EXYNOS_C2C_MIRRORMODE ? ? ? ? ?0x10
> +#define EXYNOS_C2C_IRQ_RAW_STAT0 ? ? ? 0x14
> +#define EXYNOS_C2C_IRQ_RAW_STAT1 ? ? ? 0x18
> +#define EXYNOS_C2C_IRQ_EN_STAT0 ? ? ? ?0x1c
> +#define EXYNOS_C2C_IRQ_EN_STAT1 ? ? ? ?0x20
> +#define EXYNOS_C2C_IRQ_EN_SET0 ? ? ? ? 0x24
> +#define EXYNOS_C2C_IRQ_EN_SET1 ? ? ? ? 0x28
> +#define EXYNOS_C2C_IRQ_EN_CLEAR0 ? ? ? 0x2c
> +#define EXYNOS_C2C_IRQ_EN_CLEAR1 ? ? ? 0x30
> +#define EXYNOS_C2C_IRQ_EOI ? ? ? ? ? ? 0x34
> +
> +#define EXYNOS_C2C_FCLK_FREQ ? ? ? ? ? 0x40
> +#define EXYNOS_C2C_RX_MAX_FREQ ? ? ? ? 0x44
> +#define EXYNOS_C2C_TX_MAX_FREQ ? ? ? ? 0x48
> +#define EXYNOS_C2C_RX_MAX_FREQ_ACK ? ? 0x4c
> +#define EXYNOS_C2C_WAKE_REQ ? ? ? ? ? ?0x50
> +#define EXYNOS_C2C_WAKE_ACK ? ? ? ? ? ?0x54
> +#define EXYNOS_C2C_STANDBY ? ? ? ? ? ? 0x60
> +#define EXYNOS_C2C_STANDBY_IN ? ? ? ? ?0x64
> +#define EXYNOS_C2C_WAIT ? ? ? ? ? ? ? ?0x68
> +#define EXYNOS_C2C_GENI_CONTROL ? ? ? ?0x70
> +#define EXYNOS_C2C_GENI_MASK ? ? ? ? ? 0x74
> +#define EXYNOS_C2C_GENO_STATUS ? ? ? ? 0x80
> +
> +#define EXYNOS_C2C_GENO_INT ? ? ? ? ? ?0x84
> +#define EXYNOS_C2C_GENO_LEVEL ? ? ? ? ?0x88
> +
> +/***************************************************************/
> +/* C2C Bit definition part ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? */
> +/***************************************************************/
> +/* SYSREG Bit definition */
> +#define C2C_SYSREG_CG ? ? ? ? ?(31) /* C2C Clock Gating [31] */
> +#define C2C_SYSREG_MO ? ? ? ? ?(30) /* Master On [30] */
> +#define C2C_SYSREG_FCLK ? ? ? ? ? ? ? ?(20) /* Default Functional Clock Freq [29:20] */
> +#define C2C_SYSREG_TXW ? ? ? ? (18) /* Default Tx Width [19:18] */
> +#define C2C_SYSREG_RXW ? ? ? ? (16) /* Default Rx Width [17:16] */
> +#define C2C_SYSREG_RST ? ? ? ? (15) /* Reset [15] */
> +#define C2C_SYSREG_MD ? ? ? ? ?(14) /* Master On [14] */
> +#define C2C_SYSREG_RTRST ? ? ? (13) /* Reset retention registers [13] */
> +#define C2C_SYSREG_BASE_ADDR ? (3) ?/* DRAM Base Address [12:3] */
> +#define C2C_SYSREG_DRAM_SIZE ? (0) ?/* DRAM Size [2:0] */
> +
> +#define C2C_GENIO_LATENCY_INT ?(26)
> +#define C2C_GENIO_OPP_INT ? ? ?(27)
> +#define C2C_GENIO_OPP_MODE0 ? ?(28)
> +#define C2C_GENIO_OPP_MODE1 ? ?(29)
> +#define C2C_GENIO_LATENCY0 ? ? (30)
> +#define C2C_GENIO_LATENCY1 ? ? (31)
> +#endif /* __ASM_ARM_REGS_S5P_C2C_H */
> --
> 1.7.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
