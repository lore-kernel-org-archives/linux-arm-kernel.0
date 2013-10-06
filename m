From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 6 Oct 2013 17:09:48 +0800
Subject: [PATCH] imx6q: fix emergency restart
In-Reply-To: <1380832337-4637-1-git-send-email-nathan_lynch@mentor.com>
References: <1380832337-4637-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <20131006090946.GN2734@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 03:32:17PM -0500, Nathan Lynch wrote:
> Emergency restart (e.g. sysrq-b) BUGs and panics on i.MX6Q SABRE Lite:

<snip>

> Mapping the watchdog via of_iomap() in imx6q_restart() is okay during
> normal shutdown, but this code runs in interrupt context in response
> to sysrq-b, which triggers the BUG_ON in __get_vm_area_node().

We should try to get mxc_restart() work for imx6q/dl.  I just sent a
patch (you on copy) to do that.

Shawn

> Fix this by mapping the watchdog in imx6q_init_machine() and caching
> the pointer for use by imx6q_restart().
> 
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
> ---
>  arch/arm/mach-imx/mach-imx6q.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 90372a2..e16b723 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -41,6 +41,7 @@
>  #include "hardware.h"
>  
>  static u32 chip_revision;
> +static void __iomem *wdog_base;
>  
>  int imx6q_revision(void)
>  {
> @@ -70,11 +71,6 @@ static void __init imx6q_init_revision(void)
>  
>  static void imx6q_restart(enum reboot_mode mode, const char *cmd)
>  {
> -	struct device_node *np;
> -	void __iomem *wdog_base;
> -
> -	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-wdt");
> -	wdog_base = of_iomap(np, 0);
>  	if (!wdog_base)
>  		goto soft;
>  
> @@ -192,8 +188,15 @@ static void __init imx6q_1588_init(void)
>  
>  static void __init imx6q_init_machine(void)
>  {
> +	struct device_node *np;
> +
>  	imx6q_enet_phy_init();
>  
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-wdt");
> +	if (np)
> +		wdog_base = of_iomap(np, 0);
> +	pr_info("%s: wdog_base = %p\n", __func__, wdog_base);
> +
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  
>  	imx_anatop_init();
> -- 
> 1.8.3.1
> 
