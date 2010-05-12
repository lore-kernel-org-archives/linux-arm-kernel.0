From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 12 May 2010 13:55:09 +0900
Subject: [PATCH 01/16] ARM: S5PC1xx rename registers to match plat-s5p
	style
In-Reply-To: <1270190944-21644-2-git-send-email-m.szyprowski@samsung.com>
References: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
	<1270190944-21644-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <001201caf18f$4f72a050$ee57e0f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Prepare for moving support for S5PC100 SoC to plat-s5p framework (part 1).
> Rename all clock registers to match plat-s5p style.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pc100/include/mach/system.h     |    2 +-
>  arch/arm/plat-s5pc1xx/clock.c                   |  190 ++++++------
>  arch/arm/plat-s5pc1xx/include/plat/regs-clock.h |  366
+++++++++++-----------
>  arch/arm/plat-s5pc1xx/s5pc100-clock.c           |  180 ++++++------
>  4 files changed, 369 insertions(+), 369 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pc100/include/mach/system.h b/arch/arm/mach-
> s5pc100/include/mach/system.h
> index f0d31a2..09aea4d 100644
> --- a/arch/arm/mach-s5pc100/include/mach/system.h
> +++ b/arch/arm/mach-s5pc100/include/mach/system.h
> @@ -25,7 +25,7 @@ static void arch_idle(void)
> 
>  static void arch_reset(char mode, const char *cmd)
>  {
> -	__raw_writel(S5PC100_SWRESET_RESETVAL, S5PC100_SWRESET);
> +	__raw_writel(S5P_SWRESET_RESETVAL, S5P_SWRESET);
>  	return;
>  }
>  #endif /* __ASM_ARCH_IRQ_H */

Why __ASM_ARCH_IRQ_H?
It may be right __ASM_ARCH_SYSTEM_H.

> diff --git a/arch/arm/plat-s5pc1xx/clock.c b/arch/arm/plat-s5pc1xx/clock.c
> index 387f231..1a07dd5 100644
> --- a/arch/arm/plat-s5pc1xx/clock.c
> +++ b/arch/arm/plat-s5pc1xx/clock.c
> @@ -39,13 +39,13 @@ static int clk_48m_ctrl(struct clk *clk, int enable)
>  	/* can't rely on clock lock, this register has other usages */
>  	local_irq_save(flags);
> 
> -	val = __raw_readl(S5PC100_CLKSRC1);
> +	val = __raw_readl(S5P_CLK_SRC1);	
>  	if (enable)
> -		val |= S5PC100_CLKSRC1_CLK48M_MASK;
> +		val |= S5P_CLK_SRC1_CLK48M_MASK;
>  	else
> -		val &= ~S5PC100_CLKSRC1_CLK48M_MASK;
> +		val &= ~S5P_CLK_SRC1_CLK48M_MASK;
> 
> -	__raw_writel(val, S5PC100_CLKSRC1);
> +	__raw_writel(val, S5P_CLK_SRC1);
>  	local_irq_restore(flags);
> 
>  	return 0;
> @@ -99,62 +99,62 @@ static int s5pc1xx_clk_gate(void __iomem *reg, struct
clk
> *clk, int enable)
> 
>  static int s5pc100_clk_d00_ctrl(struct clk *clk, int enable)
>  {
> -	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D00, clk, enable);
> +	return s5pc1xx_clk_gate(S5P_CLKGATE_D00, clk, enable);

Please use s5p_gatectrl(plat-s5p/clock.c) instead of s5pc1xx_clk_gate.

>  }
> 
>  static int s5pc100_clk_d01_ctrl(struct clk *clk, int enable)
>  {
> -	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D01, clk, enable);
> +	return s5pc1xx_clk_gate(S5P_CLKGATE_D01, clk, enable);

Same.

>  }
> 
>  static int s5pc100_clk_d02_ctrl(struct clk *clk, int enable)
>  {
> -	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D02, clk, enable);
> +	return s5pc1xx_clk_gate(S5P_CLKGATE_D02, clk, enable);
>  }
> 
>  static int s5pc100_clk_d10_ctrl(struct clk *clk, int enable)
>  {
> -	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D10, clk, enable);
> +	return s5pc1xx_clk_gate(S5P_CLKGATE_D10, clk, enable);
>  }
> 
>  static int s5pc100_clk_d11_ctrl(struct clk *clk, int enable)
>  {
> -	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D11, clk, enable);
> +	return s5pc1xx_clk_gate(S5P_CLKGATE_D11, clk, enable);
>  }
> 
>  static int s5pc100_clk_d12_ctrl(struct clk *clk, int enable)
>  {
> -	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D12, clk, enable);
> +	return s5pc1xx_clk_gate(S5P_CLKGATE_D12, clk, enable);
>  }
> 
>  static int s5pc100_clk_d13_ctrl(struct clk *clk, int enable)
>  {
> -	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D13, clk, enable);
> +	return s5pc1xx_clk_gate(S5P_CLKGATE_D13, clk, enable);
>  }
> 
>  static int s5pc100_clk_d14_ctrl(struct clk *clk, int enable)
>  {
> -	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D14, clk, enable);
> +	return s5pc1xx_clk_gate(S5P_CLKGATE_D14, clk, enable);
>  }
> 
>  static int s5pc100_clk_d15_ctrl(struct clk *clk, int enable)
>  {
> -	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D15, clk, enable);
> +	return s5pc1xx_clk_gate(S5P_CLKGATE_D15, clk, enable);
>  }
> 
>  static int s5pc100_clk_d20_ctrl(struct clk *clk, int enable)
>  {
> -	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D20, clk, enable);
> +	return s5pc1xx_clk_gate(S5P_CLKGATE_D20, clk, enable);
>  }
> 
>  int s5pc100_sclk0_ctrl(struct clk *clk, int enable)
>  {
> -	return s5pc1xx_clk_gate(S5PC100_SCLKGATE0, clk, enable);
> +	return s5pc1xx_clk_gate(S5P_SCLKGATE0, clk, enable);
>  }
> 
>  int s5pc100_sclk1_ctrl(struct clk *clk, int enable)
>  {
> -	return s5pc1xx_clk_gate(S5PC100_SCLKGATE1, clk, enable);
> +	return s5pc1xx_clk_gate(S5P_SCLKGATE1, clk, enable);

Same comment as for above...

>  }
> 
>  static struct clk s5pc100_init_clocks_disable[] = {
> @@ -163,43 +163,43 @@ static struct clk s5pc100_init_clocks_disable[] = {
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d11_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D11_DSI,
> +		.ctrlbit	= S5P_CLKGATE_D11_DSI,
>  	}, {
>  		.name		= "csi",
>  		.id		= -1,
>  		.parent		= &clk_h,
>  		.enable		= s5pc100_clk_d11_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D11_CSI,
> +		.ctrlbit	= S5P_CLKGATE_D11_CSI,
>  	}, {
>  		.name		= "ccan",
>  		.id		= 0,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d14_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D14_CCAN0,
> +		.ctrlbit	= S5P_CLKGATE_D14_CCAN0,
>  	}, {
>  		.name		= "ccan",
>  		.id		= 1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d14_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D14_CCAN1,
> +		.ctrlbit	= S5P_CLKGATE_D14_CCAN1,
>  	}, {
>  		.name		= "keypad",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d15_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D15_KEYIF,
> +		.ctrlbit	= S5P_CLKGATE_D15_KEYIF,
>  	}, {
>  		.name		= "hclkd2",
>  		.id		= -1,
>  		.parent		= NULL,
>  		.enable		= s5pc100_clk_d20_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D20_HCLKD2,
> +		.ctrlbit	= S5P_CLKGATE_D20_HCLKD2,
>  	}, {
>  		.name		= "iis-d2",
>  		.id		= -1,
>  		.parent		= NULL,
>  		.enable		= s5pc100_clk_d20_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D20_I2SD2,
> +		.ctrlbit	= S5P_CLKGATE_D20_I2SD2,
>  	},
>  };
> 
> @@ -210,43 +210,43 @@ static struct clk s5pc100_init_clocks[] = {
>  		.id		= -1,
>  		.parent		= &clk_hd0,
>  		.enable		= s5pc100_clk_d00_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D00_INTC,
> +		.ctrlbit	= S5P_CLKGATE_D00_INTC,
>  	}, {
>  		.name		= "tzic",
>  		.id		= -1,
>  		.parent		= &clk_hd0,
>  		.enable		= s5pc100_clk_d00_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D00_TZIC,
> +		.ctrlbit	= S5P_CLKGATE_D00_TZIC,
>  	}, {
>  		.name		= "cf-ata",
>  		.id		= -1,
>  		.parent		= &clk_hd0,
>  		.enable		= s5pc100_clk_d00_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D00_CFCON,
> +		.ctrlbit	= S5P_CLKGATE_D00_CFCON,
>  	}, {
>  		.name		= "mdma",
>  		.id		= -1,
>  		.parent		= &clk_hd0,
>  		.enable		= s5pc100_clk_d00_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D00_MDMA,
> +		.ctrlbit	= S5P_CLKGATE_D00_MDMA,
>  	}, {
>  		.name		= "g2d",
>  		.id		= -1,
>  		.parent		= &clk_hd0,
>  		.enable		= s5pc100_clk_d00_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D00_G2D,
> +		.ctrlbit	= S5P_CLKGATE_D00_G2D,
>  	}, {
>  		.name		= "secss",
>  		.id		= -1,
>  		.parent		= &clk_hd0,
>  		.enable		= s5pc100_clk_d00_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D00_SECSS,
> +		.ctrlbit	= S5P_CLKGATE_D00_SECSS,
>  	}, {
>  		.name		= "cssys",
>  		.id		= -1,
>  		.parent		= &clk_hd0,
>  		.enable		= s5pc100_clk_d00_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D00_CSSYS,
> +		.ctrlbit	= S5P_CLKGATE_D00_CSSYS,
>  	},
> 
>  	/* Memory (D0_1) devices */
> @@ -255,37 +255,37 @@ static struct clk s5pc100_init_clocks[] = {
>  		.id		= -1,
>  		.parent		= &clk_hd0,
>  		.enable		= s5pc100_clk_d01_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D01_DMC,
> +		.ctrlbit	= S5P_CLKGATE_D01_DMC,
>  	}, {
>  		.name		= "sromc",
>  		.id		= -1,
>  		.parent		= &clk_hd0,
>  		.enable		= s5pc100_clk_d01_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D01_SROMC,
> +		.ctrlbit	= S5P_CLKGATE_D01_SROMC,
>  	}, {
>  		.name		= "onenand",
>  		.id		= -1,
>  		.parent		= &clk_hd0,
>  		.enable		= s5pc100_clk_d01_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D01_ONENAND,
> +		.ctrlbit	= S5P_CLKGATE_D01_ONENAND,
>  	}, {
>  		.name		= "nand",
>  		.id		= -1,
>  		.parent		= &clk_hd0,
>  		.enable		= s5pc100_clk_d01_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D01_NFCON,
> +		.ctrlbit	= S5P_CLKGATE_D01_NFCON,
>  	}, {
>  		.name		= "intmem",
>  		.id		= -1,
>  		.parent		= &clk_hd0,
>  		.enable		= s5pc100_clk_d01_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D01_INTMEM,
> +		.ctrlbit	= S5P_CLKGATE_D01_INTMEM,
>  	}, {
>  		.name		= "ebi",
>  		.id		= -1,
>  		.parent		= &clk_hd0,
>  		.enable		= s5pc100_clk_d01_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D01_EBI,
> +		.ctrlbit	= S5P_CLKGATE_D01_EBI,
>  	},
> 
>  	/* System2 (D0_2) devices */
> @@ -294,13 +294,13 @@ static struct clk s5pc100_init_clocks[] = {
>  		.id		= -1,
>  		.parent		= &clk_pd0,
>  		.enable		= s5pc100_clk_d02_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D02_SECKEY,
> +		.ctrlbit	= S5P_CLKGATE_D02_SECKEY,
>  	}, {
>  		.name		= "sdm",
>  		.id		= -1,
>  		.parent		= &clk_hd0,
>  		.enable		= s5pc100_clk_d02_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D02_SDM,
> +		.ctrlbit	= S5P_CLKGATE_D02_SDM,
>  	},
> 
>  	/* File (D1_0) devices */
> @@ -309,49 +309,49 @@ static struct clk s5pc100_init_clocks[] = {
>  		.id		= 0,
>  		.parent		= &clk_h,
>  		.enable		= s5pc100_clk_d10_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D10_PDMA0,
> +		.ctrlbit	= S5P_CLKGATE_D10_PDMA0,
>  	}, {
>  		.name		= "pdma",
>  		.id		= 1,
>  		.parent		= &clk_h,
>  		.enable		= s5pc100_clk_d10_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D10_PDMA1,
> +		.ctrlbit	= S5P_CLKGATE_D10_PDMA1,
>  	}, {
>  		.name		= "usb-host",
>  		.id		= -1,
>  		.parent		= &clk_h,
>  		.enable		= s5pc100_clk_d10_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D10_USBHOST,
> +		.ctrlbit	= S5P_CLKGATE_D10_USBHOST,
>  	}, {
>  		.name		= "otg",
>  		.id		= -1,
>  		.parent		= &clk_h,
>  		.enable		= s5pc100_clk_d10_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D10_USBOTG,
> +		.ctrlbit	= S5P_CLKGATE_D10_USBOTG,
>  	}, {
>  		.name		= "modem",
>  		.id		= -1,
>  		.parent		= &clk_h,
>  		.enable		= s5pc100_clk_d10_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D10_MODEMIF,
> +		.ctrlbit	= S5P_CLKGATE_D10_MODEMIF,
>  	}, {
>  		.name		= "hsmmc",
>  		.id		= 0,
>  		.parent		= &clk_48m,
>  		.enable		= s5pc100_clk_d10_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D10_HSMMC0,
> +		.ctrlbit	= S5P_CLKGATE_D10_HSMMC0,
>  	}, {
>  		.name		= "hsmmc",
>  		.id		= 1,
>  		.parent		= &clk_48m,
>  		.enable		= s5pc100_clk_d10_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D10_HSMMC1,
> +		.ctrlbit	= S5P_CLKGATE_D10_HSMMC1,
>  	}, {
>  		.name		= "hsmmc",
>  		.id		= 2,
>  		.parent		= &clk_48m,
>  		.enable		= s5pc100_clk_d10_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D10_HSMMC2,
> +		.ctrlbit	= S5P_CLKGATE_D10_HSMMC2,
>  	},
> 
>  	/* Multimedia1 (D1_1) devices */
> @@ -360,43 +360,43 @@ static struct clk s5pc100_init_clocks[] = {
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d11_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D11_LCD,
> +		.ctrlbit	= S5P_CLKGATE_D11_LCD,
>  	}, {
>  		.name		= "rotator",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d11_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D11_ROTATOR,
> +		.ctrlbit	= S5P_CLKGATE_D11_ROTATOR,
>  	}, {
>  		.name		= "fimc",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d11_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D11_FIMC0,
> +		.ctrlbit	= S5P_CLKGATE_D11_FIMC0,
>  	}, {
>  		.name		= "fimc",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d11_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D11_FIMC1,
> +		.ctrlbit	= S5P_CLKGATE_D11_FIMC1,
>  	}, {
>  		.name		= "fimc",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d11_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D11_FIMC2,
> +		.ctrlbit	= S5P_CLKGATE_D11_FIMC2,
>  	}, {
>  		.name		= "jpeg",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d11_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D11_JPEG,
> +		.ctrlbit	= S5P_CLKGATE_D11_JPEG,
>  	}, {
>  		.name		= "g3d",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d11_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D11_G3D,
> +		.ctrlbit	= S5P_CLKGATE_D11_G3D,
>  	},
> 
>  	/* Multimedia2 (D1_2) devices */
> @@ -405,31 +405,31 @@ static struct clk s5pc100_init_clocks[] = {
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d12_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D12_TV,
> +		.ctrlbit	= S5P_CLKGATE_D12_TV,
>  	}, {
>  		.name		= "vp",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d12_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D12_VP,
> +		.ctrlbit	= S5P_CLKGATE_D12_VP,
>  	}, {
>  		.name		= "mixer",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d12_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D12_MIXER,
> +		.ctrlbit	= S5P_CLKGATE_D12_MIXER,
>  	}, {
>  		.name		= "hdmi",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d12_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D12_HDMI,
> +		.ctrlbit	= S5P_CLKGATE_D12_HDMI,
>  	}, {
>  		.name		= "mfc",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d12_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D12_MFC,
> +		.ctrlbit	= S5P_CLKGATE_D12_MFC,
>  	},
> 
>  	/* System (D1_3) devices */
> @@ -438,49 +438,49 @@ static struct clk s5pc100_init_clocks[] = {
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d13_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D13_CHIPID,
> +		.ctrlbit	= S5P_CLKGATE_D13_CHIPID,
>  	}, {
>  		.name		= "gpio",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d13_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D13_GPIO,
> +		.ctrlbit	= S5P_CLKGATE_D13_GPIO,
>  	}, {
>  		.name		= "apc",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d13_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D13_APC,
> +		.ctrlbit	= S5P_CLKGATE_D13_APC,
>  	}, {
>  		.name		= "iec",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d13_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D13_IEC,
> +		.ctrlbit	= S5P_CLKGATE_D13_IEC,
>  	}, {
>  		.name		= "timers",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d13_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D13_PWM,
> +		.ctrlbit	= S5P_CLKGATE_D13_PWM,
>  	}, {
>  		.name		= "systimer",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d13_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D13_SYSTIMER,
> +		.ctrlbit	= S5P_CLKGATE_D13_SYSTIMER,
>  	}, {
>  		.name		= "watchdog",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d13_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D13_WDT,
> +		.ctrlbit	= S5P_CLKGATE_D13_WDT,
>  	}, {
>  		.name		= "rtc",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d13_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D13_RTC,
> +		.ctrlbit	= S5P_CLKGATE_D13_RTC,
>  	},
> 
>  	/* Connectivity (D1_4) devices */
> @@ -489,73 +489,73 @@ static struct clk s5pc100_init_clocks[] = {
>  		.id		= 0,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d14_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D14_UART0,
> +		.ctrlbit	= S5P_CLKGATE_D14_UART0,
>  	}, {
>  		.name		= "uart",
>  		.id		= 1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d14_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D14_UART1,
> +		.ctrlbit	= S5P_CLKGATE_D14_UART1,
>  	}, {
>  		.name		= "uart",
>  		.id		= 2,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d14_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D14_UART2,
> +		.ctrlbit	= S5P_CLKGATE_D14_UART2,
>  	}, {
>  		.name		= "uart",
>  		.id		= 3,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d14_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D14_UART3,
> +		.ctrlbit	= S5P_CLKGATE_D14_UART3,
>  	}, {
>  		.name		= "i2c",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d14_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D14_IIC,
> +		.ctrlbit	= S5P_CLKGATE_D14_IIC,
>  	}, {
>  		.name		= "hdmi-i2c",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d14_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D14_HDMI_IIC,
> +		.ctrlbit	= S5P_CLKGATE_D14_HDMI_IIC,
>  	}, {
>  		.name		= "spi",
>  		.id		= 0,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d14_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D14_SPI0,
> +		.ctrlbit	= S5P_CLKGATE_D14_SPI0,
>  	}, {
>  		.name		= "spi",
>  		.id		= 1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d14_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D14_SPI1,
> +		.ctrlbit	= S5P_CLKGATE_D14_SPI1,
>  	}, {
>  		.name		= "spi",
>  		.id		= 2,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d14_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D14_SPI2,
> +		.ctrlbit	= S5P_CLKGATE_D14_SPI2,
>  	}, {
>  		.name		= "irda",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d14_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D14_IRDA,
> +		.ctrlbit	= S5P_CLKGATE_D14_IRDA,
>  	}, {
>  		.name		= "hsitx",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d14_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D14_HSITX,
> +		.ctrlbit	= S5P_CLKGATE_D14_HSITX,
>  	}, {
>  		.name		= "hsirx",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d14_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D14_HSIRX,
> +		.ctrlbit	= S5P_CLKGATE_D14_HSIRX,
>  	},
> 
>  	/* Audio (D1_5) devices */
> @@ -564,55 +564,55 @@ static struct clk s5pc100_init_clocks[] = {
>  		.id		= 0,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d15_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D15_IIS0,
> +		.ctrlbit	= S5P_CLKGATE_D15_IIS0,
>  	}, {
>  		.name		= "iis",
>  		.id		= 1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d15_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D15_IIS1,
> +		.ctrlbit	= S5P_CLKGATE_D15_IIS1,
>  	}, {
>  		.name		= "iis",
>  		.id		= 2,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d15_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D15_IIS2,
> +		.ctrlbit	= S5P_CLKGATE_D15_IIS2,
>  	}, {
>  		.name		= "ac97",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d15_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D15_AC97,
> +		.ctrlbit	= S5P_CLKGATE_D15_AC97,
>  	}, {
>  		.name		= "pcm",
>  		.id		= 0,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d15_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D15_PCM0,
> +		.ctrlbit	= S5P_CLKGATE_D15_PCM0,
>  	}, {
>  		.name		= "pcm",
>  		.id		= 1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d15_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D15_PCM1,
> +		.ctrlbit	= S5P_CLKGATE_D15_PCM1,
>  	}, {
>  		.name		= "spdif",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d15_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D15_SPDIF,
> +		.ctrlbit	= S5P_CLKGATE_D15_SPDIF,
>  	}, {
>  		.name		= "adc",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d15_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D15_TSADC,
> +		.ctrlbit	= S5P_CLKGATE_D15_TSADC,
>  	}, {
>  		.name		= "cg",
>  		.id		= -1,
>  		.parent		= &clk_p,
>  		.enable		= s5pc100_clk_d15_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_D15_CG,
> +		.ctrlbit	= S5P_CLKGATE_D15_CG,
>  	},
> 
>  	/* Audio (D2_0) devices: all disabled */
> @@ -623,49 +623,49 @@ static struct clk s5pc100_init_clocks[] = {
>  		.id		= -1,
>  		.parent		= NULL,
>  		.enable		= s5pc100_sclk0_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_SCLK0_HPM,
> +		.ctrlbit	= S5P_CLKGATE_SCLK0_HPM,
>  	}, {
>  		.name		= "sclk_onenand",
>  		.id		= -1,
>  		.parent		= NULL,
>  		.enable		= s5pc100_sclk0_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_SCLK0_ONENAND,
> +		.ctrlbit	= S5P_CLKGATE_SCLK0_ONENAND,
>  	}, {
>  		.name		= "spi_48",
>  		.id		= 0,
>  		.parent		= &clk_48m,
>  		.enable		= s5pc100_sclk0_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI0_48,
> +		.ctrlbit	= S5P_CLKGATE_SCLK0_SPI0_48,
>  	}, {
>  		.name		= "spi_48",
>  		.id		= 1,
>  		.parent		= &clk_48m,
>  		.enable		= s5pc100_sclk0_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI1_48,
> +		.ctrlbit	= S5P_CLKGATE_SCLK0_SPI1_48,
>  	}, {
>  		.name		= "spi_48",
>  		.id		= 2,
>  		.parent		= &clk_48m,
>  		.enable		= s5pc100_sclk0_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI2_48,
> +		.ctrlbit	= S5P_CLKGATE_SCLK0_SPI2_48,
>  	}, {
>  		.name		= "mmc_48",
>  		.id		= 0,
>  		.parent		= &clk_48m,
>  		.enable		= s5pc100_sclk0_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC0_48,
> +		.ctrlbit	= S5P_CLKGATE_SCLK0_MMC0_48,
>  	}, {
>  		.name		= "mmc_48",
>  		.id		= 1,
>  		.parent		= &clk_48m,
>  		.enable		= s5pc100_sclk0_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC1_48,
> +		.ctrlbit	= S5P_CLKGATE_SCLK0_MMC1_48,
>  	}, {
>  		.name		= "mmc_48",
>  		.id		= 2,
>  		.parent		= &clk_48m,
>  		.enable		= s5pc100_sclk0_ctrl,
> -		.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC2_48,
> +		.ctrlbit	= S5P_CLKGATE_SCLK0_MMC2_48,
>  	},
>  	/* Special Clocks 1 */
>  };

If the #defines like S5P_CLKGATE_SCLK0_MMC2_48, are only being used
in only here then simply used the (1 << x) to set .ctrlbit directly.
And of course, to remove those definitions will be better.

> diff --git a/arch/arm/plat-s5pc1xx/include/plat/regs-clock.h
b/arch/arm/plat-
> s5pc1xx/include/plat/regs-clock.h
> index 24dec4e..5c9c4cb 100644
> --- a/arch/arm/plat-s5pc1xx/include/plat/regs-clock.h
> +++ b/arch/arm/plat-s5pc1xx/include/plat/regs-clock.h
> @@ -3,7 +3,7 @@
>   * Copyright 2009 Samsung Electronics Co.
>   *	Byungho Min <bhmin@samsung.com>
>   *
> - * S5PC1XX clock register definitions
> + * S5PC100 clock register definitions
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -13,240 +13,240 @@
>  #ifndef __PLAT_REGS_CLOCK_H
>  #define __PLAT_REGS_CLOCK_H __FILE__
> 
> -#define S5PC100_CLKREG(x)		(S5PC1XX_VA_CLK + (x))
> -#define S5PC100_CLKREG_OTHER(x)		(S5PC1XX_VA_CLK_OTHER +
> (x))
> +#define S5P_CLKREG(x)		(S5PC1XX_VA_CLK + (x))

To use directly S3C_VA_SYS without remapping to S5PC1XX_VA_xxx is better.
If you need some offset here, then just add it here.

> +#define S5PC100_REG_OTHERS(x)	(S5PC1XX_VA_CLK_OTHER + (x))

Same. Please use S3C_VA_SYS with some offset.

> 
>  /* s5pc100 register for clock */
> -#define S5PC100_APLL_LOCK		S5PC100_CLKREG(0x00)
> -#define S5PC100_MPLL_LOCK		S5PC100_CLKREG(0x04)
> -#define S5PC100_EPLL_LOCK		S5PC100_CLKREG(0x08)
> -#define S5PC100_HPLL_LOCK		S5PC100_CLKREG(0x0C)
> +#define S5P_APLL_LOCK		S5P_CLKREG(0x00)
> +#define S5P_MPLL_LOCK		S5P_CLKREG(0x04)
> +#define S5P_EPLL_LOCK		S5P_CLKREG(0x08)
> +#define S5P_HPLL_LOCK		S5P_CLKREG(0x0C)
> 
> -#define S5PC100_APLL_CON		S5PC100_CLKREG(0x100)
> -#define S5PC100_MPLL_CON		S5PC100_CLKREG(0x104)
> -#define S5PC100_EPLL_CON		S5PC100_CLKREG(0x108)
> -#define S5PC100_HPLL_CON		S5PC100_CLKREG(0x10C)
> +#define S5P_APLL_CON		S5P_CLKREG(0x100)
> +#define S5P_MPLL_CON		S5P_CLKREG(0x104)
> +#define S5P_EPLL_CON		S5P_CLKREG(0x108)
> +#define S5P_HPLL_CON		S5P_CLKREG(0x10C)
> 
> -#define S5PC100_CLKSRC0			S5PC100_CLKREG(0x200)
> -#define S5PC100_CLKSRC1			S5PC100_CLKREG(0x204)
> -#define S5PC100_CLKSRC2			S5PC100_CLKREG(0x208)
> -#define S5PC100_CLKSRC3			S5PC100_CLKREG(0x20C)
> +#define S5P_CLK_SRC0		S5P_CLKREG(0x200)
> +#define S5P_CLK_SRC1		S5P_CLKREG(0x204)
> +#define S5P_CLK_SRC2		S5P_CLKREG(0x208)
> +#define S5P_CLK_SRC3		S5P_CLKREG(0x20C)
> 
> -#define S5PC100_CLKDIV0			S5PC100_CLKREG(0x300)
> -#define S5PC100_CLKDIV1			S5PC100_CLKREG(0x304)
> -#define S5PC100_CLKDIV2			S5PC100_CLKREG(0x308)
> -#define S5PC100_CLKDIV3			S5PC100_CLKREG(0x30C)
> -#define S5PC100_CLKDIV4			S5PC100_CLKREG(0x310)
> +#define S5P_CLK_DIV0		S5P_CLKREG(0x300)
> +#define S5P_CLK_DIV1		S5P_CLKREG(0x304)
> +#define S5P_CLK_DIV2		S5P_CLKREG(0x308)
> +#define S5P_CLK_DIV3		S5P_CLKREG(0x30C)
> +#define S5P_CLK_DIV4		S5P_CLKREG(0x310)
> 
> -#define S5PC100_CLK_OUT			S5PC100_CLKREG(0x400)
> +#define S5P_CLK_OUT		S5P_CLKREG(0x400)
> 
> -#define S5PC100_CLKGATE_D00		S5PC100_CLKREG(0x500)
> -#define S5PC100_CLKGATE_D01		S5PC100_CLKREG(0x504)
> -#define S5PC100_CLKGATE_D02		S5PC100_CLKREG(0x508)
> +#define S5P_CLKGATE_D00		S5P_CLKREG(0x500)
> +#define S5P_CLKGATE_D01		S5P_CLKREG(0x504)
> +#define S5P_CLKGATE_D02		S5P_CLKREG(0x508)
> 
> -#define S5PC100_CLKGATE_D10		S5PC100_CLKREG(0x520)
> -#define S5PC100_CLKGATE_D11		S5PC100_CLKREG(0x524)
> -#define S5PC100_CLKGATE_D12		S5PC100_CLKREG(0x528)
> -#define S5PC100_CLKGATE_D13		S5PC100_CLKREG(0x52C)
> -#define S5PC100_CLKGATE_D14		S5PC100_CLKREG(0x530)
> -#define S5PC100_CLKGATE_D15		S5PC100_CLKREG(0x534)
> +#define S5P_CLKGATE_D10		S5P_CLKREG(0x520)
> +#define S5P_CLKGATE_D11		S5P_CLKREG(0x524)
> +#define S5P_CLKGATE_D12		S5P_CLKREG(0x528)
> +#define S5P_CLKGATE_D13		S5P_CLKREG(0x52C)
> +#define S5P_CLKGATE_D14		S5P_CLKREG(0x530)
> +#define S5P_CLKGATE_D15		S5P_CLKREG(0x534)
> 
> -#define S5PC100_CLKGATE_D20		S5PC100_CLKREG(0x540)
> +#define S5P_CLKGATE_D20		S5P_CLKREG(0x540)
> 
> -#define S5PC100_SCLKGATE0		S5PC100_CLKREG(0x560)
> -#define S5PC100_SCLKGATE1		S5PC100_CLKREG(0x564)
> +#define S5P_SCLKGATE0		S5P_CLKREG(0x560)
> +#define S5P_SCLKGATE1		S5P_CLKREG(0x564)
> 
>  /* EPLL_CON */
> -#define S5PC100_EPLL_EN			(1<<31)
> -#define S5PC100_EPLL_MASK		0xffffffff
> -#define S5PC100_EPLLVAL(_m, _p, _s)	((_m) << 16 | ((_p) << 8) | ((_s)))
> +#define S5P_EPLL_EN		(1<<31)
> +#define S5P_EPLL_MASK		0xffffffff
> +#define S5P_EPLLVAL(_m, _p, _s)	((_m) << 16 | ((_p) << 8) | ((_s)))

This definitions really need? I can not fine where is used.

> 
>  /* CLKSRC0..CLKSRC3 -> mostly removed due to clksrc updates */
> -#define S5PC100_CLKSRC1_CLK48M_MASK	(0x1<<24)
> -#define S5PC100_CLKSRC1_CLK48M_SHIFT	(24)
> +#define S5P_CLK_SRC1_CLK48M_MASK	(0x1<<24)
> +#define S5P_CLK_SRC1_CLK48M_SHIFT	(24)
> 
>  /* CLKDIV0 */
> -#define S5PC100_CLKDIV0_APLL_MASK		(0x1<<0)
> -#define S5PC100_CLKDIV0_APLL_SHIFT		(0)
> -#define S5PC100_CLKDIV0_ARM_MASK		(0x7<<4)
> -#define S5PC100_CLKDIV0_ARM_SHIFT		(4)
> -#define S5PC100_CLKDIV0_D0_MASK		(0x7<<8)
> -#define S5PC100_CLKDIV0_D0_SHIFT		(8)
> -#define S5PC100_CLKDIV0_PCLKD0_MASK		(0x7<<12)
> -#define S5PC100_CLKDIV0_PCLKD0_SHIFT	(12)
> -#define S5PC100_CLKDIV0_SECSS_MASK		(0x7<<16)
> -#define S5PC100_CLKDIV0_SECSS_SHIFT		(16)
> +#define S5P_CLK_DIV0_APLL_MASK		(0x1<<0)
> +#define S5P_CLK_DIV0_APLL_SHIFT		(0)
> +#define S5P_CLK_DIV0_ARM_MASK		(0x7<<4)
> +#define S5P_CLK_DIV0_ARM_SHIFT		(4)
> +#define S5P_CLK_DIV0_D0_MASK		(0x7<<8)
> +#define S5P_CLK_DIV0_D0_SHIFT		(8)
> +#define S5P_CLK_DIV0_PCLKD0_MASK		(0x7<<12)
> +#define S5P_CLK_DIV0_PCLKD0_SHIFT	(12)
> +#define S5P_CLK_DIV0_SECSS_MASK		(0x7<<16)
> +#define S5P_CLK_DIV0_SECSS_SHIFT		(16)
> 
>  /* CLKDIV1 (OneNAND clock only used in one place, removed) */
> -#define S5PC100_CLKDIV1_APLL2_MASK		(0x7<<0)
> -#define S5PC100_CLKDIV1_APLL2_SHIFT		(0)
> -#define S5PC100_CLKDIV1_MPLL_MASK		(0x3<<4)
> -#define S5PC100_CLKDIV1_MPLL_SHIFT		(4)
> -#define S5PC100_CLKDIV1_MPLL2_MASK		(0x1<<8)
> -#define S5PC100_CLKDIV1_MPLL2_SHIFT		(8)
> -#define S5PC100_CLKDIV1_D1_MASK		(0x7<<12)
> -#define S5PC100_CLKDIV1_D1_SHIFT		(12)
> -#define S5PC100_CLKDIV1_PCLKD1_MASK		(0x7<<16)
> -#define S5PC100_CLKDIV1_PCLKD1_SHIFT	(16)
> -#define S5PC100_CLKDIV1_CAM_MASK		(0x1F<<24)
> -#define S5PC100_CLKDIV1_CAM_SHIFT		(24)
> +#define S5P_CLK_DIV1_APLL2_MASK		(0x7<<0)
> +#define S5P_CLK_DIV1_APLL2_SHIFT		(0)
> +#define S5P_CLK_DIV1_MPLL_MASK		(0x3<<4)
> +#define S5P_CLK_DIV1_MPLL_SHIFT		(4)
> +#define S5P_CLK_DIV1_MPLL2_MASK		(0x1<<8)
> +#define S5P_CLK_DIV1_MPLL2_SHIFT		(8)
> +#define S5P_CLK_DIV1_D1_MASK		(0x7<<12)
> +#define S5P_CLK_DIV1_D1_SHIFT		(12)
> +#define S5P_CLK_DIV1_PCLKD1_MASK		(0x7<<16)
> +#define S5P_CLK_DIV1_PCLKD1_SHIFT	(16)
> +#define S5P_CLK_DIV1_CAM_MASK		(0x1F<<24)
> +#define S5P_CLK_DIV1_CAM_SHIFT		(24)
> 
>  /* CLKDIV2 => removed in clksrc update */
>  /* CLKDIV3 => removed in clksrc update, or not needed */
>  /* CLKDIV4 => removed in clksrc update, or not needed */
> 
>  /* HCLKD0/PCLKD0 Clock Gate 0 Registers */
> -#define S5PC100_CLKGATE_D00_INTC		(1<<0)
> -#define S5PC100_CLKGATE_D00_TZIC		(1<<1)
> -#define S5PC100_CLKGATE_D00_CFCON		(1<<2)
> -#define S5PC100_CLKGATE_D00_MDMA		(1<<3)
> -#define S5PC100_CLKGATE_D00_G2D		(1<<4)
> -#define S5PC100_CLKGATE_D00_SECSS		(1<<5)
> -#define S5PC100_CLKGATE_D00_CSSYS		(1<<6)
> +#define S5P_CLKGATE_D00_INTC		(1<<0)
> +#define S5P_CLKGATE_D00_TZIC		(1<<1)
> +#define S5P_CLKGATE_D00_CFCON		(1<<2)
> +#define S5P_CLKGATE_D00_MDMA		(1<<3)
> +#define S5P_CLKGATE_D00_G2D		(1<<4)
> +#define S5P_CLKGATE_D00_SECSS		(1<<5)
> +#define S5P_CLKGATE_D00_CSSYS		(1<<6)
> 
>  /* HCLKD0/PCLKD0 Clock Gate 1 Registers */
> -#define S5PC100_CLKGATE_D01_DMC		(1<<0)
> -#define S5PC100_CLKGATE_D01_SROMC		(1<<1)
> -#define S5PC100_CLKGATE_D01_ONENAND		(1<<2)
> -#define S5PC100_CLKGATE_D01_NFCON		(1<<3)
> -#define S5PC100_CLKGATE_D01_INTMEM		(1<<4)
> -#define S5PC100_CLKGATE_D01_EBI		(1<<5)
> +#define S5P_CLKGATE_D01_DMC		(1<<0)
> +#define S5P_CLKGATE_D01_SROMC		(1<<1)
> +#define S5P_CLKGATE_D01_ONENAND		(1<<2)
> +#define S5P_CLKGATE_D01_NFCON		(1<<3)
> +#define S5P_CLKGATE_D01_INTMEM		(1<<4)
> +#define S5P_CLKGATE_D01_EBI		(1<<5)
> 
>  /* PCLKD0 Clock Gate 2 Registers */
> -#define S5PC100_CLKGATE_D02_SECKEY		(1<<1)
> -#define S5PC100_CLKGATE_D02_SDM		(1<<2)
> +#define S5P_CLKGATE_D02_SECKEY		(1<<1)
> +#define S5P_CLKGATE_D02_SDM		(1<<2)
> 
>  /* HCLKD1/PCLKD1 Clock Gate 0 Registers */
> -#define S5PC100_CLKGATE_D10_PDMA0		(1<<0)
> -#define S5PC100_CLKGATE_D10_PDMA1		(1<<1)
> -#define S5PC100_CLKGATE_D10_USBHOST		(1<<2)
> -#define S5PC100_CLKGATE_D10_USBOTG		(1<<3)
> -#define S5PC100_CLKGATE_D10_MODEMIF		(1<<4)
> -#define S5PC100_CLKGATE_D10_HSMMC0		(1<<5)
> -#define S5PC100_CLKGATE_D10_HSMMC1		(1<<6)
> -#define S5PC100_CLKGATE_D10_HSMMC2		(1<<7)
> +#define S5P_CLKGATE_D10_PDMA0		(1<<0)
> +#define S5P_CLKGATE_D10_PDMA1		(1<<1)
> +#define S5P_CLKGATE_D10_USBHOST		(1<<2)
> +#define S5P_CLKGATE_D10_USBOTG		(1<<3)
> +#define S5P_CLKGATE_D10_MODEMIF		(1<<4)
> +#define S5P_CLKGATE_D10_HSMMC0		(1<<5)
> +#define S5P_CLKGATE_D10_HSMMC1		(1<<6)
> +#define S5P_CLKGATE_D10_HSMMC2		(1<<7)
> 
>  /* HCLKD1/PCLKD1 Clock Gate 1 Registers */
> -#define S5PC100_CLKGATE_D11_LCD		(1<<0)
> -#define S5PC100_CLKGATE_D11_ROTATOR		(1<<1)
> -#define S5PC100_CLKGATE_D11_FIMC0		(1<<2)
> -#define S5PC100_CLKGATE_D11_FIMC1		(1<<3)
> -#define S5PC100_CLKGATE_D11_FIMC2		(1<<4)
> -#define S5PC100_CLKGATE_D11_JPEG		(1<<5)
> -#define S5PC100_CLKGATE_D11_DSI		(1<<6)
> -#define S5PC100_CLKGATE_D11_CSI		(1<<7)
> -#define S5PC100_CLKGATE_D11_G3D		(1<<8)
> +#define S5P_CLKGATE_D11_LCD		(1<<0)
> +#define S5P_CLKGATE_D11_ROTATOR		(1<<1)
> +#define S5P_CLKGATE_D11_FIMC0		(1<<2)
> +#define S5P_CLKGATE_D11_FIMC1		(1<<3)
> +#define S5P_CLKGATE_D11_FIMC2		(1<<4)
> +#define S5P_CLKGATE_D11_JPEG		(1<<5)
> +#define S5P_CLKGATE_D11_DSI		(1<<6)
> +#define S5P_CLKGATE_D11_CSI		(1<<7)
> +#define S5P_CLKGATE_D11_G3D		(1<<8)
> 
>  /* HCLKD1/PCLKD1 Clock Gate 2 Registers */
> -#define S5PC100_CLKGATE_D12_TV		(1<<0)
> -#define S5PC100_CLKGATE_D12_VP		(1<<1)
> -#define S5PC100_CLKGATE_D12_MIXER		(1<<2)
> -#define S5PC100_CLKGATE_D12_HDMI		(1<<3)
> -#define S5PC100_CLKGATE_D12_MFC		(1<<4)
> +#define S5P_CLKGATE_D12_TV		(1<<0)
> +#define S5P_CLKGATE_D12_VP		(1<<1)
> +#define S5P_CLKGATE_D12_MIXER		(1<<2)
> +#define S5P_CLKGATE_D12_HDMI		(1<<3)
> +#define S5P_CLKGATE_D12_MFC		(1<<4)
> 
>  /* HCLKD1/PCLKD1 Clock Gate 3 Registers */
> -#define S5PC100_CLKGATE_D13_CHIPID		(1<<0)
> -#define S5PC100_CLKGATE_D13_GPIO		(1<<1)
> -#define S5PC100_CLKGATE_D13_APC		(1<<2)
> -#define S5PC100_CLKGATE_D13_IEC		(1<<3)
> -#define S5PC100_CLKGATE_D13_PWM		(1<<6)
> -#define S5PC100_CLKGATE_D13_SYSTIMER	(1<<7)
> -#define S5PC100_CLKGATE_D13_WDT		(1<<8)
> -#define S5PC100_CLKGATE_D13_RTC		(1<<9)
> +#define S5P_CLKGATE_D13_CHIPID		(1<<0)
> +#define S5P_CLKGATE_D13_GPIO		(1<<1)
> +#define S5P_CLKGATE_D13_APC		(1<<2)
> +#define S5P_CLKGATE_D13_IEC		(1<<3)
> +#define S5P_CLKGATE_D13_PWM		(1<<6)
> +#define S5P_CLKGATE_D13_SYSTIMER	(1<<7)
> +#define S5P_CLKGATE_D13_WDT		(1<<8)
> +#define S5P_CLKGATE_D13_RTC		(1<<9)
> 
>  /* HCLKD1/PCLKD1 Clock Gate 4 Registers */
> -#define S5PC100_CLKGATE_D14_UART0		(1<<0)
> -#define S5PC100_CLKGATE_D14_UART1		(1<<1)
> -#define S5PC100_CLKGATE_D14_UART2		(1<<2)
> -#define S5PC100_CLKGATE_D14_UART3		(1<<3)
> -#define S5PC100_CLKGATE_D14_IIC		(1<<4)
> -#define S5PC100_CLKGATE_D14_HDMI_IIC	(1<<5)
> -#define S5PC100_CLKGATE_D14_SPI0		(1<<6)
> -#define S5PC100_CLKGATE_D14_SPI1		(1<<7)
> -#define S5PC100_CLKGATE_D14_SPI2		(1<<8)
> -#define S5PC100_CLKGATE_D14_IRDA		(1<<9)
> -#define S5PC100_CLKGATE_D14_CCAN0		(1<<10)
> -#define S5PC100_CLKGATE_D14_CCAN1		(1<<11)
> -#define S5PC100_CLKGATE_D14_HSITX		(1<<12)
> -#define S5PC100_CLKGATE_D14_HSIRX		(1<<13)
> +#define S5P_CLKGATE_D14_UART0		(1<<0)
> +#define S5P_CLKGATE_D14_UART1		(1<<1)
> +#define S5P_CLKGATE_D14_UART2		(1<<2)
> +#define S5P_CLKGATE_D14_UART3		(1<<3)
> +#define S5P_CLKGATE_D14_IIC		(1<<4)
> +#define S5P_CLKGATE_D14_HDMI_IIC	(1<<5)
> +#define S5P_CLKGATE_D14_SPI0		(1<<6)
> +#define S5P_CLKGATE_D14_SPI1		(1<<7)
> +#define S5P_CLKGATE_D14_SPI2		(1<<8)
> +#define S5P_CLKGATE_D14_IRDA		(1<<9)
> +#define S5P_CLKGATE_D14_CCAN0		(1<<10)
> +#define S5P_CLKGATE_D14_CCAN1		(1<<11)
> +#define S5P_CLKGATE_D14_HSITX		(1<<12)
> +#define S5P_CLKGATE_D14_HSIRX		(1<<13)
> 
>  /* HCLKD1/PCLKD1 Clock Gate 5 Registers */
> -#define S5PC100_CLKGATE_D15_IIS0		(1<<0)
> -#define S5PC100_CLKGATE_D15_IIS1		(1<<1)
> -#define S5PC100_CLKGATE_D15_IIS2		(1<<2)
> -#define S5PC100_CLKGATE_D15_AC97		(1<<3)
> -#define S5PC100_CLKGATE_D15_PCM0		(1<<4)
> -#define S5PC100_CLKGATE_D15_PCM1		(1<<5)
> -#define S5PC100_CLKGATE_D15_SPDIF		(1<<6)
> -#define S5PC100_CLKGATE_D15_TSADC		(1<<7)
> -#define S5PC100_CLKGATE_D15_KEYIF		(1<<8)
> -#define S5PC100_CLKGATE_D15_CG		(1<<9)
> +#define S5P_CLKGATE_D15_IIS0		(1<<0)
> +#define S5P_CLKGATE_D15_IIS1		(1<<1)
> +#define S5P_CLKGATE_D15_IIS2		(1<<2)
> +#define S5P_CLKGATE_D15_AC97		(1<<3)
> +#define S5P_CLKGATE_D15_PCM0		(1<<4)
> +#define S5P_CLKGATE_D15_PCM1		(1<<5)
> +#define S5P_CLKGATE_D15_SPDIF		(1<<6)
> +#define S5P_CLKGATE_D15_TSADC		(1<<7)
> +#define S5P_CLKGATE_D15_KEYIF		(1<<8)
> +#define S5P_CLKGATE_D15_CG		(1<<9)
> 
>  /* HCLKD2 Clock Gate 0 Registers */
> -#define S5PC100_CLKGATE_D20_HCLKD2		(1<<0)
> -#define S5PC100_CLKGATE_D20_I2SD2		(1<<1)
> +#define S5P_CLKGATE_D20_HCLKD2		(1<<0)
> +#define S5P_CLKGATE_D20_I2SD2		(1<<1)
> 
>  /* Special Clock Gate 0 Registers */
> -#define	S5PC100_CLKGATE_SCLK0_HPM		(1<<0)
> -#define	S5PC100_CLKGATE_SCLK0_PWI		(1<<1)
> -#define	S5PC100_CLKGATE_SCLK0_ONENAND	(1<<2)
> -#define	S5PC100_CLKGATE_SCLK0_UART		(1<<3)
> -#define	S5PC100_CLKGATE_SCLK0_SPI0		(1<<4)
> -#define	S5PC100_CLKGATE_SCLK0_SPI1		(1<<5)
> -#define	S5PC100_CLKGATE_SCLK0_SPI2		(1<<6)
> -#define	S5PC100_CLKGATE_SCLK0_SPI0_48	(1<<7)
> -#define	S5PC100_CLKGATE_SCLK0_SPI1_48	(1<<8)
> -#define	S5PC100_CLKGATE_SCLK0_SPI2_48	(1<<9)
> -#define	S5PC100_CLKGATE_SCLK0_IRDA		(1<<10)
> -#define	S5PC100_CLKGATE_SCLK0_USBHOST	(1<<11)
> -#define	S5PC100_CLKGATE_SCLK0_MMC0		(1<<12)
> -#define	S5PC100_CLKGATE_SCLK0_MMC1		(1<<13)
> -#define	S5PC100_CLKGATE_SCLK0_MMC2		(1<<14)
> -#define	S5PC100_CLKGATE_SCLK0_MMC0_48	(1<<15)
> -#define	S5PC100_CLKGATE_SCLK0_MMC1_48	(1<<16)
> -#define	S5PC100_CLKGATE_SCLK0_MMC2_48	(1<<17)
> +#define	S5P_CLKGATE_SCLK0_HPM		(1<<0)
> +#define	S5P_CLKGATE_SCLK0_PWI		(1<<1)
> +#define	S5P_CLKGATE_SCLK0_ONENAND	(1<<2)
> +#define	S5P_CLKGATE_SCLK0_UART		(1<<3)
> +#define	S5P_CLKGATE_SCLK0_SPI0		(1<<4)
> +#define	S5P_CLKGATE_SCLK0_SPI1		(1<<5)
> +#define	S5P_CLKGATE_SCLK0_SPI2		(1<<6)
> +#define	S5P_CLKGATE_SCLK0_SPI0_48	(1<<7)
> +#define	S5P_CLKGATE_SCLK0_SPI1_48	(1<<8)
> +#define	S5P_CLKGATE_SCLK0_SPI2_48	(1<<9)
> +#define	S5P_CLKGATE_SCLK0_IRDA		(1<<10)
> +#define	S5P_CLKGATE_SCLK0_USBHOST	(1<<11)
> +#define	S5P_CLKGATE_SCLK0_MMC0		(1<<12)
> +#define	S5P_CLKGATE_SCLK0_MMC1		(1<<13)
> +#define	S5P_CLKGATE_SCLK0_MMC2		(1<<14)
> +#define	S5P_CLKGATE_SCLK0_MMC0_48	(1<<15)
> +#define	S5P_CLKGATE_SCLK0_MMC1_48	(1<<16)
> +#define	S5P_CLKGATE_SCLK0_MMC2_48	(1<<17)

Please use space bar equally with the other instead of tab.

> 
>  /* Special Clock Gate 1 Registers */
> -#define	S5PC100_CLKGATE_SCLK1_LCD		(1<<0)
> -#define	S5PC100_CLKGATE_SCLK1_FIMC0		(1<<1)
> -#define	S5PC100_CLKGATE_SCLK1_FIMC1		(1<<2)
> -#define	S5PC100_CLKGATE_SCLK1_FIMC2		(1<<3)
> -#define	S5PC100_CLKGATE_SCLK1_TV54		(1<<4)
> -#define	S5PC100_CLKGATE_SCLK1_VDAC54	(1<<5)
> -#define	S5PC100_CLKGATE_SCLK1_MIXER		(1<<6)
> -#define	S5PC100_CLKGATE_SCLK1_HDMI		(1<<7)
> -#define	S5PC100_CLKGATE_SCLK1_AUDIO0	(1<<8)
> -#define	S5PC100_CLKGATE_SCLK1_AUDIO1	(1<<9)
> -#define	S5PC100_CLKGATE_SCLK1_AUDIO2	(1<<10)
> -#define	S5PC100_CLKGATE_SCLK1_SPDIF		(1<<11)
> -#define	S5PC100_CLKGATE_SCLK1_CAM		(1<<12)
> -
> -#define S5PC100_SWRESET		S5PC100_CLKREG_OTHER(0x000)
> -#define S5PC100_OND_SWRESET	S5PC100_CLKREG_OTHER(0x008)
> -#define S5PC100_GEN_CTRL	S5PC100_CLKREG_OTHER(0x100)
> -#define S5PC100_GEN_STATUS	S5PC100_CLKREG_OTHER(0x104)
> -#define S5PC100_MEM_SYS_CFG	S5PC100_CLKREG_OTHER(0x200)
> -#define S5PC100_CAM_MUX_SEL	S5PC100_CLKREG_OTHER(0x300)
> -#define S5PC100_MIXER_OUT_SEL	S5PC100_CLKREG_OTHER(0x304)
> -#define S5PC100_LPMP_MODE_SEL	S5PC100_CLKREG_OTHER(0x308)
> -#define S5PC100_MIPI_PHY_CON0	S5PC100_CLKREG_OTHER(0x400)
> -#define S5PC100_MIPI_PHY_CON1	S5PC100_CLKREG_OTHER(0x414)
> -#define S5PC100_HDMI_PHY_CON0	S5PC100_CLKREG_OTHER(0x420)
> -
> -#define S5PC100_SWRESET_RESETVAL	0xc100
> -#define S5PC100_OTHER_SYS_INT	24
> -#define S5PC100_OTHER_STA_TYPE	23
> +#define	S5P_CLKGATE_SCLK1_LCD		(1<<0)
> +#define	S5P_CLKGATE_SCLK1_FIMC0		(1<<1)
> +#define	S5P_CLKGATE_SCLK1_FIMC1		(1<<2)
> +#define	S5P_CLKGATE_SCLK1_FIMC2		(1<<3)
> +#define	S5P_CLKGATE_SCLK1_TV54		(1<<4)
> +#define	S5P_CLKGATE_SCLK1_VDAC54	(1<<5)
> +#define	S5P_CLKGATE_SCLK1_MIXER		(1<<6)
> +#define	S5P_CLKGATE_SCLK1_HDMI		(1<<7)
> +#define	S5P_CLKGATE_SCLK1_AUDIO0	(1<<8)
> +#define	S5P_CLKGATE_SCLK1_AUDIO1	(1<<9)
> +#define	S5P_CLKGATE_SCLK1_AUDIO2	(1<<10)
> +#define	S5P_CLKGATE_SCLK1_SPDIF		(1<<11)
> +#define	S5P_CLKGATE_SCLK1_CAM		(1<<12)

Same.

And, if you use directly above value in the ctrlbit, don't need more above
definitions.

> +
> +#define S5P_SWRESET		S5PC100_REG_OTHERS(0x000)
> +#define S5P_OND_SWRESET		S5PC100_REG_OTHERS(0x008)
> +#define S5P_GEN_CTRL		S5PC100_REG_OTHERS(0x100)
> +#define S5P_GEN_STATUS		S5PC100_REG_OTHERS(0x104)
> +#define S5P_MEM_SYS_CFG		S5PC100_REG_OTHERS(0x200)
> +#define S5P_CAM_MUX_SEL		S5PC100_REG_OTHERS(0x300)
> +#define S5P_MIXER_OUT_SEL	S5PC100_REG_OTHERS(0x304)
> +#define S5P_LPMP_MODE_SEL	S5PC100_REG_OTHERS(0x308)
> +#define S5P_MIPI_PHY_CON0	S5PC100_REG_OTHERS(0x400)
> +#define S5P_MIPI_PHY_CON1	S5PC100_REG_OTHERS(0x414)
> +#define S5P_HDMI_PHY_CON0	S5PC100_REG_OTHERS(0x420)
> +
> +#define S5P_SWRESET_RESETVAL	0xc100
> +#define S5P_OTHER_SYS_INT	24
> +#define S5P_OTHER_STA_TYPE	23
>  #define STA_TYPE_EXPON		0
>  #define STA_TYPE_SFR		1
> 
> -#define S5PC100_SLEEP_CFG_OSC_EN	0
> +#define S5P_SLEEP_CFG_OSC_EN	0

Please check whether need above definitions or not.

> 
>  /* OTHERS Resgister */
> -#define S5PC100_OTHERS_USB_SIG_MASK	(1 << 16)
> -#define S5PC100_OTHERS_MIPI_DPHY_EN		(1 << 28)
> +#define S5P_OTHERS_USB_SIG_MASK	(1 << 16)
> +#define S5P_OTHERS_MIPI_DPHY_EN		(1 << 28)
> 
>  /* MIPI D-PHY Control Register 0 */
> -#define S5PC100_MIPI_PHY_CON0_M_RESETN	(1 << 1)
> -#define S5PC100_MIPI_PHY_CON0_S_RESETN	(1 << 0)
> +#define S5P_MIPI_PHY_CON0_M_RESETN	(1 << 1)
> +#define S5P_MIPI_PHY_CON0_S_RESETN	(1 << 0)
> 
>  #endif /* _PLAT_REGS_CLOCK_H */

In your 4th and 5th patch, above file will be moved to mach directory. So how
about change to __ASM_ARCH_REGS_CLOCK_H from _PLAT...

> diff --git a/arch/arm/plat-s5pc1xx/s5pc100-clock.c
b/arch/arm/plat-s5pc1xx/s5pc100-
> clock.c
> index 2bf6c57..c391c61 100644
> --- a/arch/arm/plat-s5pc1xx/s5pc100-clock.c
> +++ b/arch/arm/plat-s5pc1xx/s5pc100-clock.c
> @@ -75,7 +75,7 @@ static struct clksrc_clk clk_mout_apll = {
>  		.id		= -1,
>  	},
>  	.sources	= &clk_src_apll,
> -	.reg_src = { .reg = S5PC100_CLKSRC0, .shift = 0, .size = 1, },
> +	.reg_src = { .reg = S5P_CLK_SRC0, .shift = 0, .size = 1, },
>  };
> 
>  static unsigned long s5pc100_clk_dout_apll_get_rate(struct clk *clk)
> @@ -83,8 +83,8 @@ static unsigned long
s5pc100_clk_dout_apll_get_rate(struct
> clk *clk)
>  	unsigned long rate = clk_get_rate(clk->parent);
>  	unsigned int ratio;
> 
> -	ratio = __raw_readl(S5PC100_CLKDIV0) &
> S5PC100_CLKDIV0_APLL_MASK;
> -	ratio >>= S5PC100_CLKDIV0_APLL_SHIFT;
> +	ratio = __raw_readl(S5P_CLK_DIV0) & S5P_CLK_DIV0_APLL_MASK;
> +	ratio >>= S5P_CLK_DIV0_APLL_SHIFT;
> 
>  	return rate / (ratio + 1);
>  }
> @@ -103,8 +103,8 @@ static unsigned long s5pc100_clk_arm_get_rate(struct
clk
> *clk)
>  	unsigned long rate = clk_get_rate(clk->parent);
>  	unsigned int ratio;
> 
> -	ratio = __raw_readl(S5PC100_CLKDIV0) &
> S5PC100_CLKDIV0_ARM_MASK;
> -	ratio >>= S5PC100_CLKDIV0_ARM_SHIFT;
> +	ratio = __raw_readl(S5P_CLK_DIV0) & S5P_CLK_DIV0_ARM_MASK;
> +	ratio >>= S5P_CLK_DIV0_ARM_SHIFT;
> 
>  	return rate / (ratio + 1);
>  }
> @@ -119,8 +119,8 @@ static unsigned long s5pc100_clk_arm_round_rate(struct
clk
> *clk,
>  		return rate;
> 
>  	div = (parent / rate) - 1;
> -	if (div > S5PC100_CLKDIV0_ARM_MASK)
> -		div = S5PC100_CLKDIV0_ARM_MASK;
> +	if (div > S5P_CLK_DIV0_ARM_MASK)
> +		div = S5P_CLK_DIV0_ARM_MASK;
> 
>  	return parent / (div + 1);
>  }
> @@ -131,16 +131,16 @@ static int s5pc100_clk_arm_set_rate(struct clk *clk,
> unsigned long rate)
>  	u32 div;
>  	u32 val;
> 
> -	if (rate < parent / (S5PC100_CLKDIV0_ARM_MASK + 1))
> +	if (rate < parent / (S5P_CLK_DIV0_ARM_MASK + 1))
>  		return -EINVAL;
> 
>  	rate = clk_round_rate(clk, rate);
>  	div = clk_get_rate(clk->parent) / rate;
> 
> -	val = __raw_readl(S5PC100_CLKDIV0);
> -	val &= S5PC100_CLKDIV0_ARM_MASK;
> +	val = __raw_readl(S5P_CLK_DIV0);
> +	val &= S5P_CLK_DIV0_ARM_MASK;
>  	val |= (div - 1);
> -	__raw_writel(val, S5PC100_CLKDIV0);
> +	__raw_writel(val, S5P_CLK_DIV0);
> 
>  	return 0;
>  }
> @@ -161,8 +161,8 @@ static unsigned long
> s5pc100_clk_dout_d0_bus_get_rate(struct clk *clk)
>  	unsigned long rate = clk_get_rate(clk->parent);
>  	unsigned int ratio;
> 
> -	ratio = __raw_readl(S5PC100_CLKDIV0) & S5PC100_CLKDIV0_D0_MASK;
> -	ratio >>= S5PC100_CLKDIV0_D0_SHIFT;
> +	ratio = __raw_readl(S5P_CLK_DIV0) & S5P_CLK_DIV0_D0_MASK;
> +	ratio >>= S5P_CLK_DIV0_D0_SHIFT;
> 
>  	return rate / (ratio + 1);
>  }
> @@ -181,8 +181,8 @@ static unsigned long
> s5pc100_clk_dout_pclkd0_get_rate(struct clk *clk)
>  	unsigned long rate = clk_get_rate(clk->parent);
>  	unsigned int ratio;
> 
> -	ratio = __raw_readl(S5PC100_CLKDIV0) &
> S5PC100_CLKDIV0_PCLKD0_MASK;
> -	ratio >>= S5PC100_CLKDIV0_PCLKD0_SHIFT;
> +	ratio = __raw_readl(S5P_CLK_DIV0) & S5P_CLK_DIV0_PCLKD0_MASK;
> +	ratio >>= S5P_CLK_DIV0_PCLKD0_SHIFT;
> 
>  	return rate / (ratio + 1);
>  }
> @@ -201,8 +201,8 @@ static unsigned long
> s5pc100_clk_dout_apll2_get_rate(struct clk *clk)
>  	unsigned long rate = clk_get_rate(clk->parent);
>  	unsigned int ratio;
> 
> -	ratio = __raw_readl(S5PC100_CLKDIV1) &
> S5PC100_CLKDIV1_APLL2_MASK;
> -	ratio >>= S5PC100_CLKDIV1_APLL2_SHIFT;
> +	ratio = __raw_readl(S5P_CLK_DIV1) & S5P_CLK_DIV1_APLL2_MASK;
> +	ratio >>= S5P_CLK_DIV1_APLL2_SHIFT;
> 
>  	return rate / (ratio + 1);
>  }
> @@ -233,7 +233,7 @@ static struct clksrc_clk clk_mout_mpll = {
>  		.id		= -1,
>  	},
>  	.sources	= &clk_src_mpll,
> -	.reg_src = { .reg = S5PC100_CLKSRC0, .shift = 4, .size = 1, },
> +	.reg_src = { .reg = S5P_CLK_SRC0, .shift = 4, .size = 1, },
>  };
> 
>  static struct clk *clkset_am_list[] = {
> @@ -252,7 +252,7 @@ static struct clksrc_clk clk_mout_am = {
>  		.id		= -1,
>  	},
>  	.sources	= &clk_src_am,
> -	.reg_src = { .reg = S5PC100_CLKSRC0, .shift = 16, .size = 1, },
> +	.reg_src = { .reg = S5P_CLK_SRC0, .shift = 16, .size = 1, },
>  };
> 
>  static unsigned long s5pc100_clk_dout_d1_bus_get_rate(struct clk *clk)
> @@ -262,8 +262,8 @@ static unsigned long
> s5pc100_clk_dout_d1_bus_get_rate(struct clk *clk)
> 
>  	printk(KERN_DEBUG "%s: parent is %ld\n", __func__, rate);
> 
> -	ratio = __raw_readl(S5PC100_CLKDIV1) & S5PC100_CLKDIV1_D1_MASK;
> -	ratio >>= S5PC100_CLKDIV1_D1_SHIFT;
> +	ratio = __raw_readl(S5P_CLK_DIV1) & S5P_CLK_DIV1_D1_MASK;
> +	ratio >>= S5P_CLK_DIV1_D1_SHIFT;
> 
>  	return rate / (ratio + 1);
>  }
> @@ -293,7 +293,7 @@ static struct clksrc_clk clk_mout_onenand = {
>  		.id		= -1,
>  	},
>  	.sources	= &clk_src_onenand,
> -	.reg_src = { .reg = S5PC100_CLKSRC0, .shift = 24, .size = 1, },
> +	.reg_src = { .reg = S5P_CLK_SRC0, .shift = 24, .size = 1, },
>  };
> 
>  static unsigned long s5pc100_clk_dout_pclkd1_get_rate(struct clk *clk)
> @@ -303,8 +303,8 @@ static unsigned long
> s5pc100_clk_dout_pclkd1_get_rate(struct clk *clk)
> 
>  	printk(KERN_DEBUG "%s: parent is %ld\n", __func__, rate);
> 
> -	ratio = __raw_readl(S5PC100_CLKDIV1) &
> S5PC100_CLKDIV1_PCLKD1_MASK;
> -	ratio >>= S5PC100_CLKDIV1_PCLKD1_SHIFT;
> +	ratio = __raw_readl(S5P_CLK_DIV1) & S5P_CLK_DIV1_PCLKD1_MASK;
> +	ratio >>= S5P_CLK_DIV1_PCLKD1_SHIFT;
> 
>  	return rate / (ratio + 1);
>  }
> @@ -325,8 +325,8 @@ static unsigned long
> s5pc100_clk_dout_mpll2_get_rate(struct clk *clk)
> 
>  	printk(KERN_DEBUG "%s: parent is %ld\n", __func__, rate);
> 
> -	ratio = __raw_readl(S5PC100_CLKDIV1) &
> S5PC100_CLKDIV1_MPLL2_MASK;
> -	ratio >>= S5PC100_CLKDIV1_MPLL2_SHIFT;
> +	ratio = __raw_readl(S5P_CLK_DIV1) & S5P_CLK_DIV1_MPLL2_MASK;
> +	ratio >>= S5P_CLK_DIV1_MPLL2_SHIFT;
> 
>  	return rate / (ratio + 1);
>  }
> @@ -347,8 +347,8 @@ static unsigned long
s5pc100_clk_dout_cam_get_rate(struct
> clk *clk)
> 
>  	printk(KERN_DEBUG "%s: parent is %ld\n", __func__, rate);
> 
> -	ratio = __raw_readl(S5PC100_CLKDIV1) &
> S5PC100_CLKDIV1_CAM_MASK;
> -	ratio >>= S5PC100_CLKDIV1_CAM_SHIFT;
> +	ratio = __raw_readl(S5P_CLK_DIV1) & S5P_CLK_DIV1_CAM_MASK;
> +	ratio >>= S5P_CLK_DIV1_CAM_SHIFT;
> 
>  	return rate / (ratio + 1);
>  }
> @@ -369,8 +369,8 @@ static unsigned long
s5pc100_clk_dout_mpll_get_rate(struct
> clk *clk)
> 
>  	printk(KERN_DEBUG "%s: parent is %ld\n", __func__, rate);
> 
> -	ratio = __raw_readl(S5PC100_CLKDIV1) &
> S5PC100_CLKDIV1_MPLL_MASK;
> -	ratio >>= S5PC100_CLKDIV1_MPLL_SHIFT;
> +	ratio = __raw_readl(S5P_CLK_DIV1) & S5P_CLK_DIV1_MPLL_MASK;
> +	ratio >>= S5P_CLK_DIV1_MPLL_SHIFT;
> 
>  	return rate / (ratio + 1);
>  }
> @@ -406,7 +406,7 @@ static struct clksrc_clk clk_mout_epll = {
>  		.id		= -1,
>  	},
>  	.sources = &clk_src_epll,
> -	.reg_src = { .reg = S5PC100_CLKSRC0, .shift = 8, .size = 1, },
> +	.reg_src = { .reg = S5P_CLK_SRC0, .shift = 8, .size = 1, },
>  };
> 
>  /* HPLL */
> @@ -431,7 +431,7 @@ static struct clksrc_clk clk_mout_hpll = {
>  		.id		= -1,
>  	},
>  	.sources = &clk_src_hpll,
> -	.reg_src = { .reg = S5PC100_CLKSRC0, .shift = 12, .size = 1, },
> +	.reg_src = { .reg = S5P_CLK_SRC0, .shift = 12, .size = 1, },
>  };
> 
>  /* Peripherals */
> @@ -539,32 +539,32 @@ static struct clksrc_clk clksrc_audio[] = {
>  		.clk	= {
>  			.name		= "audio-bus",
>  			.id		= 0,
> -			.ctrlbit	= S5PC100_CLKGATE_SCLK1_AUDIO0,
> +			.ctrlbit	= S5P_CLKGATE_SCLK1_AUDIO0,
>  			.enable		= s5pc100_sclk1_ctrl,
>  		},
>  		.sources = &clkset_audio0,
> -		.reg_div = { .reg = S5PC100_CLKDIV4, .shift = 12, .size = 4,
},
> -		.reg_src = { .reg = S5PC100_CLKSRC3, .shift = 12, .size = 3,
},
> +		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 12, .size = 4, },
> +		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 12, .size = 3, },
>  	}, {
>  		.clk	= {
>  			.name		= "audio-bus",
>  			.id		= 1,
> -			.ctrlbit	= S5PC100_CLKGATE_SCLK1_AUDIO1,
> +			.ctrlbit	= S5P_CLKGATE_SCLK1_AUDIO1,
>  			.enable		= s5pc100_sclk1_ctrl,
>  		},
>  		.sources = &clkset_audio1,
> -		.reg_div = { .reg = S5PC100_CLKDIV4, .shift = 16, .size = 4,
},
> -		.reg_src = { .reg = S5PC100_CLKSRC3, .shift = 16, .size = 3,
},
> +		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 16, .size = 4, },
> +		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 16, .size = 3, },
>  	}, {
>  		.clk	= {
>  			.name		= "audio-bus",
>  			.id		= 2,
> -			.ctrlbit	= S5PC100_CLKGATE_SCLK1_AUDIO2,
> +			.ctrlbit	= S5P_CLKGATE_SCLK1_AUDIO2,
>  			.enable		= s5pc100_sclk1_ctrl,
>  		},
>  		.sources = &clkset_audio2,
> -		.reg_div = { .reg = S5PC100_CLKDIV4, .shift = 20, .size = 4,
},
> -		.reg_src = { .reg = S5PC100_CLKSRC3, .shift = 20, .size = 3,
},
> +		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 20, .size = 4, },
> +		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 20, .size = 3, },
>  	},
>  };
> 
> @@ -620,130 +620,130 @@ static struct clksrc_clk clksrc_clks[] = {
>  		.clk	= {
>  			.name		= "spi_bus",
>  			.id		= 0,
> -			.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI0,
> +			.ctrlbit	= S5P_CLKGATE_SCLK0_SPI0,
>  			.enable		= s5pc100_sclk0_ctrl,
> 
>  		},
>  		.sources = &clkset_spi,
> -		.reg_div = { .reg = S5PC100_CLKDIV2, .shift = 4, .size = 4,
},
> -		.reg_src = { .reg = S5PC100_CLKSRC1, .shift = 4, .size = 2,
},
> +		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 4, .size = 4, },
> +		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 4, .size = 2, },
>  	}, {
>  		.clk	= {
>  			.name		= "spi_bus",
>  			.id		= 1,
> -			.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI1,
> +			.ctrlbit	= S5P_CLKGATE_SCLK0_SPI1,
>  			.enable		= s5pc100_sclk0_ctrl,
>  		},
>  		.sources = &clkset_spi,
> -		.reg_div = { .reg = S5PC100_CLKDIV2, .shift = 8, .size = 4,
},
> -		.reg_src = { .reg = S5PC100_CLKSRC1, .shift = 8, .size = 2,
},
> +		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 8, .size = 4, },
> +		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 8, .size = 2, },
>  	}, {
>  		.clk	= {
>  			.name		= "spi_bus",
>  			.id		= 2,
> -			.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI2,
> +			.ctrlbit	= S5P_CLKGATE_SCLK0_SPI2,
>  			.enable		= s5pc100_sclk0_ctrl,
>  		},
>  		.sources = &clkset_spi,
> -		.reg_div = { .reg = S5PC100_CLKDIV2, .shift = 12, .size = 4,
},
> -		.reg_src = { .reg = S5PC100_CLKSRC1, .shift = 12, .size = 2,
},
> +		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 12, .size = 4, },
> +		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 12, .size = 2, },
>  	}, {
>  		.clk	= {
>  			.name		= "uclk1",
>  			.id		= -1,
> -			.ctrlbit        = S5PC100_CLKGATE_SCLK0_UART,
> +			.ctrlbit        = S5P_CLKGATE_SCLK0_UART,
>  			.enable		= s5pc100_sclk0_ctrl,
>  		},
>  		.sources = &clkset_uart,
> -		.reg_div = { .reg = S5PC100_CLKDIV2, .shift = 0, .size = 3,
},
> -		.reg_src = { .reg = S5PC100_CLKSRC1, .shift = 0, .size = 1,
},
> +		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 0, .size = 3, },
> +		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 0, .size = 1, },
>  	}, {
>  		.clk	= {
>  			.name		= "spdif",
>  			.id		= -1,
>  		},
>  		.sources	= &clkset_spdif,
> -		.reg_src = { .reg = S5PC100_CLKSRC3, .shift = 24, .size = 2,
},
> +		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 24, .size = 2, },
>  	}, {
>  		.clk	= {
>  			.name		= "lcd",
>  			.id		= -1,
> -			.ctrlbit	= S5PC100_CLKGATE_SCLK1_LCD,
> +			.ctrlbit	= S5P_CLKGATE_SCLK1_LCD,
>  			.enable		= s5pc100_sclk1_ctrl,
>  		},
>  		.sources = &clkset_lcd_fimc,
> -		.reg_div = { .reg = S5PC100_CLKDIV3, .shift = 12, .size = 4,
},
> -		.reg_src = { .reg = S5PC100_CLKSRC2, .shift = 12, .size = 2,
},
> +		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 12, .size = 4, },
> +		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 12, .size = 2, },
>  	}, {
>  		.clk	= {
>  			.name		= "fimc",
>  			.id		= 0,
> -			.ctrlbit	= S5PC100_CLKGATE_SCLK1_FIMC0,
> +			.ctrlbit	= S5P_CLKGATE_SCLK1_FIMC0,
>  			.enable		= s5pc100_sclk1_ctrl,
>  		},
>  		.sources = &clkset_lcd_fimc,
> -		.reg_div = { .reg = S5PC100_CLKDIV3, .shift = 16, .size = 4,
},
> -		.reg_src = { .reg = S5PC100_CLKSRC2, .shift = 16, .size = 2,
},
> +		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 16, .size = 4, },
> +		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 16, .size = 2, },
>  	}, {
>  		.clk	= {
>  			.name		= "fimc",
>  			.id		= 1,
> -			.ctrlbit	= S5PC100_CLKGATE_SCLK1_FIMC1,
> +			.ctrlbit	= S5P_CLKGATE_SCLK1_FIMC1,
>  			.enable		= s5pc100_sclk1_ctrl,
>  		},
>  		.sources	= &clkset_lcd_fimc,
> -		.reg_div = { .reg = S5PC100_CLKDIV3, .shift = 20, .size = 4,
},
> -		.reg_src = { .reg = S5PC100_CLKSRC2, .shift = 20, .size = 2,
},
> +		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 20, .size = 4, },
> +		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 20, .size = 2, },
>  	}, {
>  		.clk	= {
>  			.name		= "fimc",
>  			.id		= 2,
> -			.ctrlbit	= S5PC100_CLKGATE_SCLK1_FIMC2,
> +			.ctrlbit	= S5P_CLKGATE_SCLK1_FIMC2,
>  			.enable		= s5pc100_sclk1_ctrl,
>  		},
>  		.sources = &clkset_lcd_fimc,
> -		.reg_div = { .reg = S5PC100_CLKDIV3, .shift = 24, .size = 4,
},
> -		.reg_src = { .reg = S5PC100_CLKSRC2, .shift = 24, .size = 2,
},
> +		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 24, .size = 4, },
> +		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 24, .size = 2, },
>  	}, {
>  		.clk	= {
>  			.name		= "mmc_bus",
>  			.id		= 0,
> -			.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC0,
> +			.ctrlbit	= S5P_CLKGATE_SCLK0_MMC0,
>  			.enable		= s5pc100_sclk0_ctrl,
>  		},
>  		.sources = &clkset_mmc,
> -		.reg_div = { .reg = S5PC100_CLKDIV3, .shift = 0, .size = 4,
},
> -		.reg_src = { .reg = S5PC100_CLKSRC2, .shift = 0, .size = 2,
},
> +		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 0, .size = 4, },
> +		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 0, .size = 2, },
>  	}, {
>  		.clk	= {
>  			.name		= "mmc_bus",
>  			.id		= 1,
> -			.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC1,
> +			.ctrlbit	= S5P_CLKGATE_SCLK0_MMC1,
>  			.enable		= s5pc100_sclk0_ctrl,
>  		},
>  		.sources = &clkset_mmc,
> -		.reg_div = { .reg = S5PC100_CLKDIV3, .shift = 4, .size = 4,
},
> -		.reg_src = { .reg = S5PC100_CLKSRC2, .shift = 4, .size = 2,
},
> +		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 4, .size = 4, },
> +		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 4, .size = 2, },
>  	}, {
>  		.clk	= {
>  			.name		= "mmc_bus",
>  			.id		= 2,
> -			.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC2,
> +			.ctrlbit	= S5P_CLKGATE_SCLK0_MMC2,
>  			.enable		= s5pc100_sclk0_ctrl,
>  		},
>  		.sources	= &clkset_mmc,
> -		.reg_div = { .reg = S5PC100_CLKDIV3, .shift = 8, .size = 4,
},
> -		.reg_src = { .reg = S5PC100_CLKSRC2, .shift = 8, .size = 2,
},
> +		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 8, .size = 4, },
> +		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 8, .size = 2, },
>  	}, {
>  		.clk	= {
>  			.name		= "usbhost",
>  			.id		= -1,
> -			.ctrlbit        =
> S5PC100_CLKGATE_SCLK0_USBHOST,
> +			.ctrlbit        = S5P_CLKGATE_SCLK0_USBHOST,
>  			.enable		= s5pc100_sclk0_ctrl,
>  		},
>  		.sources = &clkset_usbhost,
> -		.reg_div = { .reg = S5PC100_CLKDIV2, .shift = 20, .size = 4,
},
> -		.reg_src = { .reg = S5PC100_CLKSRC1, .shift = 20, .size = 2,
},
> +		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 20, .size = 4, },
> +		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 20, .size = 2, },
>  	}
>  };
> 
> @@ -775,8 +775,8 @@ void __init_or_cpufreq s5pc100_setup_clocks(void)
> 
>  	printk(KERN_DEBUG "%s: registering clocks\n", __func__);
> 
> -	clkdiv0 = __raw_readl(S5PC100_CLKDIV0);
> -	clkdiv1 = __raw_readl(S5PC100_CLKDIV1);
> +	clkdiv0 = __raw_readl(S5P_CLK_DIV0);
> +	clkdiv1 = __raw_readl(S5P_CLK_DIV1);
> 
>  	printk(KERN_DEBUG "%s: clkdiv0 = %08x, clkdiv1 = %08x\n", __func__,
> clkdiv0, clkdiv1);
> 
> @@ -788,22 +788,22 @@ void __init_or_cpufreq s5pc100_setup_clocks(void)
> 
>  	printk(KERN_DEBUG "%s: xtal is %ld\n", __func__, xtal);
> 
> -	apll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_APLL_CON));
> -	mpll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_MPLL_CON));
> -	epll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_EPLL_CON));
> -	hpll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_HPLL_CON));
> +	apll = s5pc1xx_get_pll(xtal, __raw_readl(S5P_APLL_CON));
> +	mpll = s5pc1xx_get_pll(xtal, __raw_readl(S5P_MPLL_CON));
> +	epll = s5pc1xx_get_pll(xtal, __raw_readl(S5P_EPLL_CON));
> +	hpll = s5pc1xx_get_pll(xtal, __raw_readl(S5P_HPLL_CON));

How about using the s5p_get_pllxxx function instead of s5pc1xx_get_pll.

> 
>  	printk(KERN_INFO "S5PC100: Apll=%ld.%03ld Mhz, Mpll=%ld.%03ld Mhz"
>  		", Epll=%ld.%03ld Mhz, Hpll=%ld.%03ld Mhz\n",
>  		print_mhz(apll), print_mhz(mpll),
>  		print_mhz(epll), print_mhz(hpll));
> 
> -	armclk = apll / GET_DIV(clkdiv0, S5PC100_CLKDIV0_APLL);
> -	armclk = armclk / GET_DIV(clkdiv0, S5PC100_CLKDIV0_ARM);
> -	hclkd0 = armclk / GET_DIV(clkdiv0, S5PC100_CLKDIV0_D0);
> -	pclkd0 = hclkd0 / GET_DIV(clkdiv0, S5PC100_CLKDIV0_PCLKD0);
> -	hclk = mpll / GET_DIV(clkdiv1, S5PC100_CLKDIV1_D1);
> -	pclk = hclk / GET_DIV(clkdiv1, S5PC100_CLKDIV1_PCLKD1);
> +	armclk = apll / GET_DIV(clkdiv0, S5P_CLK_DIV0_APLL);
> +	armclk = armclk / GET_DIV(clkdiv0, S5P_CLK_DIV0_ARM);
> +	hclkd0 = armclk / GET_DIV(clkdiv0, S5P_CLK_DIV0_D0);
> +	pclkd0 = hclkd0 / GET_DIV(clkdiv0, S5P_CLK_DIV0_PCLKD0);
> +	hclk = mpll / GET_DIV(clkdiv1, S5P_CLK_DIV1_D1);
> +	pclk = hclk / GET_DIV(clkdiv1, S5P_CLK_DIV1_PCLKD1);

Is it necessary to change the clk parent points if this happens?

> 
>  	printk(KERN_INFO "S5PC100: ARMCLK=%ld.%03ld MHz,
> HCLKD0=%ld.%03ld MHz,"
>  		" PCLKD0=%ld.%03ld MHz\n, HCLK=%ld.%03ld MHz,"

As you know, the clock scheme has been changed much. Can you re-work for c100
clock?

> --

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
