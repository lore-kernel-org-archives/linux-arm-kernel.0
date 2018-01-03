From: peng.fan@nxp.com (Peng Fan)
Date: Wed, 3 Jan 2018 00:53:30 +0000
Subject: [PATCH V3] ARM: imx: use outer_disable/resume for low power
In-Reply-To: <1514452141-14948-1-git-send-email-peng.fan@nxp.com>
References: <1514452141-14948-1-git-send-email-peng.fan@nxp.com>
Message-ID: <DB6PR04MB3221B5BFB31D39309EF5C7EB881E0@DB6PR04MB3221.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Peng Fan
> Sent: Thursday, December 28, 2017 5:09 PM
> To: shawnguo at kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> van.freenix at gmail.com; Peng Fan <peng.fan@nxp.com>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; A.s.
> Dong <aisheng.dong@nxp.com>; Russell King <linux@armlinux.org.uk>
> Subject: [PATCH V3] ARM: imx: use outer_disable/resume for low power
> 
> Use outer_disable/resume for suspend/resume and low power idle.
> With the two APIs used, code could be easy to extend to introduce
> l2c_write_sec for i.MX platforms when moving Linux Kernel runs in non-secure
> world.
> 
> The cache sync operation and l2c310_early_resume in suspend-imx6.S are kept.
> According to PL310 TRM for dormant mode: "The external power controller
> asserts the reset. Ensure the cache controller is placed back into run mode prior
> to the L1 masters.". So keep l2c310_early_resume.
> 
> Another reason is alought L2 controller lose power, L2 memory not lose power.
> If l2c310_early_resume removed, outer_resume will do invalidation which may
> corrupt data. To keep safe, the cache sync operation is also kept.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> Cc: Russell King <linux@armlinux.org.uk>
> ---
> 
> V3:
>  Continue fix 6SX low power idle. Because L2 memory not lose power,
> outer_disable seems not clearly flush all the data or flush l1 -> flush l2  ->cache
> sync must be followed, outer_resume will invalidate  the cache, which corrupt
> data and cause issues. So in V3, only  add outer_disable/resume to make it
> simple.
>  Add more commit log.
>  Based on Shawn/for-next.
> V2:
>   Fix 6SX booting. The V1 patch does not take 6SX low power idle into
>   consideration.
> 
>  arch/arm/mach-imx/cpuidle-imx6sx.c | 2 ++
>  arch/arm/mach-imx/pm-imx6.c        | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-
> imx/cpuidle-imx6sx.c
> index c5a5c3a70ab1..b35841d133dc 100644
> --- a/arch/arm/mach-imx/cpuidle-imx6sx.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
> @@ -49,7 +49,9 @@ static int imx6sx_enter_wait(struct cpuidle_device *dev,
>  		cpu_pm_enter();
>  		cpu_cluster_pm_enter();
> 

A better solution maybe

if (outer_cache.write_sec)
	outer_disable();

.....

if (outer_cache.write_sec)
	outer_resume();

Then, nothing changed for secure linux. The outer_disable/outer_resume only effects 
When linunx running in non-secure world.

Any comments?

> +		outer_disable();
>  		cpu_suspend(0, imx6sx_idle_finish);
> +		outer_resume();
> 
>  		cpu_cluster_pm_exit();
>  		cpu_pm_exit();
> diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
> index ecdf071653d4..153a0afc7645 100644
> --- a/arch/arm/mach-imx/pm-imx6.c
> +++ b/arch/arm/mach-imx/pm-imx6.c
> @@ -392,8 +392,10 @@ static int imx6q_pm_enter(suspend_state_t state)
>  			imx6_enable_rbc(true);
>  		imx_gpc_pre_suspend(true);
>  		imx_anatop_pre_suspend();
> +		outer_disable();
>  		/* Zzz ... */
>  		cpu_suspend(0, imx6q_suspend_finish);
> +		outer_resume();
>  		if (cpu_is_imx6q() || cpu_is_imx6dl())
>  			imx_smp_prepare();
>  		imx_anatop_post_resume();
> --
> 2.14.1


Thanks,
Peng.
