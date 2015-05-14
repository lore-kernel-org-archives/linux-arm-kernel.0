From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 14 May 2015 16:02:15 +0800
Subject: [PATCH 01/18] ARM: imx: Add a parameter to mxc_timer_init
In-Reply-To: <1430405073-13106-2-git-send-email-shenwei.wang@freescale.com>
References: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
 <1430405073-13106-2-git-send-email-shenwei.wang@freescale.com>
Message-ID: <20150514080213.GC6850@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 09:44:16AM -0500, Shenwei Wang wrote:
> A parameter of integer type is added to the function mxc_timer_init,
> so that a user could have a way to tell the timer driver the version
> of the timer IP block.
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
> ---
>  arch/arm/mach-imx/time.c    | 2 +-
>  drivers/clk/imx/clk-imx1.c  | 3 ++-
>  drivers/clk/imx/clk-imx21.c | 3 ++-
>  drivers/clk/imx/clk-imx27.c | 3 ++-
>  drivers/clk/imx/clk-imx31.c | 3 ++-
>  drivers/clk/imx/clk-imx35.c | 5 +++--
>  drivers/clk/imx/clk.h       | 2 +-
>  7 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
> index b1698e1..eef6b66 100644
> --- a/arch/arm/mach-imx/time.c
> +++ b/arch/arm/mach-imx/time.c
> @@ -346,7 +346,7 @@ static void __init _mxc_timer_init(int irq,
>  	setup_irq(irq, &mxc_timer_irq);
>  }
>  
> -void __init mxc_timer_init(unsigned long pbase, int irq)
> +void __init mxc_timer_init(unsigned long pbase, int irq, int ver)

I prefer to have an enum type for it.

enum gpt_device_type {
	GPT_TYPE_IMX1,		/* MX1/MXL */
	GPT_TYPE_IMX21,		/* MX21, MX27 */
	GPT_TYPE_IMX31,		/* MX25, MX31, MX35, MX37, MX51, MX6Q(Rev1.0) */
	GPT_TYPE_IMX6DL,	/* MX6DL, MX6SX, MX6Q(Rev1.1+) */
};

>  {
>  	struct clk *clk_per = clk_get_sys("imx-gpt.0", "per");
>  	struct clk *clk_ipg = clk_get_sys("imx-gpt.0", "ipg");
> diff --git a/drivers/clk/imx/clk-imx1.c b/drivers/clk/imx/clk-imx1.c
> index c9812db..49534d8 100644
> --- a/drivers/clk/imx/clk-imx1.c
> +++ b/drivers/clk/imx/clk-imx1.c
> @@ -102,7 +102,8 @@ int __init mx1_clocks_init(unsigned long fref)
>  	clk_register_clkdev(clk[IMX1_CLK_DUMMY], "ipg", "imx1-fb.0");
>  	clk_register_clkdev(clk[IMX1_CLK_DUMMY], "ahb", "imx1-fb.0");
>  
> -	mxc_timer_init(MX1_TIM1_BASE_ADDR, MX1_TIM1_INT);
> +	/*Timer version in MX1 is V0*/

There should be a space before and after '*'.

> +	mxc_timer_init(MX1_TIM1_BASE_ADDR, MX1_TIM1_INT, 0);
>  
>  	return 0;
>  }
> diff --git a/drivers/clk/imx/clk-imx21.c b/drivers/clk/imx/clk-imx21.c
> index 0ca842c..08aa048 100644
> --- a/drivers/clk/imx/clk-imx21.c
> +++ b/drivers/clk/imx/clk-imx21.c
> @@ -156,7 +156,8 @@ int __init mx21_clocks_init(unsigned long lref, unsigned long href)
>  	clk_register_clkdev(clk[IMX21_CLK_I2C_GATE], NULL, "imx21-i2c.0");
>  	clk_register_clkdev(clk[IMX21_CLK_OWIRE_GATE], NULL, "mxc_w1.0");
>  
> -	mxc_timer_init(MX21_GPT1_BASE_ADDR, MX21_INT_GPT1);
> +	/*Timer version in MX21 is v1*/
> +	mxc_timer_init(MX21_GPT1_BASE_ADDR, MX21_INT_GPT1, 1);
>  
>  	return 0;
>  }
> diff --git a/drivers/clk/imx/clk-imx27.c b/drivers/clk/imx/clk-imx27.c
> index df2dfc0..f00a7c0 100644
> --- a/drivers/clk/imx/clk-imx27.c
> +++ b/drivers/clk/imx/clk-imx27.c
> @@ -233,7 +233,8 @@ int __init mx27_clocks_init(unsigned long fref)
>  	clk_register_clkdev(clk[IMX27_CLK_EMMA_AHB_GATE], "ahb", "m2m-emmaprp.0");
>  	clk_register_clkdev(clk[IMX27_CLK_EMMA_IPG_GATE], "ipg", "m2m-emmaprp.0");
>  
> -	mxc_timer_init(MX27_GPT1_BASE_ADDR, MX27_INT_GPT1);
> +	/*Timer version in MX27 is v1*/
> +	mxc_timer_init(MX27_GPT1_BASE_ADDR, MX27_INT_GPT1, 1);
>  
>  	return 0;
>  }
> diff --git a/drivers/clk/imx/clk-imx31.c b/drivers/clk/imx/clk-imx31.c
> index a55290c..7c4a025 100644
> --- a/drivers/clk/imx/clk-imx31.c
> +++ b/drivers/clk/imx/clk-imx31.c
> @@ -198,7 +198,8 @@ int __init mx31_clocks_init(unsigned long fref)
>  	mx31_revision();
>  	clk_disable_unprepare(clk[iim_gate]);
>  
> -	mxc_timer_init(MX31_GPT1_BASE_ADDR, MX31_INT_GPT);
> +	/*Timer version in MX31 is v2*/
> +	mxc_timer_init(MX31_GPT1_BASE_ADDR, MX31_INT_GPT, 2);
>  
>  	return 0;
>  }
> diff --git a/drivers/clk/imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
> index 133fda1..a796c1e 100644
> --- a/drivers/clk/imx/clk-imx35.c
> +++ b/drivers/clk/imx/clk-imx35.c
> @@ -145,7 +145,7 @@ int __init mx35_clocks_init(void)
>  	clk[esdhc3_div] = imx_clk_divider("esdhc3_div", "esdhc_sel", base + MX35_CCM_PDR3, 16, 6);
>  
>  	clk[spdif_sel] = imx_clk_mux("spdif_sel", base + MX35_CCM_PDR3, 22, 1, std_sel, ARRAY_SIZE(std_sel));
> -	clk[spdif_div_pre] = imx_clk_divider("spdif_div_pre", "spdif_sel", base + MX35_CCM_PDR3, 29, 3); /* divide by 1 not allowed */ 
> +	clk[spdif_div_pre] = imx_clk_divider("spdif_div_pre", "spdif_sel", base + MX35_CCM_PDR3, 29, 3); /* divide by 1 not allowed */

Unrelated change?

Shawn

>  	clk[spdif_div_post] = imx_clk_divider("spdif_div_post", "spdif_div_pre", base + MX35_CCM_PDR3, 23, 6);
>  
>  	clk[ssi_sel] = imx_clk_mux("ssi_sel", base + MX35_CCM_PDR2, 6, 1, std_sel, ARRAY_SIZE(std_sel));
> @@ -296,7 +296,8 @@ int __init mx35_clocks_init(void)
>  #ifdef CONFIG_MXC_USE_EPIT
>  	epit_timer_init(MX35_IO_ADDRESS(MX35_EPIT1_BASE_ADDR), MX35_INT_EPIT1);
>  #else
> -	mxc_timer_init(MX35_GPT1_BASE_ADDR, MX35_INT_GPT);
> +	/*Timer version in MX35 is v2*/
> +	mxc_timer_init(MX35_GPT1_BASE_ADDR, MX35_INT_GPT, 2);
>  #endif
>  
>  	return 0;
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index 6bae537..06da84a 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -11,7 +11,7 @@ extern spinlock_t imx_ccm_lock;
>   * mxc_timer_init() to initialize timer for non-DT boot.  It can be removed
>   * when these legacy non-DT support is converted or dropped.
>   */
> -void mxc_timer_init(unsigned long pbase, int irq);
> +void mxc_timer_init(unsigned long pbase, int irq, int);
>  
>  void imx_check_clocks(struct clk *clks[], unsigned int count);
>  
> -- 
> 1.9.1
> 
> 
