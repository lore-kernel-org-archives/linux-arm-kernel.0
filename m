From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 23 Aug 2012 12:23:30 +0200
Subject: [PATCH] ARM: imx6q: remove imx_src_prepare_restart() call
In-Reply-To: <1345180316-9209-1-git-send-email-shawn.guo@linaro.org>
References: <1345180316-9209-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <503604A2.3050001@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.08.2012 07:11, Shawn Guo wrote:
> Currently, imx_src_prepare_restart which is called by imx6q_restart
> assumes that cpu0 must be the running cpu, so it disables all secondary
> cpus.  However this is not the case, the restart routine could possibly
> running on cpu1 or any other secondary cores.  In that case, disabling
> the cpu that runs restart routine will hang up system.
> 
> Also it turns out that everything that is done by imx_src_prepare_restart
> is not really necessary, because the watchdog reset will have those
> registers reset properly.  So let's remove the imx_src_prepare_restart
> call completely.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Tested on a i.MX6 SabreLite board together with the patch 'ARM: fix 
cpu_relax() in case of doing dmb':

Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Thanks

Dirk

> ---
>  arch/arm/mach-imx/mach-imx6q.c          |    2 --
>  arch/arm/mach-imx/src.c                 |   13 -------------
>  arch/arm/plat-mxc/include/mach/common.h |    1 -
>  3 files changed, 0 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 5ec0608..d9b0614 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -48,8 +48,6 @@ void imx6q_restart(char mode, const char *cmd)
>  	if (!wdog_base)
>  		goto soft;
>  
> -	imx_src_prepare_restart();
> -
>  	/* enable wdog */
>  	writew_relaxed(1 << 2, wdog_base);
>  	/* write twice to ensure the request will not get ignored */
> diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
> index e15f155..900b3c1 100644
> --- a/arch/arm/mach-imx/src.c
> +++ b/arch/arm/mach-imx/src.c
> @@ -43,19 +43,6 @@ void imx_set_cpu_jump(int cpu, void *jump_addr)
>  		       src_base + SRC_GPR1 + cpu * 8);
>  }
>  
> -void imx_src_prepare_restart(void)
> -{
> -	u32 val;
> -
> -	/* clear enable bits of secondary cores */
> -	val = readl_relaxed(src_base + SRC_SCR);
> -	val &= ~(0x7 << BP_SRC_SCR_CORE1_ENABLE);
> -	writel_relaxed(val, src_base + SRC_SCR);
> -
> -	/* clear persistent entry register of primary core */
> -	writel_relaxed(0, src_base + SRC_GPR1);
> -}
> -
>  void __init imx_src_init(void)
>  {
>  	struct device_node *np;
> diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
> index 7128e97..e94073f 100644
> --- a/arch/arm/plat-mxc/include/mach/common.h
> +++ b/arch/arm/plat-mxc/include/mach/common.h
> @@ -133,7 +133,6 @@ static inline void imx_smp_prepare(void) {}
>  extern void imx_enable_cpu(int cpu, bool enable);
>  extern void imx_set_cpu_jump(int cpu, void *jump_addr);
>  extern void imx_src_init(void);
> -extern void imx_src_prepare_restart(void);
>  extern void imx_gpc_init(void);
>  extern void imx_gpc_pre_suspend(void);
>  extern void imx_gpc_post_resume(void);
