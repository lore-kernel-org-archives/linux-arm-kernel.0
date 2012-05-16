From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 16 May 2012 19:47:40 +0200
Subject: [PATCH v4 4/7] ARM: imx: Enable imx53 low power idle
In-Reply-To: <1337135616-8988-5-git-send-email-rob.lee@linaro.org>
References: <1337135616-8988-1-git-send-email-rob.lee@linaro.org>
 <1337135616-8988-5-git-send-email-rob.lee@linaro.org>
Message-ID: <20120516174740.GW30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 09:33:33PM -0500, Robert Lee wrote:
> Add various functionality needed to enable a imx53 low power idle
> state.  This includes adding the imx53 gpc_dvfs clock and making a
> common imx5_late_init function and initializing all imx53
>  MACHINE_STATE late_init calls to imx5_late_init.
> 
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> ---
>  arch/arm/mach-imx/clock-mx51-mx53.c     |    1 +
>  arch/arm/mach-imx/imx53-dt.c            |    1 +
>  arch/arm/mach-imx/mach-mx53_ard.c       |    1 +
>  arch/arm/mach-imx/mach-mx53_evk.c       |    1 +
>  arch/arm/mach-imx/mach-mx53_loco.c      |    1 +
>  arch/arm/mach-imx/mach-mx53_smd.c       |    1 +
>  arch/arm/mach-imx/mm-imx5.c             |    7 ++++++-
>  arch/arm/plat-mxc/include/mach/common.h |    1 +
>  8 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/clock-mx51-mx53.c b/arch/arm/mach-imx/clock-mx51-mx53.c
> index 0847050..decedc6 100644
> --- a/arch/arm/mach-imx/clock-mx51-mx53.c
> +++ b/arch/arm/mach-imx/clock-mx51-mx53.c
> @@ -1529,6 +1529,7 @@ static struct clk_lookup mx53_lookups[] = {
>  	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
>  	_REGISTER_CLOCK("imx-ssi.2", NULL, ssi3_clk)
>  	_REGISTER_CLOCK("imx-keypad", NULL, dummy_clk)
> +	_REGISTER_CLOCK(NULL, "gpc_dvfs", gpc_dvfs_clk)

This has to be rebased against the common clock patches.

>  	.timer = &mx53_smd_timer,
>  	.init_machine = mx53_smd_board_init,
> +	.init_late	= imx5_init_late,
>  	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
> index bb38747..7740739 100644
> --- a/arch/arm/mach-imx/mm-imx5.c
> +++ b/arch/arm/mach-imx/mm-imx5.c
> @@ -216,8 +216,13 @@ void __init imx53_soc_init(void)
>  					ARRAY_SIZE(imx53_audmux_res));
>  }
>  
> +void __init imx5_init_late(void)
> +{
> +	imx5_pm_init();
> +}
> +
>  void __init imx51_init_late(void)
>  {
>  	mx51_neon_fixup();
> -	imx5_pm_init();
> +	imx5_init_late();
>  }

Where would you add i.MX53 specific code above? Hint: imx5_init_late is
the wrong function name.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
