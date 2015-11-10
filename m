From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 10 Nov 2015 11:56:53 +0100
Subject: [PATCH] clk: rockchip: switch PLLs to slow mode before reboot for
 rk3288
In-Reply-To: <1447148131-30041-1-git-send-email-zyw@rock-chips.com>
References: <1447148131-30041-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1571498.9yAnv9q8Vm@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

Am Dienstag, 10. November 2015, 17:35:31 schrieb Chris Zhong:
> We've been seeing some crashes at reboot test on rk3288-based systems,
> which boards have not reset pin connected to NPOR, they reboot by
> setting 0xfdb9 to RK3288_GLB_SRST_FST register. If the APLL works in
> a high frequency mode, some IPs might hang during soft reset.
> It appears that we can fix the problem by switching to slow mode before
> reboot, just like what we did before suspend.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> 
> ---
> 
>  drivers/clk/rockchip/clk-rk3288.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-
rk3288.c
> index 9040878..524662c 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -16,6 +16,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/reboot.h>
>  #include <linux/syscore_ops.h>
>  #include <dt-bindings/clock/rk3288-cru.h>
>  #include "clk.h"
> @@ -855,6 +856,34 @@ static void rk3288_clk_sleep_init(void __iomem 
*reg_base)
>  static void rk3288_clk_sleep_init(void __iomem *reg_base) {}
>  #endif
>  
> +void __iomem *mode_con_reg;
> +static int rk3288_restart_notify(struct notifier_block *this,
> +				   unsigned long mode, void *cmd)
> +{
> +	writel(0xf3030000, mode_con_reg);
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block rk3288_restart_handler = {
> +	.notifier_call = rk3288_restart_notify,
> +	/* Switch PLLs other than DPLL (for SDRAM) to slow mode before reboot
> +	 * to avoid crashes in reset, so this priority must bigger than the one
> +	 * in rockchip_restart_handler.
> +	 */
> +	.priority = 129,
> +};
> +
> +void __init rk3288_register_restart_notifier(void __iomem *reg)
> +{
> +	int ret;
> +
> +	mode_con_reg = reg;
> +	ret = register_restart_handler(&rk3288_restart_handler);
> +	if (ret)
> +		pr_err("%s: cannot register restart handler, %d\n",
> +		       __func__, ret);
> +}
> +

restart_handlers are really _only_ supposed to be used for actions actually 
restarting the system, not stuff that needs to be done before.

In the rockchip clock case, we already have the syscore_ops defined doing the 
suspend/resume handling, so you could simply define a .shutdown callback which 
also gets called from kernel_restart() [0], so runs at nearly the same time.

Heiko

[0] http://lxr.free-electrons.com/source/kernel/reboot.c#L214
