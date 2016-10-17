From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 17 Oct 2016 17:23:32 +0200
Subject: [PATCH] ARM: imx: gpc: Initialize all power domains
In-Reply-To: <1476208413-11286-1-git-send-email-fabio.estevam@nxp.com>
References: <1476208413-11286-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1476717812.2259.16.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 11.10.2016, 14:53 -0300 schrieb Fabio Estevam:
> When booting a kernel built with multi_v7_defconfig the following
> probe error is seen:
> 
> imx-gpc: probe of 20dc000.gpc failed with error -22
> 
> Later on the kernel crashes like this:
> 
> [    1.723358] Unable to handle kernel NULL pointer dereference at virtual address 00000040
> [    1.731500] pgd = c0204000
> [    1.731863] hctosys: unable to open rtc device (rtc0)
> [    1.739301] [00000040] *pgd=00000000
> [    1.739310] Internal error: Oops: 5 [#1] SMP ARM
> [    1.739319] Modules linked in:
> [    1.739328] CPU: 1 PID: 95 Comm: kworker/1:4 Not tainted 4.8.0-11897-g6b5e09a #1
> [    1.739331] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    1.739352] Workqueue: pm genpd_power_off_work_fn
> [    1.739356] task: ee63d400 task.stack: ee70a000
> [    1.739365] PC is at mutex_lock+0xc/0x4c
> [    1.739374] LR is at regulator_disable+0x2c/0x60
> [    1.739379] pc : [<c0bc0da0>]    lr : [<c06e4b10>]    psr: 60000013
> [    1.739379] sp : ee70beb0  ip : 10624dd3  fp : ee6e6280
> [    1.739382] r10: eefb0900  r9 : 00000000  r8 : c1309918
> [    1.739385] r7 : 00000000  r6 : 00000040  r5 : 00000000  r4 : 00000040
> [    1.739390] r3 : 0000004c  r2 : 7fffd540  r1 : 000001e4  r0 : 00000040
> 
> The gpc probe fails because of_genpd_add_provider_onecell() checks
> if all the domains are initialized via pm_genpd_present() function
> and it returns an error on the multi_v7_defconfig case.
> 
> In order to fix this error, initialize all the imx_gpc_domains, not
> only the imx6q_pu_domain.base one.
> 
> Reported-by: Olof's autobooter <build@lixom.net>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  arch/arm/mach-imx/gpc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
> index 0df062d..d0463e9 100644
> --- a/arch/arm/mach-imx/gpc.c
> +++ b/arch/arm/mach-imx/gpc.c
> @@ -430,7 +430,8 @@ static int imx_gpc_genpd_init(struct device *dev, struct regulator *pu_reg)
>  	if (!IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS))
>  		return 0;
>  
> -	pm_genpd_init(&imx6q_pu_domain.base, NULL, false);
> +	for (i = 0; i < ARRAY_SIZE(imx_gpc_domains); i++)
> +		pm_genpd_init(imx_gpc_domains[i], NULL, false);
>  	return of_genpd_add_provider_onecell(dev->of_node,
>  					     &imx_gpc_onecell_data);
>  
