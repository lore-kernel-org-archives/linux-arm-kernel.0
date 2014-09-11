From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 11 Sep 2014 16:29:06 +0800
Subject: [PATCH v1] ARM: imx6: add pm_power_off support for i.mx6 chips
In-Reply-To: <1410417667-6436-1-git-send-email-b38343@freescale.com>
References: <1410417667-6436-1-git-send-email-b38343@freescale.com>
Message-ID: <20140911082905.GI18566@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 02:41:07PM +0800, Robin Gong wrote:
> All chips of i.mx6 can be powered off by programming SNVS.
> For example :
> On i.mx6q-sabresd board, PMIC_ON_REQ connect with external
> pmic ON/OFF pin, that will cause the whole PMIC powered off
> except VSNVS. And system can restart once PMIC_ON_REQ goes
> high by push POWRER key.
> 
> Signed-off-by: Robin Gong <b38343@freescale.com>
> ---
>  arch/arm/mach-imx/common.h      |  1 +
>  arch/arm/mach-imx/mach-imx6q.c  |  2 ++
>  arch/arm/mach-imx/mach-imx6sl.c |  2 ++
>  arch/arm/mach-imx/mach-imx6sx.c |  2 ++
>  arch/arm/mach-imx/system.c      | 22 +++++++++++++++++++++-
>  5 files changed, 28 insertions(+), 1 deletion(-)

I think we'd better add a little poweroff driver under
drivers/power/reset/ rather than having it in platform code.

Shawn

> 
> diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
> index 1dabf43..baca11a 100644
> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -62,6 +62,7 @@ void mxc_set_cpu_type(unsigned int type);
>  void mxc_restart(enum reboot_mode, const char *);
>  void mxc_arch_reset_init(void __iomem *);
>  void mxc_arch_reset_init_dt(void);
> +void mxc_power_off_init(void);
>  int mx51_revision(void);
>  int mx53_revision(void);
>  void imx_set_aips(void __iomem *);
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index d51c6e9..3d6610d 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -270,6 +270,8 @@ static void __init imx6q_init_machine(void)
>  
>  	mxc_arch_reset_init_dt();
>  
> +	mxc_power_off_init();
> +
>  	parent = imx_soc_device_init();
>  	if (parent == NULL)
>  		pr_warn("failed to initialize soc device\n");
> diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
> index ed263a2..c07e6e8 100644
> --- a/arch/arm/mach-imx/mach-imx6sl.c
> +++ b/arch/arm/mach-imx/mach-imx6sl.c
> @@ -50,6 +50,8 @@ static void __init imx6sl_init_machine(void)
>  
>  	mxc_arch_reset_init_dt();
>  
> +	mxc_power_off_init();
> +
>  	parent = imx_soc_device_init();
>  	if (parent == NULL)
>  		pr_warn("failed to initialize soc device\n");
> diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
> index 3de3b73..68ea070 100644
> --- a/arch/arm/mach-imx/mach-imx6sx.c
> +++ b/arch/arm/mach-imx/mach-imx6sx.c
> @@ -20,6 +20,8 @@ static void __init imx6sx_init_machine(void)
>  
>  	mxc_arch_reset_init_dt();
>  
> +	mxc_power_off_init();
> +
>  	parent = imx_soc_device_init();
>  	if (parent == NULL)
>  		pr_warn("failed to initialize soc device\n");
> diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
> index d14c33f..925fb29 100644
> --- a/arch/arm/mach-imx/system.c
> +++ b/arch/arm/mach-imx/system.c
> @@ -23,6 +23,7 @@
>  #include <linux/delay.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/pm.h>
>  
>  #include <asm/system_misc.h>
>  #include <asm/proc-fns.h>
> @@ -32,7 +33,9 @@
>  #include "common.h"
>  #include "hardware.h"
>  
> -static void __iomem *wdog_base;
> +#define SNVS_LPCR               0x04
> +
> +static void __iomem *wdog_base, *snvs_base;
>  static struct clk *wdog_clk;
>  
>  /*
> @@ -104,6 +107,23 @@ void __init mxc_arch_reset_init_dt(void)
>  		clk_prepare(wdog_clk);
>  }
>  
> +static void power_off_snvs(void)
> +{
> +	 u32 value = readl(snvs_base + SNVS_LPCR);
> +	/* set TOP and DP_EN bit */
> +	writel(value | 0x60, snvs_base + SNVS_LPCR);
> +}
> +
> +void __init mxc_power_off_init(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,sec-v4.0-mon-rtc-lp");
> +	snvs_base = of_iomap(np, 0);
> +	WARN_ON(!snvs_base);
> +	pm_power_off = power_off_snvs;
> +}
> +
>  #ifdef CONFIG_CACHE_L2X0
>  void __init imx_init_l2cache(void)
>  {
> -- 
> 1.9.1
> 
