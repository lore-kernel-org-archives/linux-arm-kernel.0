From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 May 2015 15:34:10 +0800
Subject: [PATCH] ARM: imx6: allow booting with old DT
In-Reply-To: <1432658616-13733-1-git-send-email-l.stach@pengutronix.de>
References: <1432658616-13733-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <20150527073408.GD16165@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 06:43:36PM +0200, Lucas Stach wrote:
> The GPC rewrite to IRQ domains has been on the premise that it may break
> suspend/resume for new kernels on old DT, but otherwise keep things working
> from a user perspective. This was an accepted compromise to be able to move
> the GIC cleanup forward.
> 
> What actually happened was that booting a new kernel on an old DT crashes
> before even the console is up, so the user does not even see the warning
> that the DT is too old. The warning message suggests that this has been
> known before, which is clearly unacceptable.

To see any early message like this one, low-level debug support is
expected to be turned on.

But anyway, with your change, we get a much better situation.  Will send
it to arm-soc soon.  Thanks for the patch.

Shawn

> 
> Fix the early crash by mapping the GPC memory space if the IRQ controller
> doesn't claim it. This keeps at least CPUidle and the needed CPU wakeup
> workarounds working. With this fixed the system is able to boot up
> properly minus the expected suspend/resume breakage.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> Shawn, this is a critical fix for 4.1, to keep the combination of old
> DT + new kernel at least somewhat working, to allow users to resolve
> the situation on their systems. Please make sure this gets forwarded
> ASAP.
> ---
>  arch/arm/mach-imx/gpc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
> index 4d60005e9277..bbf015056221 100644
> --- a/arch/arm/mach-imx/gpc.c
> +++ b/arch/arm/mach-imx/gpc.c
> @@ -280,9 +280,15 @@ void __init imx_gpc_check_dt(void)
>  	struct device_node *np;
>  
>  	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-gpc");
> -	if (WARN_ON(!np ||
> -		    !of_find_property(np, "interrupt-controller", NULL)))
> -		pr_warn("Outdated DT detected, system is about to crash!!!\n");
> +	if (WARN_ON(!np))
> +		return;
> +
> +	if (WARN_ON(!of_find_property(np, "interrupt-controller", NULL))) {
> +		pr_warn("Outdated DT detected, suspend/resume will NOT work\n");
> +
> +		/* map GPC, so that at least CPUidle and WARs keep working */
> +		gpc_base = of_iomap(np, 0);
> +	}
>  }
>  
>  #ifdef CONFIG_PM_GENERIC_DOMAINS
> -- 
> 2.1.4
> 
