From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 21 Jun 2014 17:33:26 +0800
Subject: [PATCH] ARM: imx: add cpuidle support for i.mx6sx
In-Reply-To: <1403243045-8521-1-git-send-email-b20788@freescale.com>
References: <1403243045-8521-1-git-send-email-b20788@freescale.com>
Message-ID: <20140621093325.GE18165@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 01:44:05PM +0800, Anson Huang wrote:
> Add cpuidle support for i.MX6SX, derive from i.MX6Q's
> cpuidle, two levels supported:
> 
> 1. WFI;
> 2. WAIT mode.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  arch/arm/mach-imx/cpuidle-imx6q.c |    4 +++-
>  arch/arm/mach-imx/mach-imx6sx.c   |    7 +++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
> index 6bcae04..fc0bb1e 100644
> --- a/arch/arm/mach-imx/cpuidle-imx6q.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6q.c
> @@ -13,6 +13,7 @@
>  
>  #include "common.h"
>  #include "cpuidle.h"
> +#include "hardware.h"
>  
>  static atomic_t master = ATOMIC_INIT(0);
>  static DEFINE_SPINLOCK(master_lock);
> @@ -66,7 +67,8 @@ static struct cpuidle_driver imx6q_cpuidle_driver = {
>  int __init imx6q_cpuidle_init(void)
>  {
>  	/* Need to enable SCU standby for entering WAIT modes */
> -	imx_scu_standby_enable();
> +	if (!cpu_is_imx6sx())
> +		imx_scu_standby_enable();

Hmm, why is SoloX special in this regarding?  Does SoloLite work well
without this change?

Shawn

>  
>  	/* Set INT_MEM_CLK_LPM bit to get a reliable WAIT mode support */
>  	imx6q_set_int_mem_clk_lpm();
> diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
> index b7a0bde..74ff7d6 100644
> --- a/arch/arm/mach-imx/mach-imx6sx.c
> +++ b/arch/arm/mach-imx/mach-imx6sx.c
> @@ -12,6 +12,7 @@
>  #include <asm/mach/map.h>
>  
>  #include "common.h"
> +#include "cpuidle.h"
>  
>  static void __init imx6sx_init_machine(void)
>  {
> @@ -38,6 +39,11 @@ static void __init imx6sx_init_irq(void)
>  	irqchip_init();
>  }
>  
> +static void __init imx6sx_init_late(void)
> +{
> +	imx6q_cpuidle_init();
> +}
> +
>  static const char *imx6sx_dt_compat[] __initconst = {
>  	"fsl,imx6sx",
>  	NULL,
> @@ -48,5 +54,6 @@ DT_MACHINE_START(IMX6SX, "Freescale i.MX6 SoloX (Device Tree)")
>  	.init_irq	= imx6sx_init_irq,
>  	.init_machine	= imx6sx_init_machine,
>  	.dt_compat	= imx6sx_dt_compat,
> +	.init_late	= imx6sx_init_late,
>  	.restart	= mxc_restart,
>  MACHINE_END
> -- 
> 1.7.9.5
> 
