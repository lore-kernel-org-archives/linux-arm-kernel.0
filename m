From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 20 Mar 2014 14:50:13 +0800
Subject: [PATCH 14/62] ARM: imx: imx6q_set_lpm is only defined for
 CONFIG_PM=y
In-Reply-To: <1395257399-359545-15-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-15-git-send-email-arnd@arndb.de>
Message-ID: <20140320065011.GA2408@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 08:29:11PM +0100, Arnd Bergmann wrote:
> This ensures that we only call imx6q_set_lpm if CONFIG_PM
> is enabled and we are building the pm-imx6q.c file.
> 
> Another fix that has been suggested for this is to always
> build this file conditionally build only the parts of it
> that are relevant only to CONFIG_PM.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Shawn Guo <shawn.guo@freescale.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>

I think this should have been fixed by commit 28a9f3b (ARM: imx6: build
pm-imx6q.c independently of CONFIG_PM) on mainline.

Shawn

> ---
>  arch/arm/mach-imx/clk-imx6q.c      | 3 ++-
>  arch/arm/mach-imx/clk-imx6sl.c     | 3 ++-
>  arch/arm/mach-imx/cpuidle-imx6sl.c | 3 +++
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index b0e7f9d..133b23e 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -478,7 +478,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>  		clk_set_parent(clk[lvds1_sel], clk[sata_ref]);
>  
>  	/* Set initial power mode */
> -	imx6q_set_lpm(WAIT_CLOCKED);
> +	if (IS_ENABLED(CONFIG_PM))
> +		imx6q_set_lpm(WAIT_CLOCKED);
>  
>  	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-gpt");
>  	base = of_iomap(np, 0);
> diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/arch/arm/mach-imx/clk-imx6sl.c
> index f7073c0..a882bdf 100644
> --- a/arch/arm/mach-imx/clk-imx6sl.c
> +++ b/arch/arm/mach-imx/clk-imx6sl.c
> @@ -382,7 +382,8 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
>  	clk_set_parent(clks[IMX6SL_CLK_SPDIF0_SEL], clks[IMX6SL_CLK_PLL3_PFD3]);
>  
>  	/* Set initial power mode */
> -	imx6q_set_lpm(WAIT_CLOCKED);
> +	if (IS_ENABLED(CONFIG_PM))
> +		imx6q_set_lpm(WAIT_CLOCKED);
>  
>  	np = of_find_compatible_node(NULL, NULL, "fsl,imx6sl-gpt");
>  	base = of_iomap(np, 0);
> diff --git a/arch/arm/mach-imx/cpuidle-imx6sl.c b/arch/arm/mach-imx/cpuidle-imx6sl.c
> index d4b6b81..c9a6aa8 100644
> --- a/arch/arm/mach-imx/cpuidle-imx6sl.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6sl.c
> @@ -53,5 +53,8 @@ static struct cpuidle_driver imx6sl_cpuidle_driver = {
>  
>  int __init imx6sl_cpuidle_init(void)
>  {
> +	if (!IS_ENABLED(CONFIG_PM))
> +		return -ENOSYS;
> +
>  	return cpuidle_register(&imx6sl_cpuidle_driver, NULL);
>  }
> -- 
> 1.8.3.2
> 
> 
> 
