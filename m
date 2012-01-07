From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 7 Jan 2012 12:44:42 +0800
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
In-Reply-To: <20120106120345.8157a839b1c924315d728eea@canb.auug.org.au>
References: <20120106120345.8157a839b1c924315d728eea@canb.auug.org.au>
Message-ID: <20120107044439.GE4790@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Fri, Jan 06, 2012 at 12:03:45PM +1100, Stephen Rothwell wrote:
> diff --cc arch/arm/mach-imx/mm-imx5.c
> index 65139a6,bc17dfe..0000000
> --- a/arch/arm/mach-imx/mm-imx5.c
> +++ b/arch/arm/mach-imx/mm-imx5.c
> @@@ -21,9 -22,27 +22,24 @@@
>   #include <mach/devices-common.h>
>   #include <mach/iomux-v3.h>
>   
> + static struct clk *gpc_dvfs_clk;
> + 
>   static void imx5_idle(void)
>   {
>  -	if (!need_resched()) {
>  -		/* gpc clock is needed for SRPG */
>  -		if (gpc_dvfs_clk == NULL) {
>  -			gpc_dvfs_clk = clk_get(NULL, "gpc_dvfs");
>  -			if (IS_ERR(gpc_dvfs_clk))
>  -				goto err0;
>  -		}
>  -		clk_enable(gpc_dvfs_clk);
>  -		mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
>  -		if (tzic_enable_wake())
>  -			goto err1;
>  -		cpu_do_idle();
>  -err1:
>  -		clk_disable(gpc_dvfs_clk);
> ++	/* gpc clock is needed for SRPG */
> ++	if (gpc_dvfs_clk == NULL) {
> ++		gpc_dvfs_clk = clk_get(NULL, "gpc_dvfs");
> ++		if (IS_ERR(gpc_dvfs_clk))
> ++			goto err0;
> + 	}
> ++	clk_enable(gpc_dvfs_clk);
>  +	mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
> ++	if (tzic_enable_wake())
> ++		goto err1;
> ++	cpu_do_idle();
> ++err1:
> ++	clk_disable(gpc_dvfs_clk);
> + err0:
>  -	local_irq_enable();

This results in a compile error.

  CC      arch/arm/mach-imx/mm-imx5.o
arch/arm/mach-imx/mm-imx5.c: In function ?imx5_idle?:
arch/arm/mach-imx/mm-imx5.c:42:1: error: label at end of compound statement

Regards,
Shawn

>   }
>   
>   /*
