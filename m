From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 18 Nov 2009 22:15:11 +0000
Subject: [PATCH 12/19] ARM: S5PC1XX: add support for s5pc110 plls and
	clocks
In-Reply-To: <1258551194-16018-13-git-send-email-m.szyprowski@samsung.com>
References: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
	<1258551194-16018-13-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20091118221510.GC4808@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2009 at 02:33:07PM +0100, Marek Szyprowski wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Samsung S5PC110 SoC are newer Samsung SoCs. Like S5PC100 they are based
> on CortexA8 ARM CPU, but have much more powerfull integrated periperals.
> This patch adds clocks and plls definition for S5PC110 SoCs.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> ---
>  arch/arm/mach-s5pc110/Kconfig                   |    1 +
>  arch/arm/mach-s5pc110/cpu.c                     |    3 +
>  arch/arm/mach-s5pc110/include/plat/regs-clock.h |  347 ++++++
>  arch/arm/plat-s5pc1xx/Kconfig                   |    5 +
>  arch/arm/plat-s5pc1xx/Makefile                  |    1 +
>  arch/arm/plat-s5pc1xx/include/plat/pll.h        |    8 +-
>  arch/arm/plat-s5pc1xx/include/plat/s5pc110.h    |   11 +
>  arch/arm/plat-s5pc1xx/s5pc100-plls.c            |    8 +-
>  arch/arm/plat-s5pc1xx/s5pc110-clocks.c          |  254 +++++
>  arch/arm/plat-s5pc1xx/s5pc110-plls.c            | 1292 +++++++++++++++++++++++

Are these files likely to be shared with other SoCs? If not, then they
would be better off going in arch/arm/mach-s5pc110/ instead of here and
just being compiled if the machine support is enabled.

>  10 files changed, 1924 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm/mach-s5pc110/include/plat/regs-clock.h
>  create mode 100644 arch/arm/plat-s5pc1xx/s5pc110-clocks.c
>  create mode 100644 arch/arm/plat-s5pc1xx/s5pc110-plls.c
> 
> diff --git a/arch/arm/mach-s5pc110/Kconfig b/arch/arm/mach-s5pc110/Kconfig
> index fb298e2..420b585 100644
> --- a/arch/arm/mach-s5pc110/Kconfig
> +++ b/arch/arm/mach-s5pc110/Kconfig
> @@ -12,6 +12,7 @@ if ARCH_S5PC110
>  config CPU_S5PC110
>  	bool
>  	select CPU_S5PC110_INIT
> +	select CPU_S5PC110_CLOCK
>  	help
>  	  Enable S5PC110 CPU support
>  
> diff --git a/arch/arm/mach-s5pc110/cpu.c b/arch/arm/mach-s5pc110/cpu.c
> index 1a4a5e4..6c9ebcb 100644
> --- a/arch/arm/mach-s5pc110/cpu.c
> +++ b/arch/arm/mach-s5pc110/cpu.c
> @@ -86,6 +86,9 @@ void __init s5pc110_init_clocks(int xtal)
>  {
>  	printk(KERN_DEBUG "%s: initialising clocks\n", __func__);
>  	s3c24xx_register_baseclocks(xtal);
> +	s5pc1xx_register_clocks();
> +	s5pc110_register_clocks();
> +	s5pc110_setup_clocks();
>  }
>  
>  void __init s5pc110_init_irq(void)
> diff --git a/arch/arm/mach-s5pc110/include/plat/regs-clock.h b/arch/arm/mach-s5pc110/include/plat/regs-clock.h
> new file mode 100644
> index 0000000..4305a07
> --- /dev/null
> +++ b/arch/arm/mach-s5pc110/include/plat/regs-clock.h
> @@ -0,0 +1,347 @@
> +/* arch/arm/plat-s5pc1xx/include/plat/regs-clock.h
> + *
> + * Copyright 2009 Samsung Electronics Co.
> + *	Byungho Min <bhmin@samsung.com>
> + *
> + * S5PC110 clock register definitions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __PLAT_REGS_CLOCK_H
> +#define __PLAT_REGS_CLOCK_H __FILE__
> +
> +#define S5PC1XX_CLKREG(x)		(S5PC1XX_VA_CLK + (x))
> +
> +/* s5pc110 register for clock */
> +#define S5PC110_APLL_LOCK		S5PC1XX_CLKREG(0x00)
> +#define S5PC110_MPLL_LOCK		S5PC1XX_CLKREG(0x08)
> +#define S5PC110_EPLL_LOCK		S5PC1XX_CLKREG(0x10)
> +#define S5PC110_VPLL_LOCK		S5PC1XX_CLKREG(0x20)
> +
> +#define S5PC110_APLL_CON		S5PC1XX_CLKREG(0x100)
> +#define S5PC110_MPLL_CON		S5PC1XX_CLKREG(0x108)
> +#define S5PC110_EPLL_CON		S5PC1XX_CLKREG(0x110)
> +#define S5PC110_VPLL_CON		S5PC1XX_CLKREG(0x120)
> +
> +#define S5PC110_CLKSRC0			S5PC1XX_CLKREG(0x200)
> +#define S5PC110_CLKSRC1			S5PC1XX_CLKREG(0x204)
> +#define S5PC110_CLKSRC2			S5PC1XX_CLKREG(0x208)
> +#define S5PC110_CLKSRC3			S5PC1XX_CLKREG(0x20C)
> +#define S5PC110_CLKSRC4			S5PC1XX_CLKREG(0x210)
> +#define S5PC110_CLKSRC5			S5PC1XX_CLKREG(0x214)
> +#define S5PC110_CLKSRC6			S5PC1XX_CLKREG(0x218)
> +
> +#define S5PC110_CLKSRC_MASK0		S5PC1XX_CLKREG(0x280)
> +#define S5PC110_CLKSRC_MASK1		S5PC1XX_CLKREG(0x284)
> +
> +#define S5PC110_CLKDIV0		S5PC1XX_CLKREG(0x300)
> +#define S5PC110_CLKDIV1		S5PC1XX_CLKREG(0x304)
> +#define S5PC110_CLKDIV2		S5PC1XX_CLKREG(0x308)
> +#define S5PC110_CLKDIV3		S5PC1XX_CLKREG(0x30C)
> +#define S5PC110_CLKDIV4		S5PC1XX_CLKREG(0x310)
> +#define S5PC110_CLKDIV5		S5PC1XX_CLKREG(0x314)
> +#define S5PC110_CLKDIV6		S5PC1XX_CLKREG(0x318)
> +#define S5PC110_CLKDIV7		S5PC1XX_CLKREG(0x31C)
> +
> +#define S5PC110_CLKGATE_IP0		S5PC1XX_CLKREG(0x460)
> +#define S5PC110_CLKGATE_IP1		S5PC1XX_CLKREG(0x464)
> +#define S5PC110_CLKGATE_IP2		S5PC1XX_CLKREG(0x468)
> +#define S5PC110_CLKGATE_IP3		S5PC1XX_CLKREG(0x46C)
> +#define S5PC110_CLKGATE_IP4		S5PC1XX_CLKREG(0x470)
> +#define S5PC110_CLKGATE_BLOCK		S5PC1XX_CLKREG(0x480)
> +#define S5PC110_CLKGATE_BUS0		S5PC1XX_CLKREG(0x484)
> +#define S5PC110_CLKGATE_BUS1		S5PC1XX_CLKREG(0x488)
> +
> +#define S5PC110_CLK_OUT			S5PC1XX_CLKREG(0x500)
> +#define S5PC110_MDNIE_SEL		S5PC1XX_CLKREG(0x7008)
> +
> +#define S5PC110_CLKDIV_STAT0		S5PC1XX_CLKREG(0x1000)
> +#define S5PC110_CLKDIV_STAT1		S5PC1XX_CLKREG(0x1004)
> +
> +#define S5PC110_CLK_MUX_STAT0		S5PC1XX_CLKREG(0x1100)
> +#define S5PC110_CLK_MUX_STAT1		S5PC1XX_CLKREG(0x1104)
> +
> +#define S5PC110_SWRESET		S5PC1XX_CLKREG(0x2000)
> +
> +#define S5PC110_CLKSRC0_APLL_MASK		(0x1<<0)
> +#define S5PC110_CLKSRC0_APLL_SHIFT		(0)
> +#define S5PC110_CLKSRC0_MPLL_MASK		(0x1<<4)
> +#define S5PC110_CLKSRC0_MPLL_SHIFT		(4)
> +#define S5PC110_CLKSRC0_EPLL_MASK		(0x1<<8)
> +#define S5PC110_CLKSRC0_EPLL_SHIFT		(8)
> +#define S5PC110_CLKSRC0_VPLL_MASK		(0x1<<12)
> +#define S5PC110_CLKSRC0_VPLL_SHIFT		(12)
> +#define S5PC110_CLKSRC0_MUX200_MASK		(0x1<<16)
> +#define S5PC110_CLKSRC0_MUX200_SHIFT		(16)
> +#define S5PC110_CLKSRC0_MUX166_MASK		(0x1<<20)
> +#define S5PC110_CLKSRC0_MUX166_SHIFT		(20)
> +#define S5PC110_CLKSRC0_MUX133_MASK		(0x1<<24)
> +#define S5PC110_CLKSRC0_MUX133_SHIFT		(24)
> +#define S5PC110_CLKSRC0_ONENAND_MASK		(0x1<<28)
> +#define S5PC110_CLKSRC0_ONENAND_SHIFT		(28)
> +
> +#define S5PC110_CLKSRC1_HDMI_MASK		(0x1<<0)
> +#define S5PC110_CLKSRC1_HDMI_SHIFT		(0)
> +#define S5PC110_CLKSRC1_MIXER_MASK		(0x7<<1)
> +#define S5PC110_CLKSRC1_MIXER_SHIFT		(1)
> +#define S5PC110_CLKSRC1_DAC_MASK		(0x1<<8)
> +#define S5PC110_CLKSRC1_DAC_SHIFT		(8)
> +#define S5PC110_CLKSRC1_CAM0_MASK		(0xf<<12)
> +#define S5PC110_CLKSRC1_CAM0_SHIFT		(12)
> +#define S5PC110_CLKSRC1_CAM1_MASK		(0xf<<16)
> +#define S5PC110_CLKSRC1_CAM1_SHIFT		(16)
> +#define S5PC110_CLKSRC1_FIMD_MASK		(0xf<<20)
> +#define S5PC110_CLKSRC1_FIMD_SHIFT		(20)
> +#define S5PC110_CLKSRC1_CSIS_MASK		(0xf<<24)
> +#define S5PC110_CLKSRC1_CSIS_SHIFT		(24)
> +#define S5PC110_CLKSRC1_VPLLSRC_MASK		(0x1<<28)
> +#define S5PC110_CLKSRC1_VPLLSRC_SHIFT		(28)
> +
> +#define S5PC110_CLKSRC2_G3D_MASK		(0x3<<0)
> +#define S5PC110_CLKSRC2_G3D_SHIFT		(0)
> +#define S5PC110_CLKSRC2_MFC_MASK		(0x3<<4)
> +#define S5PC110_CLKSRC2_MFC_SHIFT		(4)
> +
> +#define S5PC110_CLKSRC3_MDNIE_MASK		(0xf<<0)
> +#define S5PC110_CLKSRC3_MDNIE_SHIFT		(0)
> +#define S5PC110_CLKSRC3_MDNIE_PWMCLK_MASK	(0xf<<4)
> +#define S5PC110_CLKSRC3_MDNIE_PWMCLK_SHIFT	(4)
> +#define S5PC110_CLKSRC3_FIMC0_LCLK_MASK		(0xf<<12)
> +#define S5PC110_CLKSRC3_FIMC0_LCLK_SHIFT	(12)
> +#define S5PC110_CLKSRC3_FIMC1_LCLK_MASK		(0xf<<16)
> +#define S5PC110_CLKSRC3_FIMC1_LCLK_SHIFT	(16)
> +#define S5PC110_CLKSRC3_FIMC2_LCLK_MASK		(0xf<<20)
> +#define S5PC110_CLKSRC3_FIMC2_LCLK_SHIFT	(20)
> +
> +/* CLKSRC4 */
> +#define S5PC110_CLKSRC4_MMC0_MASK		(0xf<<0)
> +#define S5PC110_CLKSRC4_MMC0_SHIFT		(0)
> +#define S5PC110_CLKSRC4_MMC1_MASK		(0xf<<4)
> +#define S5PC110_CLKSRC4_MMC1_SHIFT		(4)
> +#define S5PC110_CLKSRC4_MMC2_MASK		(0xf<<8)
> +#define S5PC110_CLKSRC4_MMC2_SHIFT		(8)
> +#define S5PC110_CLKSRC4_MMC3_MASK		(0xf<<12)
> +#define S5PC110_CLKSRC4_MMC3_SHIFT		(12)
> +#define S5PC110_CLKSRC4_UART0_MASK		(0xf<<16)
> +#define S5PC110_CLKSRC4_UART0_SHIFT		(16)
> +#define S5PC110_CLKSRC4_UART1_MASK		(0xf<<20)
> +#define S5PC110_CLKSRC4_UART1_SHIFT		(20)
> +#define S5PC110_CLKSRC4_UART2_MASK		(0xf<<24)
> +#define S5PC110_CLKSRC4_UART2_SHIFT		(24)
> +#define S5PC110_CLKSRC4_UART3_MASK		(0xf<<28)
> +#define S5PC110_CLKSRC4_UART3_SHIFT		(28)
> +
> +/* CLKSRC5 */
> +#define S5PC110_CLKSRC5_SPI0_MASK		(0xf<<0)
> +#define S5PC110_CLKSRC5_SPI0_SHIFT		(0)
> +#define S5PC110_CLKSRC5_SPI1_MASK		(0xf<<4)
> +#define S5PC110_CLKSRC5_SPI1_SHIFT		(4)
> +#define S5PC110_CLKSRC5_SPI2_MASK		(0xf<<8)
> +#define S5PC110_CLKSRC5_SPI2_SHIFT		(8)
> +#define S5PC110_CLKSRC5_PWM_MASK		(0xf<<12)
> +#define S5PC110_CLKSRC5_PWM_SHIFT		(12)
> +
> +/* CLKSRC6 */
> +#define S5PC110_CLKSRC6_AUDIO0_MASK		(0xf<<0)
> +#define S5PC110_CLKSRC6_AUDIO0_SHIFT		(0)
> +#define S5PC110_CLKSRC6_AUDIO1_MASK		(0xf<<4)
> +#define S5PC110_CLKSRC6_AUDIO1_SHIFT		(4)
> +#define S5PC110_CLKSRC6_AUDIO2_MASK		(0xf<<8)
> +#define S5PC110_CLKSRC6_AUDIO2_SHIFT		(4)
> +#define S5PC110_CLKSRC6_SPDIF_MASK		(0x3<<12)
> +#define S5PC110_CLKSRC6_SPDIF_SHIFT		(12)
> +#define S5PC110_CLKSRC6_HPM_MASK		(0x1<<16)
> +#define S5PC110_CLKSRC6_HPM_SHIFT		(16)
> +#define S5PC110_CLKSRC6_PWI_MASK		(0xf<<20)
> +#define S5PC110_CLKSRC6_PWI_SHIFT		(20)
> +#define S5PC110_CLKSRC6_ONEDRAM_MASK		(0x3<<24)
> +#define S5PC110_CLKSRC6_ONEDRAM_SHIFT		(24)
> +
> +#define S5PC110_CLKDIV0_APLL_MASK		(0x7<<0)
> +#define S5PC110_CLKDIV0_APLL_SHIFT		(0)
> +#define S5PC110_CLKDIV0_A2M_MASK		(0x7<<4)
> +#define S5PC110_CLKDIV0_A2M_SHIFT		(4)
> +#define S5PC110_CLKDIV0_HCLK_MSYS_MASK		(0x7<<8)
> +#define S5PC110_CLKDIV0_HCLK_MSYS_SHIFT	(8)
> +#define S5PC110_CLKDIV0_PCLK_MSYS_MASK		(0x7<<12)
> +#define S5PC110_CLKDIV0_PCLK_MSYS_SHIFT	(12)
> +#define S5PC110_CLKDIV0_HCLK_DSYS_MASK		(0xf<<16)
> +#define S5PC110_CLKDIV0_HCLK_DSYS_SHIFT	(16)
> +#define S5PC110_CLKDIV0_PCLK_DSYS_MASK		(0x7<<20)
> +#define S5PC110_CLKDIV0_PCLK_DSYS_SHIFT	(20)
> +#define S5PC110_CLKDIV0_HCLK_PSYS_MASK		(0xf<<24)
> +#define S5PC110_CLKDIV0_HCLK_PSYS_SHIFT	(24)
> +#define S5PC110_CLKDIV0_PCLK_PSYS_MASK		(0x7<<28)
> +#define S5PC110_CLKDIV0_PCLK_PSYS_SHIFT	(28)
> +
> +#define S5PC110_CLKDIV1_TBLK_MASK		(0xf<<0)
> +#define S5PC110_CLKDIV1_TBLK_SHIFT		(0)
> +#define S5PC110_CLKDIV1_FIMC_MASK		(0xf<<8)
> +#define S5PC110_CLKDIV1_FIMC_SHIFT		(8)
> +#define S5PC110_CLKDIV1_CAM0_MASK		(0xf<<12)
> +#define S5PC110_CLKDIV1_CAM0_SHIFT		(12)
> +#define S5PC110_CLKDIV1_CAM1_MASK		(0xf<<16)
> +#define S5PC110_CLKDIV1_CAM1_SHIFT		(16)
> +#define S5PC110_CLKDIV1_FIMD_MASK		(0xf<<20)
> +#define S5PC110_CLKDIV1_FIMD_SHIFT		(20)
> +#define S5PC110_CLKDIV1_CSIS_MASK		(0xf<<28)
> +#define S5PC110_CLKDIV1_CSIS_SHIFT		(28)
> +
> +#define S5PC110_CLKDIV2_G3D_MASK		(0xf<<0)
> +#define S5PC110_CLKDIV2_G3D_SHIFT		(0)
> +#define S5PC110_CLKDIV2_MFC_MASK		(0xf<<4)
> +#define S5PC110_CLKDIV2_MFC_SHIFT		(4)
> +
> +#define S5PC110_CLKDIV3_MDNIE_MASK		(0xf<<0)
> +#define S5PC110_CLKDIV3_MDNIE_SHIFT		(0)
> +#define S5PC110_CLKDIV3_MDNIE_PWM_MASK		(0x7f<<4)
> +#define S5PC110_CLKDIV3_MDNIE_PWM_SHIFT	(4)
> +#define S5PC110_CLKDIV3_FIMC0_LCLK_MASK	(0xf<<12)
> +#define S5PC110_CLKDIV3_FIMC0_LCLK_SHIFT	(12)
> +#define S5PC110_CLKDIV3_FIMC1_LCLK_MASK	(0xf<<16)
> +#define S5PC110_CLKDIV3_FIMC1_LCLK_SHIFT	(16)
> +#define S5PC110_CLKDIV3_FIMC2_LCLK_MASK	(0xf<<20)
> +#define S5PC110_CLKDIV3_FIMC2_LCLK_SHIFT	(20)
> +
> +#define S5PC110_CLKDIV4_MMC0_MASK		(0xf<<0)
> +#define S5PC110_CLKDIV4_MMC0_SHIFT		(0)
> +#define S5PC110_CLKDIV4_MMC1_MASK		(0xf<<4)
> +#define S5PC110_CLKDIV4_MMC1_SHIFT		(4)
> +#define S5PC110_CLKDIV4_MMC2_MASK		(0xf<<8)
> +#define S5PC110_CLKDIV4_MMC2_SHIFT		(8)
> +#define S5PC110_CLKDIV4_MMC3_MASK		(0xf<<12)
> +#define S5PC110_CLKDIV4_MMC3_SHIFT		(12)
> +#define S5PC110_CLKDIV4_UART0_MASK		(0xf<<16)
> +#define S5PC110_CLKDIV4_UART0_SHIFT		(16)
> +#define S5PC110_CLKDIV4_UART1_MASK		(0xf<<20)
> +#define S5PC110_CLKDIV4_UART1_SHIFT		(20)
> +#define S5PC110_CLKDIV4_UART2_MASK		(0xf<<24)
> +#define S5PC110_CLKDIV4_UART2_SHIFT		(24)
> +#define S5PC110_CLKDIV4_UART3_MASK		(0xf<<28)
> +#define S5PC110_CLKDIV4_UART3_SHIFT		(28)
> +
> +/* CLK_DIV5 */
> +#define S5PC110_CLKDIV5_SPI0_MASK		(0xf<<0)
> +#define S5PC110_CLKDIV5_SPI0_SHIFT		(0)
> +#define S5PC110_CLKDIV5_SPI1_MASK		(0xf<<4)
> +#define S5PC110_CLKDIV5_SPI1_SHIFT		(4)
> +#define S5PC110_CLKDIV5_SPI2_MASK		(0xf<<8)
> +#define S5PC110_CLKDIV5_SPI2_SHIFT		(8)
> +#define S5PC110_CLKDIV5_PWM_MASK		(0xf<<120)
> +#define S5PC110_CLKDIV5_PWM_SHIFT		(12)
> +
> +/* CLK_DIV6 */
> +#define S5PC110_CLKDIV6_AUDIO0_MASK		(0xf<<0)
> +#define S5PC110_CLKDIV6_AUDIO0_SHIFT		(0)
> +#define S5PC110_CLKDIV6_AUDIO1_MASK		(0xf<<4)
> +#define S5PC110_CLKDIV6_AUDIO1_SHIFT		(4)
> +#define S5PC110_CLKDIV6_AUDIO2_MASK		(0xf<<8)
> +#define S5PC110_CLKDIV6_AUDIO2_SHIFT		(8)
> +#define S5PC110_CLKDIV6_ONENAND_MASK		(0x7<<12)
> +#define S5PC110_CLKDIV6_ONENAND_SHIFT		(12)
> +#define S5PC110_CLKDIV6_COPY_MASK		(0x7<<16)
> +#define S5PC110_CLKDIV6_COPY_SHIFT		(16)
> +#define S5PC110_CLKDIV6_HPM_MASK		(0x7<<20)
> +#define S5PC110_CLKDIV6_HPM_SHIFT		(20)
> +#define S5PC110_CLKDIV6_PWI_MASK		(0xf<<24)
> +#define S5PC110_CLKDIV6_PWI_SHIFT		(24)
> +#define S5PC110_CLKDIV6_ONEDRAM_MASK		(0xf<<28)
> +#define S5PC110_CLKDIV6_ONEDRAM_SHIFT		(28)
> +
> +/* Clock Gate IP0 */
> +#define S5PC110_CLKGATE_IP0_DMC0		(1<<0)
> +#define S5PC110_CLKGATE_IP0_DMC1		(1<<1)
> +#define S5PC110_CLKGATE_IP0_MDMA		(1<<2)
> +#define S5PC110_CLKGATE_IP0_PDMA0		(1<<3)
> +#define S5PC110_CLKGATE_IP0_PDMA1		(1<<4)
> +#define S5PC110_CLKGATE_IP0_IMEM		(1<<5)
> +#define S5PC110_CLKGATE_IP0_G3D			(1<<8)
> +#define S5PC110_CLKGATE_IP0_MFC			(1<<16)
> +#define S5PC110_CLKGATE_IP0_FIMC0		(1<<24)
> +#define S5PC110_CLKGATE_IP0_FIMC1		(1<<25)
> +#define S5PC110_CLKGATE_IP0_FIMC2		(1<<26)
> +#define S5PC110_CLKGATE_IP0_JPEG		(1<<28)
> +#define S5PC110_CLKGATE_IP0_ROTATOR		(1<<29)
> +#define S5PC110_CLKGATE_IP0_IPC			(1<<30)
> +#define S5PC110_CLKGATE_IP0_CSIS		(1<<31)
> +
> +/* Clock Gate IP1 */
> +#define S5PC110_CLKGATE_IP1_FIMD		(1<<0)
> +#define S5PC110_CLKGATE_IP1_MIE			(1<<1)
> +#define S5PC110_CLKGATE_IP1_DSIM		(1<<2)
> +#define S5PC110_CLKGATE_IP1_VP			(1<<8)
> +#define S5PC110_CLKGATE_IP1_MIXER		(1<<9)
> +#define S5PC110_CLKGATE_IP1_TVENC		(1<<10)
> +#define S5PC110_CLKGATE_IP1_HDMI		(1<<11)
> +#define S5PC110_CLKGATE_IP1_USBOTG		(1<<16)
> +#define S5PC110_CLKGATE_IP1_USBHOST		(1<<17)
> +#define S5PC110_CLKGATE_IP1_NANDXL		(1<<24)
> +#define S5PC110_CLKGATE_IP1_CFCON		(1<<25)
> +#define S5PC110_CLKGATE_IP1_SROMC		(1<<26)
> +#define S5PC110_CLKGATE_IP1_NFCON		(1<<28)
> +
> +/* Clock Gate IP2 */
> +#define S5PC110_CLKGATE_IP2_SECSS		(1<<0)
> +#define S5PC110_CLKGATE_IP2_SDM			(1<<1)
> +#define S5PC110_CLKGATE_IP2_CORESIGHT		(1<<8)
> +#define S5PC110_CLKGATE_IP2_MODEM		(1<<9)
> +#define S5PC110_CLKGATE_IP2_HOSTIF		(1<<10)
> +#define S5PC110_CLKGATE_IP2_SECJTAG		(1<<11)
> +#define S5PC110_CLKGATE_IP2_HSMMC0		(1<<16)
> +#define S5PC110_CLKGATE_IP2_HSMMC1		(1<<17)
> +#define S5PC110_CLKGATE_IP2_HSMMC2		(1<<18)
> +#define S5PC110_CLKGATE_IP2_HSMMC3		(1<<19)
> +#define S5PC110_CLKGATE_IP2_TSI			(1<<20)
> +#define S5PC110_CLKGATE_IP2_VIC0		(1<<24)
> +#define S5PC110_CLKGATE_IP2_VIC1		(1<<25)
> +#define S5PC110_CLKGATE_IP2_VIC2		(1<<26)
> +#define S5PC110_CLKGATE_IP2_VIC3		(1<<27)
> +#define S5PC110_CLKGATE_IP2_TZIC0		(1<<28)
> +#define S5PC110_CLKGATE_IP2_TZIC1		(1<<29)
> +#define S5PC110_CLKGATE_IP2_TZIC2		(1<<30)
> +#define S5PC110_CLKGATE_IP2_TZIC3		(1<<31)
> +
> +/* Clock Gate IP3 */
> +#define S5PC110_CLKGATE_IP3_SPDIF		(1<<0)
> +#define S5PC110_CLKGATE_IP3_AC97		(1<<1)
> +#define S5PC110_CLKGATE_IP3_I2S0		(1<<4)
> +#define S5PC110_CLKGATE_IP3_I2S1		(1<<5)
> +#define S5PC110_CLKGATE_IP3_I2S2		(1<<6)
> +#define S5PC110_CLKGATE_IP3_I2C0		(1<<7)
> +#define S5PC110_CLKGATE_IP3_I2C1		(1<<8)
> +#define S5PC110_CLKGATE_IP3_I2C2		(1<<9)
> +#define S5PC110_CLKGATE_IP3_I2C_HDMI_DDC	(1<<10)
> +#define S5PC110_CLKGATE_IP3_I2C_HDMI_PHY	(1<<11)
> +#define S5PC110_CLKGATE_IP3_SPI0		(1<<12)
> +#define S5PC110_CLKGATE_IP3_SPI1		(1<<13)
> +#define S5PC110_CLKGATE_IP3_SPI2		(1<<14)
> +#define S5PC110_CLKGATE_IP3_RTC			(1<<15)
> +#define S5PC110_CLKGATE_IP3_SYSTIMER		(1<<16)
> +#define S5PC110_CLKGATE_IP3_UART0		(1<<17)
> +#define S5PC110_CLKGATE_IP3_UART1		(1<<18)
> +#define S5PC110_CLKGATE_IP3_UART2		(1<<19)
> +#define S5PC110_CLKGATE_IP3_UART3		(1<<20)
> +#define S5PC110_CLKGATE_IP3_KEYIF		(1<<21)
> +#define S5PC110_CLKGATE_IP3_WDT			(1<<22)
> +#define S5PC110_CLKGATE_IP3_PWM			(1<<23)
> +#define S5PC110_CLKGATE_IP3_TSADC		(1<<24)
> +#define S5PC110_CLKGATE_IP3_GPIO		(1<<26)
> +#define S5PC110_CLKGATE_IP3_SYSCON		(1<<27)
> +#define S5PC110_CLKGATE_IP3_PCM0		(1<<28)
> +#define S5PC110_CLKGATE_IP3_PCM1		(1<<29)
> +#define S5PC110_CLKGATE_IP3_PCM2		(1<<30)
> +
> +/* Clock Gate IP4 */
> +#define S5PC110_CLKGATE_IP4_CHIP_ID		(1<<0)
> +#define S5PC110_CLKGATE_IP4_IEM_IEC		(1<<1)
> +#define S5PC110_CLKGATE_IP4_IEM_APC		(1<<2)
> +#define S5PC110_CLKGATE_IP4_SECKEY		(1<<3)
> +#define S5PC110_CLKGATE_IP4_TZPC0		(1<<5)
> +#define S5PC110_CLKGATE_IP4_TZPC1		(1<<6)
> +#define S5PC110_CLKGATE_IP4_TZPC2		(1<<7)
> +#define S5PC110_CLKGATE_IP4_TZPC3		(1<<8)
> +
> +#endif /* _PLAT_REGS_CLOCK_H */
> diff --git a/arch/arm/plat-s5pc1xx/Kconfig b/arch/arm/plat-s5pc1xx/Kconfig
> index 679e145..898cd82 100644
> --- a/arch/arm/plat-s5pc1xx/Kconfig
> +++ b/arch/arm/plat-s5pc1xx/Kconfig
> @@ -50,6 +50,11 @@ config CPU_S5PC110_INIT
>  	help
>  	  Common initialisation code for the S5PC1XX
>  
> +config CPU_S5PC110_CLOCK
> +	bool
> +	help
> +	  Common clock support code for the S5PC1XX
> +
>  # platform specific device setup
>  
>  endif
> diff --git a/arch/arm/plat-s5pc1xx/Makefile b/arch/arm/plat-s5pc1xx/Makefile
> index 3e8ebf1..b03a983 100644
> --- a/arch/arm/plat-s5pc1xx/Makefile
> +++ b/arch/arm/plat-s5pc1xx/Makefile
> @@ -21,6 +21,7 @@ obj-y				+= gpiolib.o
>  obj-$(CONFIG_CPU_S5PC100_INIT)	+= s5pc100-init.o
>  obj-$(CONFIG_CPU_S5PC100_CLOCK)	+= s5pc100-plls.o s5pc100-clocks.o
>  obj-$(CONFIG_CPU_S5PC110_INIT)	+= s5pc110-init.o
> +obj-$(CONFIG_CPU_S5PC110_CLOCK)	+= s5pc110-plls.o s5pc110-clocks.o
>  
>  # Device setup
>  
> diff --git a/arch/arm/plat-s5pc1xx/include/plat/pll.h b/arch/arm/plat-s5pc1xx/include/plat/pll.h
> index 21afef1..7380d16 100644
> --- a/arch/arm/plat-s5pc1xx/include/plat/pll.h
> +++ b/arch/arm/plat-s5pc1xx/include/plat/pll.h
> @@ -22,7 +22,7 @@
>  #include <asm/div64.h>
>  
>  static inline unsigned long s5pc1xx_get_pll(unsigned long baseclk,
> -					    u32 pllcon)
> +					    u32 pllcon, int sub)
>  {
>  	u32 mdiv, pdiv, sdiv;
>  	u64 fvco = baseclk;
> @@ -32,7 +32,11 @@ static inline unsigned long s5pc1xx_get_pll(unsigned long baseclk,
>  	sdiv = (pllcon >> S5P_PLL_SDIV_SHIFT) & S5P_PLL_SDIV_MASK;
>  
>  	fvco *= mdiv;
> -	do_div(fvco, (pdiv << sdiv));
> +
> +	if (sub)
> +		do_div(fvco, (pdiv << (sdiv - 1)));
> +	else
> +		do_div(fvco, (pdiv << sdiv));
>  
>  	return (unsigned long)fvco;
>  }
> diff --git a/arch/arm/plat-s5pc1xx/include/plat/s5pc110.h b/arch/arm/plat-s5pc1xx/include/plat/s5pc110.h
> index 93c623b..86d4952 100644
> --- a/arch/arm/plat-s5pc1xx/include/plat/s5pc110.h
> +++ b/arch/arm/plat-s5pc1xx/include/plat/s5pc110.h
> @@ -26,6 +26,17 @@ extern void s5pc110_init_irq(void);
>  extern void s5pc110_register_clocks(void);
>  extern void s5pc110_setup_clocks(void);
>  
> +extern struct clk clk_hpll;
> +extern struct clk clk_hd0;
> +extern struct clk clk_pd0;
> +extern struct clk clk_54m;
> +extern struct clk clk_30m;
> +extern int s5pc110_ip0_ctrl(struct clk *clk, int enable);
> +extern int s5pc110_ip1_ctrl(struct clk *clk, int enable);
> +extern int s5pc110_ip2_ctrl(struct clk *clk, int enable);
> +extern int s5pc110_ip3_ctrl(struct clk *clk, int enable);
> +extern int s5pc110_ip4_ctrl(struct clk *clk, int enable);
> +
>  #else
>  
>  #define s5pc110_map_io NULL
> diff --git a/arch/arm/plat-s5pc1xx/s5pc100-plls.c b/arch/arm/plat-s5pc1xx/s5pc100-plls.c
> index 45f073e..b7559f8 100644
> --- a/arch/arm/plat-s5pc1xx/s5pc100-plls.c
> +++ b/arch/arm/plat-s5pc1xx/s5pc100-plls.c
> @@ -1050,10 +1050,10 @@ void __init_or_cpufreq s5pc100_setup_clocks(void)
>  
>  	printk(KERN_DEBUG "%s: xtal is %ld\n", __func__, xtal);
>  
> -	apll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_APLL_CON));
> -	mpll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_MPLL_CON));
> -	epll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_EPLL_CON));
> -	hpll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_HPLL_CON));
> +	apll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_APLL_CON), 0);
> +	mpll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_MPLL_CON), 0);
> +	epll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_EPLL_CON), 0);
> +	hpll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_HPLL_CON), 0);
>  
>  	printk(KERN_INFO "S5PC100: Apll=%ld.%03ld Mhz, Mpll=%ld.%03ld Mhz"
>  		", Epll=%ld.%03ld Mhz, Hpll=%ld.%03ld Mhz\n",
> diff --git a/arch/arm/plat-s5pc1xx/s5pc110-clocks.c b/arch/arm/plat-s5pc1xx/s5pc110-clocks.c
> new file mode 100644
> index 0000000..456bd5e
> --- /dev/null
> +++ b/arch/arm/plat-s5pc1xx/s5pc110-clocks.c
> @@ -0,0 +1,254 @@
> +/* linux/arch/arm/plat-s5pc1xx/s5pc110-clocks.c
> + *
> + * Copyright 2009 Samsung Electronics Co.
> + *
> + * S5PC110 - Clocks support
> + *
> + * Based on plat-s3c64xx/clock.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/ioport.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/map.h>
> +
> +#include <plat/regs-clock.h>
> +#include <plat/devs.h>
> +#include <plat/clock.h>
> +
> +struct clk clk_27m = {
> +	.name		= "clk_27m",
> +	.id		= -1,
> +	.rate		= 27000000,
> +};
> +
> +struct clk clk_48m = {
> +	.name		= "clk_48m",
> +	.id		= -1,
> +	.rate		= 48000000,
> +};
> +
> +struct clk clk_54m = {
> +	.name		= "clk_54m",
> +	.id		= -1,
> +	.rate		= 54000000,
> +};
> +
> +struct clk clk_30m = {
> +	.name		= "clk_30m",
> +	.id		= -1,
> +	.rate		= 30000000,
> +};
> +
> +static int s5pc1xx_clk_gate(void __iomem *reg, struct clk *clk, int enable)
> +{
> +	unsigned int ctrlbit = clk->ctrlbit;
> +	u32 con;
> +
> +	con = __raw_readl(reg);
> +	if (enable)
> +		con |= ctrlbit;
> +	else
> +		con &= ~ctrlbit;
> +	__raw_writel(con, reg);
> +
> +	return 0;
> +}
> +
> +int s5pc110_ip0_ctrl(struct clk *clk, int enable)
> +{
> +	return s5pc1xx_clk_gate(S5PC110_CLKGATE_IP0, clk, enable);
> +}
> +
> +int s5pc110_ip1_ctrl(struct clk *clk, int enable)
> +{
> +	return s5pc1xx_clk_gate(S5PC110_CLKGATE_IP1, clk, enable);
> +}
> +
> +int s5pc110_ip2_ctrl(struct clk *clk, int enable)
> +{
> +	return s5pc1xx_clk_gate(S5PC110_CLKGATE_IP2, clk, enable);
> +}
> +
> +int s5pc110_ip3_ctrl(struct clk *clk, int enable)
> +{
> +	return s5pc1xx_clk_gate(S5PC110_CLKGATE_IP3, clk, enable);
> +}
> +
> +int s5pc110_ip4_ctrl(struct clk *clk, int enable)
> +{
> +	return s5pc1xx_clk_gate(S5PC110_CLKGATE_IP4, clk, enable);
> +}
> +
> +extern struct clk clk_dout_hclkm;
> +extern struct clk clk_dout_hclkd;
> +extern struct clk clk_dout_hclkp;
> +extern struct clk clk_dout_pclkd;
> +extern struct clk clk_dout_pclkp;
> +
> +static struct clk s5pc110_init_clocks_disable[] = {
> +	{
> +		.name		= "keypad",
> +		.id		= -1,
> +		.parent		= &clk_dout_pclkp,
> +		.enable		= s5pc110_ip3_ctrl,
> +		.ctrlbit	= S5PC110_CLKGATE_IP3_KEYIF,
> +	},
> +};
> +
> +static struct clk s5pc110_init_clocks[] = {
> +	/* IP0 */
> +	{
> +		.name		= "mfc",
> +		.id		= -1,
> +		.parent		= NULL,
> +		.enable		= s5pc110_ip0_ctrl,
> +		.ctrlbit	= S5PC110_CLKGATE_IP0_MFC,
> +	},
> +
> +	/* IP1 */
> +	{
> +		.name		= "lcd",
> +		.id		= -1,
> +		.parent		= &clk_dout_hclkd,
> +		.enable		= s5pc110_ip1_ctrl,
> +		.ctrlbit	= S5PC110_CLKGATE_IP1_FIMD,
> +	}, {
> +		.name		= "otg",
> +		.id		= -1,
> +		.parent		= &clk_dout_hclkp,
> +		.enable		= s5pc110_ip1_ctrl,
> +		.ctrlbit	= S5PC110_CLKGATE_IP1_USBOTG,
> +	},
> +
> +	/* IP2 */
> +	{
> +		.name		= "hsmmc",
> +		.id		= 0,
> +		.parent		= &clk_dout_hclkp,
> +		.enable		= s5pc110_ip2_ctrl,
> +		.ctrlbit	= S5PC110_CLKGATE_IP2_HSMMC0,
> +	}, {
> +		.name		= "hsmmc",
> +		.id		= 1,
> +		.parent		= &clk_dout_hclkp,
> +		.enable		= s5pc110_ip2_ctrl,
> +		.ctrlbit	= S5PC110_CLKGATE_IP2_HSMMC1,
> +	}, {
> +		.name		= "hsmmc",
> +		.id		= 2,
> +		.parent		= &clk_dout_hclkp,
> +		.enable		= s5pc110_ip2_ctrl,
> +		.ctrlbit	= S5PC110_CLKGATE_IP2_HSMMC2,
> +	}, {
> +		.name		= "hsmmc",
> +		.id		= 3,
> +		.parent		= &clk_dout_hclkp,
> +		.enable		= s5pc110_ip2_ctrl,
> +		.ctrlbit	= S5PC110_CLKGATE_IP2_HSMMC3,
> +	},
> +	/* IP3 */
> +	{
> +		.name           = "iis",
> +		.id             = 0,
> +		.parent		= &clk_dout_pclkp,
> +		.enable		= s5pc110_ip3_ctrl,
> +		.ctrlbit	= S5PC110_CLKGATE_IP3_I2S0,
> +	}, {
> +		.name           = "iis",
> +		.id             = 1,
> +		.parent		= &clk_dout_pclkp,
> +		.enable		= s5pc110_ip3_ctrl,
> +		.ctrlbit	= S5PC110_CLKGATE_IP3_I2S1,
> +	}, {
> +		.name           = "iis",
> +		.id             = 2,
> +		.parent		= &clk_dout_pclkp,
> +		.enable		= s5pc110_ip3_ctrl,
> +		.ctrlbit	= S5PC110_CLKGATE_IP3_I2S2,
> +	}, {
> +		.name		= "i2c",
> +		.id		= 0,
> +		.parent		= &clk_dout_pclkp,
> +		.enable		= s5pc110_ip3_ctrl,
> +		.ctrlbit	= S5PC110_CLKGATE_IP3_I2C0,
> +	}, {
> +		.name		= "i2c",
> +		.id		= 1,
> +		.parent		= &clk_dout_pclkd,
> +		.enable		= s5pc110_ip3_ctrl,
> +		.ctrlbit	= S5PC110_CLKGATE_IP3_I2C1,
> +	}, {
> +		.name		= "i2c",
> +		.id		= 2,
> +		.parent		= &clk_dout_pclkp,
> +		.enable		= s5pc110_ip3_ctrl,
> +		.ctrlbit	= S5PC110_CLKGATE_IP3_I2C2,
> +	}, {
> +		.name		= "timers",
> +		.id		= -1,
> +		.parent		= &clk_dout_pclkp,
> +		.enable		= s5pc110_ip3_ctrl,
> +		.ctrlbit	= S5PC110_CLKGATE_IP3_PWM,
> +	}, {
> +		.name		= "adc",
> +		.id		= -1,
> +		.parent		= &clk_dout_pclkp,
> +		.enable		= s5pc110_ip3_ctrl,
> +		.ctrlbit	= S5PC110_CLKGATE_IP3_TSADC,
> +	},
> +};
> +
> +static struct clk *clks[] __initdata = {
> +	&clk_ext,
> +	&clk_epll,
> +	&clk_27m,
> +	&clk_30m,
> +	&clk_48m,
> +	&clk_54m,
> +};
> +
> +void __init s5pc1xx_register_clocks(void)
> +{
> +	struct clk *clkp;
> +	int ret;
> +	int ptr;
> +	int size;
> +
> +	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
> +
> +	clkp = s5pc110_init_clocks;
> +	size = ARRAY_SIZE(s5pc110_init_clocks);
> +
> +	for (ptr = 0; ptr < size; ptr++, clkp++) {
> +		ret = s3c24xx_register_clock(clkp);
> +		if (ret < 0) {
> +			printk(KERN_ERR "Failed to register clock %s (%d)\n",
> +			       clkp->name, ret);
> +		}
> +	}
> +
> +	clkp = s5pc110_init_clocks_disable;
> +	size = ARRAY_SIZE(s5pc110_init_clocks_disable);
> +
> +	for (ptr = 0; ptr < size; ptr++, clkp++) {
> +		ret = s3c24xx_register_clock(clkp);
> +		if (ret < 0) {
> +			printk(KERN_ERR "Failed to register clock %s (%d)\n",
> +			       clkp->name, ret);
> +		}
> +
> +		(clkp->enable)(clkp, 0);
> +	}
> +
> +	s3c_pwmclk_init();
> +}
> diff --git a/arch/arm/plat-s5pc1xx/s5pc110-plls.c b/arch/arm/plat-s5pc1xx/s5pc110-plls.c
> new file mode 100644
> index 0000000..05ac43c
> --- /dev/null
> +++ b/arch/arm/plat-s5pc1xx/s5pc110-plls.c
> @@ -0,0 +1,1288 @@
> +/*
> + * linux/arch/arm/plat-s5pc1xx/s5pc110-plls.c
> + *
> + * Copyright 2009 Samsung Electronics, Co.
> + * Minkyu Kang <mk7.kang@samsung.com>
> + *
> + * S5PC110 based common clock support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/sysdev.h>
> +#include <linux/io.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/map.h>
> +
> +#include <plat/cpu-freq.h>
> +
> +#include <plat/regs-clock.h>
> +#include <plat/clock.h>
> +#include <plat/cpu.h>
> +#include <plat/pll.h>
> +#include <plat/devs.h>
> +#include <plat/s5pc1xx.h>
> +
> +static struct clk clk_ext_xtal_mux = {
> +	.name		= "ext_xtal",
> +	.id		= -1,
> +};
> +
> +#define clk_fin_apll	clk_ext_xtal_mux
> +#define clk_fin_mpll	clk_ext_xtal_mux
> +#define clk_fin_epll	clk_ext_xtal_mux
> +#define clk_fin_vpll	clk_ext_xtal_mux
> +#define clk_hdmi_phy	clk_ext_xtal_mux
> +
> +#define clk_fout_mpll	clk_mpll
> +#define clk_hdmi_27m	clk_27m
> +#define clk_usbphy0	clk_30m
> +#define clk_usbphy1	clk_48m
> +
> +static struct clk clk_usb_xtal = {
> +	.name		= "usb_xtal",
> +	.id		= -1,
> +};
> +
> +static struct clk clk_pcm_cd0 = {
> +	.name		= "pcm_cdclk0",
> +	.id		= -1,
> +};
> +
> +static struct clk clk_pcm_cd1 = {
> +	.name		= "pcm_cdclk1",
> +	.id		= -1,
> +};
> +
> +static struct clk clk_iis_cd1 = {
> +	.name		= "iis_cdclk1",
> +	.id		= -1,
> +};
> +
> +struct clk_sources {
> +	unsigned int	nr_sources;
> +	struct clk	**sources;
> +};
> +
> +struct clksrc_clk {
> +	struct clk		clk;
> +	unsigned int		mask;
> +	unsigned int		shift;
> +
> +	struct clk_sources	*sources;
> +
> +	unsigned int		divider_shift;
> +	void __iomem		*reg_divider;
> +	void __iomem		*reg_source;
> +};
> +
> +/* APLL */
> +static struct clk clk_fout_apll = {
> +	.name		= "fout_apll",
> +	.id		= -1,
> +};
> +
> +static struct clk *clk_src_apll_list[] = {
> +	[0] = &clk_fin_apll,
> +	[1] = &clk_fout_apll,
> +};
> +
> +static struct clk_sources clk_src_apll = {
> +	.sources	= clk_src_apll_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_apll_list),
> +};
> +
> +static struct clksrc_clk clk_mout_apll = {
> +	.clk	= {
> +		.name		= "mout_apll",
> +		.id		= -1,
> +	},
> +	.shift		= S5PC110_CLKSRC0_APLL_SHIFT,
> +	.mask		= S5PC110_CLKSRC0_APLL_MASK,
> +	.sources	= &clk_src_apll,
> +	.reg_source	= S5PC110_CLKSRC0,
> +};
> +
> +/* MPLL */
> +static struct clk *clk_src_mpll_list[] = {
> +	[0] = &clk_fin_mpll,
> +	[1] = &clk_fout_mpll,
> +};
> +
> +static struct clk_sources clk_src_mpll = {
> +	.sources	= clk_src_mpll_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_mpll_list),
> +};
> +
> +static struct clksrc_clk clk_mout_mpll = {
> +	.clk = {
> +		.name		= "mout_mpll",
> +		.id		= -1,
> +	},
> +	.shift		= S5PC110_CLKSRC0_MPLL_SHIFT,
> +	.mask		= S5PC110_CLKSRC0_MPLL_MASK,
> +	.sources	= &clk_src_mpll,
> +	.reg_source	= S5PC110_CLKSRC0,
> +};
> +
> +static int s5pc110_default_enable(struct clk *clk, int enable)
> +{
> +	return 0;
> +}
> +
> +/* EPLL */
> +static struct clk clk_fout_epll = {
> +	.name		= "fout_epll",
> +	.id		= -1,
> +	.enable		= s5pc110_default_enable,
> +};
> +
> +static struct clk *clk_src_epll_list[] = {
> +	[0] = &clk_fin_epll,
> +	[1] = &clk_fout_epll,
> +};
> +
> +static struct clk_sources clk_src_epll = {
> +	.sources	= clk_src_epll_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_epll_list),
> +};
> +
> +static struct clksrc_clk clk_mout_epll = {
> +	.clk = {
> +		.name		= "mout_epll",
> +		.id		= -1,
> +	},
> +	.shift		= S5PC110_CLKSRC0_EPLL_SHIFT,
> +	.mask		= S5PC110_CLKSRC0_EPLL_MASK,
> +	.sources	= &clk_src_epll,
> +	.reg_source	= S5PC110_CLKSRC0,
> +};
> +
> +/* VPLLSRC */
> +static struct clk *clk_src_vpllsrc_list[] = {
> +	[0] = &clk_fin_vpll,
> +	[1] = &clk_hdmi_27m,
> +};
> +
> +static struct clk_sources clk_src_vpllsrc = {
> +	.sources	= clk_src_vpllsrc_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_vpllsrc_list),
> +};
> +
> +static struct clksrc_clk clk_mout_vpllsrc = {
> +	.clk = {
> +		.name		= "mout_vpllsrc",
> +		.id		= -1,
> +	},
> +	.shift		= S5PC110_CLKSRC1_VPLLSRC_SHIFT,
> +	.mask		= S5PC110_CLKSRC1_VPLLSRC_MASK,
> +	.sources	= &clk_src_vpllsrc,
> +	.reg_source	= S5PC110_CLKSRC1,
> +};
> +
> +/* VPLL */
> +static struct clk clk_fout_vpll = {
> +	.name		= "fout_vpll",
> +	.id		= -1,
> +};
> +
> +static struct clk *clk_src_vpll_list[] = {
> +	[0] = &clk_mout_vpllsrc.clk,
> +	[1] = &clk_fout_vpll,
> +};
> +
> +static struct clk_sources clk_src_vpll = {
> +	.sources	= clk_src_vpll_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_vpll_list),
> +};
> +
> +static struct clksrc_clk clk_mout_vpll = {
> +	.clk = {
> +		.name		= "mout_vpll",
> +		.id		= -1,
> +	},
> +	.shift		= S5PC110_CLKSRC0_VPLL_SHIFT,
> +	.mask		= S5PC110_CLKSRC0_VPLL_MASK,
> +	.sources	= &clk_src_vpll,
> +	.reg_source	= S5PC110_CLKSRC0,
> +};
> +
> +/* Dout A2M */
> +static unsigned long s5pc110_clk_dout_a2m_get_rate(struct clk *clk)
> +{
> +	unsigned long rate = clk_get_rate(clk->parent);
> +	unsigned int ratio;
> +
> +	ratio = __raw_readl(S5PC110_CLKDIV0) & S5PC110_CLKDIV0_A2M_MASK;
> +	ratio >>= S5PC110_CLKDIV0_A2M_SHIFT;
> +
> +	return rate / (ratio + 1);
> +}
> +
> +static struct clk clk_dout_a2m = {
> +	.name		= "dout_a2m",
> +	.id		= -1,
> +	.parent		= &clk_mout_apll.clk,
> +	.get_rate	= s5pc110_clk_dout_a2m_get_rate,
> +};
> +
> +/* HPM */
> +static struct clk *clk_src_hpm_list[] = {
> +	[0] = &clk_mout_apll.clk,
> +	[1] = &clk_mout_mpll.clk,
> +};
> +
> +static struct clk_sources clk_src_hpm = {
> +	.sources	= clk_src_hpm_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_hpm_list),
> +};
> +
> +static struct clksrc_clk clk_mout_hpm = {
> +	.clk = {
> +		.name		= "mout_hpm",
> +		.id		= -1,
> +	},
> +	.shift		= S5PC110_CLKSRC6_HPM_SHIFT,
> +	.mask		= S5PC110_CLKSRC6_HPM_MASK,
> +	.sources	= &clk_src_hpm,
> +	.reg_source	= S5PC110_CLKSRC6,
> +};
> +
> +/* MSYS */
> +static struct clk *clk_src_msys_list[] = {
> +	[0] = &clk_mout_apll.clk,
> +	[1] = &clk_mout_mpll.clk,
> +};
> +
> +static struct clk_sources clk_src_msys = {
> +	.sources	= clk_src_msys_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_msys_list),
> +};
> +
> +static struct clksrc_clk clk_mout_msys = {
> +	.clk = {
> +		.name		= "mout_msys",
> +		.id		= -1,
> +	},
> +	.shift		= S5PC110_CLKSRC0_MUX200_SHIFT,
> +	.mask		= S5PC110_CLKSRC0_MUX200_MASK,
> +	.sources	= &clk_src_msys,
> +	.reg_source	= S5PC110_CLKSRC0,
> +};
> +
> +/* DSYS */
> +static struct clk *clk_src_dsys_list[] = {
> +	[0] = &clk_mout_mpll.clk,
> +	[1] = &clk_dout_a2m,
> +};
> +
> +static struct clk_sources clk_src_dsys = {
> +	.sources	= clk_src_dsys_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_dsys_list),
> +};
> +
> +struct clksrc_clk clk_mout_dsys = {
> +	.clk = {
> +		.name		= "mout_dsys",
> +		.id		= -1,
> +	},
> +	.shift		= S5PC110_CLKSRC0_MUX166_SHIFT,
> +	.mask		= S5PC110_CLKSRC0_MUX166_MASK,
> +	.sources	= &clk_src_dsys,
> +	.reg_source	= S5PC110_CLKSRC0,
> +};
> +
> +/* PSYS */
> +static struct clk *clk_src_psys_list[] = {
> +	[0] = &clk_mout_mpll.clk,
> +	[1] = &clk_dout_a2m,
> +};
> +
> +static struct clk_sources clk_src_psys = {
> +	.sources	= clk_src_psys_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_psys_list),
> +};
> +
> +static struct clksrc_clk clk_mout_psys = {
> +	.clk = {
> +		.name		= "mout_psys",
> +		.id		= -1,
> +	},
> +	.shift		= S5PC110_CLKSRC0_MUX133_SHIFT,
> +	.mask		= S5PC110_CLKSRC0_MUX133_MASK,
> +	.sources	= &clk_src_psys,
> +	.reg_source	= S5PC110_CLKSRC0,
> +};
> +
> +/* Dout COPY */
> +static unsigned long s5pc110_clk_dout_copy_get_rate(struct clk *clk)
> +{
> +	unsigned long rate = clk_get_rate(clk->parent);
> +	unsigned int ratio;
> +
> +	ratio = __raw_readl(S5PC110_CLKDIV6) & S5PC110_CLKDIV6_COPY_MASK;
> +	ratio >>= S5PC110_CLKDIV6_COPY_SHIFT;
> +
> +	return rate / (ratio + 1);
> +}
> +
> +static struct clk clk_dout_copy = {
> +	.name		= "dout_copy",
> +	.id		= -1,
> +	.parent		= &clk_mout_hpm.clk,
> +	.get_rate	= s5pc110_clk_dout_copy_get_rate,
> +};
> +
> +/* Dout HPM */
> +static unsigned long s5pc110_clk_dout_hpm_get_rate(struct clk *clk)
> +{
> +	unsigned long rate = clk_get_rate(clk->parent);
> +	unsigned int ratio;
> +
> +	ratio = __raw_readl(S5PC110_CLKDIV6) & S5PC110_CLKDIV6_HPM_MASK;
> +	ratio >>= S5PC110_CLKDIV6_HPM_SHIFT;
> +
> +	return rate / (ratio + 1);
> +}
> +
> +static struct clk clk_dout_hpm = {
> +	.name		= "dout_hpm",
> +	.id		= -1,
> +	.parent		= &clk_dout_copy,
> +	.get_rate	= s5pc110_clk_dout_hpm_get_rate,
> +};
> +
> +/* Dout APLL - ARMCLK */
> +static unsigned long s5pc110_clk_dout_apll_get_rate(struct clk *clk)
> +{
> +	unsigned long rate = clk_get_rate(clk->parent);
> +	unsigned int ratio;
> +
> +	ratio = __raw_readl(S5PC110_CLKDIV0) & S5PC110_CLKDIV0_APLL_MASK;
> +	ratio >>= S5PC110_CLKDIV0_APLL_SHIFT;
> +
> +	return rate / (ratio + 1);
> +}
> +
> +static struct clk clk_dout_apll = {
> +	.name		= "dout_apll",
> +	.id		= -1,
> +	.parent		= &clk_mout_msys.clk,
> +	.get_rate	= s5pc110_clk_dout_apll_get_rate,
> +};
> +
> +/* Dout HCLKM - ACLK200, HCLK_MSYS */
> +static unsigned long s5pc110_clk_dout_hclkm_get_rate(struct clk *clk)
> +{
> +	unsigned long rate = clk_get_rate(clk->parent);
> +	unsigned int ratio;
> +
> +	ratio = __raw_readl(S5PC110_CLKDIV0) & S5PC110_CLKDIV0_HCLK_MSYS_MASK;
> +	ratio >>= S5PC110_CLKDIV0_HCLK_MSYS_SHIFT;
> +
> +	return rate / (ratio + 1);
> +}
> +
> +struct clk clk_dout_hclkm = {
> +	.name		= "dout_hclkm",
> +	.id		= -1,
> +	.parent		= &clk_dout_apll,
> +	.get_rate	= s5pc110_clk_dout_hclkm_get_rate,
> +};
> +
> +/* Dout PCLKM - PCLK_MSYS */
> +static unsigned long s5pc110_clk_dout_pclkm_get_rate(struct clk *clk)
> +{
> +	unsigned long rate = clk_get_rate(clk->parent);
> +	unsigned int ratio;
> +
> +	ratio = __raw_readl(S5PC110_CLKDIV0) & S5PC110_CLKDIV0_PCLK_MSYS_MASK;
> +	ratio >>= S5PC110_CLKDIV0_HCLK_PSYS_SHIFT;
> +
> +	return rate / (ratio + 1);
> +}
> +
> +struct clk clk_dout_pclkm = {
> +	.name		= "dout_pclkm",
> +	.id		= -1,
> +	.parent		= &clk_dout_hclkm,
> +	.get_rate	= s5pc110_clk_dout_pclkm_get_rate,
> +};
> +
> +/* Dout IMEM - HCLK100 */
> +static unsigned long s5pc110_clk_dout_imem_get_rate(struct clk *clk)
> +{
> +	unsigned long rate = clk_get_rate(clk->parent);
> +	return rate / 2;
> +}
> +
> +static struct clk clk_dout_imem = {
> +	.name		= "dout_imem",
> +	.id		= -1,
> +	.parent		= &clk_dout_hclkm,
> +	.get_rate	= s5pc110_clk_dout_imem_get_rate,
> +};
> +
> +/* Dout HCLKD - HCLK_DSYS */
> +static unsigned long s5pc110_clk_dout_hclkd_get_rate(struct clk *clk)
> +{
> +	unsigned long rate;
> +	unsigned int ratio;
> +
> +	rate = clk_get_rate(clk->parent);
> +	ratio = __raw_readl(S5PC110_CLKDIV0) & S5PC110_CLKDIV0_HCLK_DSYS_MASK;
> +	ratio >>= S5PC110_CLKDIV0_HCLK_DSYS_SHIFT;
> +
> +	return rate / (ratio + 1);
> +}
> +
> +struct clk clk_dout_hclkd = {
> +	.name		= "dout_hclkd",
> +	.id		= -1,
> +	.parent		= &clk_mout_dsys.clk,
> +	.get_rate	= s5pc110_clk_dout_hclkd_get_rate,
> +};
> +
> +/* Dout PCLKD - PCLK_DSYS */
> +static unsigned long s5pc110_clk_dout_pclkd_get_rate(struct clk *clk)
> +{
> +	unsigned long rate = clk_get_rate(clk->parent);
> +	unsigned int ratio;
> +
> +	ratio = __raw_readl(S5PC110_CLKDIV0) & S5PC110_CLKDIV0_PCLK_DSYS_MASK;
> +	ratio >>= S5PC110_CLKDIV0_PCLK_DSYS_SHIFT;
> +
> +	return rate / (ratio + 1);
> +}
> +
> +struct clk clk_dout_pclkd = {
> +	.name		= "dout_pclkd",
> +	.id		= -1,
> +	.parent		= &clk_dout_hclkd,
> +	.get_rate	= s5pc110_clk_dout_pclkd_get_rate,
> +};
> +
> +/* Dout FIMC - SCLK_FIMC */
> +static unsigned long s5pc110_clk_dout_fimc_get_rate(struct clk *clk)
> +{
> +	unsigned long rate = clk_get_rate(clk->parent);
> +	unsigned int ratio;
> +
> +	ratio = __raw_readl(S5PC110_CLKDIV1) & S5PC110_CLKDIV1_FIMC_MASK;
> +	ratio >>= S5PC110_CLKDIV1_FIMC_SHIFT;
> +
> +	return rate / (ratio + 1);
> +}
> +
> +static struct clk clk_dout_fimc = {
> +	.name		= "dout_fimc",
> +	.id		= -1,
> +	.parent		= &clk_mout_dsys.clk,
> +	.get_rate	= s5pc110_clk_dout_fimc_get_rate,
> +};
> +
> +/* Dout HCLKP - ARMATCLK, HCLK_PSYS */
> +static unsigned long s5pc110_clk_dout_hclkp_get_rate(struct clk *clk)
> +{
> +	unsigned long rate = clk_get_rate(clk->parent);
> +	unsigned int ratio;
> +
> +	ratio = __raw_readl(S5PC110_CLKDIV0) & S5PC110_CLKDIV0_HCLK_PSYS_MASK;
> +	ratio >>= S5PC110_CLKDIV0_HCLK_PSYS_SHIFT;
> +
> +	return rate / (ratio + 1);
> +}
> +
> +struct clk clk_dout_hclkp = {
> +	.name		= "dout_hclkp",
> +	.id		= -1,
> +	.parent		= &clk_mout_psys.clk,
> +	.get_rate	= s5pc110_clk_dout_hclkp_get_rate,
> +};
> +
> +/* Dout PCLKD - PCLK_DSYS */
> +static unsigned long s5pc110_clk_dout_pclkp_get_rate(struct clk *clk)
> +{
> +	unsigned long rate = clk_get_rate(clk->parent);
> +	unsigned int ratio;
> +
> +	ratio = __raw_readl(S5PC110_CLKDIV0) & S5PC110_CLKDIV0_PCLK_PSYS_MASK;
> +	ratio >>= S5PC110_CLKDIV0_PCLK_PSYS_SHIFT;
> +
> +	return rate / (ratio + 1);
> +}
> +
> +struct clk clk_dout_pclkp = {
> +	.name		= "dout_pclkp",
> +	.id		= -1,
> +	.parent		= &clk_dout_hclkp,
> +	.get_rate	= s5pc110_clk_dout_pclkp_get_rate,
> +};
> +
> +/* FLASH */
> +static struct clk *clk_src_onenand_list[] = {
> +	[0] = &clk_dout_hclkd,
> +	[1] = &clk_dout_hclkp,
> +};
> +
> +static struct clk_sources clk_src_onenand = {
> +	.sources	= clk_src_onenand_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_onenand_list),
> +};
> +
> +static struct clksrc_clk clk_mout_onenand = {
> +	.clk = {
> +		.name		= "mout_onenand",
> +		.id		= -1,
> +	},
> +	.shift		= S5PC110_CLKSRC0_ONENAND_SHIFT,
> +	.mask		= S5PC110_CLKSRC0_ONENAND_MASK,
> +	.sources	= &clk_src_onenand,
> +	.reg_source	= S5PC110_CLKSRC0,
> +};
> +
> +/* Dout FLASH - SCLK_ONENAND */
> +static unsigned long s5pc110_clk_dout_onenand_get_rate(struct clk *clk)
> +{
> +	unsigned long rate = clk_get_rate(clk->parent);
> +	unsigned int ratio;
> +
> +	ratio = __raw_readl(S5PC110_CLKDIV6) & S5PC110_CLKDIV6_ONENAND_MASK;
> +	ratio >>= S5PC110_CLKDIV6_ONENAND_SHIFT;
> +
> +	return rate / (ratio + 1);
> +}
> +
> +static struct clk clk_dout_onenand = {
> +	.name		= "dout_onenand",
> +	.id		= -1,
> +	.parent		= &clk_mout_onenand.clk,
> +	.get_rate	= s5pc110_clk_dout_onenand_get_rate,
> +};
> +
> +/* Dout FLASH2 - SCLK_ONENAND2 */
> +static unsigned long s5pc110_clk_dout_onenand2_get_rate(struct clk *clk)
> +{
> +	unsigned long rate = clk_get_rate(clk->parent);
> +	return rate / 2;
> +}
> +
> +static struct clk clk_dout_onenand2 = {
> +	.name		= "dout_onenand2",
> +	.id		= -1,
> +	.parent		= &clk_dout_onenand,
> +	.get_rate	= s5pc110_clk_dout_onenand2_get_rate,
> +};
> +
> +/* Peripherals */
> +static inline struct clksrc_clk *to_clksrc(struct clk *clk)
> +{
> +	return container_of(clk, struct clksrc_clk, clk);
> +}
> +
> +static unsigned long s5pc110_getrate_clksrc(struct clk *clk)
> +{
> +	struct clksrc_clk *sclk = to_clksrc(clk);
> +	unsigned long rate = clk_get_rate(clk->parent);
> +	u32 clkdiv = __raw_readl(sclk->reg_divider);
> +
> +	clkdiv >>= sclk->divider_shift;
> +	clkdiv &= 0xf;
> +	clkdiv++;
> +
> +	rate /= clkdiv;
> +	return rate;
> +}
> +
> +static int s5pc110_setrate_clksrc(struct clk *clk, unsigned long rate)
> +{
> +	struct clksrc_clk *sclk = to_clksrc(clk);
> +	void __iomem *reg = sclk->reg_divider;
> +	unsigned int div;
> +	u32 val;
> +
> +	rate = clk_round_rate(clk, rate);
> +	div = clk_get_rate(clk->parent) / rate;
> +	if (div > 16)
> +		return -EINVAL;
> +
> +	val = __raw_readl(reg);
> +	val &= ~(0xf << sclk->divider_shift);
> +	val |= (div - 1) << sclk->divider_shift;
> +	__raw_writel(val, reg);
> +
> +	return 0;
> +}
> +
> +static int s5pc110_setparent_clksrc(struct clk *clk, struct clk *parent)
> +{
> +	struct clksrc_clk *sclk = to_clksrc(clk);
> +	struct clk_sources *srcs = sclk->sources;
> +	u32 clksrc = __raw_readl(sclk->reg_source);
> +	int src_nr = -1;
> +	int ptr;
> +
> +	for (ptr = 0; ptr < srcs->nr_sources; ptr++) {
> +		if (srcs->sources[ptr] == parent) {
> +			src_nr = ptr;
> +			break;
> +		}
> +	}
> +
> +	if (src_nr >= 0) {
> +		clksrc &= ~sclk->mask;
> +		clksrc |= src_nr << sclk->shift;
> +
> +		__raw_writel(clksrc, sclk->reg_source);
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static unsigned long s5pc110_roundrate_clksrc(struct clk *clk,
> +					      unsigned long rate)
> +{
> +	unsigned long parent_rate = clk_get_rate(clk->parent);
> +	int div;
> +
> +	if (rate > parent_rate)
> +		rate = parent_rate;
> +	else {
> +		div = parent_rate / rate;
> +
> +		if (div == 0)
> +			div = 1;
> +		if (div > 16)
> +			div = 16;
> +
> +		rate = parent_rate / div;
> +	}
> +
> +	return rate;
> +}
> +
> +static struct clk *clkset_default_list[] = {
> +	&clk_fin_apll,
> +	&clk_usb_xtal,
> +	&clk_hdmi_27m,
> +	&clk_usbphy0,
> +	&clk_usbphy1,
> +	&clk_hdmi_phy,
> +	&clk_mout_mpll.clk,
> +	&clk_mout_epll.clk,
> +	&clk_mout_vpll.clk,
> +};
> +
> +
> +/* CAM */
> +static struct clk_sources clkset_cam = {
> +	.sources	= clkset_default_list,
> +	.nr_sources	= ARRAY_SIZE(clkset_default_list),
> +};
> +
> +static struct clksrc_clk clk_cam0 = {
> +	.clk	= {
> +		.name		= "cam",
> +		.id		= 0,
> +		.set_parent	= s5pc110_setparent_clksrc,
> +		.get_rate	= s5pc110_getrate_clksrc,
> +		.set_rate	= s5pc110_setrate_clksrc,
> +		.round_rate	= s5pc110_roundrate_clksrc,
> +	},
> +	.shift		= S5PC110_CLKSRC1_CAM0_SHIFT,
> +	.mask		= S5PC110_CLKSRC1_CAM0_MASK,
> +	.sources	= &clkset_cam,
> +	.divider_shift	= S5PC110_CLKDIV1_CAM0_SHIFT,
> +	.reg_divider	= S5PC110_CLKDIV1,
> +	.reg_source	= S5PC110_CLKSRC1,
> +};
> +
> +static struct clksrc_clk clk_cam1 = {
> +	.clk	= {
> +		.name		= "cam",
> +		.id		= 1,
> +		.set_parent	= s5pc110_setparent_clksrc,
> +		.get_rate	= s5pc110_getrate_clksrc,
> +		.set_rate	= s5pc110_setrate_clksrc,
> +		.round_rate	= s5pc110_roundrate_clksrc,
> +	},
> +	.shift		= S5PC110_CLKSRC1_CAM1_SHIFT,
> +	.mask		= S5PC110_CLKSRC1_CAM1_MASK,
> +	.sources	= &clkset_cam,
> +	.divider_shift	= S5PC110_CLKDIV1_CAM1_SHIFT,
> +	.reg_divider	= S5PC110_CLKDIV1,
> +	.reg_source	= S5PC110_CLKSRC1,
> +};
> +
> +/* FIMD */
> +static struct clk_sources clkset_fimd = {
> +	.sources	= clkset_default_list,
> +	.nr_sources	= ARRAY_SIZE(clkset_default_list),
> +};
> +
> +static struct clksrc_clk clk_fimd = {
> +	.clk	= {
> +		.name		= "fimd",
> +		.id		= -1,
> +		.ctrlbit	= S5PC110_CLKGATE_IP1_FIMD,
> +		.enable		= s5pc110_ip1_ctrl,
> +		.set_parent	= s5pc110_setparent_clksrc,
> +		.get_rate	= s5pc110_getrate_clksrc,
> +		.set_rate	= s5pc110_setrate_clksrc,
> +		.round_rate	= s5pc110_roundrate_clksrc,
> +	},
> +	.shift		= S5PC110_CLKSRC1_FIMD_SHIFT,
> +	.mask		= S5PC110_CLKSRC1_FIMD_MASK,
> +	.sources	= &clkset_fimd,
> +	.divider_shift	= S5PC110_CLKDIV1_FIMD_SHIFT,
> +	.reg_divider	= S5PC110_CLKDIV1,
> +	.reg_source	= S5PC110_CLKSRC1,
> +};
> +
> +/* MMC */
> +static struct clk_sources clkset_mmc = {
> +	.sources	= clkset_default_list,
> +	.nr_sources	= ARRAY_SIZE(clkset_default_list),
> +};
> +
> +static struct clksrc_clk clk_mmc0 = {
> +	.clk	= {
> +		.name		= "mmc-bus",
> +		.id		= 0,
> +		.ctrlbit	= S5PC110_CLKGATE_IP2_HSMMC0,
> +		.enable		= s5pc110_ip2_ctrl,
> +		.set_parent	= s5pc110_setparent_clksrc,
> +		.get_rate	= s5pc110_getrate_clksrc,
> +		.set_rate	= s5pc110_setrate_clksrc,
> +		.round_rate	= s5pc110_roundrate_clksrc,
> +	},
> +	.shift		= S5PC110_CLKSRC4_MMC0_SHIFT,
> +	.mask		= S5PC110_CLKSRC4_MMC0_MASK,
> +	.sources	= &clkset_mmc,
> +	.divider_shift	= S5PC110_CLKDIV4_MMC0_SHIFT,
> +	.reg_divider	= S5PC110_CLKDIV4,
> +	.reg_source	= S5PC110_CLKSRC4,
> +};
> +
> +static struct clksrc_clk clk_mmc1 = {
> +	.clk	= {
> +		.name		= "mmc-bus",
> +		.id		= 1,
> +		.ctrlbit	= S5PC110_CLKGATE_IP2_HSMMC1,
> +		.enable		= s5pc110_ip2_ctrl,
> +		.set_parent	= s5pc110_setparent_clksrc,
> +		.get_rate	= s5pc110_getrate_clksrc,
> +		.set_rate	= s5pc110_setrate_clksrc,
> +		.round_rate	= s5pc110_roundrate_clksrc,
> +	},
> +	.shift		= S5PC110_CLKSRC4_MMC1_SHIFT,
> +	.mask		= S5PC110_CLKSRC4_MMC1_MASK,
> +	.sources	= &clkset_mmc,
> +	.divider_shift	= S5PC110_CLKDIV4_MMC1_SHIFT,
> +	.reg_divider	= S5PC110_CLKDIV4,
> +	.reg_source	= S5PC110_CLKSRC4,
> +};
> +
> +static struct clksrc_clk clk_mmc2 = {
> +	.clk	= {
> +		.name		= "mmc-bus",
> +		.id		= 2,
> +		.ctrlbit	= S5PC110_CLKGATE_IP2_HSMMC2,
> +		.enable		= s5pc110_ip2_ctrl,
> +		.set_parent	= s5pc110_setparent_clksrc,
> +		.get_rate	= s5pc110_getrate_clksrc,
> +		.set_rate	= s5pc110_setrate_clksrc,
> +		.round_rate	= s5pc110_roundrate_clksrc,
> +	},
> +	.shift		= S5PC110_CLKSRC4_MMC2_SHIFT,
> +	.mask		= S5PC110_CLKSRC4_MMC2_MASK,
> +	.sources	= &clkset_mmc,
> +	.divider_shift	= S5PC110_CLKDIV4_MMC2_SHIFT,
> +	.reg_divider	= S5PC110_CLKDIV4,
> +	.reg_source	= S5PC110_CLKSRC4,
> +};
> +
> +static struct clksrc_clk clk_mmc3 = {
> +	.clk	= {
> +		.name		= "mmc-bus",
> +		.id		= 3,
> +		.ctrlbit	= S5PC110_CLKGATE_IP2_HSMMC3,
> +		.enable		= s5pc110_ip2_ctrl,
> +		.set_parent	= s5pc110_setparent_clksrc,
> +		.get_rate	= s5pc110_getrate_clksrc,
> +		.set_rate	= s5pc110_setrate_clksrc,
> +		.round_rate	= s5pc110_roundrate_clksrc,
> +	},
> +	.shift		= S5PC110_CLKSRC4_MMC3_SHIFT,
> +	.mask		= S5PC110_CLKSRC4_MMC3_MASK,
> +	.sources	= &clkset_mmc,
> +	.divider_shift	= S5PC110_CLKDIV4_MMC3_SHIFT,
> +	.reg_divider	= S5PC110_CLKDIV4,
> +	.reg_source	= S5PC110_CLKSRC4,
> +};
> +
> +/* AUDIO0 */
> +static struct clk_sources clkset_audio0 = {
> +	.sources	= clkset_default_list,
> +	.nr_sources	= ARRAY_SIZE(clkset_default_list),
> +};
> +
> +static struct clksrc_clk clk_audio0 = {
> +	.clk	= {
> +		.name		= "audio-bus",
> +		.id		= 0,
> +		.set_parent	= s5pc110_setparent_clksrc,
> +		.get_rate	= s5pc110_getrate_clksrc,
> +		.set_rate	= s5pc110_setrate_clksrc,
> +		.round_rate	= s5pc110_roundrate_clksrc,
> +	},
> +	.shift		= S5PC110_CLKSRC6_AUDIO0_SHIFT,
> +	.mask		= S5PC110_CLKSRC6_AUDIO0_MASK,
> +	.sources	= &clkset_audio0,
> +	.divider_shift	= S5PC110_CLKDIV6_AUDIO0_SHIFT,
> +	.reg_divider	= S5PC110_CLKDIV6,
> +	.reg_source	= S5PC110_CLKSRC6,
> +};
> +
> +/* AUDIO1 */
> +static struct clk *clkset_audio1_list[] = {
> +	&clk_iis_cd1,
> +	&clk_pcm_cd1,
> +	&clk_hdmi_27m,
> +	&clk_usbphy0,
> +	&clk_usbphy1,
> +	&clk_hdmi_phy,
> +	&clk_mout_mpll.clk,
> +	&clk_mout_epll.clk,
> +	&clk_mout_vpll.clk,
> +};
> +
> +static struct clk_sources clkset_audio1 = {
> +	.sources	= clkset_audio1_list,
> +	.nr_sources	= ARRAY_SIZE(clkset_audio1_list),
> +};
> +
> +static struct clksrc_clk clk_audio1 = {
> +	.clk	= {
> +		.name		= "audio-bus",
> +		.id		= 1,
> +		.set_parent	= s5pc110_setparent_clksrc,
> +		.get_rate	= s5pc110_getrate_clksrc,
> +		.set_rate	= s5pc110_setrate_clksrc,
> +		.round_rate	= s5pc110_roundrate_clksrc,
> +	},
> +	.shift		= S5PC110_CLKSRC6_AUDIO1_SHIFT,
> +	.mask		= S5PC110_CLKSRC6_AUDIO1_MASK,
> +	.sources	= &clkset_audio1,
> +	.divider_shift	= S5PC110_CLKDIV6_AUDIO1_SHIFT,
> +	.reg_divider	= S5PC110_CLKDIV6,
> +	.reg_source	= S5PC110_CLKSRC6,
> +};
> +
> +/* AUDIO2 */
> +static struct clk *clkset_audio2_list[] = {
> +	&clk_fin_apll,
> +	&clk_pcm_cd0,
> +	&clk_hdmi_27m,
> +	&clk_usbphy0,
> +	&clk_usbphy1,
> +	&clk_hdmi_phy,
> +	&clk_mout_mpll.clk,
> +	&clk_mout_epll.clk,
> +	&clk_mout_vpll.clk,
> +};
> +
> +static struct clk_sources clkset_audio2 = {
> +	.sources	= clkset_audio2_list,
> +	.nr_sources	= ARRAY_SIZE(clkset_audio2_list),
> +};
> +
> +static struct clksrc_clk clk_audio2 = {
> +	.clk	= {
> +		.name		= "audio-bus",
> +		.id		= 2,
> +		.set_parent	= s5pc110_setparent_clksrc,
> +		.get_rate	= s5pc110_getrate_clksrc,
> +		.set_rate	= s5pc110_setrate_clksrc,
> +		.round_rate	= s5pc110_roundrate_clksrc,
> +	},
> +	.shift		= S5PC110_CLKSRC6_AUDIO2_SHIFT,
> +	.mask		= S5PC110_CLKSRC6_AUDIO2_MASK,
> +	.sources	= &clkset_audio2,
> +	.divider_shift	= S5PC110_CLKDIV6_AUDIO2_SHIFT,
> +	.reg_divider	= S5PC110_CLKDIV6,
> +	.reg_source	= S5PC110_CLKSRC6,
> +};
> +
> +/* FIMC */
> +static struct clk_sources clkset_fimc = {
> +	.sources	= clkset_default_list,
> +	.nr_sources	= ARRAY_SIZE(clkset_default_list),
> +};
> +
> +static struct clksrc_clk clk_fimc0 = {
> +	.clk	= {
> +		.name		= "fimc",
> +		.id		= 0,
> +		.ctrlbit	= S5PC110_CLKGATE_IP0_FIMC0,
> +		.enable		= s5pc110_ip0_ctrl,
> +		.set_parent	= s5pc110_setparent_clksrc,
> +		.get_rate	= s5pc110_getrate_clksrc,
> +		.set_rate	= s5pc110_setrate_clksrc,
> +		.round_rate	= s5pc110_roundrate_clksrc,
> +	},
> +	.shift		= S5PC110_CLKSRC3_FIMC0_LCLK_SHIFT,
> +	.mask		= S5PC110_CLKSRC3_FIMC0_LCLK_MASK,
> +	.sources	= &clkset_fimc,
> +	.divider_shift	= S5PC110_CLKDIV3_FIMC0_LCLK_SHIFT,
> +	.reg_divider	= S5PC110_CLKDIV3,
> +	.reg_source	= S5PC110_CLKSRC3,
> +};
> +
> +static struct clksrc_clk clk_fimc1 = {
> +	.clk	= {
> +		.name		= "fimc",
> +		.id		= 1,
> +		.ctrlbit	= S5PC110_CLKGATE_IP0_FIMC1,
> +		.enable		= s5pc110_ip0_ctrl,
> +		.set_parent	= s5pc110_setparent_clksrc,
> +		.get_rate	= s5pc110_getrate_clksrc,
> +		.set_rate	= s5pc110_setrate_clksrc,
> +		.round_rate	= s5pc110_roundrate_clksrc,
> +	},
> +	.shift		= S5PC110_CLKSRC3_FIMC1_LCLK_SHIFT,
> +	.mask		= S5PC110_CLKSRC3_FIMC1_LCLK_MASK,
> +	.sources	= &clkset_fimc,
> +	.divider_shift	= S5PC110_CLKDIV3_FIMC1_LCLK_SHIFT,
> +	.reg_divider	= S5PC110_CLKDIV3,
> +	.reg_source	= S5PC110_CLKSRC3,
> +};
> +
> +static struct clksrc_clk clk_fimc2 = {
> +	.clk	= {
> +		.name		= "fimc",
> +		.id		= 2,
> +		.ctrlbit	= S5PC110_CLKGATE_IP0_FIMC2,
> +		.enable		= s5pc110_ip0_ctrl,
> +		.set_parent	= s5pc110_setparent_clksrc,
> +		.get_rate	= s5pc110_getrate_clksrc,
> +		.set_rate	= s5pc110_setrate_clksrc,
> +		.round_rate	= s5pc110_roundrate_clksrc,
> +	},
> +	.shift		= S5PC110_CLKSRC3_FIMC2_LCLK_SHIFT,
> +	.mask		= S5PC110_CLKSRC3_FIMC2_LCLK_MASK,
> +	.sources	= &clkset_fimc,
> +	.divider_shift	= S5PC110_CLKDIV3_FIMC2_LCLK_SHIFT,
> +	.reg_divider	= S5PC110_CLKDIV3,
> +	.reg_source	= S5PC110_CLKSRC3,
> +};
> +
> +/* UART */
> +static struct clk_sources clkset_uart = {
> +	.sources	= clkset_default_list,
> +	.nr_sources	= ARRAY_SIZE(clkset_default_list),
> +};
> +
> +static struct clksrc_clk clk_uart0 = {
> +	.clk	= {
> +		.name		= "uart",
> +		.id		= 0,
> +		.ctrlbit	= S5PC110_CLKGATE_IP3_UART0,
> +		.enable		= s5pc110_ip3_ctrl,
> +		.set_parent	= s5pc110_setparent_clksrc,
> +		.get_rate	= s5pc110_getrate_clksrc,
> +		.set_rate	= s5pc110_setrate_clksrc,
> +		.round_rate	= s5pc110_roundrate_clksrc,
> +	},
> +	.shift		= S5PC110_CLKSRC4_UART0_SHIFT,
> +	.mask		= S5PC110_CLKSRC4_UART0_MASK,
> +	.sources	= &clkset_uart,
> +	.divider_shift	= S5PC110_CLKDIV4_UART0_SHIFT,
> +	.reg_divider	= S5PC110_CLKDIV4,
> +	.reg_source	= S5PC110_CLKSRC4,
> +};
> +
> +static struct clksrc_clk clk_uart1 = {
> +	.clk	= {
> +		.name		= "uart",
> +		.id		= 1,
> +		.ctrlbit	= S5PC110_CLKGATE_IP3_UART1,
> +		.enable		= s5pc110_ip3_ctrl,
> +		.set_parent	= s5pc110_setparent_clksrc,
> +		.get_rate	= s5pc110_getrate_clksrc,
> +		.set_rate	= s5pc110_setrate_clksrc,
> +		.round_rate	= s5pc110_roundrate_clksrc,
> +	},
> +	.shift		= S5PC110_CLKSRC4_UART1_SHIFT,
> +	.mask		= S5PC110_CLKSRC4_UART1_MASK,
> +	.sources	= &clkset_uart,
> +	.divider_shift	= S5PC110_CLKDIV4_UART1_SHIFT,
> +	.reg_divider	= S5PC110_CLKDIV4,
> +	.reg_source	= S5PC110_CLKSRC4,
> +};
> +
> +static struct clksrc_clk clk_uart2 = {
> +	.clk	= {
> +		.name		= "uart",
> +		.id		= 2,
> +		.ctrlbit	= S5PC110_CLKGATE_IP3_UART2,
> +		.enable		= s5pc110_ip3_ctrl,
> +		.set_parent	= s5pc110_setparent_clksrc,
> +		.get_rate	= s5pc110_getrate_clksrc,
> +		.set_rate	= s5pc110_setrate_clksrc,
> +		.round_rate	= s5pc110_roundrate_clksrc,
> +	},
> +	.shift		= S5PC110_CLKSRC4_UART2_SHIFT,
> +	.mask		= S5PC110_CLKSRC4_UART2_MASK,
> +	.sources	= &clkset_uart,
> +	.divider_shift	= S5PC110_CLKDIV4_UART2_SHIFT,
> +	.reg_divider	= S5PC110_CLKDIV4,
> +	.reg_source	= S5PC110_CLKSRC4,
> +};
> +
> +static struct clksrc_clk clk_uart3 = {
> +	.clk	= {
> +		.name		= "uart",
> +		.id		= 3,
> +		.ctrlbit	= S5PC110_CLKGATE_IP3_UART3,
> +		.enable		= s5pc110_ip3_ctrl,
> +		.set_parent	= s5pc110_setparent_clksrc,
> +		.get_rate	= s5pc110_getrate_clksrc,
> +		.set_rate	= s5pc110_setrate_clksrc,
> +		.round_rate	= s5pc110_roundrate_clksrc,
> +	},
> +	.shift		= S5PC110_CLKSRC4_UART3_SHIFT,
> +	.mask		= S5PC110_CLKSRC4_UART3_MASK,
> +	.sources	= &clkset_uart,
> +	.divider_shift	= S5PC110_CLKDIV4_UART3_SHIFT,
> +	.reg_divider	= S5PC110_CLKDIV4,
> +	.reg_source	= S5PC110_CLKSRC4,
> +};
> +
> +/* PWM */
> +static struct clk_sources clkset_pwm = {
> +	.sources	= clkset_default_list,
> +	.nr_sources	= ARRAY_SIZE(clkset_default_list),
> +};
> +
> +static struct clksrc_clk clk_pwm = {
> +	.clk	= {
> +		.name		= "pwm",
> +		.id		= -1,
> +		.ctrlbit	= S5PC110_CLKGATE_IP3_PWM,
> +		.enable		= s5pc110_ip3_ctrl,
> +		.set_parent	= s5pc110_setparent_clksrc,
> +		.get_rate	= s5pc110_getrate_clksrc,
> +		.set_rate	= s5pc110_setrate_clksrc,
> +		.round_rate	= s5pc110_roundrate_clksrc,
> +	},
> +	.shift		= S5PC110_CLKSRC5_PWM_SHIFT,
> +	.mask		= S5PC110_CLKSRC5_PWM_MASK,
> +	.sources	= &clkset_pwm,
> +	.divider_shift	= S5PC110_CLKDIV5_PWM_SHIFT,
> +	.reg_divider	= S5PC110_CLKDIV5,
> +	.reg_source	= S5PC110_CLKSRC5,
> +};
> +
> +/* Clock initialisation code */
> +static struct clksrc_clk *init_parents[] = {
> +	&clk_mout_apll,
> +	&clk_mout_mpll,
> +	&clk_mout_epll,
> +	&clk_mout_vpllsrc,
> +	&clk_mout_vpll,
> +	&clk_mout_hpm,
> +	&clk_mout_msys,
> +	&clk_mout_dsys,
> +	&clk_mout_psys,
> +	&clk_mout_onenand,
> +	&clk_cam0,
> +	&clk_cam1,
> +	&clk_fimd,
> +	&clk_mmc0,
> +	&clk_mmc1,
> +	&clk_mmc2,
> +	&clk_mmc3,
> +	&clk_audio0,
> +	&clk_audio1,
> +	&clk_audio2,
> +	&clk_fimc0,
> +	&clk_fimc1,
> +	&clk_fimc2,
> +	&clk_uart0,
> +	&clk_uart1,
> +	&clk_uart2,
> +	&clk_uart3,
> +	&clk_pwm,
> +};
> +
> +static void __init_or_cpufreq s5pc110_set_clksrc(struct clksrc_clk *clk)
> +{
> +	struct clk_sources *srcs = clk->sources;
> +	u32 clksrc = __raw_readl(clk->reg_source);
> +
> +	clksrc &= clk->mask;
> +	clksrc >>= clk->shift;
> +
> +	if (clksrc > srcs->nr_sources || !srcs->sources[clksrc]) {
> +		printk(KERN_ERR "%s: bad source %d\n",
> +		       clk->clk.name, clksrc);
> +		return;
> +	}
> +
> +	clk->clk.parent = srcs->sources[clksrc];
> +
> +	printk(KERN_INFO "%s: source is %s (%d), rate is %ld.%03ld MHz\n",
> +		clk->clk.name, clk->clk.parent->name, clksrc,
> +		print_mhz(clk_get_rate(&clk->clk)));
> +}
> +
> +#define GET_DIV(clk, field) ((((clk) & field##_MASK) >> field##_SHIFT) + 1)
> +
> +void __init_or_cpufreq s5pc110_setup_clocks(void)
> +{
> +	struct clk *xtal_clk;
> +	unsigned long xtal;
> +	unsigned long armclk;
> +	unsigned long hclk_msys, hclk_dsys, hclk_psys;
> +	unsigned long pclk_msys, pclk_dsys, pclk_psys;
> +	unsigned long apll, mpll, epll, vpll;
> +	unsigned int clkdiv0;
> +	unsigned int ptr;
> +
> +	printk(KERN_DEBUG "%s: registering clocks\n", __func__);
> +
> +	clkdiv0 = __raw_readl(S5PC110_CLKDIV0);
> +
> +	printk(KERN_DEBUG "%s: clkdiv0 = %08x\n", __func__, clkdiv0);
> +
> +	xtal_clk = clk_get(NULL, "xtal");
> +	BUG_ON(IS_ERR(xtal_clk));
> +
> +	xtal = clk_get_rate(xtal_clk);
> +	clk_put(xtal_clk);
> +
> +	printk(KERN_DEBUG "%s: xtal is %ld\n", __func__, xtal);
> +
> +	apll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC110_APLL_CON), 1);
> +	mpll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC110_MPLL_CON), 0);
> +	epll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC110_EPLL_CON), 0);
> +	vpll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC110_VPLL_CON), 0);
> +
> +	printk(KERN_INFO "S5PC110: Apll=%ld.%03ld Mhz, Mpll=%ld.%03ld Mhz"
> +		", Epll=%ld.%03ld Mhz, Vpll=%ld.%03ld Mhz\n",
> +		print_mhz(apll), print_mhz(mpll),
> +		print_mhz(epll), print_mhz(vpll));
> +
> +	armclk = apll / GET_DIV(clkdiv0, S5PC110_CLKDIV0_APLL);
> +	hclk_msys = armclk / GET_DIV(clkdiv0, S5PC110_CLKDIV0_HCLK_MSYS);
> +	hclk_dsys = mpll / GET_DIV(clkdiv0, S5PC110_CLKDIV0_HCLK_DSYS);
> +	hclk_psys = mpll / GET_DIV(clkdiv0, S5PC110_CLKDIV0_HCLK_PSYS);
> +	pclk_msys = hclk_msys / GET_DIV(clkdiv0, S5PC110_CLKDIV0_PCLK_MSYS);
> +	pclk_dsys = hclk_dsys / GET_DIV(clkdiv0, S5PC110_CLKDIV0_PCLK_DSYS);
> +	pclk_psys = hclk_psys / GET_DIV(clkdiv0, S5PC110_CLKDIV0_PCLK_PSYS);
> +
> +	printk(KERN_INFO "S5PC110: ARMCLK=%ld.%03ld MHz\n"
> +		"HCLK: Msys %ld.%03ld MHz, Dsys %ld.%03ld MHz, Psys %ld.%03ld MHz\n"
> +		"PCLK: Msys %ld.%03ld MHz, Dsys %ld.%03ld MHz, Psys %ld.%03ld MHz\n",
> +		print_mhz(armclk),
> +		print_mhz(hclk_msys), print_mhz(hclk_dsys), print_mhz(hclk_psys),
> +		print_mhz(pclk_msys), print_mhz(pclk_dsys), print_mhz(pclk_psys));
> +
> +	clk_ext_xtal_mux.rate = xtal;
> +	clk_fout_apll.rate = apll;
> +	clk_fout_mpll.rate = mpll;
> +	clk_fout_epll.rate = epll;
> +	clk_fout_vpll.rate = vpll;
> +
> +	clk_dout_hclkm.rate = hclk_msys;
> +	clk_dout_hclkd.rate = hclk_dsys;
> +	clk_dout_hclkp.rate = hclk_psys;
> +	clk_dout_pclkm.rate = pclk_msys;
> +	clk_dout_pclkd.rate = pclk_dsys;
> +	clk_dout_pclkp.rate = pclk_psys;
> +
> +	clk_h.rate = hclk_psys;
> +	clk_p.rate = pclk_psys;
> +	clk_f.rate = armclk;
> +
> +	for (ptr = 0; ptr < ARRAY_SIZE(init_parents); ptr++)
> +		s5pc110_set_clksrc(init_parents[ptr]);
> +}
> +
> +static struct clk *clks[] __initdata = {
> +	&clk_ext_xtal_mux,
> +	&clk_usb_xtal,
> +	&clk_pcm_cd0,
> +	&clk_pcm_cd1,
> +	&clk_iis_cd1,
> +	&clk_mout_apll.clk,
> +	&clk_mout_mpll.clk,
> +	&clk_mout_epll.clk,
> +	&clk_mout_vpllsrc.clk,
> +	&clk_mout_vpll.clk,
> +	&clk_dout_a2m,
> +	&clk_mout_hpm.clk,
> +	&clk_mout_msys.clk,
> +	&clk_mout_dsys.clk,
> +	&clk_mout_psys.clk,
> +	&clk_dout_copy,
> +	&clk_dout_hpm,
> +	&clk_dout_apll,
> +	&clk_dout_hclkm,
> +	&clk_dout_pclkm,
> +	&clk_dout_hclkd,
> +	&clk_dout_pclkd,
> +	&clk_dout_hclkp,
> +	&clk_dout_pclkp,
> +	&clk_dout_fimc,
> +	&clk_dout_imem,
> +	&clk_mout_onenand.clk,
> +	&clk_dout_onenand,
> +	&clk_dout_onenand2,
> +	&clk_cam0.clk,
> +	&clk_cam1.clk,
> +	&clk_fimd.clk,
> +	&clk_mmc0.clk,
> +	&clk_mmc1.clk,
> +	&clk_mmc2.clk,
> +	&clk_mmc3.clk,
> +	&clk_audio0.clk,
> +	&clk_audio1.clk,
> +	&clk_audio2.clk,
> +	&clk_fimc0.clk,
> +	&clk_fimc1.clk,
> +	&clk_fimc2.clk,
> +	&clk_uart0.clk,
> +	&clk_uart1.clk,
> +	&clk_uart2.clk,
> +	&clk_uart3.clk,
> +	&clk_pwm.clk,
> +};
> +
> +void __init s5pc110_register_clocks(void)
> +{
> +	struct clk *clkp;
> +	int ret;
> +	int ptr;
> +
> +	for (ptr = 0; ptr < ARRAY_SIZE(clks); ptr++) {
> +		clkp = clks[ptr];
> +		ret = s3c24xx_register_clock(clkp);
> +		if (ret < 0) {
> +			printk(KERN_ERR "Failed to register clock %s (%d)\n",
> +			       clkp->name, ret);
> +		}
> +	}
> +}
> -- 
> 1.6.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
