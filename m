From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 10 Dec 2010 14:14:18 +0900
Subject: [PATCH 4/4 v2] ARM: S5PV210: Add clock definition for MIPI-CSIS
	DPHY
In-Reply-To: <1291405965-19482-5-git-send-email-s.nawrocki@samsung.com>
References: <1291405965-19482-1-git-send-email-s.nawrocki@samsung.com>
	<1291405965-19482-5-git-send-email-s.nawrocki@samsung.com>
Message-ID: <028901cb9829$1ad1cfb0$50756f10$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> MIPI DPHY control register requires special handling since it is shared
> between CSI (camera serial interface) and DSI (display serial interface).
> By creating this clock a serialized interface is provided for mipi-csis
> and mipi-dsim drivers, so DPHYs may be safely controlled by both drivers.
> Similarly dsim_dphy clock could be added for mipi-dsim.
> 
> ---
> 
> I am not quite sure about_"dphy_clock", perhaps power domain
> handling code would be better place for it.
> 
Yeah, it is MIPI DPHY enable/disable control register not clock control.
So its proper position is not here...

Hmm...how about driver's probe/open or some kind of setup in machine
directory?

> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv210/clock.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
> index b774ff1..b880b85 100644
> --- a/arch/arm/mach-s5pv210/clock.c
> +++ b/arch/arm/mach-s5pv210/clock.c
> @@ -185,6 +185,19 @@ static int s5pv210_clk_mask1_ctrl(struct clk *clk,
int
> enable)
>  	return s5p_gatectrl(S5P_CLK_SRC_MASK1, clk, enable);
>  }
> 
> +static int s5pv210_clk_mipi_dphy_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_MIPI_DPHY_CONTROL, clk, enable);
> +}
> +
> +/* The common parent clock for mipi-csi/dsi clocks. */
> +static struct clk clk_vp_mipi_dphy = {
> +	.name		= "vpclk_csis_dphy",
> +	.id		= -1,
> +	.enable		= s5pv210_clk_mipi_dphy_ctrl,
> +	.ctrlbit	= (1 << 0),
> +};
> +

Hmm...

>  static struct clk clk_sclk_hdmi27m = {
>  	.name		= "sclk_hdmi27m",
>  	.id		= -1,
> @@ -323,6 +336,18 @@ static struct clk init_clocks_disable[] = {
>  		.enable		= s5pv210_clk_ip0_ctrl,
>  		.ctrlbit	= (1 << 4),
>  	}, {
> +		.name		= "csis",
> +		.id		= -1,
> +		.parent		= &clk_pclk_dsys.clk,
> +		.enable		= s5pv210_clk_ip0_ctrl,
> +		.ctrlbit	= (1 << 31),
> +	}, {

ok.

> +		.name		= "csis_dphy",
> +		.id		= -1,
> +		.parent		= &clk_vp_mipi_dphy,
> +		.enable		= s5pv210_clk_mipi_dphy_ctrl,
> +		.ctrlbit	= (1 << 1),
> +	}, {

Same as above.

>  		.name		= "rot",
>  		.id		= -1,
>  		.parent		= &clk_hclk_dsys.clk,
> --

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
