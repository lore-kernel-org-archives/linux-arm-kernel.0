From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 10 May 2012 18:13:34 +0900
Subject: [PATCH] ARM: Exynos4: add support for GATE BLOCK clocks
In-Reply-To: <1333699250-16420-1-git-send-email-m.szyprowski@samsung.com>
References: <1333699250-16420-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <034c01cd2e8d$2ce8c090$86ba41b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> EXYNOS4_CLKGATE_BLOCK register can be used to disable the respective
> multimedia block hardware planes. It acts similar to the power domains.
> This patch adds transparent support for this method of gating of
> multimedia blocks. New clocks are added as parents to the respective
> block bus clocks. This patch has been tested on NURI and UniversalC210
> boards, which have bootloader which disable all multimedia blocks with
> both GATE BLOCK method and power domains.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/clock-exynos4.c |   54
> ++++++++++++++++++++++++++++++++++
>  1 files changed, 54 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/clock-exynos4.c b/arch/arm/mach-
> exynos/clock-exynos4.c
> index 4287311..a2f8b2e 100644
> --- a/arch/arm/mach-exynos/clock-exynos4.c
> +++ b/arch/arm/mach-exynos/clock-exynos4.c
> @@ -213,6 +213,11 @@ static int exynos4_clk_dac_ctrl(struct clk *clk, int
> enable)
>  	return s5p_gatectrl(S5P_DAC_PHY_CONTROL, clk, enable);
>  }
> 
> +static int exynos4_clk_gate_block_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(EXYNOS4_CLKGATE_BLOCK, clk, enable);
> +}
> +
>  /* Core list of CMU_CPU side */
> 
>  static struct clksrc_clk exynos4_clk_mout_apll = {
> @@ -459,6 +464,37 @@ static struct clksrc_clk exynos4_clk_sclk_vpll = {
>  	.reg_src = { .reg = EXYNOS4_CLKSRC_TOP0, .shift = 8, .size = 1 },
>  };
> 
> +static struct clk exynos4_clk_gate_cam = {
> +	.name		= "cam",
> +	.enable		= exynos4_clk_gate_block_ctrl,
> +	.ctrlbit	= (1 << 0),
> +};
> +
> +static struct clk exynos4_clk_gate_tv = {
> +	.name		= "tv",
> +	.enable		= exynos4_clk_gate_block_ctrl,
> +	.ctrlbit	= (1 << 1),
> +};
> +
> +static struct clk exynos4_clk_gate_mfc = {
> +	.name		= "mfc",
> +	.enable		= exynos4_clk_gate_block_ctrl,
> +	.ctrlbit	= (1 << 2),
> +};
> +
> +static struct clk exynos4_clk_gate_lcd0 = {
> +	.name		= "lcd0",
> +	.enable		= exynos4_clk_gate_block_ctrl,
> +	.ctrlbit	= (1 << 4),
> +};
> +
> +static struct clk *exynos4_gate_clocks[] = {
> +	&exynos4_clk_gate_cam,
> +	&exynos4_clk_gate_tv,
> +	&exynos4_clk_gate_mfc,
> +	&exynos4_clk_gate_lcd0,
> +};
> +
>  static struct clk exynos4_init_clocks_off[] = {
>  	{
>  		.name		= "timers",
> @@ -470,36 +506,43 @@ static struct clk exynos4_init_clocks_off[] = {
>  		.devname	= "s5p-mipi-csis.0",
>  		.enable		= exynos4_clk_ip_cam_ctrl,
>  		.ctrlbit	= (1 << 4),
> +		.parent		= &exynos4_clk_gate_cam,
>  	}, {
>  		.name		= "csis",
>  		.devname	= "s5p-mipi-csis.1",
>  		.enable		= exynos4_clk_ip_cam_ctrl,
>  		.ctrlbit	= (1 << 5),
> +		.parent		= &exynos4_clk_gate_cam,
>  	}, {
>  		.name		= "jpeg",
>  		.id		= 0,
>  		.enable		= exynos4_clk_ip_cam_ctrl,
>  		.ctrlbit	= (1 << 6),
> +		.parent		= &exynos4_clk_gate_cam,
>  	}, {
>  		.name		= "fimc",
>  		.devname	= "exynos4-fimc.0",
>  		.enable		= exynos4_clk_ip_cam_ctrl,
>  		.ctrlbit	= (1 << 0),
> +		.parent		= &exynos4_clk_gate_cam,
>  	}, {
>  		.name		= "fimc",
>  		.devname	= "exynos4-fimc.1",
>  		.enable		= exynos4_clk_ip_cam_ctrl,
>  		.ctrlbit	= (1 << 1),
> +		.parent		= &exynos4_clk_gate_cam,
>  	}, {
>  		.name		= "fimc",
>  		.devname	= "exynos4-fimc.2",
>  		.enable		= exynos4_clk_ip_cam_ctrl,
>  		.ctrlbit	= (1 << 2),
> +		.parent		= &exynos4_clk_gate_cam,
>  	}, {
>  		.name		= "fimc",
>  		.devname	= "exynos4-fimc.3",
>  		.enable		= exynos4_clk_ip_cam_ctrl,
>  		.ctrlbit	= (1 << 3),
> +		.parent		= &exynos4_clk_gate_cam,
>  	}, {
>  		.name		= "hsmmc",
>  		.devname	= "s3c-sdhci.0",
> @@ -534,31 +577,37 @@ static struct clk exynos4_init_clocks_off[] = {
>  		.devname	= "s5p-sdo",
>  		.enable		= exynos4_clk_ip_tv_ctrl,
>  		.ctrlbit	= (1 << 2),
> +		.parent		= &exynos4_clk_gate_tv,
>  	}, {
>  		.name		= "mixer",
>  		.devname	= "s5p-mixer",
>  		.enable		= exynos4_clk_ip_tv_ctrl,
>  		.ctrlbit	= (1 << 1),
> +		.parent		= &exynos4_clk_gate_tv,
>  	}, {
>  		.name		= "vp",
>  		.devname	= "s5p-mixer",
>  		.enable		= exynos4_clk_ip_tv_ctrl,
>  		.ctrlbit	= (1 << 0),
> +		.parent		= &exynos4_clk_gate_tv,
>  	}, {
>  		.name		= "hdmi",
>  		.devname	= "exynos4-hdmi",
>  		.enable		= exynos4_clk_ip_tv_ctrl,
>  		.ctrlbit	= (1 << 3),
> +		.parent		= &exynos4_clk_gate_tv,
>  	}, {
>  		.name		= "hdmiphy",
>  		.devname	= "exynos4-hdmi",
>  		.enable		= exynos4_clk_hdmiphy_ctrl,
>  		.ctrlbit	= (1 << 0),
> +		.parent		= &exynos4_clk_gate_tv,
>  	}, {
>  		.name		= "dacphy",
>  		.devname	= "s5p-sdo",
>  		.enable		= exynos4_clk_dac_ctrl,
>  		.ctrlbit	= (1 << 0),
> +		.parent		= &exynos4_clk_gate_tv,
>  	}, {
>  		.name		= "adc",
>  		.enable		= exynos4_clk_ip_peril_ctrl,
> @@ -623,11 +672,13 @@ static struct clk exynos4_init_clocks_off[] = {
>  		.name		= "fimg2d",
>  		.enable		= exynos4_clk_ip_image_ctrl,
>  		.ctrlbit	= (1 << 0),
> +		.parent		= &exynos4_clk_gate_lcd0,
>  	}, {
>  		.name		= "mfc",
>  		.devname	= "s5p-mfc",
>  		.enable		= exynos4_clk_ip_mfc_ctrl,
>  		.ctrlbit	= (1 << 0),
> +		.parent		= &exynos4_clk_gate_mfc,
>  	}, {
>  		.name		= "i2c",
>  		.devname	= "s3c2440-i2c.0",
> @@ -795,6 +846,7 @@ static struct clk exynos4_clk_fimd0 = {
>  	.devname	= "exynos4-fb.0",
>  	.enable		= exynos4_clk_ip_lcd0_ctrl,
>  	.ctrlbit	= (1 << 0),
> +	.parent		= &exynos4_clk_gate_lcd0,
>  };
> 
>  struct clk *exynos4_clkset_group_list[] = {
> @@ -1565,6 +1617,8 @@ void __init exynos4_register_clocks(void)
>  	s3c_register_clksrc(exynos4_clksrcs, ARRAY_SIZE(exynos4_clksrcs));
>  	s3c_register_clocks(exynos4_init_clocks_on,
> ARRAY_SIZE(exynos4_init_clocks_on));
> 
> +	s3c24xx_register_clocks(exynos4_gate_clocks,
> ARRAY_SIZE(exynos4_gate_clocks));
> +
>  	s3c24xx_register_clocks(exynos4_clk_cdev,
> ARRAY_SIZE(exynos4_clk_cdev));
>  	for (ptr = 0; ptr < ARRAY_SIZE(exynos4_clk_cdev); ptr++)
>  		s3c_disable_clocks(exynos4_clk_cdev[ptr], 1);
> --
> 1.7.1.569.g6f426

I remember, we talked about the GATE BLOCK for EXYNOS.
So now, there are any reasons it should be implemented?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
