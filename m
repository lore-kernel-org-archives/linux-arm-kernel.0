From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 19 Sep 2014 20:07:50 -0700
Subject: [PATCH 2/2] watchdog: dw_wdt: add restart handler support
In-Reply-To: <1411108199-1280-3-git-send-email-jszhang@marvell.com>
References: <1411108199-1280-1-git-send-email-jszhang@marvell.com>
 <1411108199-1280-3-git-send-email-jszhang@marvell.com>
Message-ID: <541CEF86.9070606@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2014 11:29 PM, Jisheng Zhang wrote:
> The kernel core now provides an API to trigger a system restart.
> Register with it to support restarting the system via. watchdog.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>   drivers/watchdog/dw_wdt.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index ad0619d..4ca41e9 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -29,9 +29,11 @@
>   #include <linux/miscdevice.h>
>   #include <linux/module.h>
>   #include <linux/moduleparam.h>
> +#include <linux/notifier.h>
>   #include <linux/of.h>
>   #include <linux/pm.h>
>   #include <linux/platform_device.h>
> +#include <linux/reboot.h>
>   #include <linux/spinlock.h>
>   #include <linux/timer.h>
>   #include <linux/uaccess.h>
> @@ -62,6 +64,7 @@ static struct {
>   	unsigned long		next_heartbeat;
>   	struct timer_list	timer;
>   	int			expect_close;
> +	struct notifier_block	restart_handler;
>   } dw_wdt;
>
>   static inline int dw_wdt_is_enabled(void)
> @@ -119,6 +122,22 @@ static void dw_wdt_keepalive(void)
>   	       WDOG_COUNTER_RESTART_REG_OFFSET);
>   }
>
> +static int dw_wdt_restart_handle(struct notifier_block *this,
> +				unsigned long mode, void *cmd)
> +{
> +	u32 val;
> +
> +	writel(0, dw_wdt.regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
> +	val = readl(dw_wdt.regs + WDOG_CONTROL_REG_OFFSET);
> +	if (val & WDOG_CONTROL_REG_WDT_EN_MASK)
> +		writel(WDOG_COUNTER_RESTART_KICK_VALUE, dw_wdt.regs +
> +			WDOG_COUNTER_RESTART_REG_OFFSET);
> +	else
> +		writel(WDOG_CONTROL_REG_WDT_EN_MASK,
> +		       dw_wdt.regs + WDOG_CONTROL_REG_OFFSET);

Don't you have to write WDOG_COUNTER_RESTART_KICK_VALUE into
WDOG_COUNTER_RESTART_REG_OFFSET in the else case as well ?

Guenter
