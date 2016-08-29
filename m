From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Aug 2016 13:44:18 +0800
Subject: [PATCH] ARM: imx6: enable WAIT mode hardware workaround for imx6sx
In-Reply-To: <1471885400-9140-1-git-send-email-Anson.Huang@nxp.com>
References: <1471885400-9140-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20160829054418.GB31367@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 01:03:20AM +0800, Anson Huang wrote:
> Need to enable INT_MEM_CLK_LPM bit in CCM_CGPR for WAIT mode,
> without this bit set, if there is pending interrupt during
> ARM platform entering WAIT mode without power gating, cache
> data will be corrupted, this is a hardware workaround for WAIT
> mode and must be enabled.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/mach-imx/cpuidle-imx6sx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-imx/cpuidle-imx6sx.c
> index 3c6672b..41cdce6 100644
> --- a/arch/arm/mach-imx/cpuidle-imx6sx.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
> @@ -90,6 +90,7 @@ static struct cpuidle_driver imx6sx_cpuidle_driver = {
>  
>  int __init imx6sx_cpuidle_init(void)
>  {
> +	imx6q_set_int_mem_clk_lpm(true);

It might be the time to rename the function to imx6_set_int_mem_clk_lpm()
with a beforehand patch.

Shawn

>  	imx6_enable_rbc(false);
>  	/*
>  	 * set ARM power up/down timing to the fastest,
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
